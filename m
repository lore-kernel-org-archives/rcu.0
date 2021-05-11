Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C541CC43461
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C5261606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhEKXEu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhEKXEq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0F346193A;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=OMfPN2SopZoevUefIsigWa2gCmdM2ucpHY53nWeseVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+kp9wTNLxuOP8h+Kzl04+2G1N8apj0WegXRZeJdfKkSxqFExwnwhpweodBVKT15B
         rAg1bq3lfqWiLB0PdiWCaNjkDz0wTL+dRNP4KR6k2JYiWSDX0LfWxpSneX58Fu/6SF
         X1iujio0ZExwJLu8Q23o77lW2hAzaqnvCpn+hhB16Ilu7Oo/+tmVIDDV77WfDCz/uL
         kt257wltWhwSc/bTlaDuPOM0hRjeIvvdCbLWlyDfZp8r6hvi4zc/ubm8CDDxOjR53i
         WqL3WZob/3+16BeTezIm4aGTf/hlP/P5vS8/jU1PHZ+2VSy1/e+77xa/+Bl17zHNH8
         eL9hQqmV44qiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6B3B05C0DEA; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Randy Dunlap <rdunlap@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/10] rcu: Fix various typos in comments
Date:   Tue, 11 May 2021 16:03:36 -0700
Message-Id: <20210511230336.2894314-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Fix ~12 single-word typos in RCU code comments.

[ paulmck: Apply feedback from Randy Dunlap. ]
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c                                     | 4 ++--
 kernel/rcu/sync.c                                         | 4 ++--
 kernel/rcu/tasks.h                                        | 8 ++++----
 kernel/rcu/tree.c                                         | 4 ++--
 kernel/rcu/tree.h                                         | 2 +-
 kernel/rcu/tree_plugin.h                                  | 2 +-
 .../selftests/rcutorture/formal/srcu-cbmc/src/locks.h     | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b34ad3..036ff5499ad5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -777,9 +777,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	spin_unlock_irqrestore_rcu_node(sdp, flags);
 
 	/*
-	 * No local callbacks, so probabalistically probe global state.
+	 * No local callbacks, so probabilistically probe global state.
 	 * Exact information would require acquiring locks, which would
-	 * kill scalability, hence the probabalistic nature of the probe.
+	 * kill scalability, hence the probabilistic nature of the probe.
 	 */
 
 	/* First, see if enough time has passed since the last GP. */
diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index d4558ab7a07d..33d896d85902 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -94,9 +94,9 @@ static void rcu_sync_func(struct rcu_head *rhp)
 		rcu_sync_call(rsp);
 	} else {
 		/*
-		 * We're at least a GP after the last rcu_sync_exit(); eveybody
+		 * We're at least a GP after the last rcu_sync_exit(); everybody
 		 * will now have observed the write side critical section.
-		 * Let 'em rip!.
+		 * Let 'em rip!
 		 */
 		WRITE_ONCE(rsp->gp_state, GP_IDLE);
 	}
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5051f9..da906b7f3a86 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -23,7 +23,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
- * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
+ * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
  * @cbs_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
@@ -504,7 +504,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
  * or transition to usermode execution.  As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-strcuture synchronization.
+ * through a safe state, not so much for data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -637,7 +637,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1163,7 +1163,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  * there are no read-side primitives analogous to rcu_read_lock() and
  * rcu_read_unlock() because this primitive is intended to determine
  * that all tasks have passed through a safe state, not so much for
- * data-strcuture synchronization.
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5f1545aab9ed..0b06be554c34 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2489,7 +2489,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
- * period.  Thottle as specified by rdp->blimit.
+ * period.  Throttle as specified by rdp->blimit.
  */
 static void rcu_do_batch(struct rcu_data *rdp)
 {
@@ -4094,7 +4094,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
- * must hold the corresponding leaf rcu_node ->lock with interrrupts
+ * must hold the corresponding leaf rcu_node ->lock with interrupts
  * disabled.
  */
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9a16487edfca..c1ed047cb128 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -153,7 +153,7 @@ struct rcu_data {
 	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
-	bool		core_needs_qs;	/* Core waits for quiesc state. */
+	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
 	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dfb048ec559f..b0c3fb4379c3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2857,7 +2857,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	waslocked = raw_spin_is_locked(&rdp->nocb_gp_lock);
 	wassleep = swait_active(&rdp->nocb_gp_wq);
 	if (!rdp->nocb_gp_sleep && !waslocked && !wassleep)
-		return;  /* Nothing untowards. */
+		return;  /* Nothing untoward. */
 
 	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c %c\n",
 		"lL"[waslocked],
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
index cf6938d679d7..1e24827f96f1 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
@@ -174,7 +174,7 @@ static inline bool spin_trylock(spinlock_t *lock)
 }
 
 struct completion {
-	/* Hopefuly this won't overflow. */
+	/* Hopefully this won't overflow. */
 	unsigned int count;
 };
 
-- 
2.31.1.189.g2e36527f23

