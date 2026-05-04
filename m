Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BC1CAA65
	for <rcu@vger.kernel.org>; Mon,  4 May 2026 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911365; cv=none; b=b+IOtiXU6DamU3aFUPX+jF/nPhCP90FDwINsNxwOi/kb/cpAygYbYnugJzY8gywroR5FZ5So56DJfkHTxTMQC8KZPpctoKfY1x2dvpsL4i1k6mZEy3R5ZD31cZpb7pM2Qd3tRo7cEP0Kr6j70DPU9h8nlUkRiMcyWSDAdkfucqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911365; c=relaxed/simple;
	bh=HIa0nX5L4ehamzAuOG16yR5IW2GdlUwwvizGgxbg1bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4k7P1AFH8mpxhXEcmf/bLu+CGvKH6gajXoJu2A4h07k99c9qf6UGNefaNHBxE/P/16n82/L5W1HjSVC7gz6SgG3CBLmV5CUc5ChzCwvVY0fFlssWTjwrd5KZLGRrhwr8vRMOunPJcftAfYYij3AJiSOBWD05sE9F3W7oCv7fik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFFovczf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFFovczf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b941cd869cso25154315ad.1
        for <rcu@vger.kernel.org>; Mon, 04 May 2026 09:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911363; x=1778516163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25CABJguTY/XZaAHlyNBNnk3J38Lt+IjjTyegaLv49A=;
        b=lFFovczfi6mdkOTv1HLt46ulxUPEtKwF2jAKCiVfr/Ppv73rKoX7VEjPLZzztaFX3I
         IskR13VnuqSyY4EoT57t8BRCE5qeDSmcQvWEZTT0Rtt8sgGmP/pNGzjKp4nPXQJZ/XOK
         DP9BE5zIABew+0xfDLwwWAFVHRfzem8KE+WmPsko5Cn/i1ios31PsIzmOqiILpiEmKZm
         qsivcIUSgg6aL/adl3/8lF0Sx2APGQmZJpGcc4n2stZmHFQ5OH+uB6TGqykOflMcth9A
         D2FY0QlsMuB5azm9qfgojo7ZK7IEVuBSw7Q4z383uHwOF8p9ORP7sI8VjtqR04KskMRT
         Dx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911363; x=1778516163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25CABJguTY/XZaAHlyNBNnk3J38Lt+IjjTyegaLv49A=;
        b=ThAUg2WzRR6Q9M3Cqnvm2xSVfrPbXKPis403XdbW22Z40+yK9kIY6knqXJeXXK4JBZ
         uxA6GuzDxvlznq9PM81gRpCVbBmM253JGxYOxzjSMXOl/xHsNdxxf/djllum96PqBFwM
         0229ntqqLwJHJ8jdFtwfJ6b+afASQot9PQEP/tpcgE2O3AiuIsB+XxhUzZrPLiSDvTHT
         acn/GeV4XKs4vXiksjU0ecEBWFlxtXWjSD/QQBMQH9KNa0TvmMOQzImmCBIPYFwBR2Z+
         GwTJ5T8+o4klkTSJbRo4rxJ1/CpS5jmhqv1wr3oChJndai068voqizmYknDSotvqA2Ih
         S1Sw==
X-Forwarded-Encrypted: i=1; AFNElJ8mCxxPznz2aAUd3dXplSg6Y9r4h+45a8pAfIWoGc9d58+1WMD9bMaxx2GTBDq2xTZ12W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfn8pW325TxZYgr485Q3KMj9ASdAARKjZraY9T8qwUpVB8q2+
	4HaX4hNTx3LFlju0HUix07lRXktNJ2Pj5zCyBzcQUmzKhSV4AjA48/QN
X-Gm-Gg: AeBDiesJyhP6pWDIbFlqzTwu4eMltcpSzFKysTItsImLX6q6uuLodzLuW5qZWfs1ia4
	KqvEDRxM3W0Zm5kG9QS+82UJtKCm+oydEkLEMXImgz8XxU2Hb0+1bWrxucU9MxRDaq/f1+eMYQE
	9CENTxDt+35gFpVBmilvlPhsV58nkQBYxJ+AF6A8Dpvcm1uaFG0755VUMjLUksnI2uFD/+hFQJ2
	/c5XnzeKciCj/CBGBCxiAVjKUPZ+MSQ2x5bbR5NcNPS1/OnuQC7Ju1m94eHioBeDtRwMFSOFJQc
	XBogISOLOkZaeQ2yTmqKGKppp7bT3KHSF1lhjcp8hBhuOOYqUv9dgCY6NUnS3oB0381J5LOfHp1
	rC+puM2XV0iy9VWqUdxQJnHWOffLAlkplQCrQe2OctvJnE6NA0MzzwZdl9IZ60GkAiQVPMWKHwt
	/M4uHa24Ztbl2k838m+KvqHCBIScU7mP/OIhA0gBFco9Q4xqHpEaP4d/asSPLYnA==
