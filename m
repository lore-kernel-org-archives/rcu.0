Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC856C43334
	for <rcu@archiver.kernel.org>; Tue, 19 Jul 2022 22:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiGSWmH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Jul 2022 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbiGSWmF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Jul 2022 18:42:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03BD51A0C
        for <rcu@vger.kernel.org>; Tue, 19 Jul 2022 15:42:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c3so6708486qko.1
        for <rcu@vger.kernel.org>; Tue, 19 Jul 2022 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=txI7AVZGwwiI1HjkMYuKeUAJ1SvSE9gqNhUr6fqucEA=;
        b=iblbtCEerjUZRbPnYjvE8/JCgzp7P/aL/IlBonHeHgWO1M/33FxVYuPCrLNdspPA+p
         86bz8NAGaOebQQ0W7XVIMikGFGNUstSDdJJIEraRFL09l1OydTDQeR26RKCcbduWrXxC
         9Fo/v/HhCxFcIjykzLKhCO3FG31BQNBkKUDS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=txI7AVZGwwiI1HjkMYuKeUAJ1SvSE9gqNhUr6fqucEA=;
        b=v8MovQNK22ROaHT1YobMKV9qE8CDpqB2o3PlYGfe4tE48kBeQlkF/ls+aVC9kM1gC1
         ppB2kDhJEb/+VlMNPjvVqxVdPkfSbOHjFFsz3WEsAxmuWtqtbNz31fwRrdcxksnYB8fs
         yK31RKXz7E3fOih/AEUkll0CkEBYa0zhBHuxSiAD+mjiUsCpgiMOAINM97feittYn61p
         Beu0AwU9BmvfJFxkfHB42Lbx/izI7Y7WVXrd7mT9gTgjiu6BcK5yl1Sd/vil0iukTgaQ
         JS5ukXgmfpEuTSBmOHvOy2Ate9dsEx2jZghzMLduyzG0Is1sJZoolbHTZO6m2HOytzGf
         z2Sw==
X-Gm-Message-State: AJIora/jWsOihYUDAq9DQ7EbZYuHrWbGrkCGc7D+7kGH00yD2U45WeTL
        ib10fsoj55z2F/VGVW+Pm44GbA==
X-Google-Smtp-Source: AGRyM1vAIVO2Haav1as2zyzxQYVWLtVCn+F32KNaef95U5jNhpfe5yNKrZ/TB38Q4vxyqhP4dmCm/Q==
X-Received: by 2002:a05:620a:2589:b0:6ab:91fd:3f7 with SMTP id x9-20020a05620a258900b006ab91fd03f7mr22522552qko.104.1658270522936;
        Tue, 19 Jul 2022 15:42:02 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id v6-20020ae9e306000000b006b58fce19dasm14333694qkf.20.2022.07.19.15.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 15:42:02 -0700 (PDT)
Message-ID: <530b3bf4-f790-2973-5bc5-6ccd4797ae2a@joelfernandes.org>
Date:   Tue, 19 Jul 2022 18:42:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH rcu 4/7] rcu/nocb: Add an option to offload all CPUs on
 boot
To:     paulmck@kernel.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
 <20220620224503.3841196-4-paulmck@kernel.org>
 <7a09896b-88dd-040b-86c0-863f8279a04e@quicinc.com>
 <20220719181257.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220719181257.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/19/2022 2:12 PM, Paul E. McKenney wrote:
