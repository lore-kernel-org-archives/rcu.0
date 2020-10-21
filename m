Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA01C55178
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9692022283
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MbbQ4ld+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502585AbgJUPdR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502537AbgJUPdR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 11:33:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5241EC0613CF
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 08:33:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z6so2893329qkz.4
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NQmzzDNfdi2/u9JNBuSmE+invIf87wfsHJkh8YSjhqQ=;
        b=MbbQ4ld+NX1TwKdvdAAUmm86a6ImHNKGUMo+AkORlA+qRt210GmiuF2y1iXx+0kNCq
         /qMFbw4jLR2quvdF1RGKRmydz6NO85pfoAFPuASfq0AXKyu0MmJq/mWtZ3nHQS02uXW4
         ueXNBHNF895nKGvqm9l8h8JeRT93XYDcNMNEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NQmzzDNfdi2/u9JNBuSmE+invIf87wfsHJkh8YSjhqQ=;
        b=r2eGtyYFNx/yl9l3mRNEPVcE93M1TDHFz/MlVpTeed4ZvsxA/WIu1i4U3KVCi7WmC0
         ifD9CJh/lHlhu2yTc52VABmZJ/vVzy71seEJDTZpLstGzrifmwe7H6ToDOQasiMWwzjo
         j5v+AwZqIdSmWD5tUof5sENHeE8Iyk4fwI3ctYviWn8Fhit6yU0G0gd86xlp20H4Vogz
         HsN7rrRQ4FLbXJvFUeADvJLDBOWf0oiWewXZKY9UMtjTWDCh0hMVRAwBpXA0LohhVZF2
         +PE/Iod/AkNJjd8DHnLWKXtqJ1PYPELdstZtiuPj1f7X0MDYPMntFtealcETQv4gPMyp
         9TuA==
X-Gm-Message-State: AOAM5309JNHC2mXSY/XaJ4RNukl3vmCTxK8Okp7n49I06Xi+nufiMDmT
        3iLtYV9usxKlJZebpBwuI+Wb0g==
X-Google-Smtp-Source: ABdhPJxwdN7LJyU3Pmv43OjI0TXR8hPq7LvzdaWVv/l5ui6kPPlxsABIsYAnSGu2Bb2eOB3mjOb1Fw==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr3559897qka.387.1603294396173;
        Wed, 21 Oct 2020 08:33:16 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 198sm1504005qki.117.2020.10.21.08.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:33:15 -0700 (PDT)
Date:   Wed, 21 Oct 2020 11:33:14 -0400
From:   joel@joelfernandes.org
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v7 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201021153314.GB2828884@google.com>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-3-joel@joelfernandes.org>
 <20201015122158.GA127222@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015122158.GA127222@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 15, 2020 at 02:21:58PM +0200, Frederic Weisbecker wrote:
> On Wed, Oct 14, 2020 at 08:22:57PM -0400, Joel Fernandes (Google) wrote:
> > Add counting of segment lengths of segmented callback list.
> > 
> > This will be useful for a number of things such as knowing how big the
> > ready-to-execute segment have gotten. The immediate benefit is ability
> > to trace how the callbacks in the segmented callback list change.
> > 
> > Also this patch remove hacks related to using donecbs's ->len field as a
> > temporary variable to save the segmented callback list's length. This cannot be
> > done anymore and is not needed.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  include/linux/rcu_segcblist.h |   2 +
> >  kernel/rcu/rcu_segcblist.c    | 133 +++++++++++++++++++++++-----------
> >  kernel/rcu/rcu_segcblist.h    |   2 -
> >  3 files changed, 92 insertions(+), 45 deletions(-)
> > 
> > diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> > index b36afe7b22c9..d462ae5e340a 100644
> > --- a/include/linux/rcu_segcblist.h
> > +++ b/include/linux/rcu_segcblist.h
> > @@ -69,8 +69,10 @@ struct rcu_segcblist {
> >  	unsigned long gp_seq[RCU_CBLIST_NSEGS];
> >  #ifdef CONFIG_RCU_NOCB_CPU
> >  	atomic_long_t len;
> > +	atomic_long_t seglen[RCU_CBLIST_NSEGS];
> 
> Also does it really need to be atomic?

Yes, it need not be. I will make the change for ->seglen.

BTW, for the existing ->len field, doesn't the following need to acquire nocb
lock?
rcu_nocb_try_bypass -> rcu_segcblist_inc_len

It seems that will do a lock-less non-atomic RMW on a nocb offloaded list,
otherwise.

Certainly rcu_nocb_do_flush_bypass() does do it so maybe it was missed?

> > @@ -245,7 +280,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> >  			   struct rcu_head *rhp)
> >  {
> >  	rcu_segcblist_inc_len(rsclp);
> > -	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
> 
> That's a significant change that shouldn't be hidden and unexplained in an unrelated
> patch or it may be easily missed. I'd suggest to move this line together in
> "rcu/tree: Remove redundant smp_mb() in rcu_do_batch" (with the title updated perhaps)
> and maybe put it in the beginning of the series?

Will do as you suggest, makes sense.

> > +	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> >  	rhp->next = NULL;
> >  	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> >  	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> [...]
> > @@ -330,11 +353,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
> >  
> >  	if (!rcu_segcblist_pend_cbs(rsclp))
> >  		return; /* Nothing to do. */
> > +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
> > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
> > +		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
> >  	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
> >  	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
> >  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> > -	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
> > +	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
> >  		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
> > +		rcu_segcblist_set_seglen(rsclp, i, 0);
> > +	}
> 
> So, that's probably just a matter of personal preference, so feel free to
> ignore but I'd rather do:
> 
>     rclp->len += rcu_segcblist_get_seglen(rsclp, i);
>     rcu_segcblist_set_seglen(rsclp, i, 0);
> 
> instead of the big addition above. That way, if a new index ever gets added/renamed
> to the segcblist, we'll take it into account. Also that spares a few lines.

Makes senes, will do.

thanks,

 - Joel

