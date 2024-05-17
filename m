Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193721DFFD;
	Fri, 17 May 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988639; cv=none; b=jSolMNLee9S8uBwUu+tmcjP/XjZOy46p+LSPzQ3fCL3K8X7HNsctT6oLLC+/29tzkXhLYdlEnGNdt5eL7vZxqN2LTgV/bw4qf1xoN6Hpf9ROEEhraaVLfBFiHltMowasQfliyiQH2pN282MWUFAB6Cb/XFoeIcX4kS89DmKvbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988639; c=relaxed/simple;
	bh=qot/7Z+BVjx8vdmVs4trkSgQAgtLVQ0HVQp6j3d7Ogg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKYmJKUFnidvhBpJO0W6lCSrnNmM6CqNYKb1gKfpjAzh6EMZMvwNYMQg0syKUMQ6/HOJzDQ9y02qXKDlzHNKz3o3pLQ9K5ITimhTnLkKTbDkOdK9wqPIKgI7ZiOlMaGwG7JZVBXQnodnI51E7MoCRtB4077ILz6PjHb9QzGNFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbCqnOda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbCqnOda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E27C2BD10;
	Fri, 17 May 2024 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715988638;
	bh=qot/7Z+BVjx8vdmVs4trkSgQAgtLVQ0HVQp6j3d7Ogg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BbCqnOdayYIY8ZZTIrTD6nu14aL6eF89de0VyhHKGcZG6EFXh7FYbOyyaU6ODWLpJ
	 m5G0lbzLXutnT3eyhB3rpyfOm5bYc+lzb4z6z7o7iKM9yiz4ysiXbhw6tOkntDU4/5
	 z5Z8H9g6/ynRkJcQ1TtcPIB1aPq/pYM631gyKCm2nFF/bUKIJ3NpFwwUwjYqCHvV1r
	 aRCWuESywgHr2gqzWqWpFdAJhnCuJUdgoQNCAGQHc6bqxhFvxcQM3GQ05ysSe9bg4V
	 8xKWSQvqtyH4ksvNT9GSg+rI9acsVJ54xYE4n2sAKSY/HM2PwadcFJ+RWkU5+groQm
	 RjJbaBQTRDvLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 389EACE0C3C; Fri, 17 May 2024 16:30:38 -0700 (PDT)
Date: Fri, 17 May 2024 16:30:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] rcu/tasks: Fix stale task snaphot from TASK-TRACE
Message-ID: <e75f2bd3-96c9-4cb2-83f5-eafb5b68bc3b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240517152303.19689-1-frederic@kernel.org>
 <20240517152303.19689-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517152303.19689-2-frederic@kernel.org>

On Fri, May 17, 2024 at 05:23:02PM +0200, Frederic Weisbecker wrote:
> When RCU-TASKS-TRACE pre-gp takes a snapshot of the current task running
> on all online CPUs, no explicit ordering enforces a missed context
> switched task to see the pre-GP update side accesses. The following
> diagram, courtesy of Paul, shows the possible bad scenario:
> 
>         CPU 0                                           CPU 1
>         -----                                           -----
> 
>         // Pre-GP update side access
>         WRITE_ONCE(*X, 1);
>         smp_mb();
>         r0 = rq->curr;
>                                                         RCU_INIT_POINTER(rq->curr, TASK_B)
>                                                         spin_unlock(rq)
>                                                         rcu_read_lock_trace()
>                                                         r1 = X;
>         /* ignore TASK_B */
> 
> Either r0==TASK_B or r1==1 is needed but neither is guaranteed.
> 
> One possible solution to solve this is to wait for an RCU grace period
> at the beginning of the TASKS-TRACE grace period before taking the
> current tasks snaphot. However this would introduce more latency to
> TASKS-TRACE update sides.
> 
> Choose another solution: lock the target runqueue lock while taking the
> current task snapshot. This makes sure that the update side sees
> the latest context switch and subsequent context switches will see the
> pre-GP update side accesses.
> 
> Fixes: e386b6725798 ("rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Excellent catch!!!

Queued for review and testing with the usual wordsmithing shown below.

I am happy to push this via -rcu, but if you were instead looking to
send it via some other path:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

------------------------------------------------------------------------

commit f04b876e13b8218867f4e4538488c20fbcafc4f0
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri May 17 17:23:02 2024 +0200

    rcu/tasks: Fix stale task snaphot for Tasks Trace
    
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

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8adbd886ad2ee..58d8263c12392 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1737,6 +1737,9 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 	// allow safe access to the hop list.
 	for_each_online_cpu(cpu) {
 		rcu_read_lock();
+		// Note that cpu_curr_snapshot() locks the target CPU's
+		// runqueue.  This ensures that subsequent tasks running
+		// on that CPU will see the updater's pre-GP accesses.
 		t = cpu_curr_snapshot(cpu);
 		if (rcu_tasks_trace_pertask_prep(t, true))
 			trc_add_holdout(t, hop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6d..fa6e60d5e3be3 100644
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
 