> On Tue, Jul 19, 2022 at 03:04:07PM +0530, Neeraj Upadhyay wrote:
>>
>>
>> On 6/21/2022 4:15 AM, Paul E. McKenney wrote:
>>> From: Joel Fernandes <joel@joelfernandes.org>
>>>
>>> Systems built with CONFIG_RCU_NOCB_CPU=y but booted without either
>>> the rcu_nocbs= or rcu_nohz_full= kernel-boot parameters will not have
>>> callback offloading on any of the CPUs, nor can any of the CPUs be
>>> switched to enable callback offloading at runtime.  Although this is
>>> intentional, it would be nice to have a way to offload all the CPUs
>>> without having to make random bootloaders specify either the rcu_nocbs=
>>> or the rcu_nohz_full= kernel-boot parameters.
>>>
>>> This commit therefore provides a new CONFIG_RCU_NOCB_CPU_DEFAULT_ALL
>>> Kconfig option that switches the default so as to offload callback
>>> processing on all of the CPUs.  This default can still be overridden
>>> using the rcu_nocbs= and rcu_nohz_full= kernel-boot parameters.
>>>
>>> Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
>>> Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
>>> (In v4.1, fixed issues with CONFIG maze reported by kernel test robot).
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>
>>
>> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
>>
>> One query on cpumask_setall() below
>>
>>>   Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
>>>   kernel/rcu/Kconfig                              | 13 +++++++++++++
>>>   kernel/rcu/tree_nocb.h                          | 15 ++++++++++++++-
>>>   3 files changed, 33 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 2522b11e593f2..34605c275294c 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3659,6 +3659,9 @@
>>>   			just as if they had also been called out in the
>>>   			rcu_nocbs= boot parameter.
>>> +			Note that this argument takes precedence over
>>> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
>>> +
>>>   	noiotrap	[SH] Disables trapped I/O port accesses.
>>>   	noirqdebug	[X86-32] Disables the code which attempts to detect and
>>> @@ -4557,6 +4560,9 @@
>>>   			no-callback mode from boot but the mode may be
>>>   			toggled at runtime via cpusets.
>>> +			Note that this argument takes precedence over
>>> +			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
>>> +
>>>   	rcu_nocb_poll	[KNL]
>>>   			Rather than requiring that offloaded CPUs
>>>   			(specified by rcu_nocbs= above) explicitly
>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>>> index 1c630e573548d..27aab870ae4cf 100644
>>> --- a/kernel/rcu/Kconfig
>>> +++ b/kernel/rcu/Kconfig
>>> @@ -262,6 +262,19 @@ config RCU_NOCB_CPU
>>>   	  Say Y here if you need reduced OS jitter, despite added overhead.
>>>   	  Say N here if you are unsure.
>>> +config RCU_NOCB_CPU_DEFAULT_ALL
>>> +	bool "Offload RCU callback processing from all CPUs by default"
>>> +	depends on RCU_NOCB_CPU
>>> +	default n
>>> +	help
>>> +	  Use this option to offload callback processing from all CPUs
>>> +	  by default, in the absence of the rcu_nocbs or nohz_full boot
>>> +	  parameter. This also avoids the need to use any boot parameters
>>> +	  to achieve the effect of offloading all CPUs on boot.
>>> +
>>> +	  Say Y here if you want offload all CPUs by default on boot.
>>> +	  Say N here if you are unsure.
>>> +
>>>   config TASKS_TRACE_RCU_READ_MB
>>>   	bool "Tasks Trace RCU readers use memory barriers in user and idle"
>>>   	depends on RCU_EXPERT && TASKS_TRACE_RCU
>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>> index 4cf9a29bba79d..60cc92cc66552 100644
>>> --- a/kernel/rcu/tree_nocb.h
>>> +++ b/kernel/rcu/tree_nocb.h
>>> @@ -1197,11 +1197,21 @@ void __init rcu_init_nohz(void)
>>>   {
>>>   	int cpu;
>>>   	bool need_rcu_nocb_mask = false;
>>> +	bool offload_all = false;
>>>   	struct rcu_data *rdp;
>>> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
>>> +	if (!rcu_state.nocb_is_setup) {
>>> +		need_rcu_nocb_mask = true;
>>> +		offload_all = true;
>>> +	}
>>> +#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
>>> +
>>>   #if defined(CONFIG_NO_HZ_FULL)
>>> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>>> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
>>>   		need_rcu_nocb_mask = true;
>>> +		offload_all = false; /* NO_HZ_FULL has its own mask. */
>>> +	}
>>>   #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>>>   	if (need_rcu_nocb_mask) {
>>> @@ -1222,6 +1232,9 @@ void __init rcu_init_nohz(void)
>>>   		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>>>   #endif /* #if defined(CONFIG_NO_HZ_FULL) */
>>> +	if (offload_all)
>>> +		cpumask_setall(rcu_nocb_mask);
>>
>> Do we need to do a cpumask_and(rcu_nocb_mask, cpu_possible_mask,
>> rcu_nocb_mask) after setting all cpus in rcu_nocb_mask (cpumask_subset()
>> check below takes care of it though)?
> 
> Without that cpumask_and(), systems with sparse CPU numbering schemes
> (for example, 0, 4, 8, 12, ...) will get a pr_info(), and as you noted,
> the needed cpumask_and().
> 
> I am inclined to see a complaint before we change this.  And perhaps if
> this is to change, the change should be in cpumask_setall() rather than
> in rcu_init_nohz().  But that is an argument for later, if at all.  ;-)
> 
>>> +
>>>   	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {

We could also suppress the pr_info() by making it conditional.

like:

if (!CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) {
	pr_info(...);
}

In other words, we could make the cpumask_and() as expected/normal on
systems with sparse CPU numbering schemes. Would that work?

Thanks,

 - Joel


>>>   		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");



>>>   		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
