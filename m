Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89DCC433EF
	for <rcu@archiver.kernel.org>; Fri, 19 Nov 2021 02:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7B161AA7
	for <rcu@archiver.kernel.org>; Fri, 19 Nov 2021 02:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhKSCEL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhKSCEJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Nov 2021 21:04:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D1C061574
        for <rcu@vger.kernel.org>; Thu, 18 Nov 2021 18:01:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 206so2186437pgb.4
        for <rcu@vger.kernel.org>; Thu, 18 Nov 2021 18:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlW2Zy9ay7isdEdR2sJFBb6Yrxl6VhtNhx4HmZuVK6A=;
        b=GZXlqQ5vzxixsSISTPtEuVd2qQB14SXiXP6iIubg1eHhfPllOJxfGbaUJhRZNxIt8f
         xvwbGQa9ttfVwNd5Mh0XUFEbIuejrr6nnae4JyVF4ibsnOOenzmPQk0ygRJZcSGoIjXb
         aHndH1EdBkkjTsaR+c716bGFxWwCzyPYJzqTnTpc1tO7sp74y0VTZlmE0agKbZASv1zg
         fv0vLsBtWpqjw6uqpK5BVrSY86GHI/u1YhkBn+DvhZu3aWGuQ6AQ0SpEyFJFIYmxB5gq
         9TiGqihygqN/kv/+A016xNIYDQIf5X3ELvkLmfKg/p5htuLvRI4a1N4vn4crfsppH4un
         8AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlW2Zy9ay7isdEdR2sJFBb6Yrxl6VhtNhx4HmZuVK6A=;
        b=g3WIGG/xMsU57jLwPa3eGtfPxCsN+4cS+yr95nX3VLXkX0tQ4gWeoOze0PCXM04QO6
         ZzufoQdI1lByAhXJZRDGaBxsTSmOd3e7ByY4Dagw6AgTiwodGawRy3z3D0/i7cw/E9cY
         lC+WVHYx55eR2VQ9QoNWUyb50/F25txr2Aq58QomvQzg2qz92vWRdEoZJYknTaCJkFGg
         DAhsnh7WY2WVOVPLre/mMXRJ7ShBenpxWRJA8thwHHZUerD7O9e5VMbGcPGvOLgtGaM+
         Ezg4Tb7Qe8ZEASLQH0lKrjps/ycXdaFbak281U0QDUkCoU7PjECTCQrh+EXhRQIe+p6V
         EZNQ==
X-Gm-Message-State: AOAM531sDB0MOg+peucFbNcAVIQtq94hXmZHTBMI1PLcpFZQTiLQbMdV
        UW8osjkX/BCyoxYamnZrEg==
X-Google-Smtp-Source: ABdhPJzM3RHWHbNCTfLAPff9NHMUdkIj19DZJhYtCam18/L58sI3C00nddIZQHSjQWBetdfIt5SHNA==
X-Received: by 2002:a63:334d:: with SMTP id z74mr14556252pgz.468.1637287268602;
        Thu, 18 Nov 2021 18:01:08 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c3sm850013pfm.177.2021.11.18.18.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 18:01:08 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:01:00 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <YZcFXJmrbY+oac0f@piliu.users.ipa.redhat.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
 <20211116082450.10357-2-kernelfans@gmail.com>
 <20211117113854.GA41542@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117113854.GA41542@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 11:38:54AM +0000, Mark Rutland wrote:
