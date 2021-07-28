Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131AFC4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE066056C
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 18:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhG1SqI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 14:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230164AbhG1SqH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 14:46:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C943560525;
        Wed, 28 Jul 2021 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627497965;
        bh=W/CZzbC/8sxlfKBzOYRrCUM1dZR05o0e8QgeUfTCKWM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WPqPx0ZpjqQhCc4KWGHhepuJwH884v84nwkr8iUu04Y6uKFwYVo44h0OfppLUrthm
         rU85WXWpGW7R0F7tgIygipe2VQXoU/LpwnOu35BdesKm/pDmOd79gfXG/ImlS3hylw
         xS9yE04r7SiPbw56sNr9QFwJYvxb1hVfXE5fuu15FAGZxzAJO5M8PmN2MTLxBwYCA1
         0xRNpJlrKmIya4ando8/IMmUHsr0KtkLVF2nwADmxaTA981bETo/IwJPfIoFlf7aNh
         Y1IkFtIUL8egfyrQ+agkDRmthVA+ulbEyoR37FPhoTrRnumfh8k/NIkv3+7bT6rmVm
         UWf16I5t1u5lA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 92BF65C048D; Wed, 28 Jul 2021 11:46:05 -0700 (PDT)
Date:   Wed, 28 Jul 2021 11:46:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728184605.GI4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jul 28, 2021 at 10:58:08AM -0700, Linus Torvalds wrote:
> On Wed, Jul 28, 2021 at 10:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > +/*
> > + * Increment the current CPU's rcu_data structure's ->dynticks field
> > + * with ordering.  Return the new value.
> > + */
> > +static noinstr unsigned long rcu_dynticks_inc(int incby)
> > +{
> > +       return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> > +}
> 
> Maybe inline?

I bet the compiler does this already, but why give it the choice?
I will add inline.

> But more I reacted to how we sadly don't have percpu atomics. They'd
> be fairly easy to add on x86, but I guess it's not a huge deal.
> 
> And hey, if this is pretty much the only place that would use them, I
> guess that's not much of an issue.

I did a git grep for "atomic_.*this_cpu_ptr" in -rcu, and came up with
this:

	arch/s390/kernel/time.c:	atomic_t *sw_ptr = this_cpu_ptr(&clock_sync_word);
	arch/s390/kernel/time.c:	atomic_t *sw_ptr = this_cpu_ptr(&clock_sync_word);
	arch/x86/xen/spinlock.c:	atomic_t *nest_cnt = this_cpu_ptr(&xen_qlock_wait_nest);
	drivers/irqchip/irq-apple-aic.c:	atomic_andnot(irq_bit, this_cpu_ptr(&aic_vipi_enable));
	drivers/irqchip/irq-apple-aic.c:	atomic_or(irq_bit, this_cpu_ptr(&aic_vipi_enable));
	drivers/irqchip/irq-apple-aic.c:	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit)
	drivers/irqchip/irq-apple-aic.c:	enabled = atomic_read(this_cpu_ptr(&aic_vipi_enable));
	drivers/irqchip/irq-apple-aic.c:	firing = atomic_fetch_andnot(enabled, this_cpu_ptr(&aic_vipi_flag)) & enabled;
	kernel/events/core.c:	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
	kernel/events/core.c:	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
	kernel/rcu/rcuscale.c:	atomic_dec(this_cpu_ptr(&n_async_inflight));
	kernel/rcu/rcuscale.c:			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
	kernel/rcu/rcuscale.c:				atomic_inc(this_cpu_ptr(&n_async_inflight));
	kernel/rcu/tree.c:	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
	kernel/rcu/tree.c:	return !(atomic_read(this_cpu_ptr(&rcu_data.dynticks)) & 0x1);
	kernel/trace/ring_buffer.c:	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
	kernel/trace/ring_buffer.c:	atomic_dec(this_cpu_ptr(&checking));

Given that this mostly moves text from the first argument to the function
name, I suspect that we would need quite a few instances of any given
atomic operation to make the added lines for all the definitions and
the documentation worth it.  Maybe for atomic_read()?

	/**
	 * atomic_read_this_cpu - atomically read from this CPU's variable
	 * @p: Pointer to per-CPU variable.
	 *
	 * Do an atomic_read() from the current CPU's instance of the
	 * specified per-CPU variable.
	 */
	#define atomic_read_this_cpu(p) atomic_read(this_cpu_ptr(p))

But atomic_read_this_cpu(&rcu_data.dynticks) isn't all that much shorter
than atomic_read(this_cpu_ptr(&rcu_data.dynticks)).

							Thanx, Paul
