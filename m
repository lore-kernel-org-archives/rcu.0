Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2165C05027
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 20:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBAUow (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBAUov (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 15:44:51 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CB77909C
        for <rcu@vger.kernel.org>; Wed,  1 Feb 2023 12:44:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so2428065wms.1
        for <rcu@vger.kernel.org>; Wed, 01 Feb 2023 12:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBkUStfA+iDGjKKAM+4p8+0mIlG33iS9Y15joN7auaU=;
        b=p8tndsXy9zB48jq6U4H/0wBOP0dK7C9M6YI8SpeKZhYJkxaHanw6+Ix1tUU231B/5k
         QSuqVj3WcIbAArBi3dVGZOsJDyxJwzhPUUnIIjBaEJ8rMjetZrs8qfNnBx7OHdB6r3SI
         FC8ehdA/NTaFV4Jm/4yQb6tH65UEYu5nNm26PTL0b+TL0RT3h1fE0yH6V3XqRXrC9myu
         +m7w9k8yH36blhlSClNqJZq1G3TG2auYToYac5s3EuQfM5OhNVoc2bjZVshe9VwvoRuX
         WUvJq8W8Uw84kVvU0dwsJa3q23Zy8nNz5nXE7Go6KIbBHTg7DGYgUKvu0kOqXgS7uIos
         ziYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBkUStfA+iDGjKKAM+4p8+0mIlG33iS9Y15joN7auaU=;
        b=5Ii/w5z/UgCIrc93MGoInj5ZPNjN1d2pnGlFFw6HWwQ3n0jXn1fbcB9ngUxkkA87/2
         yrv5fFlfC1kLJO2IoJ0joCxJOn/ZKekkMpPawxymk34KdE6KUYE7/tO70F+b8RND1ZgI
         OLJOQp4S59tzlWEWXPisWP98x1hlkNu9iBuAam+BQuYqtEfT9ryXQpuxMH1jSRes4/BU
         ml8hEOY3gUbLWyJ74BP8D6WofjHA6f3hDMsUWAThb1NTIUduaRSQ9EHDwl3cssS1FIf+
         WNhkbOynFAw4yXjIsPYDllUjnrnqUFQNtuwbMtlrK7HQ8IKZnP1pGMITTroHElChA1qs
         ucuw==
X-Gm-Message-State: AO0yUKXEjAqPZdzqO2i9SzcJkkMSwOtnnDbiYm3SAhafqvCwL34cNozm
        Lt35fDiaPp4djcAg3mW2A0OOEA==
X-Google-Smtp-Source: AK7set/wpf35la+9i2edsJCL7KpWtiHynmdfZv2wHgxuiVprFgfzOXT73CCMouPrU1yUSANu63rOsQ==
X-Received: by 2002:a05:600c:16c4:b0:3dc:16d2:ae5e with SMTP id l4-20020a05600c16c400b003dc16d2ae5emr3423164wmn.32.1675284286944;
        Wed, 01 Feb 2023 12:44:46 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:46 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH 0/9] Parallel CPU bringup for x86_64
Date:   Wed,  1 Feb 2023 20:43:29 +0000
Message-Id: <20230201204338.1337562-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patchseries is from the work done by David Woodhouse (v4: https://lore.kernel.org/all/20220201205328.123066-1-dwmw2@infradead.org/).
The parallel CPU bringup is disabled for all AMD CPUs in this version: (see discussions: https://lore.kernel.org/all/bc3f2b1332c4bb77558df8aa36493a55542fe5b9.camel@infradead.org/ and
https://lore.kernel.org/all/3b6ac86fdc800cac5806433daf14a9095be101e9.camel@infradead.org/).

Doing INIT/SIPI/SIPI in parallel brings down the time for smpboot from ~700ms
to 100ms (85% improvement) on a server with 128 CPUs split across 2 NUMA
nodes.

Adding another cpuhp state for do_wait_cpu_initialized to make sure cpu_init
is reached in parallel as proposed by David in v1 will bring it down further
to ~30ms. Making this change would be dependent on this patchseries, so they
could be explored if this gets merged.

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

David Woodhouse (8):
  x86/apic/x2apic: Fix parallel handling of cluster_mask
  cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
  cpu/hotplug: Add dynamic parallel bringup states before
    CPUHP_BRINGUP_CPU
  x86/smpboot: Reference count on smpboot_setup_warm_reset_vector()
  x86/smpboot: Split up native_cpu_up into separate phases and document
    them
  x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
  x86/mtrr: Avoid repeated save of MTRRs on boot-time CPU bringup
  x86/smpboot: Serialize topology updates for secondary bringup

Thomas Gleixner (1):
  x86/smpboot: Support parallel startup of secondary CPUs

 arch/x86/include/asm/realmode.h       |   3 +
 arch/x86/include/asm/smp.h            |  13 +-
 arch/x86/include/asm/topology.h       |   2 -
 arch/x86/kernel/acpi/sleep.c          |   1 +
 arch/x86/kernel/apic/apic.c           |   2 +-
 arch/x86/kernel/apic/x2apic_cluster.c | 108 +++++----
 arch/x86/kernel/cpu/common.c          |   6 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c       |   9 +
 arch/x86/kernel/head_64.S             |  73 ++++++
 arch/x86/kernel/smpboot.c             | 324 ++++++++++++++++++--------
 arch/x86/realmode/init.c              |   3 +
 arch/x86/realmode/rm/trampoline_64.S  |  14 ++
 arch/x86/xen/smp_pv.c                 |   4 +-
 include/linux/cpuhotplug.h            |   2 +
 include/linux/smpboot.h               |   7 +
 kernel/cpu.c                          |  27 ++-
 kernel/smpboot.c                      |   2 +-
 kernel/smpboot.h                      |   2 -
 18 files changed, 443 insertions(+), 159 deletions(-)

-- 
2.25.1

