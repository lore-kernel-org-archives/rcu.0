Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B5C742A7
	for <rcu@archiver.kernel.org>; Wed,  8 Mar 2023 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCHRPe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCHROn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Mar 2023 12:14:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9715AB4B
        for <rcu@vger.kernel.org>; Wed,  8 Mar 2023 09:13:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso1593604wmp.4
        for <rcu@vger.kernel.org>; Wed, 08 Mar 2023 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678295620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xliC/QW0s7RArlzmkx8GnUp7Z2eARAfl+2c0/J0Jt7A=;
        b=Z5P4sfwpHtduCG6PqcwOnJuimrxgk7olj+omNsa+6tZycr8OzEmhAKQjOuIo0kzsV3
         bDnarN/XTPTHVBVumd4drJTOXxX7/5I4+eJO+H0OxVwl4aG0DDw77gdCzWt84cDTLNmf
         ky9sBNRpSmo+xsm0SZJz7CZFtb0lhxg6Ab8AWvczRS7BIRqNPT2f5ueS2YfNd3DT9sl/
         8xguoThyWoUOet0CmOHIGJYeLXG1Gzwd/YEP0fE7n5zvHFKsPzqE8LtzabkfRdPrvtIa
         uMrgeT0bjcFTnJHDrxyBLiDhM4/tpNW5W0KsTXZ992UD7Ba/seJAczKBkn0usf1nM8vE
         uEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xliC/QW0s7RArlzmkx8GnUp7Z2eARAfl+2c0/J0Jt7A=;
        b=NdGcBwDpKIP5a7160PRj7Oh1WdpjR4PTimZ4jqHg28jb/jHX5zCBN6KDYMJWFFve1z
         3mm+GS3KyW/SF1rHvX2pKXYzYRTnlp5IfZR9OYTwSnMG+i9iguCJbSNZtMuemJs89Rey
         lRTGLOQtShc4W2MSqd4IGcbVyRSx7YKgdnKTV9W1crGoL5WWvM650To3FocQ8G2ADDRu
         cNgFfoYznWEZLcOz/I0w+iFbStfTi0f43p1leBp+pBLRCQwUL3hPWHoh1xvwZyH+/ppo
         ZC5+HIvQtJjbB5872xN+W/C4bxBgxj/A1b5sMmZgzNEEas4q9ZqwxRK/xNy+MB0T7NRZ
         hmYg==
X-Gm-Message-State: AO0yUKWzNjFx6t2XZd43tQp9pXn9BxqPU1q4cKhJjwJ8xR7j6LlZ3RBl
        OejgOgGUB2809GdOG5ltw27dWw==
X-Google-Smtp-Source: AK7set+hgxF1GrRY78zxerTO9L4+5AXzY50JRuLBliOoXtcJh8ib3MfW9KSNJ6hQ6c1zbdtAC2pm8g==
X-Received: by 2002:a05:600c:5126:b0:3ea:f6c4:3060 with SMTP id o38-20020a05600c512600b003eaf6c43060mr16767761wms.18.1678295620399;
        Wed, 08 Mar 2023 09:13:40 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:fe40:3ba4:afe4:4609])
        by smtp.gmail.com with ESMTPSA id l15-20020a1c790f000000b003e0238d9101sm11668wme.31.2023.03.08.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:13:40 -0800 (PST)
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
        Usama Arif <usama.arif@bytedance.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v14 10/12] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Wed,  8 Mar 2023 17:13:26 +0000
Message-Id: <20230308171328.1562857-11-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308171328.1562857-1-usama.arif@bytedance.com>
References: <20230308171328.1562857-1-usama.arif@bytedance.com>
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
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 arch/x86/kernel/smpboot.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fd4e678b6588..a3572b2ebfd3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/smpboot.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -992,7 +993,8 @@ static void announce_cpu(int cpu, int apicid)
 		node_width = num_digits(num_possible_nodes()) + 1; /* + '#' */
 
 	if (cpu == 1)
-		printk(KERN_INFO "x86: Booting SMP configuration:\n");
+		printk(KERN_INFO "x86: Booting SMP configuration in %s:\n",
+		       do_parallel_bringup ? "parallel" : "series");
 
 	if (system_state < SYSTEM_RUNNING) {
 		if (node != current_node) {
@@ -1325,9 +1327,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1349,6 +1354,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1517,6 +1528,8 @@ static bool prepare_parallel_bringup(void)
 		smpboot_control = STARTUP_APICID_CPUID_01;
 	}
 
+	cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
+				  native_cpu_kick, NULL);
 	return true;
 }
 
-- 
2.25.1

