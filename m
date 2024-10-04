Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96651223AD0;
	Fri,  4 Oct 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066588; cv=none; b=gpqpTlfVO81UWwjLsj4PZ7SccHnwYjbUW45KVnNYuuQR2O005Yr5WfWmFT0GgIJx0ALgQvbASVR3oJkvIpO3/I77YKySRuJX+xdCR8IoJmFMxMKvpleZLOz8ZfmEoZtkVinX9yjp32M/PerkpYmG97C/gmWT4p+WXmT01eVO25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066588; c=relaxed/simple;
	bh=ikHBNH3P9BwXJMOmXaMmaaS7+6QfYQ9cwLr7P2AyU9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBbSPpJHF3PmcN25V3WpARt7gC0bMcRqugQmHHphg91moVG0cvhFXmbv1PNuj8wcSdgt9ZbFQZwqFU7zowuiiWSmRQ4mej7w+N9lV19/9XWpTYk1/cxrlVQX6eQPv1NqRYWdRUHHMLPX3rvZS0qew/o8g6krJlvpb5WaymXzuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eHkV0I+5; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eHkV0I+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728066584;
	bh=ikHBNH3P9BwXJMOmXaMmaaS7+6QfYQ9cwLr7P2AyU9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHkV0I+5RC66z5QFyzh00pg7N7PgyjwLrAUB6VMeftYGJL6kwPZRqdl0ti8ouphrH
	 I14+kHvc8kolxd/m7ucd4RQiL/fFaq6lgFpHLyY0tZZtkVqw8Yc/Us1lwkdOtbMJ+A
	 +c6BJsygMZsdTzQ/XpU6KOhosRIGVHjDR36Rhte6HFUrQRYQ++1eLD+aUcEkEHrL1M
	 wHLOTofBXA5xc5iVfm3fcoy8nJRNwZY9DwkoEnM/PQr/BKQ3WO18Ukq9EGMoyAFIj0
	 /y4FSCZYw0zya+CsNgmto5g0SQxLlmyJ3bsbufHcP+4Ba/1HCW7vAxFXMxjRUczEtu
	 ZB71z44OEFKgQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKxsh1hRszNDs;
	Fri,  4 Oct 2024 14:29:44 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [RFC PATCH v2 4/4] sched+mm: Use hazard pointers to track lazy active mm existence
Date: Fri,  4 Oct 2024 14:27:34 -0400
Message-Id: <20241004182734.1761555-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace lazy active mm existence tracking with hazard pointers. This
removes the following implementations and their associated config
options:

- MMU_LAZY_TLB_REFCOUNT
- MMU_LAZY_TLB_SHOOTDOWN
- This removes the call_rcu delayed mm drop for RT.

It leverages the fact that each CPU only ever have at most one single
lazy active mm. This makes it a very good fit for a hazard pointer
domain implemented with one hazard pointer slot per CPU.

* Benchmarks:

will-it-scale context_switch1_threads

nr threads (-t)     speedup
     1                -0.2%
     2                +0.4%
     3                +0.2%
     6                +0.6%
    12                +0.8%
    24                +3%
    48               +12%
    96               +21%
   192               +28%
   384                +4%
   768                -0.6%

Methodology: Each test is the average of 20 iterations. Use median
result of 3 test runs.

Test hardware:

CPU(s):                   384
  On-line CPU(s) list:    0-383
Vendor ID:                AuthenticAMD
  Model name:             AMD EPYC 9654 96-Core Processor
    CPU family:           25
    Model:                17
    Thread(s) per core:   2
    Core(s) per socket:   96
    Socket(s):            2
    Stepping:             1
    Frequency boost:      enabled
    CPU(s) scaling MHz:   100%
    CPU max MHz:          3709.0000
    CPU min MHz:          400.0000
    BogoMIPS:             4799.75

Memory: 768 GB ram.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: maged.michael@gmail.com
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev
---
 Documentation/mm/active_mm.rst       |  9 ++--
 arch/Kconfig                         | 32 -------------
 arch/powerpc/Kconfig                 |  1 -
 arch/powerpc/mm/book3s64/radix_tlb.c | 23 +--------
 include/linux/mm_types.h             |  3 --
 include/linux/sched/mm.h             | 71 +++++++++++-----------------
 kernel/exit.c                        |  4 +-
 kernel/fork.c                        | 47 +++++-------------
 kernel/sched/sched.h                 |  8 +---
 lib/Kconfig.debug                    | 10 ----
 10 files changed, 49 insertions(+), 159 deletions(-)

