Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BFC433E1
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B50F20786
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592518605;
	bh=vp/SetVWiDplCHFEq5Q6ees2AeatpWF/JrR/DBv7qH0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dlmPLOev8HqmNK8U14XhRDn0+cMM+dJlQaH4FsVK6A96j0F3f6D6iRqrQ8f9ful6Y
	 kgj+y73pqWcmW394GFaWArmZ9Tq46p9mpZ3zXe6Uo0Z8P+Djq8o0uZG3D2UOjuKHxg
	 fFTil5ZfcooISTHCxV8n2xuA/SsngkMivsdVlax4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgFRWQn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731811AbgFRWQl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 18:16:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF51F207D8;
        Thu, 18 Jun 2020 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592518599;
        bh=vp/SetVWiDplCHFEq5Q6ees2AeatpWF/JrR/DBv7qH0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R/EiFM4dUIdNPR+uTDhEPM52KejUsnJQbJRGLsQVGT/AakiGHsjNVE6fiJO+pVC7v
         YMgy6WHevA5dD16ZWgVVB/txkALDkxcokWy6VC0HPSmaDnx7RHXQOk0FrzRmtMIUBk
         y6RGFB44Pl9SwLej/zJnnKZyFAaRKiI2UAuTXEIA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AE101352264E; Thu, 18 Jun 2020 15:16:39 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:16:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 2/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20200618221639.GY2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618202955.4024-2-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:29:50PM -0400, Joel Fernandes (Google) wrote:
> Track how the segcb list changes before/after acceleration, during
> queuing and during dequeuing.
> 
> This has proved useful to discover an optimization to avoid unwanted GP
> requests when there are no callbacks accelerated.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

It does look like it provides some useful information, but the fact
that callback lists can contain millions of callbacks makes the
rcu_segcblist_countseq() a non-starter for mainline use.

One thing that has been on my list for some time is to associate counts
with the rcu_segcblist segments, which would make this sort of tracing
more palatable.  This would be a fiddly change requiring careful testing,
which might be why I have not yet done it myself.  One benefit of such
counts is to allow RCU to determine whether callbacks are being held up by
the grace period on the one hand or by callback invocation on the other.

						Thanx, Paul

> ---
>  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.c | 37 +++++++++++++++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.h |  7 +++++++
>  kernel/rcu/tree.c          | 24 ++++++++++++++++++++++++
>  4 files changed, 93 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 02dcd119f3263..a6d49864dcc27 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -507,6 +507,31 @@ TRACE_EVENT_RCU(rcu_callback,
>  		  __entry->qlen)
>  );
>  
> +TRACE_EVENT_RCU(rcu_segcb,
> +
> +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> +
> +		TP_ARGS(ctx, cb_count, gp_seq),
> +
> +		TP_STRUCT__entry(
> +			__field(const char *, ctx)
> +			__array(int, cb_count, 4)
> +			__array(unsigned long, gp_seq, 4)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->ctx = ctx;
> +			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
> +			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
> +		),
> +
> +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> +
> +);
> +
>  /*
>   * Tracepoint for the registration of a single RCU callback of the special
>   * kfree() form.  The first argument is the RCU type, the second argument
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 4782cf17bf4f9..036d4abac7c5a 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -316,6 +316,43 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
>  }
>  
> +/*
> + * Return how many CBs each segment along with their gp_seq values.
> + *
> + * This function is O(N) where N is the number of callbacks. Only used from
> + * tracing code which is usually disabled in production.
> + */
> +#ifdef CONFIG_RCU_TRACE
> +void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> +			 int cbcount[RCU_CBLIST_NSEGS],
> +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> +{
> +	struct rcu_head **cur_tail, *h;
> +	int i, c;
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> +		cbcount[i] = 0;
> +
> +	cur_tail = &(rsclp->head);
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> +		c = 0;
> +		// List empty?
> +		if (rsclp->tails[i] != cur_tail) {
> +			// The loop skips the last node
> +			c = 1;
> +			for (h = *cur_tail; h->next != *(rsclp->tails[i]); h = h->next) {
> +				c++;
> +			}
> +		}
> +
> +		cbcount[i] = c;
> +		gpseq[i] = rsclp->gp_seq[i];
> +		cur_tail = rsclp->tails[i];
> +	}
> +}
> +#endif
> +
>  /*
>   * Extract only those callbacks still pending (not yet ready to be
>   * invoked) from the specified rcu_segcblist structure and place them in
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 5c293afc07b8e..0a8dbac438529 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -104,3 +104,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
>  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
>  void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>  			 struct rcu_segcblist *src_rsclp);
> +#ifdef CONFIG_RCU_TRACE
> +void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> +			 int cbcount[RCU_CBLIST_NSEGS],
> +			 unsigned long gpseq[RCU_CBLIST_NSEGS]);
> +#else
> +#define rcu_segcblist_countseq(...)
> +#endif
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ebce14e470d0e..c61af6a33fbfd 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1407,6 +1407,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  {
>  	unsigned long gp_seq_req;
>  	bool ret = false;
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
>  
>  	rcu_lockdep_assert_cblist_protected(rdp);
>  	raw_lockdep_assert_held_rcu_node(rnp);
> @@ -1415,6 +1417,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
>  		return false;
>  
> +	/* Count CBs for tracing. */
> +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> +	trace_rcu_segcb("SegCbPreAcc", cbs, gps);
> +
>  	/*
>  	 * Callbacks are often registered with incomplete grace-period
>  	 * information.  Something about the fact that getting exact
> @@ -1434,6 +1440,11 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
>  	else
>  		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
> +
> +	/* Count CBs for tracing. */
> +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> +	trace_rcu_segcb("SegCbPostAcc", cbs, gps);
> +
>  	return ret;
>  }
>  
> @@ -2316,6 +2327,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	long bl, count;
>  	long pending, tlimit = 0;
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
>  
>  	/* If no callbacks are ready, just return. */
>  	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
> @@ -2350,6 +2363,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	/* Invoke callbacks. */
>  	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
>  	rhp = rcu_cblist_dequeue(&rcl);
> +
> +	/* Count CBs for tracing. */
> +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> +	trace_rcu_segcb("SegCbDequeued", cbs, gps);
> +
>  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>  		rcu_callback_t f;
>  
> @@ -2808,6 +2826,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct rcu_data *rdp;
>  	bool was_alldone;
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
>  
>  	/* Misaligned rcu_head! */
>  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> @@ -2852,6 +2872,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		trace_rcu_callback(rcu_state.name, head,
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
> +	/* Count CBs for tracing. */
> +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> +	trace_rcu_segcb("SegCBQueued", cbs, gps);
> +
>  	/* Go handle any RCU core processing required. */
>  	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
>  	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
