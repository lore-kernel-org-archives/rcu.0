Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C26C433EF
	for <rcu@archiver.kernel.org>; Fri, 19 Nov 2021 02:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9300D6121F
	for <rcu@archiver.kernel.org>; Fri, 19 Nov 2021 02:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhKSClg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Nov 2021 21:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhKSClg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Nov 2021 21:41:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E31C061574
        for <rcu@vger.kernel.org>; Thu, 18 Nov 2021 18:38:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso7630783pjb.0
        for <rcu@vger.kernel.org>; Thu, 18 Nov 2021 18:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=be0VjlCfz8v4iknbpHUglEbWLwBU+ul0wNcBljR8czw=;
        b=osLhPfUZaUrAtbjzclrY943L1HNd0F98wz5ChFWWMPxMnV/5aO/kmsH0IhD+jAnzZq
         tfDndVEHa7JahCWuxXsu1oneg1QI/FzqPx/4tw/hllAamqk3J8vwV2P1/ZYfBZ6AgeSK
         K9X1ESmdX3mFjbkC2CuE/IQGbRRpBCgLflpvCdzpQN3o+FnvBmj9b9ZDycBiE4SanMw1
         1RG0eZHEs1GBK7X8uHK8HKGYQvx+xIUH/dg5JbLAueSPZcCfXT9ooTzSKZYGqpEaVIaY
         7wV0DSkbS/kVxT4sHqKpL7b5bmnC4Awnf+jTfTKBdoJ5ybcMTQP8ugNJojhkf4G2aj6V
         Uu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=be0VjlCfz8v4iknbpHUglEbWLwBU+ul0wNcBljR8czw=;
        b=EsdA4BVUsiYPPTOTc2FxVcK6YDF+8ufT70w8FBhfJHXqailxIr+3ERzDWlzyZGTJHz
         uNvAUOgggFyHmKQtdti0PvKyI6ihIoWELMzp9sksxVHo2AixZ+W8sgkFaykpHXdSGlZ2
         Xo29jZTHz/vJBF3nSotQcQniSFN1tz+rm0xfWOl/pCh7xtQUq79q6BZfdpG5/yYN76sP
         uDgEVDABHACqeQWJwFCCMcwJat1CgY7PPqm9ISC/u762gMbYjKKn94xZUPIk0G2Wt97S
         8JHYPjOnn9XpcQs8+wBpmG0wq0wS2bNl06Zffbc3xvT1wLvoZo+h+wPz8oZXidaq0bpz
         afiQ==
X-Gm-Message-State: AOAM532uBinXmbWKtBaV9EA5tA8HHhZjoUMghJatS4cc4X2DNtTcpPaF
        omIVi/iooxUu5u4Xyei/8Q==
X-Google-Smtp-Source: ABdhPJyHncGEvA1Ifvztkp4d2Oq8WPMtrNK8euq/nxcFtSICYjpPM84tTCPVDDWfsEUBLgWEXjRifQ==
X-Received: by 2002:a17:90b:2389:: with SMTP id mr9mr320418pjb.152.1637289515008;
        Thu, 18 Nov 2021 18:38:35 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i68sm867622pfc.158.2021.11.18.18.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 18:38:34 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:38:24 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>, rcu@vger.kernel.org
Subject: Re: [PATCHv3 3/4] irqchip: GICv3: expose pNMI discriminator
Message-ID: <YZcOIPATC6ndQl8h@piliu.users.ipa.redhat.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
 <20211116082450.10357-4-kernelfans@gmail.com>
 <878rxo8m0a.wl-maz@kernel.org>
 <YZTWlbEeQ0F/WB0l@piliu.users.ipa.redhat.com>
 <87y25n6o70.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y25n6o70.wl-maz@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 17, 2021 at 11:01:23AM +0000, Marc Zyngier wrote:
