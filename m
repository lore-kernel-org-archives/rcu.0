Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE63033E3
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429822; cv=none; b=bj1HMoKBo3I+m5JEYijgwxHUuuuXQLT/JKvnHsszx9V6Ph+soZRP/6RZAgvArHBnaEeW6tLdX0qNEbv9p0gqouTd5LPQkAlauBnV/R2CyPXZIqTLYjDNkRw9Km72vnvvfsVlZFD4sc1TK400xl0Zcz3fOZSvAPh2IjcARDpItXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429822; c=relaxed/simple;
	bh=sfZVGU9Hj9stbtl4yUdeoH+u6jGA0FBjc9cEVMC+Gs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGVaXbugZJMxVeXWhMDlgSJohoZK82TM2JD64OexoMfJ8N/aVDW6tOoM+iqIoErjZdS+75Y6AX62q75NZHHwDjxOhEFQC//T1L5ZP+rmAyA7UhxcVahpphS8lDyK+QeP5Trmi0Z23wH6mS7a7T1pejaCMPk1ZstN1NuyKt4ntd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCHeT2ge; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCHeT2ge"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1273349c56bso6339642c88.0
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429820; x=1775034620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZ4K3OH2k+TMiRs8uy+rQGZy9UvXhyZuqnAHChX5WtE=;
        b=iCHeT2geEMkV71bph6Ahko0aktuqzgMISU++9blNi8antWORinKcmNQddnKKrIMtCe
         BrnbySvS34ut9rpYvN4pt27NJyFiSmW+4gG/lcJdcsN98pq8l58AECqD++gJuAOcn/Wj
         nOgkB+dpYZhruMFQ8yBMZhsCJIDbOiJjmJtf6pREmjyG6cDI75wVwQ33XXS+jAQ6uFjq
         cOFrZ65wQK1WjDpqlDwgKQbpdsrOVcQi+ITrKxH5tuQBCvHTtGyLlqO2/MM84HJsP6FX
         yKESJk5XLU3FiqbTefmwRwIV9bkg27BueRUpKD10zacMrUKcDD9WdxM7DtP663OX2uJU
         xb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429820; x=1775034620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZ4K3OH2k+TMiRs8uy+rQGZy9UvXhyZuqnAHChX5WtE=;
        b=DM+CPxjgrk7kHAnGkbPfaLm6kCU48PwD5Bi78BUGoHZgMAVwlHz2HCM50iblaoth9i
         xOrEQ0Aa0B8VfKlkOna2W3892uMsOYbilCgfPgcrcP8fWHeVYzqQybx6ffibsSVSk+/0
         B0OCO2hWWAi5pQG+Ox04p4kWJ7mNUB7hSIftK/LRAq+pWDsXW9pjT4HgRYAsiZ0RoMG3
         myBkhwl1z4zRDObCHB33sBfaIYsV1Tuub8YRwi2bOgLACr9Nsm9bFACqZiLqkOZvZRU1
         9NrME+N+FQNpzH2JfSZW6o2uzY4MNZbDngGjReMHlBguDdoFvsL2Q7FkTEi1ecO13szb
         ASeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk1sBUMUCYiRZODxCFUVP9kvaoVBEgIOLKyz7qDie26TkSrOl7hg7noQGehZH80HKSp5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkzi4z8de6kCkt3o6v+FXuSL6DYP5YxSMqJndl8jPRp7xxlb2n
	xkf2CcMyVkuAUs2kbisIgVrVOu3Ob+0kS2TPWNxPCVMPqL6Y7448z0L8
X-Gm-Gg: ATEYQzyJFS5G0hJn5ImSc5riEw/XZAyFcaoDLhGDWrv8xVenblN8BBSAP6JejktVfY/
	UArhWDbb34LiaaJ4ulJ/KBnGRF2evvmdqXPuTzUXBR+cUsYsrv+fNmFaC29pQSJmcLBR1j7axdw
	DpyBq6BSYtPp5xwkLXd8uTqYF2oQqB9Btgl/uUPvoOsICSGXVyLk0xu5LMznmZcCDuytI/YTqcZ
	0nVS8/A+spBIWAFZZuzVl6YtioIvE9Zm7GuWlKlD5XziPq5R63VSjojt4dFVOEeZxfC0xniOYbG
	TtzXDZ4DvsmRoETkeWwgcyhM2kW2Ed8/X0yDFFu4GZj1zPEe9xNwn2SPQYq7nUN35GxQ9r1cxm8
	IBnv+Vsl3904Biz4Wn196qU5wTpcY6DEMr8fBHw/HLQfn3hLDtFKD/sSil8c20EC9WgJZ61QExQ
	I+47kjzgmj5SJobPld
X-Received: by 2002:a05:7022:618b:b0:12a:6ab7:3f7c with SMTP id a92af1059eb24-12a96e5ee3emr1202993c88.5.1774429819632;
        Wed, 25 Mar 2026 02:10:19 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:10:19 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:36 +0800
Subject: [PATCH 05/15] rcu: Support runtime NOCB initialization and dynamic
 offloading
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-5-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Context:
The RCU Non-Callback (NOCB) infrastructure traditionally requires
boot-time parameters (e.g., rcu_nocbs) to allocate masks and spawn
management kthreads (rcuog/rcuo). This prevents systems from activating
offloading on-demand without a reboot.

Problem:
Dynamic Housekeeping & Enhanced Isolation (DHEI) requires CPUs to
transition to NOCB mode at runtime. Without boot-time setup, the
NOCB masks are unallocated, and critical kthreads are missing,
preventing effective tick suppression and isolation.

