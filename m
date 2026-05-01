Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780814A619
	for <rcu@vger.kernel.org>; Fri,  1 May 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641396; cv=none; b=lsfiq3KfHtNsM91We17mqFx/14h9dq/9fhJxxhG4xTwpJlWsHCHol26bXTNQFPw7kHlMqu5M+HQ4UAt5s82S+ylhS5XYfBsl6IYh2pSbbWJD7AOv13pnQTVhhqULMARkC0YL5ucWUL/OcjlBDXxVrFvJmny54jsyDYirBT7NKeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641396; c=relaxed/simple;
	bh=+yMsvqNuTCXfoMu2+1Pv6YNXX9sHTAEKX1fyl3k3IIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMB/tP2/BHX3b7uvwZwI5NAe8laVmOea6JcivAsPF44x2pDwD3ilnlpVmqWKj6gpqcgBQ05A0MIFV8OLYhYrw+zhSMgwA1M1dUj6jFHtBzBO6HNX+IgUyl69ylzJVVgq5GR3FXVcj58sgbKsSxvPyjd5t28bZw3SIe9duf2KI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqj67SH6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqj67SH6"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6e2355739dso743410a12.2
        for <rcu@vger.kernel.org>; Fri, 01 May 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641394; x=1778246194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yZEJkZaBicNCwiNqFGstA5XafzgCy3rU/S3i0HrvL0=;
        b=Lqj67SH6mOjikBOson40P/cjw2wAU9UuoR4SAaySp2dBBgR5/npVzI+HznD4Oep2Xn
         a8wke0w8LOIVVTHjI3z2H82qeYfcCN44KgskGoHqoJ7VkHsZQ2kG4R2UCu8dosn22jin
         H0oqQLWvpRuWaeYLJRUSdUxhw4vCzmtIlMB3ogffHS7Nm7pSkSN+rt1xicH8w3GR4xTC
         QKVftxuK3Faq9pYDQcrnkREfwjvqNymxEgkoHMpL/6ILiC/1R2URvCBWWQ5EoFstwvVJ
         UYD/LqCbMYJdpUwL+aMaXxTY48eUqRQjKzZme+PEGg/U8MhryADV6SZ55y9qsMdzCq2b
         hn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641394; x=1778246194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yZEJkZaBicNCwiNqFGstA5XafzgCy3rU/S3i0HrvL0=;
        b=DNQ7t6E0P/Gx8gWlbM7d3zoubqY95a2K+vXSMDqBWwUtoIqQV9gKUEIDXSwCkngFzW
         Fp0cnZPCWb8R7Sru6ROMrm59vC0Vt1NStgDlDWYM74Hk8kPrewu4mLsYhkcEpZcqDez5
         0y012+q992jvpr19pKETdoXUTcbkA4NVsYudnEheZwDmKntU67T36/Pb4Q74z8QBO/DA
         Vg+dmRQklOPf+Mvue2fwQb0r6RMyEtN6UnkRUtFJcF9Ki/0VzpjvgrvhGjoY1M06dYS3
         bZecXROjxAkwGSycMCGZpLi9yPaJ82+6wbnhRql/n5zJK0mqm+zLFVKrJg+7kRSAug+x
         6jpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PkrHsxBQmujcJixG8DZbbUlbpfVSxwp9oZQbtfdeAhllK6yXCJgQLFFBJCkr2eSUssOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUBeNj4ooL0RrPS2anYbxfqw21oC3mhzQKcGbI3RA5C7GN6jbM
	LOPmMR+CBFC5cJEzZRAP96T8fLEak7PCaoApISybErdbH6/kmjGz+wg4
X-Gm-Gg: AeBDiesaxeG2AFQBcNXfW3Zz7JPm5b12hdLU+fje5TnfjJJLTQB0TsXrs+i9ZXvLn0c
	yvs8VKsiAO+2kI6bBkHrbfue4SVDfJwzSyHzz41a8T/wXef35amLyE9loZfZQVLp/ngHpJIJEZ/
	7Rdt/t/zqqu7MUk6YCyPZfl0jLeDXZmxreqwYPA5d4GpEhY5luT+3id+6JI30Ol6xS6zrAOLJ07
	405MskqmIYIdu/T+biDCeDMsQu7jZtgSUHNlxKKXqEOP/9NTOJF4fMbR2W8SEeZ2jMOGnIsFmeP
	8fS18E6VPj5Qn0oA2iqKladWcBrUXVMwFfxIoKFiBF/356d2beO7mUdHxamVZ6AdhNi1KSH46su
	+OabSqNGUUkJZv1UJBduuCjRNq6f6H0yx17FpwKjD+j3rI7Zfq5swS8JIac4x+udBLP2G4p3vVx
	rhgxIrRglyL1cu6jpTkNQRE/3rGCVptddFAaMB/Vn2nSeeOdYqVCywH78LuH/2wKc=
X-Received: by 2002:a17:902:ef0e:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b9a2549738mr52431585ad.39.1777641394045;
        Fri, 01 May 2026 06:16:34 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:57df:16f5:b7ab:5d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f62sm22438005ad.70.2026.05.01.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:16:33 -0700 (PDT)
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
Subject: [PATCH 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Date: Fri,  1 May 2026 21:14:57 +0800
Message-ID: <20260501131521.161852-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501131521.161852-1-yphbchou0911@gmail.com>
References: <20260501131521.161852-1-yphbchou0911@gmail.com>
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
index 82cada459e5d..2c9a99a9b68e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
 
 		nbcon_cpu_emergency_exit();
 
-		panic_on_rcu_stall();
+		panic_on_rcu_stall(smp_processor_id());
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