> On Wed, 17 Nov 2021 10:16:53 +0000,
> Pingfan Liu <kernelfans@gmail.com> wrote:
> > 
> > On Tue, Nov 16, 2021 at 09:53:25AM +0000, Marc Zyngier wrote:
> > > Hi Pingfan,
> > > 
> > > On Tue, 16 Nov 2021 08:24:49 +0000,
> > > Pingfan Liu <kernelfans@gmail.com> wrote:
> > > > 
> > > > Arch level code is ready to take over the nmi_enter()/nmi_exit()
> > > > housekeeping.
> > > > 
> > > > GICv3 can expose the pNMI discriminator, then simply remove the
> > > > housekeeping.
> > > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > Cc: Joey Gouly <joey.gouly@arm.com>
> > > > Cc: Sami Tolvanen <samitolvanen@google.com>
> > > > Cc: Julien Thierry <julien.thierry@arm.com>
> > > > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > > > Cc: rcu@vger.kernel.org
> > > > To: linux-arm-kernel@lists.infradead.org
> > > > ---
> > > >  drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
> > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > > index daec3309b014..aa2bcb47b47e 100644
> > > > --- a/drivers/irqchip/irq-gic-v3.c
> > > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > > @@ -646,12 +646,8 @@ static void gic_deactivate_unhandled(u32 irqnr)
> > > >  
> > > >  static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
> > > >  {
> > > > -	bool irqs_enabled = interrupts_enabled(regs);
> > > >  	int err;
> > > >  
> > > > -	if (irqs_enabled)
> > > > -		nmi_enter();
> > > > -
> > > >  	if (static_branch_likely(&supports_deactivate_key))
> > > >  		gic_write_eoir(irqnr);
> > > >  	/*
> > > > @@ -664,8 +660,6 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
> > > >  	if (err)
> > > >  		gic_deactivate_unhandled(irqnr);
> > > >  
> > > > -	if (irqs_enabled)
> > > > -		nmi_exit();
> > > >  }
> > > >  
> > > >  static u32 do_read_iar(struct pt_regs *regs)
> > > > @@ -702,6 +696,15 @@ static u32 do_read_iar(struct pt_regs *regs)
> > > >  	return iar;
> > > >  }
> > > >  
> > > > +static bool gic_is_in_nmi(void)
> > > > +{
> > > > +	if (gic_supports_nmi() &&
> > > > +	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI)))
> > > > +		return true;
> > > 
> > > I don't think this fixes anything.
> > > 
> > > RPR stands for 'Running Priority Register', which in GIC speak reports
> > > the priority of the most recently Ack'ed interrupt.
> > > 
> > > You cannot use this to find out whether the interrupt that you /will/
> > > ack is a NMI or not. Actually, you cannot find out about *any*
> > > priority until you actually ack the interrupt. What you are asking for
> > > is the equivalent of a crystal ball, and we're in short supply... ;-)
> > > 
> > > The only case where ICC_RPR_EL1 will return something that is equal to
> > > GICD_INT_NMI_PRI is when you are *already* in an NMI context. So
> > > unless I have completely misunderstood your approach (which is always
> > > possible), I don't see how this can work.
> > > 
> > 
> > Thank you for the clear explanation. Also I revist this part in "GIC v3
> > and v4 overview" and have a deeper understanding. (Need to spare time to
> > go through all later)
> > 
> > You totally got my idea, and I need to find a bail-out.
> > 
> > As all kinds of PIC at least have two parts of functions: active (Ack) and
> > deactive(EOI), is it possible to split handle_arch_irq into two parts?
> > I.e let irqchip expose two interfaces:
> >   u32 (*read_irqinfo*)(struct pt_regs *regs, bool *is_nmi)
> >   void (*handle_arch_irq)(struct pt_regs *regs, u32 irqnr)
> > to replace the current interface:
> 
> No. There is no way we will move to such a scheme. We want to isolate
> the irqchip stuff in its own corner, and not propagate it into the
> arch code.

I understood this beautiful design of isolation. But since the x86 and
powerpc have integrated the PIC as part of arch at hardware design,
they can tell the source of the interrupt at the arch level code.

That is why their IPI_RESCHEDULE is cheaper than arm64. But yeah, the
benifit may not persuasive enough to breach the design goal.

> 
> If the pseudo-NMI is such a problem, I'm all for removing it *now*,
> never to come back again.
> 

It is a pity that pNMI has not fulfilled the roles like other Arches yet.
Two benefits come with NMI on x86 and powerpc:
-1. hardlockup detector uses NMI to ease the detection and analysis of
unpaired irq enable/disable. It can accurately report the stack trace
-2. In kdump case, all cpus can be forced into a known code piece.

But on arm64, it does not play such a role yet. Once I hit a boot hang
issue on a customed kdump kernel, there is no tick irq after adding
some printk, and if there is hardlockup detector, it will be easy to
debug.

> >   void (*handle_arch_irq)(struct pt_regs *regs)
> >   
> > I have thought about such stuff for some days. And the benefits include:
> >   -1. For this bugfix (by the parameter 'is_nmi')
> >   -2. IPI_RESCHEDULE performance drop issue can be resolved at arch
> >       code level. (by irqnr - ipi_irq_base == IPI_RESCHEDULE ?)
> >   -3. The arch level can provide a similar loop as aic_handle_irq() in irq-apple-aic.c,
> >       which can save cpu by avoiding heavy context sync when irq is
> >       intensive.
> > 
> > Do you think it is doable?
> 
> I don't think this is even needed, because I don't believe that the
> whole thing is a real problem.
> 
> In patch #1, you are claiming that handling a NMI as an IRQ first, and
> then upgrading to NMI once we know it really is an NMI is a problem.
> How different is this from an IRQ being preempted by a NMI?
> 

It turned out a false alarm as my reply to Mark. In that case, the code
should take __el1_pnmi(), but I mistake it as __el1_irq().

Thank again for your time and patient reply.


Regards,

	Pingfan

> Your own conclusion is that the this later case isn't a problem. So
> why is the former an issue?
> 
> I'm not saying that there is no issue at all, and it could well be
> that you have spotted something that I cannot see yet. But if that's
> the case, it means that the core code is broken as well.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
