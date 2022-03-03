Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C56C433F5
	for <rcu@archiver.kernel.org>; Thu,  3 Mar 2022 20:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiCCUDi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiCCUDh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Mar 2022 15:03:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99E327CE6
        for <rcu@vger.kernel.org>; Thu,  3 Mar 2022 12:02:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3232BB826D3
        for <rcu@vger.kernel.org>; Thu,  3 Mar 2022 20:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E66C004E1;
        Thu,  3 Mar 2022 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646337758;
        bh=7GVnrM+KOUqLSK/9rhqTpUveiIpHYHWtM0D21LkQKlE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KQ92ppFXdQKwZ92/B6I5but+KUxZHypDqHuH5OALoIheVmzUNaMqirJI5etpbp7hF
         /EWc0OwSgOV5SD9W8ime1HfCES/j7VxBNHqTwV5rRxQkQ9BQaG1smbBPvZcOc+obms
         tRNhYLzC5RgWeuI0UPHudHEyzPTNKYidRqDR4a7ebNTsQYdsgBtLen35b7g8MOnjTQ
         7D/lbTDa0vEM9QTTtlDrBzwuD60hyI3+DCoiV54HP5WYG2Yk3cMSJt7U/IDDmVYRJ9
         jkmPaVGLWZ0kCm8SQKuvsJrRCYNbQ/FDOI4zv79UGMHkSFN2hO87888VSSPS4GQ+04
         VMevEwBwiyJgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 97BDC5C0ADD; Thu,  3 Mar 2022 12:02:37 -0800 (PST)
Date:   Thu, 3 Mar 2022 12:02:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YiCT/i3jlgg9LX/r@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 03, 2022 at 11:10:06AM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-02 20:36:50 [-0800], Paul E. McKenney wrote:
> > > To simply move the test from rcu_init_tasks_generic() to after
> > > do_pre_smp_initcalls(). If we can't move rcu_init_tasks_generic() after
> > > do_pre_smp_initcalls() or at least the test part because we need working
> > > synchronize_rcu() in early_initcall() then I need to move the RT
> > > requirements before. Simple ;)
> > 
> > As long as RT confines itself to configurations that do not need a
> > working synchronize_rcu() in the intervening code, yes, simple.  ;-)
> 
> ;)
> 
> > > The requirements are:
> > > 
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -1598,6 +1601,9 @@ static noinline void __init kernel_init_freeable(void)
> > >  
> > >         init_mm_internals();
> > >  
> > > +       spawn_ksoftirqd();
> > > +       irq_work_init_threads();
> > > +
> > >         rcu_init_tasks_generic();
> > >         do_pre_smp_initcalls();
> > >         lockup_detector_init();
> > > 
> > > spawn_ksoftirqd() is what I mentioned. What I just figured out is
> > > irq_work_init_threads() due to
> > > 	call_rcu_tasks_iw_wakeup()
> > > 
> > > I can't move this to hard-IRQ context because it invokes wake_up() which
> > > acquires sleeping locks. If you say that rtp->cbs_wq has only one waiter
> > > and something like rcuwait_wait_event() / rcuwait_wake_up() would work
> > > as well then call_rcu_tasks_iw_wakeup() could be lifter to hard-IRQ
> > > context and we need to worry only about spawn_ksoftirqd() :)
> > 
> > OK, I was expecting that the swait_event_timeout_exclusive() call from
> > synchronize_rcu_expedited_wait_once() would be the problem.  Are you
> > saying that this swait_event_timeout_exclusive() works fine?  
> 
> swait_event_timeout_exclusive() uses schedule_timeout() which uses a
> timer_list timer and this one requires ksoftirqd to work.

OK, at least things are consistent, then.  ;-)

> > Or are you
> > instead saying that the call_rcu_tasks_iw_wakeup() issues cause trouble
> > before that swait_event_timeout_exclusive() gets a chance to cause its
> > own trouble?
> 
> Both is needed:
> - ksoftirqd thread for timer_list timers handling.
> - irq_work thread for irq_work which is not done in hard-IRQ context.

Understood.

