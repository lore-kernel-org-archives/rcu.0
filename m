Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B93DB31C
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211095; cv=none; b=kxcny0UJCzvPdhN/hF9LMDQ6Ml/fxyIAb8IX/Bglz8wO76rgxLy5hJow+gAT27E7J+GIwXZtfbPXwpAh4ZD3aTrvI7hN4LOMsmq+SozCw6aIpf+kByJfCKPfx4ncYLvyuVyzaQ+1pElD2B9BC9cJM5ccee6yFeNquW1BHF7OtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211095; c=relaxed/simple;
	bh=iqFRsZIgWP3CMNqvnPDQsJ98GjaDrbFtLOXvcfoCaDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axJP1PI74ZghhDp59PZRcJfx9Rp7cBlV8jrCMK6twa6ZN/z2fGXFAN/ALzQWIQ1u5ZGIgVgYXpjRqp5LahdaCMhEP5/uvH4Etd8NwXElyH87HYLR34sc2gn8nHKWrLJz7+JRiKqOsOY4S3A2Dwkyg2FbyJ1EWW+F3IsVDRDLQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0BnfykD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0BnfykD"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-367c26471f5so2415141a91.1
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 10:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211092; x=1779815892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg5o0TYxZ7dyN4xjrwSkd4IzB+GmQlSJTL7b6f4Rq/g=;
        b=K0BnfykDH6Iu/0Qym4PRghZfmQ4tW3q3By1wZpXBaWqB9IfqRr6tPsdVpVj3iaSfxO
         mlYjGYF87RfW/3FTCDYKTlahKC24L6r7iiBoeQuePnFlAERegWLC6EdEl5hF0elLniQu
         FyVzriSG69XeOWWUWPGtEstJmeTKYBd9O4hAbjkrt+YFgHs5Wu1/JHtWOiJoOZqx4CoX
         rtHkeHkGJQaFTKR48JBtCn/rMZRaQ1RLJQvV4bppv/hGYVa/OczoNEwyj9WQNjYZnbLe
         dc+g6XUCM7OAIQVlT00S7vMV7Uv6Uk8JYGK+zz4324v21AU446GvJYVNaJYmI/dUsiyu
         j9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211092; x=1779815892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bg5o0TYxZ7dyN4xjrwSkd4IzB+GmQlSJTL7b6f4Rq/g=;
        b=icIH0bziZxmn0QM94bst4cq9tp5abFCvGffTjhRgNP/h9XcaF8XFIn7vwsve9TprUQ
         X6WR5v5KQ12h+MYpwl2XkLDuIOlt7tpidhkelbzCL3e8rPoWWm8DHr9wVCqi0y6LpnJL
         1j+zoSddUYCR64b+B0PFwqg/uklBaIHZu+DuDuJ4/eYzvSan9YE4tjxv3lK9HO7INrhe
         P9zi7RwhQrP3gsBR6mqiNvi+2REBkZWbq6ptuH6FAxiwZtIb/P+6xDoEkGGpJTw7eYV2
         uwiF1Nq+zk0y0OHlPO3SECySV2d+ce0uTYRhJ8nY+rZ8IlNQ1QgBsJJo8Bq6ZfRbafsC
         aKGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Tyze1F0FBOgoXTIOCDjFtL3sYYxIxSKq2qT0pbqLgHZIsMZa3PYJGhsO/hJbZT0aKcZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFh5Vkp2xik3HGRO0Bvyf32ovTSubCYrBsUaCChuZbUfFjzBCR
	4yiSUp7LCPUhuW72pTNYP88IYmyporOdKQ5JZE7lH0DyIl/Fm6GdL59+
X-Gm-Gg: Acq92OEbsL5Slye3W7UyjhryBZFu2lbqHEuZaWEMuwxk6YJBp0JLB2uiVKh5+DxkOB1
	/9/e+2wv/TGAlnpsz74skHdiQi5q+ckpZ46TrVKljOR9FdDN/ewGb0mvOvW/OeBpzuMufxHkTpI
	ynAk+f6MtyJtICZdX+WojnDWTEN5f0mi/MeL9uaW23eYeQ3qdbZKFvlpF+c1FD/KWj6XV+E9+SV
	wuw9uqPaWarw8UxB8ekM1WccNZSHqQtdcEAKAxMO3UDeUJ0I+Ou5S2rj/gyjsjCmXgadXfIv/Jn
	E8R2JkaplvNQfQIxTv0CmIoXsEzAi66oujBxS+d7SjBhw3TcmWwVK5TVzKTM23MyEntOPAznT8/
	K4z0eUvc9HX1rLHtEC3Z7CgxEzkyXo7iFehVcQqz/c6kJI6eDtZG8+hFgwm2xugiIR4+5HYtjv5
	+gt95DDHXXJUvtZE8AqPTUHFUAGByQhEYQ7NQGnop9vwg59rtUOIpSUiJdTx8j
