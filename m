Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BEFC636CD
	for <rcu@archiver.kernel.org>; Sun,  5 Feb 2023 22:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBEWON (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 5 Feb 2023 17:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBEWOM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 5 Feb 2023 17:14:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BE1A97D
        for <rcu@vger.kernel.org>; Sun,  5 Feb 2023 14:13:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so9563662wmb.2
        for <rcu@vger.kernel.org>; Sun, 05 Feb 2023 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLcR+Tb9prra+Se7ZuzrntYvfyrN/MR5XtNW3aD8zyw=;
        b=4ft5GDnoVp+w6TaJwMkAsxpPQJs54iYqt69woNnt+VDD6uj8d0NY+XX0PxfeUJQ2KV
         7GJTDuhhJfsYVyfKsETcCx/vXW3tp6mxf/i81QsgCIMldUuaOT+2jHcxaZnkm+H0UICy
         Jp874j9n9em2PZP3lV3FCGSdX/u5D2J6BWDXZXvl9JWnE7uSAB/3QHHZdwwOWNt+wPfm
         ar8XIxg2efnKf3+df0/IKqeg4K4mug9NCokBGuv52N1fi4U8klnx1sCxtP7nqELJydso
         stUMGSuFF9ESdJFN1cT+WmzpNl9RuKzBPsohEa+iqtQOkA9UrKeh8QE2nxOxwKIEsFzV
         efpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLcR+Tb9prra+Se7ZuzrntYvfyrN/MR5XtNW3aD8zyw=;
        b=fVmVQ0JZaGlCoSbHe1357rdu9vf6JhIv3/bo7UYLk67B1YhADOiEk2d3+l5RKdXSbP
         u2Ow3dFYUwias8gPASN9swz1DULvJuF+2pjNoFowyxo6QZkUXisbzc4gTDaZJC2UAkBT
         ayB2hP5VybwOl4v397ikqwoWcsN/0q45JHECQmCTcqlr6Z7zhezZNdd+K+fhRKe0K2LJ
         gdNjNGRZKUuCrzB//OkU1FI0LB5e33fv4b3ri8lcSrDyCVy+u7cLNtj4NQaHwQYapqzF
         rHYOzy8u8zCQBZKAO6iXW0VlcPbG2ZgsXQjTfbfZTXelC5BUTky7VWZPqZEc1P+jdEvO
         HP0w==
X-Gm-Message-State: AO0yUKUTqJg/ha/9aSyOsVe2u+OK1+xCbkBFfaL74T427xMNiMCqn257
        92FJmhMrLGnj8DHzyxirtIcHug==
X-Google-Smtp-Source: AK7set9AzQNdF1lQ6lMPa+waBDd2VLHlnzjxaAqKEWNBXxg7rJbBtilA7tgGYY9tgS0YLeyWNvnDCg==
X-Received: by 2002:a05:600c:c06:b0:3dc:5a7c:f8ad with SMTP id fm6-20020a05600c0c0600b003dc5a7cf8admr21135260wmb.21.1675635223505;
        Sun, 05 Feb 2023 14:13:43 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:56a5:4a1b:a896:763a? ([2a02:6b6a:b566:0:56a5:4a1b:a896:763a])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b003dd1b00bd9asm9746157wmq.32.2023.02.05.14.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 14:13:42 -0800 (PST)
Message-ID: <434b4b74-54ab-68a3-4a81-9cc02ea75e39@bytedance.com>
Date:   Sun, 5 Feb 2023 22:13:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v6 07/11] x86/smpboot: Disable parallel
 boot for AMD CPUs
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>, tglx@linutronix.de,
        rja@hpe.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, Mario Limonciello <Mario.Limonciello@amd.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
 <20230202215625.3248306-8-usama.arif@bytedance.com>
 <b3d9fbbf-e760-5d1d-9182-44c144abd1bf@amd.com>
 <d3ec562fd2e03c3aef9534f64915a14a8cb89ae1.camel@infradead.org>
 <5ba476f3-e0ac-d630-ce1d-18ab9885496f@linux.intel.com>
 <E2286684-F8AD-4708-9A3D-74C5EAE183B4@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <E2286684-F8AD-4708-9A3D-74C5EAE183B4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 04/02/2023 22:31, David Woodhouse wrote:
> 
> 
> On 4 February 2023 18:18:55 GMT, Arjan van de Ven <arjan@linux.intel.com> wrote:
>>>
>>> However...
>>>
>>> Even though we *can* support non-X2APIC processors, we *might* want to
>>> play it safe and not go back that far; only enabling parallel bringup
>>> on machines with X2APIC which roughly correlates with "lots of CPUs"
>>> since that's where the benefit is.
>>
>> I think that this is the right approach, at least on the initial patch series.
>> KISS principle; do all the easy-but-important cases first, get it stable and working
>> and in later series/kernels the range can be expanded.... if it matters.
> 
> Agreed. I'll split it to do it only with X2APIC for the initial series, and then hold the CPUID 0x1 part back for the next phase.

This was an interesting find! I tested the latest branch 
parallel-6.2-rc6 and it works well. The numbers from Russ makes the 
patch series look so much better! :)

If we do it with x2apic only and not support non-x2apic CPUID 0x1 case, 
maybe we apply the following diff to part 1?

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f53a060a899b..f6b89cf40076 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1564,7 +1564,7 @@ void __init native_smp_prepare_cpus(unsigned int 
max_cpus)
          * sufficient). Otherwise it's too hard. And not for SEV-ES
          * guests because they can't use CPUID that early.
          */
-       if (IS_ENABLED(CONFIG_X86_32) || boot_cpu_data.cpuid_level < 1 ||
+       if (IS_ENABLED(CONFIG_X86_32) || !x2apic_mode ||
             (x2apic_mode && boot_cpu_data.cpuid_level < 0xb) ||
             cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
                 do_parallel_bringup = false;



For reusing timer calibration, calibrate_delay ends up being used in 
start_kernel, smp_callin, debug_calc_bogomips and check_cx686_slop. I 
think reusing timer calibration would be ok in the first 2 uses? but not 
really sure about the other 2. cx686 seems to be quite old so not sure 
if anyone will have it to test or will ever run 6.2 kernel on it :).  I 
guess if unsure, better to leave out initially and try and get part1 merged?

Thanks,
Usama
