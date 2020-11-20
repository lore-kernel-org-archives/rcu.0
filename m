Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED0C56201
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5D822470
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgKTS5h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbgKTS5h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 13:57:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2AD22464;
        Fri, 20 Nov 2020 18:57:35 +0000 (UTC)
Date:   Fri, 20 Nov 2020 13:57:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120135733.0807c20f@gandalf.local.home>
In-Reply-To: <20201120181737.GA3301774@elver.google.com>
References: <20201118225621.GA1770130@elver.google.com>
        <20201118233841.GS1437@paulmck-ThinkPad-P72>
        <20201119125357.GA2084963@elver.google.com>
        <20201119151409.GU1437@paulmck-ThinkPad-P72>
        <20201119170259.GA2134472@elver.google.com>
        <20201119184854.GY1437@paulmck-ThinkPad-P72>
        <20201119193819.GA2601289@elver.google.com>
        <20201119213512.GB1437@paulmck-ThinkPad-P72>
        <20201120141928.GB3120165@elver.google.com>
        <20201120102613.3d18b90e@gandalf.local.home>
        <20201120181737.GA3301774@elver.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 20 Nov 2020 19:17:37 +0100
Marco Elver <elver@google.com> wrote:

> | # cat /sys/kernel/tracing/recursed_functions
> | trace_selftest_test_recursion_func+0x34/0x48:   trace_selftest_dynamic_test_func+0x4/0x28
> | el1_irq+0xc0/0x180:     gic_handle_irq+0x4/0x108
> | gic_handle_irq+0x70/0x108:      __handle_domain_irq+0x4/0x130
> | __handle_domain_irq+0x7c/0x130: irq_enter+0x4/0x28
> | trace_rcu_dyntick+0x168/0x190:  rcu_read_lock_sched_held+0x4/0x98
> | rcu_read_lock_sched_held+0x30/0x98:     rcu_read_lock_held_common+0x4/0x88
> | rcu_read_lock_held_common+0x50/0x88:    rcu_lockdep_current_cpu_online+0x4/0xd0
> | irq_enter+0x1c/0x28:    irq_enter_rcu+0x4/0xa8
> | irq_enter_rcu+0x3c/0xa8:        irqtime_account_irq+0x4/0x198
> | irq_enter_rcu+0x44/0xa8:        preempt_count_add+0x4/0x1a0
> | trace_hardirqs_off+0x254/0x2d8: __srcu_read_lock+0x4/0xa0
> | trace_hardirqs_off+0x25c/0x2d8: rcu_irq_enter_irqson+0x4/0x78
> | trace_rcu_dyntick+0xd8/0x190:   __traceiter_rcu_dyntick+0x4/0x80
> | trace_hardirqs_off+0x294/0x2d8: rcu_irq_exit_irqson+0x4/0x78
> | trace_hardirqs_off+0x2a0/0x2d8: __srcu_read_unlock+0x4/0x88

These look normal. They happen when an interrupt occurs while tracing
something with interrupts enabled, and the interrupt traces a function
before it sets the "preempt_count" to reflect that its in a new context.

That is:

	normal_context:
		func_A();
			trace_function();
				<interrupt>
					irq_enter();
						trace_function()
							if (int_interrupt())
							 [returns false]

					set_preempt_count (in interrupt)

And the recursion detection is tricked into thinking it recursed in the
same context. The lastest code handles this by allowing one level of
recursion:

 https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b02414c8f045ab3b9afc816c3735bc98c5c3d262

-- Steve

