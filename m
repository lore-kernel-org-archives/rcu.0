Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B867FC433F5
	for <rcu@archiver.kernel.org>; Thu,  3 Mar 2022 04:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiCCEhi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Mar 2022 23:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiCCEhh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Mar 2022 23:37:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A01D119F21
        for <rcu@vger.kernel.org>; Wed,  2 Mar 2022 20:36:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BF08617B7
        for <rcu@vger.kernel.org>; Thu,  3 Mar 2022 04:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D331C340ED;
        Thu,  3 Mar 2022 04:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646282211;
        bh=4Bfe5PrsYFxmBkkuq/iponVa2IrFGvOnLgHOakGIX0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TsWC0J27/XYMUSphyQuXlsLRPBTMbxsCfcvOTnTxWK5MfLG2Psv9Q0u+K4lRoD+ip
         B9FhAWzY8J6iEMRTtf6OH5koOw6pKS/eDSHcuUpimBNOlrc7I9zujVD3dFaZQHSdX+
         Ri6zc9Z0kikA/DJSYhAVUsq8oQKc6CqBVN2WPhlGX4UwgySI/DpL2NN++aktbzgCJN
         PivB0E6IkGy9fnqwQVEULWX6DIezZH7XIX0LqyiDbun//xyfnTmNchWj5EFXG3Ij9p
         MsthhhTvcKSIRKIuhbgquvAXJLvuLIA6EPZaUO610gbPjp3pvBoNpJIPjufQZEiJ3e
         8LMwFW5l7G9SQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03E935C0A40; Wed,  2 Mar 2022 20:36:51 -0800 (PST)
Date:   Wed, 2 Mar 2022 20:36:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh9QdtWL+MBXTY7x@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 02, 2022 at 12:09:42PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-01 21:42:17 [-0800], Paul E. McKenney wrote:
> > There have been several different things requiring various pieces of RCU
> > to be running quite early, and I need to do a bit of code archaeology to
> > check this out.  One of these is what forced me to move to expedited grace
> > periods once the scheduler started.  And the expedited grace periods do
> > require the timers be working, at least in their current form.
> 
> expedited as in synchronize_rcu_expedited()? Because we don't do this
> but then only after boot so it probably doesn't change a thing and makes
> other complicated.

Expedited as in both synchronize_rcu_expedited() on the one hand and
also synchronize_rcu() between the time that the scheduler is active and
RCU has spawned its kthreads (AKA the "mid-boot dead zone").  I agree
that the former is not important for you, especially if you boot with
rcupdate.rcu_normal=1.  But the mid-boot dead zone uses expedited grace
periods because at that point in the process, the normal grace period
cannot function.

> > I vaguely recall tracing requiring call_rcu() extremely early (as
> > in before rcu_init() is called), but that was not a problem because
> > there was no requirement that the callback be invoked before the first
> > couple of sets of initcalls had completed.  The only challenge in this
> > case was to avoid stomping on the callback lists at rcu_init() time,
> > no timers required.
> 
> Okay.
> 
> > One straightforward approach would be to choose the call site of the
> > rcu_tasks_initiate_self_tests() function based on whether or not the
> > kernel was built with CONFIG_PREEMPT_RT.
> 
> But then we have this change between RT and !RT due to other
> limitations. But my understanding is correct that RT does not have a
> working synchronize_rcu() in an early_initcall() while !RT does, right?

From what you are telling me, yes, right now RT's synchronize_rcu()
breaks in the mid-boot dead zone, but !RT's operates normally.

> > The other thought that comes to mind is that you may need the old-style
> > softirq until ksoftirqd is spawned.  I doubt that real-time response is
> > a big deal that early in boot.  ;-)
> 
> Puh. Given that the whole infrastructure is not prepared for that it is
> probably more than a few lines plus a conditional jump in the IRQ
> hot path. Also we do have scheduling at this point and IRQ-on/off works
> which means possible dead locks because sleeping locks are acquired in
> hard-IRQ context.

This does need to work.  But let me see what you have in the following
paragraphs.

> But let me summarize this: I did this:
> 
> |@@ -1600,6 +1600,7 @@ static noinline void __init kernel_init_
> |
> |        rcu_init_tasks_generic();
> |        do_pre_smp_initcalls();
> |+       rcu_tasks_initiate_self_tests();
> |        lockup_detector_init();
> |
> |        smp_init();
> 
> To simply move the test from rcu_init_tasks_generic() to after
> do_pre_smp_initcalls(). If we can't move rcu_init_tasks_generic() after
> do_pre_smp_initcalls() or at least the test part because we need working
> synchronize_rcu() in early_initcall() then I need to move the RT
> requirements before. Simple ;)

As long as RT confines itself to configurations that do not need a
working synchronize_rcu() in the intervening code, yes, simple.  ;-)

> The requirements are:
> 
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1598,6 +1601,9 @@ static noinline void __init kernel_init_freeable(void)
>  
>         init_mm_internals();
>  
> +       spawn_ksoftirqd();
> +       irq_work_init_threads();
> +
>         rcu_init_tasks_generic();
>         do_pre_smp_initcalls();
>         lockup_detector_init();
> 
> spawn_ksoftirqd() is what I mentioned. What I just figured out is
> irq_work_init_threads() due to
> 	call_rcu_tasks_iw_wakeup()
> 
> I can't move this to hard-IRQ context because it invokes wake_up() which
> acquires sleeping locks. If you say that rtp->cbs_wq has only one waiter
> and something like rcuwait_wait_event() / rcuwait_wake_up() would work
> as well then call_rcu_tasks_iw_wakeup() could be lifter to hard-IRQ
> context and we need to worry only about spawn_ksoftirqd() :)

OK, I was expecting that the swait_event_timeout_exclusive() call from
synchronize_rcu_expedited_wait_once() would be the problem.  Are you
saying that this swait_event_timeout_exclusive() works fine?  Or are you
instead saying that the call_rcu_tasks_iw_wakeup() issues cause trouble
before that swait_event_timeout_exclusive() gets a chance to cause its
own trouble?

Either way, it sounds like that irq_work_queue(&rtpcp->rtp_irq_work) in
call_rcu_tasks_generic() needs some adjustment to work in RT.  This should
be doable.  Given this, and given that the corresponding diagnostic
function rcu_tasks_verify_self_tests() is a late_initcall() function,
you don't need to move the call to rcu_init_tasks_generic(), correct?

Back over to you so that I can learn what I am still missing.  ;-)

							Thanx, Paul
