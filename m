Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80F1C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62B56191D
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhEKXEq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKXEp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9135561625;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=bTTiGV6pJ7S2YVVhmPJo+Oglyj3fHf76iaLIu7kJrg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwHkZqRgLJHYytEql/BSLobv0O88M8IpCJSVcqLw1WgSE++l37XBl1apMgUDC39S6
         W55iA3bRjURJ26xpihDcHnMiZJKBbNri6r2dYLiusuck84Nd41NST4uTbAgA4qqnSZ
         1ERVOq0uNaLAsEOirJYXeK5g+H0CzpgmxELYGFl1cuKAgzYqZniEWobIPIluSk+n40
         DwtgJwjU1YTnmvLbDCaJYpyVbYXTktfRPK4J7lgnJLxaWcsQ1/PjYzqp5fj5Y6+zDb
         ecrwcmYGUZtaZqitBRF1/ZFlXFnPl0gKPKIqeRx0tPitsB4Q38TPxjcN6Wq1JqxHFg
         l4DrNRbHe8ByA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 590805C0138; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/10] rcu/nocb: Use the rcuog CPU's ->nocb_timer
Date:   Tue, 11 May 2021 16:03:27 -0700
Message-Id: <20210511230336.2894314-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Currently each CPU has its own ->nocb_timer queued when the nocb_gp
wakeup must be deferred.  This approach has many drawbacks, compared to
a solution based on a single timer per NOCB group:

* There are a lot of timers to maintain.

* The per-rdp ->nocb_lock must be held to queue and cancel the timer
  and this lock can already be heavily contended.

* One timer firing doesn't cancel the other timers in the same group:
  - These other timers can thus cause spurious wakeups
  - Each rdp that queued a timer must lock both ->nocb_lock and then
    ->nocb_gp_lock upon exit from the kernel to idle/user/guest mode.

* We can't cancel all of them if we detect an unflushed bypass in
  nocb_gp_wait(). In fact currently we only ever cancel the ->nocb_timer
  of the leader group.

* The leader group's nocb_timer is cancelled without locking ->nocb_lock
  in nocb_gp_wait().  This currently appears to be safe but is an
  accident waiting to happen.

* Since the timer acquires ->nocb_lock, it requires extra care in the
  NOCB (de-)offloading process, requiring that it be either enabled or
  disabled and then flushed.

This commit instead uses the rcuog kthread's CPU's ->nocb_timer instead.
It is protected by nocb_gp_lock, which is _way_ less contended and
remains so even after this change.  As a matter of fact, the nocb_timer
almost never fires and the deferred wakeup is mostly carried out upon
idle/user/guest entry.  Now the early check performed at this point in
do_nocb_deferred_wakeup() is done on rdp_gp->nocb_defer_wakeup, which
is of course racy.  However, this raciness is harmless because we only
need the guarantee that the timer is queued if we were the last one to
queue it.  Any other situation (another CPU has queued it and we either
see it or not) is fine.

This solves all the issues listed above.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        |   1 -
 kernel/rcu/tree_plugin.h | 140 +++++++++++++++++++++------------------
 2 files changed, 77 insertions(+), 64 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 71821d59d95c..b280a843bd2c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -257,7 +257,6 @@ struct rcu_data {
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
-#define RCU_NOCB_WAKE_OFF	-1
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE		1
 #define RCU_NOCB_WAKE_FORCE	2
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ad0156b86937..5a2aa9c4e569 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -33,10 +33,6 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 	return false;
 }
 
-static inline bool rcu_running_nocb_timer(struct rcu_data *rdp)
-{
-	return (timer_curr_running(&rdp->nocb_timer) && !in_irq());
-}
 #else
 static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
 {
@@ -48,11 +44,6 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 	return false;
 }
 
-static inline bool rcu_running_nocb_timer(struct rcu_data *rdp)
-{
-	return false;
-}
-
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
@@ -72,8 +63,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		  rcu_lockdep_is_held_nocb(rdp) ||
 		  (rdp == this_cpu_ptr(&rcu_data) &&
 		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
-		  rcu_current_is_nocb_kthread(rdp) ||
-		  rcu_running_nocb_timer(rdp)),
+		  rcu_current_is_nocb_kthread(rdp)),
 		"Unsafe read of RCU_NOCB offloaded state"
 	);
 
@@ -1692,43 +1682,50 @@ bool rcu_is_nocb_cpu(int cpu)
 	return false;
 }
 
-/*
- * Kick the GP kthread for this NOCB group.  Caller holds ->nocb_lock
- * and this function releases it.
- */
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force,
-			 unsigned long flags)
-	__releases(rdp->nocb_lock)
+static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
+			   struct rcu_data *rdp,
+			   bool force, unsigned long flags)
+	__releases(rdp_gp->nocb_gp_lock)
 {
 	bool needwake = false;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
-	lockdep_assert_held(&rdp->nocb_lock);
 	if (!READ_ONCE(rdp_gp->nocb_gp_kthread)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 				    TPS("AlreadyAwake"));
 		return false;
 	}
 
