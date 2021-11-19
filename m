Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A668C433F5
	for <rcu@archiver.kernel.org>; Fri, 19 Nov 2021 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FF461179
	for <rcu@archiver.kernel.org>; Fri, 19 Nov 2021 14:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhKSOHK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:07:10 -0500
Received: from foss.arm.com ([217.140.110.172]:52002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235173AbhKSOHJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Nov 2021 09:07:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8A5ED1;
        Fri, 19 Nov 2021 06:04:07 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66C663F5A1;
        Fri, 19 Nov 2021 06:04:06 -0800 (PST)
Date:   Fri, 19 Nov 2021 14:04:04 +0000
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
Message-ID: <20211119140404.GC25912@lakrids.cambridge.arm.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
 <20211116082450.10357-2-kernelfans@gmail.com>
 <20211117113854.GA41542@C02TD0UTHF1T.local>
 <YZcFXJmrbY+oac0f@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZcFXJmrbY+oac0f@piliu.users.ipa.redhat.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 19, 2021 at 10:01:00AM +0800, Pingfan Liu wrote:
> On Wed, Nov 17, 2021 at 11:38:54AM +0000, Mark Rutland wrote:
> > On Tue, Nov 16, 2021 at 04:24:47PM +0800, Pingfan Liu wrote:
> > > Linux kernel places strict semantics between NMI and maskable interrupt.
> > > So does the RCU component, else deadlock may happen. But the current
> > > arm64 entry code can partially breach this rule through calling
> > > rcu_nmi_enter().
> > > 
> > > ***  how a deadlock can happen if NMI mistaken as IRQ  ***
> > > 
> > >     rcu_nmi_enter()
> > >     {
> > > 
> > >         if (rcu_dynticks_curr_cpu_in_eqs()) {
> > > 
> > >         	if (!in_nmi())
> > >         		rcu_dynticks_task_exit();
> > >                 ...
> > >         	if (!in_nmi()) {
> > >         		instrumentation_begin();
> > >         		rcu_cleanup_after_idle();
> > >         		instrumentation_end();
> > >         	}
> > >                 ...
> > >         } else if (!in_nmi()) {
> > >         	instrumentation_begin();
> > >         	rcu_irq_enter_check_tick();
> > >         }
> > > 
> > >     }
> > > 
> > > If a NMI is mistaken as a maskable interrupt, rcu_irq_enter_check_tick()
> > > can hit a deadlock, which is demonstrated by the following scenario:
> > > 
> > >     note_gp_changes() runs in a task context
> > >     {
> > >        local_irq_save(flags); // this protects against irq, but not NMI
> > 
> > Note: speecifically, this masks IRQs via ICC_PMR_EL1.
> > 
> > >        rnp = rdp->mynode;
> > >        ...
> > >        raw_spin_trylock_rcu_node(rnp)
> > >                                   -------> broken in by (p)NMI, without taking __nmi_enter()
> > 
> > AFAICT the broken case described here *cannot* happen.
> > 
> > If we take a pNMI here, we'll go:
> > 
> >   el1h_64_irq()
> >   -> el1h64_irq_handler()
> >   -> el1_interrupt()
> > 
> > ... where el1_interrupt is:
> > 
> > | static void noinstr el1_interrupt(struct pt_regs *regs,
> > |                                   void (*handler)(struct pt_regs *)) 
> > | {
> > |         write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> > | 
> > |         if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> > |                 __el1_pnmi(regs, handler);
> > |         else
> > |                 __el1_irq(regs, handler);
> > | } 
> > 
> > ... and interrupts_enabled() is:
> > 
> > | #define interrupts_enabled(regs)                        \
> > |        (!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
> > 
> > ... and irqs_priority_unmasked is:
> > 
> > | #define irqs_priority_unmasked(regs)                                    \
> > |         (system_uses_irq_prio_masking() ?                               \
> > |                 (regs)->pmr_save == GIC_PRIO_IRQON :                    \
> > |                 true)
> > 
> > ... irqs_priority_unmasked(regs) *must* return false for this case,
> > since the local_irq_save() above must have set the PMR to
> > GIC_PRIO_IRQOFF in the interrupted context.
> > 
> > Thus, we *must* call __el1_pnmi() in this case, where __el1_pnmi() is:
> > 
> 
> Yes, you are right. And I made a mistake to think it will call
> __el1_irq()

> As above, I made a mistake about the condition hence the code path.
> There is no problem in this case through calling __el1_pnmi()
> 
> Sorry for the false alarm and thank you again for your detailed
> explaination.

No worries; thanks for confirming this was a false alarm. Glad we're now
on the same page. :)

Likewise, thanks for reporting what you thought was an issue; having
more eyes on this is always good!

Thanks,
Mark.
