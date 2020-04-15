Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B221C38A2B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD2720787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974937;
	bh=lp2bigK3kTHhnaGa19udd4CGQ69Ac4avWPxu8YGx9NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAQ+DMG0iZlenG1MZ+3tttlZOeHqsm8L3/yY7UJgAKeVu5kNM66HOYpHrUqsTlA/f
	 kLIt1fRL4PPXB0HVmi363Ijl16psH9oREkzKOOe9IvTARPLW9i0ET7lpoCt29vn1ae
	 XSXSBRzrEPcIlrqYfMvf7A2oyZEFzZj7zu2SM2kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416592AbgDOSWP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441381AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B840621924;
        Wed, 15 Apr 2020 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974791;
        bh=lp2bigK3kTHhnaGa19udd4CGQ69Ac4avWPxu8YGx9NA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6iizfGaVVxIO96fokP93Ebl8nkMVrQDYQEPyrNjumXjqAn1J/VnWAGNI9MMOLnz7
         VusN1hL3iL0kXfOmet4GYoTkLS1+MQTC9s/ajJk/CJKogi5zHlwyKnqFKYQnFR+wNz
         tanGvz+8hPEF+TXk9ydPYsfcvSyQfSBg/q6AvZoc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 21/38] rcu-tasks: Make RCU Tasks Trace make use of RCU scheduler hooks
Date:   Wed, 15 Apr 2020 11:19:24 -0700
Message-Id: <20200415181941.11653-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit makes the calls to rcu_tasks_qs() detect and report
quiescent states for RCU tasks trace.  If the task is in a quiescent
state and if ->trc_reader_checked is not yet set, the task sets its own
->trc_reader_checked.  This will cause the grace-period kthread to
remove it from the holdout list if it still remains there.

[ paulmck: Fix conditional compilation per kbuild test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 44 +++++++++++++++++++++++++++++++++++++-------
 include/linux/rcutiny.h  |  2 +-
 kernel/rcu/tasks.h       |  5 +++--
 kernel/rcu/tree_plugin.h |  6 ++----
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2be97a8..659cbfa 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -131,20 +131,50 @@ static inline void rcu_init_nohz(void) { }
  * This is a macro rather than an inline function to avoid #include hell.
  */
 #ifdef CONFIG_TASKS_RCU_GENERIC
-#define rcu_tasks_qs(t) \
-	do { \
-		if (READ_ONCE((t)->rcu_tasks_holdout)) \
-			WRITE_ONCE((t)->rcu_tasks_holdout, false); \
+
+# ifdef CONFIG_TASKS_RCU
+# define rcu_tasks_classic_qs(t, preempt)				\
+	do {								\
+		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
+			WRITE_ONCE((t)->rcu_tasks_holdout, false);	\
 	} while (0)
-#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
+# else
+# define rcu_tasks_classic_qs(t, preempt) do { } while (0)
+# define call_rcu_tasks call_rcu
+# define synchronize_rcu_tasks synchronize_rcu
+# endif
+
+# ifdef CONFIG_TASKS_RCU_TRACE
+# define rcu_tasks_trace_qs(t)						\
+	do {								\
+		if (!likely(READ_ONCE((t)->trc_reader_checked)) &&	\
+		    !unlikely(READ_ONCE((t)->trc_reader_nesting))) {	\
+			smp_store_release(&(t)->trc_reader_checked, true); \
+			smp_mb(); /* Readers partitioned by store. */	\
+		}							\
+	} while (0)
+# else
+# define rcu_tasks_trace_qs(t) do { } while (0)
+# endif
+
+#define rcu_tasks_qs(t, preempt)					\
+do {									\
+	rcu_tasks_classic_qs((t), (preempt));				\
+	rcu_tasks_trace_qs((t));					\
+} while (0)
+
+# ifdef CONFIG_TASKS_RUDE_RCU
 void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks_rude(void);
+# endif
+
+#define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
-#define rcu_tasks_qs(t)	do { } while (0)
+#define rcu_tasks_qs(t, preempt) do { } while (0)
 #define rcu_note_voluntary_context_switch(t) do { } while (0)
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
@@ -161,7 +191,7 @@ static inline void exit_tasks_rcu_finish(void) { }
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
-	rcu_tasks_qs(current); \
+	rcu_tasks_qs(current, false); \
 	cond_resched(); \
 } while (0)
 
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 045c28b..d77e111 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -49,7 +49,7 @@ static inline void rcu_softirq_qs(void)
 #define rcu_note_context_switch(preempt) \
 	do { \
 		rcu_qs(); \
-		rcu_tasks_qs(current); \
+		rcu_tasks_qs(current, (preempt)); \
 	} while (0)
 
 static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8dffe2b..2ec82f4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -180,7 +180,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Pick up any new callbacks. */
 		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
-		smp_mb__after_unlock_lock(); // Order updates vs. GP.
+		smp_mb__after_spinlock(); // Order updates vs. GP.
 		list = rtp->cbs_head;
 		rtp->cbs_head = NULL;
 		rtp->cbs_tail = &rtp->cbs_head;
@@ -870,7 +870,7 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
 	WRITE_ONCE(t->trc_reader_need_end, false);
-	t->trc_reader_checked = false;
+	WRITE_ONCE(t->trc_reader_checked, false);
 	t->trc_ipi_to_cpu = -1;
 	trc_wait_for_one_reader(t, hop);
 }
@@ -979,6 +979,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 		pr_err("\t%d holdouts\n", atomic_read(&trc_n_readers_need_end));
 	}
 	smp_mb(); // Caller's code must be ordered after wakeup.
+		  // Pairs with pretty much every ordering primitive.
 }
 
 /* Report any needed quiescent state for this exiting task. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4f34c32..37e0281 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -331,8 +331,7 @@ void rcu_note_context_switch(bool preempt)
 	rcu_qs();
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
-	if (!preempt)
-		rcu_tasks_qs(current);
+	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
@@ -841,8 +840,7 @@ void rcu_note_context_switch(bool preempt)
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs)))
 		rcu_momentary_dyntick_idle();
-	if (!preempt)
-		rcu_tasks_qs(current);
+	rcu_tasks_qs(current, preempt);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
 }
-- 
2.9.5

