Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5207EC6379F
	for <rcu@archiver.kernel.org>; Wed, 22 Feb 2023 11:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBVLLz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Feb 2023 06:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBVLLy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Feb 2023 06:11:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0808144AD
        for <rcu@vger.kernel.org>; Wed, 22 Feb 2023 03:11:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o4so7337185wrs.4
        for <rcu@vger.kernel.org>; Wed, 22 Feb 2023 03:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=900pVIUNDl1fFAAAWqIXzxz+XxoOhUTKstOFvaC+URs=;
        b=xho3b8ocCJ7HKp7c6JvNQ3PKBC9TwznMUIRoiZ7KPTLvAW/CGu5VT4e4Z34PyhKABz
         M6o5xG+tZN2VpFz+TuqxkEEuwI09jUupHx7PbMx9mShJxoDTmJSnorABMvf6aMYv5J0X
         wf+pRydrfs2hfBzelkQera/fyeK04lum6n56m6NI2TWaO7yVzEvvcEB6wyaOf63Zxk27
         SpDKMd+UzxnTiKs2YxQqwOAYbmcnEqwdyAIzE9J5hDQ89SIrfGJ/GkI7ObqoR0lHfQKc
         JoqOUJkOJxPAV8rSPi69WFfwyNMZlgKS8EORBlCTZT/y0zxOmVKidPf6STWn5j5XlSUC
         Ewjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=900pVIUNDl1fFAAAWqIXzxz+XxoOhUTKstOFvaC+URs=;
        b=sz9Tfh8jfrNNlM709f6P1s/6SSXKmwspgM+JIXFw4CwF2+0KytQnDD+GISXZlRnqEE
         zzGyTdL5APCOwzSBsltC62bsa9/2qMj258w+BAj3EEmb2ApjHKvvMi+OiEgAlf7XWqd7
         oTvI6impC0A8FCkUxP13YLL7fx/g7Eem0lw4Qh9G00kKwepksv5zKX22hF5Sdji0Hm+d
         q/eCuahkz8wWqluHXFFXijg0j5vgRUuLLMOWcJbQCh7h9jSiA4GoeQyTuBV0MwShdcfy
         J6PaL7IeiPXebHDtV7U95u6Vxz+/spSsMv8eA9XgrfAYXRFXyMBOGSLgPqTwdSgYRHFl
         eCVQ==
X-Gm-Message-State: AO0yUKXeTQTUboGBzVRM82D7eCBwHuobkFivQrxGthAATlsK+s4VcMIl
        QgG1rp97+K0IrpTDXa4SxEZoKg==
X-Google-Smtp-Source: AK7set/ggH+OgPFF3Af4lqBRWPf69Uivg6sXAUDLs9koPOrEzabpRzCUtqBNSoo0/1NC7/lxiFedNw==
X-Received: by 2002:adf:edc5:0:b0:2c7:daa:d01 with SMTP id v5-20020adfedc5000000b002c70daa0d01mr270834wro.11.1677064286366;
        Wed, 22 Feb 2023 03:11:26 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:1a14:8be6:b3a9:a95e? ([2a02:6b6a:b566:0:1a14:8be6:b3a9:a95e])
        by smtp.gmail.com with ESMTPSA id z3-20020adff1c3000000b002c559def236sm5342738wro.57.2023.02.22.03.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 03:11:25 -0800 (PST)
Message-ID: <be85a49f-9867-6117-9c35-f7d7b8c0cdff@bytedance.com>
Date:   Wed, 22 Feb 2023 11:11:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v9 0/8] Parallel CPU bringup for x86_64
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
        kim.phillips@amd.com, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com
References: <20230215145425.420125-1-usama.arif@bytedance.com>
 <62ee53770b4010f065346b7f2a1200013836be97.camel@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <62ee53770b4010f065346b7f2a1200013836be97.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 22/02/2023 10:11, David Woodhouse wrote:
> On Wed, 2023-02-15 at 14:54 +0000, Usama Arif wrote:
>> The main change over v8 is dropping the patch to avoid repeated saves of MTRR
>> at boot time. It didn't make a difference to smpboot time and is independent
>> of parallel CPU bringup, so if needed can be explored in a separate patchset.
>>
>> The patches have also been rebased to v6.2-rc8 and retested and the
>> improvement in boot time is the same as v8.
> 
> Thanks for picking this up, Usama.
> 
> So the next thing that might be worth looking at is allowing the APs
> all to be running their hotplug thread simultaneously, bringing
> themselves from CPUHP_BRINGUP_CPU to CPUHP_AP_ONLINE. This series eats
> the initial INIT/SIPI/SIPI latency, but if there's any significant time
> in the AP hotplug thread, that could be worth parallelising.
> 
> There may be further wins in the INIT/SIPI/SIPI too. Currently we
> process each CPU at a time, sending INIT, SIPI, waiting 10µs and
> sending another SIPI.
> 
> What if we sent the first INIT+SIPI to all CPUs, then did another pass
> sending another SIPI only to those which hadn't already started running
> and set their bit in cpu_initialized_mask ?
> 
> Might not be worth it, and there's an added complexity that they all
> have to wait for each other (on the real mode trampoline lock) before
> they can take their turn and get as far as setting their bit in
> cpu_initialized_mask. So we'd probably end up sending the second SIPI
> to most of them *anyway*.

Thanks! I think I sent out v10 a bit too early, but hopefully it looks 
like everyone agrees on the suspend code in it at the moment?

As a next step, I was thinking of reposting and starting a discussion on 
the reuse timer calibration patch separately. Its not part of parallel 
smp, but in my testing, it takes away (70ms) ~70% of the remaining 
parallel smpboot time. With the machine and kernel I am testing, the 
kexec reboot time after parallel smp is just under a second, so this 
represents ~7% of the boot time, which is a notable percentage reduction 
in server downtime. Or maybe someone could reply to this thread saying 
its not a good idea to post it as I remember there were quite a few 
reservations about it? :)

Thanks,
Usama
