Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D424C43332
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B222076E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576709;
	bh=kmNvkx5gngLXpQK6EqSsPDdnGsbL9Re+sPPk1bjA5ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dd9DNAlldZ+fMTNgfz0oKnCHsACP9LKnsb/EjBSThe8NkbDDtOlQznL3glmMzRbYF
	 6/KwZrS3eG4yr5Ve7coVHL4xBS7KXA3dulFcQn5E3rVvHoVLWEchr4V9tFfZnLr/Rk
	 /g3Z3gDRCvvTx+cwkghM7vrUbZh6Vi+L5zqN1z98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCSALs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgCSALF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1793620782;
        Thu, 19 Mar 2020 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576663;
        bh=kmNvkx5gngLXpQK6EqSsPDdnGsbL9Re+sPPk1bjA5ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2P+4rghNo9fInvOPI7MiYPilCHoIw6L9PbyEJVKQ2MkgIyIGjSWcAz2tbcqRj//75
         fIHHqkanolFUsVPp/qLPORix+qB5XO3KvwSNJ4e4hIyiMF6WevezVGnqOVieZpPbmB
         2WTpSGFGYvwApa9tJHKB7GN397LejPM2mOIg5Pi0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 04/22] rcu-tasks: Move Tasks RCU to its own file
Date:   Wed, 18 Mar 2020 17:10:42 -0700
Message-Id: <20200319001100.24917-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This code-movement-only commit is in preparation for adding an additional
flavor of Tasks RCU, which relies on workqueues to detect grace periods.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/update.c | 366 +--------------------------------------------------
 2 files changed, 372 insertions(+), 364 deletions(-)
 create mode 100644 kernel/rcu/tasks.h

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
new file mode 100644
index 0000000..be8d179
--- /dev/null
+++ b/kernel/rcu/tasks.h
@@ -0,0 +1,370 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Task-based RCU implementations.
+ *
+ * Copyright (C) 2020 Paul E. McKenney
+ */
+
+#ifdef CONFIG_TASKS_RCU
+
+/*
+ * Simple variant of RCU whose quiescent states are voluntary context
+ * switch, cond_resched_rcu_qs(), user-space execution, and idle.
+ * As such, grace periods can take one good long time.  There are no
+ * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
+ * because this implementation is intended to get the system into a safe
+ * state for some of the manipulations involved in tracing and the like.
+ * Finally, this implementation does not support high call_rcu_tasks()
+ * rates from multiple CPUs.  If this is required, per-CPU callback lists
+ * will be needed.
+ */
+
+/* Global list of callbacks and associated lock. */
+static struct rcu_head *rcu_tasks_cbs_head;
+static struct rcu_head **rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
+static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
+static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
+
+/* Track exiting tasks in order to allow them to be waited for. */
+DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
+
+/* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
+#define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
+static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
+module_param(rcu_task_stall_timeout, int, 0644);
+
+static struct task_struct *rcu_tasks_kthread_ptr;
+
+/**
+ * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_tasks() assumes
+ * that the read-side critical sections end at a voluntary context
+ * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
+ * or transition to usermode execution.  As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-strcuture synchronization.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
+{
+	unsigned long flags;
+	bool needwake;
+
+	rhp->next = NULL;
+	rhp->func = func;
+	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
+	needwake = !rcu_tasks_cbs_head;
+	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
+	rcu_tasks_cbs_tail = &rhp->next;
+	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+	/* We can't create the thread unless interrupts are enabled. */
+	if (needwake && READ_ONCE(rcu_tasks_kthread_ptr))
+		wake_up(&rcu_tasks_cbs_wq);
+}
+EXPORT_SYMBOL_GPL(call_rcu_tasks);
+
+/**
+ * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
+ *
+ * Control will return to the caller some time after a full rcu-tasks
+ * grace period has elapsed, in other words after all currently
+ * executing rcu-tasks read-side critical sections have elapsed.  These
+ * read-side critical sections are delimited by calls to schedule(),
+ * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
+ * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function
+ * preambles and profiling hooks.  The synchronize_rcu_tasks() function
+ * is not (yet) intended for heavy use from multiple CPUs.
+ *
+ * Note that this guarantee implies further memory-ordering guarantees.
+ * On systems with more than one CPU, when synchronize_rcu_tasks() returns,
+ * each CPU is guaranteed to have executed a full memory barrier since the
+ * end of its last RCU-tasks read-side critical section whose beginning
+ * preceded the call to synchronize_rcu_tasks().  In addition, each CPU
+ * having an RCU-tasks read-side critical section that extends beyond
+ * the return from synchronize_rcu_tasks() is guaranteed to have executed
+ * a full memory barrier after the beginning of synchronize_rcu_tasks()
+ * and before the beginning of that RCU-tasks read-side critical section.
+ * Note that these guarantees include CPUs that are offline, idle, or
+ * executing in user mode, as well as CPUs that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked synchronize_rcu_tasks(), which returned
+ * to its caller on CPU B, then both CPU A and CPU B are guaranteed
+ * to have executed a full memory barrier during the execution of
+ * synchronize_rcu_tasks() -- even if CPU A and CPU B are the same CPU
+ * (but again only if the system has more than one CPU).
+ */
+void synchronize_rcu_tasks(void)
+{
+	/* Complain if the scheduler has not started.  */
+	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			 "synchronize_rcu_tasks called too soon");
+
+	/* Wait for the grace period. */
+	wait_rcu_gp(call_rcu_tasks);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
+
+/**
+ * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
+ *
+ * Although the current implementation is guaranteed to wait, it is not
+ * obligated to, for example, if there are no pending callbacks.
+ */
+void rcu_barrier_tasks(void)
+{
+	/* There is only one callback queue, so this is easy.  ;-) */
+	synchronize_rcu_tasks();
+}
+EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
+
+/* See if tasks are still holding out, complain if so. */
+static void check_holdout_task(struct task_struct *t,
+			       bool needreport, bool *firstreport)
+{
+	int cpu;
+
+	if (!READ_ONCE(t->rcu_tasks_holdout) ||
+	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
+	    !READ_ONCE(t->on_rq) ||
+	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
+	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
+		WRITE_ONCE(t->rcu_tasks_holdout, false);
+		list_del_init(&t->rcu_tasks_holdout_list);
+		put_task_struct(t);
+		return;
+	}
+	rcu_request_urgent_qs_task(t);
+	if (!needreport)
+		return;
+	if (*firstreport) {
+		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
+		*firstreport = false;
+	}
+	cpu = task_cpu(t);
+	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
+		 t, ".I"[is_idle_task(t)],
+		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
+		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
+		 t->rcu_tasks_idle_cpu, cpu);
+	sched_show_task(t);
+}
+
+/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
+static int __noreturn rcu_tasks_kthread(void *arg)
+{
+	unsigned long flags;
+	struct task_struct *g, *t;
+	unsigned long lastreport;
+	struct rcu_head *list;
+	struct rcu_head *next;
+	LIST_HEAD(rcu_tasks_holdouts);
+	int fract;
+
+	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
+	housekeeping_affine(current, HK_FLAG_RCU);
+
+	/*
+	 * Each pass through the following loop makes one check for
+	 * newly arrived callbacks, and, if there are some, waits for
+	 * one RCU-tasks grace period and then invokes the callbacks.
+	 * This loop is terminated by the system going down.  ;-)
+	 */
+	for (;;) {
+
+		/* Pick up any new callbacks. */
+		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
+		list = rcu_tasks_cbs_head;
+		rcu_tasks_cbs_head = NULL;
+		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
+		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
+
+		/* If there were none, wait a bit and start over. */
+		if (!list) {
+			wait_event_interruptible(rcu_tasks_cbs_wq,
+						 READ_ONCE(rcu_tasks_cbs_head));
+			if (!rcu_tasks_cbs_head) {
+				WARN_ON(signal_pending(current));
+				schedule_timeout_interruptible(HZ/10);
+			}
+			continue;
+		}
+
+		/*
+		 * Wait for all pre-existing t->on_rq and t->nvcsw
+		 * transitions to complete.  Invoking synchronize_rcu()
+		 * suffices because all these transitions occur with
+		 * interrupts disabled.  Without this synchronize_rcu(),
+		 * a read-side critical section that started before the
+		 * grace period might be incorrectly seen as having started
+		 * after the grace period.
+		 *
+		 * This synchronize_rcu() also dispenses with the
+		 * need for a memory barrier on the first store to
+		 * ->rcu_tasks_holdout, as it forces the store to happen
+		 * after the beginning of the grace period.
+		 */
+		synchronize_rcu();
+
+		/*
+		 * There were callbacks, so we need to wait for an
+		 * RCU-tasks grace period.  Start off by scanning
+		 * the task list for tasks that are not already
+		 * voluntarily blocked.  Mark these tasks and make
+		 * a list of them in rcu_tasks_holdouts.
+		 */
+		rcu_read_lock();
+		for_each_process_thread(g, t) {
+			if (t != current && READ_ONCE(t->on_rq) &&
+			    !is_idle_task(t)) {
+				get_task_struct(t);
+				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
+				WRITE_ONCE(t->rcu_tasks_holdout, true);
+				list_add(&t->rcu_tasks_holdout_list,
+					 &rcu_tasks_holdouts);
+			}
+		}
+		rcu_read_unlock();
+
+		/*
+		 * Wait for tasks that are in the process of exiting.
+		 * This does only part of the job, ensuring that all
+		 * tasks that were previously exiting reach the point
+		 * where they have disabled preemption, allowing the
+		 * later synchronize_rcu() to finish the job.
+		 */
+		synchronize_srcu(&tasks_rcu_exit_srcu);
+
+		/*
+		 * Each pass through the following loop scans the list
+		 * of holdout tasks, removing any that are no longer
+		 * holdouts.  When the list is empty, we are done.
+		 */
+		lastreport = jiffies;
+
+		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
+		fract = 10;
+
+		for (;;) {
+			bool firstreport;
+			bool needreport;
+			int rtst;
+			struct task_struct *t1;
+
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			/* Slowly back off waiting for holdouts */
+			schedule_timeout_interruptible(HZ/fract);
+
+			if (fract > 1)
+				fract--;
+
+			rtst = READ_ONCE(rcu_task_stall_timeout);
+			needreport = rtst > 0 &&
+				     time_after(jiffies, lastreport + rtst);
+			if (needreport)
+				lastreport = jiffies;
+			firstreport = true;
+			WARN_ON(signal_pending(current));
+			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
+						rcu_tasks_holdout_list) {
+				check_holdout_task(t, needreport, &firstreport);
+				cond_resched();
+			}
+		}
+
+		/*
+		 * Because ->on_rq and ->nvcsw are not guaranteed
+		 * to have a full memory barriers prior to them in the
+		 * schedule() path, memory reordering on other CPUs could
+		 * cause their RCU-tasks read-side critical sections to
+		 * extend past the end of the grace period.  However,
+		 * because these ->nvcsw updates are carried out with
+		 * interrupts disabled, we can use synchronize_rcu()
+		 * to force the needed ordering on all such CPUs.
+		 *
+		 * This synchronize_rcu() also confines all
+		 * ->rcu_tasks_holdout accesses to be within the grace
+		 * period, avoiding the need for memory barriers for
+		 * ->rcu_tasks_holdout accesses.
+		 *
+		 * In addition, this synchronize_rcu() waits for exiting
+		 * tasks to complete their final preempt_disable() region
+		 * of execution, cleaning up after the synchronize_srcu()
+		 * above.
+		 */
+		synchronize_rcu();
+
+		/* Invoke the callbacks. */
+		while (list) {
+			next = list->next;
+			local_bh_disable();
+			list->func(list);
+			local_bh_enable();
+			list = next;
+			cond_resched();
+		}
+		/* Paranoid sleep to keep this from entering a tight loop */
+		schedule_timeout_uninterruptible(HZ/10);
+	}
+}
+
+/* Spawn rcu_tasks_kthread() at core_initcall() time. */
+static int __init rcu_spawn_tasks_kthread(void)
+{
+	struct task_struct *t;
+
+	t = kthread_run(rcu_tasks_kthread, NULL, "rcu_tasks_kthread");
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
+		return 0;
+	smp_mb(); /* Ensure others see full kthread. */
+	WRITE_ONCE(rcu_tasks_kthread_ptr, t);
+	return 0;
+}
+core_initcall(rcu_spawn_tasks_kthread);
+
+/* Do the srcu_read_lock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+{
+	preempt_disable();
+	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	preempt_enable();
+}
+
+/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
+void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
+{
+	preempt_disable();
+	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
+	preempt_enable();
+}
+
+#endif /* #ifdef CONFIG_TASKS_RCU */
+
+#ifndef CONFIG_TINY_RCU
+
+/*
+ * Print any non-default Tasks RCU settings.
+ */
+static void __init rcu_tasks_bootup_oddness(void)
+{
+#ifdef CONFIG_TASKS_RCU
+	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
+		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
+	else
+		pr_info("\tTasks RCU enabled.\n");
+#endif /* #ifdef CONFIG_TASKS_RCU */
+}
+
+#endif /* #ifndef CONFIG_TINY_RCU */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index dd837da..0fb2a9e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -489,370 +489,6 @@ int rcu_cpu_stall_suppress_at_boot __read_mostly; // !0 = suppress boot stalls.
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_at_boot);
 module_param(rcu_cpu_stall_suppress_at_boot, int, 0444);
 
