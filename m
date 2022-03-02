Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C79C433EF
	for <rcu@archiver.kernel.org>; Wed,  2 Mar 2022 11:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiCBLKe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCBLKb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Mar 2022 06:10:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B209593B2
        for <rcu@vger.kernel.org>; Wed,  2 Mar 2022 03:09:46 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:09:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646219384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QgCvCGdKiZgI0ITUrWkWWCLcKoPQXQp6CEHQpgXcoAA=;
        b=fCoS8Pbb2AIhu9DoUZsb6dDaCYHOqEKSd7q1RH6OQhmofHaa4bxlm55MMNQcEi/+k/EnMT
        i981Eks5MiAxGoilSwbeHlgdXP0HQi5EEejSXIu7wlhSnebI7jQ8OUu1qcvltMRX4egUJe
        j1MvJUbjVor0jwwen2LD0BHi7rrWcy1kpi2lhxSqtB6DE1KgiQVvnRUschas7gXTIdTnlI
        PrNW5Cbun0AcWCvx+CQBxwBTKM5E8hla0u/pkhwNIqJDqBj+mvHVTInT9b411UOBQ8dloK
        1bG7Ne4AZkmJ70BY+gD4HAlcBcqxxDbVhcprni3dl5Z4i9uE4IIS8sBGvwjidA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646219384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QgCvCGdKiZgI0ITUrWkWWCLcKoPQXQp6CEHQpgXcoAA=;
        b=G0APpwxTOqFP+hiy9f0KYyP7DtrGweX0qPYtcpCAo52ZWka+LEOu2mmbjcSuoSLTWBWcaj
        ZHmBbzBUV4ZAaADg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <Yh9QdtWL+MBXTY7x@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2022-03-01 21:42:17 [-0800], Paul E. McKenney wrote:
> There have been several different things requiring various pieces of RCU
> to be running quite early, and I need to do a bit of code archaeology to
> check this out.  One of these is what forced me to move to expedited grace
> periods once the scheduler started.  And the expedited grace periods do
> require the timers be working, at least in their current form.

expedited as in synchronize_rcu_expedited()? Because we don't do this
but then only after boot so it probably doesn't change a thing and makes
other complicated.

> I vaguely recall tracing requiring call_rcu() extremely early (as
> in before rcu_init() is called), but that was not a problem because
> there was no requirement that the callback be invoked before the first
> couple of sets of initcalls had completed.  The only challenge in this
> case was to avoid stomping on the callback lists at rcu_init() time,
> no timers required.

Okay.

> One straightforward approach would be to choose the call site of the
> rcu_tasks_initiate_self_tests() function based on whether or not the
> kernel was built with CONFIG_PREEMPT_RT.

But then we have this change between RT and !RT due to other
limitations. But my understanding is correct that RT does not have a
working synchronize_rcu() in an early_initcall() while !RT does, right?

> The other thought that comes to mind is that you may need the old-style
> softirq until ksoftirqd is spawned.  I doubt that real-time response is
> a big deal that early in boot.  ;-)

Puh. Given that the whole infrastructure is not prepared for that it is
probably more than a few lines plus a conditional jump in the IRQ
hot path. Also we do have scheduling at this point and IRQ-on/off works
which means possible dead locks because sleeping locks are acquired in
hard-IRQ context.

But let me summarize this: I did this:

|@@ -1600,6 +1600,7 @@ static noinline void __init kernel_init_
|
|        rcu_init_tasks_generic();
|        do_pre_smp_initcalls();
|+       rcu_tasks_initiate_self_tests();
|        lockup_detector_init();
|
|        smp_init();

To simply move the test from rcu_init_tasks_generic() to after
do_pre_smp_initcalls(). If we can't move rcu_init_tasks_generic() after
do_pre_smp_initcalls() or at least the test part because we need working
synchronize_rcu() in early_initcall() then I need to move the RT
requirements before. Simple ;)

The requirements are:

--- a/init/main.c
+++ b/init/main.c
@@ -1598,6 +1601,9 @@ static noinline void __init kernel_init_freeable(void)
 
        init_mm_internals();
 
+       spawn_ksoftirqd();
+       irq_work_init_threads();
+
        rcu_init_tasks_generic();
        do_pre_smp_initcalls();
        lockup_detector_init();

spawn_ksoftirqd() is what I mentioned. What I just figured out is
irq_work_init_threads() due to
	call_rcu_tasks_iw_wakeup()

I can't move this to hard-IRQ context because it invokes wake_up() which
acquires sleeping locks. If you say that rtp->cbs_wq has only one waiter
and something like rcuwait_wait_event() / rcuwait_wake_up() would work
as well then call_rcu_tasks_iw_wakeup() could be lifter to hard-IRQ
context and we need to worry only about spawn_ksoftirqd() :)

> 							Thanx, Paul
> 

Sebastian
