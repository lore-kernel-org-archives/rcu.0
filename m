Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202CCC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6B72076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974949;
	bh=B7YxMRKC9mUlSSZM4ZF1ZgO/ByVG7fjMGfUmKmVR30k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kc4eXfK1cgFCT3NSev8OTXrRlV6rWYfA2jpqHmVL8dLkW4y8Es+O6peI12h6Ee0fj
	 mbrYg7i6NCG+IZI1uzT0Pg+xVKtNu+DjMfYFG69Zyf7n9V5/pDjciuu0OIrRAR/aC6
	 XuwNwwYYGPozG1ea2Q3VMpWaUfe+9B29zHojrs2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416608AbgDOSW0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441374AbgDOSTu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9230F21707;
        Wed, 15 Apr 2020 18:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974788;
        bh=B7YxMRKC9mUlSSZM4ZF1ZgO/ByVG7fjMGfUmKmVR30k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXzlZmMeIT6CbJ1V33g9Kw6lE93kgq8EOlPy/4Klfub2BXIqRiWL6v3OOLg7+WrRf
         LqTqmffrBiYUWLUG92SaDhke06qcLf537NhAJxuJrV32f8f9dCeCbFYOn2klQ8+hcK
         r3AlRz+OEkwnVkYLR9zGpPY51t8POZ3tlMMC2obs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v4 tip/core/rcu 15/38] rcu-tasks: Add an RCU Tasks Trace to simplify protection of tracing hooks
Date:   Wed, 15 Apr 2020 11:19:18 -0700
Message-Id: <20200415181941.11653-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because RCU does not watch exception early-entry/late-exit, idle-loop,
or CPU-hotplug execution, protection of tracing and BPF operations is
needlessly complicated.  This commit therefore adds a variant of
Tasks RCU that:

o	Has explicit read-side markers to allow finite grace periods in
	the face of in-kernel loops for PREEMPT=n builds.  These markers
	are rcu_read_lock_trace() and rcu_read_unlock_trace().

o	Protects code in the idle loop, exception entry/exit, and
	CPU-hotplug code paths.  In this respect, RCU-tasks trace is
	similar to SRCU, but with lighter-weight readers.

o	Avoids expensive read-side instruction, having overhead similar
	to that of Preemptible RCU.

There are of course downsides:

o	The grace-period code can send IPIs to CPUs, even when those
	CPUs are in the idle loop or in nohz_full userspace.  This is
	mitigated by later commits.

o	It is necessary to scan the full tasklist, much as for Tasks RCU.

o	There is a single callback queue guarded by a single lock,
	again, much as for Tasks RCU.  However, those early use cases
	that request multiple grace periods in quick succession are
	expected to do so from a single task, which makes the single
	lock almost irrelevant.  If needed, multiple callback queues
	can be provided using any number of schemes.

Perhaps most important, this variant of RCU does not affect the vanilla
flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
readers can operate from idle, offline, and exception entry/exit in no
way enables rcu_preempt and rcu_sched readers to do so.

The memory ordering was outlined here:
https://lore.kernel.org/lkml/20200319034030.GX3199@paulmck-ThinkPad-P72/

This effort benefited greatly from off-list discussions of BPF
requirements with Alexei Starovoitov and Andrii Nakryiko.  At least
some of the on-list discussions are captured in the Link: tags below.
In addition, KCSAN was quite helpful in finding some early bugs.

