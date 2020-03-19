Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E52C4332D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 03:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1BC20719
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 03:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584589233;
	bh=ovOEGFyiGUBt/uqGL/LAOhIjbkrMtZ0sKkRg4GkNoJU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cvqW3W841choGGxyo4jfCvdtJ8LI2UxP0mcpaOiE6EZRasLWTXYa2yw3iWb3kpn/6
	 Ym1a5Q/2UmXROKWYrNwoSMhxMyQ06wPfHW92/4nobbpyCEJLUia7HLWrmX2xghcRc8
	 quAlhdG6py+Z47KS4DplgVgce79MFGoanBaFc5ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCSDkc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 23:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSDkc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 23:40:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE0520674;
        Thu, 19 Mar 2020 03:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584589231;
        bh=ovOEGFyiGUBt/uqGL/LAOhIjbkrMtZ0sKkRg4GkNoJU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q7stD9bnCAyZ62WHJdkQVAwc5DeaSVyXV5nUxzuiUuiDX+g4UBxFCGEnornsMv3JS
         kuY9Ea7cW7mT0Pq84KBgNcYcf7vcIlbIiJJfrLOPJRBfGQlXhGzD8UgaqRWPMExfWm
         IH6BTTBLVSS+RrrMFd/wa/OlumlM/VIF250w+wC4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D8F1B352275A; Wed, 18 Mar 2020 20:40:30 -0700 (PDT)
Date:   Wed, 18 Mar 2020 20:40:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
Message-ID: <20200319034030.GX3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-14-paulmck@kernel.org>
 <20200319013717.GA221152@google.com>
 <CAEXW_YR+NNXyaCfAkCiygjKoPkgpRwkit6G5vi44ebOwua7gCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR+NNXyaCfAkCiygjKoPkgpRwkit6G5vi44ebOwua7gCA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 18, 2020 at 09:58:23PM -0400, Joel Fernandes wrote:
> On Wed, Mar 18, 2020 at 9:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Mar 18, 2020 at 05:10:52PM -0700, paulmck@kernel.org wrote:
> > [...]
> > > +/* Initialize for a new RCU-tasks-trace grace period. */
> > > +static void rcu_tasks_trace_pregp_step(void)
> > > +{
> > > +     int cpu;
> > > +
> > > +     // Wait for CPU-hotplug paths to complete.
> > > +     cpus_read_lock();
> > > +     cpus_read_unlock();
> > > +
> > > +     // Allow for fast-acting IPIs.
> > > +     atomic_set(&trc_n_readers_need_end, 1);
> > > +
> > > +     // There shouldn't be any old IPIs, but...
> > > +     for_each_possible_cpu(cpu)
> > > +             WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
> > > +}
> > > +
> > > +/* Do first-round processing for the specified task. */
> > > +static void rcu_tasks_trace_pertask(struct task_struct *t,
> > > +                                 struct list_head *hop)
> > > +{
> > > +     WRITE_ONCE(t->trc_reader_need_end, false);
> > > +     t->trc_reader_checked = false;
> > > +     t->trc_ipi_to_cpu = -1;
> > > +     trc_wait_for_one_reader(t, hop);
> > > +}
> > > +
> > > +/* Do intermediate processing between task and holdout scans. */
> > > +static void rcu_tasks_trace_postscan(void)
> > > +{
> > > +     // Wait for late-stage exiting tasks to finish exiting.
> > > +     // These might have passed the call to exit_tasks_rcu_finish().
> > > +     synchronize_rcu();
> > > +     // Any tasks that exit after this point will set ->trc_reader_checked.
> > > +}
> > > +
> > > +/* Do one scan of the holdout list. */
> > > +static void check_all_holdout_tasks_trace(struct list_head *hop,
> > > +                                       bool ndrpt, bool *frptp)
> > > +{
> > > +     struct task_struct *g, *t;
> > > +
> > > +     list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
> > > +             // If safe and needed, try to check the current task.
> > > +             if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
> > > +                 !READ_ONCE(t->trc_reader_checked))
> > > +                     trc_wait_for_one_reader(t, hop);
> >
> > Just some questions:
> >
> > 1. How are we ensuring on the reader-side that we are executing memory
> > barriers that are sufficient to ensure that all update-side memory operations
> 
> Apologies, here I meant "update memory operations".
> 
> > in reader section is visible to code executing after the grace period?

