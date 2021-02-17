Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A4C433E0
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 18:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D5F64DFF
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhBQSSo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:18:44 -0500
Received: from z11.mailgun.us ([104.130.96.11]:42189 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233242AbhBQSSk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 13:18:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613585899; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=aDgfF1QCcG8lBfwmf6xXAw4WENFG+VP+X0RAKWqaZgg=; b=JYX4XPglsqfuRXz8YFT0Fk51SX6wPv5S6Su2dNqZ87X2ctyGXauGoO/ULDgIiZwDF+bWgm0C
 tmZ5kqIJ2hUEZN7gFigxHty0042JFWuE+715HcfSd70c2Rf0U0rdQbQG+B2ul3m7hr9D/Wq6
 QgETyhRZmfzlKMIlP0avsVPznBc=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 602d5dd03af8a93304a21c47 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 18:17:52
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86319C433C6; Wed, 17 Feb 2021 18:17:51 +0000 (UTC)
Received: from [192.168.0.100] (unknown [124.123.173.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 745B0C433CA;
        Wed, 17 Feb 2021 18:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 745B0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu/tree: Add a trace event for RCU stall warnings
To:     Sangmoon Kim <sangmoon.kim@samsung.com>, paulmck@kernel.org
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
References: <20210216175015.GZ2743@paulmck-ThinkPad-P72>
 <CGME20210217135813epcas1p2b3bd79ca06ac847472b048b889100978@epcas1p2.samsung.com>
 <20210217134947.19055-1-sangmoon.kim@samsung.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <bf80e296-14bf-6f36-8952-416829d30e5a@codeaurora.org>
Date:   Wed, 17 Feb 2021 23:47:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217134947.19055-1-sangmoon.kim@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Sangmoon,

On 2/17/2021 7:19 PM, Sangmoon Kim wrote:
>> -----Original Message-----
>> From: Paul E. McKenney <paulmck@kernel.org>
>> Sent: Wednesday, February 17, 2021 2:50 AM
>>
>> On Mon, Feb 15, 2021 at 05:53:25PM +0900, Sangmoon Kim wrote:
>>> The event allows us to trace the RCU stall when
>>> sysctl_panic_on_rcu_stall is disabled.
>>>
>>> The first parameter is the name of RCU flavour like other trace
>>> events. The second one shows us which function detected stalls.
>>>
>>> The RCU stall is mainly caused by external factors such as interrupt
>>> handling or task scheduling or something else. Therefore, this event
>>> uses TRACE_EVENT macro, not dedicated one, so that someone interested
>>> in the RCU stall can use it without CONFIG_RCU_TRACE.
>>>
>>> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
>>
>> The patch looks plausible, but I have to ask...  Why not instead just
>> get the existing information out of the console log?
>>
>> 							Thanx, Paul
> 
> This can provide a trigger point for the RCU stall warning.
> If a module in the kernel wants to trace the stall for debugging purposes,
> there is a cost of continuing to parse the console log.
> This tracepoint is useful because it is hard to pay these costs
> especially on mobile devices.
> 
> Thanks,
> Sangmoon
> 

So, the idea here is to register to these trace events from kernel 
module and use that for debugging? Just curious what debugging action
module does on these traces, as they have limited information
about the stall, compared to console stall warnings, which gives a
much more detailed information about stall.


Thanks
Neeraj

>>
>>> ---
>>>   include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
>>>   kernel/rcu/tree_exp.h      |  2 ++
>>>   kernel/rcu/tree_stall.h    |  2 ++
>>>   3 files changed, 32 insertions(+)
>>>
>>> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
>>> index 155b5cb43cfd..8476f3161bd0 100644
>>> --- a/include/trace/events/rcu.h
>>> +++ b/include/trace/events/rcu.h
>>> @@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
>>>   		  __entry->cpu, __entry->qsevent)
>>>   );
>>>
>>> +/*
>>> + * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
>>> + * and a string identifying which function detected the RCU stall as follows:
>>> + *
>>> + *	"StallDetected": Scheduler-tick detects other CPU's stalls.
>>> + *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
>>> + *	"ExpeditedStall": Expedited grace period detects stalls.
>>> + */
>>> +TRACE_EVENT(rcu_stall_warning,
>>> +
>>> +	TP_PROTO(const char *rcuname, const char *msg),
>>> +
>>> +	TP_ARGS(rcuname, msg),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__field(const char *, rcuname)
>>> +		__field(const char *, msg)
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__entry->rcuname = rcuname;
>>> +		__entry->msg = msg;
>>> +	),
>>> +
>>> +	TP_printk("%s %s",
>>> +		  __entry->rcuname, __entry->msg)
>>> +);
>>> +
>>>   #endif /* #if defined(CONFIG_TREE_RCU) */
>>>
>>>   /*
>>> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>>> index 8760b6ead770..c16618284cb2 100644
>>> --- a/kernel/rcu/tree_exp.h
>>> +++ b/kernel/rcu/tree_exp.h
>>> @@ -566,6 +566,8 @@ static void synchronize_rcu_expedited_wait(void)
>>>   				dump_cpu_task(cpu);
>>>   			}
>>>   		}
>>> +		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
>>> +
>>>   		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
>>>   	}
>>>   }
>>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>>> index 70d48c52fabc..e93df4fac5b1 100644
>>> --- a/kernel/rcu/tree_stall.h
>>> +++ b/kernel/rcu/tree_stall.h
>>> @@ -531,6 +531,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>>>
>>>   	rcu_check_gp_kthread_starvation();
>>>
>>> +	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
>>>   	panic_on_rcu_stall();
>>>
>>>   	rcu_force_quiescent_state();  /* Kick them all. */
>>> @@ -575,6 +576,7 @@ static void print_cpu_stall(unsigned long gps)
>>>   			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
>>>   	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>>
>>> +	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
>>>   	panic_on_rcu_stall();
>>>
>>>   	/*
>>> --
>>> 2.17.1
>>>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