Link: https://lore.kernel.org/lkml/20200219150744.428764577@infradead.org/
Link: https://lore.kernel.org/lkml/87mu8p797b.fsf@nanos.tec.linutronix.de/
Link: https://lore.kernel.org/lkml/20200225221305.605144982@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Apply feedback from Steve Rostedt and Joel Fernandes. ]
[ paulmck: Decrement trc_n_readers_need_end upon IPI failure. ]
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/rcupdate_trace.h |  84 ++++++++++
 include/linux/sched.h          |   8 +
 init/init_task.c               |   4 +
 kernel/fork.c                  |   4 +
 kernel/rcu/Kconfig             |  11 +-
 kernel/rcu/tasks.h             | 357 ++++++++++++++++++++++++++++++++++++++++-
 6 files changed, 463 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/rcupdate_trace.h

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
new file mode 100644
index 0000000..ed97e10
--- /dev/null
+++ b/include/linux/rcupdate_trace.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Read-Copy Update mechanism for mutual exclusion, adapted for tracing.
+ *
+ * Copyright (C) 2020 Paul E. McKenney.
+ */
+
+#ifndef __LINUX_RCUPDATE_TRACE_H
+#define __LINUX_RCUPDATE_TRACE_H
+
+#include <linux/sched.h>
+#include <linux/rcupdate.h>
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+
+extern struct lockdep_map rcu_trace_lock_map;
+
+static inline int rcu_read_lock_trace_held(void)
+{
+	return lock_is_held(&rcu_trace_lock_map);
+}
+
+#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+
+static inline int rcu_read_lock_trace_held(void)
+{
+	return 1;
+}
+
+#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+
+void rcu_read_unlock_trace_special(struct task_struct *t);
+
+/**
+ * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
+ *
+ * When synchronize_rcu_trace() is invoked by one task, then that task
+ * is guaranteed to block until all other tasks exit their read-side
+ * critical sections.  Similarly, if call_rcu_trace() is invoked on one
+ * task while other tasks are within RCU read-side critical sections,
+ * invocation of the corresponding RCU callback is deferred until after
+ * the all the other tasks exit their critical sections.
+ *
+ * For more details, please see the documentation for rcu_read_lock().
+ */
+static inline void rcu_read_lock_trace(void)
+{
+	struct task_struct *t = current;
+
+	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
+	rcu_lock_acquire(&rcu_trace_lock_map);
+}
+
+/**
+ * rcu_read_unlock_trace - mark end of RCU-trace read-side critical section
+ *
+ * Pairs with a preceding call to rcu_read_lock_trace(), and nesting is
+ * allowed.  Invoking a rcu_read_unlock_trace() when there is no matching
+ * rcu_read_lock_trace() is verboten, and will result in lockdep complaints.
+ *
+ * For more details, please see the documentation for rcu_read_unlock().
+ */
+static inline void rcu_read_unlock_trace(void)
+{
+	int nesting;
+	struct task_struct *t = current;
+
+	rcu_lock_release(&rcu_trace_lock_map);
+	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
+	WRITE_ONCE(t->trc_reader_nesting, nesting);
+	if (likely(!READ_ONCE(t->trc_reader_need_end)) || nesting)
+		return;  // We assume shallow reader nesting.
+	rcu_read_unlock_trace_special(t);
+}
+
+void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
+void synchronize_rcu_tasks_trace(void);
+void rcu_barrier_tasks_trace(void);
+
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
+
+#endif /* __LINUX_RCUPDATE_TRACE_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a4b727f5..864f60e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -724,6 +724,14 @@ struct task_struct {
 	struct list_head		rcu_tasks_holdout_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+	int				trc_reader_nesting;
+	int				trc_ipi_to_cpu;
+	bool				trc_reader_need_end;
+	bool				trc_reader_checked;
+	struct list_head		trc_holdout_list;
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
+
 	struct sched_info		sched_info;
 
 	struct list_head		tasks;
diff --git a/init/init_task.c b/init/init_task.c
index bd403ed..e8b3740 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -141,6 +141,10 @@ struct task_struct init_task
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
 #endif
+#ifdef CONFIG_TASKS_TRACE_RCU
+	.trc_reader_nesting = 0,
+	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
+#endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 4385f3d..1eff609 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1683,6 +1683,10 @@ static inline void rcu_copy_process(struct task_struct *p)
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
 #endif /* #ifdef CONFIG_TASKS_RCU */
+#ifdef CONFIG_TASKS_TRACE_RCU
+	p->trc_reader_nesting = 0;
+	INIT_LIST_HEAD(&p->trc_holdout_list);
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
 struct pid *pidfd_pid(const struct file *file)
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 6ee6372..cb1d18e 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -71,7 +71,7 @@ config TREE_SRCU
 	  This option selects the full-fledged version of SRCU.
 
 config TASKS_RCU_GENERIC
-	def_bool TASKS_RCU || TASKS_RUDE_RCU
+	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
 	select SRCU
 	help
 	  This option enables generic infrastructure code supporting
@@ -93,6 +93,15 @@ config TASKS_RUDE_RCU
 	  switches on all online CPUs, including idle ones, so use
 	  with caution.
 
+config TASKS_TRACE_RCU
+	def_bool 0
+	help
+	  This option enables a task-based RCU implementation that uses
+	  explicit rcu_read_lock_trace() read-side markers, and allows
+	  these readers to appear in the idle loop as well as on the CPU
+	  hotplug code paths.  It can force IPIs on online CPUs, including
+	  idle ones, so use with caution.
+
 config RCU_STALL_COMMON
 	def_bool TREE_RCU
 	help
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d8b09d5..a5ed7e2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -181,12 +181,17 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 	preempt_enable();
 }
 