X-Received: by 2002:a17:90b:2c90:b0:366:3ac:f730 with SMTP id 98e67ed59e1d1-36951c976dfmr18698848a91.25.1779211091837;
        Tue, 19 May 2026 10:18:11 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:46ec:2327:9655:89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm14370012a91.0.2026.05.19.10.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:18:11 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs
Date: Wed, 20 May 2026 01:17:31 +0800
Message-ID: <20260519171745.1551340-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260519171745.1551340-1-yphbchou0911@gmail.com>
References: <20260519171745.1551340-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
stalled one, and the expedited grace period path had no stalled CPU to
report at all.

Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.
Falls back to cpu_none_mask on allocation failure.

Store the stall mask in scx_sched rather than scx_exit_info, keeping the
BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
directly and dumps all stalled CPUs first to avoid losing them to
truncation.

Use __GFP_NOWARN for the cpumask allocations in print_other_cpu_stall()
and synchronize_rcu_expedited_wait(). Both allocate before calling
nbcon_cpu_emergency_enter(). A warn_alloc() failure printout would use
the normal printk path and risk deadlock if a stalled CPU holds a
console lock.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 include/linux/sched/ext.h   |  4 +-
 kernel/rcu/tree_exp.h       | 14 +++++--
 kernel/rcu/tree_stall.h     | 15 ++++++--
 kernel/sched/ext.c          | 76 ++++++++++++++++++++++++++++++++-----
 kernel/sched/ext_internal.h |  1 +
 5 files changed, 91 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 20b2343aa344..75cb8b119fb7 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -263,7 +263,7 @@ void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
 bool scx_hardlockup(int cpu);
-bool scx_rcu_cpu_stall(void);
+bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
@@ -271,7 +271,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 static inline bool scx_hardlockup(int cpu) { return false; }
-static inline bool scx_rcu_cpu_stall(void) { return false; }
+static inline bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..b8f4ca984c1c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -555,7 +555,8 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
 /*
  * Print out an expedited RCU CPU stall warning message.
  */
