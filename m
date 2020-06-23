Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C597C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 06:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFAE20774
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 06:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="oFPFUrUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgFWGTv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:19:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19079 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbgFWGTu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Jun 2020 02:19:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592893189; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=qSIBjsymwcejYBr9cEeko6qfS3ROa3wXIu8BjipLX44=; b=oFPFUrUlT/sPel5r1AzahsOS2E3fFmGfpPdJ9+h1p0Wx+t7DcRYqCKrVnwksE1SmmimP7rVQ
 jUst+dV241jypfsu28ooyGOovohHAad9Mdu2JAliDPVT3z4UnW53zMW27KNZGfxCC23AwIem
 tYYiJFEnnYVBRBNKhAz9HScVO5Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ef19f00a6e154319f7bb3cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 06:19:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2D9CDC433A0; Tue, 23 Jun 2020 06:19:44 +0000 (UTC)
Received: from [192.168.0.100] (unknown [124.123.165.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC7CFC433C8;
        Tue, 23 Jun 2020 06:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC7CFC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Force quiescent state on callback overload
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
 <20200621195052.GF9247@paulmck-ThinkPad-P72>
 <94686c2e-b589-2598-e658-42f13cec1216@codeaurora.org>
 <20200622031325.GG9247@paulmck-ThinkPad-P72>
 <b72302b1-f49a-84fb-6bb9-75dd5f16bd2c@codeaurora.org>
 <20200622225356.GT9247@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <fdfa6bce-e566-2b04-6be5-e80492a8ae98@codeaurora.org>
Date:   Tue, 23 Jun 2020 11:49:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622225356.GT9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 6/23/2020 4:23 AM, Paul E. McKenney wrote:
> On Mon, Jun 22, 2020 at 09:16:24AM +0530, Neeraj Upadhyay wrote:
>> Hi Paul,
>>
>> On 6/22/2020 8:43 AM, Paul E. McKenney wrote:
>>> On Mon, Jun 22, 2020 at 01:30:31AM +0530, Neeraj Upadhyay wrote:
>>>> Hi Paul,
>>>>
>>>> On 6/22/2020 1:20 AM, Paul E. McKenney wrote:
>>>>> On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
>>>>>> On callback overload, we want to force quiescent state immediately,
>>>>>> for the first and second fqs. Enforce the same, by including
>>>>>> RCU_GP_FLAG_OVLD flag, in fqsstart check.
>>>>>>
>>>>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>>>
>>>>> Good catch!
>>>>>
>>>>> But what did you do to verify that this change does the right thing?
>>>>>
>>>>> 						Thanx, Paul
>>>>>
>>>>
>>>> I haven't done a runtime verification of this code path; I posted this,
>>>> based on review of this code.
>>>
>>> My concern is that under overload, the FQS scans would happen continuously
>>> rather than accelerating only the first such scan in a given grace period.
>>> This would of course result in a CPU-bound grace-period kthread, which
>>> users might not be all that happy with.
>>>
>>> Or am I missing something subtle that prevents this?
>>
>> Looks like under overload, only the first and second scans are accelerated?
>>
>>      gf = 0;
>>      if (first_gp_fqs) {
>>           first_gp_fqs = false;
>>            gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
>>      }
> 
> Very good, it does sound like you understand this, and it matches my
> analysis and passes light testing, so I queued this one.  I did improve
> the commit log, please check below.  The added detail is helpful to people
> (including ourselves, by the way) who might need to look at this commit
> some time in the future.
> 

Thanks; patch looks good; I will try to put more efforts on commit log
for future patches.

> If you have an x86 system lying around, running rcutorture is quite
> straightforward.  Non-x86 systems can also run rcutorture, if nothing
> else by using modprobe and rmmod as described here:
> 
> https://paulmck.livejournal.com/57769.html
> 
> The scripting described in the latter part of this document has worked
> on ARMv8 and PowerPC, and might still work for all I know.

I will set it up at my end; the livejournal is pretty detailed! Thanks
for sharing this!


Thanks
Neeraj

> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9482524d7dd0aea5d32a6efa2979223eea07c029
> Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> Date:   Mon Jun 22 00:07:27 2020 +0530
> 
>      rcu/tree: Force quiescent state on callback overload
>      
>      On callback overload, it is necessary to quickly detect idle CPUs,
>      and rcu_gp_fqs_check_wake() checks for this condition.  Unfortunately,
>      the code following the call to this function does not repeat this check,
>      which means that in reality no actual quiescent-state forcing, instead
>      only a couple of quick and pointless wakeups at the beginning of the
>      grace period.
>      
>      This commit therefore adds a check for the RCU_GP_FLAG_OVLD flag in
>      the post-wakeup "if" statement in rcu_gp_fqs_loop().
>      
>      Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d0988a1..6226bfb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
>   			break;
>   		/* If time for quiescent-state forcing, do it. */
>   		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
> -		    (gf & RCU_GP_FLAG_FQS)) {
> +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>   			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>   					       TPS("fqsstart"));
>   			rcu_gp_fqs(first_gp_fqs);
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
