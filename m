Return-Path: <SRS0=XTmi=EK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A65C2D0A3
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9020867
	for <rcu@archiver.kernel.org>; Wed,  4 Nov 2020 13:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F3XGktgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgKDNiU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:38:20 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:25726 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbgKDNiT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Nov 2020 08:38:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604497099; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RxrPn8ohTBs9IISAW9lDtPNqPK2tcUCvIx4y39dCtjI=; b=F3XGktgwT8WN13ywjgy2PDso3a3AdxOABjDDWaQpytq0dsM8M4hPhkqH5PecVYSYyniE3s1k
 lIOHM8pFhP356EI4QDZRejJ74c71Ac5/5w6Gh/SoB66rBcluDltve6Y5jNprLxL1U6mh/CWW
 RhDBOUjx5d+1XXAQSzV3zeWgWtU=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fa2aebaedd210180f981e63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 13:38:02
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 71A6BC433C6; Wed,  4 Nov 2020 13:38:01 +0000 (UTC)
Received: from [192.168.0.103] (unknown [124.123.167.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF36AC433C8;
        Wed,  4 Nov 2020 13:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF36AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v9 3/7] srcu: Fix invoke_rcu_callbacks() segcb length
 adjustment
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
 <20201103142603.1302207-4-joel@joelfernandes.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <5fd2a2cc-71eb-e557-8cde-5dc0e166396f@codeaurora.org>
Date:   Wed, 4 Nov 2020 19:07:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103142603.1302207-4-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/3/2020 7:55 PM, Joel Fernandes (Google) wrote:
> With earlier patches, the negative counting of the unsegmented list
> cannot be used to adjust the segmented one. To fix this, sample the
> unsegmented length in advance, and use it after CB execution to adjust
> the segmented list's length.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>

>   kernel/rcu/srcutree.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 0f23d20d485a..79b7081143a7 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1160,6 +1160,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
>    */
>   static void srcu_invoke_callbacks(struct work_struct *work)
>   {
> +	long len;
>   	bool more;
>   	struct rcu_cblist ready_cbs;
>   	struct rcu_head *rhp;
> @@ -1182,6 +1183,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>   	/* We are on the job!  Extract and invoke ready callbacks. */
>   	sdp->srcu_cblist_invoking = true;
>   	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
> +	len = ready_cbs.len;
>   	spin_unlock_irq_rcu_node(sdp);
>   	rhp = rcu_cblist_dequeue(&ready_cbs);
>   	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
> @@ -1190,13 +1192,14 @@ static void srcu_invoke_callbacks(struct work_struct *work)
>   		rhp->func(rhp);
>   		local_bh_enable();
>   	}
> +	WARN_ON_ONCE(ready_cbs.len);
>   
>   	/*
>   	 * Update counts, accelerate new callbacks, and if needed,
>   	 * schedule another round of callback invocation.
>   	 */
>   	spin_lock_irq_rcu_node(sdp);
> -	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
> +	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
>   	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
>   				       rcu_seq_snap(&ssp->srcu_gp_seq));
>   	sdp->srcu_cblist_invoking = false;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
