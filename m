Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90032374E6A;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=TzY/12pSdPvuoc6oJaCluu8gRIaG4Io3aSiO9qEUEtBgUVgVsO0STHfDWgIAD4x1eQMFydxczq2DRMygbqJPWREXLPdQUPEwnhG4T7FjmHcQyvFKbCdNKEnj54rR9ZeCvJ/t/wHWpIkPXlRbmaICyJM3JCQIYSJ6oL3VL0MifEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=6aDUX6LAwslTG36vDPsQwQC0nclinqh+8IovqdcwnQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iPo/ZxOLi06D91s5Qy859uEEwk5LC5dp3R3Ny9O5Cb8Tbh9KXTLR/tO4C5FjrkmU6NqU7kCf060KgzSqHhPpoPfz+qgcF764iEUdw2NTsXoL4Zen5LwE5ZogfQTP24yFUAJdEZVGPeHecBiXpLGQRqEXXi9qabJyDQciv+mTyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHo3J1EA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHo3J1EA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B116C116C6;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=6aDUX6LAwslTG36vDPsQwQC0nclinqh+8IovqdcwnQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHo3J1EA4cRmCP681Jhz4q7tJ9D2I3FeVNGeUxIvDUIGT4iVsB5xq8I1hOBRiDXeT
	 CMncRhVM8l72ag3xd485r+CRhyWiS6PfFLhdxwlD1ZPNWAeTsgd6EuLeJGOqPLCzoO
	 B3dec7pN/jxQcolWQSeW95EGOPZVeRfwuUfMSVQhazffwp6/VVZJOXM3H8XP+Z0KSq
	 5SG2Spuj3ddzhDti2t/gnCzTVD21yS9WwgFEtBS2wifcirgFeG4hXSVtLYfJZDX4QS
	 x2FIOkdSFoTdsIIlcBVRNrK1/g4RQfcZ4oqbmrVqsgMC07Cm/wh3kIFktNCKwFyq2R
	 +Wwr8ifcLm2OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E0D16CE0D66; Tue,  3 Mar 2026 15:50:38 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 01/11] rcutorture: Add a textbook-style trivial preemptible RCU
Date: Tue,  3 Mar 2026 15:50:27 -0800
Message-Id: <20260303235037.1967017-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a trivial textbook implementation of preemptible RCU
to rcutorture ("torture_type=trivial-preempt"), similar in spirit to the
existing "torture_type=trivial" textbook implementation of non-preemptible
RCU.  Neither trivial RCU implementation has any value for production use,
and are intended only to keep Paul honest in his introductory writings
and presentations.

[ paulmck: Apply kernel test robot feedback. ]
---
 include/linux/sched.h                         |  4 ++
 kernel/rcu/Kconfig.debug                      | 11 ++++
 kernel/rcu/rcu.h                              |  4 ++
 kernel/rcu/rcutorture.c                       | 57 ++++++++++++++++++-
 kernel/rcu/update.c                           | 22 +++++++
 .../rcutorture/configs/rcu/TRIVIAL-PREEMPT    | 12 ++++
 .../configs/rcu/TRIVIAL-PREEMPT.boot          |  3 +
 7 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 074ad4ef3d813..fc2cb6804eabe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -948,6 +948,10 @@ struct task_struct {
 	struct srcu_ctr __percpu	*trc_reader_scp;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
+#ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+	int				rcu_trivial_preempt_nesting;
+#endif /* #ifdef CONFIG_TRIVIAL_PREEMPT_RCU */
+
 	struct sched_info		sched_info;
 
 	struct list_head		tasks;
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 625d75392647b..e078e988773d6 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -228,4 +228,15 @@ config RCU_DYNTICKS_TORTURE
 
 	  This has no value for production and is only for testing.
 
+config TRIVIAL_PREEMPT_RCU
+	bool "Textbook trivial preemptible RCU in rcutorture"
+	depends on RCU_EXPERT && RCU_TORTURE_TEST
+	default n
+	help
+	  This option enables a textbook preemptible RCU that is
+	  implemented in rcutorture.  Its sole purpose is to validate
+	  code used in books, papers, and presentations.
+
+	  This has no value for production and is only for testing.
+
 endmenu # "RCU Debugging"
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index dc5d614b372c1..37e7a8a9e375d 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -682,4 +682,8 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v);
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
 #endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
