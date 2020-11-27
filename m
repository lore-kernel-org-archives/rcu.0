Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C9C2D0E4
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 04:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B042222A
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 04:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v/wxUnB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392457AbgK0ExZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Nov 2020 23:53:25 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:25530 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392444AbgK0ExZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 Nov 2020 23:53:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606452804; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=xM24JflFy1SAsCAGU2vOf/vt49oiaZncEUPC7LPr8h0=; b=v/wxUnB+WpGXqFamh7n04VBJWtBuh9KDmMoEpRyg5EaqUhthJwa37USPOJtxR0PYJ3uQF1kG
 HfMEZEB/SAbt6wRwOYimffXcr2RcGYb2R/WMMhicpB6TVDdcggQcwNlI+UVoqpcYaYh3NshZ
 oRokKwrHAaeHu0wfe7jFbGCxfdw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fc0863e4146c5eefdbfe31b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Nov 2020 04:53:18
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2E33C43468; Fri, 27 Nov 2020 04:53:17 +0000 (UTC)
Received: from [192.168.0.105] (unknown [49.206.49.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4BE12C433ED;
        Fri, 27 Nov 2020 04:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4BE12C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2 tip/core/rcu 5/6] srcu: Provide polling interfaces for
 Tree SRCU grace periods
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com
References: <@@@> <20201121005919.17152-5-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <05712100-9f65-d81c-1eb0-671bc54f3baa@codeaurora.org>
Date:   Fri, 27 Nov 2020 10:22:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201121005919.17152-5-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> There is a need for a polling interface for SRCU grace
> periods, so this commit supplies get_state_synchronize_srcu(),
> start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
> purpose.  The first can be used if future grace periods are inevitable
> (perhaps due to a later call_srcu() invocation), the second if future
> grace periods might not otherwise happen, and the third to check if a
> grace period has elapsed since the corresponding call to either of the
> first two.
> 
> As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
> the return value from either get_state_synchronize_srcu() or
> start_poll_synchronize_srcu() must be passed in to a later call to
> poll_state_synchronize_srcu().
> 
> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
> [ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
> [ paulmck: Apply feedback from Neeraj Upadhyay. ]
> Link: https://lore.kernel.org/lkml/20201117004017.GA7444@paulmck-ThinkPad-P72/
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

For version in -rcu dev

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>


Thanks
Neeraj

>   kernel/rcu/srcutiny.c |  2 +-
>   kernel/rcu/srcutree.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index b073175..c8f4202 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -148,7 +148,7 @@ void srcu_drive_gp(struct work_struct *wp)
>   	 * straighten that out.
>   	 */
>   	WRITE_ONCE(ssp->srcu_gp_running, false);
> -	if (USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
> +	if (USHORT_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
>   		schedule_work(&ssp->srcu_work);
>   }
>   EXPORT_SYMBOL_GPL(srcu_drive_gp);
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d930ece..945c047 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -810,7 +810,8 @@ static void srcu_leak_callback(struct rcu_head *rhp)
>   /*
>    * Start an SRCU grace period, and also queue the callback if non-NULL.
>    */
> -static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
> +static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> +					     struct rcu_head *rhp, bool do_norm)
>   {
>   	unsigned long flags;
>   	int idx;
> @@ -819,10 +820,12 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>   	unsigned long s;
>   	struct srcu_data *sdp;
>   
> +	check_init_srcu_struct(ssp);
>   	idx = srcu_read_lock(ssp);
>   	sdp = raw_cpu_ptr(ssp->sda);
>   	spin_lock_irqsave_rcu_node(sdp, flags);
> -	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> +	if (rhp)
> +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>   	rcu_segcblist_advance(&sdp->srcu_cblist,
>   			      rcu_seq_current(&ssp->srcu_gp_seq));
>   	s = rcu_seq_snap(&ssp->srcu_gp_seq);
> @@ -841,6 +844,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>   	else if (needexp)
>   		srcu_funnel_exp_start(ssp, sdp->mynode, s);
>   	srcu_read_unlock(ssp, idx);
> +	return s;
>   }
>   
>   /*
> @@ -874,7 +878,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>   static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>   			rcu_callback_t func, bool do_norm)
>   {
> -	check_init_srcu_struct(ssp);
>   	if (debug_rcu_head_queue(rhp)) {
>   		/* Probable double call_srcu(), so leak the callback. */
>   		WRITE_ONCE(rhp->func, srcu_leak_callback);
> @@ -882,7 +885,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>   		return;
>   	}
>   	rhp->func = func;
> -	srcu_gp_start_if_needed(ssp, rhp, do_norm);
> +	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
>   }
>   
>   /**
> @@ -1011,6 +1014,62 @@ void synchronize_srcu(struct srcu_struct *ssp)
>   }
>   EXPORT_SYMBOL_GPL(synchronize_srcu);
>   
> +/**
> + * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
> + * @ssp: srcu_struct to provide cookie for.
> + *
> + * This function returns a cookie that can be passed to
> + * poll_state_synchronize_srcu(), which will return true if a full grace
> + * period has elapsed in the meantime.  It is the caller's responsibility
> + * to make sure that grace period happens, for example, by invoking
> + * call_srcu() after return from get_state_synchronize_srcu().
> + */
> +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
> +{
> +	// Any prior manipulation of SRCU-protected data must happen
> +	// before the load from ->srcu_gp_seq.
> +	smp_mb();
> +	return rcu_seq_snap(&ssp->srcu_gp_seq);
> +}
> +EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
> +
> +/**
> + * start_poll_synchronize_srcu - Provide cookie and start grace period
> + * @ssp: srcu_struct to provide cookie for.
> + *
> + * This function returns a cookie that can be passed to
> + * poll_state_synchronize_srcu(), which will return true if a full grace
> + * period has elapsed in the meantime.  Unlike get_state_synchronize_srcu(),
> + * this function also ensures that any needed SRCU grace period will be
> + * started.  This convenience does come at a cost in terms of CPU overhead.
> + */
> +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
> +{
> +	return srcu_gp_start_if_needed(ssp, NULL, true);
> +}
> +EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
> +
> +/**
> + * poll_state_synchronize_srcu - Has cookie's grace period ended?
> + * @ssp: srcu_struct to provide cookie for.
> + * @cookie: Return value from get_state_synchronize_srcu() or start_poll_synchronize_srcu().
> + *
> + * This function takes the cookie that was returned from either
> + * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
> + * returns @true if an SRCU grace period elapsed since the time that the
> + * cookie was created.
> + */
> +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
> +{
> +	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
> +		return false;
> +	// Ensure that the end of the SRCU grace period happens before
> +	// any subsequent code that the caller might execute.
> +	smp_mb(); // ^^^
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
> +
>   /*
>    * Callback function for srcu_barrier() use.
>    */
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
