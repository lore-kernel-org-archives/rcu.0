Return-Path: <SRS0=g6Hr=7Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URG_BIZ,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A35C433DF
	for <rcu@archiver.kernel.org>; Thu, 11 Jun 2020 23:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909502078C
	for <rcu@archiver.kernel.org>; Thu, 11 Jun 2020 23:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591919664;
	bh=ecHjhTk2OUDvinD2Ye94HRxBLH7cQT2pTk9FPh29ju4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=njr/mAb97oHQK0L1oQCSRMGikXlZkGwJaji7qxfwRZprmaWghi+hhJwYhP1BeTHFR
	 fI7QSDV6gHRJ0aY5+0dUnz0iRoVXihSlZ4RZI4dG4T8A3R9U9+INZzSNoPbvxGcDYv
	 5sCUs3UDliwxjoYn0PjLB1QYsTMMla6b+E0+CPV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFKXyY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgFKXyY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Jun 2020 19:54:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629B920731;
        Thu, 11 Jun 2020 23:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591919663;
        bh=ecHjhTk2OUDvinD2Ye94HRxBLH7cQT2pTk9FPh29ju4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uUNnZlrRjwuidzGZvAARld7TF+Uyr4CLw2y+VzrRDaOlkjqCwyrvj1a+1+2yCTAto
         HbI6tNA2g7dN5I0zLlEUh1GEumTpTKoco9bezWk57RD46/aDpd8hu4zM0XY5fMD8ET
         hA5p27UIFjiWvGO8ARvGBi3UDNsQ33X5WYSqSjCE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4B02C35228C7; Thu, 11 Jun 2020 16:54:23 -0700 (PDT)
Date:   Thu, 11 Jun 2020 16:54:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     tglx@linutronix.de, luto@kernel.org, x86@kernel.org,
        frederic@kernel.org, rostedt@goodmis.org, joel@joelfernandes.org,
        mathieu.desnoyers@efficios.com, will@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH RFC] x86/entry: Ask RCU if it needs rcu_irq_{enter,exit}()
Message-ID: <20200611235423.GA32454@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611235305.GA32342@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 11, 2020 at 04:53:05PM -0700, Paul E. McKenney wrote:
> RCU needs to detect when one if its interrupt handlers interrupted an idle
> state, where an idle state is either the idle loop itself or nohz_full
> userspace execution.  When a CPU has been interrupted from one of these
> idle states, RCU can report a quiescent state, helping the current grace
> period to come to an end.
> 
> However, there are optimized kernel-entry paths where handlers that
> would normally be executed in interrupt context are instead executed
> directly from the base process context, but with interrupts disabled.
> When such a directly-executed handler is followed by softirq processing
> (which re-enables interrupts), it is possible that one of RCU's interrupt
> handlers will interrupt this softirq processing.  This situation can cause
> RCU to incorrectly assume that the CPU has passed through a quiescent
> state, when in fact the CPU is instead in the midst of softirq processing,
> and might well be within an RCU read-side critical section.  In that case,
> reporting a quiescent state can result in too-short RCU grace periods,
> leading to arbitrary memory corruption and a sharp degradation in the
> actuarial statistics of your kernel.
> 
> The fix is for the optimized kernel-entry paths to replace the current
> call to __rcu_is_watching() with a call to a new rcu_needs_irq_enter()
> function, which returns true iff RCU needs explicit calls to
> rcu_irq_enter() and rcu_irq_exit() surrounding the optimized invocation
> of the handler.  These explicit calls are never required in Tiny RCU,
> and in Tree RCU are required only if the CPU might have interrupted
> nohz_full userspace execution or the idle loop.  There is the usual
> precision/overhead tradeoff, with the current implementation majoring
> in low common-case overhead.
> 
> While in the area, the commit also returns rcu_is_cpu_rrupt_from_idle()
> to its original semantics.
> 
> This has been subjected only to very light rcutorture testing, so use
> appropriate caution.  The placement of the new rcu_needs_irq_enter()
> is not ideal, but the more natural include/linux/hardirq.h location has
> #include issues.

And if you want more details on how I got to this patch, please see below.

							Thanx, Paul

