Return-Path: <SRS0=HAhG=EB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4F8C2D0A3
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 05:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0602087C
	for <rcu@archiver.kernel.org>; Mon, 26 Oct 2020 05:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PeclKkH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769255AbgJZFkp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 26 Oct 2020 01:40:45 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46604 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1736461AbgJZFkp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 26 Oct 2020 01:40:45 -0400
Received: by mail-il1-f194.google.com with SMTP id a20so7087908ilk.13
        for <rcu@vger.kernel.org>; Sun, 25 Oct 2020 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WIknJCEsnGcKmkGeMaUJs6kRpDf0I10AEmCTGVp2I5s=;
        b=PeclKkH4oUWEBhOQIWbAO2Va+Xq2LcceX9mJQpGDCGwnE9EzCGpWYLLJtljx/vWA7c
         emjxA4WUSgjAVQ5UkKgcYV7JEFfTNnXRIp6uWkXammDChMbB8zDf2I0EstnHB8NGnX4u
         81BUDgTMiMX0M91R05AMlHtpAfuJIFIAEcWX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WIknJCEsnGcKmkGeMaUJs6kRpDf0I10AEmCTGVp2I5s=;
        b=SZKca4P+UJAM39GxRGDtJZJLS0AmpLUB0Avxc2sdqf+x7GkFMZzGatPBIYYPESbgG6
         SiTA6Bz4QDWRKJpwSZcFACI6BeuJdEQClQFwc+AKGjcwmo+wviJ9NFvS8HO7kH1wpZgF
         /WkRSHl0W6z00e4MDM6Zmr8MU+P+lg836FvjjuLZrMqFCllMh6q1UIXMl9Fz8q5NL4k8
         kremG5hvJFPkKJn0cn7pOELzl4XlhpQ7X1rQ/k4dOyTTLgIqsOOd68r8joSm4/l2jQuC
         AUSgI30rFPmziQyr1SOwoB3VdXsw3pL94/wK1c/upykDBIPykoDC7iqO3HMArXX02MOi
         1wwQ==
X-Gm-Message-State: AOAM533NkBsU6OA4+MndgekIufKLMkQ9XLZZ2Xs4xbE7Ee4zk1OroTKr
        6UVW93qP1OFUH0da7KAELEO7kg==
X-Google-Smtp-Source: ABdhPJz8DOW5SvDUGKr6TbPfTHjXyd+Y+EAt65LZYvgYPI3W2QXTDQd5XGVynuii5qgCuZ4xuXndmw==
X-Received: by 2002:a92:d710:: with SMTP id m16mr8717849iln.161.1603690844615;
        Sun, 25 Oct 2020 22:40:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id m2sm4999401ion.44.2020.10.25.22.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 22:40:43 -0700 (PDT)
Date:   Mon, 26 Oct 2020 01:40:43 -0400
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
Message-ID: <20201026054043.GA4192074@google.com>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
 <20201021190813.3005054-3-joel@joelfernandes.org>
 <20201026003212.GA104441@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026003212.GA104441@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Oct 26, 2020 at 01:32:12AM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 21, 2020 at 03:08:09PM -0400, Joel Fernandes (Google) wrote:
> > @@ -307,6 +317,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >  
> >  	if (!rcu_segcblist_ready_cbs(rsclp))
> >  		return; /* Nothing to do. */
> > +	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
> 
> I realize, doesn't it break the unsegmented count in srcu_invoke_callbacks() ?
> 
> It still does rcu_segcblist_insert_count(), so it adds zero to rsclp->len
> which thus doesn't get cleared and probably keeps growing.

You are right. This needs changing :-( Its my fault, I did not test SRCU
torture tests which are indeed failing.

I fixed it with the diff attached to the end of the email and will test it
more.

> >  	*rclp->tail = rsclp->head;
> >  	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
> >  	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
> > @@ -314,6 +325,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >  	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
> >  		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
> >  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
> > +	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
> >  }
> >  
> >  /*
> > @@ -330,11 +342,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
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
> 
> You seem to have forgotten the suggestion?
> 
>     rclp->len += rcu_segcblist_get_seglen(rsclp, i)

I decided to keep it this way as I did not see how it could be better.
You mentioned you are Ok with either option so I left it as is.

Thanks!

 - Joel

---8<-----------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0f23d20d485a..79b7081143a7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1160,6 +1160,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
  */
 static void srcu_invoke_callbacks(struct work_struct *work)
 {
+	long len;
 	bool more;
 	struct rcu_cblist ready_cbs;
 	struct rcu_head *rhp;
@@ -1182,6 +1183,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	/* We are on the job!  Extract and invoke ready callbacks. */
 	sdp->srcu_cblist_invoking = true;
 	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
+	len = ready_cbs.len;
 	spin_unlock_irq_rcu_node(sdp);
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
@@ -1190,13 +1192,14 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 		rhp->func(rhp);
 		local_bh_enable();
 	}
+	WARN_ON_ONCE(ready_cbs.len);
 
 	/*
 	 * Update counts, accelerate new callbacks, and if needed,
 	 * schedule another round of callback invocation.
 	 */
 	spin_lock_irq_rcu_node(sdp);
-	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
+	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
