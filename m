Return-Path: <SRS0=yvZM=DV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE20C433E7
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8354421582
	for <rcu@archiver.kernel.org>; Wed, 14 Oct 2020 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="H9kRTgb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgJNPGp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:06:45 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:28723 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731469AbgJNPGo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 11:06:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602688003; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=e2kGAgVHzh9Hqu3iJnnfFGTiII18swYy+tQKbtPXPm8=; b=H9kRTgb5TV3cwDEkyB+xkpnPGiCfhb+XSQUkocVCWeUKc1C2sFXCFf1VDu08tB0hgqLiEpXJ
 c5VLj577CTVwDB9nLPJhVvO+Q3SKxTqGdQV5i7FV34A8+0jG6hiSQLHBmz/3/FU8VkPvkX6X
 rp3JUDgGH2rS3ZPvU/x2qNuQ+Oo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f8713f083370fa1c142a4ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 14 Oct 2020 15:06:24
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0EAB3C433FE; Wed, 14 Oct 2020 15:06:24 +0000 (UTC)
Received: from [192.168.0.102] (unknown [49.206.34.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B670C433F1;
        Wed, 14 Oct 2020 15:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B670C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many
 callbacks were executed
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
 <20200923152211.2403352-2-joel@joelfernandes.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <e05fbdf4-546e-4d41-bac0-aa438bc0afcd@codeaurora.org>
Date:   Wed, 14 Oct 2020 20:36:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200923152211.2403352-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/23/2020 8:52 PM, Joel Fernandes (Google) wrote:
> Currently, rcu_do_batch() depends on the unsegmented callback list's len field
> to know how many CBs are executed. This fields counts down from 0 as CBs are
> dequeued.  It is possible that all CBs could not be run because of reaching
> limits in which case the remaining unexecuted callbacks are requeued in the
> CPU's segcblist.
> 
> The number of callbacks that were not requeued are then the negative count (how
> many CBs were run) stored in the rcl->len which has been counting down on every
> dequeue. This negative count is then added to the per-cpu segmented callback
> list's to correct its count.
> 
> Such a design works against future efforts to track the length of each segment
> of the segmented callback list. The reason is because
> rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
> list's length field (rcl->len) during extraction.
> 
> Also, the design of counting down from 0 is confusing and error-prone IMHO.
> 
> This commit therefore explicitly counts have many callbacks were executed in
> rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
> field, without relying on the negativity of rcl->len.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>   kernel/rcu/rcu_segcblist.c | 2 +-
>   kernel/rcu/rcu_segcblist.h | 1 +
>   kernel/rcu/tree.c          | 9 ++++-----
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 2d2a6b6b9dfb..bb246d8c6ef1 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
>    * This increase is fully ordered with respect to the callers accesses
>    * both before and after.
>    */
> -static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
> +void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
>   {
>   #ifdef CONFIG_RCU_NOCB_CPU
>   	smp_mb__before_atomic(); /* Up to the caller! */
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 5c293afc07b8..b90725f81d77 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
>   }
>   
>   void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
> +void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
>   void rcu_segcblist_init(struct rcu_segcblist *rsclp);
>   void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
>   void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7623128d0020..50af465729f4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2427,7 +2427,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   			       rcu_segcblist_is_offloaded(&rdp->cblist);
>   	struct rcu_head *rhp;
>   	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
> -	long bl, count;
> +	long bl, count = 0;
>   	long pending, tlimit = 0;
>   
>   	/* If no callbacks are ready, just return. */
> @@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
>   		rcu_callback_t f;
>   
> +		count++;
>   		debug_rcu_head_unqueue(rhp);
>   
>   		rcu_lock_acquire(&rcu_callback_map);
> @@ -2485,9 +2486,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   
>   		/*
>   		 * Stop only if limit reached and CPU has something to do.
> -		 * Note: The rcl structure counts down from zero.
>   		 */
> -		if (-rcl.len >= bl && !offloaded &&
> +		if (count >= bl && !offloaded &&
>   		    (need_resched() ||
>   		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
>   			break;

Update below usage of -rcl.len also?

if (likely((-rcl.len & 31) || local_clock() < tlimit))


Thanks
Neeraj

> @@ -2510,7 +2510,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   
>   	local_irq_save(flags);
>   	rcu_nocb_lock(rdp);
> -	count = -rcl.len;
>   	rdp->n_cbs_invoked += count;
>   	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
>   			    is_idle_task(current), rcu_is_callbacks_kthread());
> @@ -2518,7 +2517,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
>   	/* Update counts and requeue any remaining callbacks. */
>   	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
>   	smp_mb(); /* List handling before counting for rcu_barrier(). */
> -	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
> +	rcu_segcblist_add_len(&rdp->cblist, -count);
>   
>   	/* Reinstate batch limit if we have worked down the excess. */
>   	count = rcu_segcblist_n_cbs(&rdp->cblist);
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
