Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE3C636D7
	for <rcu@archiver.kernel.org>; Tue, 21 Feb 2023 22:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBUWft (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBUWfs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Feb 2023 17:35:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AD31E31
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 14:35:45 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t13so5927248wrv.13
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pnDOENvPZPPRofzLURGJ/LFWArubW2KTtPcq1+8yXM=;
        b=sDCk9nu65x1h7dJPs44M/BnuWEgFJzsXV00gTIoXx7meSbOXnQtDBY0wrsXO12wg3Y
         cKEZupe1ZGO3V9BslVKM+Bgl61OUvmQOHLf19eqV12aD+HW50hTUP1buTUteGozI/lMv
         ObxEO8WDKxjeH6ben9x+ZZ2QoarIIVaSJD4PnkVgCT5+gCjTsft0g5EcnTn6Kt8lIquW
         Ju24R6XkP2IH0KtBCHbjXRK+XOuMqjbilTM70qGcmZBTIZAwr58lvSTfcidsdtuLbbhb
         2HnuiQT973jntI+w3S4LKLhaDzEkaKwyF13oWIhdswPveKnmryUrR08oGBzMayQCR8k8
         pJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pnDOENvPZPPRofzLURGJ/LFWArubW2KTtPcq1+8yXM=;
        b=i0PvmLBRqlP0GJvzJKgxtfOvPW1ONHAc6vfEASyxI4r472od26wRWPNl2bxfmll3Hl
         gAzcx0z9vv2pM6+guDHoku6fvGsEmKmQcMDDOd3qiC3kDJOLIAW6o5EKZJMtGlYO7XRd
         IbBuoZJ1LfwFwuRjj4mBbuiaKnreZz51jfp9HzyERrQSwYEGhr8mYtnKdW6VyeLZ9WUR
         1PVB3siOF6ybJ2bY3Q8NaDHW6CHJdNrQ4+WnScWnKzDvCxEzOLdJIhOXhO0jDtF+9xgn
         EsxaUNpXVp0d8w12iAYRSBl41L+N+/KHRuV1cNLoDRq+UfPZ3b2ExRG71EKOYBqyWejs
         gXYg==
X-Gm-Message-State: AO0yUKXceNFj5jiFRzAdBrum4vRGLnom5vG41GbBAgrKFUpsbftCfIeC
        9c7acTmJLQHH/qrS+ybHMM+w6A==
X-Google-Smtp-Source: AK7set/xZTn72idcDDur5F/34x/QPvwKOGdJkPJ3dk6hC4tPAqrZqqfwvrS9g6p5iadzj5+FfPNsRg==
X-Received: by 2002:a5d:4f8b:0:b0:2c5:5881:be0f with SMTP id d11-20020a5d4f8b000000b002c55881be0fmr5751134wru.25.1677018944105;
        Tue, 21 Feb 2023 14:35:44 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:1a14:8be6:b3a9:a95e])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm4501254wrr.5.2023.02.21.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:35:43 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v10 0/8] Parallel CPU bringup for x86_64
Date:   Tue, 21 Feb 2023 22:33:44 +0000
Message-Id: <20230221223352.2288528-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This version fixes suspend/resume not working with parallel smpboot in v9
(reported by Oleksandr Natalenko) by saving smpboot_control properly in
x86_acpi_suspend_lowlevel.

The patches have also been rebased to v6.2 and retested and the improvement
in boot time is the same as v9.

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
v9: Drop patch to avoid repeated saves of MTRR at boot time.
    rebased and retested at v6.2-rc8.
    added kernel doc for no_parallel_bringup and made do_parallel_bringup
    __ro_after_init.
v10: Fixed suspend/resume not working with parallel smpboot.
     rebased and retested to 6.2.
     fixed checkpatch errors.


David Woodhouse (8):
  x86/apic/x2apic: Allow CPU cluster_mask to be populated in parallel
  cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
  cpu/hotplug: Add dynamic parallel bringup states before
    CPUHP_BRINGUP_CPU
  x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
  x86/smpboot: Split up native_cpu_up into separate phases and document
    them
  x86/smpboot: Support parallel startup of secondary CPUs
  x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
  x86/smpboot: Serialize topology updates for secondary bringup

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/asm/smp.h                    |  14 +-
 arch/x86/include/asm/topology.h               |   2 -
 arch/x86/kernel/acpi/sleep.c                  |   7 +
 arch/x86/kernel/apic/apic.c                   |   2 +-
 arch/x86/kernel/apic/x2apic_cluster.c         | 126 ++++---
 arch/x86/kernel/cpu/common.c                  |   6 +-
 arch/x86/kernel/head_64.S                     |  99 ++++-
 arch/x86/kernel/smpboot.c                     | 350 +++++++++++++-----
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  14 +
 arch/x86/xen/smp_pv.c                         |   4 +-
 include/linux/cpuhotplug.h                    |   2 +
 include/linux/smpboot.h                       |   7 +
 kernel/cpu.c                                  |  31 +-
 kernel/smpboot.c                              |   2 +-
 kernel/smpboot.h                              |   2 -
 18 files changed, 519 insertions(+), 158 deletions(-)

-- 
2.25.1

