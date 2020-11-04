Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB4EC388F7
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0A62344C
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 13:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jrd/Ketx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgKDNk1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:40:27 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:25726 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKDNk1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 08:40:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604497226; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RpVoMAO7pE7bPDbOQefCI2LLXeTHBoEF7ybXZpUMBOc=; b=jrd/Ketx/nfQEW/XZ0wuHoH2VcFAnqmZvxMMXkqAtl5xNeckbVwF09f76Xa/7ey0bPkwAEZs
 JjyArGlijg2DXRWU3XRZksTT2xBr2ooJ8lg/60i1RR16Vy1Ms8I8i3Vw6O4wgdQg17mLBYh+
 M70j3dyjh/4vvLD8Smlyn3q00Yc=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fa2af4ac4a50c2467527411 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 13:40:26
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 226BAC433C9; Wed,  4 Nov 2020 13:40:25 +0000 (UTC)
Received: from [192.168.0.103] (unknown [124.123.167.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC7B7C433C8;
        Wed,  4 Nov 2020 13:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC7B7C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <58c89893-1bf7-29bb-7f97-2e48755e8dd7@codeaurora.org>
Date:   Wed, 4 Nov 2020 19:10:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103142603.1302207-5-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/3/2020 7:56 PM, Joel Fernandes (Google) wrote:
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
> ---
>   include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
>   kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
>   kernel/rcu/rcu_segcblist.h |  5 +++++
>   kernel/rcu/tree.c          |  9 +++++++++
>   4 files changed, 73 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..5f8f2ee1a936 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
>   		  __entry->qlen)
>   );
>   
> +TRACE_EVENT_RCU(rcu_segcb_stats,
> +
> +		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),

I think we need to use long[] instead of int[] for cb_count everywhere 
in this patch?


Thanks
Neeraj

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
> +		),
> +
> +		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
> +			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
> +			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
> +			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
> +
> +);
> +
>   /*
>    * Tracepoint for the registration of a single RCU callback of the special
>    * kvfree() form.  The first argument is the RCU type, the second argument
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 357c19bbcb00..2a03949d0b82 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -14,6 +14,7 @@
>   #include <linux/types.h>
>   
>   #include "rcu_segcblist.h"
> +#include "rcu.h"
>   
>   /* Initialize simple callback list. */
>   void rcu_cblist_init(struct rcu_cblist *rclp)
> @@ -328,6 +329,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>   	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>   }
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
> +
> +	rcu_segcblist_countseq(rsclp, cbs, gps);
> +
> +	trace_rcu_segcb_stats(context, cbs, gps);
> +}
> +#endif
> +
>   /*
>    * Extract only those callbacks still pending (not yet ready to be
>    * invoked) from the specified rcu_segcblist structure and place them in
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index cd35c9faaf51..7750734fa116 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
>   bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
>   void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>   			 struct rcu_segcblist *src_rsclp);
> +#ifdef CONFIG_RCU_TRACE
> +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context);
> +#else
> +#define __trace_rcu_segcb_stats(...)
> +#endif
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 24c00020ab83..f6c6653b3ec2 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1497,6 +1497,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>   	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
>   		return false;
>   
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
> +
>   	/*
>   	 * Callbacks are often registered with incomplete grace-period
>   	 * information.  Something about the fact that getting exact
> @@ -1517,6 +1519,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>   	else
>   		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
>   
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
> +
>   	return ret;
>   }
>   
> @@ -2466,11 +2470,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
>   	if (offloaded)
>   		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> +
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
>   	rcu_nocb_unlock_irqrestore(rdp, flags);
>   
>   	/* Invoke callbacks. */
>   	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
>   	rhp = rcu_cblist_dequeue(&rcl);
> +
>   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>   		rcu_callback_t f;
>   
> @@ -2983,6 +2990,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>   		trace_rcu_callback(rcu_state.name, head,
>   				   rcu_segcblist_n_cbs(&rdp->cblist));
>   
> +	__trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
> +
>   	/* Go handle any RCU core processing required. */
>   	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
>   		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
