Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240176F077;
	Fri, 16 Aug 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780999; cv=none; b=oHsQtGzi0J3NxXNEeUr4BezYhqkE6stgiqZRUWijylm2ykcAKJUYCXg8//ioulFTkNxG8L/FUakBxav159mBxoizmP+YTYEM8cYpd9qweRgOzgm099SxDsuXPS/Y80vUniUPtS+DuzSoh1x9SHlsSXaP8DtASgDTlcRxGxa4NoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780999; c=relaxed/simple;
	bh=Y5UbxV5Jyf6/dkj1ZZX1svOhGW+35AdNr+MhtBOj3OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIbNkPaM1cm+CpI9CZfMOrq6M182CHVTz/gDLmi3Vl4lH+JdGaaFAVvq9N7q91nleYPALYe1vucC+FOjR34jkX91gmRcCPILcybOS4jMbjMvaUx98knKWUdDsR5whQsQNQ5LWjZm11kreYgE+NARuCT39NCkvMhZRiIehPX5meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoNz66Pi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoNz66Pi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5281DC32782;
	Fri, 16 Aug 2024 04:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723780998;
	bh=Y5UbxV5Jyf6/dkj1ZZX1svOhGW+35AdNr+MhtBOj3OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoNz66PiS7K0T8geYloBMuLAx2vfNFADkyvNvDvWfxyKXzQUSqCpJpe/tAHIJmfqH
	 0pHQTcRQN+lz6HjE8Re7EP/iHlZOXtgKZYm+Cy90m6kZyrP/re47ZlWPbNzgM6pCb3
	 OXd79BomByhXb7zCO7SSW3JDpFMwhZKMa6Oz1DE8PvLHji3biqoWTXgJaHKTLTlLti
	 lzpNoEDEF7cfwvxR1xsmAw0iwDqWTRD9VS9i6gDoLmCJboljXQvCix2RysZ6veRdkp
	 DOb5x7l7d7jwGaGe1ZuO22VHhcRW2J1HVhEWwjZkSirl+GfkaYnyTR9zYFlCEYEad8
	 lPmABeGM6G6QQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH rcu 01/26] treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
Date: Fri, 16 Aug 2024 09:32:16 +0530
Message-Id: <20240816040241.17776-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

Context tracking state related symbols currently use a mix of the
CONTEXT_ (e.g. CONTEXT_KERNEL) and CT_SATE_ (e.g. CT_STATE_MASK) prefixes.

Clean up the naming and make the ctx_state enum use the CT_STATE_ prefix.

Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 arch/Kconfig                           |  2 +-
 arch/arm64/kernel/entry-common.c       |  2 +-
 arch/powerpc/include/asm/interrupt.h   |  6 +++---
 arch/powerpc/kernel/interrupt.c        |  6 +++---
 arch/powerpc/kernel/syscall.c          |  2 +-
 arch/x86/entry/common.c                |  2 +-
 include/linux/context_tracking.h       | 16 ++++++++--------
 include/linux/context_tracking_state.h | 20 ++++++++++----------
 include/linux/entry-common.h           |  2 +-
 kernel/context_tracking.c              | 12 ++++++------
 kernel/entry/common.c                  |  2 +-
 kernel/sched/core.c                    |  4 ++--
 12 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..4e2eaba9e305 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -862,7 +862,7 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	  Architecture neither relies on exception_enter()/exception_exit()
 	  nor on schedule_user(). Also preempt_schedule_notrace() and
 	  preempt_schedule_irq() can't be called in a preemptible section
-	  while context tracking is CONTEXT_USER. This feature reflects a sane
+	  while context tracking is CT_STATE_USER. This feature reflects a sane
 	  entry implementation where the following requirements are met on
 	  critical entry code, ie: before user_exit() or after user_enter():
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index b77a15955f28..3fcd9d080bf2 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -103,7 +103,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
 static __always_inline void __enter_from_user_mode(void)
 {
 	lockdep_hardirqs_off(CALLER_ADDR0);
-	CT_WARN_ON(ct_state() != CONTEXT_USER);
+	CT_WARN_ON(ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
 	trace_hardirqs_off_finish();
 	mte_disable_tco_entry(current);
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 2d6c886b40f4..23638d4e73ac 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -177,7 +177,7 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs)
 
 	if (user_mode(regs)) {
 		kuap_lock();
-		CT_WARN_ON(ct_state() != CONTEXT_USER);
+		CT_WARN_ON(ct_state() != CT_STATE_USER);
 		user_exit_irqoff();
 
 		account_cpu_user_entry();
@@ -189,8 +189,8 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs)
 		 * so avoid recursion.
 		 */
 		if (TRAP(regs) != INTERRUPT_PROGRAM)
-			CT_WARN_ON(ct_state() != CONTEXT_KERNEL &&
-				   ct_state() != CONTEXT_IDLE);
+			CT_WARN_ON(ct_state() != CT_STATE_KERNEL &&
+				   ct_state() != CT_STATE_IDLE);
 		INT_SOFT_MASK_BUG_ON(regs, is_implicit_soft_masked(regs));
 		INT_SOFT_MASK_BUG_ON(regs, arch_irq_disabled_regs(regs) &&
 					   search_kernel_restart_table(regs->nip));
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index eca293794a1e..af62ec974b97 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -266,7 +266,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	unsigned long ret = 0;
 	bool is_not_scv = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) || !scv;
 
