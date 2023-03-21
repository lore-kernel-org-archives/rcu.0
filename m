Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E5EC76195
	for <rcu@archiver.kernel.org>; Tue, 21 Mar 2023 19:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCUTll (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Mar 2023 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCUTlg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Mar 2023 15:41:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4C532B9
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:41:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l27so6563368wrb.2
        for <rcu@vger.kernel.org>; Tue, 21 Mar 2023 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679427640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=713eNkzIsW4JnC6r4Qq0A/MbdlkjMzmV9oMocjSXM2A=;
        b=GFvc9lFJiKr6fg+/7WOD6Eg3fbx6ow2SRG8rgbJntZLZLX+FtpF8NJOlDIwAvuRAj2
         l/b8hvQlrsWeIAQuX6rFqT//lsZwWhQhM5clGIwcmO6+zDArNTA8TyQTGvT9ipKqeaiV
         Amv9m971asKm1ZZX+HYMV67R5qaSo7mHxYObjaASdmSoATbWAqcRfru9Rpswjn9oBAAd
         y6K67ADIOEUNJmUsnkLfX4CTq5BF+xJbwo7012Xq/3IosVQMV2ksBi+2de42En5A/mTb
         mnSMXqt6oFclJ/9XZHTe4upXc+exRMxyMUfLsOfCMmwTiLFonGkJ9pqNrSUCrAJ/vspj
         mVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=713eNkzIsW4JnC6r4Qq0A/MbdlkjMzmV9oMocjSXM2A=;
        b=vS13t3OnehLOiYQiNRIzWzhUoIgEnLpRSMCQB6QDQbQuad4FR4su6qNDtwWgd3HHHP
         zKHDblLjSBXOfiCzZQzIAOetSc70+2jN4lkV+uCuG0TCqHiL6/bQiY2eYflo92L/tBwt
         KcJtG2tOxVhvxesMUmZBLxPRgFleByIlYHX5XRU/iq2ZmwVvQ0IKvDoTbN0eQxc1DS3+
         nHr4pPC7fEq3GQGo+Ik8ZX7RICqsmXsP0jki/N5shHSAft2HuFGYtaeIZbZH09icpn0j
         kI1fKFwqL/kHT1hMNuCvVXpSkbkpsLKYkYNJxjO3l2cls/bELMDYzkiuj2qp9F7u1o+E
         wNfg==
X-Gm-Message-State: AO0yUKWoU8z+VmwBSpRG1vgVVhjUmnTqem8qzrbILnzlAEmyPkZWe5f6
        rMweHTnHivMrisYEeEyGfXV0xg==
X-Google-Smtp-Source: AK7set9LUYINHOVQlprQf1UrCVlPqjyryKuSv5Y3sOHIczk0cybf+bhkznA7BNznNJXnXzVn/YZsCw==
X-Received: by 2002:a5d:66c7:0:b0:2c7:1e43:e578 with SMTP id k7-20020a5d66c7000000b002c71e43e578mr3202990wrw.41.1679427640021;
        Tue, 21 Mar 2023 12:40:40 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7a8a:d679:ba4e:61cf])
        by smtp.gmail.com with ESMTPSA id a3-20020adffb83000000b002c561805a4csm12005026wrr.45.2023.03.21.12.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:40:39 -0700 (PDT)
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
        gpiccoli@igalia.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v16 6/8] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Tue, 21 Mar 2023 19:40:06 +0000
Message-Id: <20230321194008.785922-7-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321194008.785922-1-usama.arif@bytedance.com>
References: <20230321194008.785922-1-usama.arif@bytedance.com>
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
index 8f7f36721ea8..bb818e6d8701 100644
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
-		goto out;
+	/* If parallel AP bringup isn't enabled, perform the first steps now. */
+	if (!do_parallel_bringup) {
+		ret = do_cpu_up(cpu, tidle);
+		if (ret)
+			goto out;
+	}
 
 	ret = do_wait_cpu_initialized(cpu);
 	if (ret)
@@ -1347,6 +1352,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1515,6 +1526,8 @@ static bool prepare_parallel_bringup(void)
 		smpboot_control = STARTUP_APICID_CPUID_01;
 	}
 
+	cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
+				  native_cpu_kick, NULL);
 	return true;
 }
 
-- 
2.25.1

