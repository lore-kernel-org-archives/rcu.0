Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C8C433EF
	for <rcu@archiver.kernel.org>; Sat,  5 Mar 2022 05:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiCEFBS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 5 Mar 2022 00:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCEFBR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 5 Mar 2022 00:01:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793A243151
        for <rcu@vger.kernel.org>; Fri,  4 Mar 2022 21:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E6560A6D
        for <rcu@vger.kernel.org>; Sat,  5 Mar 2022 05:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE4AC340EC;
        Sat,  5 Mar 2022 05:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646456426;
        bh=bQRV41sfxElYw9T9e8re4X2Hl0kv25fV5N/8vFJ7sZE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=La145krthjvt5tMMcP5YdFsW12xgjZ1GK2vCkFBDIHchD8tMUReYwfzfjOd5fqOa+
         uL2WtZqgFwknzCu1zJrWfokbbgVLabVoQJfojntS+q+BQlFF55eXpufukU9l3boSa5
         e7U7HU8ehzxMbykelvxr0PKiuJwqi/zoA/lVTXUCxZImImWqaxCGPGoN5Pts3i85FM
         E2S52RL7+W86VhJKA1km/EUVUfeCnSDmr39ovfmeagmaRulcWGN293F5CpoTGEc3Z6
         dM8sc/VNXVi41pnTmoOONDvj5icI7/Wmb+kjK+qBpYTJCqAexW/kBxxkxSwcZB3nyM
         kn6PD5nL8uBQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6C985C0920; Fri,  4 Mar 2022 21:00:25 -0800 (PST)
Date:   Fri, 4 Mar 2022 21:00:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220305050025.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiIrtog8fQOExyVl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiIrtog8fQOExyVl@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 04, 2022 at 04:09:42PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-03 12:02:37 [-0800], Paul E. McKenney wrote:
> > > > Either way, it sounds like that irq_work_queue(&rtpcp->rtp_irq_work) in
> > > > call_rcu_tasks_generic() needs some adjustment to work in RT.  This should
> > > > be doable.  Given this, and given that the corresponding diagnostic
> > > > function rcu_tasks_verify_self_tests() is a late_initcall() function,
> > > > you don't need to move the call to rcu_init_tasks_generic(), correct?
> > > 
> > > #1 ksoftirqd must be spawned first in order to get timer_list timer to
> > >    work. I'm going to do that, this should not be a problem.
> > 
> > I very much appreciate your flexibility on this, but it would be even
> > better if there was a good way to avoid the dependency on ksoftirqd,
> > at least during boot time.  Spawning ksoftirqd first would narrow the
> > window of RCU unavailability in RT, but it would be good to have RCU
> > work throughout, as it currently does in !RT.  (Give or take a short
> > time during the midst of the scheduler putting itself together.)
> 
> During SYSTEM_BOOTING we could do softirqs right away but we lack the
> infrastructure. Starting with SYSTEM_SCHEDULING we rely on the thread so
> it needs to be spawned earlier. The problem with SYSTEM_SCHEDULING+ is
> that we may deadlock if the softirqs and performed in IRQ-context.

Understood.  My goal is to prevent RCU from being yet another odd
constraint that people writing boot-time code need to worry about.
Or at least no additional odd constraints than the ones that it already
presents.  :-/

> > This might seem a bit utopian or even unreasonable, but please keep in
> > mind that both the scheduler and the idle loop use RCU.
> 
> But the problem is only the usage of synchronize_rcu().

And synchronize_rcu_expedited(), but yes in that call_rcu() and so
on still work.

>                                                         So
> rcu_read_lock() and call_rcu() works. Only synchronize_rcu() does not.
> Couldn't we make a rule to use at earliest within early_initcall()?

Of course we could make such a rule.

And sometimes, people running into problems with that rule might be able
to move their code earlier or later and avoid problems.  But other times
they have to do something else.  Which will sometimes mean that we are
asking them to re-implement some odd special case of RCU within their
own subsystem, which just does not sound like a good idea.

In face, my experience indicates that it is way easier to make RCU work
more globally than to work all the issues stemming from these sorts of
limits on RCU users.  Takes less time, also.

