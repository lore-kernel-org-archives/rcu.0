Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB8C6379F
	for <rcu@archiver.kernel.org>; Tue, 21 Feb 2023 22:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBUWgV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjBUWgO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Feb 2023 17:36:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3532E66
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 14:35:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bo30so5437989wrb.0
        for <rcu@vger.kernel.org>; Tue, 21 Feb 2023 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NT0Eusw18gI70sCCLpWRO1h/3KoOWH0Kl/jfZNvB0/o=;
        b=owPCV4w3lTZs8563Ro8jzNqVAHV29fDptPQ9cq7ZQwDUurVoCmzz+Yv57SWEeM/qA5
         H7jvrPh2gMiLGxaNzU8g4inNNHpVQRBDJncFtn8BtYQfIVfPwnpRYCFBgYrGk5EEZlKh
         IEYfQXy2WpBc375AEN7UxIWlcFvxtn5qsefgQyEHPQQlNbOvFtn8VDVqWBRLoYBFsIsN
         phmM7LHYam2Ms9u4Kg5hNdqjcW93lJ3bXkgl08/c/5+6plIvMKXP5Tiy4iXksVia6vva
         fPOdTTd382aSKKePa/BhbskkSDRe3JkjD/5YujhUrWIg8A+Qksyg7/7jDuaiExQcppbP
         vwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NT0Eusw18gI70sCCLpWRO1h/3KoOWH0Kl/jfZNvB0/o=;
        b=UY0BO7AT30QzMF0oZZQrFXXIKEbWocqwbPCFcvor6XtVYMJuJhKa/HmMDCR5tnMY9x
         BRjoCXAbZVSaVN5FvHbuoA738ckfMkvgy8fBQfw56aP8Dj/bQvykP3TemnGG2eCKhdBd
         kpVdJwZJqZ38jVepiRDqH0M5WF0PH0DUyDD3pBpJkOKJ7ubND0/mHvpJGi6Y+2TKxAaJ
         T9rkQgRUw5weoddhoGAbf4wrWI+yUH+qP7WC0CUkodN5IcZYjKW113ReiDbnPm5fyxVV
         YdEQJl+7mcol21C48k2fb/mUtbZusmP5ftDYJ72xe5zm3r4X8+jdCvY6yOu8lBdI5nZk
         3elg==
X-Gm-Message-State: AO0yUKUQzuXI0LBNZF7onD/4fxgQS41XIAtOzx9lRUNvhYOktn1wujSb
        gULwmYrk5+rqeAxpl4Qsl6lsuQ==
X-Google-Smtp-Source: AK7set+QYZOoObU5r9Lv1ztUjqQnBL32311UcNp7RFdUUeqIUqp51mQ4bB4EECCUqF0zBzlSzRoWLQ==
X-Received: by 2002:a05:6000:11cd:b0:2c5:594b:10d1 with SMTP id i13-20020a05600011cd00b002c5594b10d1mr6269275wrx.23.1677018949655;
        Tue, 21 Feb 2023 14:35:49 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:1a14:8be6:b3a9:a95e])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm4501254wrr.5.2023.02.21.14.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 14:35:49 -0800 (PST)
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
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v10 7/8] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Tue, 21 Feb 2023 22:33:51 +0000
Message-Id: <20230221223352.2288528-8-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221223352.2288528-1-usama.arif@bytedance.com>
References: <20230221223352.2288528-1-usama.arif@bytedance.com>
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
index 6924d91b69ca..a8f52e03d55d 100644
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

