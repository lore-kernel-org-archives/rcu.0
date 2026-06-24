Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD1246782;
	Wed, 24 Jun 2026 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307492; cv=none; b=PaRtwgmGJspqAkxnFept+4wZJcMcuKOsxmaZVfGKuOYH074Qy03f6BBhVFVZAdXOTyJ7Sf/qEKRan4hUQh+9dJgJN5yiSxhV10KDXi61C550wY0v8GOQM68BWMEyMyzn45S+wpo7kre8zZGnMjAu1wTth8y+T+YS/2vp/11CL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307492; c=relaxed/simple;
	bh=0pQhSW8mhjoVCMXKhqt25SbJ17jW/hghSyno4iy8g3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEk4n9WvId8tE2uKHyus7Tvt4Cj2x7TCtGTjXAOyWQLgw775KrlL6wsk29Du2qLq1RqQuAM5tdlDGABDzBFmmt9JVFttugNj5e7QWsAb9SaKQI7w/BEcdK/7SFVOUfpDBJaK47HU/u8dWB6rlxuBWkdNYwr7SjeGY//2w2J0tVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNC1oyOX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNC1oyOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75841F00A3A;
	Wed, 24 Jun 2026 13:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307488;
	bh=+vNizmGQ1/AKgw4WOuPtkJNKLNL4EZgR9Tv2TQkkO3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNC1oyOXxPnoRZqaXL8S/MatYLYidOA0lTGZrbhWBUDtNvqwAUFG32gK+P85kwTZX
	 qzok1p1c4uz4tsfI1NzeyBRhTmFYcDVgzn5oFP62o8C8T/sR7UZRBc1owHu3f+3x7X
	 RjD1AaKQEuE5jDRjQ1mMPXnoLsD/PsD/uWJ4XfcEwjEKAdgf6RCwBBW6eaYeGb228H
	 H9WY0Lbk2BkWpAi4DyO7NGZVYDukdgu4hQk29RF1mweCrAP3CT2HCuCQhcXtWb6RMJ
	 /w8A73IuOR5sWTQd3L0yVzGbKy+3vh8M/BxHE4Rqko4ooPSD/5YlvkTjMYf01uuKEl
	 WWVU/RsnpBGcg==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 08/11] rcu: Wake NOCB rcuog kthreads on expedited grace period completion
Date: Wed, 24 Jun 2026 06:23:50 -0700
Message-ID: <20260624132356.516959-9-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624132356.516959-1-puranjay@kernel.org>
References: <20260624132356.516959-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tree.c      | 11 ++++-
 kernel/rcu/tree.h      |  3 +-
 kernel/rcu/tree_exp.h  |  2 +
 kernel/rcu/tree_nocb.h | 95 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d7e47dfcf702e..169d98ed52bbb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2224,8 +2224,15 @@ static noinline void rcu_gp_cleanup(void)
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
index 36330739d937c..79d3a656e5f73 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -268,7 +268,7 @@ struct rcu_data {
 	u8 nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
 	u8 nocb_gp_bypass;		/* Found a bypass on last scan? */
 	u8 nocb_gp_gp;			/* GP to wait for on last scan? */
-	unsigned long nocb_gp_seq;	/*  If so, ->gp_seq to wait for. */
+	struct rcu_gp_seq nocb_gp_seq; /* If so, GP state to wait for. */
 	unsigned long nocb_gp_loops;	/* # passes through wait code. */
 	struct swait_queue_head nocb_gp_wq; /* For nocb kthreads to sleep on. */
 	bool nocb_cb_sleep;		/* Is the nocb CB thread asleep? */
@@ -511,6 +511,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
+static void rcu_nocb_exp_cleanup(struct rcu_node *rnp);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0569d8e40e86d..5c35e28708640 100644
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
index 263bb8a65a988..6da1b8f524768 100644
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
@@ -754,9 +808,15 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		 */
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
 		    !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
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
@@ -778,7 +838,8 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 
 	my_rdp->nocb_gp_bypass = bypass;
 	my_rdp->nocb_gp_gp = needwait_gp;
-	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
+	if (needwait_gp)
+		my_rdp->nocb_gp_seq = wait_gp_seq;
 
 	// At least one child with non-empty ->nocb_bypass, so set
 	// timer in order to avoid stranding its callbacks.
@@ -813,12 +874,12 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
+		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq.norm, TPS("StartWait"));
 		swait_event_interruptible_exclusive(
-			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
-			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
+			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq.norm) & 0x1],
+			poll_state_synchronize_rcu_full(&wait_gp_seq) ||
 			!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
+		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq.norm, TPS("EndWait"));
 	}
 
 	if (!rcu_nocb_poll) {
@@ -852,7 +913,8 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		swake_up_one(&rdp_toggling->nocb_state_wq);
 	}
 
-	my_rdp->nocb_gp_seq = -1;
+	my_rdp->nocb_gp_seq.norm = -1;
+	my_rdp->nocb_gp_seq.exp = -1;
 	WARN_ON(signal_pending(current));
 }
 
@@ -1536,7 +1598,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
+	pr_info("nocb GP %d %c%c%c%c%c %c[%c%c] %c%c:%ld/%ld rnp %d:%d %lu %c CPU %d%s\n",
 		rdp->cpu,
 		"kK"[!!rdp->nocb_gp_kthread],
 		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
@@ -1548,7 +1610,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		".W"[swait_active(&rnp->nocb_gp_wq[1])],
 		".B"[!!rdp->nocb_gp_bypass],
 		".G"[!!rdp->nocb_gp_gp],
-		(long)rdp->nocb_gp_seq,
+		(long)rdp->nocb_gp_seq.norm,
+		(long)rdp->nocb_gp_seq.exp,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
 		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
@@ -1668,6 +1731,10 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
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
2.53.0-Meta