diff --git a/Documentation/mm/active_mm.rst b/Documentation/mm/active_mm.rst
index d096fc091e23..c225cac49c30 100644
--- a/Documentation/mm/active_mm.rst
+++ b/Documentation/mm/active_mm.rst
@@ -2,11 +2,10 @@
 Active MM
 =========
 
-Note, the mm_count refcount may no longer include the "lazy" users
-(running tasks with ->active_mm == mm && ->mm == NULL) on kernels
-with CONFIG_MMU_LAZY_TLB_REFCOUNT=n. Taking and releasing these lazy
-references must be done with mmgrab_lazy_tlb() and mmdrop_lazy_tlb()
-helpers, which abstract this config option.
+Note, the mm_count refcount no longer include the "lazy" users (running
+tasks with ->active_mm == mm && ->mm == NULL) Taking and releasing these
+lazy references must be done with mmgrab_lazy_tlb() and mmdrop_lazy_tlb()
+helpers, which are implemented with hazard pointers.
 
 ::
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..d4261935f8dc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -475,38 +475,6 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
-# Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
-# MMU_LAZY_TLB_REFCOUNT=n can improve the scalability of context switching
-# to/from kernel threads when the same mm is running on a lot of CPUs (a large
-# multi-threaded application), by reducing contention on the mm refcount.
-#
-# This can be disabled if the architecture ensures no CPUs are using an mm as a
-# "lazy tlb" beyond its final refcount (i.e., by the time __mmdrop frees the mm
-# or its kernel page tables). This could be arranged by arch_exit_mmap(), or
-# final exit(2) TLB flush, for example.
-#
-# To implement this, an arch *must*:
-# Ensure the _lazy_tlb variants of mmgrab/mmdrop are used when manipulating
-# the lazy tlb reference of a kthread's ->active_mm (non-arch code has been
-# converted already).
-config MMU_LAZY_TLB_REFCOUNT
-	def_bool y
-	depends on !MMU_LAZY_TLB_SHOOTDOWN
-
-# This option allows MMU_LAZY_TLB_REFCOUNT=n. It ensures no CPUs are using an
-# mm as a lazy tlb beyond its last reference count, by shooting down these
-# users before the mm is deallocated. __mmdrop() first IPIs all CPUs that may
-# be using the mm as a lazy tlb, so that they may switch themselves to using
-# init_mm for their active mm. mm_cpumask(mm) is used to determine which CPUs
-# may be using mm as a lazy tlb mm.
-#
-# To implement this, an arch *must*:
-# - At the time of the final mmdrop of the mm, ensure mm_cpumask(mm) contains
-#   at least all possible CPUs in which the mm is lazy.
-# - It must meet the requirements for MMU_LAZY_TLB_REFCOUNT=n (see above).
-config MMU_LAZY_TLB_SHOOTDOWN
-	bool
-
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..b1e25e75baab 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -291,7 +291,6 @@ config PPC
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
-	select MMU_LAZY_TLB_SHOOTDOWN		if PPC_BOOK3S_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE		if PPC64 || NOT_COHERENT_CACHE
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK	if PPC64
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 9e1f6558d026..ff0d4f28cf52 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1197,28 +1197,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
 	 * See the comment for radix in arch_exit_mmap().
 	 */
 	if (tlb->fullmm) {
-		if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
-			/*
-			 * Shootdown based lazy tlb mm refcounting means we
-			 * have to IPI everyone in the mm_cpumask anyway soon
-			 * when the mm goes away, so might as well do it as
-			 * part of the final flush now.
-			 *
-			 * If lazy shootdown was improved to reduce IPIs (e.g.,
-			 * by batching), then it may end up being better to use
-			 * tlbies here instead.
-			 */
-			preempt_disable();
-
-			smp_mb(); /* see radix__flush_tlb_mm */
-			exit_flush_lazy_tlbs(mm);
-			__flush_all_mm(mm, true);
-
-			preempt_enable();
-		} else {
-			__flush_all_mm(mm, true);
-		}
-
+		__flush_all_mm(mm, true);
 	} else if ( (psize = radix_get_mmu_psize(page_size)) == -1) {
 		if (!tlb->freed_tables)
 			radix__flush_tlb_mm(mm);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 485424979254..db5f13554485 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -975,9 +975,6 @@ struct mm_struct {
 		atomic_t tlb_flush_batched;
 #endif
 		struct uprobes_state uprobes_state;
-#ifdef CONFIG_PREEMPT_RT
-		struct rcu_head delayed_drop;
-#endif
 #ifdef CONFIG_HUGETLB_PAGE
 		atomic_long_t hugetlb_usage;
 #endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 91546493c43d..0fecd1a3311d 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -9,6 +9,10 @@
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
 #include <linux/sched/coredump.h>
+#include <linux/hp.h>
+
+/* Sched lazy mm hazard pointer domain. */
+DECLARE_PER_CPU(struct hp_slot, hp_domain_sched_lazy_mm);
 
 /*
  * Routines for handling mm_structs
@@ -55,61 +59,42 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
-#ifdef CONFIG_PREEMPT_RT
-/*
- * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
- * by far the least expensive way to do that.
- */
-static inline void __mmdrop_delayed(struct rcu_head *rhp)
+/* Helpers for lazy TLB mm refcounting */
+static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);
+	struct hp_ctx ctx;
 
-	__mmdrop(mm);
-}
+	/*
+	 * mmgrab_lazy_tlb must provide a full memory barrier, see the
+	 * membarrier comment finish_task_switch which relies on this.
+	 */
+	smp_mb();
 
