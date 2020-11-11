Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9612EC388F7
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 00:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FFE21D40
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 00:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLM94lnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKKAfc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Nov 2020 19:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKKAfb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Nov 2020 19:35:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAD720679;
        Wed, 11 Nov 2020 00:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605054930;
        bh=D4jRiWxXxP++VO1TwA+JplWahrx6eqTYDL3lhjn7rqI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LLM94lnRmmLKQRerEugNOB/zyx6DNmVC/zRxQg7alL0TtJVW5aixY1ZffmDepXDqf
         5SHkvt4Ss9v24WPrcs5x8UGfxE1zM2lS7K7cpEIgo2VZ72NEDthrDyRxqdd+hscT/s
         AbmWQoqUUNAQp9VveywQ++hQTd5KGACRiYRLFu70=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3CA2A35226CB; Tue, 10 Nov 2020 16:35:30 -0800 (PST)
Date:   Tue, 10 Nov 2020 16:35:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201111003530.GA10251@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-5-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 09:26:00AM -0500, Joel Fernandes (Google) wrote:
> Track how the segcb list changes before/after acceleration, during
> queuing and during dequeuing.
> 
> This has proved useful to discover an optimization to avoid unwanted GP
> requests when there are no callbacks accelerated. The overhead is minimal as
> each segment's length is now stored in the respective segment.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I thought I had responded to this one, but I find no record of having
done so.  But please see below for some questions and comments.

> ---
>  include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
>  kernel/rcu/rcu_segcblist.h |  5 +++++
>  kernel/rcu/tree.c          |  9 +++++++++
>  4 files changed, 73 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..5f8f2ee1a936 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
>  		  __entry->qlen)
>  );
>  
> +TRACE_EVENT_RCU(rcu_segcb_stats,
> +
> +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
> +
> +		TP_ARGS(ctx, cb_count, gp_seq),
> +
> +		TP_STRUCT__entry(
> +			__field(const char *, ctx)
> +			__array(int, cb_count, RCU_CBLIST_NSEGS)
> +			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->ctx = ctx;
> +			memcpy(__entry->cb_count, cb_count, RCU_CBLIST_NSEGS * sizeof(int));
> +			memcpy(__entry->gp_seq, gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));

OK, I will bite...

Why not include linux/rcu_segcblist.h and then fold all of
rcu_segcblist_countseq() and much of __trace_rcu_segcb_stats() into
this TP_fast_assign()?  If you must have "unsigned int" for cb_count,
then you can use "do {} while (0)" to declare the index variable, but
if you can use unsigned long as suggested by Neeraj, you can just use
a pair of memcpy()s.

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
> index 357c19bbcb00..2a03949d0b82 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  
>  #include "rcu_segcblist.h"
> +#include "rcu.h"
>  
>  /* Initialize simple callback list. */
>  void rcu_cblist_init(struct rcu_cblist *rclp)
> @@ -328,6 +329,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>  	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>  }
>  
> +/*
> + * Return how many CBs each segment along with their gp_seq values.
> + *
> + * This function is O(N) where N is the number of segments. Only used from
> + * tracing code which is usually disabled in production.
> + */
> +#ifdef CONFIG_RCU_TRACE
> +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> +			 int cbcount[RCU_CBLIST_NSEGS],
> +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> +{
> +	int i;
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> +		gpseq[i] = rsclp->gp_seq[i];
> +	}
> +}
> +
> +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> +{
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
> +
> +	if (!trace_rcu_segcb_stats_enabled())
> +		return;

Can't you rely on the trace system to enable and disable this trace
event?  If the thought is to save instructions, then moving all this
into TP_fast_assign() enables the trace system to deal with that as well.

> +	rcu_segcblist_countseq(rsclp, cbs, gps);
> +
> +	trace_rcu_segcb_stats(context, cbs, gps);
> +}
> +#endif
> +
>  /*
>   * Extract only those callbacks still pending (not yet ready to be
>   * invoked) from the specified rcu_segcblist structure and place them in
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index cd35c9faaf51..7750734fa116 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
>  bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
>  void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>  			 struct rcu_segcblist *src_rsclp);
> +#ifdef CONFIG_RCU_TRACE
> +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context);
> +#else
> +#define __trace_rcu_segcb_stats(...)
> +#endif

And letting TP_fast_assign() to the work allows this to go away...

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 24c00020ab83..f6c6653b3ec2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
>  		return false;
>  
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));

...and you don't need the "__" everywhere.

So what am I missing here?

						Thanx, Paul

> +
>  	/*
>  	 * Callbacks are often registered with incomplete grace-period
>  	 * information.  Something about the fact that getting exact
> @@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	else
>  		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
>  
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
> +
>  	return ret;
>  }
>  
> @@ -2466,11 +2470,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
>  	if (offloaded)
>  		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> +
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
>  
>  	/* Invoke callbacks. */
>  	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
>  	rhp = rcu_cblist_dequeue(&rcl);
> +
>  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>  		rcu_callback_t f;
>  
> @@ -2983,6 +2990,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		trace_rcu_callback(rcu_state.name, head,
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> +
>  	/* Go handle any RCU core processing required. */
>  	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
>  		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 