> What I observe during boot:
> | [    0.184838] cblist_init_generic: Setting adjustable number of callback queues.
> | [    0.184853] cblist_init_generic: Setting shift to 2 and lim to 1.
> | [    0.188116] irq_work_single() wake_up_klogd_work_func+0x0/0x70 26
> | [    0.188861] cblist_init_generic: Setting shift to 2 and lim to 1.
> | [    0.189671] Running RCU-tasks wait API self tests
> | [    0.190254] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
> | [    0.292569] expire_timers() process_timeout+0x0/0x10
> | [    0.292655] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
> | [    0.295082] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
> | [    0.296481] irq_work_single() call_rcu_tasks_iw_wakeup+0x0/0x20 22
> | [    0.304685] rcu: Hierarchical SRCU implementation.
> | [    0.311415] Callback from call_rcu_tasks_trace() invoked.
> | [    0.344100] smp: Bringing up secondary CPUs ...
> 
> 1x schedule_timeout() and 4x call_rcu_tasks_iw_wakeup(). Both are
> crucial.

Got it, thank you!

> > Either way, it sounds like that irq_work_queue(&rtpcp->rtp_irq_work) in
> > call_rcu_tasks_generic() needs some adjustment to work in RT.  This should
> > be doable.  Given this, and given that the corresponding diagnostic
> > function rcu_tasks_verify_self_tests() is a late_initcall() function,
> > you don't need to move the call to rcu_init_tasks_generic(), correct?
> 
> #1 ksoftirqd must be spawned first in order to get timer_list timer to
>    work. I'm going to do that, this should not be a problem.

I very much appreciate your flexibility on this, but it would be even
better if there was a good way to avoid the dependency on ksoftirqd,
at least during boot time.  Spawning ksoftirqd first would narrow the
window of RCU unavailability in RT, but it would be good to have RCU
work throughout, as it currently does in !RT.  (Give or take a short
time during the midst of the scheduler putting itself together.)

This might seem a bit utopian or even unreasonable, but please keep in
mind that both the scheduler and the idle loop use RCU.

However, that swait_event_timeout_exclusive() doesn't need exact timing
during boot.  Anything that let other tasks run for at least a few tens
of microseconds (up to say a millisecond) could easily work just fine.
Is there any such thing in RT?

> #2 call_rcu_tasks_iw_wakeup. Here we have the following options:
>    - Don't use, delay, …

What is the form of the delay?  All this code is trying to do is to make
the specified function execute in a clean environment so as to avoid
potential deadlocks.  So the range of possible solutions is quite broad.

>    - if you can guarantee that there is only _one_ waiter
>      => Replace rcu_tasks::cbs_wq with rcuwait. Let this irq_work run
>         then in hard-IRQ context.

There is indeed only ever one waiter.  

But rcuwait is going to acquire scheduler locks, correct?  It would be
better to avoid that potential deadlock.

>    - if you can't guarantee that there is only _one_ waiter
>      => spawn the irq-work thread early.

Spawning the irq-work kthread early still leaves a hole.

> As for #2, I managed to trigger the wakeup via tracing (and stumbled
> into a bug un related to this) and I see only one waiter. Doesn't mean I
> do it right and they can't be a second waiter.

Only one waiter!  ;-)

Other approaches:

o	For the swait_event_timeout_exclusive(), I could make early
	boot uses instead do swait_event_exclusive() and make early boot
	rcu_sched_clock_irq() do an unconditional wakeup.  This would
	require a loop around one of the swait_event_exclusive()
	calls (cheaper than making rcu_sched_clock_irq() worry about
	durations).

	RCU would need to be informed of the end of "early boot",
	for example, by invoking some TBD RCU function as soon
	as the ksoftirqd kthreads are created.

	This would also require that rcu_needs_cpu() always return
	true during early boot.

	Static branches could be used if required, as they might be in
	rcu_needs_cpu() and maybe also in rcu_sched_clock_irq().

o	A similar TBD RCU function could cause call_rcu_tasks_generic()
	to avoid invoking irq_work_queue() until after the relevant
	kthread was created, but to do any needed wakeup at that point.
	If wakeups are needed before that time (which they might),
	then perhaps the combination of rcu_sched_clock_irq() and
	rcu_needs_cpu() can help out there as well.

These would be conditioned on IS_ENABLED(CONFIG_PREEMPT_RT).

But now you are going to tell me that wakeups cannot be done from the
scheduler tick interrupt handler?  If that is the case, are there other
approaches?

> > Back over to you so that I can learn what I am still missing.  ;-)
> 
> Hope that helps.

Maybe?  You tell me!  ;-)

							Thanx, Paul
