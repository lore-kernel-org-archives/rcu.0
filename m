Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31635C3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3782076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974970;
	bh=Sddy2OWYAz9qif5oI3NQdYckwbFm6oX6Oy/o3MSALTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JK4jKHW0EiBOuB2k12h18/fQxjFuPvl/gU0OTs0J7RX2/3WLaIGNnP07aVoZLuXHS
	 dZbfEiHCUjspH5t+sEdi3Cn1+fwQe0KzcaWuxuxkQ/6BV52QQ+UnQcwI3cmZQrjjCP
	 8wxmRnx2Pxbm9A1CI3kK3GV2bv3cs6rwD3NOJp+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416628AbgDOSWm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436614AbgDOSTt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BC72173E;
        Wed, 15 Apr 2020 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974788;
        bh=Sddy2OWYAz9qif5oI3NQdYckwbFm6oX6Oy/o3MSALTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmM1dufxjgxw9Rv0aO6PUXDGYhWmif2v0tnKTkatfCI7j4WGWSBmbeYnNs4UKzih3
         imM/PwxX3CSiKRJP0myxg0jQZM9dZSFAFy3IHBqXJp1+kZaN8j2ADBhi94mKJQcl6A
         vbnTJ5CCFW15qXYRVim4R/J3o0vTMmYowYMJ4W1A=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 13/38] rcu-tasks: Further refactor RCU-tasks to allow adding more variants
Date:   Wed, 15 Apr 2020 11:19:16 -0700
Message-Id: <20200415181941.11653-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit refactors RCU tasks to allow variants to be added.  These
variants will share the current Tasks-RCU tasklist scan and the holdout
list processing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 166 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 58 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9ca83c6..344426e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -12,6 +12,11 @@
 
 struct rcu_tasks;
 typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
+typedef void (*pregp_func_t)(void);
+typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
+typedef void (*postscan_func_t)(void);
+typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
+typedef void (*postgp_func_t)(void);
 
 /**
  * Definition for a Tasks-RCU-like mechanism.
@@ -21,6 +26,11 @@ typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
+ * @pregp_func: This flavor's pre-grace-period function (optional).
+ * @pertask_func: This flavor's per-task scan function (optional).
+ * @postscan_func: This flavor's post-task scan function (optional).
+ * @holdout_func: This flavor's holdout-list scan function (optional).
+ * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
@@ -32,6 +42,11 @@ struct rcu_tasks {
 	raw_spinlock_t cbs_lock;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
+	pregp_func_t pregp_func;
+	pertask_func_t pertask_func;
+	postscan_func_t postscan_func;
+	holdouts_func_t holdouts_func;
+	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
 	char *name;
 	char *kname;
@@ -113,6 +128,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Pick up any new callbacks. */
 		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+		smp_mb__after_unlock_lock(); // Order updates vs. GP.
 		list = rtp->cbs_head;
 		rtp->cbs_head = NULL;
 		rtp->cbs_tail = &rtp->cbs_head;
@@ -207,6 +223,49 @@ static void __init rcu_tasks_bootup_oddness(void)
 // rates from multiple CPUs.  If this is required, per-CPU callback lists
 // will be needed.
 
+/* Pre-grace-period preparation. */
+static void rcu_tasks_pregp_step(void)
+{
+	/*
+	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
+	 * to complete.  Invoking synchronize_rcu() suffices because all
+	 * these transitions occur with interrupts disabled.  Without this
+	 * synchronize_rcu(), a read-side critical section that started
+	 * before the grace period might be incorrectly seen as having
+	 * started after the grace period.
+	 *
+	 * This synchronize_rcu() also dispenses with the need for a
+	 * memory barrier on the first store to t->rcu_tasks_holdout,
+	 * as it forces the store to happen after the beginning of the
+	 * grace period.
+	 */
+	synchronize_rcu();
+}
+
+/* Per-task initial processing. */
+static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
+{
+	if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
+		get_task_struct(t);
+		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
+		WRITE_ONCE(t->rcu_tasks_holdout, true);
+		list_add(&t->rcu_tasks_holdout_list, hop);
+	}
+}
+
+/* Processing between scanning taskslist and draining the holdout list. */
+void rcu_tasks_postscan(void)
+{
+	/*
+	 * Wait for tasks that are in the process of exiting.  This
+	 * does only part of the job, ensuring that all tasks that were
+	 * previously exiting reach the point where they have disabled
+	 * preemption, allowing the later synchronize_rcu() to finish
+	 * the job.
+	 */
+	synchronize_srcu(&tasks_rcu_exit_srcu);
+}
+
 /* See if tasks are still holding out, complain if so. */
 static void check_holdout_task(struct task_struct *t,
 			       bool needreport, bool *firstreport)
@@ -239,55 +298,63 @@ static void check_holdout_task(struct task_struct *t,
 	sched_show_task(t);
 }
 
