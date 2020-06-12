Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418D1C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272C8206A4
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFLOry (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgFLOrx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 10:47:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C31BC03E96F;
        Fri, 12 Jun 2020 07:47:53 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjky9-0005Nb-33; Fri, 12 Jun 2020 16:47:45 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 71061100F5A; Fri, 12 Jun 2020 16:47:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
In-Reply-To: <20200612142621.GA8009@lenoir>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72> <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com> <871rmkzcc8.fsf@nanos.tec.linutronix.de> <87wo4cxubv.fsf@nanos.tec.linutronix.de> <20200612142621.GA8009@lenoir>
Date:   Fri, 12 Jun 2020 16:47:44 +0200
Message-ID: <87tuzgxrvz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> On Fri, Jun 12, 2020 at 03:55:00PM +0200, Thomas Gleixner wrote:
>> The idea of conditionally calling into rcu_irq_enter() only when RCU is
>> not watching turned out to be not completely thought through.
>> 
>> Paul noticed occasional premature end of grace periods in RCU torture
>> testing. Bisection led to the commit which made the invocation of
>> rcu_irq_enter() conditional on !rcu_is_watching().
>> 
>> It turned out that this conditional breaks RCU assumptions about the idle
>> task when the scheduler tick happens to be a nested interrupt. Nested
>> interrupts can happen when the first interrupt invokes softirq processing
>> on return which enables interrupts. If that nested tick interrupt does not
>> invoke rcu_irq_enter() then the nest accounting in RCU claims that this is
>> the first interrupt which might mark a quiescient state and end grace
>> periods prematurely.
>> 
>> Change the condition from !rcu_is_watching() to is_idle_task(current) which
>> enforces that interrupts in the idle task unconditionally invoke
>> rcu_irq_enter() independent of the RCU state.
>> 
>> This is also correct vs. user mode entries in NOHZ full scenarios because
>> user mode entries bring RCU out of EQS and force the RCU irq nesting state
>> accounting to nested. As only the first interrupt can enter from user mode
>> a nested tick interrupt will enter from kernel mode and as the nesting
>> state accounting is forced to nesting it will not do anything stupid even
>> if rcu_irq_enter() has not been invoked.
>> 
>> Fixes: 3eeec3858488 ("x86/entry: Provide idtentry_entry/exit_cond_rcu()")
>> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>
> So, in the end the call to rcu_irq_enter() in irq_enter() is going to
> be useless in x86, right?

x86 is not calling irq_enter() anymore. It's using irq_enter_rcu().
