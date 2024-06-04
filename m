Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B30145349;
	Tue,  4 Jun 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540505; cv=none; b=ZeY7g+Ib6emZWMiATuI5xjHGaESWjgtytCWXTxgXLySqvq1p16vY/K/p4yu4V7c6Mm9viR4YQ+lZQlzi8//6tx6eSQodgXob/dLlbLlCP1yJGYhwIeQmOynpjcd/FfiRZDTYAEpuizVU61zsL5gYAkAXBk0sB4ywduY9KvIR3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540505; c=relaxed/simple;
	bh=zHYhOT3Kv/pjOwmzA0DuB4E4EZ+pA5hNQiLKcdhduVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADnyTOOZO8JSX7ixpQMQYUK9boZ/3ixDQMhzREeRPPgvJBzANgwKsWQ4UaxzfAEDKY33ruOCsJdIoe2eUUbiRL5lw7m0oUSnWtndLRtxjlag89SvGE6cAJdKaUiDfPwMz3W2CdGELw/xdaJ6Q0kaUYVBdpQqlJeEBAFwfg2uMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOhvA2QX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOhvA2QX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C6DC4AF07;
	Tue,  4 Jun 2024 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540504;
	bh=zHYhOT3Kv/pjOwmzA0DuB4E4EZ+pA5hNQiLKcdhduVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOhvA2QXI/Rf/hv7liHG1wuvv9AFkFjPlW2GrpEF29Egx2eMxzMDx2BBgOiOOlBU/
	 EFp7cACDhbY4AKGto9VmxisX70pnwVkkeRFzgC+DEI2+jyW1CegYDf81+E7X6GeTGO
	 Rt1cHGTPsXpAiY1aJMsS77DSUwh3dQ2Nl6kM8TY3g+6Wrev361sSYdAVm9nH9AjrBv
	 Y7mjA891JPwyqdbm82wEHhOOlK8a6D/fHdfSTMYBRZN2dsltNzxTtWXW/tyA8Pphyf
	 vshw0S4y24krwIpsO39mEI3RCq4zWzxevt5u3iNczQxawN5jWmhUFgp0u0usnojfdM
	 QBMDBv68Vizhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4BA50CE3F0F; Tue,  4 Jun 2024 15:35:04 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] rcu/tasks: Fix stale task snaphot for Tasks Trace
Date: Tue,  4 Jun 2024 15:35:02 -0700
Message-Id: <20240604223502.2371550-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e3f5a71d-09ca-4882-a7f1-5680ad28c8c0@paulmck-laptop>
References: <e3f5a71d-09ca-4882-a7f1-5680ad28c8c0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When RCU-TASKS-TRACE pre-gp takes a snapshot of the current task running
on all online CPUs, no explicit ordering synchronizes properly with a
context switch.  This lack of ordering can permit the new task to miss
pre-grace-period update-side accesses.  The following diagram, courtesy
of Paul, shows the possible bad scenario:

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
at the beginning of the RCU-tasks-trace grace period before taking the
current tasks snaphot. However this would introduce large additional
latencies to RCU-tasks-trace grace periods.

Another solution is to lock the target runqueue while taking the current
task snapshot. This ensures that the update side sees the latest context
switch and subsequent context switches will see the pre-grace-period
update side accesses.

This commit therefore adds runqueue locking to cpu_curr_snapshot().

Fixes: e386b6725798 ("rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 10 ++++++++++
 kernel/sched/core.c | 14 +++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4dc56b6e27c04..126a343326170 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1747,6 +1747,16 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	// allow safe access to the hop list.
 	for_each_online_cpu(cpu) {
 		rcu_read_lock();
+		// Note that cpu_curr_snapshot() picks up the target
+		// CPU's current task while its runqueue is locked with
+		// an smp_mb__after_spinlock().  This ensures that either
+		// the grace-period kthread will see that task's read-side
+		// critical section or the task will see the updater's pre-GP
+		// accesses.  The trailing smp_mb() in cpu_curr_snapshot() 
+		// does not currently play a role other than simplify
+		// that function's ordering semantics.  If these simplified
+		// ordering semantics continue to be redundant, that smp_mb()
+		// might be removed.
 		t = cpu_curr_snapshot(cpu);
 		if (rcu_tasks_trace_pertask_prep(t, true))
 			trc_add_holdout(t, hop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc05227..05afa2932b5e4 100644
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
2.40.1

