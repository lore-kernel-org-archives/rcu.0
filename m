Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A2C7EE23
	for <rcu@archiver.kernel.org>; Fri, 24 Feb 2023 19:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBXTRf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBXTRc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 Feb 2023 14:17:32 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A20C6EB27
        for <rcu@vger.kernel.org>; Fri, 24 Feb 2023 11:17:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r18so223365wrx.1
        for <rcu@vger.kernel.org>; Fri, 24 Feb 2023 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlPt4Q3q43f/kES2hajYBu0feYXRxIPRsViZnbHRgo8=;
        b=ULOxdkQfJSc2wzWXnZzkcOyay31tWrkYETOwBzB86fVZxSrlFxO0D+wFcUzNSs6OEy
         G/Wj5Om0d1dD3bur8hORomrHxlcp2EbExVSVCLMSKMGK2NC7h+NFjFMV7o67rbfpdPJe
         IeIpNPsVMo+s+E7ly717Zk+OS1Cl+Gkl9QbLcj3fT3nhhNHD2KH0fO3KZ5srXAerW70V
         tMXC90LPZ9cSFAyS4VDbe7A4PUZgMQ9Wp0rQS6agHwqpMfgMxvvB9otmc4DTHrlHl4/M
         oNvhx15NDacei8jDIfP7/qN6BwU6owh6GMJBAE5cP+r6LbEuEks5hO4JemkXa5R1bXEO
         QiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlPt4Q3q43f/kES2hajYBu0feYXRxIPRsViZnbHRgo8=;
        b=bOVxAyNEHWR4z5JdaeBSy6pe31DLH7jre5Fifb3bJi4ejLUiw3Wa183ncmJ9o3OhJ+
         ISA7sgBd9EmAxNgvufIqRhLJ45j31ODzo6fwXFfcbMZgs28L/ClHq59eFL9DY/d44Qjs
         G+2dm2RaqbCjvPKWZiZNPli1OOeFUOHgPVRysZ6Kep4H2frn5vt3Gi08AafXARz8G6bc
         p/Kb1l/1/2w0xAQEIztR7IzHBgzOmp0Ny222ZZDxtFcuW/N4D2FFtFzo38t7nGcDUaQ+
         wpw6Y8yWViXyF2PXdiQv7ujPW6Ul2pvYDfF0ogXA/nDv7zVUtx9q2NWxjVekcCEYfAz1
         UJCw==
X-Gm-Message-State: AO0yUKWV24jbhW+KuUfDtMFfkfPxq7u/ujuHHZA5r9CWp0aXq/GOaHjT
        l5VFKoBHe9G8r3wjLNaOs2xwqQ==
X-Google-Smtp-Source: AK7set8bcMpUzNCKsQ+jr5w1UWR23aN9ub4GLVSYhJodv/gdPO0QitNKBJ4ItzsHaFeUGdPOLJvusA==
X-Received: by 2002:a5d:6f01:0:b0:2bf:d937:3589 with SMTP id ay1-20020a5d6f01000000b002bfd9373589mr594169wrb.14.1677266249149;
        Fri, 24 Feb 2023 11:17:29 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:d12b:5d7b:42ef:d31a? ([2a02:6b6a:b566:0:d12b:5d7b:42ef:d31a])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b002c58ca558b6sm13612940wrl.88.2023.02.24.11.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 11:17:28 -0800 (PST)
Message-ID: <8dcac250-474a-6102-1a60-b8ad84eb0a4b@bytedance.com>
Date:   Fri, 24 Feb 2023 19:17:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v11 09/12] x86/smpboot: Remove
 initial_stack on 64-bit
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kim.phillips@amd.com" <kim.phillips@amd.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
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
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        "simon.evans@bytedance.com" <simon.evans@bytedance.com>,
        "liangma@liangbit.com" <liangma@liangbit.com>
References: <20230223191140.4155012-1-usama.arif@bytedance.com>
 <20230223191140.4155012-10-usama.arif@bytedance.com>
 <BYAPR21MB1688FEE6BA7464980CCF7A21D7A89@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2c3abf634824f2b7207a3ac94985863472d67608.camel@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <2c3abf634824f2b7207a3ac94985863472d67608.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 24/02/2023 18:28, David Woodhouse wrote:
> On Fri, 2023-02-24 at 18:24 +0000, Michael Kelley (LINUX) wrote:
>> I'm getting a compile error on the new reference to PTREGS_SIZE:
> 
> Is it just that <asm/asm-offsets.h> is included conditionally, and not
> in your build? What if you include it directly from <asm/processor.h>

This is fixed in the v2 patch that Brian sent.

diff --git a/arch/x86/include/asm/processor.h 
b/arch/x86/include/asm/processor.h
index 9c4a5c4d46c1..bdde7316e75b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -650,8 +650,8 @@ static inline void spin_lock_prefetch(const void *x)
  #else
  extern unsigned long __end_init_task[];

-#define INIT_THREAD {                                                  \
-       .sp     = (unsigned long)&__end_init_task - PTREGS_SIZE,        \
+#define INIT_THREAD { 
    \
+       .sp     = (unsigned long)&__end_init_task - sizeof(struct 
pt_regs), \
  }

  extern unsigned long KSTK_ESP(struct task_struct *task);
