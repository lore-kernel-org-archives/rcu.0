Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD227C4332D
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 01:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7621220767
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 01:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="CvHPUKPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCSB6g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:58:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34646 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSB6f (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 21:58:35 -0400
Received: by mail-io1-f68.google.com with SMTP id h131so668657iof.1
        for <rcu@vger.kernel.org>; Wed, 18 Mar 2020 18:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0p4yLraNGK6GHKg27zWpQK3iXedCaAOVX5CrTA68Gno=;
        b=CvHPUKPErx+M0/Yd17Ko659JUDH2l2x5wqqkxbZJs7kdgQxHUGhy+o1EmGWGjRqtAY
         hSbDIb9ExiLnaz2MlOG1qhTL0LJax+Wr0piZq8E7NGrVwz9m0DNSR5wWxKoT0029ufZL
         fpj9HawudGrWPdGGCO0YKBhLUsQqMaLaf8uf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0p4yLraNGK6GHKg27zWpQK3iXedCaAOVX5CrTA68Gno=;
        b=e6a8gDZ20SubbUCh/M+evolld2mbM0tYxmI8jUm8GwrmbZkcvTFelRJcG5ahy+3MdN
         tqhtVv8iKwr7vi0KdBKSm0t6jbVDWdIJorsDhV8Ip2XB9W+srczOxAlHwf0EgBNJeCy3
         05f43jCpU6WMqM3efnjKmdHuIaHDbf9A9XBDe/bBwT/tkWCFST51nSgSvN0gCSc+ssBu
         lNDUDL1UxXrq8L/HPxKSCjHuAhnIOq8hU3ZUafAp+CqIWUnHNjm7zumPmAMD1m0YONHS
         F6uQ+4ztLlDrsEHPfqOzapMT6toDM1Lj7Qty9Xckf3sSVDkeTBqCSmHMaikGmmVfLwE/
         LYRQ==
X-Gm-Message-State: ANhLgQ1IARZj5lHee3NZlTK15NgaI5bGjvUx4bFkyV3jd57tzylyS8lS
        /QlrTzQv7yC7YwA2NmX7IboPT3zMRlykBY6e8d1Fjg==
X-Google-Smtp-Source: ADFU+vuFqKemr5mv8/c4u46NlVjJ5mT1//Tl17/NTpi4GLBggHDdDykoLy2MNr3uFrNlBsNNFMT1l3RxhxiLm11q43Q=
X-Received: by 2002:a02:940d:: with SMTP id a13mr1007771jai.23.1584583114337;
 Wed, 18 Mar 2020 18:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200319001024.GA28798@paulmck-ThinkPad-P72> <20200319001100.24917-14-paulmck@kernel.org>
 <20200319013717.GA221152@google.com>
In-Reply-To: <20200319013717.GA221152@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 18 Mar 2020 21:58:23 -0400
Message-ID: <CAEXW_YR+NNXyaCfAkCiygjKoPkgpRwkit6G5vi44ebOwua7gCA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 tip/core/rcu 14/22] rcu-tasks: Add an RCU Tasks
 Trace to simplify protection of tracing hooks
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 18, 2020 at 9:37 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Mar 18, 2020 at 05:10:52PM -0700, paulmck@kernel.org wrote:
> [...]
> > +/* Initialize for a new RCU-tasks-trace grace period. */
> > +static void rcu_tasks_trace_pregp_step(void)
> > +{
> > +     int cpu;
> > +
> > +     // Wait for CPU-hotplug paths to complete.
> > +     cpus_read_lock();
> > +     cpus_read_unlock();
> > +
> > +     // Allow for fast-acting IPIs.
> > +     atomic_set(&trc_n_readers_need_end, 1);
> > +
> > +     // There shouldn't be any old IPIs, but...
> > +     for_each_possible_cpu(cpu)
> > +             WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
> > +}
> > +
> > +/* Do first-round processing for the specified task. */
> > +static void rcu_tasks_trace_pertask(struct task_struct *t,
> > +                                 struct list_head *hop)
> > +{
> > +     WRITE_ONCE(t->trc_reader_need_end, false);
> > +     t->trc_reader_checked = false;
> > +     t->trc_ipi_to_cpu = -1;
> > +     trc_wait_for_one_reader(t, hop);
> > +}
> > +
> > +/* Do intermediate processing between task and holdout scans. */
> > +static void rcu_tasks_trace_postscan(void)
> > +{
> > +     // Wait for late-stage exiting tasks to finish exiting.
> > +     // These might have passed the call to exit_tasks_rcu_finish().
> > +     synchronize_rcu();
> > +     // Any tasks that exit after this point will set ->trc_reader_checked.
> > +}
> > +
> > +/* Do one scan of the holdout list. */
> > +static void check_all_holdout_tasks_trace(struct list_head *hop,
> > +                                       bool ndrpt, bool *frptp)
> > +{
> > +     struct task_struct *g, *t;
> > +
> > +     list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
> > +             // If safe and needed, try to check the current task.
> > +             if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
> > +                 !READ_ONCE(t->trc_reader_checked))
> > +                     trc_wait_for_one_reader(t, hop);
>
> Just some questions:
>
> 1. How are we ensuring on the reader-side that we are executing memory
> barriers that are sufficient to ensure that all update-side memory operations