X-Received: by 2002:a17:903:1b6c:b0:2ba:3b93:aa4d with SMTP id d9443c01a7336-2ba3b93abc7mr23499355ad.25.1777911362905;
        Mon, 04 May 2026 09:16:02 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d123:1fb:b1d3:aa01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba4ccf6a1esm2385745ad.81.2026.05.04.09.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:16:02 -0700 (PDT)
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
	yphbchou0911@gmail.com
Subject: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Tue,  5 May 2026 00:08:20 +0800
Message-ID: <20260504161543.674488-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260504161543.674488-1-yphbchou0911@gmail.com>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
for two paths:

- scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
  irq_work may run elsewhere; pass the local cpu explicitly.
- scx_rcu_cpu_stall() takes no CPU, recording the detector rather than
  the stalled one; add stalled_cpu to its signature and
  panic_on_rcu_stall(), threading it from print_cpu_stall() (current
  CPU) and print_other_cpu_stall() (first detected stalled CPU).

Add an exit_cpu parameter to handle_lockup() so callers pass the correct
CPU directly. Remove the now-unused scx_verror() macro.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       |  2 +-
 kernel/rcu/tree_stall.h     | 11 +++++++----
 kernel/sched/ext.c          | 14 ++++++++------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d05efcac794d..16bbf24089ca 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -259,7 +259,7 @@ void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
 bool scx_hardlockup(int cpu);
-bool scx_rcu_cpu_stall(void);
+bool scx_rcu_cpu_stall(int stalled_cpu);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
@@ -267,7 +267,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 static inline bool scx_hardlockup(int cpu) { return false; }
-static inline bool scx_rcu_cpu_stall(void) { return false; }
+static inline bool scx_rcu_cpu_stall(int stalled_cpu) { return false; }
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 82cada459e5d..fa83e273a648 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall();
+		panic_on_rcu_stall(raw_smp_processor_id());
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..172ac08e673d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
 early_initcall(check_cpu_stall_init);
 
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
-static void panic_on_rcu_stall(void)
+static void panic_on_rcu_stall(int stalled_cpu)
 {
 	static int cpu_stall;
 
@@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
 	 * Attempt to kick out the BPF scheduler if it's installed and defer
 	 * the panic to give the system a chance to recover.
 	 */
-	if (scx_rcu_cpu_stall())
+	if (scx_rcu_cpu_stall(stalled_cpu))
 		return;
 
 	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
@@ -631,6 +631,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
+	int first_stalled_cpu = -1;
 	unsigned long flags;
 	unsigned long gpa;
 	unsigned long j;
@@ -660,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 					print_cpu_stall_info(cpu);
+					if (first_stalled_cpu < 0)
+						first_stalled_cpu = cpu;
 					ndetected++;
 				}
 		}
@@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(first_stalled_cpu);
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
@@ -754,7 +757,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	nbcon_cpu_emergency_exit();
 
-	panic_on_rcu_stall();
+	panic_on_rcu_stall(smp_processor_id());
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 48c65ac8e230..8a0b1662a75a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5069,6 +5069,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 
 /**
  * handle_lockup - sched_ext common lockup handler
+ * @exit_cpu: CPU to record in exit_info; pass the stalled/hung CPU, not current
  * @fmt: format string
  *
  * Called on system stall or lockup condition and initiates abort of sched_ext
@@ -5078,7 +5079,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
  * resolve the lockup. %false if sched_ext is not enabled or abort was already
  * initiated by someone else.
  */
-static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
+static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
@@ -5094,7 +5095,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		ret = scx_verror(sch, fmt, args);
+		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
 		va_end(args);
 		return ret;
 	default:
@@ -5114,9 +5115,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
  * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
  * else already initiated abort.
  */
-bool scx_rcu_cpu_stall(void)
+bool scx_rcu_cpu_stall(int stalled_cpu)
 {
-	return handle_lockup("RCU CPU stall detected!");
+	return handle_lockup(stalled_cpu, "RCU CPU stall detected!");
 }
 
 /**
@@ -5131,7 +5132,8 @@ bool scx_rcu_cpu_stall(void)
  */
 void scx_softlockup(u32 dur_s)
 {
-	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
+	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
+			   smp_processor_id(), dur_s))
 		return;
 
 	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
@@ -5150,7 +5152,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
 {
 	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
 
-	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
+	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))
 		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
 				cpu);
 }
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b4f5dd28855e..2d04f27cf7c5 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1486,8 +1486,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
 	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
 #define scx_error(sch, fmt, args...)						\
 	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_verror(sch, fmt, args)						\
-	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
 
 /*
  * Return the rq currently locked from an scx callback, or NULL if no rq is
-- 
2.48.1

