Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1926BC63777
	for <rcu@archiver.kernel.org>; Sat, 28 Nov 2020 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8577246E4
	for <rcu@archiver.kernel.org>; Sat, 28 Nov 2020 17:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZbjJcSvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgK1EOF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Nov 2020 23:14:05 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:44321 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbgK1ENL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Nov 2020 23:13:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606536789; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=CKQ67obRSTE5auRFN3Iv3F18LhaYz1abTj3Ju4cK5ug=; b=ZbjJcSvG7IbgY8CnEeXw/1p3JXGVpPBRcfX0VfiKuvdEjlwsxNG8ZGtV+KOi11ydSNu/6/8D
 u+4u38Z06ZvkQ15r9rBsoripcPSyLvu3wLhm4O+9rkCHMjIqjeiEn2x86IINCXZ5+UKmMP6H
 E+KQoDvv7zca5c7infxzInx5zw8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fc1ce524146c5eefdcb0a9b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 28 Nov 2020 04:13:06
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5135C433C6; Sat, 28 Nov 2020 04:13:05 +0000 (UTC)
Received: from [192.168.0.105] (unknown [49.206.49.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6348C433C6;
        Sat, 28 Nov 2020 04:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6348C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v2 tip/core/rcu 1/6] srcu: Make Tiny SRCU use multi-bit
 grace-period counter
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kent.overstreet@gmail.com
References: <@@@> <20201121005919.17152-1-paulmck@kernel.org>
 <f70d1032-8e0f-37bf-9ab0-33e85bc8643c@codeaurora.org>
 <20201123195543.GC1437@paulmck-ThinkPad-P72>
 <46f5137b-2450-2478-6274-157367264ce4@codeaurora.org>
 <28a22477-9fbd-603a-404c-1cf6e7cc18b5@codeaurora.org>
 <20201128021609.GX1437@paulmck-ThinkPad-P72>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <225e5fba-f763-3a1e-062b-c74cdc5f83af@codeaurora.org>
Date:   Sat, 28 Nov 2020 09:42:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201128021609.GX1437@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 11/28/2020 7:46 AM, Paul E. McKenney wrote:
> On Wed, Nov 25, 2020 at 10:03:26AM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 11/24/2020 10:48 AM, Neeraj Upadhyay wrote:
>>>
>>>
>>> On 11/24/2020 1:25 AM, Paul E. McKenney wrote:
>>>> On Mon, Nov 23, 2020 at 10:01:13AM +0530, Neeraj Upadhyay wrote:
>>>>> On 11/21/2020 6:29 AM, paulmck@kernel.org wrote:
>>>>>> From: "Paul E. McKenney" <paulmck@kernel.org>
>>>>>>
>>>>>> There is a need for a polling interface for SRCU grace periods.  This
>>>>>> polling needs to distinguish between an SRCU instance being idle on the
>>>>>> one hand or in the middle of a grace period on the other.  This commit
>>>>>> therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
>>>>>> a defacto boolean to a free-running counter, using the bottom bit to
>>>>>> indicate that a grace period is in progress.  The second-from-bottom
>>>>>> bit is thus used as the index returned by srcu_read_lock().
>>>>>>
>>>>>> Link:
>>>>>> https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
>>>>>> Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
>>>>>> [ paulmck: Fix __srcu_read_lock() idx computation Neeraj per
>>>>>> Upadhyay. ]
>>>>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>>> ---
>>>>>>     include/linux/srcutiny.h | 4 ++--
>>>>>>     kernel/rcu/srcutiny.c    | 5 +++--
>>>>>>     2 files changed, 5 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
>>>>>> index 5a5a194..d9edb67 100644
>>>>>> --- a/include/linux/srcutiny.h
>>>>>> +++ b/include/linux/srcutiny.h
>>>>>> @@ -15,7 +15,7 @@
>>>>>>     struct srcu_struct {
>>>>>>         short srcu_lock_nesting[2];    /* srcu_read_lock()
>>>>>> nesting depth. */
>>>>>> -    short srcu_idx;            /* Current reader array element. */
>>>>>> +    unsigned short srcu_idx;    /* Current reader array
>>>>>> element in bit 0x2. */
>>>>>>         u8 srcu_gp_running;        /* GP workqueue running? */
>>>>>>         u8 srcu_gp_waiting;        /* GP waiting for readers? */
>>>>>>         struct swait_queue_head srcu_wq;
>>>>>> @@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct
>>>>>> srcu_struct *ssp)
>>>>>>     {
>>>>>>         int idx;
>>>>>> -    idx = READ_ONCE(ssp->srcu_idx);
>>>>>> +    idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
>>>>>>         WRITE_ONCE(ssp->srcu_lock_nesting[idx],
>>>>>> ssp->srcu_lock_nesting[idx] + 1);
>>>>>>         return idx;
>>>>>>     }
>>>>>
>>>>> Need change in idx calcultion in srcu_torture_stats_print() ?
>>>>>
>>>>> static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
>>>>>     idx = READ_ONCE(ssp->srcu_idx) & 0x1;
>>>>
>>>> Excellent point!  It should match the calculation in __srcu_read_lock(),
>>>> shouldn't it?  I have updated this, thank you!
>>>>
>>>>                              Thanx, Paul
>>>>
>>>
>>> Updated version looks good!
>>>
>>>
>>> Thanks
>>> Neeraj
>>>
>>
>> For the version in rcu -dev:
>>
>> Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> 
> I applied all of these, thank you very much!
> 

Welcome :)

