Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F992EEE62;
	Fri, 31 Jul 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459459; cv=none; b=nSU+KDSyL9AOdhgILbIblDSAvZSgw2nwCTuvMet0uNlAPvGaJrijov0u5Y9SC2bqws4o+p8oCgn2p+t32vXxWiHu1MehvY+I5kr/jrEoTHj74n72ZpGDi11JkTBRia23a+eIVRXc5nt366nMqqwbrKfUoHxWtZGPF1jWL54imxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459459; c=relaxed/simple;
	bh=zO0XGxofTaaNPsGnJVcVUWw4ivyjn9q3Je5zroHFlA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSSjBU61unHPMEZPs/J8I2yjAzUNgWzhH0chLH0n5pwz75uWPZ6USRKHgUG0piroLzWecIbzHtJ2wnyZ9KbwIg5xIg0taOWV31YEIGvJK6h9+XKm0xZG5aWD/mfABPUjN38tc9s4f25VxRDntDMaCvO5VgMF5X5n5BM6iD/0fPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLvflZO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLvflZO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17EB1F00A3D;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=XjjmnlG53+qYKgr4Fb0zEuMcJyobUFqi29vyQuHKNCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLvflZO6OdHKpBBc0hbfRM5G7MVHm1mwF7szZZpCGzxdtmr0kOG+iBWdjt91QNY+b
	 J7KG/daMUnH5vKHMuUkecaM+nNQEBNzFP4RcFyInG4RA1vKsoCjLxEASbUNOvkjDWu
	 EyZQvYJq552Ku8oQmX4C4hdfv6RY5/6G4GbqE2huTdtFt8hkXlq7kXMD6R+SmePzsh
	 YtQlg7eYXo8rMpXpMDVqKgLV0fjO8uJ43gWBiGmBH7pde/ulLIQkQHRG4dtr6SLRvN
	 zipCamvK2uvVwhKFxPEYqEBdtIkKwV6Cd+T/JiNsXaeeIz7nv7hJx7FgwSJkBRVuv6
	 wtJ0sKPLN6m4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49864CE14D9; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 09/12] rcu: Wake NOCB rcuog kthreads on expedited grace period completion
Date: Thu, 30 Jul 2026 17:57:29 -0700
Message-Id: <20260731005732.3530999-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
References: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

When an expedited grace period completes, rcu_exp_wait_wake() wakes
waiters on rnp->exp_wq[] but does not notify the NOCB rcuog kthreads.  An
rcuog kthread that is waiting for a grace period sleeps on the leaf
rcu_node's ->nocb_gp_wq[] with a wait condition based on the grace-period
state, so without a wakeup, callbacks on offloaded CPUs that could
benefit from the expedited GP wait until the rcuog kthread wakes for some
other reason (e.g. the next normal GP or a timer).

Make the rcuog grace-period wait honour expedited GPs and wake it when
one completes:

 - nocb_gp_wait() now records the grace period to wait for as a struct
   rcu_gp_seq (both normal and expedited), tracks the earliest pending
   normal and expedited sequence across the group, and releases the wait
   via poll_state_synchronize_rcu_full() so it wakes for whichever
   completes first.  ->nocb_gp_seq is widened to struct rcu_gp_seq
   accordingly.

 - rcu_exp_wait_wake() calls the new rcu_nocb_exp_cleanup() on leaf
   nodes, which wakes both ->nocb_gp_wq[0] and ->nocb_gp_wq[1] (the
   expedited sequence does not share parity with the normal ->gp_seq the
   waiter indexed with).  Both this path and rcu_nocb_gp_cleanup() use
   the shared rcu_nocb_cleanup_wake() helper, which checks swait_active()
   first; the smp_mb() in rcu_gp_cleanup()/rcu_exp_wait_wake() orders the
   grace-period state update before that check.

