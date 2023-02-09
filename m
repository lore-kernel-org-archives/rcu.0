Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BEAC636D6
	for <rcu@archiver.kernel.org>; Thu,  9 Feb 2023 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjBIPmS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjBIPmR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Feb 2023 10:42:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59764649
        for <rcu@vger.kernel.org>; Thu,  9 Feb 2023 07:42:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso4198658wms.0
        for <rcu@vger.kernel.org>; Thu, 09 Feb 2023 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70igdMRKSd94d/Z6B4nTp+zZijhDvqltjmxokObwWsg=;
        b=dn1U2yeryf8Id2WciGCIbisN8nc8WVUoW0x3x8T/HHApprnvNYSu7W0t42yiRyI1EW
         tp4fm9lutmSq+T55vwPUQk9B1UWlt4JHjjj1ZpLOTBTm4Bwl3JgzqyeiXhCFoKhTZ0pv
         j8vYiuw5GU/Bo4feROs7BDR5+3ZAAM31B6HFB2GykseOkKIv43GV7i+/c0aymfLxceh2
         uJ2+gaLSwo/H4pdqj3hmuzVkxaXGXyHtX2NKOn4fP4y7OdW0eFNQKlG7FwaovozSICQG
         os8vCROIiBjMrcNpi02K1uyiVxh0qmjrpvjg6UEu5zh/HaGle0XdJPvxykOiSRHgChfB
         ezmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70igdMRKSd94d/Z6B4nTp+zZijhDvqltjmxokObwWsg=;
        b=sV6Lfd+ItufuuSoxtRfSsZ31U7sum7zi3rD+EdRNrBIJaM6znSyM5Ir8OYrcd/Enxe
         IzH4BkcZ9LLfjiNNICpA/HrRBfbVioKguf0GRI3ItLWuDznRpaoN57J+INF1EdHAMlB3
         QxG/ejzXH3igjgrEDGK5nteuKEbx4++Msdr9AsALNuU7EOsGyX8DjnmDUrjSTRcKhqbw
         9t1DtrRpuLGkvBhcKWCw4f75/ioRo6k5DM5oM+2BPw81RkN4IRsmJB9obLd76lLMnO3t
         QP034tj6/z1YcktL0l1L2BUv6d04/V9/yB6R8Y0PEt4MVkDi/k0PdWEAzTwL2aQoPWUL
         2ldA==
X-Gm-Message-State: AO0yUKXpVWnwsvii7Ig7zCwecc0BDgWv86SJpRBag5cOAmMrI2FHu5bT
        DaBVes1S3ozxEDoUGRqiw0IIQA==
X-Google-Smtp-Source: AK7set+0X34TzpaVv6Bom5vLgzMJaqdLE+LB5Qtei0wdACr+o3J6xmJtV+nEgzp905Nvz4trsR+CCQ==
X-Received: by 2002:a05:600c:3417:b0:3dc:5b79:2dbb with SMTP id y23-20020a05600c341700b003dc5b792dbbmr10392632wmp.25.1675957324606;
        Thu, 09 Feb 2023 07:42:04 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:8009:2525:9580:8db2])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600c364600b003df7b40f99fsm5099754wmq.11.2023.02.09.07.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:42:04 -0800 (PST)
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
Subject: [PATCH v8 5/9] x86/smpboot: Split up native_cpu_up into separate phases and document them
Date:   Thu,  9 Feb 2023 15:41:52 +0000
Message-Id: <20230209154156.266385-6-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209154156.266385-1-usama.arif@bytedance.com>
References: <20230209154156.266385-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

There are four logical parts to what native_cpu_up() does on the BSP (or
on the controlling CPU for a later hotplug):

 1) Wake the AP by sending the INIT/SIPI/SIPI sequence.

 2) Wait for the AP to make it as far as wait_for_master_cpu() which
    sets that CPU's bit in cpu_initialized_mask, then sets the bit in
    cpu_callout_mask to let the AP proceed through cpu_init().

 3) Wait for the AP to finish cpu_init() and get as far as the
    smp_callin() call, which sets that CPU's bit in cpu_callin_mask.

 4) Perform the TSC synchronization and wait for the AP to actually
    mark itself online in cpu_online_mask.

