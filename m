Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F59C61DA3
	for <rcu@archiver.kernel.org>; Tue, 21 Feb 2023 11:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjBULzj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Feb 2023 06:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjBULze (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Feb 2023 06:55:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD62528F
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 03:54:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l25so3728305wrb.3
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 03:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lzq9naJ5Gwo2WGrWv0NYN2BRYvpnbF1Pf8MG1ViESI=;
        b=1vfskNEeBw11/q2YRjmKPk9C/aSwz5XfH6BYxqXucGqTi4LHziHOgmd0nJ9Dk4Anbr
         VBr5j9XrjyJMeMJwlYhgeUXkA6MdK1+6FQX+Y+ebvbU+Dj/SW9QfoPeZYuZxuFwzxjqs
         4LWrdfFIHxqUYv7H2wOq6RAQrCLCWWowh0m5UwgoRXHAXjL9p8nJVr/gRTesH7Saz7Yy
         mv6sG6L9jcerch+b8Gj7j+6nFABtDFOAaXXiOA+0Yh9wWhgYAIC043KkH1hjlQdJAY8e
         WNXsUFD/pW4PoK+rVdIFJyB4ouNed3pJb5P4dy+KaxWxhaqWYjPIR47rNG/LR30Ot8Nv
         pFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lzq9naJ5Gwo2WGrWv0NYN2BRYvpnbF1Pf8MG1ViESI=;
        b=EEHlyfYBeBPYQwIHtMz+gxqMUBn4157S8wzoH7BHiMhVyWKnIrZLBkl76cT7qzLDm4
         STH9BUIpcbyGCTtSp0fGj/rwNnGXE7+82v28xoTMgNOUS8X/dRMcrZOIaATVjPmWA/PR
         V7h3JxD25I9vHhAeUwJtC3FrcKqyAZVG+bNeFE7EcD2ohcO4EZtP8vlanZATo7F/yWpL
         bAYhezDPISI0ep2+tpWH5YanfR64sWJ0EDsqjHdFpKzTRWsZe/foozafTVFVjQQ73V6B
         bSaEdoJDM21TDx7/I+dCRlEBwjhOPYHb1Yq5JoGWAMMx5c5ue88He5raZ3l/MmId29l6
         ipNg==
X-Gm-Message-State: AO0yUKX3XzbDL619jaRflNCOCe+PfT5suaMFj4ytKej/vs5XZt/5XCph
        1Sg0Qwe1yYJs8JtUOzcnmNsi7A==
X-Google-Smtp-Source: AK7set9w+obqnpH8kQtyt0L04B6t2sN1mCYhzDOdSVFbeQypoWXmVKBW+GEhamKB9CPiWpe2+7NXYQ==
X-Received: by 2002:a5d:6f0c:0:b0:2c5:55c3:d18d with SMTP id ay12-20020a5d6f0c000000b002c555c3d18dmr2588566wrb.9.1676980491294;
        Tue, 21 Feb 2023 03:54:51 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:8498:f303:14d8:47b5? ([2a02:6b6a:b566:0:8498:f303:14d8:47b5])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d4c4d000000b002c55de1c72bsm8090429wrt.62.2023.02.21.03.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:54:50 -0800 (PST)
Message-ID: <049adfae-f4a0-349e-323a-52299969ef99@bytedance.com>
Date:   Tue, 21 Feb 2023 11:54:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v9 0/8] Parallel CPU bringup for x86_64
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Kim Phillips <kim.phillips@amd.com>, tglx@linutronix.de,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Piotr Gorski <piotrgorski@cachyos.org>
References: <20230215145425.420125-1-usama.arif@bytedance.com>
 <2a67f6cf18dd2c1879fad9fd8a28242918d3e5d2.camel@infradead.org>
 <982e1d6140705414e8fd60b990bd259a@natalenko.name>
 <715CBABF-4017-4784-8F30-5386F1524830@infradead.org>
 <67dbc69f-b712-8971-f1c9-5d07f506a19c@amd.com>
 <42dc683e2846ae8fc1e09715aaf7884660e1a386.camel@infradead.org>
 <37c18c3aeea2e558633b6da6886111d0@natalenko.name>
 <5A3B7074-0C6D-472B-803B-D76541828C1F@infradead.org>
 <3d8ed6e157df10c5175c636de0e21849@natalenko.name>
 <5c557f9b6f55dc2a612ee89142971298e6ae12d8.camel@infradead.org>
 <ee0d0d971a3095d6a1e96ad4f1ba32d2@natalenko.name>
 <5b8f9c89f7015fa80c966c6c7f6fa259db6744f8.camel@infradead.org>
 <ce731b5a4a53680b4840467977b33d9a@natalenko.name>
 <85ceb3f92abf3c013924de2f025517372bed19c0.camel@infradead.org>
 <3e5944de08ef0d23584d19bad7bae66c@natalenko.name>
 <26E5DC9C-0F19-4E4F-9076-04506A197374@infradead.org>
 <d91f96eb-86a1-c794-761d-a96e39076b13@bytedance.com>
 <6e7d75d98266ab68b57bf6db644ecc75@natalenko.name>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <6e7d75d98266ab68b57bf6db644ecc75@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 21/02/2023 11:42, Oleksandr Natalenko wrote:
> On 21.02.2023 11:47, Usama Arif wrote:
>> On 21/02/2023 10:27, David Woodhouse wrote:
>>>
>>> On 21 February 2023 09:49:51 GMT, Oleksandr Natalenko 
>>> <oleksandr@natalenko.name> wrote:
>>>> On 21.02.2023 10:06, David Woodhouse wrote:
>>>>> Why does arch/x86/kernel/acpi/sleep.c::x86_acpi_suspend_lowlevel() set
>>>>>
>>>>>      initial_gs = per_cpu_offset(smp_processor_id()) ?
>>>>>
>>>>> Would it not be CPU#0 that comes back up, and should it not get
>>>>> per_cpu_offset(0) ?
>>>>
>>>> Wanna me try `initial_gs = per_cpu_offset(0);` too?
>>>
>>
>> I think it might be smp_processor_id() and not 0 incase CPU0 was 
>> offline at the point the system was suspended?
> 
> Is it even possible for CPU 0 to be offline, at least on x86?
> 

It is possible on x86 (using BOOTPARAM_HOTPLUG_CPU0), but I just read 
the Kconfig option and it says:

"resume from hibernate or suspend always starts from CPU0.
So hibernate and suspend are prevented if CPU0 is offline."

so I guess switching to 0 should be ok.
