Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D7FC38A2B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C322076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974914;
	bh=Mg9UGLEn+8mKQiBDb5bnhsQsD+0riRG6qzZI4sDA8xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xdrjodfWDA+yHDwX+v7MlwrUrlpjeTFQo/gjYo72WbVI351fnsZ2iE3BJT7wKZkO6
	 v9nQ34YbXAcfNKaQjqQrq1w4BQwlmffcCaf5FLgzRduDfybK6oLW4zLVp8Uua8vRx9
	 3q4XFGig96QeheAi1VAhHKwCppMhzJGBqPOml8Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441485AbgDOSVw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441386AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33C121973;
        Wed, 15 Apr 2020 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974792;
        bh=Mg9UGLEn+8mKQiBDb5bnhsQsD+0riRG6qzZI4sDA8xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRwut/nqBwGTFjwQ0mBHEbVMmLC4o6vo0mN7nk2X4qtSZI8xBZXWUnmqYy7pzUKsU
         X5tJx7sYg65nVUjL9ItufWTwaFB55CZ4oBGDz3vgcInqH0py8OzqGN5FKhBp7N+7fu
         ShrLDqPdCcXTjvficjZhdnw1zwQK/W+s2dquxq0s=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 24/38] rcu-tasks: Split ->trc_reader_need_end
Date:   Wed, 15 Apr 2020 11:19:27 -0700
Message-Id: <20200415181941.11653-24-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit splits ->trc_reader_need_end by using the rcu_special union.
This change permits readers to check to see if a memory barrier is
required without any added overhead in the common case where no such
barrier is required.  This commit also adds the read-side checking.
Later commits will add the machinery to properly set the new
->trc_reader_special.b.need_mb field.

This commit also makes rcu_read_unlock_trace_special() tolerate nested
read-side critical sections within interrupt and NMI handlers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h | 11 +++++++----
 include/linux/sched.h          |  4 ++--
 init/init_task.c               |  1 +
 kernel/fork.c                  |  1 +
 kernel/rcu/tasks.h             | 33 ++++++++++++++++++++-------------
 5 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index ed97e10..c42b365c 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -31,7 +31,7 @@ static inline int rcu_read_lock_trace_held(void)
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-void rcu_read_unlock_trace_special(struct task_struct *t);
+void rcu_read_unlock_trace_special(struct task_struct *t, int nesting);
 
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
@@ -50,6 +50,8 @@ static inline void rcu_read_lock_trace(void)
 	struct task_struct *t = current;
 
 	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
+	if (t->trc_reader_special.b.need_mb)
+		smp_mb(); // Pairs with update-side barriers
 	rcu_lock_acquire(&rcu_trace_lock_map);
 }
 
@@ -69,10 +71,11 @@ static inline void rcu_read_unlock_trace(void)
 
 	rcu_lock_release(&rcu_trace_lock_map);
 	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
-	WRITE_ONCE(t->trc_reader_nesting, nesting);
-	if (likely(!READ_ONCE(t->trc_reader_need_end)) || nesting)
+	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
+		WRITE_ONCE(t->trc_reader_nesting, nesting);
 		return;  // We assume shallow reader nesting.
-	rcu_read_unlock_trace_special(t);
+	}
+	rcu_read_unlock_trace_special(t, nesting);
 }
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 864f60e..9437b53 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -613,7 +613,7 @@ union rcu_special {
 		u8			blocked;
 		u8			need_qs;
 		u8			exp_hint; /* Hint for performance. */
-		u8			pad; /* No garbage from compiler! */
+		u8			need_mb; /* Readers need smp_mb(). */
 	} b; /* Bits. */
 	u32 s; /* Set of bits. */
 };
@@ -727,7 +727,7 @@ struct task_struct {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
 	int				trc_ipi_to_cpu;
-	bool				trc_reader_need_end;
+	union rcu_special		trc_reader_special;
 	bool				trc_reader_checked;
 	struct list_head		trc_holdout_list;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
diff --git a/init/init_task.c b/init/init_task.c
index e8b3740..825972d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -143,6 +143,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
+	.trc_reader_special.s = 0,
 	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
 #endif
 #ifdef CONFIG_CPUSETS
diff --git a/kernel/fork.c b/kernel/fork.c
index 1eff609..559cdb1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1685,6 +1685,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
+	p->trc_reader_special.s = 0;
 	INIT_LIST_HEAD(&p->trc_holdout_list);
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6f4e8b1..4a730f1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -723,10 +723,17 @@ DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
 
 /* If we are the last reader, wake up the grace-period kthread. */
-void rcu_read_unlock_trace_special(struct task_struct *t)
+void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
-	WRITE_ONCE(t->trc_reader_need_end, false);
-	if (atomic_dec_and_test(&trc_n_readers_need_end))
+	int nq = t->trc_reader_special.b.need_qs;
+
+	if (t->trc_reader_special.b.need_mb)
+		smp_mb(); // Pairs with update-side barriers.
+	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
+	if (nq)
+		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
+	WRITE_ONCE(t->trc_reader_nesting, nesting);
+	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
 		wake_up(&trc_wait);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
@@ -777,8 +784,8 @@ static void trc_read_check_handler(void *t_in)
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	WARN_ON_ONCE(t->trc_reader_need_end);
-	WRITE_ONCE(t->trc_reader_need_end, true);
+	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
 reset_ipi:
 	// Allow future IPIs to be sent on CPU and for task.
@@ -804,8 +811,8 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	// exit from that critical section.
 	if (unlikely(t->trc_reader_nesting)) {
 		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-		WARN_ON_ONCE(t->trc_reader_need_end);
-		WRITE_ONCE(t->trc_reader_need_end, true);
+		WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+		WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	}
 	return true;
 }
@@ -880,7 +887,7 @@ static void rcu_tasks_trace_pregp_step(void)
 static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
-	WRITE_ONCE(t->trc_reader_need_end, false);
+	WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_checked, false);
 	t->trc_ipi_to_cpu = -1;
 	trc_wait_for_one_reader(t, hop);
@@ -912,7 +919,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
 		 t->trc_reader_nesting,
-		 " N"[!!t->trc_reader_need_end],
+		 " N"[!!t->trc_reader_special.b.need_qs],
 		 cpu);
 	sched_show_task(t);
 }
@@ -976,11 +983,11 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 			break;  // Count reached zero.
 		// Stall warning time, so make a list of the offenders.
 		for_each_process_thread(g, t)
-			if (READ_ONCE(t->trc_reader_need_end))
+			if (READ_ONCE(t->trc_reader_special.b.need_qs))
 				trc_add_holdout(t, &holdouts);
 		firstreport = true;
 		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list)
-			if (READ_ONCE(t->trc_reader_need_end)) {
+			if (READ_ONCE(t->trc_reader_special.b.need_qs)) {
 				show_stalled_task_trace(t, &firstreport);
 				trc_del_holdout(t);
 			}
@@ -999,8 +1006,8 @@ void exit_tasks_rcu_finish_trace(struct task_struct *t)
 	WRITE_ONCE(t->trc_reader_checked, true);
 	WARN_ON_ONCE(t->trc_reader_nesting);
 	WRITE_ONCE(t->trc_reader_nesting, 0);
-	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_need_end)))
-		rcu_read_unlock_trace_special(t);
+	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
+		rcu_read_unlock_trace_special(t, 0);
 }
 
 /**
-- 
2.9.5