Apologies, here I meant "update memory operations".

thanks,

 - Joel


> in reader section is visible to code executing after the grace period?
>
> 2. Is it possible that a hold-out task is removed from the hold-out list and is
> not waited on in the updater side, before the reader side got a chance to
> indirectly execute such memory barriers?
>
> 3. If a reader sees updates that were done before the grace period started, it
> should not see any updates that happen after the grace period ends. Is that
> guaranteed with this RCU-Trace?
>
> If its Ok, it would be nice to mention more about memory ordering aspect in
> the changelog.
>
> thanks!
>
>  - Joel
>
>
> > +
> > +             // If check succeeded, remove this task from the list.
> > +             if (READ_ONCE(t->trc_reader_checked))
> > +                     trc_del_holdout(t);
> > +     }
> > +}
> > +
> > +/* Wait for grace period to complete and provide ordering. */
> > +static void rcu_tasks_trace_postgp(void)
> > +{
> > +     // Remove the safety count.
> > +     smp_mb__before_atomic();  // Order vs. earlier atomics
> > +     atomic_dec(&trc_n_readers_need_end);
> > +     smp_mb__after_atomic();  // Order vs. later atomics
> > +
> > +     // Wait for readers.
> > +     wait_event_idle_exclusive(trc_wait,
> > +                               atomic_read(&trc_n_readers_need_end) == 0);
> > +
> > +     smp_mb(); // Caller's code must be ordered after wakeup.
> > +}
> > +
> > +/* Report any needed quiescent state for this exiting task. */
> > +void exit_tasks_rcu_finish_trace(struct task_struct *t)
> > +{
> > +     WRITE_ONCE(t->trc_reader_checked, true);
> > +     WARN_ON_ONCE(t->trc_reader_nesting);
> > +     WRITE_ONCE(t->trc_reader_nesting, 0);
> > +     if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_need_end)))
> > +             rcu_read_unlock_trace_special(t);
> > +}
> > +
> > +void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
> > +DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
> > +              "RCU Tasks Trace");
> > +
> > +/**
> > + * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
> > + * @rhp: structure to be used for queueing the RCU updates.
> > + * @func: actual callback function to be invoked after the grace period
> > + *
> > + * The callback function will be invoked some time after a full grace
> > + * period elapses, in other words after all currently executing RCU
> > + * read-side critical sections have completed. call_rcu_tasks_trace()
> > + * assumes that the read-side critical sections end at context switch,
> > + * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
> > + * there are no read-side primitives analogous to rcu_read_lock() and
> > + * rcu_read_unlock() because this primitive is intended to determine
> > + * that all tasks have passed through a safe state, not so much for
> > + * data-strcuture synchronization.
> > + *
> > + * See the description of call_rcu() for more detailed information on
> > + * memory ordering guarantees.
> > + */
> > +void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func)
> > +{
> > +     call_rcu_tasks_generic(rhp, func, &rcu_tasks_trace);
> > +}
> > +EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
> > +
> > +/**
> > + * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
> > + *
> > + * Control will return to the caller some time after a trace rcu-tasks
> > + * grace period has elapsed, in other words after all currently
> > + * executing rcu-tasks read-side critical sections have elapsed.  These
> > + * read-side critical sections are delimited by calls to schedule(),
> > + * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
> > + * anyway) cond_resched().
> > + *
> > + * This is a very specialized primitive, intended only for a few uses in
> > + * tracing and other situations requiring manipulation of function preambles
> > + * and profiling hooks.  The synchronize_rcu_tasks_trace() function is not
> > + * (yet) intended for heavy use from multiple CPUs.
> > + *
> > + * See the description of synchronize_rcu() for more detailed information
> > + * on memory ordering guarantees.
> > + */
> > +void synchronize_rcu_tasks_trace(void)
> > +{
> > +     RCU_LOCKDEP_WARN(lock_is_held(&rcu_trace_lock_map), "Illegal synchronize_rcu_tasks_trace() in RCU Tasks Trace read-side critical section");
> > +     synchronize_rcu_tasks_generic(&rcu_tasks_trace);
> > +}
> > +EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_trace);
> > +
> > +/**
> > + * rcu_barrier_tasks_trace - Wait for in-flight call_rcu_tasks_trace() callbacks.
> > + *
> > + * Although the current implementation is guaranteed to wait, it is not
> > + * obligated to, for example, if there are no pending callbacks.
> > + */
> > +void rcu_barrier_tasks_trace(void)
> > +{
> > +     /* There is only one callback queue, so this is easy.  ;-) */
> > +     synchronize_rcu_tasks_trace();
> > +}
> > +EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
> > +
> > +static int __init rcu_spawn_tasks_trace_kthread(void)
> > +{
> > +     rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
> > +     rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
> > +     rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
> > +     rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
> > +     rcu_tasks_trace.postgp_func = rcu_tasks_trace_postgp;
> > +     rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
> > +     return 0;
> > +}
> > +core_initcall(rcu_spawn_tasks_trace_kthread);
> > +
> > +#else /* #ifdef CONFIG_TASKS_TRACE_RCU */
> > +void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
> > +#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
> > --
> > 2.9.5
> >
