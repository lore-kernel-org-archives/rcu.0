Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108BC433F5
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00CF61BA2
	for <rcu@archiver.kernel.org>; Wed, 17 Nov 2021 10:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhKQKUB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbhKQKT7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Nov 2021 05:19:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF5C061570
        for <rcu@vger.kernel.org>; Wed, 17 Nov 2021 02:17:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x131so2176367pfc.12
        for <rcu@vger.kernel.org>; Wed, 17 Nov 2021 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3pxJ3oQB88Hy6nnUYDAPmtV0wGKDywu1tvGr37CcGmo=;
        b=AZ/Y9d/NSXMTpaI2z25ku/RMHoWjo3mZ+y8XHxGQ5jbIZKDm7g4blxLcUiMWLvIlpm
         wGUwYxmaUS1OAy2cMZkJHKpEWLk9ToHgLsLt3CR+zMndDWPJAyDHrB2KZY6R76n3puHG
         3hyA2650ItEozwaqN45clgDPsve++NhxBKu19joIc1zlPoLyt9MuYtUblJGSsAQoSiBx
         OvUQHpusTitQKVdppwvSd9jXW70HXIF6oMYATXLFMQBcQHuNKVeoSy2yYJ6an0FO8Hsx
         zNdCalG/WoWw2GkY+ZL7zIzruruuWjXVC7JV4wPma7N0w0lA1Omgp0ZurtSaGAN3yWyq
         ImXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pxJ3oQB88Hy6nnUYDAPmtV0wGKDywu1tvGr37CcGmo=;
        b=RgBHw0zPnGt7TuWQIm9r3GygBhf1Lcx/5H9osHgZsR4RM0AthPxb5BwTqyQPWCJSkS
         RmfIH5T0P2lRnsYKQQ5JvwjOk3mAh79vXDT/v8iKhBwzo5Er7sWbzcwwlH/NaL8CESQ1
         blT257LtRUoFPVMn9NCe6PYkVZNuvxp+2A0hlI82twOSZRncJDe5ms0sRy5Q75WcCrAO
         kzthbyhq49krVJZemeUZ9L9HxCBNEdLoAXNJ5NU62uRPzGB0TOR2EAtpufLPbmopii6J
         7yF7uHQtiLBunSy+Djcmp5GC99ArWXUzKh+kGMbDlN4Lgr3UU4WCHk8aM3e9IoUfX6DQ
         qtNw==
X-Gm-Message-State: AOAM533bvRFtLP/1bu9CXOkFeuoIgoBsLIpMpue20mEBdf9/vkQ7yrGU
        eOA/FlxiS4FY3dt94IJcYw==
X-Google-Smtp-Source: ABdhPJxZlFb6Flfdv48dXZtqAXEASsgD+al8cdIwbO46Q3dKugeyWyPZohgqhH4U7kYuIEhZZSlgaA==
X-Received: by 2002:a63:5642:: with SMTP id g2mr4438997pgm.152.1637144220621;
        Wed, 17 Nov 2021 02:17:00 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f4sm20991170pfg.34.2021.11.17.02.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:17:00 -0800 (PST)
Date:   Wed, 17 Nov 2021 18:16:53 +0800
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
Message-ID: <YZTWlbEeQ0F/WB0l@piliu.users.ipa.redhat.com>
References: <20211116082450.10357-1-kernelfans@gmail.com>
 <20211116082450.10357-4-kernelfans@gmail.com>
 <878rxo8m0a.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rxo8m0a.wl-maz@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 16, 2021 at 09:53:25AM +0000, Marc Zyngier wrote:
> Hi Pingfan,
> 
> On Tue, 16 Nov 2021 08:24:49 +0000,
> Pingfan Liu <kernelfans@gmail.com> wrote:
> > 
> > Arch level code is ready to take over the nmi_enter()/nmi_exit()
> > housekeeping.
> > 
> > GICv3 can expose the pNMI discriminator, then simply remove the
> > housekeeping.
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Sami Tolvanen <samitolvanen@google.com>
> > Cc: Julien Thierry <julien.thierry@arm.com>
> > Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> > Cc: rcu@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index daec3309b014..aa2bcb47b47e 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -646,12 +646,8 @@ static void gic_deactivate_unhandled(u32 irqnr)
> >  
> >  static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
> >  {
> > -	bool irqs_enabled = interrupts_enabled(regs);
> >  	int err;
> >  
> > -	if (irqs_enabled)
> > -		nmi_enter();
> > -
> >  	if (static_branch_likely(&supports_deactivate_key))
> >  		gic_write_eoir(irqnr);
> >  	/*
> > @@ -664,8 +660,6 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
> >  	if (err)
> >  		gic_deactivate_unhandled(irqnr);
> >  
> > -	if (irqs_enabled)
> > -		nmi_exit();
> >  }
> >  
> >  static u32 do_read_iar(struct pt_regs *regs)
> > @@ -702,6 +696,15 @@ static u32 do_read_iar(struct pt_regs *regs)
> >  	return iar;
> >  }
> >  
> > +static bool gic_is_in_nmi(void)
> > +{
> > +	if (gic_supports_nmi() &&
> > +	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI)))
> > +		return true;
> 
> I don't think this fixes anything.
> 
> RPR stands for 'Running Priority Register', which in GIC speak reports
> the priority of the most recently Ack'ed interrupt.
> 
> You cannot use this to find out whether the interrupt that you /will/
> ack is a NMI or not. Actually, you cannot find out about *any*
> priority until you actually ack the interrupt. What you are asking for
> is the equivalent of a crystal ball, and we're in short supply... ;-)
> 
> The only case where ICC_RPR_EL1 will return something that is equal to
> GICD_INT_NMI_PRI is when you are *already* in an NMI context. So
> unless I have completely misunderstood your approach (which is always
> possible), I don't see how this can work.
> 

Thank you for the clear explanation. Also I revist this part in "GIC v3
and v4 overview" and have a deeper understanding. (Need to spare time to
go through all later)

You totally got my idea, and I need to find a bail-out.

As all kinds of PIC at least have two parts of functions: active (Ack) and
deactive(EOI), is it possible to split handle_arch_irq into two parts?
I.e let irqchip expose two interfaces:
  u32 (*read_irqinfo*)(struct pt_regs *regs, bool *is_nmi)
  void (*handle_arch_irq)(struct pt_regs *regs, u32 irqnr)
to replace the current interface:
  void (*handle_arch_irq)(struct pt_regs *regs)
  
I have thought about such stuff for some days. And the benefits include:
  -1. For this bugfix (by the parameter 'is_nmi')
  -2. IPI_RESCHEDULE performance drop issue can be resolved at arch
      code level. (by irqnr - ipi_irq_base == IPI_RESCHEDULE ?)
  -3. The arch level can provide a similar loop as aic_handle_irq() in irq-apple-aic.c,
      which can save cpu by avoiding heavy context sync when irq is
      intensive.

Do you think it is doable?


Thanks,

	Pingfan
> If you want to distinguish between NMI and IRQ early on (before
> acknowledging the interrupt), the only solution is to turn the NMI
> into a Group-0 interrupt so that it is presented to the CPU as a
> FIQ. At which point, you have the information by construction.
> 
> Unfortunately, this will only work in VMs, as Group-0 interrupts are
> usually routed to EL3 on bare metal systems.
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