-	CT_WARN_ON(ct_state() == CONTEXT_USER);
+	CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	kuap_assert_locked();
 
@@ -344,7 +344,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs)
 
 	BUG_ON(regs_is_unrecoverable(regs));
 	BUG_ON(arch_irq_disabled_regs(regs));
-	CT_WARN_ON(ct_state() == CONTEXT_USER);
+	CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	/*
 	 * We don't need to restore AMR on the way back to userspace for KUAP.
@@ -386,7 +386,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	if (!IS_ENABLED(CONFIG_PPC_BOOK3E_64) &&
 	    TRAP(regs) != INTERRUPT_PROGRAM &&
 	    TRAP(regs) != INTERRUPT_PERFMON)
-		CT_WARN_ON(ct_state() == CONTEXT_USER);
+		CT_WARN_ON(ct_state() == CT_STATE_USER);
 
 	kuap = kuap_get_and_assert_locked();
 
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index f6f868e817e6..be159ad4b77b 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -27,7 +27,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 
 	trace_hardirqs_off(); /* finish reconciling */
 
-	CT_WARN_ON(ct_state() == CONTEXT_KERNEL);
+	CT_WARN_ON(ct_state() == CT_STATE_KERNEL);
 	user_exit_irqoff();
 
 	BUG_ON(regs_is_unrecoverable(regs));
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 51cc9c7cb9bd..94941c5a10ac 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -150,7 +150,7 @@ early_param("ia32_emulation", ia32_emulation_override_cmdline);
 #endif
 
 /*
- * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
+ * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
  */
 static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 {
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 6e76b9dba00e..28fcfa184903 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -26,26 +26,26 @@ extern void user_exit_callable(void);
 static inline void user_enter(void)
 {
 	if (context_tracking_enabled())
-		ct_user_enter(CONTEXT_USER);
+		ct_user_enter(CT_STATE_USER);
 
 }
 static inline void user_exit(void)
 {
 	if (context_tracking_enabled())
-		ct_user_exit(CONTEXT_USER);
+		ct_user_exit(CT_STATE_USER);
 }
 
 /* Called with interrupts disabled.  */
 static __always_inline void user_enter_irqoff(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_enter(CONTEXT_USER);
+		__ct_user_enter(CT_STATE_USER);
 
 }
 static __always_inline void user_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_exit(CONTEXT_USER);
+		__ct_user_exit(CT_STATE_USER);
 }
 
 static inline enum ctx_state exception_enter(void)
@@ -57,7 +57,7 @@ static inline enum ctx_state exception_enter(void)
 		return 0;
 
 	prev_ctx = __ct_state();
-	if (prev_ctx != CONTEXT_KERNEL)
+	if (prev_ctx != CT_STATE_KERNEL)
 		ct_user_exit(prev_ctx);
 
 	return prev_ctx;
@@ -67,7 +67,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 {
 	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK) &&
 	    context_tracking_enabled()) {
-		if (prev_ctx != CONTEXT_KERNEL)
+		if (prev_ctx != CT_STATE_KERNEL)
 			ct_user_enter(prev_ctx);
 	}
 }
@@ -75,7 +75,7 @@ static inline void exception_exit(enum ctx_state prev_ctx)
 static __always_inline bool context_tracking_guest_enter(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_enter(CONTEXT_GUEST);
+		__ct_user_enter(CT_STATE_GUEST);
 
 	return context_tracking_enabled_this_cpu();
 }
