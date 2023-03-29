Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EC5C74A5B
	for <rcu@archiver.kernel.org>; Wed, 29 Mar 2023 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjC2LKF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Mar 2023 07:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2LKE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Mar 2023 07:10:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19653C1E
        for <rcu@vger.kernel.org>; Wed, 29 Mar 2023 04:10:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l27so15246505wrb.2
        for <rcu@vger.kernel.org>; Wed, 29 Mar 2023 04:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680088201;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fMyRoI+gDBMSQ1ASPAj5GDfjiLEoGxH9G7/ldjpWq0=;
        b=Q1JX6+bz61+vh+Vzi+sUwW3yMZkzm75oKFpftOGczVAhMrRDKm0YR/bBqfuht4I4G0
         yvMwrHoq81CHuHyybcV/HPEQWF0NIdOH7bDzS37+Gr2coehioxNJ8a59CKMBA2XsZp6h
         8wtpVuc69EPsfRMeKaNWH2Fvmbl9ev5l1PbaHocbOfQ/X0Uwteton/ZLxjXcoCbnErLl
         w1T0tHaZo9yPx2R7aeax5iKD+dsN1rQq98OVSuy14aEp3lvRsjwMj40Oyit5R9o+8gGr
         d28N78YHVgGHJNYCrpiy462211GYs3XiGa2aj2RbW3aqBF24wOZBfKJWhajVPZIj/McR
         iPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680088201;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fMyRoI+gDBMSQ1ASPAj5GDfjiLEoGxH9G7/ldjpWq0=;
        b=Xh8n0b9uVs/v9PbnSVkKYE3HVDFb3tlXAsn8wQ1P/5+gs1/oWtg5xV3eEXDahREp+T
         vFILNpTFb1X34t7xlpQyQ8h/2NsymzhNZQRUmiGK2VJWqK+UC0LBxWEZ91ZGL3p3TDUY
         QPN/CUVRjKu8eTXB0o56aZP7EpYziy7c8j/1rEynUMiTamDWtRLQ1Sk3/oWikGzF9U9T
         MFczuVT22ccqQhq1O4yU85iH90gjQOO+A9wdgYvlD+oO6vNZALfGVpxaKncSlYzAI0PZ
         jtEWs1IQoxCdJxxbSG4EM6LK1HQrnnYpwS6PTsdj75QbtPuTJPDwWeXwLely5lgaMA9b
         lsMQ==
X-Gm-Message-State: AAQBX9dJscjusxZKsAGLmOnZsw/1cQnDeow+yDiNfd7/l66fY6+1kCFq
        TtyUc92hzhj3QXfINQ95XLHJWQ==
X-Google-Smtp-Source: AKy350ZMd5xDkTUJpUgfq6tGD1h9j1CDSgZ2snnpFp2odtgk5TA+d4edR7BJm6x3BDtTdIHsEhjZgg==
X-Received: by 2002:adf:dd4f:0:b0:2cf:ec75:8090 with SMTP id u15-20020adfdd4f000000b002cfec758090mr14969737wrm.14.1680088201184;
        Wed, 29 Mar 2023 04:10:01 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b566:0:4aac:c45d:f15a:d179? ([2a02:6b6a:b566:0:4aac:c45d:f15a:d179])
        by smtp.gmail.com with ESMTPSA id i7-20020adffc07000000b002c5706f7c6dsm29908071wrr.94.2023.03.29.04.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:10:00 -0700 (PDT)
Message-ID: <8b6eeca2-bc35-6e17-e1e9-27d77565db67@bytedance.com>
Date:   Wed, 29 Mar 2023 12:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v17 2/8] cpu/hotplug: Reset task stack state in _cpu_up()
Content-Language: en-US
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230328195758.1049469-1-usama.arif@bytedance.com>
 <20230328195758.1049469-3-usama.arif@bytedance.com>
In-Reply-To: <20230328195758.1049469-3-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 28/03/2023 20:57, Usama Arif wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit dce1ca0525bf ("sched/scs: Reset task stack state in bringup_cpu()")
> ensured that the shadow call stack was reset and KASAN poisoning removed
> from a CPU's stack each time that CPU is brought up, not just once.
> 
> This is not incorrect. However, with parallel bringup, an architecture
> may obtain the idle thread for a new CPU from a pre-bringup stage, by
> calling idle_thread_get() for itself. This would mean that the cleanup
> in bringup_cpu() would be too late.
> 
> Move the SCS/KASAN cleanup to the generic _cpu_up() function instead,
> which already ensures that the new CPU's stack is available, purely to
> allow for early failure. This occurs when the CPU to be brought up is
> in the CPUHP_OFFLINE state, which should correctly do the cleanup any
> time the CPU has been taken down to the point where such is needed.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Forgot to include my sign-off. Thanks David for pointing it out.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>

> ---
>   kernel/cpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6c0a92ca6bb5..43e0a77f21e8 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -591,12 +591,6 @@ static int bringup_cpu(unsigned int cpu)
>   	struct task_struct *idle = idle_thread_get(cpu);
>   	int ret;
>   
> -	/*
> -	 * Reset stale stack state from the last time this CPU was online.
> -	 */
> -	scs_task_reset(idle);
> -	kasan_unpoison_task_stack(idle);
> -
>   	/*
>   	 * Some architectures have to walk the irq descriptors to
>   	 * setup the vector space for the cpu which comes online.
> @@ -1383,6 +1377,12 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
>   			ret = PTR_ERR(idle);
>   			goto out;
>   		}
> +
> +		/*
> +		 * Reset stale stack state from the last time this CPU was online.
> +		 */
> +		scs_task_reset(idle);
> +		kasan_unpoison_task_stack(idle);
>   	}
>   
>   	cpuhp_tasks_frozen = tasks_frozen;
