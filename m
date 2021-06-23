Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07D7C4743C
	for <rcu@archiver.kernel.org>; Wed, 23 Jun 2021 03:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A119B6135A
	for <rcu@archiver.kernel.org>; Wed, 23 Jun 2021 03:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWD7w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 23:59:52 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:61094 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWD7v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Jun 2021 23:59:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624420655; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=wW6o3uBZEysjylk8SPrMOuZ7g4T1yfR4JhqBnE4nj0s=; b=V/ppx2JWdsXcLJxcvMEG/fPb9oHcdRKXl+CTbSZxbmRr+On5BYs3c8b42leez/msCNFt69XB
 GlUoR2woxFCD9gyQGCZXn46nkvPtyXA7QTFk226nKZeve33f89WysOJtCWPKEaW7A40rvgrO
 2D1fdEy1wWpsqW5w952SNWLBNhE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60d2b11f638039e997cd4852 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 03:57:19
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39B3DC43217; Wed, 23 Jun 2021 03:57:19 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.199.158.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57CADC433F1;
        Wed, 23 Jun 2021 03:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57CADC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: update: Check rcu_bh_lock_map state in
 rcu_read_lock_bh_held
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com, frederic@kernel.org
References: <1624363521-19702-1-git-send-email-neeraju@codeaurora.org>
 <20210622175855.GE4397@paulmck-ThinkPad-P17-Gen-1>
 <61bed875-5ebf-03d8-58ea-e9263c534201@codeaurora.org>
 <20210622234652.GL4397@paulmck-ThinkPad-P17-Gen-1>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <b37e3232-4151-e948-3987-b19c88f0e217@codeaurora.org>
Date:   Wed, 23 Jun 2021 09:27:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622234652.GL4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 6/23/2021 5:16 AM, Paul E. McKenney wrote:
> On Wed, Jun 23, 2021 at 12:38:09AM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 6/22/2021 11:28 PM, Paul E. McKenney wrote:
>>> On Tue, Jun 22, 2021 at 05:35:21PM +0530, Neeraj Upadhyay wrote:
>>>> In addition to irq and softirq state, check rcu_bh_lock_map
>>>> state, to decide whether RCU bh lock is held.
>>>>
>>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>
>>> My initial reaction was that "in_softirq() || irqs_disabled()" covers
>>> it because rcu_read_lock_bh() disables BH.  But you are right that it
>>> does seem a bit silly to ignore lockdep.
>>>
>>> So would it also make sense to have a WARN_ON_ONCE() if lockdep claims
>>> we are under rcu_read_lock_bh() protection, but "in_softirq() ||
>>> irqs_disabled()" think otherwise?
>>
>> After thinking more on this, looks like one intention of not
>> having lockdep check here was to catch scenarios where some code enables bh
>> after doing rcu_read_lock_bh(), as is mentioned in the comment above
>> rcu_read_lock_bh_held():
>>
>>    Note that if someone uses
>>    rcu_read_lock_bh(), but then later enables BH, lockdep (if enabled)
>>    will show the situation.  This is useful for debug checks in functions
>>    that require that they be called within an RCU read-side critical
>>    section.
>>
>> Client users seem to be doing lockdep checks on returned value:
>> drivers/net/wireguard/peer.c
>>     RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held(),
>>
>> Similarly, any rcu_dereference_check(..., rcu_read_lock_bh_held()) usage
>> also triggers warning, if bh is enabled, inside rcu_read_lock_bh()
>> section.
>>
>> So, using 'in_softirq() || irqs_disabled()' condition looks to be sufficient
>> condition, to mark all read lock bh regions and adding '||
>> lock_is_held(&rcu_bh_lock_map)' to this condition does not seem to fit
>> well with the RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held()) and
>> rcu_dereference_check(..., rcu_read_lock_bh_held()) calls, if we hit
>> the scenario, where bh lockmap state (shows bh lock acquired) conflicts with
>> the softirq/irq state .
> 
> That makes sense to me!
> 
> But should there be checks somewhere for something like
> "lock_is_held(&rcu_bh_lock_map) && !in_softirq() && !irqs_disabled()"?
> 
> 							Thanx, Paul
> 

I think this check is good to have inside rcu_read_lock_bh_held(), to
highlight this scenario explicitly; I am thinking, if it makes sense to
have lock_is_held(&rcu_bh_lock_map) check in rcu_softirq_qs() ?

Also, I think this check is more important for 
rcu_read_lock_sched_held(), where lockdep state is used as a sufficient 
condition, for marking a RCU
sched region. One more api is rcu_read_lock_any_held(), where we can
warn on conflicting cases.

   int rcu_read_lock_sched_held(void)
   {
         bool ret;

         if (rcu_read_lock_held_common(&ret))
                 return ret;
         return lock_is_held(&rcu_sched_lock_map) || !preemptible();
   }


Thanks
Neeraj

>> Thanks
>> Neeraj
>>
>>>> ---
>>>>    kernel/rcu/update.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>>>> index c21b38c..d416f1c 100644
>>>> --- a/kernel/rcu/update.c
>>>> +++ b/kernel/rcu/update.c
>>>> @@ -333,7 +333,7 @@ int rcu_read_lock_bh_held(void)
>>>>    	if (rcu_read_lock_held_common(&ret))
>>>>    		return ret;
>>>> -	return in_softirq() || irqs_disabled();
>>>> +	return lock_is_held(&rcu_bh_lock_map) || in_softirq() || irqs_disabled();
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
>>>> -- 
>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>>>> hosted by The Linux Foundation
>>>>
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