>> Only minor point which I have is, the idx calculation can be made an inline
>> func (though srcu_drive_gp() does not require a READ_ONCE for ->srcu_idx):
>>
>> __srcu_read_lock() and srcu_torture_stats_print() are using
>>
>> idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
>>
>> whereas srcu_drive_gp() uses:
>>
>> idx = (ssp->srcu_idx & 0x2) / 2;
> 
> They do work on different elements of the various arrays.  Or do you
> believe that the srcu_drive_gp() use needs adjusting?

My bad, I missed that they are using different elements of array.
Please ignore this comment.


Thanks
Neeraj

> 
> Either way, the overhead of READ_ONCE() is absolutely not at all
> a problem.  Would you like to put together a patch so that I can see
> exactly what you are suggesting?
> 
> 							Thanx, Paul
> 
>> Thanks
>> Neeraj
>>
>>>>> Thanks
>>>>> Neeraj
>>>>>
>>>>>> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
>>>>>> index 6208c1d..5598cf6 100644
>>>>>> --- a/kernel/rcu/srcutiny.c
>>>>>> +++ b/kernel/rcu/srcutiny.c
>>>>>> @@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
>>>>>>         ssp->srcu_cb_head = NULL;
>>>>>>         ssp->srcu_cb_tail = &ssp->srcu_cb_head;
>>>>>>         local_irq_enable();
>>>>>> -    idx = ssp->srcu_idx;
>>>>>> -    WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
>>>>>> +    idx = (ssp->srcu_idx & 0x2) / 2;
>>>>>> +    WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>>>>>>         WRITE_ONCE(ssp->srcu_gp_waiting, true);  /*
>>>>>> srcu_read_unlock() wakes! */
>>>>>>         swait_event_exclusive(ssp->srcu_wq,
>>>>>> !READ_ONCE(ssp->srcu_lock_nesting[idx]));
>>>>>>         WRITE_ONCE(ssp->srcu_gp_waiting, false); /*
>>>>>> srcu_read_unlock() cheap. */
>>>>>> +    WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>>>>>>         /* Invoke the callbacks we removed above. */
>>>>>>         while (lh) {
>>>>>>
>>>>>
>>>>> -- 
>>>>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is
>>>>> a member of
>>>>> the Code Aurora Forum, hosted by The Linux Foundation
>>>
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of
>> the Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