In preparation to allow these phases to operate in parallel on multiple
APs, split them out into separate functions and document the interactions
a little more clearly in both the BSP and AP code paths.

No functional change intended.

[Usama Arif: fixed rebase conflict]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 arch/x86/kernel/smpboot.c | 181 ++++++++++++++++++++++++++------------
 1 file changed, 127 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3a793772a2aa..b9366f86c433 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -204,6 +204,10 @@ static void smp_callin(void)
 
 	wmb();
 
+	/*
+	 * This runs the AP through all the cpuhp states to its target
+	 * state (CPUHP_ONLINE in the case of serial bringup).
+	 */
 	notify_cpu_starting(cpuid);
 
 	/*
@@ -231,17 +235,32 @@ static void notrace start_secondary(void *unused)
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
 #endif
+	/*
+	 * Sync point with do_wait_cpu_initialized(). Before proceeding through
+	 * cpu_init(), the AP will call wait_for_master_cpu() which sets its
+	 * own bit in cpu_initialized_mask and then waits for the BSP to set
+	 * its bit bit in cpu_callout_mask to release it.
+	 */
 	cpu_init_secondary();
 	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
+
+	/*
+	 * Sync point with do_wait_cpu_callin(). The AP doesn't wait here
+	 * but just sets the bit to let the controlling CPU (BSP) know that
+	 * it's got this far.
+	 */
 	smp_callin();
 
 	enable_start_cpu0 = 0;
 
 	/* otherwise gcc will move up smp_processor_id before the cpu_init */
 	barrier();
+
 	/*
-	 * Check TSC synchronization with the boot CPU:
+	 * Check TSC synchronization with the boot CPU (or whichever CPU
+	 * is controlling the bringup). It will do its part of this from
+	 * do_wait_cpu_online(), making it an implicit sync point.
 	 */
 	check_tsc_sync_target();
 
@@ -254,6 +273,7 @@ static void notrace start_secondary(void *unused)
 	 * half valid vector space.
 	 */
 	lock_vector_lock();
+	/* Sync point with do_wait_cpu_online() */
 	set_cpu_online(smp_processor_id(), true);
 	lapic_online();
 	unlock_vector_lock();
@@ -1083,7 +1103,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	unsigned long start_ip = real_mode_header->trampoline_start;
 
 	unsigned long boot_error = 0;
-	unsigned long timeout;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -1144,55 +1163,94 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
 						     cpu0_nmi_registered);
 
-	if (!boot_error) {
-		/*
-		 * Wait 10s total for first sign of life from AP
-		 */
-		boot_error = -1;
-		timeout = jiffies + 10*HZ;
-		while (time_before(jiffies, timeout)) {
-			if (cpumask_test_cpu(cpu, cpu_initialized_mask)) {
-				/*
-				 * Tell AP to proceed with initialization
-				 */
-				cpumask_set_cpu(cpu, cpu_callout_mask);
-				boot_error = 0;
-				break;
-			}
-			schedule();
-		}
-	}
+	return boot_error;
+}
 
