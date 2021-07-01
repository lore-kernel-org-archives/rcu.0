Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EB7C11F64
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BC061369
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 17:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGARIm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:08:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12718 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229971AbhGARIl (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 13:08:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625159171; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=caanMCCbjZ+WrHwr1J3fqGmoaRr7ikrOCfImOZID6CM=; b=X65vlb4RcXqfGTY4yC4hEELfx1d7xEdJHomG28Aox60mwpxtNucHtGPwi7Tglznp56xjumDt
 6lvcBCZ2nhvGBG7QpHMFLEjCb1mUHs7EYX49H8JnEtKvWZOoaWW7/gzKQOtf1CtCEC+Z88OT
 AAOiAqPbfSo2anXjNyWWjLX1Rok=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60ddf5ee2a2a9a9761d62526 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Jul 2021 17:05:50
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31323C4338A; Thu,  1 Jul 2021 17:05:50 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.199.158.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A07C7C433F1;
        Thu,  1 Jul 2021 17:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A07C7C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
To:     paulmck@kernel.org
Cc:     Liu Song <fishland@aliyun.com>, liu.song11@zte.com.cn,
        rcu@vger.kernel.org
References: <20210630140802.39138-1-fishland@aliyun.com>
 <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
 <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <bb788228-9756-2ee9-f11c-eae133c34593@codeaurora.org>
Date:   Thu, 1 Jul 2021 22:35:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/1/2021 10:01 PM, Paul E. McKenney wrote:
> On Thu, Jul 01, 2021 at 08:24:32PM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 6/30/2021 7:38 PM, Liu Song wrote:
>>> From: Liu Song <liu.song11@zte.com.cn>
>>>
>>> In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
>>> pointers. This patch adjusts a few codes that have not done so.
>>>
>>
>> Minor: Can we also add below statement?
>> "This patch doesn't introduce any functional change."
>>
>>> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> 
> Applied with the usual wordsmithing, including adding words to this
> effect, so thank you all!  I removed the obsolete chunk that Neeraj
> pointed out as well.
> 
> Please take a look and check to see if all is well.
> 

Looks good to me

Thanks
Neeraj

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 9a6b5a10785f4d9b4f073736e6648fa3851882bd
> Author: Liu Song <liu.song11@zte.com.cn>
> Date:   Wed Jun 30 22:08:02 2021 +0800
> 
>      rcu: Use per_cpu_ptr to get the pointer of per_cpu variable
>      
>      There are a few remaining locations in kernel/rcu that still use
>      "&per_cpu()".  This commit replaces them with "per_cpu_ptr(&)", and does
>      not introduce any functional change..
>      
>      Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>      Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>      Signed-off-by: Liu Song <liu.song11@zte.com.cn>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f9f52daacd1c..806160c44b17 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -923,7 +923,7 @@ static void trc_read_check_handler(void *t_in)
>   	// Allow future IPIs to be sent on CPU and for task.
>   	// Also order this IPI handler against any later manipulations of
>   	// the intended task.
> -	smp_store_release(&per_cpu(trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
> +	smp_store_release(per_cpu_ptr(&trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
>   	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
>   }
>   
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a627a200a5ae..f42b98af3ed3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1290,7 +1290,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>   	 */
>   	jtsq = READ_ONCE(jiffies_to_sched_qs);
>   	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> -	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> +	rnhqp = per_cpu_ptr(&rcu_data.rcu_need_heavy_qs, rdp->cpu);
>   	if (!READ_ONCE(*rnhqp) &&
>   	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
>   	     time_after(jiffies, rcu_state.jiffies_resched) ||
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index a8d0fcf0826f..677ee3d8671b 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -351,7 +351,7 @@ static void rcu_dump_cpu_stacks(void)
>   
>   static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
>   {
> -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>   
>   	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
>   		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
