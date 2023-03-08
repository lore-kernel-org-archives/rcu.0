Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8446FC64EC4
	for <rcu@archiver.kernel.org>; Wed,  8 Mar 2023 14:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCHOLZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Mar 2023 09:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjCHOLF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Mar 2023 09:11:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC7B5B5CB
        for <rcu@vger.kernel.org>; Wed,  8 Mar 2023 06:10:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j2so15484472wrh.9
        for <rcu@vger.kernel.org>; Wed, 08 Mar 2023 06:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678284607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwuTURK4pgdaZOSjBm4ykIJHPiI6ZMc4y7U8yqvAA8E=;
        b=NxOQX0losj6KUjW09AqI8TallxXyzA+67KC1SEgp5kdAmzbG3S4/HUaTEGpBt3NUOr
         RHSUf+M77rNNQ0yqTjZemL7w9dmOTJee81l+pDDJG2MinGPI8ZRofYU2MclMNz/BemM3
         /n9jvPmXzsIkdGyNpIwkLobcprw/oWVKCKX/VBetSFHw3132J1qu0g0Bwhx2U5HWNGDV
         XBn5qVa1t1g8WXO5j5MrJfYSbeCLA+XEiSPaDDg0jDD3L3Ms6lHUuWuuu2ef742x6ntt
         utuPNEU19qiu0+mNpg1DvB73RhRVwZYg5IrhvFacFD2Tzl3rQigC62uF2OcjQHtI4XaV
         u+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678284607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwuTURK4pgdaZOSjBm4ykIJHPiI6ZMc4y7U8yqvAA8E=;
        b=PJ8DdWs8uZHvvpb0GqDCPlh8d+vw2NZtmuh6Rl9LZ8jR5Vdtddrs2bTXz7DVLTgGMH
         AOqiVgL2zgUt5tcs7wARqTu0HOAT8NVnOkpqa5vfKPaxmgbGsYdJT9r+mI+UEkvI22P+
         owVsjQc7lH/wLz4pc2DjFQcMaQMX8FU7kRN8Ormb9WN61wLTB8HCh7nhDoA04uLwbb1c
         c3YyOAqTxRi+DQLmKAKweWdQkPqK6Nk/y8HiunmEc5sca4NSYTpB5jLwFfmFAC2ULeQ8
         QpUStCb+D5A5Gmc8TlB/9SqLi4n8wDpGCXr7VNHoSR34vlx/ziANIDiDBI3AvFs0kjPW
         rKFA==
X-Gm-Message-State: AO0yUKXrNMiIvzsp0H4G1IeRRw4bHt+/AlWNHIxe7o/903sdAa3B0Kh5
        Ev24VBv/UvGvepHgcOEbpuOqdA==
X-Google-Smtp-Source: AK7set/OkWWaPqXZ/GgjkOaIwX0t9gxjOEHVNFuu2kgYmqldgwXq2yccYCG6fFviJObZxipEmkpzrg==
X-Received: by 2002:adf:f5c9:0:b0:2c7:1210:fe42 with SMTP id k9-20020adff5c9000000b002c71210fe42mr11736229wrp.47.1678284607105;
        Wed, 08 Mar 2023 06:10:07 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:52ca:aea8:eb67:a912? ([2a02:6b6a:b566:0:52ca:aea8:eb67:a912])
        by smtp.gmail.com with ESMTPSA id m14-20020adffe4e000000b002c54c8e70b1sm15571371wrs.9.2023.03.08.06.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:10:06 -0800 (PST)
Message-ID: <a6090023-29d7-a190-d118-56b8e7acffc6@bytedance.com>
Date:   Wed, 8 Mar 2023 14:10:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v13 00/11] Parallel CPU bringup for x86_64
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "Rapan, Sabin" <sabrapan@amazon.com>
Cc:     "piotrgorski@cachyos.org" <piotrgorski@cachyos.org>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "mimoja@mimoja.de" <mimoja@mimoja.de>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        "simon.evans@bytedance.com" <simon.evans@bytedance.com>,
        "liangma@liangbit.com" <liangma@liangbit.com>
References: <20230302111227.2102545-1-usama.arif@bytedance.com>
 <faa0eb3bb8ba0326d501516a057ab46eaf1f3c05.camel@infradead.org>
 <effbb6e2-c5a1-af7f-830d-8d7088f57477@amd.com>
 <269ed38b5eed9c3a259c183d59d4f1eb5128f132.camel@infradead.org>
 <0c56683a-c258-46f6-056e-e85da8a557db@amd.com>
 <3bfbbd92-b2ed-8189-7b57-0533f6c87ae7@amd.com>
 <1975308c952236895f2d8f0e56af9db288eaf330.camel@infradead.org>
 <39f23da7-1e77-4535-21a6-00f77a382ae5@amd.com>
 <ba8aae2eafdeb09ec1a41d45ab3c2e4cdaf7a28f.camel@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <ba8aae2eafdeb09ec1a41d45ab3c2e4cdaf7a28f.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> static bool prepare_parallel_bringup(void)
> {
> 	bool has_sev_es = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) &&
> 		static_branch_unlikely(&sev_es_enable_key);

sev_es_enable_key is only defined when CONFIG_AMD_MEM_ENCRYPT is 
enabled, so it gives a build error when AMD_MEM_ENCRYPT is disabled. 
maybe below is better?

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 282cca020777..e7df41436cfe 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1519,8 +1519,12 @@ void __init smp_prepare_cpus_common(void)
   */
  static bool prepare_parallel_bringup(void)
  {
-       bool has_sev_es = IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT) &&
-               static_branch_unlikely(&sev_es_enable_key);
+       bool has_sev_es;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+       has_sev_es = static_branch_unlikely(&sev_es_enable_key);
+#else
+       has_sev_es = 0;
+#endif

         if (IS_ENABLED(CONFIG_X86_32))
                 return false;
