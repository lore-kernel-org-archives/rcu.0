Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C51C433EF
	for <rcu@archiver.kernel.org>; Fri,  4 Mar 2022 15:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiCDPKx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiCDPKw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Mar 2022 10:10:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC12C109A70
        for <rcu@vger.kernel.org>; Fri,  4 Mar 2022 07:09:50 -0800 (PST)
Date:   Fri, 4 Mar 2022 16:09:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646406583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8pwlqsUoakdNO6V0QJMv5C2ZhcAva2nNaoTV5T4/2sM=;
        b=U3mXXFSbOdglSpRAqyS8uNhixEakn/wzZruaafn5/+vf2BNRLW9MQcowABu3wB4ofDG4P9
        OAeF5deWsMNM/gObA/fo1q1i4wzCUp6Qp2ag8RikJDdQmXOSW9oSVyBDrZMfIdBEHI7wHx
        nNBjqc9D59AaYws7UhOenNYB7G+J1Nrfr6rwFzb0Bz0CESeJDTZR4UZi+zyEr1dEGjwKpm
        mNOKJSedVNEEGyNqznvrSuMm9GCJWVQLPy2MrV40DIarTPcNrBU9q4T/Nc46l99YNBcEVN
        SBg5Zy4WhFftgsENdfrhu0PBCbpNAUacDQ9NoHGN11FKNlQJQXxNREl0u50iNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646406583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8pwlqsUoakdNO6V0QJMv5C2ZhcAva2nNaoTV5T4/2sM=;
        b=LJUsr/dqAZF4/3cgRyRc0vQoBZ02bEYvPXawkjSlPiypgGdOC87E9Mg4/zh6m/D3iNdn5X
        3NworZYeD3LMuVAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <YiIrtog8fQOExyVl@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-03 12:02:37 [-0800], Paul E. McKenney wrote:
> > > Either way, it sounds like that irq_work_queue(&rtpcp->rtp_irq_work) in
> > > call_rcu_tasks_generic() needs some adjustment to work in RT.  This should
> > > be doable.  Given this, and given that the corresponding diagnostic
> > > function rcu_tasks_verify_self_tests() is a late_initcall() function,
> > > you don't need to move the call to rcu_init_tasks_generic(), correct?
> > 
> > #1 ksoftirqd must be spawned first in order to get timer_list timer to
> >    work. I'm going to do that, this should not be a problem.
> 
> I very much appreciate your flexibility on this, but it would be even
> better if there was a good way to avoid the dependency on ksoftirqd,
> at least during boot time.  Spawning ksoftirqd first would narrow the
> window of RCU unavailability in RT, but it would be good to have RCU
> work throughout, as it currently does in !RT.  (Give or take a short
> time during the midst of the scheduler putting itself together.)

During SYSTEM_BOOTING we could do softirqs right away but we lack the
infrastructure. Starting with SYSTEM_SCHEDULING we rely on the thread so
it needs to be spawned earlier. The problem with SYSTEM_SCHEDULING+ is
that we may deadlock if the softirqs and performed in IRQ-context.

> This might seem a bit utopian or even unreasonable, but please keep in
> mind that both the scheduler and the idle loop use RCU.

But the problem is only the usage of synchronize_rcu(). So
rcu_read_lock() and call_rcu() works. Only synchronize_rcu() does not.
Couldn't we make a rule to use at earliest within early_initcall()?

> However, that swait_event_timeout_exclusive() doesn't need exact timing
> during boot.  Anything that let other tasks run for at least a few tens
> of microseconds (up to say a millisecond) could easily work just fine.
> Is there any such thing in RT?

swait_event_timeout_exclusive() appears not to be the culprit. It is
invoked a few times (with a 6.5ms timeout) but returns without setting
up a timer. So either my setup avoids the timer or this happens always
and is not related to my config).

rcu_tasks_wait_gp() does schedule_timeout_idle() and this is the one
that blocks. This could be replaced with schedule_hrtimeout() (just
tested). I hate the idea to use a precise delay in a timeout like
situation. But we could use schedule_hrtimeout_range() with a HZ delta
so it kind of feels like the timer_list timer ;)

Also I have no idea how often this is triggered / under which
circumstances (assuming it is bound synchronize_rcu()).

> >    - if you can't guarantee that there is only _one_ waiter
> >      => spawn the irq-work thread early.
> 
> Spawning the irq-work kthread early still leaves a hole.

Why is spawning ksoftirqd + irq-work before early_initcall() still a
hole? If the definition is _no_ synchronize_rcu() before
early_initcall() then it works as documented.

> Other approaches:
> 
> o	For the swait_event_timeout_exclusive(), I could make early
> 	boot uses instead do swait_event_exclusive() and make early boot
> 	rcu_sched_clock_irq() do an unconditional wakeup.  This would
> 	require a loop around one of the swait_event_exclusive()
> 	calls (cheaper than making rcu_sched_clock_irq() worry about
> 	durations).
> 
> 	RCU would need to be informed of the end of "early boot",
> 	for example, by invoking some TBD RCU function as soon
> 	as the ksoftirqd kthreads are created.
> 
> 	This would also require that rcu_needs_cpu() always return
> 	true during early boot.
> 
> 	Static branches could be used if required, as they might be in
> 	rcu_needs_cpu() and maybe also in rcu_sched_clock_irq().

swait_event_timeout_exclusive() appears innocent.

> o	A similar TBD RCU function could cause call_rcu_tasks_generic()
> 	to avoid invoking irq_work_queue() until after the relevant
> 	kthread was created, but to do any needed wakeup at that point.
> 	If wakeups are needed before that time (which they might),
> 	then perhaps the combination of rcu_sched_clock_irq() and
> 	rcu_needs_cpu() can help out there as well.

IRQ-work has been addressed in a different patch.

> These would be conditioned on IS_ENABLED(CONFIG_PREEMPT_RT).
> 
> But now you are going to tell me that wakeups cannot be done from the
> scheduler tick interrupt handler?  If that is the case, are there other
> approaches?

If you by my irqwork patch then I think we are down to:
- spawn ksoftirqd early
- use during boot schedule_hrtimeout() or the whole time (no I idea how
  often this triggers).

> > > Back over to you so that I can learn what I am still missing.  ;-)
> > 
> > Hope that helps.
> 
> Maybe?  You tell me!  ;-)
> 
> 							Thanx, Paul

Sebastian
