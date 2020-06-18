Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F25C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345C32075E
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 23:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DA4R295d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgFRXwf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFRXwe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 19:52:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A592CC0613EE
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 16:52:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so7380685qke.7
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lncC3bu/ZKjuJrqkGmM6i3BINSdzOE7f+KUI0j06O6A=;
        b=DA4R295dM0OPN2/U1vfpWqdhoktgUb02jpdx3x3N9YWHHCX/btW2MW/V+rPEW2P16f
         ZXLIuUhPOgGZ/Rzpf80Tv7S1WAtE8n5yMZT283yT9S/QA+iKqO1Si1shbruJfsBHG8WE
         4XJwrxSh23TdOq8sDAc/dAYZng4H7JdZOYBag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lncC3bu/ZKjuJrqkGmM6i3BINSdzOE7f+KUI0j06O6A=;
        b=I8NRePjjcP7Gt98dIDo6veEYdC5dcb6H2K96hXsCTPM6SX3aEkoACcOE+WnmIjkN4R
         FwId6yrc4CS7aViQXbCFqSKOYT7G/+CdhWI8OXHwOfzJQytaw9c6L6iIxN0HhnclX2kR
         mwaRf8sar61QTwZ4waQ3Npe1w36hQ6qNHBglrpXZRCaAwzTG3Tk4cSeyThDoOfMSqjBB
         hxH6zMfDhMbxzF9cdr+dBmrazHXasJWiy85YfQzM77kcSxJzSZ+2dzgr/sCGqNqvnFQR
         R2P2744ioBBZ4ZI7Cnbb7UBGFAt3uVc09KKY3ro9fzQseOdXW6158JqnOAtdH2xHvbZy
         IBtw==
X-Gm-Message-State: AOAM531rn1Xf0V7lXfc3jMAZJdMoPUnW5RO31AJM6qfTQC7bacp5MuVO
        J+Kpu7f3IiEgBjA6t8h5Jxd3Iw==
X-Google-Smtp-Source: ABdhPJx/goqklVcR/QaFBJkO3HjIPWba+12DzaDfZ2Ws0KqhlYrKxZIZPfD7YpE1mioWHE2U9YJHEw==
X-Received: by 2002:a37:b842:: with SMTP id i63mr918913qkf.365.1592524352845;
        Thu, 18 Jun 2020 16:52:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id c2sm4314730qkl.58.2020.06.18.16.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 16:52:32 -0700 (PDT)
Date:   Thu, 18 Jun 2020 19:52:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 2/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20200618235232.GB40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-2-joel@joelfernandes.org>
 <20200618221639.GY2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618221639.GY2723@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 03:16:39PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 04:29:50PM -0400, Joel Fernandes (Google) wrote:
> > Track how the segcb list changes before/after acceleration, during
> > queuing and during dequeuing.
> > 
> > This has proved useful to discover an optimization to avoid unwanted GP
> > requests when there are no callbacks accelerated.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> It does look like it provides some useful information, but the fact
> that callback lists can contain millions of callbacks makes the
> rcu_segcblist_countseq() a non-starter for mainline use.
> 
> One thing that has been on my list for some time is to associate counts
> with the rcu_segcblist segments, which would make this sort of tracing
> more palatable.  This would be a fiddly change requiring careful testing,
> which might be why I have not yet done it myself.  One benefit of such
> counts is to allow RCU to determine whether callbacks are being held up by
> the grace period on the one hand or by callback invocation on the other.

Sounds good, as discussed on IRC I will work on adding direct counters to the
list.

thanks,

 - Joel


