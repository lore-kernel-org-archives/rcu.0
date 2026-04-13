Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57073397E81
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066236; cv=none; b=DwUSXq6b5vIj/OC9EybswfbDeRxGWQJuTr2JTWvibst+cI/286tbmuvfbJeK8AsitluXjRRV3rMiLCIP92GrviNw3KT7S17/NRc4hjzHIa6dCWkrrEE/FPTM2qKlwW8YF4P8V9EHX1RCVGGDHps3sgsw12HPHDyWZljFzwobxu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066236; c=relaxed/simple;
	bh=a/odz2uw4gvTIjw/tTNRaOxlb3XXkQnfh9vxBJlDOpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mpi2btu9pO6eMnK7/uo9IfZ75dIOgGtHArN7SyetNRpBLMe6fKj7ftaz6OcXJiBeFAoEJ1/jppkMy4zJQIjLJBkLwGbRgsDWRAGE4Mh2S7YcoW2IN+R8hfuWoxls3/ciBiWJLnlt4C7f2RGLjOt+CTCoY6jrv/96FyLG4ET75bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyfAsS+n; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyfAsS+n"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c20010f10so10473796c88.0
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066234; x=1776671034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dq7A9F2uS9NBzcitrHUera4fwiqvquYPVtGYt+ZQHw=;
        b=LyfAsS+nyWB4jM85ExsVjPVvONfdxlrGTJBDdlw40d7Q59DquWHE7QDP7+H0x9IKv+
         peEFhobLpVxIll5J8SnBhZzaHVaQ07/B7n/s/LV+1E18QTjtrlZJHJBZbc6mcaVspnBp
         bzO0gWgPcXL1SccRJG6kSYRAUa18PJE9i7xWDkJA3gMId0NYYd2FOAUyY2D2IfNe9fJ5
         cUo+uruc5CcVD1cOAgvSwv6S6CSWZub/aWg278MdwGkFZqDx1QgZCzJrKYbS2808MEgV
         NjIxbOnChqBwR4wEqo9WZCnLAajeHcNfE4oZiOWbrK69aiUhjCdQ7bq17MmKnpEYfkLS
         1eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066234; x=1776671034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dq7A9F2uS9NBzcitrHUera4fwiqvquYPVtGYt+ZQHw=;
        b=qCzcSikC4YilNWA6KV2L+K3JZs0K3ereinAiK42Sa+7LBQ5tyZHmgApsE2j5ktQNuu
         MN4IVrrZNx8elUhgECExp1rqljHeLeFInzQDTycIszLQA2zXdrT4tZDRKwjHvXP3BbkO
         9NQdVwDo6pQFYyUCaJQXEaEHSHuF+rS9euKM7VJ5ocexF94dEARhmSLyROA6HPf6AuWD
         bkMusZqQBIpbvfnVJj9308i2Kz4WKuh3Jb66L1jl4t7VyYohHXot3OqrcZnQCXPRnCvg
         znbCx+WKNm4zDDhU6IfMpOuaf7mmY2MDWkacMB/UaimmWMEpy8LDn/X09Ar2hK/hHFFn
         mXhw==
X-Forwarded-Encrypted: i=1; AFNElJ+HZFD6UuQhd+Pn8MjRYg+fdls7VyMQJlZBQ18nboAcZ3OBeXCiZn2wfw7mWYSs/gci0hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwoVz57s4lqftM9XKZtCmwWwOZvFhz0K/xEtVPmb1vrGYM+gF
	u74ATu43KWsbJdHz/bz2th227AiA5N6olbtR4r6pqypY7jWjr4Hkw0+p
