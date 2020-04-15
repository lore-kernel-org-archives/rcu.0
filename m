Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB1C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1CD20787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974897;
	bh=BuzfUisDuj8JrS/2QV/iWcqsQuXeR3pQ32AErTfd7s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NZHDLH972AMUco+f0leO0Oo/UhMmz+0UiOkyFQ6Nc0vrb8q75KIh+Ga0w3g16qUPA
	 C7moXLfwTt2u8BdLuoeycXiRtcdMkN+iNBf13BlXpiYCUjVND4dujVZHlO67fZIrUp
	 omU6qaU5cPZmSXmvbQdA/HCJw8dq8a+Wn+QwYBEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441467AbgDOSVc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441389AbgDOSTy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFEE221734;
        Wed, 15 Apr 2020 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974793;
        bh=BuzfUisDuj8JrS/2QV/iWcqsQuXeR3pQ32AErTfd7s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y332OaiYiziCvR0KSA4yFttgSaBzsyw86GLV9FmazgpPwDAU3Mix0L5IQTNVu4izh
         GcABAcmifjfcD5C9KWCkkA+WUHXquuG3ERhJK/Q/9HjnKhr+ccMZpH47n21tD9FiPg
         JPDZRtikqQ3n8J+tW0jPUC0CTMNYEBEaO1w5g03Y=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 27/38] rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built
Date:   Wed, 15 Apr 2020 11:19:30 -0700
Message-Id: <20200415181941.11653-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Systems running CPU-bound real-time task do not want IPIs sent to CPUs
executing nohz_full userspace tasks.  Battery-powered systems don't
want IPIs sent to idle CPUs in low-power mode.  Unfortunately, RCU tasks
trace can and will send such IPIs in some cases.

Both of these situations occur only when the target CPU is in RCU
dyntick-idle mode, in other words, when RCU is not watching the
target CPU.  This suggests that CPUs in dyntick-idle mode should use
memory barriers in outermost invocations of rcu_read_lock_trace()
and rcu_read_unlock_trace(), which would allow the RCU tasks trace
grace period to directly read out the target CPU's read-side state.
One challenge is that RCU tasks trace is not targeting a specific
CPU, but rather a task.  And that task could switch from one CPU to
another at any time.

This commit therefore uses try_invoke_on_locked_down_task()
and checks for task_curr() in trc_inspect_reader_notrunning().
When this condition holds, the target task is running and cannot move.
If CONFIG_TASKS_TRACE_RCU_READ_MB=y, the new rcu_dynticks_zero_in_eqs()
function can be used to check if the specified integer (in this case,
t->trc_reader_nesting) is zero while the target CPU remains in that same
dyntick-idle sojourn.  If so, the target task is in a quiescent state.
If not, trc_read_check_handler() must indicate failure so that the
grace-period kthread can take appropriate action or retry after an
appropriate delay, as the case may be.

With this change, given CONFIG_TASKS_TRACE_RCU_READ_MB=y, if a given
CPU remains idle or a given task continues executing in nohz_full mode,
the RCU tasks trace grace-period kthread will detect this without the
need to send an IPI.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h         |  2 ++
 kernel/rcu/tasks.h       | 36 ++++++++++++++++++++++++++----------
 kernel/rcu/tree.c        | 24 ++++++++++++++++++++++++
 kernel/rcu/tree.h        |  2 ++
 kernel/rcu/tree_plugin.h | 18 ++++++++++++++++++
 5 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e1089fd..296f926 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -501,6 +501,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 #endif
 
 #ifdef CONFIG_TINY_RCU
+static inline bool rcu_dynticks_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
@@ -510,6 +511,7 @@ static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
 #else /* #ifdef CONFIG_TINY_RCU */
+bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 64a5b97..3eed886 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -806,22 +806,38 @@ static void trc_read_check_handler(void *t_in)
 /* Callback function for scheduler to check locked-down task.  */
 static bool trc_inspect_reader(struct task_struct *t, void *arg)
 {
-	if (task_curr(t))
-		return false;  // It is running, so decline to inspect it.
+	int cpu = task_cpu(t);
+	bool in_qs = false;
+
+	if (task_curr(t)) {
+		// If no chance of heavyweight readers, do it the hard way.
+		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+			return false;
+
+		// If heavyweight readers are enabled on the remote task,
+		// we can inspect its state despite its currently running.
+		// However, we cannot safely change its state.
+		if (!rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
+			return false; // No quiescent state, do it the hard way.
+		in_qs = true;
+	} else {
+		in_qs = likely(!t->trc_reader_nesting);
+	}
 
 	// Mark as checked.  Because this is called from the grace-period
 	// kthread, also remove the task from the holdout list.
 	t->trc_reader_checked = true;
 	trc_del_holdout(t);
 
-	// If the task is in a read-side critical section, set up its
-	// its state so that it will awaken the grace-period kthread upon
-	// exit from that critical section.
-	if (unlikely(t->trc_reader_nesting)) {
-		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-		WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
-		WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
-	}
+	if (in_qs)
+		return true;  // Already in quiescent state, done!!!
+
+	// The task is in a read-side critical section, so set up its
+	// state so that it will awaken the grace-period kthread upon exit
+	// from that critical section.
+	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e54a8a1..7dd7a17 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -252,6 +252,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * critical sections, and we also must force ordering with the
 	 * next idle sojourn.
 	 */
+	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
@@ -278,6 +279,7 @@ static void rcu_dynticks_eqs_exit(void)
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
 	// RCU is now watching.  Better not be in an extended quiescent state!
+	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
@@ -350,6 +352,28 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 }
 
 /*
+ * Return true if the referenced integer is zero while the specified
+ * CPU remains within a single extended quiescent state.
+ */
+bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int snap;
+
+	// If not quiescent, force back to earlier extended quiescent state.
+	snap = atomic_read(&rdp->dynticks) & ~(RCU_DYNTICK_CTRL_MASK |
+					       RCU_DYNTICK_CTRL_CTR);
+
+	smp_rmb(); // Order ->dynticks and *vp reads.
+	if (READ_ONCE(*vp))
+		return false;  // Non-zero, so report failure;
+	smp_rmb(); // Order *vp read and ->dynticks re-read.
+
+	// If still in the same extended quiescent state, we are good!
+	return snap == (atomic_read(&rdp->dynticks) & ~RCU_DYNTICK_CTRL_MASK);
+}
+
+/*
  * Set the special (bottom) bit of the specified CPU so that it
  * will take special action (such as flushing its TLB) on the
  * next exit from an extended quiescent state.  Returns true if
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9dc2ec0..29ba799 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -454,6 +454,8 @@ static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 static void rcu_dynticks_task_enter(void);
 static void rcu_dynticks_task_exit(void);
+static void rcu_dynticks_task_trace_enter(void);
+static void rcu_dynticks_task_trace_exit(void);
 
 /* Forward declarations for tree_stall.h */
 static void record_gp_stall_check_time(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 37e0281..4cef7e3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2552,3 +2552,21 @@ static void rcu_dynticks_task_exit(void)
 	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
 #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
 }
+
+/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
+static void rcu_dynticks_task_trace_enter(void)
+{
+#ifdef CONFIG_TASKS_RCU_TRACE
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = true;
+#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+}
+
+/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
+static void rcu_dynticks_task_trace_exit(void)
+{
+#ifdef CONFIG_TASKS_RCU_TRACE
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
+		current->trc_reader_special.b.need_mb = false;
+#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+}
-- 
2.9.5

