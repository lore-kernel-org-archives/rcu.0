Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A0C433F5
	for <rcu@archiver.kernel.org>; Wed,  9 Mar 2022 10:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiCIKUD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Mar 2022 05:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCIKUC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Mar 2022 05:20:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF914F996
        for <rcu@vger.kernel.org>; Wed,  9 Mar 2022 02:19:03 -0800 (PST)
Date:   Wed, 9 Mar 2022 11:19:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646821141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+F6GOwOVVSYsnTelFzgfgwLAhz0qKOVhpVgxR/DE90=;
        b=SglJfVqQS/KBZ2J+w+88DqPuHVsOuwwd7lBeDS2FrbcjaBs5GWhyKXhYb0sFvdjDppfeNu
        rr17FN+F70oAnlfDLMwj9Y6T0jgqvj0SvOgYE11D9UXUhoJ5wFiP7o+1yiCnhV0QlboIa1
        4sGC2OHgTk0otHKRsiOYbXAe6llCL0Yf6GpRXX2jbbI2XDsiRS33pwX4qloU1AMJFTkYdU
        KOvA/QS49u2DR/g73NCvrJ6pQ1Dy8bM3LH+DyDRzTRtx8Tj0Gacspnc5nteBWEz0N67Oor
        4okZtqnjxNN0H0/1IoF6lHdGdXY9L/eil5q/6IxgxdX0VQf7LUq4xItDBYFgrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646821141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+F6GOwOVVSYsnTelFzgfgwLAhz0qKOVhpVgxR/DE90=;
        b=P0FMv0xYY/zrl7M62lEZB4q0fX7yAgdE6T9INT+/5aw0xWgzEZEyRA4RMoje5aDjhfHLse
        BonF18qcP/NSvbDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <Yih/FAZqGpqDMA4l@linutronix.de>
References: <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiIrtog8fQOExyVl@linutronix.de>
 <20220305050025.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <YiZGwQltzDSzMMDg@linutronix.de>
 <20220307215327.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <Yic+K7javne8UY5U@linutronix.de>
 <20220308181040.GV4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308181040.GV4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-08 10:10:40 [-0800], Paul E. McKenney wrote:
> > Correct. Before do_pre_smp_initcalls() there is no ksoftirqd so timers
> > won't be processed. Therefore even the 26secs timer triggers, there
> > will be no RCU-stall warning. Also I'm not sure how much of preemption
> > can happen at this point since there is not much going on.
> > Any delay at this points to a lockup and at this point the lockup
> > detector isn't even fully operational (it does not trigger here during
> > test).
> 
> Is sysrq operational at this point in RT?  If so, that can be used
> to diagnose the hang, at least in development environments.  If the
> need to use sysrq becomes a problem, checks/wakeups can be added to
> rcu_sched_clock_irq().

I doubt (including !RT). The UART driver isn't yet loaded and any kind
of output is provided by an early_printk implementation which is just
output not input.

> And here is what I ended up hand-applying, presumably due to differences
> between -rt and -rcu.  I also expanded the changelog a bit.  Could you
> please check to make sure that I didn't mess something up?

Nope, good, I added something to the description.

> Oh, and I also couldn't resist taking advantage of 100 columns...
> What can I say?

You may not believe it but since last week I am indeed an owner of an
wide screen. So I do enjoy the 100 columns. Also I still try to figure
out what to do with the other half of the screen ;)

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 2895b3bb5f8a0ebe565c62b1d2e3e1efca669962
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Tue Mar 8 09:54:13 2022 -0800
> 
>     rcu-tasks: Use schedule_hrtimeout_range() to wait for grace periods
>     
>     The synchronous RCU-tasks grace-period-wait primitives invoke
>     schedule_timeout_idle() to give readers a chance to exit their
>     read-side critical sections.  Unfortunately, this fails during early
>     boot on PREEMPT_RT because PREEMPT_RT relies solely on ksoftirqd to run
>     timer handlers.  Because ksoftirqd cannot operate until its kthreads
>     are spawned, there is a brief period of time following scheduler
>     initialization where PREEMPT_RT cannot run the timer handlers that
>     schedule_timeout_idle() relies on, resulting in a hang.

Could we add something like:
   The delay here is used infrequent so it can be made to expire in
   hard-IRQ context on PREEMPT_RT without increasing the overall system
   latency.

My problem here is not to use this (timer does not expire during boot,
lets make it raw) as a general example how things should be handled in
future.
I only managed to trigger this delay via the dynamic ftrace interface/
samples so I'm comfortable with this.
Moreover I don't think that this timer, if batched with another one, will
not increase the latency substantially given that we trade here the wake
of ksoftirqd with the wake of the actual thread and that one wake up
shouldn't make much of a difference. The difference is that with
ksoftirqd, if we expire multiple timer then each timer is expired with
enabled interrupts - preemtible.
That is why I favoured spawning ksoftirqd earlier but I think this
works, too.

>     To avoid this boot-time hang, this commit replaces schedule_timeout_idle()
>     with schedule_hrtimeout(), so that the timer expires in hardirq context.
>     This is ensures that the timer fires even on PREEMPT_RT throughout the
>     irqs-enabled portions of boot as well as during runtime.
>     
>     The timer is set to expire between fract and fract + HZ / 2 jiffies in
>     order to align with any other timers that might expire during that time,
>     thus reducing the number of wakeups.
>     
>     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Sebastian
