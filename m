Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F133C4332F
	for <rcu@archiver.kernel.org>; Thu, 24 Nov 2022 03:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKXDdQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKXDdP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 22:33:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2571F03
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 19:33:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4001985pjt.0
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 19:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq+SP73Tw5UORgi/8FhP11RnnUw8B+S0Y7CoHYs81qw=;
        b=Y2KKL496rUNaxIQ6h1T3n7wFiBRXobdJX/npag41uYorXjdg1dtKDhHVfKjxiqU9yc
         o9J7uVLWilKGuoQUn4MEf89e4m39JDpxgpqpscyfrDGhytmjLGckNH7uAa1K0SWkOgsv
         i5LVgUffdl4imf7vcNH00iqAATvytGYHF7a388JHWykpKE62yZsRfkUU89Nc7kMJ0Vgt
         bPJsC+fyJQ8qTncJ25awyw+bX70/m8rXY56y1vPcoakhm9Xv36wpshgL+YUUivpHOxJf
         ygo9+t841bpporm2PPE0px8GSp3V6conTHr+BTG+eI+rSw6CMDpBPWStJPINBGF5brN+
         lLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq+SP73Tw5UORgi/8FhP11RnnUw8B+S0Y7CoHYs81qw=;
        b=pEdrxNiri4scL/S3wBNH90LL83D64Uno/eTFVbd7dIm8AciXEkO3T8OnzhESp7IkiS
         8utcPu8HgKvP25nIX8rhcGATdO5/QrwyhTLkGYXbO/hNs65eeY0ydwcnXCbp9eFr1ly1
         +rq8d3q7zQWq+yrDHDlUPBLNlRp7RCoYVKg+YgW2QcthvN6lcl6meLI1r8rLGOB6qJNL
         DirVY1hFD3+hDKuU1VtxEyjZ8T9KUhRI8n0uJquLr64dzyDZgaEYrGeCSubFymipJuBD
         qLYgKqrkmDK2aiM4KctBCknpKslpK74DrDWhH9TXgv+P/aFYhE2kLmEdAMOedcDBdMKa
         AeOw==
X-Gm-Message-State: ANoB5pk7KoMHMiXsGDsCdpR4mXaopY7bT50lGsd9eXNNiBnKM77HjRsz
        2fKvar4jkXX0K7vp75huq2IE0FNr4g==
X-Google-Smtp-Source: AA0mqf7IbnPVkaX5SvHjWjR8wBGlBHKSIqj42HJq+27pfvt7orn19YR0EIj9kQNKgUh16l3SimoA0w==
X-Received: by 2002:a17:90b:3c42:b0:218:8186:ef9b with SMTP id pm2-20020a17090b3c4200b002188186ef9bmr30815311pjb.10.1669260794118;
        Wed, 23 Nov 2022 19:33:14 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b4-20020a1709027e0400b0018668bee7cdsm14951835plm.77.2022.11.23.19.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:33:13 -0800 (PST)
Date:   Thu, 24 Nov 2022 11:33:08 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCHv2 2/2] srcu: Eliminate the case that snp_seq bigger than
 snap in srcu_funnel_gp_start()
Message-ID: <Y37l9PDleNiaHFLo@piliu.users.ipa.redhat.com>
References: <20221123135638.79021-1-kernelfans@gmail.com>
 <20221123135638.79021-3-kernelfans@gmail.com>
 <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123192046.GH4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 23, 2022 at 11:20:46AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 09:56:38PM +0800, Pingfan Liu wrote:
> > Since the srcu read lock is still held during srcu_funnel_gp_start(),
> > the seq snap should be the largest number for the slot
> > srcu_have_cbs[idx].
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: rcu@vger.kernel.org
> > ---
> >  include/linux/rcupdate.h |  1 +
> >  kernel/rcu/srcutree.c    | 11 ++++++-----
> >  2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 08605ce7379d..a09007236660 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -32,6 +32,7 @@
> >  #include <linux/context_tracking_irq.h>
> >  
> >  #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
> > +#define ULONG_CMP_GT(a, b)	(ULONG_MAX / 2 > (a) - (b))
> 
> Please see below...
> 
> >  #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
> >  #define ulong2long(a)		(*(long *)(&(a)))
> >  #define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 2fc0e775ade4..41902b823687 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -905,14 +905,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
> >  		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> >  			spin_lock_irqsave_rcu_node(snp, flags);
> >  			snp_seq = snp->srcu_have_cbs[idx];
> > -			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
> > +			/*
> > +			 * s should be the biggest in the current slot. Hence only LE is
> > +			 * valid
> > +			 */
> > +			BUG_ON(ULONG_CMP_GT(snp_seq, s));
> 
> Why not this?  (Plus adjusting the comment above, of course.)
> 
> 			WARN_ON_ONCE(ULONG_CMP_LT(s, snp_seq));
> 

A neat solution!

And what about the comment
			/* s should be the biggest in the current slot. */

> That way we don't need ULONG_CMP_GT().  Plus if we are confused about
> s being the biggest in the current slot, we get a splat and can debug
> further.  We both might be quite sure that we are not confused, but
> that is exactly when we are most prone to making mistakes.  ;-)
> 

Same feeling :)

> I also ask that you run with this check for some time.  After all, if

Sure. I will try it immediately.

> the assumption is incorrect, the resulting SRCU hangs off in various
> systems around the world will not be so much fun to debug.
> 
> Given that this is slowpath code, it is much better to take an extra
> compare and branch than to introduce even an extremely small risk of
> hanging SRCU.
> 

Agree.


Thanks,

	Pingfan

> 							Thanx, Paul
> 
> > +			if (!srcu_invl_snp_seq(snp_seq) && (snp_seq == s)) {
> >  				if (snp == snp_leaf && snp_seq == s)
> >  					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
> >  				spin_unlock_irqrestore_rcu_node(snp, flags);
> > -				if (snp == snp_leaf && snp_seq != s) {
> > -					srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
> > -					return;
> > -				}
> >  				if (!do_norm)
> >  					srcu_funnel_exp_start(ssp, snp, s);
> >  				return;
> > -- 
> > 2.31.1
> > 
