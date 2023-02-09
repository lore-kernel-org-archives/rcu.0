Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B0C636D6
	for <rcu@archiver.kernel.org>; Thu,  9 Feb 2023 15:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBIPmH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjBIPmH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Feb 2023 10:42:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2955D3FD
        for <rcu@vger.kernel.org>; Thu,  9 Feb 2023 07:42:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z13so1733889wmp.2
        for <rcu@vger.kernel.org>; Thu, 09 Feb 2023 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1H+oj5V5646VG0XAJHE52zkrnEGPlSBUjUdWUsoSuD8=;
        b=Or4Anks+YFvw/FAYTj3d21i8QmL0GOfRwXiN+tkY424Imzs4nJSieM75WXAUnohmBo
         REXZrDA/iPFA2mmMkAAaJUVJzJjlXy8WzWoEHr+seFaS7fUHprNbrKOKrqqYEMNHW8Mg
         FUuHTkk+eoo8hz2GX2ZNXZ20rlXXr36BgAnl02qwGPVR74oV73euzetaaEPhoKWwnVIv
         QhBXva/t/ijvtjvXMhIUYvRZU6F61KIpFs1+PcwJpu4SxZp+pGtEK/rjXR3qSRuFYckj
         KtJdm/8Y0BI09vfQC+kJFkNqzlNHip45j1+iQaoasPHUnDB+6amzSxSHOUe81WU3DbDd
         Sw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H+oj5V5646VG0XAJHE52zkrnEGPlSBUjUdWUsoSuD8=;
        b=pyhWyQLDY9+DHRvvxjcwwE2XoDY9Sda3ZNPMgrbRp2nYAbnoqWYf6ZqBgLgAvcwLPa
         zzc+8xCaBpG0YLk+q5UTX+aOwNWvLg8B/bx9TRxW/tqrMbZ59oAO23rwDO/gvOIED8CO
         JE5oVHQ/PGj05kxottNxwAT/iPIqaUtdSy1bmowb1COHj4RUMvBpOMDLB1cieP361tTz
         9lI/PmCjX7/tT7bwRAGHPFWK9+7rN981CHUHd74yQMJ4gtT8tqXEp/YtWk46NIzFhthL
         peyWqCNCY2+eDuUfXiX2WUUyBf14IRDz40ehdaKinjPJnvmHj0v3t/G500fEcsclw4E8
         ghzA==
X-Gm-Message-State: AO0yUKUPtn+HdUwTmvoh1DQ/7a33FItj98L291RDVTalRw2YR5e+7QNn
        fVgAGRlANXPugKwL8NhWXLJn3w==
X-Google-Smtp-Source: AK7set9qEPZp4CbT4fNEm/oWUcSTi3jgBisX1UlrQibXjiSi4ZwdqQ2wgIRQgBMdjE+OMTmMscqvVw==
X-Received: by 2002:a05:600c:a292:b0:3df:eb5d:fbf with SMTP id hu18-20020a05600ca29200b003dfeb5d0fbfmr10369441wmb.38.1675957319835;
        Thu, 09 Feb 2023 07:41:59 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8009:2525:9580:8db2])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003df7b40f99fsm5099754wmq.11.2023.02.09.07.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:41:59 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v8 0/9] Parallel CPU bringup for x86_64
Date:   Thu,  9 Feb 2023 15:41:47 +0000
Message-Id: <20230209154156.266385-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The major change over v7 is fixing CPU0 hotplug not working as reported by
Paul E. McKenney using rcu torture tests. This is fixed by setting up the
initial_gs, initial_stack and early_gdt_descr properly for this case.

The improvement in boot time is the same as v7.

Thanks,
Usama

Changes across versions:
v2: Cut it back to just INIT/SIPI/SIPI in parallel for now, nothing more
v3: Clean up x2apic patch, add MTRR optimisation, lock topology update
    in preparation for more parallelisation.
v4: Fixes to the real mode parallelisation patch spotted by SeanC, to
    avoid scribbling on initial_gs in common_cpu_up(), and to allow all
    24 bits of the physical X2APIC ID to be used. That patch still needs
    a Signed-off-by from its original author, who once claimed not to
    remember writing it at all. But now we've fixed it, hopefully he'll
    admit it now :)
v5: rebase to v6.1 and remeasure performance, disable parallel bringup
    for AMD CPUs.
v6: rebase to v6.2-rc6, disabled parallel boot on amd as a cpu bug and
    reused timer calibration for secondary CPUs.
v7: [David Woodhouse] iterate over all possible CPUs to find any existing
    cluster mask in alloc_clustermask. (patch 1/9)
    Keep parallel AMD support enabled in AMD, using APIC ID in CPUID leaf
    0x0B (for x2APIC mode) or CPUID leaf 0x01 where 8 bits are sufficient.
    Included sanity checks for APIC id from 0x0B. (patch 6/9)
    Removed patch for reusing timer calibration for secondary CPUs.
    commit message and code improvements.
v8: Fix CPU0 hotplug by setting up the initial_gs, initial_stack and
    early_gdt_descr.
    Drop trampoline lock and bail if APIC ID not found in find_cpunr.
    Code comments improved and debug prints added.

David Woodhouse (9):
  x86/apic/x2apic: Allow CPU cluster_mask to be populated in parallel
  cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
  cpu/hotplug: Add dynamic parallel bringup states before
    CPUHP_BRINGUP_CPU
  x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
  x86/smpboot: Split up native_cpu_up into separate phases and document
    them
  x86/smpboot: Support parallel startup of secondary CPUs
  x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
  x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
  x86/smpboot: Serialize topology updates for secondary bringup

 arch/x86/include/asm/realmode.h       |   3 +
 arch/x86/include/asm/smp.h            |  14 +-
 arch/x86/include/asm/topology.h       |   2 -
 arch/x86/kernel/acpi/sleep.c          |   1 +
 arch/x86/kernel/apic/apic.c           |   2 +-
 arch/x86/kernel/apic/x2apic_cluster.c | 130 ++++++----
 arch/x86/kernel/cpu/common.c          |   6 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c       |   9 +
 arch/x86/kernel/head_64.S             |  99 +++++++-
 arch/x86/kernel/smpboot.c             | 350 +++++++++++++++++++-------
 arch/x86/realmode/init.c              |   3 +
 arch/x86/realmode/rm/trampoline_64.S  |  14 ++
 arch/x86/xen/smp_pv.c                 |   4 +-
 include/linux/cpuhotplug.h            |   2 +
 include/linux/smpboot.h               |   7 +
 kernel/cpu.c                          |  31 ++-
 kernel/smpboot.c                      |   2 +-
 kernel/smpboot.h                      |   2 -
 18 files changed, 521 insertions(+), 160 deletions(-)

-- 
2.25.1

