Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD0C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 21:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D6A20738
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598392555;
	bh=GkXzOxPvKqAlXfXqK4iEZQTpxUw94ZFAMY00sROf4Y8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FpnZHiGseDqP9EwdCiIjtnXbmJZdes6POIIqpPLaR439wPn9+mfe8pQJeO3VXFdA/
	 UQaRUBr4AssnEy0M3uEL9+it77UniWSQUP1p10Mnqm+lyznmjyvhSyD94ZRg8kfZP9
	 bl2EYjZDH84YsY0U6oEBpA+2t46m/LNgrxFDQUvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHYVzz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHYVzy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Aug 2020 17:55:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 875002071E;
        Tue, 25 Aug 2020 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598392553;
        bh=GkXzOxPvKqAlXfXqK4iEZQTpxUw94ZFAMY00sROf4Y8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S0x8+TuY+lokER/QMwot7w3n8bRkZHbNZwBHloxeagOwNemlPINHwRxm4/Zz/P6Lu
         tKoonFNZmwfw5x0tUnHgi9Lkacv/GUEq9SYSD13veJqMenkXLpoiwbq9yQ/EG5xyAY
         WyabEHIw/abOgINJu1oXlRQ6kMIZm4yRBuaRv47w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4CEE0352304D; Tue, 25 Aug 2020 14:55:53 -0700 (PDT)
Date:   Tue, 25 Aug 2020 14:55:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dave@stgolabs.net, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: Re: [PATCH v4 -rcu 4/4] rcu/trace: Add tracing for how segcb list
 changes
Message-ID: <20200825215553.GB16846@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200825024842.3408659-1-joel@joelfernandes.org>
 <20200825024842.3408659-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825024842.3408659-5-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 24, 2020 at 10:48:42PM -0400, Joel Fernandes (Google) wrote:
> Track how the segcb list changes before/after acceleration, during
> queuing and during dequeuing.
> 
> This has proved useful to discover an optimization to avoid unwanted GP
> requests when there are no callbacks accelerated. The overhead is minimal as
> each segment's length is now stored in the respective segment.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Speaking of tracing, diagnostics, and debugging, a few instances of
ASSERT_EXCLUSIVE_WRITER() in the previous patch might save a lot
of debugging.  Help KCSAN help us.

> ---
>  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.c | 27 +++++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.h |  7 +++++++
>  kernel/rcu/tree.c          | 23 +++++++++++++++++++++++
>  4 files changed, 82 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..7b84df3c95df 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
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
>   * kvfree() form.  The first argument is the RCU type, the second argument
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 73a103464ea4..6419dbbaecde 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -378,6 +378,33 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
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

Why not declare the arrays here and invoke the new trace event from
here also?  That would simplify the usage and save a few lines of code.

						Thanx, Paul

> +	struct rcu_head **cur_tail;
> +	int i;
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> +		cbcount[i] = 0;
> +
> +	cur_tail = &(rsclp->head);
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
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
> index b90725f81d77..5f7cdfed0ba4 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -105,3 +105,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
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
> index 51348144a4ea..16ad99a9ebba 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1476,6 +1476,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  {
>  	unsigned long gp_seq_req;
>  	bool ret = false;
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
>  
>  	rcu_lockdep_assert_cblist_protected(rdp);
>  	raw_lockdep_assert_held_rcu_node(rnp);
> @@ -1484,6 +1486,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
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
> @@ -1504,6 +1510,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	else
>  		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
>  
> +	/* Count CBs for tracing. */
> +	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> +	trace_rcu_segcb("SegCbPostAcc", cbs, gps);
> +
>  	return ret;
>  }
>  
> @@ -2421,6 +2431,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	long bl, count = 0;
>  	long pending, tlimit = 0;
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
>  
>  	/* If no callbacks are ready, just return. */
>  	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
> @@ -2461,6 +2473,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
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
> @@ -2929,6 +2946,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	unsigned long flags;
>  	struct rcu_data *rdp;
>  	bool was_alldone;
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
>  
>  	/* Misaligned rcu_head! */
>  	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> @@ -2974,6 +2993,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
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
> 2.28.0.297.g1956fa8f8d-goog
> 
