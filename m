Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8446C5519F
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323DB22253
	for <rcu@archiver.kernel.org>; Fri, 20 Nov 2020 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xZnP7D23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgKTMCW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 07:02:22 -0500
Received: from z5.mailgun.us ([104.130.96.5]:63773 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbgKTMCW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 07:02:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605873742; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ts54798rTxZTjmbOx4G3RHPyu+HPUuWjafwL48ciZWc=; b=xZnP7D23t4sqlLNpsSVdfxANsiE3YRUuJuBRA09ONQztGyUz2FEUmvjqf8oukst1uK90NzEg
 Q4FfnIx2wUOZSBtURtDp5udxixxqR59JZjOFBNkzoB5PoCObbFjzjS3UozsAnOqrjiJJba2w
 tJeaB0KS+eHCo2dBAAZPNLd9UNM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fb7b0301dba509aaeba91b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Nov 2020 12:01:52
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F420C43468; Fri, 20 Nov 2020 12:01:52 +0000 (UTC)
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAE53C43460;
        Fri, 20 Nov 2020 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAE53C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH RFC tip/core/rcu 5/5] srcu: Provide polling interfaces for
 Tree SRCU grace periods
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-5-paulmck@kernel.org>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <dca110ff-81d1-17b6-06d9-0fdd61363465@codeaurora.org>
Date:   Fri, 20 Nov 2020 17:31:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117004052.14758-5-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
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
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/srcutree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d930ece..015d80e 100644
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
> @@ -822,7 +823,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>   	idx = srcu_read_lock(ssp);
>   	sdp = raw_cpu_ptr(ssp->sda);
>   	spin_lock_irqsave_rcu_node(sdp, flags);
> -	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> +	if (rhp)
> +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>   	rcu_segcblist_advance(&sdp->srcu_cblist,
>   			      rcu_seq_current(&ssp->srcu_gp_seq));
>   	s = rcu_seq_snap(&ssp->srcu_gp_seq);
> @@ -841,6 +843,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>   	else if (needexp)
>   		srcu_funnel_exp_start(ssp, sdp->mynode, s);
>   	srcu_read_unlock(ssp, idx);
> +	return s;
>   }
>   
>   /*
> @@ -882,7 +885,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>   		return;
>   	}
>   	rhp->func = func;
> -	srcu_gp_start_if_needed(ssp, rhp, do_norm);
> +	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
>   }
>   
>   /**
> @@ -1011,6 +1014,60 @@ void synchronize_srcu(struct srcu_struct *ssp)
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
> +        // before the load from ->srcu_gp_seq.
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
> +	smp_mb(); // ^^^

Minor: Should this comment be more descriptive?



Thanks
Neeraj

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
