Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED984C636D6
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 19:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjBWTNi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjBWTNO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 14:13:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAEA55C30
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:12:22 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p8so11689235wrt.12
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 11:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cOxOkpCD+vr2n7vBER3mbkwWwlvY2KHB3oBnHbXr/U=;
        b=ErntIUgAGEyRKXt4RMT66Pr0KsOFVw3vBflYFgfNggAyszQJLjPK+0lmvNVh2KXY7g
         wLgsBRVHOmbmRWbenYGMIxstY0+viUEq09wJYgsdb0oa72GZHZyRNICptybAqmyCeY/4
         JSfHCnSohGbanQEtvvBqQOiPK3IGTQsbhuRvCIkXAtcI/l1zNfcYBX53buZ7xaGJm9Si
         tIx8lFSAKy+fGR9TzyT8jccKHgDF22drQHBcbFUumT4w4Cm+cupSv8AmEqAky0qy3J34
         Dsakgq/7oGhgzOOA/T+PDYwDyEqdsiF1RVugLC3zmLNw4vIThARfDuXru7zf/cuVHvwj
         jtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cOxOkpCD+vr2n7vBER3mbkwWwlvY2KHB3oBnHbXr/U=;
        b=pUqTH+YAx1HyUmTNA00QUlL0xhp9gnI0hAIMrX68AWt8hii0K4izetOiwWkv4kKjZi
         Pb5xwT4ikH95ExxCB7a/4aEto66v4s8TfTtUwnD9DV5NguUHCmO1jKoKVSLMhbG9+T8X
         jaHiBdr+uOiWUJB5trZbSExi4ZNBl/XdiesdcVfPXV+bvsH9FBFHxrDTHgUQWLa17ZGC
         XxAMVnVnV8MuBGJIb6et8xy7y19UYYpbrFxakfWIizKRYeqFnttWn895ydvbQ6KIqnBx
         byDs2NKp4Nu/XyoQQlAD26bMCH1PBoVg8okBMBt+bZc28EgG1UHcg9Wz9Mtdyzf11Yeg
         40og==
X-Gm-Message-State: AO0yUKXoyQrIHPuh/Xe08vk5ZVdaIPcj90iWcgjv1HZ22XFynVDuYpFs
        JYzZ74ApIgr+2sliZyPlCz/kDg==
X-Google-Smtp-Source: AK7set+dbHx4azJ+uDT3nkXu+TSQadSyr2qdot7zwaRJcS8pl5LZjAZsdxZtDowpkUSbv7n0SuNgfA==
X-Received: by 2002:adf:ea11:0:b0:2c7:a39:7453 with SMTP id q17-20020adfea11000000b002c70a397453mr6424268wrm.54.1677179509837;
        Thu, 23 Feb 2023 11:11:49 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:5ee0:5af0:64bd:6198])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b002c561805a4csm12957286wrt.45.2023.02.23.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:11:49 -0800 (PST)
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
Subject: [PATCH v11 07/12] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Thu, 23 Feb 2023 19:11:35 +0000
Message-Id: <20230223191140.4155012-8-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223191140.4155012-1-usama.arif@bytedance.com>
References: <20230223191140.4155012-1-usama.arif@bytedance.com>
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
index 74c76c78f7d2..85ce6a8978ff 100644
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
 		smpboot_control = STARTUP_SECONDARY | STARTUP_APICID_CPUID_01;
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