> On Tue, Nov 16, 2021 at 04:24:47PM +0800, Pingfan Liu wrote:
> > Linux kernel places strict semantics between NMI and maskable interrupt.
> > So does the RCU component, else deadlock may happen. But the current
> > arm64 entry code can partially breach this rule through calling
> > rcu_nmi_enter().
> > 
> > ***  how a deadlock can happen if NMI mistaken as IRQ  ***
> > 
> >     rcu_nmi_enter()
> >     {
> > 
> >         if (rcu_dynticks_curr_cpu_in_eqs()) {
> > 
> >         	if (!in_nmi())
> >         		rcu_dynticks_task_exit();
> >                 ...
> >         	if (!in_nmi()) {
> >         		instrumentation_begin();
> >         		rcu_cleanup_after_idle();
> >         		instrumentation_end();
> >         	}
> >                 ...
> >         } else if (!in_nmi()) {
> >         	instrumentation_begin();
> >         	rcu_irq_enter_check_tick();
> >         }
> > 
> >     }
> > 
> > If a NMI is mistaken as a maskable interrupt, rcu_irq_enter_check_tick()
> > can hit a deadlock, which is demonstrated by the following scenario:
> > 
> >     note_gp_changes() runs in a task context
> >     {
> >        local_irq_save(flags); // this protects against irq, but not NMI
> 
> Note: speecifically, this masks IRQs via ICC_PMR_EL1.
> 
> >        rnp = rdp->mynode;
> >        ...
> >        raw_spin_trylock_rcu_node(rnp)
> >                                   -------> broken in by (p)NMI, without taking __nmi_enter()
> 
> AFAICT the broken case described here *cannot* happen.
> 
> If we take a pNMI here, we'll go:
> 
>   el1h_64_irq()
>   -> el1h64_irq_handler()
>   -> el1_interrupt()
> 
> ... where el1_interrupt is:
> 
> | static void noinstr el1_interrupt(struct pt_regs *regs,
> |                                   void (*handler)(struct pt_regs *)) 
> | {
> |         write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> | 
> |         if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> |                 __el1_pnmi(regs, handler);
> |         else
> |                 __el1_irq(regs, handler);
> | } 
> 
> ... and interrupts_enabled() is:
> 
> | #define interrupts_enabled(regs)                        \
> |        (!((regs)->pstate & PSR_I_BIT) && irqs_priority_unmasked(regs))
> 
> ... and irqs_priority_unmasked is:
> 
> | #define irqs_priority_unmasked(regs)                                    \
> |         (system_uses_irq_prio_masking() ?                               \
> |                 (regs)->pmr_save == GIC_PRIO_IRQON :                    \
> |                 true)
> 
> ... irqs_priority_unmasked(regs) *must* return false for this case,
> since the local_irq_save() above must have set the PMR to
> GIC_PRIO_IRQOFF in the interrupted context.
> 
> Thus, we *must* call __el1_pnmi() in this case, where __el1_pnmi() is:
> 

Yes, you are right. And I made a mistake to think it will call
__el1_irq()
> | static __always_inline void __el1_pnmi(struct pt_regs *regs,
> |                                        void (*handler)(struct pt_regs *)) 
> | {
> |         arm64_enter_nmi(regs);
> |         do_interrupt_handler(regs, handler);
> |         arm64_exit_nmi(regs);
> | }
> 
> Note that arm64_{enter,exit}_nmi() handle the __nmi_{enter,exit}() calls around
> do_interupt_handler().
> 
> >                                            rcu_nmi_enter()
> >                                             ->__rcu_irq_enter_check_tick()
> >                                                ->raw_spin_lock_rcu_node(rdp->mynode);
> >                                                    deadlock happens!!!
> > 
> >     }
> 
> As above, I don't think this can go wrong as you describe, and don't believe
> that this can deadlock.
> 
> > *** On arm64, how pNMI mistaken as IRQ ***
> > 
> > On arm64, pNMI is an analogue to NMI. In essence, it is a higher
> > priority interrupt but not disabled by local_irq_disable().
> > 
> > In current implementation
> > 1) If a pNMI from a context where IRQs were masked, it can be recognized
> >    as nmi, and calls __nmi_enter() immediately. This is no problem.
> 
> Agreed, this case works correctly.
> 
> > 2) But it causes trouble if a pNMI from a context where IRQs were
> >    unmasked, and temporarily regarded as maskable interrupt.  It is not
> >    treated as NMI, i.e. calling nmi_enter() until reading from GIC.
> > 
> >     __el1_irq()
> >     {
> >       irq_enter_rcu()   ----> hit the deadlock bug
> 
> What is "the deadlock bug"? The example you had above was for a context where
> IRQs were *masked*, which is a different case.
> 

As above, I made a mistake about the condition hence the code path.
There is no problem in this case through calling __el1_pnmi()

Sorry for the false alarm and thank you again for your detailed
explaination.


Regards,

	Pingfan