The most pithy response is that in many of the cases, we are not
executing any additional memory barriers on the read side because it is
not necessary to do so.  Another pithy response would be that there are
very likely still memory-ordering bugs, hence the "RFC".  ;-)

Perhaps more constructively...

There are a number of cases, taking things task by task.

1.	The target task is blocked and not in a read-side critical
	section.  In this case, the grace-period kthread's call to
	try_invoke_on_locked_down_task() will acquire the target task's
	->pi_lock.  This lock will have been acquired by the target task
	while sleeping and will be acquired again when it awakened.
	This set of locks will order prior and subsequent read-side
	critical sections against that point in the grace-period
	process.  The smp_mb__after_spinlock() at the beginning of
	rcu_tasks_kthread() in combination with the lock will order this
	against posting of the callbacks.  The smp_mb() at the end of
	rcu_tasks_trace_postgp() does the same for post-grace-period
	actions.

	Note that the ordering from the callbacks to the subsequent
	readers still holds even if the target task is in a
	read-side critical section.

2.	The target task is runnable and not in a read-side critical
	section.  This proceeds the same as #1 above, except that
	both the ->pi_lock and the runqueue lock will be held when
	checking the target tasks's state.

	Note that the ordering from the callbacks to the subsequent
	readers still holds even if the target task is in a
	read-side critical section.

3.	The target task is running that we IPI and is not in a
	read-side critical section.  In this case, there is ordering
	from the smp_call_function_single() to the IPI handler
	on the one hand (and thus to later readers), and due to the
	smp_store_release() (from earlier readers) on the other hand.  The
	READ_ONCE(t->trc_ipi_to_cpu) pairs with the smp_store_release()
	in combination with the aforementioned smp_mb().

	Note that the ordering from the callbacks to the subsequent
	readers still holds even if the target task is in a
	read-side critical section.

4.	If the target task passes through a context switch while
	not in a read-side critical section, it also passes
	through rcu_tasks_trace_qs(), which has an smp_mb() and
	smp_store_release() that work not unlike the IPI case above.

	If the task is in a read-side critical section, nothing
	happens, and either this or some other case will apply
	at some later time.

5.	Otherwise, the task's ->trc_reader_special.b.need_qs is
	set, which will cause the rcu_read_unlock_trace() to
	invoke rcu_read_unlock_trace_special().  The chain
	of atomic_dec_and_test() calls will order all of these
	events, and that chain, when combined with
	wait_event_idle_exclusive_timeout()'s read of that same
	variable and its later smp_mb() will force the needed
	ordering with all prior readers.

Hey, you asked!

Your turn.  Find the bug(s).

> > 2. Is it possible that a hold-out task is removed from the hold-out list and is
> > not waited on in the updater side, before the reader side got a chance to
> > indirectly execute such memory barriers?

The only purpose of the hold-out task list is to keep track of tasks
that still need one of the above options to be applied.  Once a task is
removed from that list one of the above options has happened or is in
flight, so there is no need for the hold-out task list to be involved
in any ordering.

> > 3. If a reader sees updates that were done before the grace period started, it
> > should not see any updates that happen after the grace period ends. Is that
> > guaranteed with this RCU-Trace?

Yes, as above.

> > If its Ok, it would be nice to mention more about memory ordering aspect in
> > the changelog.

I can certainly do that, but in the immortal words of MS-DOS, are you sure?

The problem is that RCU memory ordering isn't a single pairing or
even a chain.  It is instead a net weaving through all the readers
before the end of the grace period, all the readers after the
beginning of the grace period, the grace period itself, as well as
the updates both before and after the grace period.  See for example
Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg.  It would
look sort of like that, though perhaps a little bit less elaborate.

							Thanx, Paul