-	if (READ_ONCE(rdp->nocb_defer_wakeup) > RCU_NOCB_WAKE_NOT) {
-		WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-		del_timer(&rdp->nocb_timer);
+	if (rdp_gp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+		del_timer(&rdp_gp->nocb_timer);
 	}
-	rcu_nocb_unlock_irqrestore(rdp, flags);
-	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+
 	if (force || READ_ONCE(rdp_gp->nocb_gp_sleep)) {
 		WRITE_ONCE(rdp_gp->nocb_gp_sleep, false);
 		needwake = true;
-		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
 	}
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
-	if (needwake)
+	if (needwake) {
+		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DoWake"));
 		wake_up_process(rdp_gp->nocb_gp_kthread);
+	}
 
 	return needwake;
 }
 
+/*
+ * Kick the GP kthread for this NOCB group.
+ */
+static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+{
+	unsigned long flags;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
+}
+
 /*
  * Arrange to wake the GP kthread for this NOCB group at some future
  * time when it is safe to do so.
@@ -1736,12 +1733,18 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force,
 static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 			       const char *reason)
 {
-	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_OFF)
-		return;
-	if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
-		mod_timer(&rdp->nocb_timer, jiffies + 1);
-	if (rdp->nocb_defer_wakeup < waketype)
-		WRITE_ONCE(rdp->nocb_defer_wakeup, waketype);
+	unsigned long flags;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+
+	if (rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT)
+		mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
+	if (rdp_gp->nocb_defer_wakeup < waketype)
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
+
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, reason);
 }
 
@@ -1968,13 +1971,14 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		rdp->qlen_last_fqs_check = len;
 		if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			wake_nocb_gp(rdp, false, flags);
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			wake_nocb_gp(rdp, false);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE,
 					   TPS("WakeEmptyIsDeferred"));
-			rcu_nocb_unlock_irqrestore(rdp, flags);
 		}
 	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
 		/* ... or if many callbacks queued. */
@@ -1989,10 +1993,14 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		smp_mb(); /* Enqueue before timer_pending(). */
 		if ((rdp->nocb_cb_sleep ||
 		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
-		    !timer_pending(&rdp->nocb_bypass_timer))
+		    !timer_pending(&rdp->nocb_bypass_timer)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					   TPS("WakeOvfIsDeferred"));
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		} else {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
+		}
 	} else {
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
@@ -2118,11 +2126,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			bypass = true;
 		}
 		rnp = rdp->mynode;
-		if (bypass) {  // Avoid race with first bypass CB.
-			WRITE_ONCE(my_rdp->nocb_defer_wakeup,
-				   RCU_NOCB_WAKE_NOT);
-			del_timer(&my_rdp->nocb_timer);
-		}
+
 		// Advance callbacks if helpful and low contention.
 		needwake_gp = false;
 		if (!rcu_segcblist_restempty(&rdp->cblist,
@@ -2168,11 +2172,18 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	my_rdp->nocb_gp_bypass = bypass;
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
-	if (bypass && !rcu_nocb_poll) {
-		// At least one child with non-empty ->nocb_bypass, so set
-		// timer in order to avoid stranding its callbacks.
+	if (bypass) {
 		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
-		mod_timer(&my_rdp->nocb_bypass_timer, j + 2);
+		// Avoid race with first bypass CB.
+		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+			del_timer(&my_rdp->nocb_timer);
+		}
+		if (!rcu_nocb_poll) {
+			// At least one child with non-empty ->nocb_bypass, so set
+			// timer in order to avoid stranding its callbacks.
+			mod_timer(&my_rdp->nocb_bypass_timer, j + 2);
+		}
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
 	if (rcu_nocb_poll) {
@@ -2344,15 +2355,18 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	int ndw;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	int ret;
 
-	rcu_nocb_lock_irqsave(rdp, flags);
-	if (!rcu_nocb_need_deferred_wakeup(rdp)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+
+	if (!rcu_nocb_need_deferred_wakeup(rdp_gp)) {
+		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 		return false;
 	}
-	ndw = READ_ONCE(rdp->nocb_defer_wakeup);
-	ret = wake_nocb_gp(rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
+
+	ndw = rdp_gp->nocb_defer_wakeup;
+	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -2373,7 +2387,10 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
  */
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 {
-	if (rcu_nocb_need_deferred_wakeup(rdp))
+	if (!rdp->nocb_gp_rdp)
+		return false;
+
+	if (rcu_nocb_need_deferred_wakeup(rdp->nocb_gp_rdp))
 		return do_nocb_deferred_wakeup_common(rdp);
 	return false;
 }
@@ -2443,17 +2460,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	rcu_nocb_lock_irqsave(rdp, flags);
-	/* Make sure nocb timer won't stay around */
-	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
-	del_timer_sync(&rdp->nocb_timer);
-
 	/*
-	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY with CB unlocked
-	 * and IRQs disabled but let's be paranoid.
+	 * Lock one last time to acquire latest callback updates from kthreads
+	 * so we can later handle callbacks locally without locking.
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
+	/*
+	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY after the nocb
+	 * lock is released but how about being paranoid for once?
+	 */
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
 	/*
 	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
@@ -2517,8 +2532,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 * SEGCBLIST_SOFTIRQ_ONLY mode.
 	 */
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-	/* Re-enable nocb timer */
-	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+
 	/*
 	 * We didn't take the nocb lock while working on the
 	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
-- 
2.31.1.189.g2e36527f23

