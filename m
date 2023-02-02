Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A990C636D7
	for <rcu@archiver.kernel.org>; Thu,  2 Feb 2023 21:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjBBV4z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjBBV4x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Feb 2023 16:56:53 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4EE7377D
        for <rcu@vger.kernel.org>; Thu,  2 Feb 2023 13:56:39 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o18so3008655wrj.3
        for <rcu@vger.kernel.org>; Thu, 02 Feb 2023 13:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hr9lEiKrK81ARA2M0cI5BiENvgrY9Zt5BHSS6rpobc=;
        b=u2nq3Ej9mftRp/AibuMcN8opF0/YxTfubYLNVe5VnD252/9mQ6PWzMHa5Wy+zTi5xp
         CIi3VzipOQ3cUPBGWAYmpslvBtttDPw0YSfsxwwOb8vHCqZjVNxF0VdoPIcVsCTVro9g
         AguJPXSsPtWzOCPAOcncRsin0t0J5YZ7QOZe8pW0y6LDl7mODkAk59UCuvCsC+MP5sqy
         q+DG2ZCDTfCUwcSBIxz9PsT6w0i57kcB3wXmbmXODr7XQ/LQ3stW00g1uJPRvgJxl05E
         tMfTmxwCQSL1qvW3qdy+19PzKFX9DfoV4xwkbCCP0MVT9BliY8KGfNVy4aBXuTJwfNjG
         w2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hr9lEiKrK81ARA2M0cI5BiENvgrY9Zt5BHSS6rpobc=;
        b=UEI8PimvpRYTZIC93zwP2vAG/kA/YTcP6Dwh+YXqGNkmIi5mNVITHqCPb5efHSp+yV
         VpUK2+AcnO4dsRzn+T7wz7U6jFF/I3uYc0+qRKZMgPf23FAuwt98kgMdkxm6WdsU9oG4
         /t3p/9O3w9E8H4jZh3L0u4uM1v6+nLUwIev/HHMgS7xnNHnR3tM3rSOFDqQoHXD5XfBG
         fnqr6lBiqyJ+eZxs/GfQSNGufo6bMi79FEEOt4WGuEC6hyhoyECAeXVG8PYqd4dvcfoC
         0NHvWPWL4pMp9GvLkssIi0D9T/vm0NjTWJW6GW/lQJtWPnXOJe7kZ3fhT1gsk7SL4M1y
         XHkw==
X-Gm-Message-State: AO0yUKXmkv0emKkRFOfQ3ARgHhfr720CANeV06+9cHrsV9bkJV7Fj/ui
        rc2WsyXfkFnwSqyp6P0AZQLjvA==
X-Google-Smtp-Source: AK7set9VaYKLIY2SSswrgGk/66ynBMexvL5z+QFh9QXlklkefxCnDRz/1L9DNd9e8bVxmgiTz/rx5g==
X-Received: by 2002:adf:fa84:0:b0:2bf:ae15:ac15 with SMTP id h4-20020adffa84000000b002bfae15ac15mr6639032wrr.62.1675374998131;
        Thu, 02 Feb 2023 13:56:38 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:98fe:e4ee:fc7e:cd71])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d6d08000000b00297dcfdc90fsm506078wrq.24.2023.02.02.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:56:37 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de, arjan@linux.intel.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v6 08/11] x86/smpboot: Send INIT/SIPI/SIPI to secondary CPUs in parallel
Date:   Thu,  2 Feb 2023 21:56:22 +0000
Message-Id: <20230202215625.3248306-9-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202215625.3248306-1-usama.arif@bytedance.com>
References: <20230202215625.3248306-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

When the APs can find their own APIC ID without assistance, we can do
the AP bringup in parallel.

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/smpboot.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 656897b055f5..77c509e95571 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/smpboot.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -1330,9 +1331,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1354,6 +1358,12 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
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
@@ -1550,6 +1560,10 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		do_parallel_bringup = false;
 	}
 
+	if (do_parallel_bringup)
+		cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
+					  native_cpu_kick, NULL);
+
 	snp_set_wakeup_secondary_cpu();
 }
 
-- 
2.25.1

