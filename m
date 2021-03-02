Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2723DC433DB
	for <rcu@archiver.kernel.org>; Wed,  3 Mar 2021 05:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C818E64E58
	for <rcu@archiver.kernel.org>; Wed,  3 Mar 2021 05:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350225AbhCCEyZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:54:25 -0500
Received: from z11.mailgun.us ([104.130.96.11]:26934 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349829AbhCBRgx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 Mar 2021 12:36:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614706582; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=yHHMhxMEUhM1wJY5IozNUpAzuO//2bTaKnwzFl1HvnI=; b=cRBLu8xJjmTLubnyXz2DwuE9W77oaJwJFVUGLN7ZtkeqcSv6/ILPprT3zdjfGh5yVSzxyDYT
 wedHAlpvAtTqEJQLMeMn9h1Aejx/Ewe2fZEP70uiWeoWtehJs7228+9/UJ3bgLlrgDMZMed6
 FerEdsNiwlKmwonrtgM0BSssc+4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 603e7021081b59d4ed198a0f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 17:04:33
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EEDA4C433ED; Tue,  2 Mar 2021 17:04:32 +0000 (UTC)
Received: from [192.168.0.101] (unknown [124.123.173.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA2B6C433CA;
        Tue,  2 Mar 2021 17:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA2B6C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
Subject: Re: [PATCH v3] rcu/tree: Add a trace event for RCU stall warnings
To:     Sangmoon Kim <sangmoon.kim@samsung.com>, urezki@gmail.com
Cc:     jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        paulmck@kernel.org, rcu@vger.kernel.org, rostedt@goodmis.org
References: <20210228194700.GA55724@pc638.lan>
 <CGME20210302120418epcas1p17e7f55d9c380ae864d2a6afab5fd3b1b@epcas1p1.samsung.com>
 <20210302115515.14239-1-sangmoon.kim@samsung.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <c8105158-d981-83bb-64f7-83e0c2921de9@codeaurora.org>
Date:   Tue, 2 Mar 2021 22:34:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302115515.14239-1-sangmoon.kim@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 3/2/2021 5:25 PM, Sangmoon Kim wrote:
> The event allows us to trace the RCU stall when
> sysctl_panic_on_rcu_stall is disabled.
> 
> The first parameter is the name of RCU flavour like other trace
> events. The second one shows us which function detected stalls.
> 
> The RCU stall is mainly caused by external factors such as interrupt
> handling or task scheduling or something else. Therefore, this event
> uses TRACE_EVENT macro, not dedicated one, so that someone interested
> in the RCU stall can use it without CONFIG_RCU_TRACE.
> 
> Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
> Thank you for reviewing this.
> 
> Changes in v2:
>   - Move the tracepoints before printing out stall messages.
> 
> Changes in v3:
>   - Rebase on dev in linux-rcu.git
> 
>   include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
>   kernel/rcu/tree_exp.h      |  1 +
>   kernel/rcu/tree_stall.h    |  2 ++
>   3 files changed, 31 insertions(+)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 5fc29400e1a2..c7711e9b6900 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
>   		  __entry->cpu, __entry->qsevent)
>   );
>   
> +/*
> + * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
> + * and a string identifying which function detected the RCU stall as follows:
> + *
> + *	"StallDetected": Scheduler-tick detects other CPU's stalls.
> + *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
> + *	"ExpeditedStall": Expedited grace period detects stalls.
> + */
> +TRACE_EVENT(rcu_stall_warning,
> +
> +	TP_PROTO(const char *rcuname, const char *msg),
> +
> +	TP_ARGS(rcuname, msg),
> +
> +	TP_STRUCT__entry(
> +		__field(const char *, rcuname)
> +		__field(const char *, msg)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->rcuname = rcuname;
> +		__entry->msg = msg;
> +	),
> +
> +	TP_printk("%s %s",
> +		  __entry->rcuname, __entry->msg)
> +);
> +
>   #endif /* #if defined(CONFIG_TREE_RCU) */
>   
>   /*
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6c6ff06d4ae6..2796084ef85a 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -521,6 +521,7 @@ static void synchronize_rcu_expedited_wait(void)
>   		if (rcu_stall_is_suppressed())
>   			continue;
>   		panic_on_rcu_stall();
> +		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
>   		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
>   		       rcu_state.name);
>   		ndetected = 0;
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 475b26171b20..59b95cc5cbdf 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -536,6 +536,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>   	 * See Documentation/RCU/stallwarn.rst for info on how to debug
>   	 * RCU CPU stall warnings.
>   	 */
> +	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
>   	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
>   	rcu_for_each_leaf_node(rnp) {
>   		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> @@ -606,6 +607,7 @@ static void print_cpu_stall(unsigned long gps)
>   	 * See Documentation/RCU/stallwarn.rst for info on how to debug
>   	 * RCU CPU stall warnings.
>   	 */
> +	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
>   	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
>   	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
>   	print_cpu_stall_info(smp_processor_id());
> 

Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
