Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3FC433EF
	for <rcu@archiver.kernel.org>; Wed,  9 Mar 2022 18:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiCISiS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiCISiL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Mar 2022 13:38:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F51704D2
        for <rcu@vger.kernel.org>; Wed,  9 Mar 2022 10:37:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D5C461730
        for <rcu@vger.kernel.org>; Wed,  9 Mar 2022 18:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2691C340EC;
        Wed,  9 Mar 2022 18:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646851030;
        bh=q0SbofMeh6J0zjjDSHwIAbG7wyH2L2PC4pqH2t13t6o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NpdDPB7Vpi+RZute8CNfXmusYY/TS4yRnR+0DhTCAGknP1Jl15zQiL5U0mSt3Jnfi
         8P5UaRQuM9mjm35lMZPwUEKoAGt4kD6sTiAjypBt41bWDgHgHRw5YqxruqSfxsJwWK
         T6UgXHZq+2/rtbCbWyxYlw6pKHsr4oMaxItx+xXn0GSpdPBfpwdw7+MCFp5N0sCxy7
         3u5koLxAfx6SkBdBbe8Lqqp4Yx355FDmuETiGbuE58dL5qehZRruUCeUpg0dNS6SNn
         LgHshgvQiztecaAjVXiyIyJPT96exolblBH5VB4actEwyTN5LTdds5U67Kh5XP7atm
         Gzov0xW63hDJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BB1B5C03FA; Wed,  9 Mar 2022 10:37:10 -0800 (PST)
Date:   Wed, 9 Mar 2022 10:37:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220309183710.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiIrtog8fQOExyVl@linutronix.de>
 <20220305050025.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <YiZGwQltzDSzMMDg@linutronix.de>
 <20220307215327.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <Yic+K7javne8UY5U@linutronix.de>
 <20220308181040.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yih/FAZqGpqDMA4l@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yih/FAZqGpqDMA4l@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 09, 2022 at 11:19:00AM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-08 10:10:40 [-0800], Paul E. McKenney wrote:
> > > Correct. Before do_pre_smp_initcalls() there is no ksoftirqd so timers
> > > won't be processed. Therefore even the 26secs timer triggers, there
> > > will be no RCU-stall warning. Also I'm not sure how much of preemption
> > > can happen at this point since there is not much going on.
> > > Any delay at this points to a lockup and at this point the lockup
> > > detector isn't even fully operational (it does not trigger here during
> > > test).
> > 
> > Is sysrq operational at this point in RT?  If so, that can be used
> > to diagnose the hang, at least in development environments.  If the
> > need to use sysrq becomes a problem, checks/wakeups can be added to
> > rcu_sched_clock_irq().
> 
> I doubt (including !RT). The UART driver isn't yet loaded and any kind
> of output is provided by an early_printk implementation which is just
> output not input.

OK, so rcu_sched_clock_irq() it is, should problems arise.  Or a boot-time
switch between timer and hrtimer, but that could get a bit ugly.

> > And here is what I ended up hand-applying, presumably due to differences
> > between -rt and -rcu.  I also expanded the changelog a bit.  Could you
> > please check to make sure that I didn't mess something up?
> 
> Nope, good, I added something to the description.
> 
> > Oh, and I also couldn't resist taking advantage of 100 columns...
> > What can I say?
> 
> You may not believe it but since last week I am indeed an owner of an
> wide screen. So I do enjoy the 100 columns. Also I still try to figure
> out what to do with the other half of the screen ;)

Very good!

And I am sure that you have seen what I do with the extra screen
real estate.  ;-)

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit 2895b3bb5f8a0ebe565c62b1d2e3e1efca669962
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Tue Mar 8 09:54:13 2022 -0800
> > 
> >     rcu-tasks: Use schedule_hrtimeout_range() to wait for grace periods
> >     
> >     The synchronous RCU-tasks grace-period-wait primitives invoke
> >     schedule_timeout_idle() to give readers a chance to exit their
> >     read-side critical sections.  Unfortunately, this fails during early
> >     boot on PREEMPT_RT because PREEMPT_RT relies solely on ksoftirqd to run
> >     timer handlers.  Because ksoftirqd cannot operate until its kthreads
> >     are spawned, there is a brief period of time following scheduler
> >     initialization where PREEMPT_RT cannot run the timer handlers that
> >     schedule_timeout_idle() relies on, resulting in a hang.
> 
> Could we add something like:
>    The delay here is used infrequent so it can be made to expire in
>    hard-IRQ context on PREEMPT_RT without increasing the overall system
>    latency.
> 
> My problem here is not to use this (timer does not expire during boot,
> lets make it raw) as a general example how things should be handled in
> future.
> I only managed to trigger this delay via the dynamic ftrace interface/
> samples so I'm comfortable with this.
> Moreover I don't think that this timer, if batched with another one, will
> not increase the latency substantially given that we trade here the wake
> of ksoftirqd with the wake of the actual thread and that one wake up
> shouldn't make much of a difference. The difference is that with
> ksoftirqd, if we expire multiple timer then each timer is expired with
> enabled interrupts - preemtible.
> That is why I favoured spawning ksoftirqd earlier but I think this
> works, too.

Good points.

What I did was to make the addition shown below.

> >     To avoid this boot-time hang, this commit replaces schedule_timeout_idle()
> >     with schedule_hrtimeout(), so that the timer expires in hardirq context.
> >     This is ensures that the timer fires even on PREEMPT_RT throughout the
> >     irqs-enabled portions of boot as well as during runtime.
> >     
> >     The timer is set to expire between fract and fract + HZ / 2 jiffies in
> >     order to align with any other timers that might expire during that time,
> >     thus reducing the number of wakeups.

	Note that RCU-tasks grace periods are infrequent, so the use
	of hrtimer should be fine.  In contrast, in common-case code,
	user of hrtimer could result in performance issues.

Does that work?

And of course if RCU-tasks grace periods do become more frequent, the
next step would be to use hrtimers at boot time and timers later on.
But one step at a time.

I also added Martin Lau and Andrii Nakryiko on CC since they have
come across the occasional RCU-tasks performance issue.

							Thanx, Paul

> >     Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Sebastian