A stub rcu_nocb_exp_cleanup() is provided for CONFIG_RCU_NOCB_CPU=n.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c      | 11 ++++-
 kernel/rcu/tree.h      |  3 +-
 kernel/rcu/tree_exp.h  |  2 +
 kernel/rcu/tree_nocb.h | 95 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa11e9a048302d..251114eb974bca 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2219,8 +2219,15 @@ static noinline void rcu_gp_cleanup(void)
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
-		if (!rnp->parent)
-			smp_mb(); // Order against failing poll_state_synchronize_rcu_full().
+		if (!rnp->parent) {
+			/*
+			 * Order against failing poll_state_synchronize_rcu_full(),
+			 * and also against rcu_nocb_gp_cleanup() -> swait_active(),
+			 * which relies on this barrier to observe a waiter that
+			 * enqueued before re-checking the grace-period state.
+			 */
+			smp_mb();
+		}
 		rdp = this_cpu_ptr(&rcu_data);
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rnp, rdp) || needgp;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7dfc57e9adb18e..01a1b2985abdeb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -253,7 +253,7 @@ struct rcu_data {
 	u8 nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
 	u8 nocb_gp_bypass;		/* Found a bypass on last scan? */
 	u8 nocb_gp_gp;			/* GP to wait for on last scan? */
-	unsigned long nocb_gp_seq;	/*  If so, ->gp_seq to wait for. */
+	struct rcu_gp_seq nocb_gp_seq; /* If so, GP state to wait for. */
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
@@ -498,6 +498,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7024131574df8a..1ab83c98af51c4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -708,6 +708,8 @@ static void rcu_exp_wait_wake(unsigned long s)
 		}
 		smp_mb(); /* All above changes before wakeup. */
 		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(s) & 0x3]);
+		if (rcu_is_leaf_node(rnp))
+			rcu_nocb_exp_cleanup(rnp);
 	}
 	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
 	mutex_unlock(&rcu_state.exp_wake_mutex);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 876dd897f18be3..afb35f921b3387 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -170,13 +170,35 @@ static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
+static void rcu_nocb_cleanup_wake(struct swait_queue_head *sq)
+{
+	if (swait_active(sq))
+		swake_up_all(sq);
+}
+
 /*
  * Wake up any no-CBs CPUs' kthreads that were waiting on the just-ended
  * grace period.
  */
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
-	swake_up_all(sq);
+	/*
+	 * swait_active() can be checked first because of the following
+	 * ordering, which pairs the smp_mb() in rcu_gp_cleanup() against
+	 * the implicit barrier in prepare_to_swait()/set_current_state()
+	 * on the nocb_gp_wait() side:
+	 *
+	 * rcu_gp_cleanup()                          nocb_gp_wait()
+	 * ---------------                           --------------
+	 * WRITE_ONCE(root->gp_seq, new_gp_seq);     swait_event_interruptible_exclusive(sq)
+	 * smp_mb()                                     prepare_to_swait()
+	 * if swait_active(sq)                             list_add_tail(...)
+	 *    swake_up_all(sq)                            set_current_state()
+	 *                                                  smp_mb()
+	 *                                             if (poll_state_synchronize_rcu_full())
+	 *                                                ...
+	 */
+	rcu_nocb_cleanup_wake(sq);
 }
 
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp)
@@ -190,6 +212,38 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
+/*
+ * Wake NOCB rcuog kthreads on a leaf node so that they can advance
+ * callbacks that were waiting for the just-completed expedited GP.
+ *
+ * The rcuog kthread waiting for a grace period sleeps on the per-leaf-node
+ * ->nocb_gp_wq[] (not on its rdp_gp's ->nocb_gp_wq, which only signals that
+ * new callbacks have shown up), so this is the queue that must be woken.
+ * Both the even and odd waitqueues are woken because the expedited sequence
+ * does not share parity with the normal ->gp_seq the waiter indexed with.
+ */
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp)
+{
+	/*
+	 * swait_active() can be checked first because of the following
+	 * ordering, which pairs the smp_mb() in rcu_exp_wait_wake() against
+	 * the implicit barrier in prepare_to_swait()/set_current_state()
+	 * on the nocb_gp_wait() side:
+	 *
+	 * rcu_exp_wait_wake()                          nocb_gp_wait()
+	 * ---------------                              --------------
+	 * rcu_seq_end(&rcu_state.expedited_sequence);  swait_event_interruptible_exclusive(sq)
+	 * smp_mb()                                         prepare_to_swait()
+	 * if swait_active(sq)                                 list_add_tail(...)
+	 *    swake_up_all(sq)                                set_current_state()
+	 *                                                      smp_mb()
+	 *                                                 if (poll_state_synchronize_rcu_full())
+	 *                                                    ...
+	 */
+	rcu_nocb_cleanup_wake(&rnp->nocb_gp_wq[0]);
+	rcu_nocb_cleanup_wake(&rnp->nocb_gp_wq[1]);
+}
+
 /* Clear any pending deferred wakeup timer (nocb_gp_lock must be held). */
 static void nocb_defer_wakeup_cancel(struct rcu_data *rdp_gp)
 {
@@ -659,7 +713,6 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool bypass = false;
 	int __maybe_unused cpu = my_rdp->cpu;
-	struct rcu_gp_seq cur_gp_seq;
 	unsigned long flags;
 	bool gotcbs = false;
 	unsigned long j = jiffies;
@@ -669,7 +722,7 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 	bool needwake_gp;
 	struct rcu_data *rdp, *rdp_toggling = NULL;
 	struct rcu_node *rnp;
-	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
+	struct rcu_gp_seq wait_gp_seq = {0}; // Suppress "use uninitialized" warning.
 	bool wasempty = false;
 
 	/*
@@ -693,6 +746,7 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * won't be ignored for long.
 	 */
 	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
+		struct rcu_gp_seq cur_gp_seq;
 		long bypass_ncbs;
 		bool flush_bypass = false;
 		long lazy_ncbs;
@@ -743,9 +797,15 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 						      RCU_NEXT_READY_TAIL));
 		// Need to wait on some grace period?
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
-			if (!needwait_gp ||
-			    ULONG_CMP_LT(cur_gp_seq.norm, wait_gp_seq))
-				wait_gp_seq = cur_gp_seq.norm;
+			/*
+			 * Track the earliest pending normal and expedited GP
+			 * across the group so the wait below can be released by
+			 * whichever completes first.
+			 */
+			if (!needwait_gp || ULONG_CMP_LT(cur_gp_seq.norm, wait_gp_seq.norm))
+				wait_gp_seq.norm = cur_gp_seq.norm;
+			if (!needwait_gp || ULONG_CMP_LT(cur_gp_seq.exp, wait_gp_seq.exp))
+				wait_gp_seq.exp = cur_gp_seq.exp;
 			needwait_gp = true;
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("NeedWaitGP"));
@@ -767,7 +827,8 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 
 	my_rdp->nocb_gp_bypass = bypass;
 	my_rdp->nocb_gp_gp = needwait_gp;
