Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59296C433E0
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2302164F1C
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 18:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhBYSfR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233374AbhBYSeE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 13:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 379E464F21;
        Thu, 25 Feb 2021 18:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278002;
        bh=glnU8MC6Ied4PPAT3zOsh80mN5qE11MtT41oSCgM9kU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J8p/j1reSgFeoyQPYiLvj/3FdMAYu+BuViqpLHutHisaW4FZZ8RLFlETOuy+FHN8e
         QxyKd2eXyB0qn3/ngt4DVcVBN7R2GoETmGzHW8blGnxqeTtJsmQyc+39OiclE7fDiV
         B8NJNj6d9NX5juriP6KQTlEKlH1BU8l2kNDCZ/7w+DmYeLD8L8sgfv0j8VxRZDPWPx
         P9JOUKcZr/qPXohOYeS0P9wdd+DtnNYyQsAhrXx/RoTXqEJQSYD7cOJgQTlwLjIHC0
         X9fK+6X/avLl1bkxIQ5REhUUHvT86mgHT1ShX8HuikJJ9KtTY1J+cYYRPfBzsFCg3I
         TZWWLJ5uLCJNg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D90EF35227D5; Thu, 25 Feb 2021 10:33:21 -0800 (PST)
Date:   Thu, 25 Feb 2021 10:33:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: tasks-trace RCU: question about grace period forward progress
Message-ID: <20210225183321.GT2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
 <20210225153656.GQ2743@paulmck-ThinkPad-P72>
 <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 25, 2021 at 10:47:32AM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 25, 2021, at 10:36 AM, paulmck paulmck@kernel.org wrote:
> 
> > On Thu, Feb 25, 2021 at 09:22:48AM -0500, Mathieu Desnoyers wrote:
> >> Hi Paul,
> >> 
> >> Answering a question from Peter on IRC got me to look at rcu_read_lock_trace(),
> >> and I see this:
> >> 
> >> static inline void rcu_read_lock_trace(void)
> >> {
> >>         struct task_struct *t = current;
> >> 
> >>         WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
> >>         barrier();
> >>         if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
> >>             t->trc_reader_special.b.need_mb)
> >>                 smp_mb(); // Pairs with update-side barriers
> >>         rcu_lock_acquire(&rcu_trace_lock_map);
> >> }
> >> 
> >> static inline void rcu_read_unlock_trace(void)
> >> {
> >>         int nesting;
> >>         struct task_struct *t = current;
> >> 
> >>         rcu_lock_release(&rcu_trace_lock_map);
> >>         nesting = READ_ONCE(t->trc_reader_nesting) - 1;
> >>         barrier(); // Critical section before disabling.
> >>         // Disable IPI-based setting of .need_qs.
> >>         WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
> >>         if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
> >>                 WRITE_ONCE(t->trc_reader_nesting, nesting);
> >>                 return;  // We assume shallow reader nesting.
> >>         }
> >>         rcu_read_unlock_trace_special(t, nesting);
> >> }
> >> 
> >> AFAIU, each thread keeps track of whether it is nested within a RCU read-side
> >> critical
> >> section with a counter, and grace periods iterate over all threads to make sure
> >> they
> >> are not within a read-side critical section before they can complete:
> >> 
> >> # define rcu_tasks_trace_qs(t)                                          \
> >>         do {                                                            \
> >>                 if (!likely(READ_ONCE((t)->trc_reader_checked)) &&      \
> >>                     !unlikely(READ_ONCE((t)->trc_reader_nesting))) {    \
> >>                         smp_store_release(&(t)->trc_reader_checked, true); \
> >>                         smp_mb(); /* Readers partitioned by store. */   \
> >>                 }                                                       \
> >>         } while (0)
> >> 
> >> It reminds me of the liburcu urcu-mb flavor which also deals with per-thread
> >> state to track whether threads are nested within a critical section:
> >> 
> >> https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L90
> >> https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L125
> >> 
> >> static inline void _urcu_mb_read_lock_update(unsigned long tmp)
> >> {
> >> 	if (caa_likely(!(tmp & URCU_GP_CTR_NEST_MASK))) {
> >> 		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr,
> >> 		_CMM_LOAD_SHARED(urcu_mb_gp.ctr));
> >> 		cmm_smp_mb();
> >> 	} else
> >> 		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, tmp + URCU_GP_COUNT);
> >> }
> >> 
> >> static inline void _urcu_mb_read_lock(void)
> >> {
> >> 	unsigned long tmp;
> >> 
> >> 	urcu_assert(URCU_TLS(urcu_mb_reader).registered);
> >> 	cmm_barrier();
> >> 	tmp = URCU_TLS(urcu_mb_reader).ctr;
> >> 	urcu_assert((tmp & URCU_GP_CTR_NEST_MASK) != URCU_GP_CTR_NEST_MASK);
> >> 	_urcu_mb_read_lock_update(tmp);
> >> }
> >> 
> >> The main difference between the two algorithm is that task-trace within the
> >> kernel lacks the global "urcu_mb_gp.ctr" state snapshot, which is either
> >> incremented or flipped between 0 and 1 by the grace period. This allow RCU
> >> readers
> >> outermost nesting starting after the beginning of the grace period not to
> >> prevent
> >> progress of the grace period.
> >> 
> >> Without this, a steady flow of incoming tasks-trace-RCU readers can prevent the
> >> grace period from ever completing.
> >> 
> >> Or is this handled in a clever way that I am missing here ?
> > 
> > There are several mechanisms designed to handle this.  The following
> > paragraphs describe these at a high level.
> > 
> > The trc_wait_for_one_reader() is invoked on each task.  It uses the
> > try_invoke_on_locked_down_task(), which, if the task is currently not
> > running, keeps it that way and invokes trc_inspect_reader().  If the
> > locked-down task is in a read-side critical section, the need_qs field
> > is set, which will cause the task's next rcu_read_lock_trace() to report
> > the quiescent state.
> 
> I suspect you meant "rcu_read_unlock_trace()" here.