-/*
- * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
- * kernels via RCU.
- */
-static inline void mmdrop_sched(struct mm_struct *mm)
-{
-	/* Provides a full memory barrier. See mmdrop() */
-	if (atomic_dec_and_test(&mm->mm_count))
-		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
-}
-#else
-static inline void mmdrop_sched(struct mm_struct *mm)
-{
-	mmdrop(mm);
-}
-#endif
+	/*
+	 * The caller guarantees existence of mm. Allocate a hazard
+	 * pointer to chain this existence guarantee to a hazard
+	 * pointer.
+	 */
+	ctx = hp_allocate(&hp_domain_sched_lazy_mm, mm);
 
-/* Helpers for lazy TLB mm refcounting */
-static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
-{
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
-		mmgrab(mm);
+	/* There is only a single lazy mm per CPU at any time. */
+	WARN_ON_ONCE(!hp_ctx_addr(ctx));
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
-		mmdrop(mm);
-	} else {
-		/*
-		 * mmdrop_lazy_tlb must provide a full memory barrier, see the
-		 * membarrier comment finish_task_switch which relies on this.
-		 */
-		smp_mb();
-	}
+	/*
+	 * mmdrop_lazy_tlb must provide a full memory barrier, see the
+	 * membarrier comment finish_task_switch which relies on this.
+	 */
+	smp_mb();
+	WRITE_ONCE(this_cpu_ptr(&hp_domain_sched_lazy_mm)->addr, NULL);
 }
 
 static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
-		mmdrop_sched(mm);
-	else
-		smp_mb(); /* see mmdrop_lazy_tlb() above */
+	smp_mb(); /* see mmdrop_lazy_tlb() above */
+	WRITE_ONCE(this_cpu_ptr(&hp_domain_sched_lazy_mm)->addr, NULL);
 }
 
 /**
diff --git a/kernel/exit.c b/kernel/exit.c
index 7430852a8571..cb4ace06c0f0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -545,8 +545,6 @@ static void exit_mm(void)
 	if (!mm)
 		return;
 	mmap_read_lock(mm);
-	mmgrab_lazy_tlb(mm);
-	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
 	/*
@@ -561,6 +559,8 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
+	mmgrab_lazy_tlb(mm);
+	BUG_ON(mm != current->active_mm);
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..42c652ec39b5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -149,6 +149,9 @@ DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
+/* Sched lazy mm hazard pointer domain. */
+DEFINE_PER_CPU(struct hp_slot, hp_domain_sched_lazy_mm);
+
 #ifdef CONFIG_PROVE_RCU
 int lockdep_tasklist_lock_is_held(void)
 {
@@ -855,50 +858,24 @@ static void do_shoot_lazy_tlb(void *arg)
 		WARN_ON_ONCE(current->mm);
 		current->active_mm = &init_mm;
 		switch_mm(mm, &init_mm, current);
+		WRITE_ONCE(this_cpu_ptr(&hp_domain_sched_lazy_mm)->addr, NULL);
 	}
 }
 
