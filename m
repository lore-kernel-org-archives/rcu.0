Return-Path: <SRS0=ayKe=WL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C0EC3A589
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615552084D
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 20:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pcs9yKKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfHOUEv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:04:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42677 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbfHOUEu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Aug 2019 16:04:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so1854089pfk.9
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 13:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n6YBL5b/Dd5MLp+dSdcFCG5ICIZMehFxtT34vdhhjVI=;
        b=pcs9yKKzMLWzJx7mPAbEu0cQ48CKSVk8eADzdB58kn0E7yaKovp28RX5k2ozazDg0T
         ryqjMC9H01FaJQLFxUpAhcRV/mVZjzP4O63MWzYmlAi6A6J0t4l06vdoDYNldJfN509b
         jMkPYUd1mL/d0xcXVh+V6KnPRUOkNfG0WDOJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6YBL5b/Dd5MLp+dSdcFCG5ICIZMehFxtT34vdhhjVI=;
        b=JDln7LX5BoroAt4qI0Dg7xoQo6l/hjtlrolNo2+l7QtbG3/Ekwjl1Kz+UdIweOANn/
         3nLnHPByQzBKi8b1+UloTrKpzTPTuESbZqeK819MVyc3vQEaHWUc8Ly4JcQXZ+GCoz97
         o4rZPB3tkXi1VQDHzlTf1tgOq0qFXeaRLP7MPafALaqLrnATU1ZdlFRHZB1kOei/W/hR
         0728RWNvOtbEpx1smAcIRDpDnFP61zOG/9nrCaakvEbFxJdJM6VKy6InwkIGa5m4wM1K
         O2+92YrmMHIP9cLvptpjZfdRYf0OAMhgY2eR2UadfNPbBT3oJjxyvJuj2hXnWkPZH3k+
         xbvA==
X-Gm-Message-State: APjAAAV81Uobc4gnOxVmYqLelmsFeITlYdW//CYuUM02FUIxKc6Phuhq
        dNdWLiYVTKL/rnOYKor9Udf02zgkOuk=
X-Google-Smtp-Source: APXvYqwKcHBhdLcqluLmQLmg4ocCKeTWpY5KnpNwcr9RscQ4Kve6EZ4YBBcGc2Qg307G9js66NdLIQ==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr3759515pjq.50.1565899490147;
        Thu, 15 Aug 2019 13:04:50 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id s14sm3481998pfe.16.2019.08.15.13.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 13:04:49 -0700 (PDT)
Date:   Thu, 15 Aug 2019 16:04:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190815200432.GB23194@google.com>
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815171714.GA1023@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 10:17:14AM -0700, Paul E. McKenney wrote:
> On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> > On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 8c494a692728..ad906d6a74fb 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > >  	 */
> > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > > +		    rdp->dynticks_nmi_nesting == 2 &&
> > > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > +			rdp->rcu_forced_tick = true;
> > > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > +		}
> > 
> > 
> > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > (rcu_dynticks_curr_cpu_in_eqs())".
> 
> This would need to go in an "else" clause, correct?  But there would still
> want to be a check for interrupt from base level (which would admittedly
> be an equality comparison with zero) and we would also still need to check
> for rdp->rcu_urgent_qs && !rdp->rcu_forced_tick.

True, agreed. I replied to this before saying it should be
!rcu_dynticks_curr_cpu_in_eqs() in the "if" ;) But it seems I could also be
missing the check for TICK_DEP_MASK_RCU in my tree so I think we need this as
well which is below as diff. Testing it more now!

And, with this I do get many more ticks during the test. But there are
intervals where the tick is not seen. Still it is much better than before:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be9707f68024..e697c7a2ce67 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_CLOCK_RCU) {
+		return true;
+	}
+
 	return false;
 }
 
> Still, an equal-zero comparison is probably going to be a bit cheaper than
> an equals-two comparison, and this is on the interrupt-entry fastpath,
> so this change is likely worth making.  Good call!!!

Thanks!!

 - Joel

[snip]