@@ -83,7 +83,7 @@ static __always_inline bool context_tracking_guest_enter(void)
 static __always_inline void context_tracking_guest_exit(void)
 {
 	if (context_tracking_enabled())
-		__ct_user_exit(CONTEXT_GUEST);
+		__ct_user_exit(CT_STATE_GUEST);
 }
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index bbff5f7f8803..f1c53125edee 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -10,18 +10,18 @@
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
 enum ctx_state {
-	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
-	CONTEXT_KERNEL		= 0,
-	CONTEXT_IDLE		= 1,
-	CONTEXT_USER		= 2,
-	CONTEXT_GUEST		= 3,
-	CONTEXT_MAX		= 4,
+	CT_STATE_DISABLED	= -1,	/* returned by ct_state() if unknown */
+	CT_STATE_KERNEL		= 0,
+	CT_STATE_IDLE		= 1,
+	CT_STATE_USER		= 2,
+	CT_STATE_GUEST		= 3,
+	CT_STATE_MAX		= 4,
 };
 
 /* Even value for idle, else odd. */
-#define RCU_DYNTICKS_IDX CONTEXT_MAX
+#define RCU_DYNTICKS_IDX CT_STATE_MAX
 
-#define CT_STATE_MASK (CONTEXT_MAX - 1)
+#define CT_STATE_MASK (CT_STATE_MAX - 1)
 #define CT_DYNTICKS_MASK (~CT_STATE_MASK)
 
 struct context_tracking {
@@ -123,14 +123,14 @@ static inline bool context_tracking_enabled_this_cpu(void)
  *
  * Returns the current cpu's context tracking state if context tracking
  * is enabled.  If context tracking is disabled, returns
- * CONTEXT_DISABLED.  This should be used primarily for debugging.
+ * CT_STATE_DISABLED.  This should be used primarily for debugging.
  */
 static __always_inline int ct_state(void)
 {
 	int ret;
 
 	if (!context_tracking_enabled())
-		return CONTEXT_DISABLED;
+		return CT_STATE_DISABLED;
 
 	preempt_disable();
 	ret = __ct_state();
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d..1e50cdb83ae5 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -108,7 +108,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
 
 	instrumentation_begin();
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 24b1e1143260..4bb5751af994 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -317,7 +317,7 @@ void noinstr ct_nmi_enter(void)
 void noinstr ct_idle_enter(void)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
-	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CONTEXT_IDLE);
+	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CT_STATE_IDLE);
 }
 EXPORT_SYMBOL_GPL(ct_idle_enter);
 
@@ -335,7 +335,7 @@ void noinstr ct_idle_exit(void)
 	unsigned long flags;
 
 	raw_local_irq_save(flags);
-	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
+	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CT_STATE_IDLE);
 	raw_local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
@@ -485,7 +485,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * user_exit() or ct_irq_enter(). Let's remove RCU's dependency
 			 * on the tick.
 			 */
-			if (state == CONTEXT_USER) {
+			if (state == CT_STATE_USER) {
 				instrumentation_begin();
 				trace_user_enter(0);
 				vtime_user_enter(current);
@@ -621,7 +621,7 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * run a RCU read side critical section anytime.
 			 */
 			ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
-			if (state == CONTEXT_USER) {
+			if (state == CT_STATE_USER) {
 				instrumentation_begin();
 				vtime_user_exit(current);
 				trace_user_exit(0);
@@ -634,12 +634,12 @@ void noinstr __ct_user_exit(enum ctx_state state)
 			 * In this we case we don't care about any concurrency/ordering.
 			 */
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE))
-				raw_atomic_set(&ct->state, CONTEXT_KERNEL);
+				raw_atomic_set(&ct->state, CT_STATE_KERNEL);
 
 		} else {
 			if (!IS_ENABLED(CONFIG_CONTEXT_TRACKING_IDLE)) {
 				/* Tracking for vtime only, no concurrent RCU EQS accounting */
-				raw_atomic_set(&ct->state, CONTEXT_KERNEL);
+				raw_atomic_set(&ct->state, CT_STATE_KERNEL);
 			} else {
 				/*
 				 * Tracking for vtime and RCU EQS. Make sure we don't race
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc38588..5b6934e23c21 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -182,7 +182,7 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 	unsigned long nr = syscall_get_nr(current, regs);
 
-	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
+	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
 
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f655025607..93a845fe8449 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5762,7 +5762,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
-	SCHED_WARN_ON(ct_state() == CONTEXT_USER);
+	SCHED_WARN_ON(ct_state() == CT_STATE_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
@@ -6658,7 +6658,7 @@ asmlinkage __visible void __sched schedule_user(void)
 	 * we find a better solution.
 	 *
 	 * NB: There are buggy callers of this function.  Ideally we
-	 * should warn if prev_state != CONTEXT_USER, but that will trigger
+	 * should warn if prev_state != CT_STATE_USER, but that will trigger
 	 * too frequently to make sense yet.
 	 */
 	enum ctx_state prev_state = exception_enter();
-- 
2.40.1