Solution:
Refactor RCU initialization to support dynamic on-demand setup.
- Introduce rcu_init_nocb_dynamic() to allocate masks and organize
  kthreads if the system wasn't initially configured for NOCB.
- Update rcu_housekeeping_reconfigure() to iterate over CPUs and
  perform safe offload/deoffload transitions via hotplug sequences
  (cpu_down -> offload -> cpu_up).
- Remove __init from rcu_organize_nocb_kthreads to allow runtime
  reconfiguration of the callback management hierarchy.

This enables a true "Zero-Conf" isolation experience where any CPU
can be fully isolated at runtime regardless of boot parameters.
---
 kernel/rcu/rcu.h       |  4 +++
 kernel/rcu/tree.c      | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 27 ++++++++++++------
 4 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3d..fa9de9a3918b1 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -658,8 +658,12 @@ unsigned long srcu_batches_completed(struct srcu_struct *sp);
 #endif // #else // #ifdef CONFIG_TINY_SRCU
 
 #ifdef CONFIG_RCU_NOCB_CPU
+void rcu_init_nocb_dynamic(void);
+void rcu_spawn_cpu_nocb_kthread(int cpu);
 void rcu_bind_current_to_nocb(void);
 #else
+static inline void rcu_init_nocb_dynamic(void) { }
+static inline void rcu_spawn_cpu_nocb_kthread(int cpu) { }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4e..3fd12ac20957f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -48,6 +48,7 @@
 #include <linux/delay.h>
 #include <linux/random.h>
 #include <linux/trace_events.h>
+#include <linux/sched/isolation.h>
 #include <linux/suspend.h>
 #include <linux/ftrace.h>
 #include <linux/tick.h>
@@ -4916,4 +4917,79 @@ void __init rcu_init(void)
 #include "tree_stall.h"
 #include "tree_exp.h"
 #include "tree_nocb.h"
+
+#ifdef CONFIG_SMP
+static int rcu_housekeeping_reconfigure(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	struct task_struct *t;
+	int cpu;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_RCU)
+		return NOTIFY_OK;
+
+	rcu_init_nocb_dynamic();
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		bool isolated = !cpumask_test_cpu(cpu, upd->new_mask);
+		bool offloaded = rcu_rdp_is_offloaded(rdp);
+
+		if (isolated && !offloaded) {
+			/* Transition to NOCB */
+			pr_info("rcu: CPU %d transitioning to NOCB mode\n", cpu);
+			if (cpu_online(cpu)) {
+				remove_cpu(cpu);
+				rcu_spawn_cpu_nocb_kthread(cpu);
+				rcu_nocb_cpu_offload(cpu);
+				add_cpu(cpu);
+			} else {
+				rcu_spawn_cpu_nocb_kthread(cpu);
+				rcu_nocb_cpu_offload(cpu);
+			}
+		} else if (!isolated && offloaded) {
+			/* Transition to CB */
+			pr_info("rcu: CPU %d transitioning to CB mode\n", cpu);
+			if (cpu_online(cpu)) {
+				remove_cpu(cpu);
+				rcu_nocb_cpu_deoffload(cpu);
+				add_cpu(cpu);
+			} else {
+				rcu_nocb_cpu_deoffload(cpu);
+			}
+		}
+	}
+
+	t = READ_ONCE(rcu_state.gp_kthread);
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+
+#ifdef CONFIG_TASKS_RCU
+	t = get_rcu_tasks_gp_kthread();
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	t = get_rcu_tasks_rude_gp_kthread();
+	if (t)
+		housekeeping_affine(t, HK_TYPE_RCU);
+#endif
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rcu_housekeeping_nb = {
+	.notifier_call = rcu_housekeeping_reconfigure,
+};
+
+static int __init rcu_init_housekeeping_notifier(void)
+{
+	housekeeping_register_notifier(&rcu_housekeeping_nb);
+	return 0;
+}
+late_initcall(rcu_init_housekeeping_notifier);
+#endif
+
 #include "tree_plugin.h"
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8bbe7960cda7..5322656a5a359 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -518,7 +518,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
-static void __init rcu_organize_nocb_kthreads(void);
+static void rcu_organize_nocb_kthreads(void);
 
 /*
  * Disable IRQs before checking offloaded state so that local
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e6cd56603cad4..9f5f446e70b3f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1285,6 +1285,22 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 }
 #endif // #ifdef CONFIG_RCU_LAZY
 
+void rcu_init_nocb_dynamic(void)
+{
+	if (rcu_state.nocb_is_setup)
+		return;
+
+	if (!cpumask_available(rcu_nocb_mask)) {
+		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
+			pr_info("rcu_nocb_mask allocation failed, dynamic offloading disabled.\n");
+			return;
+		}
+	}
+
+	rcu_state.nocb_is_setup = true;
+	rcu_organize_nocb_kthreads();
+}
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1302,15 +1318,8 @@ void __init rcu_init_nohz(void)
 		cpumask = cpu_possible_mask;
 
 	if (cpumask) {
-		if (!cpumask_available(rcu_nocb_mask)) {
-			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
-				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
-				return;
-			}
-		}
-
+		rcu_init_nocb_dynamic();
 		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
-		rcu_state.nocb_is_setup = true;
 	}
 
 	if (!rcu_state.nocb_is_setup)
@@ -1442,7 +1451,7 @@ module_param(rcu_nocb_gp_stride, int, 0444);
 /*
  * Initialize GP-CB relationships for all no-CBs CPU.
  */
-static void __init rcu_organize_nocb_kthreads(void)
+static void rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	bool firsttime = true;

-- 
2.43.0