-	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
+	if (needwait_gp)
+		my_rdp->nocb_gp_seq = wait_gp_seq;
 
 	// At least one child with non-empty ->nocb_bypass, so set
 	// timer in order to avoid stranding its callbacks.
@@ -802,12 +863,12 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
-		trace_rcu_this_gp(rnp, wait_gp_seq, TPS("StartWait"));
+		trace_rcu_this_gp(rnp, wait_gp_seq.norm, TPS("StartWait"));
 		swait_event_interruptible_exclusive(
-			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
-			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
+			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq.norm) & 0x1],
+			poll_state_synchronize_rcu_full(&wait_gp_seq) ||
 			!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_this_gp(rnp, wait_gp_seq, TPS("EndWait"));
+		trace_rcu_this_gp(rnp, wait_gp_seq.norm, TPS("EndWait"));
 	}
 
 	if (!rcu_nocb_poll) {
@@ -841,7 +902,8 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		swake_up_one(&rdp_toggling->nocb_state_wq);
 	}
 
-	my_rdp->nocb_gp_seq = -1;
+	my_rdp->nocb_gp_seq.norm = -1;
+	my_rdp->nocb_gp_seq.exp = -1;
 	WARN_ON(signal_pending(current));
 }
 
@@ -1525,7 +1587,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
+	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld/%ld rnp %d:%d %lu %c CPU %d%s\n",
 		rdp->cpu,
 		"kK"[!!rdp->nocb_gp_kthread],
 		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
@@ -1537,7 +1599,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		".W"[swait_active(&rnp->nocb_gp_wq[1])],
 		".B"[!!rdp->nocb_gp_bypass],
 		".G"[!!rdp->nocb_gp_gp],
-		(long)rdp->nocb_gp_seq,
+		(long)rdp->nocb_gp_seq.norm,
+		(long)rdp->nocb_gp_seq.exp,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
 		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
@@ -1657,6 +1720,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp)
+{
+}
+
 static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
-- 
2.40.1