-static void cleanup_lazy_tlbs(struct mm_struct *mm)
+static void retire_lazy_mm_hp(int cpu, struct hp_slot *slot, void *addr)
 {
-	if (!IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
-		/*
-		 * In this case, lazy tlb mms are refounted and would not reach
-		 * __mmdrop until all CPUs have switched away and mmdrop()ed.
-		 */
-		return;
-	}
+	smp_call_function_single(cpu, do_shoot_lazy_tlb, addr, 1);
+	smp_call_function_single(cpu, do_check_lazy_tlb, addr, 1);
+}
 
+static void cleanup_lazy_tlbs(struct mm_struct *mm)
+{
 	/*
-	 * Lazy mm shootdown does not refcount "lazy tlb mm" usage, rather it
-	 * requires lazy mm users to switch to another mm when the refcount
+	 * Require lazy mm users to switch to another mm when the refcount
 	 * drops to zero, before the mm is freed. This requires IPIs here to
 	 * switch kernel threads to init_mm.
-	 *
-	 * archs that use IPIs to flush TLBs can piggy-back that lazy tlb mm
-	 * switch with the final userspace teardown TLB flush which leaves the
-	 * mm lazy on this CPU but no others, reducing the need for additional
-	 * IPIs here. There are cases where a final IPI is still required here,
-	 * such as the final mmdrop being performed on a different CPU than the
-	 * one exiting, or kernel threads using the mm when userspace exits.
-	 *
-	 * IPI overheads have not found to be expensive, but they could be
-	 * reduced in a number of possible ways, for example (roughly
-	 * increasing order of complexity):
-	 * - The last lazy reference created by exit_mm() could instead switch
-	 *   to init_mm, however it's probable this will run on the same CPU
-	 *   immediately afterwards, so this may not reduce IPIs much.
-	 * - A batch of mms requiring IPIs could be gathered and freed at once.
-	 * - CPUs store active_mm where it can be remotely checked without a
-	 *   lock, to filter out false-positives in the cpumask.
-	 * - After mm_users or mm_count reaches zero, switching away from the
-	 *   mm could clear mm_cpumask to reduce some IPIs, perhaps together
-	 *   with some batching or delaying of the final IPIs.
-	 * - A delayed freeing and RCU-like quiescing sequence based on mm
-	 *   switching to avoid IPIs completely.
 	 */
-	on_each_cpu_mask(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1);
-	if (IS_ENABLED(CONFIG_DEBUG_VM_SHOOT_LAZIES))
-		on_each_cpu(do_check_lazy_tlb, (void *)mm, 1);
+	hp_scan(&hp_domain_sched_lazy_mm, mm, retire_lazy_mm_hp);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..d883c2aa3518 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3527,12 +3527,8 @@ static inline void switch_mm_cid(struct rq *rq,
 	if (!next->mm) {                                // to kernel
 		/*
 		 * user -> kernel transition does not guarantee a barrier, but
-		 * we can use the fact that it performs an atomic operation in
-		 * mmgrab().
-		 */
-		if (prev->mm)                           // from user
-			smp_mb__after_mmgrab();
-		/*
+		 * we can use the fact that mmgrab() has a full barrier.
+		 *
 		 * kernel -> kernel transition does not change rq->curr->mm
 		 * state. It stays NULL.
 		 */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..1cb9dab361c9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -803,16 +803,6 @@ config DEBUG_VM
 
 	  If unsure, say N.
 
-config DEBUG_VM_SHOOT_LAZIES
-	bool "Debug MMU_LAZY_TLB_SHOOTDOWN implementation"
-	depends on DEBUG_VM
-	depends on MMU_LAZY_TLB_SHOOTDOWN
-	help
-	  Enable additional IPIs that ensure lazy tlb mm references are removed
-	  before the mm is freed.
-
-	  If unsure, say N.
-
 config DEBUG_VM_MAPLE_TREE
 	bool "Debug VM maple trees"
 	depends on DEBUG_VM
-- 
2.39.2

