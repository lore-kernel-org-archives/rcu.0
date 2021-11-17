Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918EAC433EF
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 11:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FC36128B
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 11:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhKQLmC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:42:02 -0500
Received: from foss.arm.com ([217.140.110.172]:55628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236837AbhKQLmB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 06:42:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A1A1FB;
        Wed, 17 Nov 2021 03:39:03 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.46.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43E953F70D;
        Wed, 17 Nov 2021 03:39:01 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:38:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>, rcu@vger.kernel.org
Subject: Re: [PATCHv3 1/4] arm64: entry: judge nmi ealier to avoid deadlock
 in RCU
Message-ID: <20211117113854.GA41542@C02TD0UTHF1T.local>
References: <20211116082450.10357-1-kernelfans@gmail.com>
 <20211116082450.10357-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116082450.10357-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 16, 2021 at 04:24:47PM +0800, Pingfan Liu wrote:
> Linux kernel places strict semantics between NMI and maskable interrupt.
> So does the RCU component, else deadlock may happen. But the current
> arm64 entry code can partially breach this rule through calling
> rcu_nmi_enter().
> 
> ***  how a deadlock can happen if NMI mistaken as IRQ  ***
> 
>     rcu_nmi_enter()
>     {
> 
>         if (rcu_dynticks_curr_cpu_in_eqs()) {
> 
>         	if (!in_nmi())
>         		rcu_dynticks_task_exit();
>                 ...
>         	if (!in_nmi()) {
>         		instrumentation_begin();
>         		rcu_cleanup_after_idle();
>         		instrumentation_end();
>         	}
>                 ...
>         } else if (!in_nmi()) {
>         	instrumentation_begin();
>         	rcu_irq_enter_check_tick();
>         }
> 
>     }
> 
> If a NMI is mistaken as a maskable interrupt, rcu_irq_enter_check_tick()
> can hit a deadlock, which is demonstrated by the following scenario:
> 
>     note_gp_changes() runs in a task context
>     {
>        local_irq_save(flags); // this protects against irq, but not NMI

Note: speecifically, this masks IRQs via ICC_PMR_EL1.

>        rnp = rdp->mynode;
>        ...
>        raw_spin_trylock_rcu_node(rnp)
>                                   -------> broken in by (p)NMI, without taking __nmi_enter()

AFAICT the broken case described here *cannot* happen.

If we take a pNMI here, we'll go:

  el1h_64_irq()
  -> el1h64_irq_handler()
  -> el1_interrupt()

... where el1_interrupt is:

| static void noinstr el1_interrupt(struct pt_regs *regs,
|                                   void (*handler)(struct pt_regs *)) 
| {
|         write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
| 
|         if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
|                 __el1_pnmi(regs, handler);
|         else
|                 __el1_irq(regs, handler);
| } 

... and interrupts_enabled() is:

| #define interrupts_enabled(regs)                        \
|        (!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))

... and irqs_priority_unmasked is:

| #define irqs_priority_unmasked(regs)                                    \
|         (system_uses_irq_prio_masking() ?                               \
|                 (regs)->pmr_save == GIC_PRIO_IRQON :                    \
|                 true)

... irqs_priority_unmasked(regs) *must* return false for this case,
since the local_irq_save() above must have set the PMR to
GIC_PRIO_IRQOFF in the interrupted context.

Thus, we *must* call __el1_pnmi() in this case, where __el1_pnmi() is:

| static __always_inline void __el1_pnmi(struct pt_regs *regs,
|                                        void (*handler)(struct pt_regs *)) 
| {
|         arm64_enter_nmi(regs);
|         do_interrupt_handler(regs, handler);
|         arm64_exit_nmi(regs);
| }

Note that arm64_{enter,exit}_nmi() handle the __nmi_{enter,exit}() calls around
do_interupt_handler().

>                                            rcu_nmi_enter()
>                                             ->__rcu_irq_enter_check_tick()
>                                                ->raw_spin_lock_rcu_node(rdp->mynode);
>                                                    deadlock happens!!!
> 
>     }

As above, I don't think this can go wrong as you describe, and don't believe
that this can deadlock.

