Return-Path: <SRS0=yvZM=DV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC89BC433DF
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DB22203
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="joF87Aeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgJNPXg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:23:36 -0400
Received: from z5.mailgun.us ([104.130.96.5]:22168 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728432AbgJNPXg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 11:23:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602689014; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=+IIsA+57Axc0TGbzx3J0PJirmqcxQY6ipMrJ2tY6ekA=; b=joF87AegwdywSDViP0P8y0s4VTYYlERW675q1D+QAEpwVj81VN83x8EBszIYMv2dPjuTzxHL
 n9eXlQ1/Nl7u23jMGUH/s7pnCsAvk/0MaZX/NsAbrfm9FL984V9jkcIuG7Rm3I4Aely8V73S
 n8Gkx3hkBnf2ZuOLfp608GMXPRk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f8717b30764f13b00136653 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 15:22:27
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7DEEC433CB; Wed, 14 Oct 2020 15:22:26 +0000 (UTC)
Received: from [192.168.0.102] (unknown [49.206.34.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DAF6C433C9;
        Wed, 14 Oct 2020 15:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7DAF6C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v6 3/4] rcu/trace: Add tracing for how segcb list changes
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
 <20200923152211.2403352-4-joel@joelfernandes.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <be9eb8bc-b776-e122-2182-ca2aac2d1e20@codeaurora.org>
Date:   Wed, 14 Oct 2020 20:52:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200923152211.2403352-4-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/23/2020 8:52 PM, Joel Fernandes (Google) wrote:
> Track how the segcb list changes before/after acceleration, during
> queuing and during dequeuing.
> 
> This has proved useful to discover an optimization to avoid unwanted GP
> requests when there are no callbacks accelerated. The overhead is minimal as
> each segment's length is now stored in the respective segment.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
>   kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
>   kernel/rcu/rcu_segcblist.h |  5 +++++
>   kernel/rcu/tree.c          |  9 +++++++++
>   4 files changed, 73 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 155b5cb43cfd..7b84df3c95df 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
>   		  __entry->qlen)
>   );
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

Use RCU_CBLIST_NSEGS in place of 4 ?
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
>   /*
>    * Tracepoint for the registration of a single RCU callback of the special
>    * kvfree() form.  The first argument is the RCU type, the second argument
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 0e6d19bd3de9..df0f31e30947 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -13,6 +13,7 @@
>   #include <linux/rcupdate.h>
>   
>   #include "rcu_segcblist.h"
> +#include "rcu.h"
>   
>   /* Initialize simple callback list. */
>   void rcu_cblist_init(struct rcu_cblist *rclp)
> @@ -343,6 +344,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
>   	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
>   }
>   
> +/*
> + * Return how many CBs each segment along with their gp_seq values.
> + *
> + * This function is O(N) where N is the number of callbacks. Only used from

N is number of segments?

> + * tracing code which is usually disabled in production.
> + */
> +#ifdef CONFIG_RCU_TRACE
> +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> +			 int cbcount[RCU_CBLIST_NSEGS],
> +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> +{
> +	int i;
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
> +		cbcount[i] = 0;
> +

What is the reason for initializing to 0?

> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> +		gpseq[i] = rsclp->gp_seq[i];
> +	}
> +}
> +
> +void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context)
> +{
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
> +
> +	rcu_segcblist_countseq(rsclp, cbs, gps);
> +
> +	trace_rcu_segcb(context, cbs, gps);
> +}
> +#endif
> +
>   /*
>    * Extract only those callbacks still pending (not yet ready to be
>    * invoked) from the specified rcu_segcblist structure and place them in
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 3e0eb1056ae9..15c10d30f88c 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -103,3 +103,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
>   bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
>   void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
>   			 struct rcu_segcblist *src_rsclp);
> +#ifdef CONFIG_RCU_TRACE
> +void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context);
> +#else
> +#define trace_rcu_segcb_list(...)
> +#endif
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 50af465729f4..e3381ff67fc6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1492,6 +1492,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>   	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
>   		return false;
>   
> +	trace_rcu_segcb_list(&rdp->cblist, "SegCbPreAcc");

Use TPS("SegCbPreAcc") ?


Thanks
Neeraj

> +
>   	/*
>   	 * Callbacks are often registered with incomplete grace-period
>   	 * information.  Something about the fact that getting exact
> @@ -1512,6 +1514,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>   	else
>   		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
>   
> +	trace_rcu_segcb_list(&rdp->cblist, "SegCbPostAcc");
> +
>   	return ret;
>   }
>   
> @@ -2469,6 +2473,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   	/* Invoke callbacks. */
>   	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
>   	rhp = rcu_cblist_dequeue(&rcl);
> +
> +	trace_rcu_segcb_list(&rdp->cblist, "SegCbDequeued");
> +
>   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>   		rcu_callback_t f;
>   
> @@ -2982,6 +2989,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>   		trace_rcu_callback(rcu_state.name, head,
>   				   rcu_segcblist_n_cbs(&rdp->cblist));
>   
> +	trace_rcu_segcb_list(&rdp->cblist, "SegCBQueued");
> +
>   	/* Go handle any RCU core processing required. */
>   	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
>   	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
