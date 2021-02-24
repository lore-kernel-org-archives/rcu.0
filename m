Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40DC433E0
	for <rcu@archiver.kernel.org>; Wed, 24 Feb 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D881664DF5
	for <rcu@archiver.kernel.org>; Wed, 24 Feb 2021 09:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhBXJTR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Feb 2021 04:19:17 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:48959 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhBXJTO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Feb 2021 04:19:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614158331; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=pKnHmEt3v515E5ECVc3X8cclTJMgTiGlLtrlYEHXPn0=; b=begCAk4ymsP48EKL/SVcCvQXIGrrWfOPmR2AOw+dYkrrPSlQFUqt6dbj1aJg6IWg144Qrof3
 yrFiRqtgp3dQhelNy8fgDHQ6ifm7DwFcL1VaReQ/83yiaYR/TxqP+uo8c8E+QBMTE+8BxroC
 8iKMVXrA9Z8vjqpq3rhqeLNPooc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 603619ee095efe1816201bc8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 09:18:38
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A66AAC43465; Wed, 24 Feb 2021 09:18:38 +0000 (UTC)
Received: from [192.168.0.100] (unknown [124.123.173.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 490C7C433CA;
        Wed, 24 Feb 2021 09:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 490C7C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
To:     Sangmoon Kim <sangmoon.kim@samsung.com>, paulmck@kernel.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
References: <20210218185926.GV2743@paulmck-ThinkPad-P72>
 <CGME20210222083416epcas1p2c4d51fc7a793729c08e424f13077954a@epcas1p2.samsung.com>
 <20210222082539.15573-1-sangmoon.kim@samsung.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <2406eacc-b270-989d-79ce-9e97817b7458@codeaurora.org>
Date:   Wed, 24 Feb 2021 14:48:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222082539.15573-1-sangmoon.kim@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Sangmoon,


On 2/22/2021 1:55 PM, Sangmoon Kim wrote:
> 
> 
>> -----Original Message-----
>> From: Paul E. McKenney <paulmck@kernel.org>
>> Sent: Friday, February 19, 2021 3:59 AM
>>
>> On Thu, Feb 18, 2021 at 01:24:16PM -0500, Steven Rostedt wrote:
>>> On Thu, 18 Feb 2021 09:00:12 -0800
>>> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>
>>>> OK, I will bite.  ;-)
>>>
>>> Do I turn into a wearwolf?
>>
>> Maybe even a wash-n-wear wolf.  ;-)
>>
>>>> Can the saving of console into trace buffers be easily enabled and
>>>> disabled within the code?
>>>
>>> Well, we do have this for ftrace:
>>>
>>>   echo 'enable_event:printk:console' > events/rcu/rcu_stall_warning/trigger
>>>
>>> Would enable the printk console to be traced to the ring buffer once the
>>> stall is triggered, and not before hand.
>>>
>>>>   If so, does enabling and disabling nest?
>>>
>>> It has a disable as well, but unfortunately its global and does not nest.
>>> We could always implement a percpu trigger that can nest though.
>>
>> So Sangmoon could have a module react to an RCU CPU stall warning
>> tracepoint by turning on tracing of console messages.  If there was a
>> start-stop pair of RCU CPU stall warning tracepoints, he could turn it
>> off as well.
>>
>> Not sure if that is what Sangmoon is looking for, but it is a possibility.
>>
>> 							Thanx, Paul
> 
> Thank you. I'm learning the new things through this review.
> 
> Copying console messages is not really necessary to me. I wanted to say
> this tracepoint can also be used in such way for debugging purpose.
> 

In case we want to use this trace event, to capture RCU stall 
information, which comes on console, into trace buffers; why not have 
these events at the start of the functions like print_other_cpu_stall(), 
print_cpu_stall() rather than  at the end ?


Thanks
Neeraj

> What I need is that a module records the stall happening and report the
> stall event when kernel panic occurred. Of course, there is no detailed
> information there, but it helps developers to recognize that the stall
> has occurred in the system.
> 
> The usage scenario is as follows.
> There is a kernel module for debugging.
> The module registers a probe function using register_trace_rcu_stall_warning().
> When a stall warning event occurs, the module records the event into its own buffer.
> When a kernel panic occurs, the developers can see the report generated
> by the module and can also see the buffer of the module directly through Ramdump.
> 
> Thanks,
> Sangmoon
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
