Return-Path: <SRS0=M2zx=DY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D59C433DF
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 06:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A9F20720
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 06:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZkATWNHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436978AbgJQGDC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411732AbgJQGBh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432AC0613AC
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 18:31:25 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b8so6137975ioh.11
        for <rcu@vger.kernel.org>; Fri, 16 Oct 2020 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SLzJSGMR4mbYOI89e+4XPuKYVMYsrE6xEQzvzv1FK40=;
        b=ZkATWNHfDMwAnZYAEPtQdFpGvzmblB9A8Jo2ek8XDBkVys0P/vtgeQwi0sPRlpsbz8
         R72eT+JFhPIo+VnDxQPGZ0AaoTwoADs40Bp58zZch1bbsUSYCwPw+DbslwfE1grZC0R5
         VnxoWRYC57Swywhlsw5vS8f//o2+slDnYTze4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SLzJSGMR4mbYOI89e+4XPuKYVMYsrE6xEQzvzv1FK40=;
        b=cfJSMX4QDiv04Ne1bdcu6j2IQkeWg9fl8nTwEUCFFmVLVWv+33DisGMpxQI2pkr7rH
         H4tusGyLtE96UHO9RJP3PhTPkJjLp5vBxtcfmU6tvz8dR8cODtXRbK+e3wDiZsoA38JR
         Nx+AptbwzKzE7AGzV3QiITS8ME8fNZrLnDh0GfL2Mbp3p1pPqWpNbYi9pCxKxG4L/XtP
         UVbtqEh6ScHqjOuMMT+anDZW0ty8G7v0kRmIG/F/wGXBUL5eqya2nuxMBO/CbMFnUEOw
         4TED6D3RDlvkRgiS0ThDHySLNvX3CvgIhoZKdta8gpjmWpKI2y/dIp9mqYKrTCch4IU2
         C/yg==
X-Gm-Message-State: AOAM532JvxC1bGjW2AfRJH0R/YJXg+xEP+dLo1m048EMEf8aDwQQ3R8p
        ccALuJiK/Z/UnvIC2Eu6csKTrg==
X-Google-Smtp-Source: ABdhPJy3A9mxbUrKl5CR5I3MLz47bWf1N/lJ3npLhzSycul4E/UhT67t1SqNiyxnFxyASxGUoohSZg==
X-Received: by 2002:a02:b80f:: with SMTP id o15mr4617962jam.103.1602898284676;
        Fri, 16 Oct 2020 18:31:24 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z18sm3704281ioi.30.2020.10.16.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 18:31:23 -0700 (PDT)
Date:   Fri, 16 Oct 2020 21:31:23 -0400
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
Message-ID: <20201017013123.GC4015033@google.com>
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

Yeah I think not. In fact, I am not even sure if ->len in the existing code
needs to be atomic. I am considering vetting all code paths. Paul told me it
used to be the case that ->len could be lockless written (possibly without
IRQs disabled) I think but that maybe nowadays it is not the case. Let us
double check to be sure.

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

Ok I can do that.

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

Yeah your way is better, I will do it this way.

thanks,

 - Joel