-	if (!boot_error) {
-		/*
-		 * Wait till AP completes initial initialization
-		 */
-		while (!cpumask_test_cpu(cpu, cpu_callin_mask)) {
-			/*
-			 * Allow other tasks to run while we wait for the
-			 * AP to come online. This also gives a chance
-			 * for the MTRR work(triggered by the AP coming online)
-			 * to be completed in the stop machine context.
-			 */
-			schedule();
-		}
+static int do_wait_cpu_cpumask(unsigned int cpu, const struct cpumask *mask)
+{
+	unsigned long timeout;
+
+	/*
+	 * Wait up to 10s for the CPU to report in.
+	 */
+	timeout = jiffies + 10*HZ;
+	while (time_before(jiffies, timeout)) {
+		if (cpumask_test_cpu(cpu, mask))
+			return 0;
+
+		schedule();
 	}
+	return -1;
+}
 
-	if (x86_platform.legacy.warm_reset) {
-		/*
-		 * Cleanup possible dangling ends...
-		 */
-		smpboot_restore_warm_reset_vector();
+/*
+ * Bringup step two: Wait for the target AP to reach cpu_init_secondary()
+ * and thus wait_for_master_cpu(), then set cpu_callout_mask to allow it
+ * to proceed.  The AP will then proceed past setting its 'callin' bit
+ * and end up waiting in check_tsc_sync_target() until we reach
+ * do_wait_cpu_online() to tend to it.
+ */
+static int do_wait_cpu_initialized(unsigned int cpu)
+{
+	/*
+	 * Wait for first sign of life from AP.
+	 */
+	if (do_wait_cpu_cpumask(cpu, cpu_initialized_mask))
+		return -1;
+
+	cpumask_set_cpu(cpu, cpu_callout_mask);
+	return 0;
+}
+
+/*
+ * Bringup step three: Wait for the target AP to reach smp_callin().
+ * The AP is not waiting for us here so we don't need to parallelise
+ * this step. Not entirely clear why we care about this, since we just
+ * proceed directly to TSC synchronization which is the next sync
+ * point with the AP anyway.
+ */
+static int do_wait_cpu_callin(unsigned int cpu)
+{
+	/*
+	 * Wait till AP completes initial initialization.
+	 */
+	return do_wait_cpu_cpumask(cpu, cpu_callin_mask);
+}
+
+/*
+ * Bringup step four: Synchronize the TSC and wait for the target AP
+ * to reach set_cpu_online() in start_secondary().
+ */
+static int do_wait_cpu_online(unsigned int cpu)
+{
+	unsigned long flags;
+
+	/*
+	 * Check TSC synchronization with the AP (keep irqs disabled
+	 * while doing so):
+	 */
+	local_irq_save(flags);
+	check_tsc_sync_source(cpu);
+	local_irq_restore(flags);
+
+	/*
+	 * Wait for the AP to mark itself online. Not entirely
+	 * clear why we care, since the generic cpuhp code will
+	 * wait for it to each CPUHP_AP_ONLINE_IDLE before going
+	 * ahead with the rest of the bringup anyway.
+	 */
+	while (!cpu_online(cpu)) {
+		cpu_relax();
+		touch_nmi_watchdog();
 	}
 
-	return boot_error;
+	return 0;
 }
 
-int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+static int do_cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int apicid = apic->cpu_present_to_apicid(cpu);
 	int cpu0_nmi_registered = 0;
-	unsigned long flags;
 	int err, ret = 0;
 
 	lockdep_assert_irqs_enabled();
@@ -1239,19 +1297,6 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 		goto unreg_nmi;
 	}
 
-	/*
-	 * Check TSC synchronization with the AP (keep irqs disabled
-	 * while doing so):
-	 */
-	local_irq_save(flags);
-	check_tsc_sync_source(cpu);
-	local_irq_restore(flags);
-
-	while (!cpu_online(cpu)) {
-		cpu_relax();
-		touch_nmi_watchdog();
-	}
-
 unreg_nmi:
 	/*
 	 * Clean up the nmi handler. Do this after the callin and callout sync
@@ -1263,6 +1308,34 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	return ret;
 }
 
+int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	int ret;
+
+	ret = do_cpu_up(cpu, tidle);
+	if (ret)
+		return ret;
+
+	ret = do_wait_cpu_initialized(cpu);
+	if (ret)
+		return ret;
+
+	ret = do_wait_cpu_callin(cpu);
+	if (ret)
+		return ret;
+
+	ret = do_wait_cpu_online(cpu);
+
+	if (x86_platform.legacy.warm_reset) {
+		/*
+		 * Cleanup possible dangling ends...
+		 */
+		smpboot_restore_warm_reset_vector();
+	}
+
+	return ret;
+}
+
 /**
  * arch_disable_smp_support() - disables SMP support for x86 at runtime
  */
-- 
2.25.1

