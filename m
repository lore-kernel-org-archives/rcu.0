Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FD9C2B9F4
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2867A61108
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 19:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhFVTK6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:10:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40704 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232725AbhFVTK6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Jun 2021 15:10:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624388922; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=poAFY6AopzNryNovMw1oTx+Yqrh24KODRR7fLR5Xk/A=; b=h11PGQnTiJKJ6vMZ7Cm9huiriwwZRnyBDPTo1iRCaTf/HxlIcSIkf+s1FS+0+hISlqSDofwt
 ESdacmJ606YFzhZBE0FwJUjb/tHMnwSs44lY/C567c28MP0Fp+oQOa1HRg4/yDemHLq0QmxI
 21Y7E7CnV/fw9s4UU3T0fzxkENA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d235224ca9face3433fb38 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 19:08:18
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEAACC43143; Tue, 22 Jun 2021 19:08:17 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.199.158.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACF76C433D3;
        Tue, 22 Jun 2021 19:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACF76C433D3
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
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <61bed875-5ebf-03d8-58ea-e9263c534201@codeaurora.org>
Date:   Wed, 23 Jun 2021 00:38:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622175855.GE4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 6/22/2021 11:28 PM, Paul E. McKenney wrote:
> On Tue, Jun 22, 2021 at 05:35:21PM +0530, Neeraj Upadhyay wrote:
>> In addition to irq and softirq state, check rcu_bh_lock_map
>> state, to decide whether RCU bh lock is held.
>>
>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> My initial reaction was that "in_softirq() || irqs_disabled()" covers
> it because rcu_read_lock_bh() disables BH.  But you are right that it
> does seem a bit silly to ignore lockdep.
> 
> So would it also make sense to have a WARN_ON_ONCE() if lockdep claims
> we are under rcu_read_lock_bh() protection, but "in_softirq() ||
> irqs_disabled()" think otherwise?
> 
> 							Thanx, Paul
> 

After thinking more on this, looks like one intention of not
having lockdep check here was to catch scenarios where some code enables 
bh after doing rcu_read_lock_bh(), as is mentioned in the comment above 
rcu_read_lock_bh_held():

   Note that if someone uses
   rcu_read_lock_bh(), but then later enables BH, lockdep (if enabled)
   will show the situation.  This is useful for debug checks in functions
   that require that they be called within an RCU read-side critical
   section.

Client users seem to be doing lockdep checks on returned value:
drivers/net/wireguard/peer.c
    RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held(),

Similarly, any rcu_dereference_check(..., rcu_read_lock_bh_held()) usage 
also triggers warning, if bh is enabled, inside rcu_read_lock_bh()
section.

So, using 'in_softirq() || irqs_disabled()' condition looks to be 
sufficient condition, to mark all read lock bh regions and adding '|| 
lock_is_held(&rcu_bh_lock_map)' to this condition does not seem to fit
well with the RCU_LOCKDEP_WARN(!rcu_read_lock_bh_held()) and 
rcu_dereference_check(..., rcu_read_lock_bh_held()) calls, if we hit
the scenario, where bh lockmap state (shows bh lock acquired) conflicts 
with the softirq/irq state .



Thanks
Neeraj

>> ---
>>   kernel/rcu/update.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
>> index c21b38c..d416f1c 100644
>> --- a/kernel/rcu/update.c
>> +++ b/kernel/rcu/update.c
>> @@ -333,7 +333,7 @@ int rcu_read_lock_bh_held(void)
>>   
>>   	if (rcu_read_lock_held_common(&ret))
>>   		return ret;
>> -	return in_softirq() || irqs_disabled();
>> +	return lock_is_held(&rcu_bh_lock_map) || in_softirq() || irqs_disabled();
>>   }
>>   EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
>>   
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> hosted by The Linux Foundation
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