+/* Scan the holdout lists for tasks no longer holding out. */
+static void check_all_holdout_tasks(struct list_head *hop,
+				    bool needreport, bool *firstreport)
+{
+	struct task_struct *t, *t1;
+
+	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list) {
+		check_holdout_task(t, needreport, firstreport);
+		cond_resched();
+	}
+}
+
+/* Finish off the Tasks-RCU grace period. */
+static void rcu_tasks_postgp(void)
+{
+	/*
+	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
+	 * memory barriers prior to them in the schedule() path, memory
+	 * reordering on other CPUs could cause their RCU-tasks read-side
+	 * critical sections to extend past the end of the grace period.
+	 * However, because these ->nvcsw updates are carried out with
+	 * interrupts disabled, we can use synchronize_rcu() to force the
+	 * needed ordering on all such CPUs.
+	 *
+	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
+	 * accesses to be within the grace period, avoiding the need for
+	 * memory barriers for ->rcu_tasks_holdout accesses.
+	 *
+	 * In addition, this synchronize_rcu() waits for exiting tasks
+	 * to complete their final preempt_disable() region of execution,
+	 * cleaning up after the synchronize_srcu() above.
+	 */
+	synchronize_rcu();
+}
+
 /* Wait for one RCU-tasks grace period. */
 static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 {
 	struct task_struct *g, *t;
 	unsigned long lastreport;
-	LIST_HEAD(rcu_tasks_holdouts);
+	LIST_HEAD(holdouts);
 	int fract;
 
-	/*
-	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
-	 * to complete.  Invoking synchronize_rcu() suffices because all
-	 * these transitions occur with interrupts disabled.  Without this
-	 * synchronize_rcu(), a read-side critical section that started
-	 * before the grace period might be incorrectly seen as having
-	 * started after the grace period.
-	 *
-	 * This synchronize_rcu() also dispenses with the need for a
-	 * memory barrier on the first store to t->rcu_tasks_holdout,
-	 * as it forces the store to happen after the beginning of the
-	 * grace period.
-	 */
-	synchronize_rcu();
+	rtp->pregp_func();
 
 	/*
 	 * There were callbacks, so we need to wait for an RCU-tasks
 	 * grace period.  Start off by scanning the task list for tasks
 	 * that are not already voluntarily blocked.  Mark these tasks
-	 * and make a list of them in rcu_tasks_holdouts.
+	 * and make a list of them in holdouts.
 	 */
 	rcu_read_lock();
-	for_each_process_thread(g, t) {
-		if (t != current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
-			get_task_struct(t);
-			t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
-			WRITE_ONCE(t->rcu_tasks_holdout, true);
-			list_add(&t->rcu_tasks_holdout_list,
-				 &rcu_tasks_holdouts);
-		}
-	}
+	for_each_process_thread(g, t)
+		rtp->pertask_func(t, &holdouts);
 	rcu_read_unlock();
 
-	/*
-	 * Wait for tasks that are in the process of exiting.  This
-	 * does only part of the job, ensuring that all tasks that were
-	 * previously exiting reach the point where they have disabled
-	 * preemption, allowing the later synchronize_rcu() to finish
-	 * the job.
-	 */
-	synchronize_srcu(&tasks_rcu_exit_srcu);
+	rtp->postscan_func();
 
 	/*
 	 * Each pass through the following loop scans the list of holdout
@@ -303,9 +370,8 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 		bool firstreport;
 		bool needreport;
 		int rtst;
-		struct task_struct *t1;
 
-		if (list_empty(&rcu_tasks_holdouts))
+		if (list_empty(&holdouts))
 			break;
 
 		/* Slowly back off waiting for holdouts */
@@ -320,31 +386,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 			lastreport = jiffies;
 		firstreport = true;
 		WARN_ON(signal_pending(current));
-		list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
-					 rcu_tasks_holdout_list) {
-			check_holdout_task(t, needreport, &firstreport);
-			cond_resched();
-		}
+		rtp->holdouts_func(&holdouts, needreport, &firstreport);
 	}
 
-	/*
-	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
-	 * memory barriers prior to them in the schedule() path, memory
-	 * reordering on other CPUs could cause their RCU-tasks read-side
-	 * critical sections to extend past the end of the grace period.
-	 * However, because these ->nvcsw updates are carried out with
-	 * interrupts disabled, we can use synchronize_rcu() to force the
-	 * needed ordering on all such CPUs.
-	 *
-	 * This synchronize_rcu() also confines all ->rcu_tasks_holdout
-	 * accesses to be within the grace period, avoiding the need for
-	 * memory barriers for ->rcu_tasks_holdout accesses.
-	 *
-	 * In addition, this synchronize_rcu() waits for exiting tasks
-	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after the synchronize_srcu() above.
-	 */
-	synchronize_rcu();
+	rtp->postgp_func();
 }
 
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
@@ -413,6 +458,11 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
+	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
+	rcu_tasks.pertask_func = rcu_tasks_pertask;
+	rcu_tasks.postscan_func = rcu_tasks_postscan;
+	rcu_tasks.holdouts_func = check_all_holdout_tasks;
+	rcu_tasks.postgp_func = rcu_tasks_postgp;
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks);
 	return 0;
 }
-- 
2.9.5

