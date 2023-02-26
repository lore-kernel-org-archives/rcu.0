Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17AC7EE32
	for <rcu@archiver.kernel.org>; Sun, 26 Feb 2023 11:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBZLIl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Feb 2023 06:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBZLIi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Feb 2023 06:08:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E949EC4E
        for <rcu@vger.kernel.org>; Sun, 26 Feb 2023 03:08:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso618888wmq.1
        for <rcu@vger.kernel.org>; Sun, 26 Feb 2023 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rv4YBkExnEbzjmvRGSVdLlKzdSs1hoLH3+gZkX3hIJM=;
        b=DJ0qn754KoOY7lszedXqM0cvktd4MIlEDstLHXsvijRzw7VZtckVr4f+/5tRRSmKHU
         gdDRywi3/sCcc7cHk3Z1pMDmtOJBx42sx44E2WV0E5kwwaYFh0qPiytCfjob5b6Whm6M
         JoD/FuFOZZRjwBfN/BXF6UWeFn4h1MBx/LQRtZGy6q9qXLvTqOP1wlhSDMW34m8nEXIL
         5j4L2Hm+EO5Z2aUvxXx4NkNje0MQfjveISORHATz2z5n4bl/Cjjio/sv53EwV2Lz9yR4
         ZLxVoK7Ra+QQNJID4t6OiAb0CvXGuzbUjPqd8warO8sN+vc5QX5e09GyuhHyU4um/Lo4
         3BHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv4YBkExnEbzjmvRGSVdLlKzdSs1hoLH3+gZkX3hIJM=;
        b=voD0Rh/VxbV80p7ZEqQbv2I0Um+CLZPW62K5EFFI6b/IBAlFv2gnLN0p4PkDddH5G2
         dgdSWaH0j1SIbM2uYKXhFRg+qyif0hivWi90+xAMGlXhwSV5sF7dVw30bSelkP7lIgaB
         jmzzVfed7jKsUd0DTVbT0E/PKHtsFkRW3t0QWnzm8WA5fX0L3Ls+YBMshyXVZzBwcIa8
         u/B04wr5U3BkO1/4I9OJy/StZga5yETlZkSx8r36+FBv71WevKUL+SsV0+vxvj1eZwk7
         eDd1019ERY1ph/9VUY/3nXyQbiUg/NfiOjjG4SKGv98o7kSsveaelgaoQBBcRf7+s/3O
         y9JQ==
X-Gm-Message-State: AO0yUKXT05k5PTkKxeV6KtC5DWY9jhXCY+5TMNUBX94knr9egJEJ9kUr
        f+6oMoIfmeV9u48ugCnDW14E4Q==
X-Google-Smtp-Source: AK7set8mHGT2VnCThEqOMgIy/Fuquza1CoWNEJQk3uaHqxCiEMo9Z60UV7yiXPOSZC5v+cIlL4JZnw==
X-Received: by 2002:a05:600c:4da3:b0:3eb:2da4:f304 with SMTP id v35-20020a05600c4da300b003eb2da4f304mr5025546wmp.17.1677409693572;
        Sun, 26 Feb 2023 03:08:13 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:df7b:4668:3e23:d0c9])
        by smtp.gmail.com with ESMTPSA id v22-20020a1cf716000000b003e1fee8baacsm9157318wmh.25.2023.02.26.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 03:08:13 -0800 (PST)
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
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v12 10/11] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Sun, 26 Feb 2023 11:08:01 +0000
Message-Id: <20230226110802.103134-11-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226110802.103134-1-usama.arif@bytedance.com>
References: <20230226110802.103134-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

When the APs can find their own APIC ID without assistance, perform the
AP bringup in parallel.

Register a CPUHP_BP_PARALLEL_DYN stage "x86/cpu:kick" which just calls
do_boot_cpu() to deliver INIT/SIPI/SIPI to each AP in turn before the
normal native_cpu_up() does the rest of the hand-holding.

The APs will then take turns through the real mode code (which has its
own bitlock for exclusion) until they make it to their own stack, then
proceed through the first few lines of start_secondary() and execute
these parts in parallel:

 start_secondary()
    -> cr4_init()
    -> (some 32-bit only stuff so not in the parallel cases)
    -> cpu_init_secondary()
       -> cpu_init_exception_handling()
       -> cpu_init()
          -> wait_for_master_cpu()

At this point they wait for the BSP to set their bit in cpu_callout_mask
(from do_wait_cpu_initialized()), and release them to continue through
the rest of cpu_init() and beyond.

This reduces the time taken for bringup on my 28-thread Haswell system
from about 120ms to 80ms. On a socket 96-thread Skylake it takes the
bringup time from 500ms to 100ms.

There is more speedup to be had by doing the remaining parts in parallel
too — especially notify_cpu_starting() in which the AP takes itself
through all the stages from CPUHP_BRINGUP_CPU to CPUHP_ONLINE. But those
require careful auditing to ensure they are reentrant, before we can go
that far.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 19b9b89b7458..711573cd9b87 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/smpboot.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -1325,9 +1326,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int ret;
 
-	ret = do_cpu_up(cpu, tidle);
-	if (ret)
-		return ret;
+	/* If parallel AP bringup isn't enabled, perform the first steps now. */
+	if (!do_parallel_bringup) {
+		ret = do_cpu_up(cpu, tidle);
+		if (ret)
+			return ret;
+	}
 
 	ret = do_wait_cpu_initialized(cpu);
 	if (ret)
@@ -1349,6 +1353,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	return ret;
 }
 
+/* Bringup step one: Send INIT/SIPI to the target AP */
+static int native_cpu_kick(unsigned int cpu)
+{
+	return do_cpu_up(cpu, idle_thread_get(cpu));
+}
+
 /**
  * arch_disable_smp_support() - disables SMP support for x86 at runtime
  */
@@ -1566,6 +1576,11 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		smpboot_control = STARTUP_APICID_CPUID_01;
 	}
 
+	if (do_parallel_bringup) {
+		cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
+					  native_cpu_kick, NULL);
+	}
+
 	snp_set_wakeup_secondary_cpu();
 }
 
-- 
2.25.1