> 						Thanx, Paul
> 
> > ---
> >  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.c | 37 +++++++++++++++++++++++++++++++++++++
> >  kernel/rcu/rcu_segcblist.h |  7 +++++++
> >  kernel/rcu/tree.c          | 24 ++++++++++++++++++++++++
> >  4 files changed, 93 insertions(+)
> > 
> > diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> > index 02dcd119f3263..a6d49864dcc27 100644
> > --- a/include/trace/events/rcu.h
> > +++ b/include/trace/events/rcu.h
> > @@ -507,6 +507,31 @@ TRACE_EVENT_RCU(rcu_callback,
> >  		  __entry->qlen)
> >  );
> >  
> > +TRACE_EVENT_RCU(rcu_segcb,
> > +
> > +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> > +
> > +		TP_ARGS(ctx, cb_count, gp_seq),
> > +
> > +		TP_STRUCT__entry(
> > +			__field(const char *, ctx)
> > +			__array(int, cb_count, 4)
> > +			__array(unsigned long, gp_seq, 4)
> > +		),
> > +
> > +		TP_fast_assign(
> > +			__entry->ctx = ctx;
> > +			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
> > +			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
> > +		),
> > +
> > +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> > +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> > +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> > +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> > +
> > +);
> > +
> >  /*
> >   * Tracepoint for the registration of a single RCU callback of the special
> >   * kfree() form.  The first argument is the RCU type, the second argument
> > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > index 4782cf17bf4f9..036d4abac7c5a 100644
> > --- a/kernel/rcu/rcu_segcblist.c
> > +++ b/kernel/rcu/rcu_segcblist.c
> > @@ -316,6 +316,43 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> >  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
> >  }
> >  
> > +/*
> > + * Return how many CBs each segment along with their gp_seq values.
> > + *
> > + * This function is O(N) where N is the number of callbacks. Only used from
> > + * tracing code which is usually disabled in production.
> > + */
> > +#ifdef CONFIG_RCU_TRACE
> > +void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> > +{
> > +	struct rcu_head **cur_tail, *h;
> > +	int i, c;
> > +
> > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> > +		cbcount[i] = 0;
> > +
> > +	cur_tail = &(rsclp->head);
> > +
> > +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> > +		c = 0;
> > +		// List empty?
> > +		if (rsclp->tails[i] != cur_tail) {
> > +			// The loop skips the last node
> > +			c = 1;
> > +			for (h = *cur_tail; h->next != *(rsclp->tails[i]); h = h->next) {
> > +				c++;
> > +			}
> > +		}
> > +
> > +		cbcount[i] = c;
> > +		gpseq[i] = rsclp->gp_seq[i];
> > +		cur_tail = rsclp->tails[i];
> > +	}
> > +}
> > +#endif
> > +
> >  /*
> >   * Extract only those callbacks still pending (not yet ready to be
> >   * invoked) from the specified rcu_segcblist structure and place them in
> > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > index 5c293afc07b8e..0a8dbac438529 100644
> > --- a/kernel/rcu/rcu_segcblist.h
> > +++ b/kernel/rcu/rcu_segcblist.h
> > @@ -104,3 +104,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
> >  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
> >  void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
> >  			 struct rcu_segcblist *src_rsclp);
> > +#ifdef CONFIG_RCU_TRACE
> > +void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> > +			 int cbcount[RCU_CBLIST_NSEGS],
> > +			 unsigned long gpseq[RCU_CBLIST_NSEGS]);
> > +#else
> > +#define rcu_segcblist_countseq(...)
> > +#endif
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ebce14e470d0e..c61af6a33fbfd 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1407,6 +1407,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >  {
> >  	unsigned long gp_seq_req;
> >  	bool ret = false;
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> >  
> >  	rcu_lockdep_assert_cblist_protected(rdp);
> >  	raw_lockdep_assert_held_rcu_node(rnp);
> > @@ -1415,6 +1417,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >  	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
> >  		return false;
> >  
> > +	/* Count CBs for tracing. */
> > +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> > +	trace_rcu_segcb("SegCbPreAcc", cbs, gps);
> > +
> >  	/*
> >  	 * Callbacks are often registered with incomplete grace-period
> >  	 * information.  Something about the fact that getting exact
> > @@ -1434,6 +1440,11 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
> >  		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
> >  	else
> >  		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
> > +
> > +	/* Count CBs for tracing. */
> > +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> > +	trace_rcu_segcb("SegCbPostAcc", cbs, gps);
> > +
> >  	return ret;
> >  }
> >  
> > @@ -2316,6 +2327,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
> >  	long bl, count;
> >  	long pending, tlimit = 0;
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> >  
> >  	/* If no callbacks are ready, just return. */
> >  	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
> > @@ -2350,6 +2363,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
> >  	/* Invoke callbacks. */
> >  	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
> >  	rhp = rcu_cblist_dequeue(&rcl);
> > +
> > +	/* Count CBs for tracing. */
> > +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> > +	trace_rcu_segcb("SegCbDequeued", cbs, gps);
> > +
> >  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
> >  		rcu_callback_t f;
> >  
> > @@ -2808,6 +2826,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  	unsigned long flags;
> >  	struct rcu_data *rdp;
> >  	bool was_alldone;
> > +	int cbs[RCU_CBLIST_NSEGS];
> > +	unsigned long gps[RCU_CBLIST_NSEGS];
> >  
> >  	/* Misaligned rcu_head! */
> >  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > @@ -2852,6 +2872,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  		trace_rcu_callback(rcu_state.name, head,
> >  				   rcu_segcblist_n_cbs(&rdp->cblist));
> >  
> > +	/* Count CBs for tracing. */
> > +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> > +	trace_rcu_segcb("SegCBQueued", cbs, gps);
> > +
> >  	/* Go handle any RCU core processing required. */
> >  	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> >  	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> > -- 
> > 2.27.0.111.gc72c7da667-goog
> > 
