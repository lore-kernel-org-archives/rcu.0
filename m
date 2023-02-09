Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45524C636D4
	for <rcu@archiver.kernel.org>; Thu,  9 Feb 2023 11:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBIL6X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBIL4Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Feb 2023 06:56:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120745BA58
        for <rcu@vger.kernel.org>; Thu,  9 Feb 2023 03:45:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so1445612wrz.12
        for <rcu@vger.kernel.org>; Thu, 09 Feb 2023 03:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hu6GdqNd3zsA84btgPFw8USXgsViqaEjdbJQnrfaI4w=;
        b=n1Ienk5lRO8cXWiArd74AhjKDLGYOjoSuLC0rRa/zikn36qgUP3ui7o/AwrN8hMBJX
         Unk1ZpgBgrbfEPmhmnDsOuX8wI/DXel0M23Cv3AFj20qQtDxsqSdOtbZING9EmqacyF5
         I0CYpWWOdPX0s4w/LtCTfnYqomtoRnUbIiyK6SnPXTJISnHBN1CKCPxrxUKbJBnqCm9h
         5bCFrgasalLc0XAf3HlJpcuY+hQv9KNX0JXNQL9K1C2R64TDmFaeabXOkmj7HRVzHIwU
         ohqxTol+g/Ulqc1WRLf2HQnSWR6kbjoIgFLp6LsthUfIK2kCmFi+jEma6CTxY9+FhmhK
         YsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hu6GdqNd3zsA84btgPFw8USXgsViqaEjdbJQnrfaI4w=;
        b=cgQzbeawyL6OqErQhJroIBfQPqNfXUeYqog9QTSOBjbhnQhxOQUSW6nTU/m9qnxf92
         6sewn7pNsmz8bM/aStKrm+FVZjRxwHeM+hhtaXJLkgU95qtwsWNDaCNAc1I98hcwrCGC
         jtnwh3cRy5B33e32m2nLnF2eNY+6hXCzEC1bd2/toS0JdfJ3nt7FAPmVtlSOG3mOksU9
         Uq5a3h0a0jXDy46aSCggfntyRpQFa0U0Z9BV6Hf94PJFyJvEKGj8JnLh2Kp+WeSjbnXw
         +vSFl++r4k6lv04ysBPbRz3XV2dIjhEH7wzb1v2cZ0p8ryoVhNxpi9FI0QscD+kX8LmO
         p+8A==
X-Gm-Message-State: AO0yUKVqxcf+YQqtkPF5PUi4NLPuU1pdYB36gxOBUdu4vJEV2Y/IbQN7
        AHNu5D+qnj67s3C1kA1MghCVuA==
X-Google-Smtp-Source: AK7set+SdD0YDgg4BCREGyg/o6ZuyXLyU0+ajza8lIhXN2idY2jcgPdHDEeeYVo1q6dNnVXyEeB29Q==
X-Received: by 2002:a5d:6585:0:b0:2c3:c453:5dd3 with SMTP id q5-20020a5d6585000000b002c3c4535dd3mr10725274wru.36.1675943133621;
        Thu, 09 Feb 2023 03:45:33 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:8009:2525:9580:8db2? ([2a02:6b6a:b566:0:8009:2525:9580:8db2])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b002c3f280bdc7sm1085376wrz.96.2023.02.09.03.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 03:45:33 -0800 (PST)
Message-ID: <541a3e2a-d72e-98f7-bfc6-f64ef65f3043@bytedance.com>
Date:   Thu, 9 Feb 2023 11:45:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v7 0/9] Parallel CPU bringup for x86_64
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>, paulmck@kernel.org,
        tglx@linutronix.de
Cc:     kim.phillips@amd.com, arjan@linux.intel.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com
References: <20230207230436.2690891-1-usama.arif@bytedance.com>
 <20230209035300.GA3216394@paulmck-ThinkPad-P17-Gen-1>
 <8e2f03e2-9517-aeb4-df60-b36ef3ff3a75@bytedance.com>
 <f07b371ae2eb11f541c665b488b3d4b6bf1a81b3.camel@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <f07b371ae2eb11f541c665b488b3d4b6bf1a81b3.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 09/02/2023 11:03, David Woodhouse wrote:
> On Thu, 2023-02-09 at 09:49 +0000, Usama Arif wrote:
>>
>> Its easy to test, just by doing
>> echo 0 > /sys/devices/system/cpu/cpu0/online;
>> echo 1 > /sys/devices/system/cpu/cpu0/online;
> 
> This one also fixes it for me. If we're happy with this approach, I'll
> work it into Thomas's original patch (and hopefully eventually he'll be
> happy enough with it and the commit message that he'll give us his
> Signed-off-by for it.)
> 

Yes, I think its better!

> 
> I could probably add a Co-developed-by: tglx for that first x2apic
> patch in the series too, but then it would *also* need his SoB and I
> didn't want to be owed two, so I just pasted his suggested code and
> didn't credit him.
> 
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 5462464fe3ef..ea6052a97619 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -450,7 +450,16 @@ SYM_CODE_END(secondary_startup_64)
>   SYM_CODE_START(start_cpu0)
>          ANNOTATE_NOENDBR
>          UNWIND_HINT_EMPTY
> -       movq    initial_stack(%rip), %rsp
> +       /* Load the per-cpu base for CPU#0 */
> +       leaq    __per_cpu_offset(%rip), %rbx
> +       movq    (%rbx), %rbx
> +
> +       /* Find the idle task stack */
> +       movq    $idle_threads, %rcx
> +       addq    %rbx, %rcx
> +       movq    (%rcx), %rcx
> +       movq    TASK_threadsp(%rcx), %rsp
> +
>          jmp     .Ljump_to_C_code
>   SYM_CODE_END(start_cpu0)
>   #endif
> 
> I cut and pasted some of that, I'm not entirely sure why we have three
> instructions to do the equivalent of 'movq idle_threads(%ebx), %ecx'
> and may fix that in the original as I work this in.