-static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j)
+static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j,
+					    struct cpumask *stalled_mask)
 {
 	int cpu;
 	unsigned long mask;
@@ -578,6 +579,8 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 			if (!(READ_ONCE(rnp->expmask) & mask))
 				continue;
 			ndetected++;
+			if (stalled_mask)
+				cpumask_set_cpu(cpu, stalled_mask);
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			pr_cont(" %d-%c%c%c%c", cpu,
 				"O."[!!cpu_online(cpu)],
@@ -659,23 +662,28 @@ static void synchronize_rcu_expedited_wait(void)
 
 	for (;;) {
 		unsigned long j;
+		cpumask_var_t stalled_mask;
+		bool have_mask;
 
 		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
 
+		have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWARN);
+
 		nbcon_cpu_emergency_enter();
 
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
-		synchronize_rcu_expedited_stall(jiffies_start, j);
+		synchronize_rcu_expedited_stall(jiffies_start, j, have_mask ? stalled_mask : NULL);
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall();
+		panic_on_rcu_stall(have_mask ? stalled_mask : cpu_none_mask);
+		free_cpumask_var(stalled_mask);
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..90d6eaf1b841 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
 early_initcall(check_cpu_stall_init);
 
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
-static void panic_on_rcu_stall(void)
+static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
 {
 	static int cpu_stall;
 
@@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
 	 * Attempt to kick out the BPF scheduler if it's installed and defer
 	 * the panic to give the system a chance to recover.
 	 */
-	if (scx_rcu_cpu_stall())
+	if (scx_rcu_cpu_stall(stalled_mask))
 		return;
 
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
@@ -631,6 +631,8 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
+	cpumask_var_t stalled_mask;
+	bool have_mask;
 	unsigned long flags;
 	unsigned long gpa;
 	unsigned long j;
@@ -645,6 +647,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWARN);
+
 	nbcon_cpu_emergency_enter();
 
 	/*
@@ -660,6 +664,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 					print_cpu_stall_info(cpu);
+					if (have_mask)
+						cpumask_set_cpu(cpu, stalled_mask);
 					ndetected++;
 				}
 		}
@@ -701,7 +707,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(have_mask ? stalled_mask : cpu_none_mask);
+	free_cpumask_var(stalled_mask);
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
@@ -754,7 +761,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(cpumask_of(smp_processor_id()));
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 22b1356aa4eb..28797467f82a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4948,6 +4948,8 @@ static const struct attribute_group scx_global_attr_group = {
 
 static void free_pnode(struct scx_sched_pnode *pnode);
 static void free_exit_info(struct scx_exit_info *ei);
+static const char *scx_exit_reason(enum scx_exit_kind kind);
+static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
 
 static void scx_sched_free_rcu_work(struct work_struct *work)
 {
@@ -4962,6 +4964,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	timer_shutdown_sync(&sch->bypass_lb_timer);
 	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 	free_cpumask_var(sch->bypass_lb_resched_cpumask);
+	free_cpumask_var(sch->stall_cpus);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 	kfree(sch->cgrp_path);
@@ -5187,9 +5190,46 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
  * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
  * else already initiated abort.
  */
-bool scx_rcu_cpu_stall(void)
+bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
 {
-	return handle_lockup(-1, "RCU CPU stall detected!");
+	struct scx_sched *sch;
+	struct scx_exit_info *ei;
+	int exit_cpu;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return false;
+
+	switch (scx_enable_state()) {
+	case SCX_ENABLING:
+	case SCX_ENABLED:
+		break;
+	default:
+		return false;
+	}
+
+	exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
+	ei = sch->exit_info;
+
+	guard(preempt)();
+
+	if (!scx_claim_exit(sch, SCX_EXIT_ERROR))
+		return false;
+
+#ifdef CONFIG_STACKTRACE
+	ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
+#endif
+	scnprintf(ei->msg, SCX_EXIT_MSG_LEN, "RCU CPU stall on CPUs (%*pbl)",
+		  cpumask_pr_args(stalled_mask));
+	ei->kind = SCX_EXIT_ERROR;
+	ei->reason = scx_exit_reason(SCX_EXIT_ERROR);
+	ei->exit_cpu = exit_cpu;
+	cpumask_copy(sch->stall_cpus, stalled_mask);
+
+	irq_work_queue(&sch->disable_irq_work);
+	return true;
 }
 
 /**
@@ -5204,7 +5244,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+	if (!handle_lockup(smp_processor_id(),
+			   "soft lockup - CPU %d stuck for %us",
 			   smp_processor_id(), dur_s))
 		return;
 
@@ -6608,14 +6649,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 	dump_line(&s, "----------");
 
 	/*
-	 * Dump the exit CPU first so it isn't lost to dump truncation, then
-	 * walk the rest in order, skipping the one already dumped.
+	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
+	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
 	 */
-	if (ei->exit_cpu >= 0)
-		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
-	for_each_possible_cpu(cpu) {
-		if (cpu != ei->exit_cpu)
+	if (!cpumask_empty(sch->stall_cpus)) {
+		for_each_cpu(cpu, sch->stall_cpus)
 			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		for_each_possible_cpu(cpu) {
+			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
+				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		}
+	} else {
+		if (ei->exit_cpu >= 0)
+			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
+		for_each_possible_cpu(cpu) {
+			if (cpu != ei->exit_cpu)
+				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
+		}
 	}
 
 	dump_newline(&s);
@@ -6851,6 +6901,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 		ret = -ENOMEM;
 		goto err_free_lb_cpumask;
 	}
+	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_free_lb_resched_cpumask;
+	}
 	/*
 	 * Copy ops through the right union view. For cid-form the source is
 	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
@@ -6920,8 +6974,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
 #ifdef CONFIG_EXT_SUB_SCHED
 err_free_lb_resched:
 	RCU_INIT_POINTER(ops->priv, NULL);
-	free_cpumask_var(sch->bypass_lb_resched_cpumask);
+	free_cpumask_var(sch->stall_cpus);
 #endif
+err_free_lb_resched_cpumask:
+	free_cpumask_var(sch->bypass_lb_resched_cpumask);
 err_free_lb_cpumask:
 	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 err_stop_helper:
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 3ccfea06cba0..f51f03868ff7 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1178,6 +1178,7 @@ struct scx_sched {
 	struct timer_list	bypass_lb_timer;
 	cpumask_var_t		bypass_lb_donee_cpumask;
 	cpumask_var_t		bypass_lb_resched_cpumask;
+	cpumask_var_t		stall_cpus;
 	struct rcu_work		rcu_work;
 
 	/* all ancestors including self */
-- 
2.48.1

