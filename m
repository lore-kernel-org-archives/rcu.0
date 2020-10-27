Return-Path: <SRS0=xcim=EC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FCEC63697
	for <rcu@archiver.kernel.org>; Tue, 27 Oct 2020 17:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C4C720878
	for <rcu@archiver.kernel.org>; Tue, 27 Oct 2020 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HB0b295L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762210AbgJ0Rbc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:31:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46560 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1819673AbgJ0Rat (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Oct 2020 13:30:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id a23so1921309qkg.13
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2020 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYSeqyz/JIAv8fNqM55u3XsYcFX6LZVCFHKdWniBKbU=;
        b=HB0b295Lv8MXIWJcp5LaqEKYZPE+K3XJZKxBq6R5kmC6Nv5NBAXfZHe0G9FRdCju8m
         /J6Gg6vFr6M76B5EbWhrpsygLjgdD9MKNm6/AwPpZ5bXVqnmN6+sYeWIa/lrARJ0YU/x
         W18x+EDL33QjPGGHu4OeKfE745kMtVhb0BSew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYSeqyz/JIAv8fNqM55u3XsYcFX6LZVCFHKdWniBKbU=;
        b=mSyJREPI3+Ys4LOzN3ar0pjQeeJFUYVtS+Rd4ynBeEjmFSqmDI+7e5UTNf2Wza5LeS
         qn6lNGbtMdGvNkdCJLtLs/9Oh8hYeF0M2MtXhyPzdydUfqIhJruud3S4QM8BIzetD1//
         TzGCZ+4MB7GBFTtVNLAstfejIJL74l5Pwg0ZYZYapjivbD3DuzKm2Xpx9YUUS3fCv59P
         XwQdLD/U62Ye5yRfrkPAuFQoqN/3XxPHJdGe/qEZ/8jUowgNa21B3/eb4Tp7abevc0Ja
         XsXp6gzkVNlkm05p7mDpE/sNBqy0SmD9iGGX7G43bN2d+RpccbaNR1Ebuc/LMu0iHhmo
         jA2g==
X-Gm-Message-State: AOAM532QQ93kMbUXRe4dmWzlqyfuo+bxDsLYS2dC7dYiK5aiz45esD0h
        4XSfX6ZrTDXti5DEnszeA+s2OQ==
X-Google-Smtp-Source: ABdhPJxbwOpdpa+A8Rc7aok4VV3rF8fkP5IBJnsgQ/TQGOaEnmW+eEbGgNwptKqFJ+VQAiEmk/l/dQ==
X-Received: by 2002:a37:a34a:: with SMTP id m71mr3257792qke.81.1603819847951;
        Tue, 27 Oct 2020 10:30:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t8sm1281237qtb.97.2020.10.27.10.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:30:47 -0700 (PDT)
Date:   Tue, 27 Oct 2020 13:30:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v8 2/6] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20201027173046.GA1018765@google.com>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
 <20201026003212.GA104441@lothringen>
 <20201026054043.GA4192074@google.com>
 <20201026112445.GC104441@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026112445.GC104441@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 26, 2020 at 12:24:45PM +0100, Frederic Weisbecker wrote:
[..] 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0f23d20d485a..79b7081143a7 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1160,6 +1160,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
> >   */
> >  static void srcu_invoke_callbacks(struct work_struct *work)
> >  {
> > +	long len;
> >  	bool more;
> >  	struct rcu_cblist ready_cbs;
> >  	struct rcu_head *rhp;
> > @@ -1182,6 +1183,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> >  	/* We are on the job!  Extract and invoke ready callbacks. */
> >  	sdp->srcu_cblist_invoking = true;
> >  	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
> > +	len = ready_cbs.len;
> >  	spin_unlock_irq_rcu_node(sdp);
> >  	rhp = rcu_cblist_dequeue(&ready_cbs);
> >  	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
> > @@ -1190,13 +1192,14 @@ static void srcu_invoke_callbacks(struct work_struct *work)
> >  		rhp->func(rhp);
> >  		local_bh_enable();
> >  	}
> > +	WARN_ON_ONCE(ready_cbs.len);
> >  
> >  	/*
> >  	 * Update counts, accelerate new callbacks, and if needed,
> >  	 * schedule another round of callback invocation.
> >  	 */
> >  	spin_lock_irq_rcu_node(sdp);
> > -	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
> > +	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
> >  	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> >  				       rcu_seq_snap(&ssp->srcu_gp_seq));
> >  	sdp->srcu_cblist_invoking = false;
> 
> Looks good! Thanks.

Just to report, with this fix the (s)rcutorture tests pass:

SRCU-N ------- 259086 GPs (143.937/s) [srcu: g3342384 f0x0 total-gps=3342384]
SRCU-P ------- 69443 GPs (38.5794/s) [srcud: g637552 f0x0 total-gps=637552]

thanks,

 - Joel

