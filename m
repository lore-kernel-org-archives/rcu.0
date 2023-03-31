Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498B9C76196
	for <rcu@archiver.kernel.org>; Fri, 31 Mar 2023 11:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjCaLkw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 31 Mar 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjCaLkp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 31 Mar 2023 07:40:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF01EA18
        for <rcu@vger.kernel.org>; Fri, 31 Mar 2023 04:40:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l37so12702817wms.2
        for <rcu@vger.kernel.org>; Fri, 31 Mar 2023 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680262840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4BMda4uP/trXOPVFbxA+44piSZybxeHCQYh1voebKMY=;
        b=KrfJ+JLUhiklGuQ0qODImm/axxyEiVkecB4sK8IKbUhsoUeJMyhW/jzDbm/eFnTSDn
         qHWkSqXGrFpua1u7aLcPeMLLjsAOkSZhERpQ1lZzDCIvUPo5h3MxQrUGHTCgjFCvzLgL
         ymlxxrZvMM11Y6Lr/Vzo+VLUY1C9L3P/Ms6q5duVI9o+tGZjU7NrDSp5O8rC387qiYfY
         885BRfMAk/DgNlOejW5WZuJW0QHM6/dKPQLTowFCPxBi67uSQxcb8VBaLYJPiC3iHZqs
         /3HycxrKcjZmgm+IKlOotX+L7+zEZ5+sJZ6sak8RJsw6LBJA7fKec+dmTVEWi0wzSuB8
         GpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680262840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BMda4uP/trXOPVFbxA+44piSZybxeHCQYh1voebKMY=;
        b=M7frd8c1xKTasNVgF2W+qmQ3bLRbBGEeiNrQXp/NordWfMrNmpP5QuIqwjH8nGIPCV
         0YF22JfSbXrQuBUJxkDiY/bKO4TN1x8Cul1bRS3X/pStOkzAcQDFe19xpdzl49Cb3eY+
         93MD4gZ58CbiFKMJtSW3a1Iv0CtqFNRCcqoy+LEWcrj8A2j2hJFg8lO0kFX7M41jH2B+
         Jo0CNp2krU1C117chsZ1KPy/qPOCB+WhDxrJNJFI3JqEbG4ycoP1NRQhTzCvwnYrv+9/
         PWi/Iv/Xa1wVQMv2yO3CxGkfVTopX+bJPK4t8oBzLCvwYGuzSEJ2uQsveOfwnHcvzBDJ
         3lJg==
X-Gm-Message-State: AAQBX9fycGcyds/AaGWtbasIEqX0ANgJMN9SAL41TT58LafFKiZl840g
        OBlcXHQnPnDO3wHqfkOz4qXGRw==
X-Google-Smtp-Source: AKy350akXFV8HM8s/Ha6Lz3ESFXQ5hdrtXgaWbnYOF6NFoTV9iTpZm5oM2jthlq8wOd0t4RVLzWtXA==
X-Received: by 2002:a7b:c852:0:b0:3ef:64b4:b081 with SMTP id c18-20020a7bc852000000b003ef64b4b081mr16262072wml.39.1680262839961;
        Fri, 31 Mar 2023 04:40:39 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b566:0:668d:6a39:bcbb:5910? ([2a02:6b6a:b566:0:668d:6a39:bcbb:5910])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003edff838723sm2451209wml.3.2023.03.31.04.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 04:40:39 -0700 (PDT)
Message-ID: <144fbadc-8d27-796b-0263-ff2662b283ae@bytedance.com>
Date:   Fri, 31 Mar 2023 12:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v17 6/8] x86/smpboot: Send INIT/SIPI/SIPI
 to secondary CPUs in parallel
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, dwmw2@infradead.org,
        kim.phillips@amd.com, brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>
References: <20230328195758.1049469-1-usama.arif@bytedance.com>
 <20230328195758.1049469-7-usama.arif@bytedance.com> <87v8iirxun.ffs@tglx>
 <CAFC43E6-97E9-4E89-AABB-78E31037048A@alien8.de> <87sfdmrtnj.ffs@tglx>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <87sfdmrtnj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 30/03/2023 19:17, Thomas Gleixner wrote:
> On Thu, Mar 30 2023 at 19:05, Borislav Petkov wrote:
> 
>> On March 30, 2023 6:46:24 PM GMT+02:00, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> So that violates the rules of microcode loading that the sibling must be
>>> in a state where it does not execute anything which might be affected by
>>> the microcode update. The fragile startup code does not really qualify
>>> as such a state :)
>>
>> Yeah I don't think we ever enforced this for early loading.
> 
> We don't have to so far. CPU bringup is fully serialized so when the
> first sibling comes up the other one is still in wait for SIPI lala
> land. When the second comes up it will see that the microcode is already
> up to date.
> 

A simple solution is to serialize load_ucode_ap by acquiring a spinlock 
at the start of ucode_cpu_init and releasing it at its end.

I guess if we had topology_sibling_cpumask initialized at this point we 
could have a spinlock per core (not thread) and parallelize it, but 
thats set much later in smp_callin.

I can include the below in next version if it makes sense?

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80a688295ffa..b5e64628a975 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2155,10 +2155,13 @@ static inline void setup_getcpu(int cpu)
  }

  #ifdef CONFIG_X86_64
+static DEFINE_SPINLOCK(ucode_cpu_spinlock);
  static inline void ucode_cpu_init(int cpu)
  {
+       spin_lock(&ucode_cpu_spinlock);
         if (cpu)
                 load_ucode_ap();
+       spin_unlock(&ucode_cpu_spinlock);
  }

