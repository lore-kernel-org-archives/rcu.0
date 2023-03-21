Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B06C6FD1D
	for <rcu@archiver.kernel.org>; Tue, 21 Mar 2023 19:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCUTl3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCUTlZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Mar 2023 15:41:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27038EA1
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:40:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h17so14863687wrt.8
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679427634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zchVYrraM7s3AAvPCnvhbdIUl39F6C9hdQmcDKPK/Q=;
        b=eHO+13aro+Q5+CFqTFTEYO/acPnKq92VXA1rMDfgODABgcYcvJlqbN+8jzb4pIojMl
         h0PU/VR7YAe2ZQwP4QN/qgyAU7J+Xi2uc7QBgohOBHLHBldz3azXk/VpFYhLw123Q5bn
         GnXsxlWdyhWU3B17VU/HWn0JCgMsKwZrQZdGyhlAXhv7Kh/nNP3uypKJiqMScZcA9CsO
         9a3ui4pzLyihrUNZJtnk/Zqe/AG1q7ltAySlxJ9pj2EbnPvBMVc1/xZcJoLQS+JZgszj
         WDKNrA0fcXnf9/h1ptbinmMggQwBmEd1BoQ4y+n1ybW+34gRPi+TpAVIB/zy2yLZNpvm
         0MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zchVYrraM7s3AAvPCnvhbdIUl39F6C9hdQmcDKPK/Q=;
        b=lNLwA9scKO5V3RL/zs3TlYXlvjok5Xu4AUtw9vguPYIXww7ZQztAjVHGjGZnHxdu7T
         mmDpLlFO5WYDEXJkZ+pLxyD8oPQvvXjw92uq9RET+JgfsrctFvkJJwmor8sYcZBE0AOV
         HMFHo1kDc9C/0RR/la07y8LRnDSkpSv85lSijNzrrFK4C9NP4wapCRXBGL6GNI967Tt5
         Rf/Us++2OX+HS0iKHQUjNxEtj9Jln4raeWkfaugjqGoIQPn6G/eu20NfcuJ5Gx83G7RX
         Zj6T6DaYLZnt8fV/4jdkGcyICULHQlpgtX8/NXrtiebw4tBFv4dXWkLsF+ilR69urEhf
         qzIg==
X-Gm-Message-State: AO0yUKUR2Q+2GtC5J8NpMMww7JIIj+IvNyyco+vw7Lq3R7wawe+cIQKp
        8PJoMox42E0EUkakYF7BKalUgw==
X-Google-Smtp-Source: AK7set9JWBndoA6/LsUZnhg+S7mZ3EFpbG43ajzw6YNe+1yek1XVoxjdYeT6sHzfIxDgUfn9TjclWA==
X-Received: by 2002:adf:fe51:0:b0:2cf:e689:e60e with SMTP id m17-20020adffe51000000b002cfe689e60emr3233898wrs.59.1679427634215;
        Tue, 21 Mar 2023 12:40:34 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7a8a:d679:ba4e:61cf])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm12005026wrr.45.2023.03.21.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:40:33 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, kim.phillips@amd.com,
        brgerst@gmail.com
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        gpiccoli@igalia.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v16 0/8] Parallel CPU bringup for x86_64
Date:   Tue, 21 Mar 2023 19:40:00 +0000
Message-Id: <20230321194008.785922-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This version includes the following changes over v15:
- Roll back to CPUHP_OFFLINE on failure in parallel bringup case.
- Release trampoline_lock earlier, just before setup_gdt.
- Rebase to x86/apic, Linux 6.3-rc3 with no change in boot time
  improvement over v15.
  (This already has some of the commits from v15 merged).

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
v11: Added patches from Brian Gerst to remove the global variables initial_gs,
     initial_stack, and early_gdt_descr from the 64-bit boot code
     (https://lore.kernel.org/all/20230222221301.245890-1-brgerst@gmail.com/).
v12: Fixed compilation errors, acquire tr_lock for every stack setup in
     trampoline_64.S.
     Rearranged commits for a cleaner git history.
v13: Fix build error with CONFIG_FORCE_NR_CPUS.
     Commit message improved, typos fixed and extra comments added.
v14: Enable parallel bringup for SEV-ES guests.
v15: use vendor parallel_smp when platform has CC_ATTR_GUEST_STATE_ENCRYPT.
     Call smpboot_restore_warm_reset_vector incase any of the steps in
     native_cpu_up fail.
     Reset stale stack and kasan unpoison in bringup_cpu
     Release trampoline_lock a bit earlier.
v16: Roll back to CPUHP_OFFLINE on failure in parallel bringup case.
     Release trampoline_lock earlier, just before setup_gdt.
     Rebase to x86/apic (Linux 6.3-rc3).

 
David Woodhouse (8):
  cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
  cpu/hotplug: Reset task stack state in _cpu_up()
  cpu/hotplug: Add dynamic parallel bringup states before
    CPUHP_BRINGUP_CPU
  x86/smpboot: Split up native_cpu_up into separate phases and document
    them
  x86/smpboot: Support parallel startup of secondary CPUs
  x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
  x86/smpboot: Serialize topology updates for secondary bringup
  x86/smpboot: Allow parallel bringup for SEV-ES

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/coco/core.c                          |   5 +
 arch/x86/include/asm/coco.h                   |   1 +
 arch/x86/include/asm/cpu.h                    |   1 +
 arch/x86/include/asm/realmode.h               |   3 +
 arch/x86/include/asm/sev-common.h             |   3 +
 arch/x86/include/asm/smp.h                    |  13 +-
 arch/x86/include/asm/topology.h               |   2 -
 arch/x86/kernel/acpi/sleep.c                  |   9 +-
 arch/x86/kernel/apic/apic.c                   |   2 +-
 arch/x86/kernel/cpu/common.c                  |   6 +-
 arch/x86/kernel/cpu/topology.c                |   3 +-
 arch/x86/kernel/head_64.S                     |  97 +++++
 arch/x86/kernel/smpboot.c                     | 344 +++++++++++++-----
 arch/x86/realmode/init.c                      |   3 +
 arch/x86/realmode/rm/trampoline_64.S          |  27 +-
 arch/x86/xen/smp_pv.c                         |   4 +-
 include/linux/cpuhotplug.h                    |   2 +
 include/linux/smpboot.h                       |   7 +
 kernel/cpu.c                                  |  61 +++-
 kernel/smpboot.h                              |   2 -
 21 files changed, 481 insertions(+), 117 deletions(-)

-- 
2.25.1

