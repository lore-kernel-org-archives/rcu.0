Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EAEC11F64
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 14:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70CD6141E
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 14:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhGAO5g (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:57:36 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19370 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhGAO5g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 10:57:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625151306; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=XELbrgas9rs/IeJ/15WvopuWbIxaUX7YGn2YTH/XjhE=; b=QJAxrAEfAPVFrQjIImCWwkeQpI8Lj/zTu8HK5iSzaT+IS4uK5Z8om8GDn4m4V/I9O2MbYdEU
 HLargLPiF5x40dIbXfkuX4LThDDKMdk+T4rVf07DZEwi5DzTkdYv/wWWRcF8Y61ArhnRgDTH
 z7zTwlEFHzbWwAcn1JF5d4V0SMA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60ddd731f3042986141474af (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Jul 2021 14:54:41
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CC70C4338A; Thu,  1 Jul 2021 14:54:41 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.199.158.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 281D1C433F1;
        Thu,  1 Jul 2021 14:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 281D1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
To:     Liu Song <fishland@aliyun.com>, paulmck@kernel.org
Cc:     liu.song11@zte.com.cn, rcu@vger.kernel.org
References: <20210630140802.39138-1-fishland@aliyun.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
Date:   Thu, 1 Jul 2021 20:24:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630140802.39138-1-fishland@aliyun.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 6/30/2021 7:38 PM, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> pointers. This patch adjusts a few codes that have not done so.
> 

Minor: Can we also add below statement?
"This patch doesn't introduce any functional change."

> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>   kernel/rcu/tasks.h      | 2 +-
>   kernel/rcu/tree.c       | 4 ++--
>   kernel/rcu/tree_stall.h | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 350ebf5051f9..0275217cb6e4 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -875,7 +875,7 @@ static void trc_read_check_handler(void *t_in)
>   	// Allow future IPIs to be sent on CPU and for task.
>   	// Also order this IPI handler against any later manipulations of
>   	// the intended task.
> -	smp_store_release(&per_cpu(trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
> +	smp_store_release(per_cpu_ptr(&trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
>   	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
>   }
>   
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8e78b2430c16..5cab8e39a731 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -399,7 +399,7 @@ bool rcu_eqs_special_set(int cpu)
>   	int old;
>   	int new;
>   	int new_old;
> -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);

rcu_eqs_special_set() does not exist in rcu dev branch [1]; so this 
might need rebase.


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/kernel/rcu/tree.c?h=dev

>   
>   	new_old = atomic_read(&rdp->dynticks);
>   	do {
> @@ -1333,7 +1333,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>   	 */
>   	jtsq = READ_ONCE(jiffies_to_sched_qs);
>   	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
> -	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
> +	rnhqp = per_cpu_ptr(&rcu_data.rcu_need_heavy_qs, rdp->cpu);
>   	if (!READ_ONCE(*rnhqp) &&
>   	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
>   	     time_after(jiffies, rcu_state.jiffies_resched) ||
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 59b95cc5cbdf..990fdb793d57 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -349,7 +349,7 @@ static void rcu_dump_cpu_stacks(void)
>   
>   static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
>   {
> -	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>   
>   	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
>   		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
>

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>



Thanks
Neeraj

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