+static void exit_tasks_rcu_finish_trace(struct task_struct *t);
+
 /* Do the srcu_read_unlock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
+	struct task_struct *t = current;
+
 	preempt_disable();
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
+	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
 	preempt_enable();
+	exit_tasks_rcu_finish_trace(t);
 }
 
 #ifndef CONFIG_TINY_RCU
@@ -196,15 +201,19 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
  */
 static void __init rcu_tasks_bootup_oddness(void)
 {
-#ifdef CONFIG_TASKS_RCU
+#if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
 	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
 		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
-	else
-		pr_info("\tTasks RCU enabled.\n");
+#endif /* #ifdef CONFIG_TASKS_RCU */
+#ifdef CONFIG_TASKS_RCU
+	pr_info("\tTrampoline variant of Tasks RCU enabled.\n");
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_RUDE_RCU
 	pr_info("\tRude variant of Tasks RCU enabled.\n");
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
+#ifdef CONFIG_TASKS_TRACE_RCU
+	pr_info("\tTracing variant of Tasks RCU enabled.\n");
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
 #endif /* #ifndef CONFIG_TINY_RCU */
@@ -569,3 +578,343 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
+
+////////////////////////////////////////////////////////////////////////
+//
+// Tracing variant of Tasks RCU.  This variant is designed to be used
+// to protect tracing hooks, including those of BPF.  This variant
+// therefore:
+//
+// 1.	Has explicit read-side markers to allow finite grace periods
+//	in the face of in-kernel loops for PREEMPT=n builds.
+//
+// 2.	Protects code in the idle loop, exception entry/exit, and
+//	CPU-hotplug code paths, similar to the capabilities of SRCU.
+//
+// 3.	Avoids expensive read-side instruction, having overhead similar
+//	to that of Preemptible RCU.
+//
+// There are of course downsides.  The grace-period code can send IPIs to
+// CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
+// It is necessary to scan the full tasklist, much as for Tasks RCU.  There
+// is a single callback queue guarded by a single lock, again, much as for
+// Tasks RCU.  If needed, these downsides can be at least partially remedied.
+//
+// Perhaps most important, this variant of RCU does not affect the vanilla
+// flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
+// readers can operate from idle, offline, and exception entry/exit in no
+// way allows rcu_preempt and rcu_sched readers to also do so.
+
+// The lockdep state must be outside of #ifdef to be useful.
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key rcu_lock_trace_key;
+struct lockdep_map rcu_trace_lock_map =
+	STATIC_LOCKDEP_MAP_INIT("rcu_read_lock_trace", &rcu_lock_trace_key);
+EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
+#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+
+atomic_t trc_n_readers_need_end;	// Number of waited-for readers.
+DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
+
+// Record outstanding IPIs to each CPU.  No point in sending two...
+static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
+
+/* If we are the last reader, wake up the grace-period kthread. */
+void rcu_read_unlock_trace_special(struct task_struct *t)
+{
+	WRITE_ONCE(t->trc_reader_need_end, false);
+	if (atomic_dec_and_test(&trc_n_readers_need_end))
+		wake_up(&trc_wait);
+}
+EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
+
+/* Add a task to the holdout list, if it is not already on the list. */
+static void trc_add_holdout(struct task_struct *t, struct list_head *bhp)
+{
+	if (list_empty(&t->trc_holdout_list)) {
+		get_task_struct(t);
+		list_add(&t->trc_holdout_list, bhp);
+	}
+}
+
+/* Remove a task from the holdout list, if it is in fact present. */
+static void trc_del_holdout(struct task_struct *t)
+{
+	if (!list_empty(&t->trc_holdout_list)) {
+		list_del_init(&t->trc_holdout_list);
+		put_task_struct(t);
+	}
+}
+
+/* IPI handler to check task state. */
+static void trc_read_check_handler(void *t_in)
+{
+	struct task_struct *t = current;
+	struct task_struct *texp = t_in;
+
+	// If the task is no longer running on this CPU, leave.
+	if (unlikely(texp != t)) {
+		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
+			wake_up(&trc_wait);
+		goto reset_ipi; // Already on holdout list, so will check later.
+	}
+
+	// If the task is not in a read-side critical section, and
+	// if this is the last reader, awaken the grace-period kthread.
+	if (likely(!t->trc_reader_nesting)) {
+		if (WARN_ON_ONCE(atomic_dec_and_test(&trc_n_readers_need_end)))
+			wake_up(&trc_wait);
+		// Mark as checked after decrement to avoid false
+		// positives on the above WARN_ON_ONCE().
+		WRITE_ONCE(t->trc_reader_checked, true);
+		goto reset_ipi;
+	}
+	WRITE_ONCE(t->trc_reader_checked, true);
+
+	// Get here if the task is in a read-side critical section.  Set
+	// its state so that it will awaken the grace-period kthread upon
+	// exit from that critical section.
+	WARN_ON_ONCE(t->trc_reader_need_end);
+	WRITE_ONCE(t->trc_reader_need_end, true);
+
+reset_ipi:
+	// Allow future IPIs to be sent on CPU and for task.
+	// Also order this IPI handler against any later manipulations of
+	// the intended task.
+	smp_store_release(&per_cpu(trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
+	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
+}
+
+/* Callback function for scheduler to check locked-down task.  */
+static bool trc_inspect_reader(struct task_struct *t, void *arg)
+{
+	if (task_curr(t))
+		return false;  // It is running, so decline to inspect it.
+
+	// Mark as checked.  Because this is called from the grace-period
+	// kthread, also remove the task from the holdout list.
+	t->trc_reader_checked = true;
+	trc_del_holdout(t);
+
+	// If the task is in a read-side critical section, set up its
+	// its state so that it will awaken the grace-period kthread upon
+	// exit from that critical section.
+	if (unlikely(t->trc_reader_nesting)) {
+		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+		WARN_ON_ONCE(t->trc_reader_need_end);
+		WRITE_ONCE(t->trc_reader_need_end, true);
+	}
+	return true;
+}
+
+/* Attempt to extract the state for the specified task. */
+static void trc_wait_for_one_reader(struct task_struct *t,
+				    struct list_head *bhp)
+{
+	int cpu;
+
+	// If a previous IPI is still in flight, let it complete.
+	if (smp_load_acquire(&t->trc_ipi_to_cpu) != -1) // Order IPI
+		return;
+
+	// The current task had better be in a quiescent state.
+	if (t == current) {
+		t->trc_reader_checked = true;
+		trc_del_holdout(t);
+		WARN_ON_ONCE(t->trc_reader_nesting);
+		return;
+	}
+
+	// Attempt to nail down the task for inspection.
+	if (try_invoke_on_locked_down_task(t, trc_inspect_reader, NULL))
+		return;
+
+	// If currently running, send an IPI, either way, add to list.
+	trc_add_holdout(t, bhp);
+	if (task_curr(t)) {
+		// The task is currently running, so try IPIing it.
+		cpu = task_cpu(t);
+
+		// If there is already an IPI outstanding, let it happen.
+		if (per_cpu(trc_ipi_to_cpu, cpu) || t->trc_ipi_to_cpu >= 0)
+			return;
+
+		atomic_inc(&trc_n_readers_need_end);
+		per_cpu(trc_ipi_to_cpu, cpu) = true;
+		t->trc_ipi_to_cpu = cpu;
+		if (smp_call_function_single(cpu,
+					     trc_read_check_handler, t, 0)) {
+			// Just in case there is some other reason for
+			// failure than the target CPU being offline.
+			per_cpu(trc_ipi_to_cpu, cpu) = false;
+			t->trc_ipi_to_cpu = cpu;
+			if (atomic_dec_and_test(&trc_n_readers_need_end)) {
+				WARN_ON_ONCE(1);
+				wake_up(&trc_wait);
+			}
+		}
+	}
+}
+
+/* Initialize for a new RCU-tasks-trace grace period. */
+static void rcu_tasks_trace_pregp_step(void)
+{
+	int cpu;
+
+	// Wait for CPU-hotplug paths to complete.
+	cpus_read_lock();
+	cpus_read_unlock();
+
+	// Allow for fast-acting IPIs.
+	atomic_set(&trc_n_readers_need_end, 1);
+
+	// There shouldn't be any old IPIs, but...
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
+}
+
+/* Do first-round processing for the specified task. */
+static void rcu_tasks_trace_pertask(struct task_struct *t,
+				    struct list_head *hop)
+{
+	WRITE_ONCE(t->trc_reader_need_end, false);
+	t->trc_reader_checked = false;
+	t->trc_ipi_to_cpu = -1;
+	trc_wait_for_one_reader(t, hop);
+}
+
+/* Do intermediate processing between task and holdout scans. */
+static void rcu_tasks_trace_postscan(void)
+{
+	// Wait for late-stage exiting tasks to finish exiting.
+	// These might have passed the call to exit_tasks_rcu_finish().
+	synchronize_rcu();
+	// Any tasks that exit after this point will set ->trc_reader_checked.
+}
+
+/* Do one scan of the holdout list. */
+static void check_all_holdout_tasks_trace(struct list_head *hop,
+					  bool ndrpt, bool *frptp)
+{
+	struct task_struct *g, *t;
+
+	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
+		// If safe and needed, try to check the current task.
+		if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
+		    !READ_ONCE(t->trc_reader_checked))
+			trc_wait_for_one_reader(t, hop);
+
+		// If check succeeded, remove this task from the list.
+		if (READ_ONCE(t->trc_reader_checked))
+			trc_del_holdout(t);
+	}
+}
+
+/* Wait for grace period to complete and provide ordering. */
+static void rcu_tasks_trace_postgp(void)
+{
+	// Remove the safety count.
+	smp_mb__before_atomic();  // Order vs. earlier atomics
+	atomic_dec(&trc_n_readers_need_end);
+	smp_mb__after_atomic();  // Order vs. later atomics
+
+	// Wait for readers.
+	wait_event_idle_exclusive(trc_wait,
+				  atomic_read(&trc_n_readers_need_end) == 0);
+
+	smp_mb(); // Caller's code must be ordered after wakeup.
+}
+
+/* Report any needed quiescent state for this exiting task. */
+void exit_tasks_rcu_finish_trace(struct task_struct *t)
+{
+	WRITE_ONCE(t->trc_reader_checked, true);
+	WARN_ON_ONCE(t->trc_reader_nesting);
+	WRITE_ONCE(t->trc_reader_nesting, 0);
+	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_need_end)))
+		rcu_read_unlock_trace_special(t);
+}
+
+void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
+		 "RCU Tasks Trace");
+
+/**
+ * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_tasks_trace()
+ * assumes that the read-side critical sections end at context switch,
+ * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
+ * there are no read-side primitives analogous to rcu_read_lock() and
+ * rcu_read_unlock() because this primitive is intended to determine
+ * that all tasks have passed through a safe state, not so much for
+ * data-strcuture synchronization.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func)
+{
+	call_rcu_tasks_generic(rhp, func, &rcu_tasks_trace);
+}
+EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
+
+/**
+ * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
+ *
+ * Control will return to the caller some time after a trace rcu-tasks
+ * grace period has elapsed, in other words after all currently
+ * executing rcu-tasks read-side critical sections have elapsed.  These
+ * read-side critical sections are delimited by calls to schedule(),
+ * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
+ * anyway) cond_resched().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function preambles
+ * and profiling hooks.  The synchronize_rcu_tasks_trace() function is not
+ * (yet) intended for heavy use from multiple CPUs.
+ *
+ * See the description of synchronize_rcu() for more detailed information
+ * on memory ordering guarantees.
+ */
+void synchronize_rcu_tasks_trace(void)
+{
+	RCU_LOCKDEP_WARN(lock_is_held(&rcu_trace_lock_map), "Illegal synchronize_rcu_tasks_trace() in RCU Tasks Trace read-side critical section");
+	synchronize_rcu_tasks_generic(&rcu_tasks_trace);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_trace);
+
+/**
+ * rcu_barrier_tasks_trace - Wait for in-flight call_rcu_tasks_trace() callbacks.
+ *
+ * Although the current implementation is guaranteed to wait, it is not
+ * obligated to, for example, if there are no pending callbacks.
+ */
+void rcu_barrier_tasks_trace(void)
+{
+	/* There is only one callback queue, so this is easy.  ;-) */
+	synchronize_rcu_tasks_trace();
+}
+EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
+
+static int __init rcu_spawn_tasks_trace_kthread(void)
+{
+	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
+	rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
+	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
+	rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
+	rcu_tasks_trace.postgp_func = rcu_tasks_trace_postgp;
+	rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
+	return 0;
+}
+core_initcall(rcu_spawn_tasks_trace_kthread);
+
+#else /* #ifdef CONFIG_TASKS_TRACE_RCU */
+void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
+#endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
-- 
2.9.5