> > thanks!
> >
> >  - Joel
> >
> >
> > > +
> > > +             // If check succeeded, remove this task from the list.
> > > +             if (READ_ONCE(t->trc_reader_checked))
> > > +                     trc_del_holdout(t);
> > > +     }
> > > +}
> > > +
> > > +/* Wait for grace period to complete and provide ordering. */
> > > +static void rcu_tasks_trace_postgp(void)
> > > +{
> > > +     // Remove the safety count.
> > > +     smp_mb__before_atomic();  // Order vs. earlier atomics
> > > +     atomic_dec(&trc_n_readers_need_end);
> > > +     smp_mb__after_atomic();  // Order vs. later atomics
> > > +
> > > +     // Wait for readers.
> > > +     wait_event_idle_exclusive(trc_wait,
> > > +                               atomic_read(&trc_n_readers_need_end) == 0);
> > > +
> > > +     smp_mb(); // Caller's code must be ordered after wakeup.
> > > +}
> > > +
> > > +/* Report any needed quiescent state for this exiting task. */
> > > +void exit_tasks_rcu_finish_trace(struct task_struct *t)
> > > +{
> > > +     WRITE_ONCE(t->trc_reader_checked, true);
> > > +     WARN_ON_ONCE(t->trc_reader_nesting);
> > > +     WRITE_ONCE(t->trc_reader_nesting, 0);
> > > +     if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_need_end)))
> > > +             rcu_read_unlock_trace_special(t);
> > > +}
> > > +
> > > +void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
> > > +DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
> > > +              "RCU Tasks Trace");
> > > +
> > > +/**
> > > + * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
> > > + * @rhp: structure to be used for queueing the RCU updates.
> > > + * @func: actual callback function to be invoked after the grace period
> > > + *
> > > + * The callback function will be invoked some time after a full grace
> > > + * period elapses, in other words after all currently executing RCU
> > > + * read-side critical sections have completed. call_rcu_tasks_trace()
> > > + * assumes that the read-side critical sections end at context switch,
> > > + * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
> > > + * there are no read-side primitives analogous to rcu_read_lock() and
> > > + * rcu_read_unlock() because this primitive is intended to determine
> > > + * that all tasks have passed through a safe state, not so much for
> > > + * data-strcuture synchronization.
> > > + *
> > > + * See the description of call_rcu() for more detailed information on
> > > + * memory ordering guarantees.
> > > + */
> > > +void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func)
> > > +{
> > > +     call_rcu_tasks_generic(rhp, func, &rcu_tasks_trace);
> > > +}
> > > +EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
> > > +
> > > +/**
> > > + * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
> > > + *
> > > + * Control will return to the caller some time after a trace rcu-tasks
> > > + * grace period has elapsed, in other words after all currently
> > > + * executing rcu-tasks read-side critical sections have elapsed.  These
> > > + * read-side critical sections are delimited by calls to schedule(),
> > > + * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
> > > + * anyway) cond_resched().
> > > + *
> > > + * This is a very specialized primitive, intended only for a few uses in
> > > + * tracing and other situations requiring manipulation of function preambles
> > > + * and profiling hooks.  The synchronize_rcu_tasks_trace() function is not
> > > + * (yet) intended for heavy use from multiple CPUs.
> > > + *
> > > + * See the description of synchronize_rcu() for more detailed information
> > > + * on memory ordering guarantees.
> > > + */
> > > +void synchronize_rcu_tasks_trace(void)
> > > +{
> > > +     RCU_LOCKDEP_WARN(lock_is_held(&rcu_trace_lock_map), "Illegal synchronize_rcu_tasks_trace() in RCU Tasks Trace read-side critical section");
> > > +     synchronize_rcu_tasks_generic(&rcu_tasks_trace);
> > > +}
> > > +EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_trace);
> > > +
> > > +/**
> > > + * rcu_barrier_tasks_trace - Wait for in-flight call_rcu_tasks_trace() callbacks.
> > > + *
> > > + * Although the current implementation is guaranteed to wait, it is not
> > > + * obligated to, for example, if there are no pending callbacks.
> > > + */
> > > +void rcu_barrier_tasks_trace(void)
> > > +{
> > > +     /* There is only one callback queue, so this is easy.  ;-) */
> > > +     synchronize_rcu_tasks_trace();
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
> > > +
> > > +static int __init rcu_spawn_tasks_trace_kthread(void)
> > > +{
> > > +     rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
> > > +     rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
> > > +     rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
> > > +     rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
> > > +     rcu_tasks_trace.postgp_func = rcu_tasks_trace_postgp;
> > > +     rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
> > > +     return 0;
> > > +}
> > > +core_initcall(rcu_spawn_tasks_trace_kthread);
> > > +
> > > +#else /* #ifdef CONFIG_TASKS_TRACE_RCU */
> > > +void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
> > > +#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
> > > --
> > > 2.9.5
> > >
