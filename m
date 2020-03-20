Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C9C4332B
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 02:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EA420753
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 02:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584672585;
	bh=XhJ1LZqcmhPeZODYBScaf2tom9qUZ233rVvx76q+qms=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cL+Z9XgSxhXfzHEuBOVzKq17JmXsvXD5E5PZPEIebBWzs+aRD5Hxj5vOdHd4JNarh
	 ICG98JGfvy40YsgAX5S0RyOfLCD2RNuU8SA9svNhrESyPFehhdYpfcPu2jjLs+5nfW
	 sOV+FgasYhK4IKnkukBmpl2VEDT2KQFxiEZ7JK3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCTCtp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgCTCto (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 22:49:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528622071C;
        Fri, 20 Mar 2020 02:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584672583;
        bh=XhJ1LZqcmhPeZODYBScaf2tom9qUZ233rVvx76q+qms=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=b6H9M9PMVANwlE+I9R+lY+z102qor1d7e51mbhtZt2Vj0sHcU1S/AMAASQEtvBvAw
         S2UWWCfjQOoqQrw5jDtQE2xoxRvu34XJWrskvgjdkpgbudN7gOjcZb/k0LIXjdD055
         KDhNsO3ZQ9bSzqjkrtg/vMUdW1UwXAlEQPkGtev0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 22F1435226B9; Thu, 19 Mar 2020 19:49:43 -0700 (PDT)
Date:   Thu, 19 Mar 2020 19:49:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to
 sample state of locked-down task
Message-ID: <20200320024943.GA29649@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-1-paulmck@kernel.org>
 <20200319132238.75a034c3@gandalf.local.home>
 <20200319173525.GI3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319173525.GI3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 10:35:25AM -0700, Paul E. McKenney wrote:
> On Thu, Mar 19, 2020 at 01:22:38PM -0400, Steven Rostedt wrote:
> > On Wed, 18 Mar 2020 17:10:39 -0700
> > paulmck@kernel.org wrote:

[ . . . ]

> > >  /**
> > > + * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
> > > + * @p: Process for which the function is to be invoked.
> > > + * @func: Function to invoke.
> > > + * @arg: Argument to function.
> > > + *
> > > + * If the specified task can be quickly locked into a definite state
> > > + * (either sleeping or on a given runqueue), arrange to keep it in that
> > > + * state while invoking @func(@arg).  This function can use ->on_rq and
> > > + * task_curr() to work out what the state is, if required.  Given that
> > > + * @func can be invoked with a runqueue lock held, it had better be quite
> > > + * lightweight.
> > > + *
> > > + * Returns:
> > > + *	@false if the task slipped out from under the locks.
> > > + *	@true if the task was locked onto a runqueue or is sleeping.
> > > + *		However, @func can override this by returning @false.
> > 
> > Should probably state that it will return false if the state could be
> > locked, otherwise it returns the return code of the function.
> 
> So like this?
> 
>  * Returns:
>  * @false if the task state could not be locked.
>  * Otherwise, the return value from @func(arg).
> 
> > I'm wondering if we shouldn't have the function return code be something
> > passed in by the parameter, and have this return either true (locked and
> > function called), or false (not locked and function wasn't called).
> 
> I was thinking of this as one of the possible uses of whatever arg
> points to, which allows the caller of try_invoke_on_locked_down_task()
> and the specified function to communicate whatever they wish.  Then
> the specified function could (for example) unconditionally return true
> so that the return value from try_invoke_on_locked_down_task() indicated
> whether or not the specified function was called.
> 
> The current setup is very convenient for the use cases thus far.  It
> allows the function to say "Yeah, I was called, but I couldn't do
> anything", thus allowing the caller to make exactly one check to know
> that corrective action is required.

And here is another use case that led me to take this approach.
The trc_inspect_reader_notrunning() function in the patch below is passed
to try_invoke_on_locked_down_task() whose caller can continue testing
just the return value from try_invoke_on_locked_down_task() to work out
what to do next.

Thoughts?  Other use cases?

							Thanx, Paul

------------------------------------------------------------------------

commit e26a234c1205bf02b62b62cd7f15f8086fc0b13b
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Mar 19 15:33:12 2020 -0700

    rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built
    
    Systems running CPU-bound real-time task do not want IPIs sent to CPUs
    executing nohz_full userspace tasks.  Battery-powered systems don't
    want IPIs sent to idle CPUs in low-power mode.  Unfortunately, RCU tasks
    trace can and will send such IPIs in some cases.
    
    Both of these situations occur only when the target CPU is in RCU
    dyntick-idle mode, in other words, when RCU is not watching the
    target CPU.  This suggests that CPUs in dyntick-idle mode should use
    memory barriers in outermost invocations of rcu_read_lock_trace()
    and rcu_read_unlock_trace(), which would allow the RCU tasks trace
    grace period to directly read out the target CPU's read-side state.
    One challenge is that RCU tasks trace is not targeting a specific
    CPU, but rather a task.  And that task could switch from one CPU to
    another at any time.
    
    This commit therefore uses try_invoke_on_locked_down_task()
    and checks for task_curr() in trc_inspect_reader_notrunning().
    When this condition holds, the target task is running and cannot move.
    If CONFIG_TASKS_TRACE_RCU_READ_MB=y, the new rcu_dynticks_zero_in_eqs()
    function can be used to check if the specified integer (in this case,
    t->trc_reader_nesting) is zero while the target CPU remains in that same
    dyntick-idle sojourn.  If so, the target task is in a quiescent state.
    If not, trc_read_check_handler() must indicate failure so that the
    grace-period kthread can take appropriate action or retry after an
    appropriate delay, as the case may be.
    
    With this change, given CONFIG_TASKS_TRACE_RCU_READ_MB=y, if a given
    CPU remains idle or a given task continues executing in nohz_full mode,
    the RCU tasks trace grace-period kthread will detect this without the
    need to send an IPI.
    
    Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e1089fd..296f926 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -501,6 +501,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 #endif
 
 #ifdef CONFIG_TINY_RCU
+static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -510,6 +511,7 @@ static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
 #else /* #ifdef CONFIG_TINY_RCU */
+bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d31ed74..36f03d3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -802,22 +802,38 @@ static void trc_read_check_handler(void *t_in)
 /* Callback function for scheduler to check non-running) task.  */
 static bool trc_inspect_reader_notrunning(struct task_struct *t, void *arg)
 {
-	if (task_curr(t))
-		return false;  // It is running, so decline to inspect it.
+	int cpu = task_cpu(t);
+	bool in_qs = false;
+
+	if (task_curr(t)) {
+		// If no chance of heavyweight readers, do it the hard way.
+		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+			return false;
+
+		// If heavyweight readers are enabled on the remote task,
+		// we can inspect its state despite its currently running.
+		// However, we cannot safely change its state.
+		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+			return false; // No quiescent state, do it the hard way.
+		in_qs = true;
+	} else {
+		in_qs = likely(!t->trc_reader_nesting);
+	}
 
 	// Mark as checked.  Because this is called from the grace-period
 	// kthread, also remove the task from the holdout list.
 	t->trc_reader_checked = true;
 	trc_del_holdout(t);
 
-	// If the task is in a read-side critical section, set up its
+	if (in_qs)
+		return true;  // Already in quiescent state, done!!!
+
+	// The task is in a read-side critical section, so set up its
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	if (unlikely(t->trc_reader_nesting)) {
-		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-		WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
-		WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
-	}
+	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index de6228a..4eb424e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -239,6 +239,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
+	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
@@ -265,6 +266,7 @@ static void rcu_dynticks_eqs_exit(void)
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is now watching.  Better not be in an extended quiescent state!
+	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
@@ -337,6 +339,28 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 }
 
 /*
+ * Return true if the referenced integer is zero while the specified
+ * CPU remains within a single extended quiescent state.
+ */
+bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int snap;
+
+	// If not quiescent, force back to earlier extended quiescent state.
+	snap = atomic_read(&rdp->dynticks) & ~(RCU_DYNTICK_CTRL_MASK |
+					       RCU_DYNTICK_CTRL_CTR);
+
+	smp_rmb(); // Order ->dynticks and *vp reads.
+	if (READ_ONCE(*vp))
+		return false;  // Non-zero, so report failure;
+	smp_rmb(); // Order *vp read and ->dynticks re-read.
+
+	// If still in the same extended quiescent state, we are good!
+	return snap == (atomic_read(&rdp->dynticks) & ~RCU_DYNTICK_CTRL_MASK);
+}
+
+/*
  * Set the special (bottom) bit of the specified CPU so that it
  * will take special action (such as flushing its TLB) on the
  * next exit from an extended quiescent state.  Returns true if
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 44edd0a..43991a4 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -455,6 +455,8 @@ static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
+static void rcu_dynticks_task_trace_enter(void);
+static void rcu_dynticks_task_trace_exit(void);
 
 /* Forward declarations for tree_stall.h */
 static void record_gp_stall_check_time(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9355536..f4a344e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2553,3 +2553,21 @@ static void rcu_dynticks_task_exit(void)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
 #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
 }
+
+/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
+static void rcu_dynticks_task_trace_enter(void)
+{
+#ifdef CONFIG_TASKS_RCU_TRACE
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = true;
+#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+}
+
+/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
+static void rcu_dynticks_task_trace_exit(void)
+{
+#ifdef CONFIG_TASKS_RCU_TRACE
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = false;
+#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+}
