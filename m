Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE37C636CC
	for <rcu@archiver.kernel.org>; Wed,  8 Feb 2023 12:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjBHMya (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Feb 2023 07:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBHMy3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Feb 2023 07:54:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69180241F3
        for <rcu@vger.kernel.org>; Wed,  8 Feb 2023 04:54:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1408293wms.0
        for <rcu@vger.kernel.org>; Wed, 08 Feb 2023 04:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbu+Qp3H391Eb/1v8euZ4W7qurN5ceJRB7UVV/W0fqk=;
        b=rNQTXy6D0WTaHNnOLcl/CztjI3TVlJqBotvL8w6lYKQnoryfNvaxAuuLGfps6gitnn
         3VFicmNEa02LXy0xc3frf+IWHfcZ0douH6rHUHj4BtEYTeRjHLVJ3HDQD0xSK5MjhR3t
         8EXcmN/bThR9Y9IuSNjyEGBejYe/O1eyBpky9G1Fq9tOCH2QHElj7ZBKcFOq2rtHjiPx
         HMwOvtEaturf3nuUT3aFp+IyOTdeYpaNB+aR1frA2AbrMozLqYhdmhE4oIlQbmq0+3pE
         oxFm20WP21Jvkm5SfneedMCwfn9dLzme2DPEsVHoKKo4+LxdAYJD7Nko3u5UlkQW+QEH
         RATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbu+Qp3H391Eb/1v8euZ4W7qurN5ceJRB7UVV/W0fqk=;
        b=nlXjSHKNePRMmnQUcsw4F03qu1HCHs+7cOPVRVFlbk+TJH5S+dtzmMWFdv1WZjI9nc
         AvcoP9eT+SRS3Ah9pCEvoPE5TZBkUmPwfUN50EAlAgguXKWC7AqW8PbaslUCO/sDiiXz
         paQcAArA5zYtBssjHucNO1xvtwPodtdBU6qZnqKy3JSkMfEIIC7zk/M24JyXYK2KToWz
         CYfSyZ+hk/aeMEEADHCAitXeERUi2Zf6k9Yf+gMo79rRNgc0RIE9D+P48sbo2+c82gIj
         QOBXB0EnXoNDVJiuSjqEUMhUzVCNzk9eihM3aOjlTNCKwL8M9Rb6uIieSQ7FP3ICKr1P
         m2Ow==
X-Gm-Message-State: AO0yUKUULVeOEHiNPP6y/FeDNPo/fbaaKFBC1Jj8vUGEQCQq2FIS7Lfi
        leMIQHEdv5afUxY1IpHyMKgFYw==
X-Google-Smtp-Source: AK7set8xdIQQgwZvX1OR7eNm518Bawsc3t4csucPiGSGyRqXvuHdJjpBwLcQq4XLpD5I+V5lw9cHEQ==
X-Received: by 2002:a05:600c:44d3:b0:3e0:481:c896 with SMTP id f19-20020a05600c44d300b003e00481c896mr6370172wmo.35.1675860841996;
        Wed, 08 Feb 2023 04:54:01 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:b2b3:5502:81b7:d4ad? ([2a02:6b6a:b566:0:b2b3:5502:81b7:d4ad])
        by smtp.gmail.com with ESMTPSA id d3-20020a056000114300b002c3f9404c45sm2412841wrx.7.2023.02.08.04.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 04:54:01 -0800 (PST)
Message-ID: <86df2c79-3626-d476-54b4-82c225a6dbd9@bytedance.com>
Date:   Wed, 8 Feb 2023 12:54:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v7 6/9] x86/smpboot: Support parallel
 startup of secondary CPUs
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>, dwmw2@infradead.org
Cc:     tglx@linutronix.de, kim.phillips@amd.com, arjan@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com
References: <20230207230436.2690891-1-usama.arif@bytedance.com>
 <20230207230436.2690891-7-usama.arif@bytedance.com>
 <CAMzpN2iejCnBeBdC6+92fUL2k8ZdAq_jEgXX+RSoGMhRZ0UBSA@mail.gmail.com>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <CAMzpN2iejCnBeBdC6+92fUL2k8ZdAq_jEgXX+RSoGMhRZ0UBSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 08/02/2023 05:09, Brian Gerst wrote:
> On Tue, Feb 7, 2023 at 6:10 PM Usama Arif <usama.arif@bytedance.com> wrote:
>>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Rework the real-mode startup code to allow for APs to be brought up in
>> parallel. This is in two parts:
>>
>> 1. Introduce a bit-spinlock to prevent them from all using the real
>>     mode stack at the same time.
>>
>> 2. Avoid the use of global variables for passing per-CPU information to
>>     the APs.
>>
>> To achieve the latter, export the cpuid_to_apicid[] array so that each
>> AP can find its own per_cpu data (and thus initial_gs, initial_stack and
>> early_gdt_descr) by searching therein based on its APIC ID.
>>
>> Introduce a global variable 'smpboot_control' indicating to the AP how
>> it should find its APIC ID. For a serialized bringup, the APIC ID is
>> explicitly passed in the low bits of smpboot_control, while for parallel
>> mode there are flags directing the AP to find its APIC ID in CPUID leaf
>> 0x0b (for X2APIC mode) or CPUID leaf 0x01 where 8 bits are sufficient.
> 
> For the serialized bringup case, it would be simpler to just put the
> cpu number in the lower bits instead of the APIC id, skipping the
> lookup.
> 
> --
> Brian Gerst

I guess we could do something like below, it would save a few loops 
through find_cpunr in serial case, but probably is as simple as just 
using setup_AP and find_cpunr for all cases? Happy with either but if 
there is a strong preference for below, can change in next revision?

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 656e6018b9d4..30aa543a0114 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -265,7 +265,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, 
SYM_L_GLOBAL)
         testl   $STARTUP_APICID_CPUID_01, %edx
         jnz     .Luse_cpuid_01
         andl    $0x0FFFFFFF, %edx
-       jmp     .Lsetup_AP
+       mov     $8, %eax
+       mul     %edx
+       movq    %rax, %rcx
+       jmp     .Linit_cpu_data

  .Luse_cpuid_01:
         mov     $0x01, %eax
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ffec5de2e2e..73dd87bf2f29 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1141,7 +1141,7 @@ static int do_boot_cpu(int apicid, int cpu, struct 
task_struct *idle,
                 early_gdt_descr.address = (unsigned 
long)get_cpu_gdt_rw(cpu);
                 initial_stack  = idle->thread.sp;
         } else if (!do_parallel_bringup) {
-               smpboot_control = STARTUP_SECONDARY | apicid;
+               smpboot_control = STARTUP_SECONDARY | cpu;
         }

         /* Enable the espfix hack for this CPU */
