Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F2C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D74E8206A4
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 13:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgFLNzQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFLNzM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 09:55:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF27C03E96F;
        Fri, 12 Jun 2020 06:55:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjk97-0004ZH-Er; Fri, 12 Jun 2020 15:55:01 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B42B9100F5A; Fri, 12 Jun 2020 15:55:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
In-Reply-To: <871rmkzcc8.fsf@nanos.tec.linutronix.de>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72> <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com> <871rmkzcc8.fsf@nanos.tec.linutronix.de>
Date:   Fri, 12 Jun 2020 15:55:00 +0200
Message-ID: <87wo4cxubv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The idea of conditionally calling into rcu_irq_enter() only when RCU is
not watching turned out to be not completely thought through.

Paul noticed occasional premature end of grace periods in RCU torture
testing. Bisection led to the commit which made the invocation of
rcu_irq_enter() conditional on !rcu_is_watching().

It turned out that this conditional breaks RCU assumptions about the idle
task when the scheduler tick happens to be a nested interrupt. Nested
interrupts can happen when the first interrupt invokes softirq processing
on return which enables interrupts. If that nested tick interrupt does not
invoke rcu_irq_enter() then the nest accounting in RCU claims that this is
the first interrupt which might mark a quiescient state and end grace
periods prematurely.

Change the condition from !rcu_is_watching() to is_idle_task(current) which
enforces that interrupts in the idle task unconditionally invoke
rcu_irq_enter() independent of the RCU state.

This is also correct vs. user mode entries in NOHZ full scenarios because
user mode entries bring RCU out of EQS and force the RCU irq nesting state
accounting to nested. As only the first interrupt can enter from user mode
a nested tick interrupt will enter from kernel mode and as the nesting
state accounting is forced to nesting it will not do anything stupid even
if rcu_irq_enter() has not been invoked.

Fixes: 3eeec3858488 ("x86/entry: Provide idtentry_entry/exit_cond_rcu()")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -557,14 +557,34 @@ bool noinstr idtentry_enter_cond_rcu(str
 		return false;
 	}
 
-	if (!__rcu_is_watching()) {
+	/*
+	 * If this entry hit the idle task invoke rcu_irq_enter() whether
+	 * RCU is watching or not.
+	 *
+	 * Interupts can nest when the first interrupt invokes softirq
+	 * processing on return which enables interrupts.
+	 *
+	 * Scheduler ticks in the idle task can mark quiescent state and
+	 * terminate a grace period, if and only if the timer interrupt is
+	 * not nested into another interrupt.
+	 *
+	 * Checking for __rcu_is_watching() here would prevent the nesting
+	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
+	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
+	 * assume that it is the first interupt and eventually claim
+	 * quiescient state and end grace periods prematurely.
+	 *
+	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
+	 * consistent.
+	 *
+	 * TINY_RCU does not support EQS, so let the compiler eliminate
+	 * this part when enabled.
+	 */
+	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
 		 * as in enter_from_user_mode().
-		 *
-		 * This only happens for IRQs that hit the idle
-		 * loop, i.e. if idle is not using MWAIT.
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
@@ -576,9 +596,10 @@ bool noinstr idtentry_enter_cond_rcu(str
 	}
 
 	/*
-	 * If RCU is watching then RCU only wants to check
-	 * whether it needs to restart the tick in NOHZ
-	 * mode.
+	 * If RCU is watching then RCU only wants to check whether it needs
+	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
+	 * already contains a warning when RCU is not watching, so no point
+	 * in having another one here.
 	 */
 	instrumentation_begin();
 	rcu_irq_enter_check_tick();
