Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC071C636CC
	for <rcu@archiver.kernel.org>; Tue,  7 Feb 2023 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjBGXFE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Feb 2023 18:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBGXFC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Feb 2023 18:05:02 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DAB3FF2B
        for <rcu@vger.kernel.org>; Tue,  7 Feb 2023 15:04:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so221701wms.0
        for <rcu@vger.kernel.org>; Tue, 07 Feb 2023 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWyZfvHfRMCW/IU8Kqgu9e5Q/3q0z6e4L7Wtj650hu8=;
        b=sj91hFEtXyPTrl/TkrAJ1B+e/sbdEY/hOTom3rh+R8665fhyF94f79s6gfupGiNZsH
         P1egkAuKBB9SRp/ujvqE4l6LiJfSO4hGFVhcRJFXcoEAAb0tpUFkvhTD6njHhTPPMdF0
         am+8Hcm44U9UAql8zZB+dO12E4IFLt+/CP1sh/TGO6W4VhVFeQszvx9qiLNqzpNCYAIJ
         cIVNCCojklaeWTPO9LloT9pW4B7SRgI1TgXiSzNwqCJKVnFacs+tA/f1cNhyKkt2aUJq
         dwhDjuWVQj0F2iGMl12PzM5tD0If6DuRXB4tC5AdkZbwghBoD77409US86SpJ62MJRMj
         dWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWyZfvHfRMCW/IU8Kqgu9e5Q/3q0z6e4L7Wtj650hu8=;
        b=CeUbeenAB8R5LI9CetzNvq47q+/H6qY7hQyDt1yHSQDGMQ8AKuUASVpOOueNXc3Nm4
         a6KbRUJ24XGEUu8pKovu64qlsfwXTeaMJjhNBuop3RVE0ZBH+DCIZYzaCKr1xmdzruTx
         b3+Ox4sshmGrpFcT3NtDCC0lHXkKYnUvbq052806OV1kq19UdKjxsm4S9rfPiQNA6bt5
         hVHrSNT/td7EVC3n3NSFWHh9O5xMd80+YijosQbjfzxK4WA0o9Ih46wBvhfhhW+9ncTb
         Nx+Z91Xpkt5JTGvyUCncOPocfO+k+GmotO4smBCc6tQ7V0ljMSZoTTttJJP3biOMWoWO
         oI7w==
X-Gm-Message-State: AO0yUKX8Eyti6SHC5DJJlbxTLt7WN+YmZZiovYgg0j/LAVXH6dOQrVyn
        OarJ2w2x7xNto++iyWqNNSLEzw==
X-Google-Smtp-Source: AK7set9woofUemvQZeOvO20OKJwvXI3Tq5eK0Srxc1yC75Rjd+PG2VHz5JwhPzDkZZt4tyHu1Ae1Gw==
X-Received: by 2002:a05:600c:4ecb:b0:3df:9858:c02c with SMTP id g11-20020a05600c4ecb00b003df9858c02cmr533084wmq.1.1675811086915;
        Tue, 07 Feb 2023 15:04:46 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:c04f:2463:c151:8b87])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003dcc82ce53fsm146485wmq.38.2023.02.07.15.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:04:46 -0800 (PST)
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
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v7 7/9] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Tue,  7 Feb 2023 23:04:34 +0000
Message-Id: <20230207230436.2690891-8-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207230436.2690891-1-usama.arif@bytedance.com>
References: <20230207230436.2690891-1-usama.arif@bytedance.com>
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

[Usama Arif: fixed rebase conflict]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/smpboot.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7abdf347493f..7e7bcab6676e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/smpboot.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -1326,9 +1327,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1350,6 +1354,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1565,6 +1575,11 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
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

