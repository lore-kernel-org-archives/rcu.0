Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4788C55178
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6401520786
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617292;
	bh=fz2HhQJRCVuQiOPMD551kUBRgNfqMQdtpKHjhwrMEso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gt/org6WrTF/nQnfNRu4WfdwDFeQrW0uy+3OTBX1ZKVDBL3y5MJI44VgChW625QL6
	 ArSEnI+CMEdNr4cN2Laxfgyb0WU0P7MkXEC7bsnlRyZi4ScbRHbZLzlRBgp0heCAMD
	 BkEbeQAccXi11wliAoxtguqFR6zhl08tXUkTklMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgKEXB3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbgKEXB3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:01:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4CA620782;
        Thu,  5 Nov 2020 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617288;
        bh=fz2HhQJRCVuQiOPMD551kUBRgNfqMQdtpKHjhwrMEso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cqjgu4QBg/SzXVn2KlMlYh14uJDIUF9J7GH/aAYdAwP0U+t97tkD5nliDDWe8ICRt
         nCNAmogqpthy78hb7waUDeRfsq4HiYgC0z4U8vlI8o++s5dSB+a9/moESCCGTZnao2
         awGNKG8R0+P8dunSTykc+19y9WLGNHDQUW1v9YIo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH tip/core/rcu 2/2] x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs
Date:   Thu,  5 Nov 2020 15:01:23 -0800
Message-Id: <20201105230123.18308-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230040.GA18202@paulmck-ThinkPad-P72>
References: <20201105230040.GA18202@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, accessing /proc/cpuinfo sends IPIs to idle CPUs in order to
learn their clock frequency.  Which is a bit strange, given that waking
them from idle likely significantly changes their clock frequency.
This commit therefore avoids sending /proc/cpuinfo-induced IPIs to
idle CPUs.

[ paulmck: Also check for idle in arch_freq_prepare_all(). ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/kernel/cpu/aperfmperf.c | 6 ++++++
 include/linux/rcutiny.h          | 2 ++
 include/linux/rcutree.h          | 1 +
 kernel/rcu/tree.c                | 8 ++++++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index 37ff7f4..47af9b7 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
 #include <linux/sched/isolation.h>
+#include <linux/rcupdate.h>
 
 #include "cpu.h"
 
@@ -93,6 +94,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 		return 0;
 
+	if (rcu_is_idle_cpu(cpu))
+		return 0; /* Idle CPUs are completely uninteresting. */
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -112,6 +116,8 @@ void arch_freq_prepare_all(void)
 	for_each_online_cpu(cpu) {
 		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 			continue;
+		if (rcu_is_idle_cpu(cpu))
+			continue; /* Idle CPUs are completely uninteresting. */
 		if (!aperfmperf_snapshot_cpu(cpu, now, false))
 			wait = true;
 	}
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7c1ecdb..2a97334 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -89,6 +89,8 @@ static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_preempt(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
+#define rcu_is_idle_cpu(cpu) \
+	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 59eb5cd..df578b7 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -50,6 +50,7 @@ void rcu_irq_exit(void);
 void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
+bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
 void rcu_irq_exit_check_preempt(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef..1d84c0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -341,6 +341,14 @@ static bool rcu_dynticks_in_eqs(int snap)
 	return !(snap & RCU_DYNTICK_CTRL_CTR);
 }
 
+/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
+bool rcu_is_idle_cpu(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+}
+
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
-- 
2.9.5

