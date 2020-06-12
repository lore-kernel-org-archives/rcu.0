Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE9C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19278207ED
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 19:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591989563;
	bh=eVeHPkyPScZsK0g9JqzFzU1bK/ULdIMua5/4Xl7TQBc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=iwC4Jt1gPmwtFjTPLUSmcYvLp++3a+c3I5pxcduk0FlEKYm9iOc4SrTXHJ0iG/lcE
	 LFOAha61RDOdHKd2hd1NOZ+SFipX6wVrPmADSNrySxboT3JZV9sVc+qtyed5d95u9+
	 KH5ORGkbDpHBF+OiFY01+dPbbWiXLX9ztQSzbjWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgFLTTW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLTTW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 15:19:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ECB520792;
        Fri, 12 Jun 2020 19:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591989561;
        bh=eVeHPkyPScZsK0g9JqzFzU1bK/ULdIMua5/4Xl7TQBc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LNk0rcTUJ5IrGOIA9enz+/813+ZulY29chmIZpXPamNOpTnYEGqAMxi2djvmO1KP7
         2mOP/jggO+Ex0HNGNjuthAZOOe1TfefwtmiHrfrSBnASpyiN4bs6HAtgs62QoiE9ki
         NuS5JfagTFYjZl/vwaA/EmVIfHg1X5WvAnqXO+sQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F02A3522658; Fri, 12 Jun 2020 12:19:21 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:19:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
Message-ID: <20200612191921.GA18255@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
 <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
 <871rmkzcc8.fsf@nanos.tec.linutronix.de>
 <87wo4cxubv.fsf@nanos.tec.linutronix.de>
 <20200612174953.GA19188@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612174953.GA19188@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 12, 2020 at 10:49:53AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
> > The idea of conditionally calling into rcu_irq_enter() only when RCU is
> > not watching turned out to be not completely thought through.
> > 
> > Paul noticed occasional premature end of grace periods in RCU torture
> > testing. Bisection led to the commit which made the invocation of
> > rcu_irq_enter() conditional on !rcu_is_watching().
> > 
> > It turned out that this conditional breaks RCU assumptions about the idle
> > task when the scheduler tick happens to be a nested interrupt. Nested
> > interrupts can happen when the first interrupt invokes softirq processing
> > on return which enables interrupts. If that nested tick interrupt does not
> > invoke rcu_irq_enter() then the nest accounting in RCU claims that this is
> > the first interrupt which might mark a quiescient state and end grace
> > periods prematurely.
> 
> For this last sentence, how about the following?
> 
> If that nested tick interrupt does not invoke rcu_irq_enter() then the
> RCU's irq-nesting checks will believe that this interrupt came directly
> from idle, which will cause RCU to report a quiescent state.  Because
> this interrupt instead came from a softirq handler which might have
> been executing an RCU read-side critical section, this can cause the
> grace period to end prematurely.
> 
> > Change the condition from !rcu_is_watching() to is_idle_task(current) which
> > enforces that interrupts in the idle task unconditionally invoke
> > rcu_irq_enter() independent of the RCU state.
> > 
> > This is also correct vs. user mode entries in NOHZ full scenarios because
> > user mode entries bring RCU out of EQS and force the RCU irq nesting state
> > accounting to nested. As only the first interrupt can enter from user mode
> > a nested tick interrupt will enter from kernel mode and as the nesting
> > state accounting is forced to nesting it will not do anything stupid even
> > if rcu_irq_enter() has not been invoked.
> 
> On the testing front, just like with my busted patch yesterday, this
> patch breaks the TASKS03 rcutorture scenario by preventing the Tasks
> RCU grace periods from ever completing.  However, this is an unusual
> configuration with NO_HZ_FULL and one CPU actually being nohz_full.
> The more conventional TASKS01 and TASKS02 scenarios do just fine.
> 
> I will therefore address this issue in a follow-on patch.

I should add that -your- patch from yesterday did -not- cause this
problem, in case that is of interest.

							Thanx, Paul

> > Fixes: 3eeec3858488 ("x86/entry: Provide idtentry_entry/exit_cond_rcu()")
> > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
> Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
> 
> > ---
> >  arch/x86/entry/common.c |   35 ++++++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 7 deletions(-)
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -557,14 +557,34 @@ bool noinstr idtentry_enter_cond_rcu(str
> >  		return false;
> >  	}
> >  
> > -	if (!__rcu_is_watching()) {
> > +	/*
> > +	 * If this entry hit the idle task invoke rcu_irq_enter() whether
> > +	 * RCU is watching or not.
> > +	 *
> > +	 * Interupts can nest when the first interrupt invokes softirq
> > +	 * processing on return which enables interrupts.
> > +	 *
> > +	 * Scheduler ticks in the idle task can mark quiescent state and
> > +	 * terminate a grace period, if and only if the timer interrupt is
> > +	 * not nested into another interrupt.
> > +	 *
> > +	 * Checking for __rcu_is_watching() here would prevent the nesting
> > +	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
> > +	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
> > +	 * assume that it is the first interupt and eventually claim
> > +	 * quiescient state and end grace periods prematurely.
> > +	 *
> > +	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
> > +	 * consistent.
> > +	 *
> > +	 * TINY_RCU does not support EQS, so let the compiler eliminate
> > +	 * this part when enabled.
> > +	 */
> > +	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
> >  		/*
> >  		 * If RCU is not watching then the same careful
> >  		 * sequence vs. lockdep and tracing is required
> >  		 * as in enter_from_user_mode().
> > -		 *
> > -		 * This only happens for IRQs that hit the idle
> > -		 * loop, i.e. if idle is not using MWAIT.
> >  		 */
> >  		lockdep_hardirqs_off(CALLER_ADDR0);
> >  		rcu_irq_enter();
> > @@ -576,9 +596,10 @@ bool noinstr idtentry_enter_cond_rcu(str
> >  	}
> >  
> >  	/*
> > -	 * If RCU is watching then RCU only wants to check
> > -	 * whether it needs to restart the tick in NOHZ
> > -	 * mode.
> > +	 * If RCU is watching then RCU only wants to check whether it needs
> > +	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
> > +	 * already contains a warning when RCU is not watching, so no point
> > +	 * in having another one here.
> >  	 */
> >  	instrumentation_begin();
> >  	rcu_irq_enter_check_tick();