X-Gm-Gg: AeBDievpf7sNqrxuFyxp76dCaIkXwzaYUHst7A38EqIkY7sDh5Uq0GMwSTwPfU1YioE
	gpVtOoPqutIwuiPQ9w8I1liTK3fDMyiPHmsMlREe9kTHT0eguF0Bd1t4d9WnM3XBtTOp8ejsti7
	tjqBSsj6ebM9UqWnPNdTC8xbVnuXx3HoXd0jI6HgbIkPM35NX1loqmWHV4qyWMN2WqdaRLKh0nA
	Z79Lo4v94h+YUUjlkrEGHt0hWwIP+As8shR+/Cd+r9iuQxtxdfyaYSn1gZ7IZ91rnGiM7ZI/U8W
	fKcQajbh4wrWettibQi/nBpF/EIwiHx9WUDGAdfUwNP14ZTK7JBh1+F5tduMY9486dOoH3ioc84
	uOWdnLn8qcsNgAl4gvTKS6Qh1X9c0fahbKV5qIR1XCpsjIDYNUrCg9jeRokoO3o6+YIQxzbymZg
	YHxzyvSya719fX6IYg
X-Received: by 2002:a05:7022:439f:b0:128:d5f1:d594 with SMTP id a92af1059eb24-12c34e7b83amr6713439c88.10.1776066234304;
        Mon, 13 Apr 2026 00:43:54 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:43:54 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:09 +0800
Subject: [PATCH v2 03/12] rcu: Support runtime NOCB initialization and
 dynamic offloading
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-3-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Context:
The RCU Non-Callback (NOCB) infrastructure traditionally requires
boot-time parameters (e.g., rcu_nocbs) to allocate masks and spawn
management kthreads (rcuog/rcuo). This prevents systems from activating
offloading on-demand without a reboot.

Problem:
Dynamic Housekeeping Management requires CPUs to transition to
NOCB mode at runtime when they are newly isolated. Without boot-time
setup, the NOCB masks are unallocated, and critical kthreads are missing,
preventing effective tick suppression and isolation.

Solution:
Refactor RCU initialization to support dynamic on-demand setup.
- Introduce rcu_init_nocb_dynamic() to allocate masks and organize
  kthreads if the system wasn't initially configured for NOCB.
- Introduce rcu_housekeeping_reconfigure() to iterate over CPUs and
  perform safe offload/deoffload transitions via hotplug sequences
  (cpu_down -> offload -> cpu_up) when a housekeeping cpuset triggers
  a notifier event.
- Remove __init from rcu_organize_nocb_kthreads to allow runtime
  reconfiguration of the callback management hierarchy.

This enables a true "Zero-Conf" isolation experience where any CPU
can be fully isolated at runtime regardless of boot parameters.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/rcu/rcu.h       |  4 +++
 kernel/rcu/tree.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 31 +++++++++++++--------
 4 files changed, 100 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9b10b57b79ada..282874443c96b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -663,8 +663,12 @@ unsigned long srcu_batches_completed(struct srcu_struct *sp);
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
index 55df6d37145e8..84c8388cf89a1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4928,4 +4928,79 @@ void __init rcu_init(void)
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
index 7dfc57e9adb18..f3d31918ea322 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -517,7 +517,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags);
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp);
 #ifdef CONFIG_RCU_NOCB_CPU
-static void __init rcu_organize_nocb_kthreads(void);
+static void rcu_organize_nocb_kthreads(void);
 
 /*
  * Disable IRQs before checking offloaded state so that local
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3337c7231ccb..36f6c9be937aa 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1259,6 +1259,22 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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
@@ -1276,15 +1292,8 @@ void __init rcu_init_nohz(void)
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
@@ -1344,7 +1353,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
  * rcuo CB kthread, spawn it.  Additionally, if the rcuo GP kthread
  * for this CPU's group has not yet been created, spawn it as well.
  */
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
+void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_data *rdp_gp;
@@ -1416,7 +1425,7 @@ module_param(rcu_nocb_gp_stride, int, 0444);
 /*
  * Initialize GP-CB relationships for all no-CBs CPU.
  */
-static void __init rcu_organize_nocb_kthreads(void)
+static void rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	bool firsttime = true;
@@ -1668,7 +1677,7 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 	return false;
 }
 
-static void rcu_spawn_cpu_nocb_kthread(int cpu)
+void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 }
 

-- 
2.43.0

