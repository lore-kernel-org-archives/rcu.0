Return-Path: <SRS0=0MOJ=WJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42398C31E40
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 01:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1137F20665
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 01:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Mv241Fhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHMBF2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 21:05:28 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45014 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHMBF2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Aug 2019 21:05:28 -0400
Received: by mail-pg1-f172.google.com with SMTP id i18so50352362pgl.11
        for <rcu@vger.kernel.org>; Mon, 12 Aug 2019 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qKDtRrj8VSA0AxTKmeWFFvgiD7uTonCobI1vWS2Oa24=;
        b=Mv241FhbNqODnmgbBHKpokjGwoA0ZA2DLfDRJnJGl1/Fo4TiGuXXkE7hQG0C4OsZb3
         42o8l9VPl1/SSH47hrtWpR4TsJxQaR0adyBnkQCxIY7QHqU4QjaZNrAyB4BcE2RfYQX3
         cUMTJ1gggVu8mQrZYUNL9wvtewVVIjYMrhfYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qKDtRrj8VSA0AxTKmeWFFvgiD7uTonCobI1vWS2Oa24=;
        b=drO+9fM5byAe9disq16CosEg37RIQr7maN1BGB05iAgJqub1gOG68d6951LrbFKYMi
         p34Jz3nx4XgJ/yfRoaBWqaaiE4RZMJehjSLlm2xxfBcQjmi8ffHbFwYNPxLV+1nnPGqP
         AowD/ZlyynmOF5mJqYsJZAV8ay3BauPV+rX4szHdjS/vLc86qZATshtuX1+t5G2BZC4K
         Eu+FWQKd60ohpA2zIOW8ObmFfPnj/hW0IdS3so8aoBlxxpiI1N+Wk9AkNsPEdpTndx6t
         zDQg+OfPRJll6y5zjtYFZU91SgmbFT2zJNv/oNtWcvs/6ccH6xWpCtxbUVYBaUFZUy/M
         VJhg==
X-Gm-Message-State: APjAAAUTdJvXeAGSTPq4YLyv7rEqSPH4TA4wlCLueQ98i9erdpBq4c0P
        mhZIhcGe5LN1wlJvconY6t45+2hdYMg=
X-Google-Smtp-Source: APXvYqy+4vu3quu56fOnYCKxkR9ImMB7DR2raLLo9n4l3tA6ML/FY2VBqoKnDxqvoSlB5D3o5MYGJw==
X-Received: by 2002:a65:430b:: with SMTP id j11mr32045818pgq.383.1565658327681;
        Mon, 12 Aug 2019 18:05:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 67sm817885pjo.29.2019.08.12.18.05.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 18:05:26 -0700 (PDT)
Date:   Mon, 12 Aug 2019 21:05:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190813010525.GB129011@google.com>
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813010249.GA129011@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
[snip]
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8c494a692728..ad906d6a74fb 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	 */
> >  	if (rdp->dynticks_nmi_nesting != 1) {
> >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > +		    rdp->dynticks_nmi_nesting == 2 &&
> > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > +			rdp->rcu_forced_tick = true;
> > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > +		}
> 
> 
> Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> rcu_nmi_enter_common() ? We could add this code there, under the "if
> (rcu_dynticks_curr_cpu_in_eqs())".

Actually, the other way. if (!rcu_dynticks_curr_cpu_in_eqs()) then do the
tick_dep_set_cpu().

thanks,

 - Joel