------------------------------------------------------------------------

Thomas supplied a patch and suggested that there be an RCU-supplied
rcu_needs_irq_enter() function that says whether the full
rcu_irq_enter()/rcu_irq_exit() dance is required.  The function needing
the dance is rcu_is_cpu_rrupt_from_idle().

Assumptions:

o	It would be simpler for idtentry_enter_cond_rcu() to check a
	new rcu_needs_irq_enter() function than to do a fragile check
	of "!__rcu_is_watching() || is_idle_task(current)".  Note also
	that this check does not account for expedited grace periods
	interacting with softirq handlers having interrupted nohz_full
	userspace execution.

	This assumption seems likely to hold.

o	If CONFIG_CONTEXT_TRACKING=y, assume that rcu_user_enter()
	and rcu_user_exit() might be invoked on any CPU.  Query in to
	Frederic on whether this can be more selective.

Functions of interest:

o	rcu_is_cpu_rrupt_from_idle().  See below.

o	__rcu_is_watching().  The only call to this will likely
	be eliminated.  If so, it can be removed.

o	idtentry_enter_cond_rcu().  Replace __rcu_is_watching()
	check with a check of rcu_needs_irq_enter().

o	idtentry_exit_cond_rcu().  No change.

o	rcu_irq_enter_check_tick().  Turn on tick for nohz_full
	CPUs when required.

o	rcu_irq_exit_check_preempt().  Straight lockdep validation.

Use cases for rcu_is_cpu_rrupt_from_idle():

o	rcu_sched_clock_irq(): If not interrupted from idle, need to
	ask the scheduler for help for ->urgent_qs request.

o	rcu_pending(): If a nohz_full CPU is interrupted from idle,
	don't raise_softirq() it.  Instead, let the grace-period
	kthread detect the quiescent state.

o	rcu_exp_handler() for PREEMPT_NONE kernels:  Directly report
	a quiescent state if interrupted from idle.

o	rcu_flavor_sched_clock_irq for PREEMPT kernels:  Report a
	voluntary context switch if interrupted from idle.  Here "idle"
	includes still in the kernel but on the way to/from nohz_full
	userspace execution.

o	rcu_flavor_sched_clock_irq for PREEMPT_NONE kernels:  Report a
	quiescent state if interrupted from idle.
	
In all of the above cases for NO_HZ_FULL kernels, "idle" includes still
in the kernel but on the way to/from nohz_full userspace execution.

Information available to rcu_needs_irq_enter():

o	IS_ENABLED(CONFIG_CONTEXT_TRACKING), which indicates that
	nohz_full userspace execution is possible, and that some
	CPUs might be invoking rcu_idle_enter() and rcu_idle_exit().

	There is also tick_nohz_full_cpu(), but it is not clear that if
	this returns false that the corresponding CPU is guaranteed not
	to be invoking rcu_idle_enter() and rcu_idle_exit().

o	is_idle_task(current), which returns true if the current task
	is an idle task.  Such tasks always need to execute
	rcu_irq_enter() and rcu_irq_exit().  Or, if instrumentation
	is prohibited, rcu_nmi_enter() and rcu_nmi_exit().

o	rdp->dynticks_nesting:	If non-zero, we are in process context,
	and don't need rcu_irq_enter() or rcu_irq_exit() regardless
	of other state.  But this requires that rcu_needs_irq_enter()
	be defined within Tree RCU, so it is not necessarily a win.

->	The simple approach is for rcu_needs_irq_enter() to return:

	!IS_ENABLED(CONFIG_TINY_RCU) &&
	(IS_ENABLED(CONFIG_CONTEXT_TRACKING) || is_idle_task(current))

	Except that Frederic points out context_tracking_enabled_cpu():

	!IS_ENABLED(CONFIG_TINY_RCU) &&
	(context_tracking_enabled_cpu(smp_processor_id()) || is_idle_task(current))

o	As a result, rcu_needs_irq_enter() might need to be defined
	outside of RCU to allow inlining and to avoid #include hell.
	One candidate location is include/linux/hardirq.h, the same
	place that rcu_irq_enter_check_tick() is defined.