> *** On arm64, how pNMI mistaken as IRQ ***
> 
> On arm64, pNMI is an analogue to NMI. In essence, it is a higher
> priority interrupt but not disabled by local_irq_disable().
> 
> In current implementation
> 1) If a pNMI from a context where IRQs were masked, it can be recognized
>    as nmi, and calls __nmi_enter() immediately. This is no problem.

Agreed, this case works correctly.

> 2) But it causes trouble if a pNMI from a context where IRQs were
>    unmasked, and temporarily regarded as maskable interrupt.  It is not
>    treated as NMI, i.e. calling nmi_enter() until reading from GIC.
> 
>     __el1_irq()
>     {
>       irq_enter_rcu()   ----> hit the deadlock bug

What is "the deadlock bug"? The example you had above was for a context where
IRQs were *masked*, which is a different case.

Consider that if this can happen for a context where IRQs are unmasked
it means that we would also deadlock *when taking a regular IRQ*.

I do not beleive that this can deadlock as described. I don't see this
as any different from a sequence such as:

  < run in a context with IRQs unmasked>
    < take a regular IRQ >
      < take a pNMI within the IRQ handling flow >

... e.g. taking a pNMI when handling a spurious regular IRQ.

>         gic_handle_nmi()
>           nmi_enter()
>           nmi_exit()
>       irq_exit_rcu()
>     }
> 
> *** Remedy ***
> 
> If the irqchip level exposes an interface for detecting pNMI to arch level
> code, it can meet the requirement at this early stage. That is the
> interface (*interrupt_is_nmi)() in this patch.

As above, I do not believe that this is necessary for the current pseudo-NMI
scheme.

Are you seeing a deadlock in practice, or is this something you've found by
inspection?

Thanks,
Mark.

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> Cc: rcu@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/irq.h     |  1 +
>  arch/arm64/kernel/entry-common.c | 10 +++++++++-
>  arch/arm64/kernel/irq.c          | 18 ++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index fac08e18bcd5..f3eb13bfa65e 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -11,6 +11,7 @@ struct pt_regs;
>  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  #define set_handle_irq	set_handle_irq
>  int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
> +int set_nmi_discriminator(bool (*discriminator)(void));
>  
>  static inline int nr_legacy_irqs(void)
>  {
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index f7408edf8571..5a1a5dd66d04 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -260,6 +260,14 @@ static void do_interrupt_handler(struct pt_regs *regs,
>  
>  extern void (*handle_arch_irq)(struct pt_regs *);
>  extern void (*handle_arch_fiq)(struct pt_regs *);
> +extern bool (*interrupt_is_nmi)(void);
> +
> +static inline bool is_in_pnmi(struct pt_regs *regs)
> +{
> +	if (!interrupts_enabled(regs) || (*interrupt_is_nmi)())
> +		return true;
> +	return false;
> +}
>  
>  static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
>  				      unsigned int esr)
> @@ -454,7 +462,7 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
>  {
>  	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
>  
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && is_in_pnmi(regs))
>  		__el1_pnmi(regs, handler);
>  	else
>  		__el1_irq(regs, handler);
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index bda49430c9ea..fabed09ed966 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -81,8 +81,14 @@ static void default_handle_fiq(struct pt_regs *regs)
>  	panic("FIQ taken without a root FIQ handler\n");
>  }
>  
> +static bool default_nmi_discriminator(void)
> +{
> +	return false;
> +}
> +
>  void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
>  void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
> +bool (*interrupt_is_nmi)(void) __ro_after_init = default_nmi_discriminator;
>  
>  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
> @@ -104,6 +110,18 @@ int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI)
> +
> +int __init set_nmi_discriminator(bool (*discriminator)(void))
> +{
> +	if (interrupt_is_nmi != default_nmi_discriminator)
> +		return -EBUSY;
> +
> +	interrupt_is_nmi = discriminator;
> +	return 0;
> +}
> +#endif
> +
>  void __init init_IRQ(void)
>  {
>  	init_irq_stacks();
> -- 
> 2.31.1
> 