And it probably is not all -that- hard.

> > However, that swait_event_timeout_exclusive() doesn't need exact timing
> > during boot.  Anything that let other tasks run for at least a few tens
> > of microseconds (up to say a millisecond) could easily work just fine.
> > Is there any such thing in RT?
> 
> swait_event_timeout_exclusive() appears not to be the culprit. It is
> invoked a few times (with a 6.5ms timeout) but returns without setting
> up a timer. So either my setup avoids the timer or this happens always
> and is not related to my config).

Now that you mention it, yes.  There is only one CPU, so unless you have
an odd series of preemptions, it quickly figures out that it does not
need to wait.  But that odd series of preemptions really is out there,
patiently waiting for us to lose context on this code.

> rcu_tasks_wait_gp() does schedule_timeout_idle() and this is the one
> that blocks. This could be replaced with schedule_hrtimeout() (just
> tested). I hate the idea to use a precise delay in a timeout like
> situation. But we could use schedule_hrtimeout_range() with a HZ delta
> so it kind of feels like the timer_list timer ;)

If schedule_hrtimeout_range() works, I am good with it.
And you are right, precision is not required here.  And maybe
schedule_hrtimeout_range() could also be used to create a crude
boot-time-only polling loop for the swait_event_timeout_exclusive()?

> Also I have no idea how often this is triggered / under which
> circumstances (assuming it is bound synchronize_rcu()).

If I understand you here, it only has to happen once in a while.

> > >    - if you can't guarantee that there is only _one_ waiter
> > >      => spawn the irq-work thread early.
> > 
> > Spawning the irq-work kthread early still leaves a hole.
> 
> Why is spawning ksoftirqd + irq-work before early_initcall() still a
> hole? If the definition is _no_ synchronize_rcu() before
> early_initcall() then it works as documented.

Because based on past experience, it will be way easier to make RCU not
have that hole that to deal with that hole's existence.

> > Other approaches:
> > 
> > o	For the swait_event_timeout_exclusive(), I could make early
> > 	boot uses instead do swait_event_exclusive() and make early boot
> > 	rcu_sched_clock_irq() do an unconditional wakeup.  This would
> > 	require a loop around one of the swait_event_exclusive()
> > 	calls (cheaper than making rcu_sched_clock_irq() worry about
> > 	durations).
> > 
> > 	RCU would need to be informed of the end of "early boot",
> > 	for example, by invoking some TBD RCU function as soon
> > 	as the ksoftirqd kthreads are created.
> > 
> > 	This would also require that rcu_needs_cpu() always return
> > 	true during early boot.
> > 
> > 	Static branches could be used if required, as they might be in
> > 	rcu_needs_cpu() and maybe also in rcu_sched_clock_irq().
> 
> swait_event_timeout_exclusive() appears innocent.

I agree that it would rarely need to block, but if the task executing the
synchronize_rcu() preempted one of the readers, wouldn't it have to block?
Or am I missing some code path that excludes that possibility?

> > o	A similar TBD RCU function could cause call_rcu_tasks_generic()
> > 	to avoid invoking irq_work_queue() until after the relevant
> > 	kthread was created, but to do any needed wakeup at that point.
> > 	If wakeups are needed before that time (which they might),
> > 	then perhaps the combination of rcu_sched_clock_irq() and
> > 	rcu_needs_cpu() can help out there as well.
> 
> IRQ-work has been addressed in a different patch.

And from what I can see, that IRQ_WORK_INIT_HARD() is just the ticket.
Thank you!!!

> > These would be conditioned on IS_ENABLED(CONFIG_PREEMPT_RT).
> > 
> > But now you are going to tell me that wakeups cannot be done from the
> > scheduler tick interrupt handler?  If that is the case, are there other
> > approaches?
> 
> If you by my irqwork patch then I think we are down to:
> - spawn ksoftirqd early
> - use during boot schedule_hrtimeout() or the whole time (no I idea how
>   often this triggers).

The boot-time schedule_hrtimeout_range() seems to cover things, especially
given that most of the time there would be no need to block.  Or is
there yet another gap where schedule_hrtimeout_range() does not work?
(After the scheduler starts.)

							Thanx, Paul