+#ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+void synchronize_rcu_trivial_preempt(void);
+#endif // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8a9282a0245cc..3c272413666b2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1061,6 +1061,61 @@ static struct rcu_torture_ops trivial_ops = {
 	.name		= "trivial"
 };
 
+#ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
+/*
+ * Definitions for trivial CONFIG_PREEMPT=y torture testing.  This
+ * implementation does not work well with large numbers of tasks or with
+ * long-term preemption.  Either or both get you RCU CPU stall warnings.
+ */
+
+static void rcu_sync_torture_init_trivial_preempt(void)
+{
+	rcu_sync_torture_init();
+	if (WARN_ONCE(onoff_interval || shuffle_interval, "%s: Non-zero onoff_interval (%d) or shuffle_interval (%d) breaks trivial RCU, resetting to zero", __func__, onoff_interval, shuffle_interval)) {
+		onoff_interval = 0;
+		shuffle_interval = 0;
+	}
+}
+
+static int rcu_torture_read_lock_trivial_preempt(void)
+{
+	struct task_struct *t = current;
+
+	WRITE_ONCE(t->rcu_trivial_preempt_nesting, t->rcu_trivial_preempt_nesting + 1);
+	smp_mb();
+	return 0;
+}
+
+static void rcu_torture_read_unlock_trivial_preempt(int idx)
+{
+	struct task_struct *t = current;
+
+	smp_store_release(&t->rcu_trivial_preempt_nesting, t->rcu_trivial_preempt_nesting - 1);
+}
+
+static struct rcu_torture_ops trivial_preempt_ops = {
+	.ttype		= RCU_TRIVIAL_FLAVOR,
+	.init		= rcu_sync_torture_init_trivial_preempt,
+	.readlock	= rcu_torture_read_lock_trivial_preempt,
+	.read_delay	= rcu_read_delay,  // just reuse rcu's version.
+	.readunlock	= rcu_torture_read_unlock_trivial_preempt,
+	.readlock_held	= torture_readlock_not_held,
+	.get_gp_seq	= rcu_no_completed,
+	.sync		= synchronize_rcu_trivial_preempt,
+	.exp_sync	= synchronize_rcu_trivial_preempt,
+	.irq_capable	= 0, // In theory it should be, but let's keep it trivial.
+	.name		= "trivial-preempt"
+};
+
+#define TRIVIAL_PREEMPT_OPS &trivial_preempt_ops,
+
+#else // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
+#define TRIVIAL_PREEMPT_OPS
+
+#endif // #else // #ifdef CONFIG_TRIVIAL_PREEMPT_RCU
+
 #ifdef CONFIG_TASKS_RCU
 
 /*
@@ -4449,7 +4504,7 @@ rcu_torture_init(void)
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
 		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
-		&trivial_ops,
+		&trivial_ops, TRIVIAL_PREEMPT_OPS
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index d98a5c38e19c5..b62735a678842 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -538,6 +538,28 @@ long torture_sched_setaffinity(pid_t pid, const struct cpumask *in_mask, bool do
 EXPORT_SYMBOL_GPL(torture_sched_setaffinity);
 #endif
 
+#if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
+// Trivial and stupid grace-period wait.  Defined here so that lockdep
+// kernels can find tasklist_lock.
+void synchronize_rcu_trivial_preempt(void)
+{
+	struct task_struct *g;
+	struct task_struct *t;
+
+	smp_mb(); // Order prior accesses before grace-period start.
+	rcu_read_lock(); // Protect task list.
+	for_each_process_thread(g, t) {
+		if (t == current)
+			continue;  // Don't deadlock on ourselves!
+		// Order later rcu_read_lock() on other tasks after QS.
+		while (smp_load_acquire(&t->rcu_trivial_preempt_nesting))
+			continue;
+	}
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_trivial_preempt);
+#endif // #if IS_ENABLED(CONFIG_TRIVIAL_PREEMPT_RCU)
+
 int rcu_cpu_stall_notifiers __read_mostly; // !0 = provide stall notifiers (rarely useful)
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_notifiers);
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
new file mode 100644
index 0000000000000..8230b14bfe680
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT
@@ -0,0 +1,12 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=8
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_TRIVIAL_PREEMPT_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot
new file mode 100644
index 0000000000000..299cd3a12df6c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL-PREEMPT.boot
@@ -0,0 +1,3 @@
+rcutorture.torture_type=trivial-preempt
+rcutorture.onoff_interval=0
+rcutorture.shuffle_interval=0
-- 
2.40.1

