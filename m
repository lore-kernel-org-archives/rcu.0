Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7A3FB044
	for <rcu@vger.kernel.org>; Mon, 18 May 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110014; cv=none; b=W8zCZgFjaZBkyiFmzrL1xs1I2xcTiInZIR14GeYcCmC/qr0Y2S7ie6tfPh/W/xXnp3Tt+vEsso4j9M488rVnx/D0PZBTHCCiHQds1tn0cBZa4SRpzGTWgMXhVzzdNaGOrnvoAkgVzbKm5ZSzgBtwTCkcYlQnmQbbAYfGY0dbSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110014; c=relaxed/simple;
	bh=C7nHQnxYggXqqXgHA8yK2XGmo8iSvTXSqhwUU1ZUQx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6Rr6BC7COrITq9Z9I1q2ASottpW67FhIerEj83e+2+FO+imrjjWeHq2deu/cl5OlROPnus5j6lrbJlYh6TAzMKFaXbN0aX/S6DF796hdY9HE8+QRLVfeYKjPrfylcPneslPVV2V2kuZyYiqY8YbBclTLjfbon1hpPqtL9N2Ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S31W3Gx4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S31W3Gx4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36974217d4eso1199465a91.2
        for <rcu@vger.kernel.org>; Mon, 18 May 2026 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110012; x=1779714812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+jVh1ZMjYbXV7kTF8Y6pq+jOCVWPBaSeZyRt6WW1QY=;
        b=S31W3Gx4oHaAiLiJqiU4uIed/HDsIszScbULa3+n6KwuBMxZBzOnIuQOr44E8X8uHn
         1SxKTtt/3W9rJaQfTfcBn7V92nyvtU1zW2AQkyOuTw6eO3BzvCpMDSDocCofY0Jw7KyV
         ydxDLws3CrMXV7W6gE7RqDzzbL68Bp9BMQaSobRgbcnXVRPr6iSka+pl5ClflOs/5d/4
         gvAv6E/JVyIpcZAcaXPaHMk1DTvVem4mBi+abvXFPg6Ci1nf9ERchuOqnedV3BMOl3mm
         cPuuzlS9yFTfL7S1cy1hsvUq/XvUY1DiUzzUf4h/0zvpUWt+YQggri496lXQjxQkHVWq
         2K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110012; x=1779714812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q+jVh1ZMjYbXV7kTF8Y6pq+jOCVWPBaSeZyRt6WW1QY=;
        b=n9TAwHv9ocQAQa30otMi/52BIs7WDL7k5jaFfiSrtGrbE1kbAWTgOqj6dF4a2BaBl3
         vsMT4v+QDsu9Q7B9kFZJq07OsN9PrM2OqFOqWOrN4Dh6zbxOPfoIbX3QsVFQwoTRNPsO
         fZ6C2eKqscv4x4oGdouFva2gfs603ecJyxmVPxMQMVj7riwO/4TDCeUxdQG7jbHsxRLu
         Ce2JnEPxPszwh0mkUIX/tQkNpRy5uh9EgFtSQv0n1yDIPAIWJYixu/QFpSwiaSeF/mG5
         3GNoy0AXPCgHJk+GfJSAhyw2RVdCoNdDEcsxsyHMww1msuLAZVCKKQl34oQiebj3PNwX
         9jEw==
X-Forwarded-Encrypted: i=1; AFNElJ+7xiPSw55PGbLm/OXDdQh7CTtm5U4pm7S7QQgv+D0KmSslWs0lS10zV8mhdYzReeAhnP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUuizclPJftq25Td+T3VVMqq5/6saAASm4HCXnRkMmL+GLDam
	CipPq+7bjoFi+siefRSFu6yl1p/XvacHyqeJ03+mNebHPw/OjqDwwgOO
X-Gm-Gg: Acq92OFVQVEDSZRHA0+den9v+0M87gp5+i8JKiLdmiDtLSQlB1M9jnyubV+26QJzPCO
	IzZyaKbS0l63xwqTRflnSX1FtNGf6cDHv8beETayIZRIvp1RsnOXgoQxmLEHoWByMg6+ilPykQg
	jPq2xOJFfJY25RX58F7aG0bAfJzPp+IP3pn4fER+ugQ4RJR3d8euuShD7cFHPt5nflKdeSJQSYn
	Hr7/Q+K4O7yox6hIpKsWwpmkpE5vVsjrbfUhS5/3evf40UtuhecDApjjKNLiIR4eDZyjrdi/hc9
	1/PQmy2/mznKIXhZcqIZ9pagIHxEOW3zhyYvWdUKxF+zNjlW+JVmh/h2UvY1eM+qs4Eu86AmM/e
	pKMh7GqXYrgj+c/e8C1yBzLmdu7XHxgPYM4FDCYkAbGqKB/2ScE06tErTGzylEstLCMoZtt5Llr
	JlDndsUSZIeEy5KsLxoDSy5HPFoFmpEt1MD5aplop33PmT+zhz6hC9
X-Received: by 2002:a17:90b:314a:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-3695173c0cfmr14018103a91.0.1779110012364;
        Mon, 18 May 2026 06:13:32 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c31b:5187:c514:ac40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm11241781a91.4.2026.05.18.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:32 -0700 (PDT)
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
Subject: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to report cpumask of stalled CPUs
Date: Mon, 18 May 2026 21:11:49 +0800
Message-ID: <20260518131311.1170786-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518131311.1170786-1-yphbchou0911@gmail.com>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
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

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 include/linux/sched/ext.h |  4 ++--
 kernel/rcu/tree_exp.h     | 14 +++++++++++---
 kernel/rcu/tree_stall.h   | 15 +++++++++++----
 kernel/sched/ext.c        |  7 +++++--
 4 files changed, 29 insertions(+), 11 deletions(-)

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
index 82cada459e5d..6199ca3cfb7d 100644
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
 
+		have_mask = zalloc_cpumask_var(&stalled_mask, GFP_KERNEL);
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
index b67532cb8770..b25609520418 100644
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
 
+	have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC);
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
index 22b1356aa4eb..a2ef2eae7e91 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5187,9 +5187,12 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
  * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
  * else already initiated abort.
  */
-bool scx_rcu_cpu_stall(void)
+bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
 {
-	return handle_lockup(-1, "RCU CPU stall detected!");
+	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
+
+	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
+			     cpumask_pr_args(stalled_mask));
 }
 
 /**
-- 
2.48.1

