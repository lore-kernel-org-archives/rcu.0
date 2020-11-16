Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEFC55ABD
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 19:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F8920829
	for <rcu@archiver.kernel.org>; Mon, 16 Nov 2020 19:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v9yBjVsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgKPTwW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:52:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgKPTwW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 14:52:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD892080A;
        Mon, 16 Nov 2020 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605556341;
        bh=VWhr9jewBX0UGHGFaiENb1K89beC+p+6bup/fl1b+RU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=v9yBjVsC2DCPQqM2Z0JiCPFB6N/gjCPHCyptPSMIZJG1IRENFNQXK9dGTRuqO9PWF
         3Hk1lTb+l9KQs6uf/vBAGXiDp+f8Sl1eJlsnHOgRasnZoGNo9+K5ZZqUwCO7xiK5+o
         4WxeAA0w9+Jcw5AP4C0qgoNVdwus02LhkK2NSSZk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4C0003522684; Mon, 16 Nov 2020 11:52:21 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:52:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH rcu-dev] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201116195221.GB1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201114193132.2660464-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114193132.2660464-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Nov 14, 2020 at 02:31:32PM -0500, Joel Fernandes (Google) wrote:
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

Queued for further review and testing, thank you all!

If testing goes well I expect to put this in the v5.11 bucket.  Here is
hoping...

							Thanx, Paul

> ---
>  include/trace/events/rcu.h | 26 ++++++++++++++++++++++++++
>  kernel/rcu/tree.c          |  9 +++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..5fc29400e1a2 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -505,6 +505,32 @@ TRACE_EVENT_RCU(rcu_callback,
>  		  __entry->qlen)
>  );
>  
> +TRACE_EVENT_RCU(rcu_segcb_stats,
> +
> +		TP_PROTO(struct rcu_segcblist *rs, const char *ctx),
> +
> +		TP_ARGS(rs, ctx),
> +
> +		TP_STRUCT__entry(
> +			__field(const char *, ctx)
> +			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
> +			__array(long, seglen, RCU_CBLIST_NSEGS)
> +		),
> +
> +		TP_fast_assign(
> +			__entry->ctx = ctx;
> +			memcpy(__entry->seglen, rs->seglen, RCU_CBLIST_NSEGS * sizeof(long));
> +			memcpy(__entry->gp_seq, rs->gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
> +
> +		),
> +
> +		TP_printk("%s seglen: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld) "
> +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> +			  __entry->seglen[0], __entry->seglen[1], __entry->seglen[2], __entry->seglen[3],
> +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> +
> +);
> +
>  /*
>   * Tracepoint for the registration of a single RCU callback of the special
>   * kvfree() form.  The first argument is the RCU type, the second argument
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 413831b48648..b96d26d0d44a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
>  		return false;
>  
> +	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
> +
>  	/*
>  	 * Callbacks are often registered with incomplete grace-period
>  	 * information.  Something about the fact that getting exact
> @@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  	else
>  		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
>  
> +	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
> +
>  	return ret;
>  }
>  
> @@ -2473,11 +2477,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
>  	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
>  	if (offloaded)
>  		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> +
> +	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
>  	rcu_nocb_unlock_irqrestore(rdp, flags);
>  
>  	/* Invoke callbacks. */
>  	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
>  	rhp = rcu_cblist_dequeue(&rcl);
> +
>  	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>  		rcu_callback_t f;
>  
> @@ -2989,6 +2996,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		trace_rcu_callback(rcu_state.name, head,
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
> +	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> +
>  	/* Go handle any RCU core processing required. */
>  	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
>  		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
