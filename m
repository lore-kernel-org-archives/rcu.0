Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7CC5519F
	for <rcu@archiver.kernel.org>; Sun, 22 Nov 2020 14:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3911520789
	for <rcu@archiver.kernel.org>; Sun, 22 Nov 2020 14:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vJyZEOdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKVOXm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 22 Nov 2020 09:23:42 -0500
Received: from z5.mailgun.us ([104.130.96.5]:48120 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgKVOXk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 22 Nov 2020 09:23:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606055019; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Qbk4lITnLr1zMdM2FZ1pm/SnJvA/VeqVHp7zTxf2TRw=; b=vJyZEOdSF5TMv+hSH91ddYZVUjHm8g/73DR4EKTbnkGDoiOJF4AjOkaE7kq2/I6pgF61K3dc
 nw6Qa1tEgQVBQHSUcr8PrV5MkefPDASQOv0MUErFhJGMiaGHdPmeZSFyUKmvsiKRo1BXF+Cx
 4R9n216Uvj2W9PGb/Qn8nW5/evI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fba745de9b70886222061ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 22 Nov 2020 14:23:25
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 649E6C43467; Sun, 22 Nov 2020 14:23:24 +0000 (UTC)
Received: from [192.168.0.101] (unknown [124.123.182.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2652C433C6;
        Sun, 22 Nov 2020 14:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2652C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH RFC tip/core/rcu 5/5] srcu: Provide polling interfaces for
 Tree SRCU grace periods
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
 <20201117004052.14758-5-paulmck@kernel.org>
 <dca110ff-81d1-17b6-06d9-0fdd61363465@codeaurora.org>
 <20201121001602.GO1437@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <60163765-35ad-fa8b-a7a9-1f7596c3e9b5@codeaurora.org>
Date:   Sun, 22 Nov 2020 19:52:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201121001602.GO1437@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/21/2020 5:46 AM, Paul E. McKenney wrote:
> On Fri, Nov 20, 2020 at 05:31:43PM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 11/17/2020 6:10 AM, paulmck@kernel.org wrote:
>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>>
>>> There is a need for a polling interface for SRCU grace
>>> periods, so this commit supplies get_state_synchronize_srcu(),
>>> start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
>>> purpose.  The first can be used if future grace periods are inevitable
>>> (perhaps due to a later call_srcu() invocation), the second if future
>>> grace periods might not otherwise happen, and the third to check if a
>>> grace period has elapsed since the corresponding call to either of the
>>> first two.
>>>
>>> As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
>>> the return value from either get_state_synchronize_srcu() or
>>> start_poll_synchronize_srcu() must be passed in to a later call to
>>> poll_state_synchronize_srcu().
>>>
>>> Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
>>> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
>>> [ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>    kernel/rcu/srcutree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>>    1 file changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>>> index d930ece..015d80e 100644
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -810,7 +810,8 @@ static void srcu_leak_callback(struct rcu_head *rhp)
>>>    /*
>>>     * Start an SRCU grace period, and also queue the callback if non-NULL.
>>>     */
>>> -static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
>>> +static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>>> +					     struct rcu_head *rhp, bool do_norm)
>>>    {
>>>    	unsigned long flags;
>>>    	int idx;
>>> @@ -822,7 +823,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>>>    	idx = srcu_read_lock(ssp);
>>>    	sdp = raw_cpu_ptr(ssp->sda);
>>>    	spin_lock_irqsave_rcu_node(sdp, flags);
>>> -	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>>> +	if (rhp)
>>> +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
>>>    	rcu_segcblist_advance(&sdp->srcu_cblist,
>>>    			      rcu_seq_current(&ssp->srcu_gp_seq));
>>>    	s = rcu_seq_snap(&ssp->srcu_gp_seq);
>>> @@ -841,6 +843,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
>>>    	else if (needexp)
>>>    		srcu_funnel_exp_start(ssp, sdp->mynode, s);
>>>    	srcu_read_unlock(ssp, idx);
>>> +	return s;
>>>    }
>>>    /*
>>> @@ -882,7 +885,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
>>>    		return;
>>>    	}
>>>    	rhp->func = func;
>>> -	srcu_gp_start_if_needed(ssp, rhp, do_norm);
>>> +	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
>>>    }
>>>    /**
>>> @@ -1011,6 +1014,60 @@ void synchronize_srcu(struct srcu_struct *ssp)
>>>    }
>>>    EXPORT_SYMBOL_GPL(synchronize_srcu);
>>> +/**
>>> + * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
>>> + * @ssp: srcu_struct to provide cookie for.
>>> + *
>>> + * This function returns a cookie that can be passed to
>>> + * poll_state_synchronize_srcu(), which will return true if a full grace
>>> + * period has elapsed in the meantime.  It is the caller's responsibility
>>> + * to make sure that grace period happens, for example, by invoking
>>> + * call_srcu() after return from get_state_synchronize_srcu().
>>> + */
>>> +unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
>>> +{
>>> +	// Any prior manipulation of SRCU-protected data must happen
>>> +        // before the load from ->srcu_gp_seq.
>>> +	smp_mb();
>>> +	return rcu_seq_snap(&ssp->srcu_gp_seq);
>>> +}
>>> +EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
>>> +
>>> +/**
>>> + * start_poll_synchronize_srcu - Provide cookie and start grace period
>>> + * @ssp: srcu_struct to provide cookie for.
>>> + *
>>> + * This function returns a cookie that can be passed to
>>> + * poll_state_synchronize_srcu(), which will return true if a full grace
>>> + * period has elapsed in the meantime.  Unlike get_state_synchronize_srcu(),
>>> + * this function also ensures that any needed SRCU grace period will be
>>> + * started.  This convenience does come at a cost in terms of CPU overhead.
>>> + */
>>> +unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
>>> +{
>>> +	return srcu_gp_start_if_needed(ssp, NULL, true);
>>> +}
>>> +EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
>>> +
>>> +/**
>>> + * poll_state_synchronize_srcu - Has cookie's grace period ended?
>>> + * @ssp: srcu_struct to provide cookie for.
>>> + * @cookie: Return value from get_state_synchronize_srcu() or start_poll_synchronize_srcu().
>>> + *
>>> + * This function takes the cookie that was returned from either
>>> + * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
>>> + * returns @true if an SRCU grace period elapsed since the time that the
>>> + * cookie was created.
>>> + */
>>> +bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
>>> +{
>>> +	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
>>> +		return false;
>>> +	smp_mb(); // ^^^
>>
>> Minor: Should this comment be more descriptive?
> 
> You have to read between the lines?  ;-)

:)

> How about like this?
> 

Looks good to me!

Thanks
Neeraj

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
> {
> 	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
> 		return false;
> 	// Ensure that the end of the SRCU grace period happens before
> 	// any subsequent code that the caller might execute.
> 	smp_mb(); // ^^^
> 	return true;
> }
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
