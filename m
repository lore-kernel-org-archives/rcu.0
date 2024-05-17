Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5F12D778;
	Fri, 17 May 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959391; cv=none; b=LYbUUqsmEvOMBUyRh9nJs8u6BBOTeRKAirBq5Git4MSd3Z3+Pw/l2ysjzr2SbLZzMxiduWMC2VeJFElJmiSMoOX1634by7Mkj7iR3XCSL3O99SwPKlYrpEt0iUfWRAVinnrz5IlPZJQS7+7FVJJLsgxvgVswqau+IoRaScGHTjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959391; c=relaxed/simple;
	bh=K4F4gN1sYw1jz4DDlrCYUcK3s5IwxW3rvJ52l6UkSK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EI3w9yz+gAPy0L+ArzxHmWKWcAWjY/ZWGTTyxTMKmPbpegCwsnis6YhF63pvzva1OgqUQYTcMhKpEyph8pNPFa1VIZZRugFpVbSbQLZvtiCO8HD2VtTwhvUxPyvZ3TuRvVQITc5LvQtbntAEf7NFSm8bqnfQ5gThQLulPAvwM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+qxUXYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+qxUXYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE70C32781;
	Fri, 17 May 2024 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715959391;
	bh=K4F4gN1sYw1jz4DDlrCYUcK3s5IwxW3rvJ52l6UkSK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+qxUXYPILunjwCMmvUu7ACUmGOp2FJQ+L/MUiQccMSFTREWFBCVepZv+FkD2L3jn
	 SeSm1chef7qZSb+Oy/gcc3yy8FjcC9SR6OPEAFu0zHKicHVMeCBzgfX1A8IOCZKbsJ
	 Og0K9TxdyAT8CaMdR9BdCxu2s1yE/iTuVInkTBv7qPw063cqfgeGC3wAbE2zCAx20e
	 fK5WGKP3PMHES7BkZvQJQ/UAqhEaT92ch6aLe2bItn5BsIM7lsMCGaIDU02T3nQnut
	 We9U3pSz8QLHOkqdLTWskg79dLaa6OVt9EY52TEdzAUnVtleko67QqAjkts1U1uKWx
	 2hoYGUZd+I+pw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] rcu/tasks: Fix stale task snaphot from TASK-TRACE
Date: Fri, 17 May 2024 17:23:02 +0200
Message-ID: <20240517152303.19689-2-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240517152303.19689-1-frederic@kernel.org>
References: <20240517152303.19689-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RCU-TASKS-TRACE pre-gp takes a snapshot of the current task running
on all online CPUs, no explicit ordering enforces a missed context
switched task to see the pre-GP update side accesses. The following
diagram, courtesy of Paul, shows the possible bad scenario:

        CPU 0                                           CPU 1
        -----                                           -----

        // Pre-GP update side access
        WRITE_ONCE(*X, 1);
        smp_mb();
        r0 = rq->curr;
                                                        RCU_INIT_POINTER(rq->curr, TASK_B)
                                                        spin_unlock(rq)
                                                        rcu_read_lock_trace()
                                                        r1 = X;
        /* ignore TASK_B */

Either r0==TASK_B or r1==1 is needed but neither is guaranteed.

One possible solution to solve this is to wait for an RCU grace period
at the beginning of the TASKS-TRACE grace period before taking the
current tasks snaphot. However this would introduce more latency to
TASKS-TRACE update sides.

Choose another solution: lock the target runqueue lock while taking the
current task snapshot. This makes sure that the update side sees
the latest context switch and subsequent context switches will see the
pre-GP update side accesses.

Fixes: e386b6725798 ("rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tasks.h  |  5 +++++
 kernel/sched/core.c | 14 +++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8adbd886ad2e..6a9ee35a282e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1737,6 +1737,11 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	// allow safe access to the hop list.
 	for_each_online_cpu(cpu) {
 		rcu_read_lock();
+		/*
+		 * RQ must be locked because no ordering exists/can be relied upon
+		 * between rq->curr write and subsequent read sides. This ensures that
+		 * further context switching tasks will see update side pre-GP accesses.
+		 */
 		t = cpu_curr_snapshot(cpu);
 		if (rcu_tasks_trace_pertask_prep(t, true))
 			trc_add_holdout(t, hop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..fa6e60d5e3be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4467,12 +4467,7 @@ int task_call_func(struct task_struct *p, task_call_f func, void *arg)
  * @cpu: The CPU on which to snapshot the task.
  *
  * Returns the task_struct pointer of the task "currently" running on
- * the specified CPU.  If the same task is running on that CPU throughout,
- * the return value will be a pointer to that task's task_struct structure.
- * If the CPU did any context switches even vaguely concurrently with the
- * execution of this function, the return value will be a pointer to the
- * task_struct structure of a randomly chosen task that was running on
- * that CPU somewhere around the time that this function was executing.
+ * the specified CPU.
  *
  * If the specified CPU was offline, the return value is whatever it
  * is, perhaps a pointer to the task_struct structure of that CPU's idle
@@ -4486,11 +4481,16 @@ int task_call_func(struct task_struct *p, task_call_f func, void *arg)
  */
 struct task_struct *cpu_curr_snapshot(int cpu)
 {
+	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *t;
+	struct rq_flags rf;
 
-	smp_mb(); /* Pairing determined by caller's synchronization design. */
+	rq_lock_irqsave(rq, &rf);
+	smp_mb__after_spinlock(); /* Pairing determined by caller's synchronization design. */
 	t = rcu_dereference(cpu_curr(cpu));
+	rq_unlock_irqrestore(rq, &rf);
 	smp_mb(); /* Pairing determined by caller's synchronization design. */
+
 	return t;
 }
 
-- 
2.44.0

