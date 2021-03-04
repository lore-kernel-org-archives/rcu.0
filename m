Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE73C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B5264EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhCDBA5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355385AbhCDAXx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:23:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3B7064E56;
        Thu,  4 Mar 2021 00:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817393;
        bh=8WQ3g84kz0p7iNJ8Gkk4N31oVvyO11luf0iCST2rRRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO41dFOs9w27yceah41akY/YYnxPN2+ty6iVhuiTaYLWjDPsWKafUXUlov2GXRqmJ
         abvZe7m7ZjSzfjEsKgw1kcj1CipurUwWgA6lsIcbgGqlCutDo5lbtxJghSPcdsTHer
         O2hX4QEuxcu2nn/w+AAzlfTxngvwx7jkvPTS/mod2nBCibbe5pN6cCoclHsonYinae
         S4p/eeex9AxDICYW7SNfmM6CbHm4Ha8WmJ0taPsRH7BQ3mLB4XKcDYH3FEMphjCZ+l
         i307rxr/Q80qyjF8eALgGGJIj/MfuWBd14E0RwzWs60bRcYxOSiMLk+vfnCsUOxURt
         VDz691mLPRFgQ==
From:   paulmck@kernel.org
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
Subject: [PATCH tip/core/rcu 01/12] rcu/nocb: Detect unsafe checks for offloaded rdp
Date:   Wed,  3 Mar 2021 16:23:00 -0800
Message-Id: <20210304002311.23655-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Provide CONFIG_PROVE_RCU sanity checks to ensure we are always reading
the offloaded state of an rdp in a safe and stable way and prevent from
its value to be changed under us. We must either hold the barrier mutex,
the cpu-hotplug lock (read or write) or the nocb lock.
Local non-preemptible reads are also safe. NOCB kthreads and timers have
their own means of synchronization against the offloaded state updaters.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 21 +++++------
 kernel/rcu/tree_plugin.h | 90 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..03503e2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -156,6 +156,7 @@ static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
+static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
 /* rcuc/rcub kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
@@ -1672,7 +1673,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2128,7 +2129,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2327,7 +2328,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2497,7 +2498,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -3066,7 +3067,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
 	/* Go handle any RCU core processing required. */
-	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3843,13 +3844,13 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	if (!rcu_rdp_is_offloaded(rdp) &&
 	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    !rcu_rdp_is_offloaded(rdp) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
@@ -3968,7 +3969,7 @@ void rcu_barrier(void)
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (cpu_is_offline(cpu) &&
-		    !rcu_segcblist_is_offloaded(&rdp->cblist))
+		    !rcu_rdp_is_offloaded(rdp))
 			continue;
 		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
@@ -4291,7 +4292,7 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
-	if (rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	if (rcu_rdp_is_offloaded(rdp) ||
 	    rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
 
@@ -4309,7 +4310,7 @@ void rcutree_migrate_callbacks(int cpu)
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
-	if (rcu_segcblist_is_offloaded(&my_rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..cd513ea 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -16,8 +16,70 @@
 #ifdef CONFIG_RCU_NOCB_CPU
 static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
 static bool __read_mostly rcu_nocb_poll;    /* Offload kthread are to poll. */
+static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
+{
+	return lockdep_is_held(&rdp->nocb_lock);
+}
+
+static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
+{
+	/* Race on early boot between thread creation and assignment */
+	if (!rdp->nocb_cb_kthread || !rdp->nocb_gp_kthread)
+		return true;
+
+	if (current == rdp->nocb_cb_kthread || current == rdp->nocb_gp_kthread)
+		if (in_task())
+			return true;
+	return false;
+}
+
+static inline bool rcu_running_nocb_timer(struct rcu_data *rdp)
+{
+	return (timer_curr_running(&rdp->nocb_timer) && !in_irq());
+}
+#else
+static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
+{
+	return 0;
+}
+
+static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
+{
+	return false;
+}
+
+static inline bool rcu_running_nocb_timer(struct rcu_data *rdp)
+{
+	return false;
+}
+
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
+static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
+{
+	/*
+	 * In order to read the offloaded state of an rdp is a safe
+	 * and stable way and prevent from its value to be changed
+	 * under us, we must either hold the barrier mutex, the cpu
+	 * hotplug lock (read or write) or the nocb lock. Local
+	 * non-preemptible reads are also safe. NOCB kthreads and
+	 * timers have their own means of synchronization against the
+	 * offloaded state updaters.
+	 */
+	RCU_LOCKDEP_WARN(
+		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
+		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
+		  rcu_lockdep_is_held_nocb(rdp) ||
+		  (rdp == this_cpu_ptr(&rcu_data) &&
+		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
+		  rcu_current_is_nocb_kthread(rdp) ||
+		  rcu_running_nocb_timer(rdp)),
+		"Unsafe read of RCU_NOCB offloaded state"
+	);
+
+	return rcu_segcblist_is_offloaded(&rdp->cblist);
+}
+
 /*
  * Check the RCU kernel configuration parameters and print informative
  * messages about anything out of the ordinary.
@@ -1257,7 +1319,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
 	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
-	       !rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist);
+		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
 
 /*
@@ -1352,7 +1414,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 
 	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
 	if (rcu_segcblist_empty(&rdp->cblist) ||
-	    rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist)) {
+	    rcu_rdp_is_offloaded(rdp)) {
 		*nextevt = KTIME_MAX;
 		return 0;
 	}
@@ -1388,7 +1450,7 @@ static void rcu_prepare_for_idle(void)
 	int tne;
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		return;
 
 	/* Handle nohz enablement switches conservatively. */
@@ -1429,7 +1491,7 @@ static void rcu_cleanup_after_idle(void)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		return;
 	if (rcu_try_advance_all_cbs())
 		invoke_rcu_core();
@@ -1560,7 +1622,7 @@ static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
 static void rcu_nocb_lock(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (!rcu_rdp_is_offloaded(rdp))
 		return;
 	raw_spin_lock(&rdp->nocb_lock);
 }
@@ -1571,7 +1633,7 @@ static void rcu_nocb_lock(struct rcu_data *rdp)
  */
 static void rcu_nocb_unlock(struct rcu_data *rdp)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		lockdep_assert_irqs_disabled();
 		raw_spin_unlock(&rdp->nocb_lock);
 	}
@@ -1584,7 +1646,7 @@ static void rcu_nocb_unlock(struct rcu_data *rdp)
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		lockdep_assert_irqs_disabled();
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	} else {
@@ -1596,7 +1658,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
@@ -1690,7 +1752,7 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 {
 	struct rcu_cblist rcl;
 
-	WARN_ON_ONCE(!rcu_segcblist_is_offloaded(&rdp->cblist));
+	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
 	lockdep_assert_held(&rdp->nocb_bypass_lock);
 	if (rhp && !rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
@@ -1718,7 +1780,7 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
@@ -1732,7 +1794,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 {
 	rcu_lockdep_assert_cblist_protected(rdp);
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
@@ -1764,7 +1826,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (!rcu_rdp_is_offloaded(rdp)) {
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
@@ -2397,7 +2459,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	}
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu))
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
 		else
@@ -2472,7 +2534,7 @@ int rcu_nocb_cpu_offload(int cpu)
 
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu))
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
 		else
-- 
2.9.5