You are quite correct, apologies for my early morning confusion!

> > If read-side memory barriers have been enabled, trc_inspect_reader()
> > is able to check for a reader being active, and if not, reports the
> > quiescent state.  If there is a reader, trc_inspect_reader() reports
> > failure, which is another path to the following paragraph.
> > 
> > If the task could not be locked down due its currently running,
> > then trc_wait_for_one_reader() attempts to send an IPI, which results in
> > trc_read_check_handler() rechecking for a read-side critical section
> > and either reporting the quiescent state immediately or proceding in the
> > same way that trc_inspect_reader() does.  The trc_read_check_handler()
> > of course checks to make sure that the target task is still running
> > before doing anything.  If the attempt to send the IPI fails, then
> > the task is rechecked in a later pass.
> > 
> > So what sequence of events did you find that causes these mechanisms
> > to fail?
> 
> The explanation you provide takes care of my concerns, so I don't have
> any remaining problematic scenario in mind.

Would the block comment added by the below patch have helped?

One question for Peter...  Does each and every context switch imply a
full barrier?

I am pretty sure that it does, but figured that this was a good time
to double-check, given that RCU Tasks Trace assumes this.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit 581f79546b6be406a9c7280b2d3511b60821efe0
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Feb 25 10:26:00 2021 -0800

    rcu-tasks: Add block comment laying out RCU Tasks Trace design
    
    This commit adds a block comment that gives a high-level overview of
    how RCU tasks trace grace periods progress.  It also adds a note about
    how exiting tasks are handles, plus it gives an overview of the memory
    ordering.
    
    Reported-by: Peter Zijlstra <peterz@infradead.org>
    Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 17c8ebe..f818357 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -726,6 +726,42 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 // flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
 // readers can operate from idle, offline, and exception entry/exit in no
 // way allows rcu_preempt and rcu_sched readers to also do so.
+//
+// The implementation uses rcu_tasks_wait_gp(), which relies on function
+// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_trace_kthread()
+// function sets these function pointers up so that rcu_tasks_wait_gp()
+// invokes these functions in this order:
+//
+// rcu_tasks_trace_pregp_step():
+//	Initialize the count of readers and block CPU-hotplug operations.
+// rcu_tasks_trace_pertask(), invoked on every non-idle task:
+//	Initialize per-task state and attempt to identify an immediate
+//	quiescent state for that task, or, failing that, attempt to set
+//	that task's .need_qs flag so that that task's next outermost
+//	rcu_read_unlock_trace() will report the quiescent state (in which
+//	case the count of readers is incremented).  If both attempts fail,
+//	the task is added to a "holdout" list.
+// rcu_tasks_trace_postscan():
+//	Initialize state and attempt to identify an immediate quiescent
+//	state as above (but only for idle tasks), unblock CPU-hotplug
+//	operations, and wait for an RCU grace period to avoid races with
+//	tasks that are in the process of exiting.
+// check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
+//	Scans the holdout list, attempting to identify a quiescent state
+//	for each task on the list.  If there is a quiescent state, the
+//	corresponding task is removed from the holdout list.
+// rcu_tasks_trace_postgp():
+//	Wait for the count of readers do drop to zero, reporting any stalls.
+//	Also execute full memory barriers to maintain ordering with code
+//	executing after the grace period.
+//
+// The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
+//
+// Pre-grace-period update-side code is ordered before the grace
+// period via the ->cbs_lock and barriers in rcu_tasks_kthread().
+// Pre-grace-period read-side code is ordered before the grace period by
+// atomic_dec_and_test() of the count of readers (for IPIed readers) and by
+// scheduler context-switch ordering (for locked-down non-running readers).
 
 // The lockdep state must be outside of #ifdef to be useful.
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
