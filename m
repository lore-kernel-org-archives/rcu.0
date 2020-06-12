Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FB1C433DF
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 12:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0DB2081A
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 12:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFLMk4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFLMk4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 08:40:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4DC03E96F;
        Fri, 12 Jun 2020 05:40:56 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjizA-0003TQ-Rr; Fri, 12 Jun 2020 14:40:40 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AA722100F5A; Fri, 12 Jun 2020 14:40:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] x86/entry: Ask RCU if it needs rcu_irq_{enter,exit}()
In-Reply-To: <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
References: <20200611235305.GA32342@paulmck-ThinkPad-P72> <CALCETrWo-zpiDsYGtKvm8LzW6CQ5L19a3+Ag_9g8aL4wHaJj9g@mail.gmail.com>
Date:   Fri, 12 Jun 2020 14:40:39 +0200
Message-ID: <871rmkzcc8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
>
> This is saying we were idle and __rcu_is_watching() correctly returned
> false.  We got sysvec_apic_timer_interrupt(), which did
> rcu_irq_enter() and then turned on IRQs for softirq processing.  Then
> we got sysvec_call_function_single() inside that, and
> sysvec_call_function_single() noticed that RCU was already watching
> and did *not* call rcu_irq_enter().  And, if
> sysvec_call_function_single() does rcu_is_cpu_rrupt_from_idle(), it
> will return true.  So the issue is that RCU thinks that, since it
>
>
>> +static __always_inline bool rcu_needs_irq_enter(void)
>> +{
>> +       return !IS_ENABLED(CONFIG_TINY_RCU) &&
>> +               (context_tracking_enabled_cpu(smp_processor_id()) || is_idle_task(current));
>> +}
>
> x86 shouldn't need this context tracking check -- we won't even call
> this if we came from user mode, and we make sure we never run with
> IRQs on when we're in CONTEXT_USER.

As I told Paul already, it's broken.

> I think my preference would be to fix this with something more like
> tglx's patch but with an explanation:

Yes, explanation is definitely required :)

> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index f0b657097a2a..93fd9d6fe033 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -571,7 +571,7 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
>                 return false;
>         }
>
> -       if (!__rcu_is_watching()) {
> +       if (!__rcu_is_watching() || is_idle_task(current)) {

Actually that __rcu_is_watching() check is pointless because this can
only return false when current is the idle task. If the entry came from
user mode then this path is not taken. Entry from user mode with NOHZ
full does:

  enter_from_user_mode()
    user_exit_irqoff()
      __context_tracking_exit(CONTEXT_USER)
         rcu_user_exit()
           rcu_eqs_exit(1)
       	      WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);

So if an interrupt hits the kernel after enabling interrupts then:

  1) RCU is watching and out of EQS
  2) The dynticks_nmi_nesting counter is not longer relevant

That remains that way until returning to user or scheduling out to idle
which means:

     if (is_idle_task(current))

is completely sufficient. And we don't care about unconditional
rcu_irq_enter() in this case. If idle triggers a #PF which wants to
sleep then the RCU state is the least of our worries.

Thanks,

        tglx

