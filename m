Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A4C56202
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38BA22253
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QXJtgDal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgKTLhB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:37:01 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:13334 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgKTLhB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 06:37:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605872220; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=zeUkBZJSG3m+Px0GQ95i9hVc445A7oX9PZfP5zdKnDo=; b=QXJtgDaleBr2Bka8ycMwoEvidoH+UK30Q53LtDROHW20qBv3J1SaTx3zBXWxcYST/0wZVTz/
 bZj32PEiNzQN8o7CL4U50/nlvImyAerm9d8aqtnQj9/divqTLY7V1xsU8f63oRKVXU4ZFaML
 4GrdTsDLhDfuAYHlRc4rilIn71E=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fb7aa5b7f0cfa6a16d3fc71 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 11:36:59
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD506C43468; Fri, 20 Nov 2020 11:36:58 +0000 (UTC)
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E7DBC433C6;
        Fri, 20 Nov 2020 11:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E7DBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH RFC tip/core/rcu 3/5] srcu: Provide internal interface to
 start a Tree SRCU grace period
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-3-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <69c05cd0-8187-49a7-5b2d-1a10ba42fa44@codeaurora.org>
Date:   Fri, 20 Nov 2020 17:06:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117004052.14758-3-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a polling interface for SRCU grace periods.
> This polling needs to initiate an SRCU grace period without having
> to queue (and manage) a callback.  This commit therefore splits the
> Tree SRCU __call_srcu() function into callback-initialization and
> queuing/start-grace-period portions, with the latter in a new function
> named srcu_gp_start_if_needed().  This function may be passed a NULL
> callback pointer, in which case it will refrain from queuing anything.
> 
> Why have the new function mess with queuing?  Locking considerations,
> of course!
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>


Thanks
Neeraj

>   kernel/rcu/srcutree.c | 66 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 79b7081..d930ece 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -808,6 +808,42 @@ static void srcu_leak_callback(struct rcu_head *rhp)
>   }
>   
>   /*
> + * Start an SRCU grace period, and also queue the callback if non-NULL.
> + */
> +static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
> +{
> +	unsigned long flags;
> +	int idx;
> +	bool needexp = false;
> +	bool needgp = false;
> +	unsigned long s;
> +	struct srcu_data *sdp;
> +
> +	idx = srcu_read_lock(ssp);
> +	sdp = raw_cpu_ptr(ssp->sda);
> +	spin_lock_irqsave_rcu_node(sdp, flags);
> +	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> +	rcu_segcblist_advance(&sdp->srcu_cblist,
> +			      rcu_seq_current(&ssp->srcu_gp_seq));
> +	s = rcu_seq_snap(&ssp->srcu_gp_seq);
> +	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> +	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> +		sdp->srcu_gp_seq_needed = s;
> +		needgp = true;
> +	}
> +	if (!do_norm && ULONG_CMP_LT(sdp->srcu_gp_seq_needed_exp, s)) {
> +		sdp->srcu_gp_seq_needed_exp = s;
> +		needexp = true;
> +	}
> +	spin_unlock_irqrestore_rcu_node(sdp, flags);
> +	if (needgp)
> +		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
> +	else if (needexp)
> +		srcu_funnel_exp_start(ssp, sdp->mynode, s);
> +	srcu_read_unlock(ssp, idx);
> +}
> +
> +/*
>    * Enqueue an SRCU callback on the srcu_data structure associated with
>    * the current CPU and the specified srcu_struct structure, initiating
>    * grace-period processing if it is not already running.
> @@ -838,13 +874,6 @@ static void srcu_leak_callback(struct rcu_head *rhp)
>   static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>   			rcu_callback_t func, bool do_norm)
>   {
> -	unsigned long flags;
> -	int idx;
> -	bool needexp = false;
> -	bool needgp = false;
> -	unsigned long s;
> -	struct srcu_data *sdp;
> -
>   	check_init_srcu_struct(ssp);
>   	if (debug_rcu_head_queue(rhp)) {
>   		/* Probable double call_srcu(), so leak the callback. */
> @@ -853,28 +882,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>   		return;
>   	}
>   	rhp->func = func;
> -	idx = srcu_read_lock(ssp);
> -	sdp = raw_cpu_ptr(ssp->sda);
> -	spin_lock_irqsave_rcu_node(sdp, flags);
> -	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> -	rcu_segcblist_advance(&sdp->srcu_cblist,
> -			      rcu_seq_current(&ssp->srcu_gp_seq));
> -	s = rcu_seq_snap(&ssp->srcu_gp_seq);
> -	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
> -	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
> -		sdp->srcu_gp_seq_needed = s;
> -		needgp = true;
> -	}
> -	if (!do_norm && ULONG_CMP_LT(sdp->srcu_gp_seq_needed_exp, s)) {
> -		sdp->srcu_gp_seq_needed_exp = s;
> -		needexp = true;
> -	}
> -	spin_unlock_irqrestore_rcu_node(sdp, flags);
> -	if (needgp)
> -		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
> -	else if (needexp)
> -		srcu_funnel_exp_start(ssp, sdp->mynode, s);
> -	srcu_read_unlock(ssp, idx);
> +	srcu_gp_start_if_needed(ssp, rhp, do_norm);
>   }
>   
>   /**
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