-#ifdef CONFIG_TASKS_RCU
-
-/*
- * Simple variant of RCU whose quiescent states are voluntary context
- * switch, cond_resched_rcu_qs(), user-space execution, and idle.
- * As such, grace periods can take one good long time.  There are no
- * read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
- * because this implementation is intended to get the system into a safe
- * state for some of the manipulations involved in tracing and the like.
- * Finally, this implementation does not support high call_rcu_tasks()
- * rates from multiple CPUs.  If this is required, per-CPU callback lists
- * will be needed.
- */
-
-/* Global list of callbacks and associated lock. */
-static struct rcu_head *rcu_tasks_cbs_head;
-static struct rcu_head **rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-static DECLARE_WAIT_QUEUE_HEAD(rcu_tasks_cbs_wq);
-static DEFINE_RAW_SPINLOCK(rcu_tasks_cbs_lock);
-
-/* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
-
-/* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
-#define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
-static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
-module_param(rcu_task_stall_timeout, int, 0644);
-
-static struct task_struct *rcu_tasks_kthread_ptr;
-
-/**
- * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
- * @rhp: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks() assumes
- * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
- * or transition to usermode execution.  As such, there are no read-side
- * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
- * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
- *
- * See the description of call_rcu() for more detailed information on
- * memory ordering guarantees.
- */
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func)
-{
-	unsigned long flags;
-	bool needwake;
-
-	rhp->next = NULL;
-	rhp->func = func;
-	raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-	needwake = !rcu_tasks_cbs_head;
-	WRITE_ONCE(*rcu_tasks_cbs_tail, rhp);
-	rcu_tasks_cbs_tail = &rhp->next;
-	raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
-	/* We can't create the thread unless interrupts are enabled. */
-	if (needwake && READ_ONCE(rcu_tasks_kthread_ptr))
-		wake_up(&rcu_tasks_cbs_wq);
-}
-EXPORT_SYMBOL_GPL(call_rcu_tasks);
-
-/**
- * synchronize_rcu_tasks - wait until an rcu-tasks grace period has elapsed.
- *
- * Control will return to the caller some time after a full rcu-tasks
- * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
- * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
- * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
- *
- * This is a very specialized primitive, intended only for a few uses in
- * tracing and other situations requiring manipulation of function
- * preambles and profiling hooks.  The synchronize_rcu_tasks() function
- * is not (yet) intended for heavy use from multiple CPUs.
- *
- * Note that this guarantee implies further memory-ordering guarantees.
- * On systems with more than one CPU, when synchronize_rcu_tasks() returns,
- * each CPU is guaranteed to have executed a full memory barrier since the
- * end of its last RCU-tasks read-side critical section whose beginning
- * preceded the call to synchronize_rcu_tasks().  In addition, each CPU
- * having an RCU-tasks read-side critical section that extends beyond
- * the return from synchronize_rcu_tasks() is guaranteed to have executed
- * a full memory barrier after the beginning of synchronize_rcu_tasks()
- * and before the beginning of that RCU-tasks read-side critical section.
- * Note that these guarantees include CPUs that are offline, idle, or
- * executing in user mode, as well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked synchronize_rcu_tasks(), which returned
- * to its caller on CPU B, then both CPU A and CPU B are guaranteed
- * to have executed a full memory barrier during the execution of
- * synchronize_rcu_tasks() -- even if CPU A and CPU B are the same CPU
- * (but again only if the system has more than one CPU).
- */
-void synchronize_rcu_tasks(void)
-{
-	/* Complain if the scheduler has not started.  */
-	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
-
-	/* Wait for the grace period. */
-	wait_rcu_gp(call_rcu_tasks);
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
-
-/**
- * rcu_barrier_tasks - Wait for in-flight call_rcu_tasks() callbacks.
- *
- * Although the current implementation is guaranteed to wait, it is not
- * obligated to, for example, if there are no pending callbacks.
- */
-void rcu_barrier_tasks(void)
-{
-	/* There is only one callback queue, so this is easy.  ;-) */
-	synchronize_rcu_tasks();
-}
-EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
-
-/* See if tasks are still holding out, complain if so. */
-static void check_holdout_task(struct task_struct *t,
-			       bool needreport, bool *firstreport)
-{
-	int cpu;
-
-	if (!READ_ONCE(t->rcu_tasks_holdout) ||
-	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
-	    !READ_ONCE(t->on_rq) ||
-	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
-	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
-		WRITE_ONCE(t->rcu_tasks_holdout, false);
-		list_del_init(&t->rcu_tasks_holdout_list);
-		put_task_struct(t);
-		return;
-	}
-	rcu_request_urgent_qs_task(t);
-	if (!needreport)
-		return;
-	if (*firstreport) {
-		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
-		*firstreport = false;
-	}
-	cpu = task_cpu(t);
-	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
-		 t, ".I"[is_idle_task(t)],
-		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
-		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
-		 t->rcu_tasks_idle_cpu, cpu);
-	sched_show_task(t);
-}
-
-/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
-static int __noreturn rcu_tasks_kthread(void *arg)
-{
-	unsigned long flags;
-	struct task_struct *g, *t;
-	unsigned long lastreport;
-	struct rcu_head *list;
-	struct rcu_head *next;
-	LIST_HEAD(rcu_tasks_holdouts);
-	int fract;
-
-	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
-	housekeeping_affine(current, HK_FLAG_RCU);
-
-	/*
-	 * Each pass through the following loop makes one check for
-	 * newly arrived callbacks, and, if there are some, waits for
-	 * one RCU-tasks grace period and then invokes the callbacks.
-	 * This loop is terminated by the system going down.  ;-)
-	 */
-	for (;;) {
-
-		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
-		list = rcu_tasks_cbs_head;
-		rcu_tasks_cbs_head = NULL;
-		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
-		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
-
-		/* If there were none, wait a bit and start over. */
-		if (!list) {
-			wait_event_interruptible(rcu_tasks_cbs_wq,
-						 READ_ONCE(rcu_tasks_cbs_head));
-			if (!rcu_tasks_cbs_head) {
-				WARN_ON(signal_pending(current));
-				schedule_timeout_interruptible(HZ/10);
-			}
-			continue;
-		}
-
-		/*
-		 * Wait for all pre-existing t->on_rq and t->nvcsw
-		 * transitions to complete.  Invoking synchronize_rcu()
-		 * suffices because all these transitions occur with
-		 * interrupts disabled.  Without this synchronize_rcu(),
-		 * a read-side critical section that started before the
-		 * grace period might be incorrectly seen as having started
-		 * after the grace period.
-		 *
-		 * This synchronize_rcu() also dispenses with the
-		 * need for a memory barrier on the first store to
-		 * ->rcu_tasks_holdout, as it forces the store to happen
-		 * after the beginning of the grace period.
-		 */
-		synchronize_rcu();
-
-		/*
-		 * There were callbacks, so we need to wait for an
-		 * RCU-tasks grace period.  Start off by scanning
-		 * the task list for tasks that are not already
-		 * voluntarily blocked.  Mark these tasks and make
-		 * a list of them in rcu_tasks_holdouts.
-		 */
-		rcu_read_lock();
-		for_each_process_thread(g, t) {
-			if (t != current && READ_ONCE(t->on_rq) &&
-			    !is_idle_task(t)) {
-				get_task_struct(t);
-				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
-				WRITE_ONCE(t->rcu_tasks_holdout, true);
-				list_add(&t->rcu_tasks_holdout_list,
-					 &rcu_tasks_holdouts);
-			}
-		}
-		rcu_read_unlock();
-
-		/*
-		 * Wait for tasks that are in the process of exiting.
-		 * This does only part of the job, ensuring that all
-		 * tasks that were previously exiting reach the point
-		 * where they have disabled preemption, allowing the
-		 * later synchronize_rcu() to finish the job.
-		 */
-		synchronize_srcu(&tasks_rcu_exit_srcu);
-
-		/*
-		 * Each pass through the following loop scans the list
-		 * of holdout tasks, removing any that are no longer
-		 * holdouts.  When the list is empty, we are done.
-		 */
-		lastreport = jiffies;
-
-		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
-		fract = 10;
-
-		for (;;) {
-			bool firstreport;
-			bool needreport;
-			int rtst;
-			struct task_struct *t1;
-
-			if (list_empty(&rcu_tasks_holdouts))
-				break;
-
-			/* Slowly back off waiting for holdouts */
-			schedule_timeout_interruptible(HZ/fract);
-
-			if (fract > 1)
-				fract--;
-
-			rtst = READ_ONCE(rcu_task_stall_timeout);
-			needreport = rtst > 0 &&
-				     time_after(jiffies, lastreport + rtst);
-			if (needreport)
-				lastreport = jiffies;
-			firstreport = true;
-			WARN_ON(signal_pending(current));
-			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-						rcu_tasks_holdout_list) {
-				check_holdout_task(t, needreport, &firstreport);
-				cond_resched();
-			}
-		}
-
-		/*
-		 * Because ->on_rq and ->nvcsw are not guaranteed
-		 * to have a full memory barriers prior to them in the
-		 * schedule() path, memory reordering on other CPUs could
-		 * cause their RCU-tasks read-side critical sections to
-		 * extend past the end of the grace period.  However,
-		 * because these ->nvcsw updates are carried out with
-		 * interrupts disabled, we can use synchronize_rcu()
-		 * to force the needed ordering on all such CPUs.
-		 *
-		 * This synchronize_rcu() also confines all
-		 * ->rcu_tasks_holdout accesses to be within the grace
-		 * period, avoiding the need for memory barriers for
-		 * ->rcu_tasks_holdout accesses.
-		 *
-		 * In addition, this synchronize_rcu() waits for exiting
-		 * tasks to complete their final preempt_disable() region
-		 * of execution, cleaning up after the synchronize_srcu()
-		 * above.
-		 */
-		synchronize_rcu();
-
-		/* Invoke the callbacks. */
-		while (list) {
-			next = list->next;
-			local_bh_disable();
-			list->func(list);
-			local_bh_enable();
-			list = next;
-			cond_resched();
-		}
-		/* Paranoid sleep to keep this from entering a tight loop */
-		schedule_timeout_uninterruptible(HZ/10);
-	}
-}
-
-/* Spawn rcu_tasks_kthread() at core_initcall() time. */
-static int __init rcu_spawn_tasks_kthread(void)
-{
-	struct task_struct *t;
-
-	t = kthread_run(rcu_tasks_kthread, NULL, "rcu_tasks_kthread");
-	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
-		return 0;
-	smp_mb(); /* Ensure others see full kthread. */
-	WRITE_ONCE(rcu_tasks_kthread_ptr, t);
-	return 0;
-}
-core_initcall(rcu_spawn_tasks_kthread);
-
-/* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
-{
-	preempt_disable();
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-	preempt_enable();
-}
-
-/* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
-{
-	preempt_disable();
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
-	preempt_enable();
-}
-
-#endif /* #ifdef CONFIG_TASKS_RCU */
-
-#ifndef CONFIG_TINY_RCU
-
-/*
- * Print any non-default Tasks RCU settings.
- */
-static void __init rcu_tasks_bootup_oddness(void)
-{
-#ifdef CONFIG_TASKS_RCU
-	if (rcu_task_stall_timeout != RCU_TASK_STALL_TIMEOUT)
-		pr_info("\tTasks-RCU CPU stall warnings timeout set to %d (rcu_task_stall_timeout).\n", rcu_task_stall_timeout);
-	else
-		pr_info("\tTasks RCU enabled.\n");
-#endif /* #ifdef CONFIG_TASKS_RCU */
-}
-
-#endif /* #ifndef CONFIG_TINY_RCU */
-
 #ifdef CONFIG_PROVE_RCU
 
 /*
@@ -923,6 +559,8 @@ late_initcall(rcu_verify_early_boot_tests);
 void rcu_early_boot_tests(void) {}
 #endif /* CONFIG_PROVE_RCU */
 
+#include "tasks.h"
+
 #ifndef CONFIG_TINY_RCU
 
 /*
-- 
2.9.5

