Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC3C4742C
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6FE2085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuCgj7K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgKMMOq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbgKMMOm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:42 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E036922249;
        Fri, 13 Nov 2020 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269681;
        bh=d41iGxWWsxP2tZ4/4D/fXkgQN6a/XJPQnStNFz5HMag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuCgj7K1Y31IvRz+uZmYi18OudmaQPMzimoZVyMYZdq+i5RtkQBmjfVpN/HmHnXN1
         zF8ceu6rfyk3pQeiQKu68Uxo8XYfSebt2QBUZAInHKgv562Y53vT12rbKFR/2OmUi3
         nawFEgZH86gKc83WvXsQMj6U3fp9Nla6jad4zQIM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 19/19] rcu/nocb: Detect unsafe checks for offloaded rdp
Date:   Fri, 13 Nov 2020 13:13:34 +0100
Message-Id: <20201113121334.166723-20-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Provide CONFIG_PROVE_RCU sanity checks to ensure we are always reading
the offloaded state of an rdp in a safe and stable way and prevent from
its value to be changed under us. We must either hold the barrier mutex,
the cpu-hotplug lock (read or write) or the nocb lock.
Local non-preemptible reads are also safe. NOCB kthreads and timers have
their own means of synchronization against the offloaded state updaters.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c        | 21 +++++-----
 kernel/rcu/tree_plugin.h | 90 +++++++++++++++++++++++++++++++++-------
 2 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b24d60a52f34..5293444b9683 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,6 +154,7 @@ static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
+static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
 /* rcuc/rcub kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
@@ -1617,7 +1618,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2068,7 +2069,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_rdp_is_offloaded(rdp);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2267,7 +2268,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2436,7 +2437,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
 	unsigned long flags;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2992,7 +2993,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3766,13 +3767,13 @@ static int rcu_pending(int user)
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
 
@@ -3891,7 +3892,7 @@ void rcu_barrier(void)
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (cpu_is_offline(cpu) &&
-		    !rcu_segcblist_is_offloaded(&rdp->cblist))
+		    !rcu_rdp_is_offloaded(rdp))
 			continue;
 		if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
 			rcu_barrier_trace(TPS("OnlineQ"), cpu,
@@ -4210,7 +4211,7 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
-	if (rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	if (rcu_rdp_is_offloaded(rdp) ||
 	    rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
 
@@ -4228,7 +4229,7 @@ void rcutree_migrate_callbacks(int cpu)
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
 		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
-	if (rcu_segcblist_is_offloaded(&my_rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
 	} else {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ada4b875e489..224bf66b84d0 100644
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
@@ -1256,7 +1318,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
 	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
-	       !rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist);
+		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
 
 /*
@@ -1351,7 +1413,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 
 	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
 	if (rcu_segcblist_empty(&rdp->cblist) ||
-	    rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist)) {
+	    rcu_rdp_is_offloaded(rdp)) {
 		*nextevt = KTIME_MAX;
 		return 0;
 	}
@@ -1387,7 +1449,7 @@ static void rcu_prepare_for_idle(void)
 	int tne;
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		return;
 
 	/* Handle nohz enablement switches conservatively. */
@@ -1428,7 +1490,7 @@ static void rcu_cleanup_after_idle(void)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		return;
 	if (rcu_try_advance_all_cbs())
 		invoke_rcu_core();
@@ -1559,7 +1621,7 @@ static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
 static void rcu_nocb_lock(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (!rcu_rdp_is_offloaded(rdp))
 		return;
 	raw_spin_lock(&rdp->nocb_lock);
 }
@@ -1570,7 +1632,7 @@ static void rcu_nocb_lock(struct rcu_data *rdp)
  */
 static void rcu_nocb_unlock(struct rcu_data *rdp)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		lockdep_assert_irqs_disabled();
 		raw_spin_unlock(&rdp->nocb_lock);
 	}
@@ -1583,7 +1645,7 @@ static void rcu_nocb_unlock(struct rcu_data *rdp)
 static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 				       unsigned long flags)
 {
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		lockdep_assert_irqs_disabled();
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 	} else {
@@ -1595,7 +1657,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (rcu_rdp_is_offloaded(rdp))
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
@@ -1687,7 +1749,7 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 {
 	struct rcu_cblist rcl;
 
-	WARN_ON_ONCE(!rcu_segcblist_is_offloaded(&rdp->cblist));
+	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
 	lockdep_assert_held(&rdp->nocb_bypass_lock);
 	if (rhp && !rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
@@ -1715,7 +1777,7 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j)
 {
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
@@ -1729,7 +1791,7 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 {
 	rcu_lockdep_assert_cblist_protected(rdp);
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist) ||
+	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
 	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
@@ -1761,7 +1823,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (!rcu_rdp_is_offloaded(rdp)) {
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
@@ -2383,7 +2445,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	}
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
 		} else {
@@ -2459,7 +2521,7 @@ int rcu_nocb_cpu_offload(int cpu)
 
 	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
-	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
 		} else {
-- 
2.25.1

