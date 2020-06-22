Return-Path: <SRS0=LAXB=AD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235CC433E0
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 03:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B49233CE
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 03:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="StLFE2IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgFVDqc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:46:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13345 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731090AbgFVDqc (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 21 Jun 2020 23:46:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592797592; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=CuDBRy7VYXmLMYOkyJUj7x/xoJi9VZ80ag4mVBgKVYk=; b=StLFE2IXXZtAqDZU3T4xoRxfFRblJMUoZG8oAdSHwqDOHSUP8jGmB4g7UvfHCODSHGJdEE91
 /ixMfxKLWsjWs4TFHS9Ofn0Wfuv0cQkuQtbElZHYC5F1BTZSzimDCbUbZTPbKg0czmCSm04E
 4JnwAHPm8RzFYX+0KbumQqqh7FQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5ef02997c4bb4f886d6fbebd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 03:46:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55771C433CB; Mon, 22 Jun 2020 03:46:30 +0000 (UTC)
Received: from [192.168.0.100] (unknown [124.123.165.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3993BC433C8;
        Mon, 22 Jun 2020 03:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3993BC433C8
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
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <b72302b1-f49a-84fb-6bb9-75dd5f16bd2c@codeaurora.org>
Date:   Mon, 22 Jun 2020 09:16:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622031325.GG9247@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On 6/22/2020 8:43 AM, Paul E. McKenney wrote:
> On Mon, Jun 22, 2020 at 01:30:31AM +0530, Neeraj Upadhyay wrote:
>> Hi Paul,
>>
>> On 6/22/2020 1:20 AM, Paul E. McKenney wrote:
>>> On Mon, Jun 22, 2020 at 12:07:27AM +0530, Neeraj Upadhyay wrote:
>>>> On callback overload, we want to force quiescent state immediately,
>>>> for the first and second fqs. Enforce the same, by including
>>>> RCU_GP_FLAG_OVLD flag, in fqsstart check.
>>>>
>>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>
>>> Good catch!
>>>
>>> But what did you do to verify that this change does the right thing?
>>>
>>> 						Thanx, Paul
>>>
>>
>> I haven't done a runtime verification of this code path; I posted this,
>> based on review of this code.
> 
> My concern is that under overload, the FQS scans would happen continuously
> rather than accelerating only the first such scan in a given grace period.
> This would of course result in a CPU-bound grace-period kthread, which
> users might not be all that happy with.
> 
> Or am I missing something subtle that prevents this?

Looks like under overload, only the first and second scans are accelerated?

     gf = 0;
     if (first_gp_fqs) {
          first_gp_fqs = false;
           gf = rcu_state.cbovld ? RCU_GP_FLAG_OVLD : 0;
     }


Thanks
Neeraj

> 
> But yes, it does look like the current mainline code fails to do the
> first scan immediately, so again, good catch!
> 
> 							Thanx, Paul
>

>> Thanks
>> Neeraj
>>
>>>> ---
>>>>    kernel/rcu/tree.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index d0988a1..6226bfb 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
>>>>    			break;
>>>>    		/* If time for quiescent-state forcing, do it. */
>>>>    		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
>>>> -		    (gf & RCU_GP_FLAG_FQS)) {
>>>> +		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
>>>>    			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>>>>    					       TPS("fqsstart"));
>>>>    			rcu_gp_fqs(first_gp_fqs);
>>>> -- 
>>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>>>> a Linux Foundation Collaborative Project
>>>>
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
