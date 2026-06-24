Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB73BAD95;
	Wed, 24 Jun 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307475; cv=none; b=GlTgHNrpy4IrLuaZnRwUS+wQ1vSjw4rYa+le8L3UvkWRzpb1ajfkCDVPmIj0ZFJZOy1EWmp0twLpTgqL597bsUfoX9W6cuZNXXjvWvPi7umHSXiGnIJeTxYPXisvVLzhQ4oRwoXte7bLRXDlB+fk63fpb8JOw8WyFDFp9l71Kbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307475; c=relaxed/simple;
	bh=Tf8XWeFmNP5JNCZuBfjlMyzF2RBgPvBxV/KcuaMlQfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKze2l0OjVpt/MVKqWpsECus9OHhGeaQWe55ci4U5kzyASjRvdHB/FPlsFXphy6QG/8fye+55Ou3Ah2lniEn90W6A9asupJrqtVgAQrS1APwOUHIp1X2pa5CHQaoPQ2T6SMzAFdGuQFMX6/hoW0uykJeziu4L86EuxeVasCMee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhGdquwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhGdquwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF94C1F000E9;
	Wed, 24 Jun 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307474;
	bh=cAmeKvf8S3AEy8rD7Hi3eS66yMk3Siq5yFHfhRZikdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhGdquwIPjKzeFS2YCwfRtc5088s+AdRidjIwqjR/YxVufItsCeUaG9ZzqjSjJs5I
	 dpKapoFjx0vWjTtKF+iWzBz/NRJZ1ovb5wi9E+lt2GrFlU7Z3FtaNlAnODCo5pAd4W
	 yqy/qTkpp9KlXeGuKOUNNuqB3EkvhUSdKgOSykhXDlePRt8u+LaRvdWgO3JGw6OcrG
	 Zx5OAup1AqS99BpCOsBaeILB3Bj2ITCGAguPRWSvepo4qcccx8gLuDEzsR0ehJOzXn
	 3XBENHu0cOArkfvG0WflT/tzysXhx3+6Odb4gIH+Zwp6QPmgxxkimlTmIYy38ccuYh
	 jsczrpsAknr8g==
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
Subject: [PATCH v1 04/11] rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
Date: Wed, 24 Jun 2026 06:23:46 -0700
Message-ID: <20260624132356.516959-5-puranjay@kernel.org>
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

Change the type of the per-segment ->gp_seq[] array in struct
rcu_segcblist from unsigned long to struct rcu_gp_seq.  This prepares the
callback tracking infrastructure to record both normal and expedited
grace periods per segment.

The rcu_segcblist_nextgp(), rcu_segcblist_advance(), and
rcu_segcblist_accelerate() helpers now take a struct rcu_gp_seq * instead
of an unsigned long, and all callers use the .norm field for comparisons
and assignments.  The SRCU and Tasks RCU wrappers construct a struct
rcu_gp_seq with only .norm set and forward to the core helpers.

No functional change: only the .norm field is used.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/rcu_segcblist.h |  2 +-
 include/trace/events/rcu.h    |  5 +++--
 kernel/rcu/rcu_segcblist.c    | 24 ++++++++++++++----------
 kernel/rcu/rcu_segcblist.h    |  6 +++---
 kernel/rcu/tree.c             | 25 ++++++++++++++-----------
 kernel/rcu/tree_nocb.h        | 21 +++++++++++----------
 6 files changed, 46 insertions(+), 37 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 2fdc2208f1ca3..137cc23b024c5 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -190,7 +190,7 @@ struct rcu_cblist {
 struct rcu_segcblist {
 	struct rcu_head *head;
 	struct rcu_head **tails[RCU_CBLIST_NSEGS];
-	unsigned long gp_seq[RCU_CBLIST_NSEGS];
+	struct rcu_gp_seq gp_seq[RCU_CBLIST_NSEGS];
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_t len;
 #else
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5fbdabe3faead..c84309c388343 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -547,10 +547,11 @@ TRACE_EVENT_RCU(rcu_segcb_stats,
 		),
 
 		TP_fast_assign(
+			int i;
 			__entry->ctx = ctx;
 			memcpy(__entry->seglen, rs->seglen, RCU_CBLIST_NSEGS * sizeof(long));
-			memcpy(__entry->gp_seq, rs->gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
-
+			for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+				__entry->gp_seq[i] = rs->gp_seq[i].norm;
 		),
 
 		TP_printk("%s seglen: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld) "
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 421f1dadb5e55..4e3dfe42bc097 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -307,13 +307,13 @@ struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp)
 
 /*
  * Return false if there are no CBs awaiting grace periods, otherwise,
- * return true and store the nearest waited-upon grace period into *lp.
+ * return true and store the nearest waited-upon grace period state into *gsp.
  */
-bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
+bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
 {
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return false;
-	*lp = rsclp->gp_seq[RCU_WAIT_TAIL];
+	*gsp = rsclp->gp_seq[RCU_WAIT_TAIL];
 	return true;
 }
 
@@ -496,7 +496,7 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
  * Advance the callbacks in the specified rcu_segcblist structure based
  * on the current value passed in for the grace-period counter.
  */
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
 {
 	int i;
 
@@ -509,7 +509,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
 	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
-		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
+		if (ULONG_CMP_LT(gsp->norm, rsclp->gp_seq[i].norm))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
 		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
@@ -537,7 +537,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  * ready to invoke.  Returns true if there are callbacks that won't be
  * ready to invoke until seq, false otherwise.
  */
-bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
+bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
 {
 	int i, j;
 
@@ -555,7 +555,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 */
 	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
 		if (!rcu_segcblist_segempty(rsclp, i) &&
-		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
+		    ULONG_CMP_LT(rsclp->gp_seq[i].norm, gsp->norm))
 			break;
 
 	/*
@@ -595,7 +595,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 */
 	for (; i < RCU_NEXT_TAIL; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
-		rsclp->gp_seq[i] = seq;
+		rsclp->gp_seq[i].norm = gsp->norm;
 	}
 	return true;
 }
@@ -637,10 +637,14 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 
 void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	rcu_segcblist_advance(rsclp, seq);
+	struct rcu_gp_seq gs = { .norm = seq };
+
+	rcu_segcblist_advance(rsclp, &gs);
 }
 
 bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	return rcu_segcblist_accelerate(rsclp, seq);
+	struct rcu_gp_seq gs = { .norm = seq };
+
+	return rcu_segcblist_accelerate(rsclp, &gs);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 956f2967d9d29..16b0cb6b32507 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -124,7 +124,7 @@ bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
-bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
+bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp);
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
@@ -139,8 +139,8 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
-bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp);
+bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
 void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index af4b6daf6a0ff..1d65505460bc7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1142,7 +1142,7 @@ static void rcu_gp_kthread_wake(void)
  */
 static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	unsigned long gp_seq_req;
+	struct rcu_gp_seq gs;
 	bool ret = false;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
@@ -1164,15 +1164,15 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
-		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
+	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
+	if (rcu_segcblist_accelerate(&rdp->cblist, &gs))
+		ret = rcu_start_this_gp(rnp, rdp, gs.norm);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, gs.norm, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, gs.norm, TPS("AccReadyCB"));
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
 
@@ -1189,14 +1189,14 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 					struct rcu_data *rdp)
 {
-	unsigned long c;
+	struct rcu_gp_seq gs;
 	bool needwake;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
-	c = rcu_seq_snap(&rcu_state.gp_seq);
-	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
+	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
+	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, gs.norm)) {
 		/* Old request still live, so mark recent callbacks. */
-		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
+		(void)rcu_segcblist_accelerate(&rdp->cblist, &gs);
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -1218,6 +1218,8 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
  */
 static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
+	struct rcu_gp_seq gs;
+
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1229,7 +1231,8 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * Find all callbacks whose ->gp_seq numbers indicate that they
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
 	 */
-	rcu_segcblist_advance(&rdp->cblist, rnp->gp_seq);
+	gs.norm = rnp->gp_seq;
+	rcu_segcblist_advance(&rdp->cblist, &gs);
 
 	/* Classify any remaining callbacks. */
 	return rcu_accelerate_cbs(rnp, rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 373b877cf171d..e0274a2e1c1ae 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -433,7 +433,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				bool lazy)
 {
 	unsigned long c;
-	unsigned long cur_gp_seq;
+	struct rcu_gp_seq cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	long lazy_len = READ_ONCE(rdp->lazy_len);
@@ -502,7 +502,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		}
 		if (j != rdp->nocb_gp_adv_time &&
 		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
+		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq.norm)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
@@ -659,7 +659,7 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool bypass = false;
 	int __maybe_unused cpu = my_rdp->cpu;
-	unsigned long cur_gp_seq;
+	struct rcu_gp_seq cur_gp_seq;
 	unsigned long flags;
 	bool gotcbs = false;
 	unsigned long j = jiffies;
@@ -731,7 +731,7 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
 		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
+		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq.norm))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
 			wasempty = rcu_segcblist_restempty(&rdp->cblist,
@@ -744,8 +744,8 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 						      RCU_NEXT_READY_TAIL));
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
 			if (!needwait_gp ||
-			    ULONG_CMP_LT(cur_gp_seq, wait_gp_seq))
-				wait_gp_seq = cur_gp_seq;
+			    ULONG_CMP_LT(cur_gp_seq.norm, wait_gp_seq))
+				wait_gp_seq = cur_gp_seq.norm;
 			needwait_gp = true;
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("NeedWaitGP"));
@@ -877,7 +877,7 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
 static void nocb_cb_wait(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	unsigned long cur_gp_seq;
+	struct rcu_gp_seq cur_gp_seq;
 	unsigned long flags;
 	bool needwake_gp = false;
 	struct rcu_node *rnp = rdp->mynode;
@@ -919,7 +919,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
 	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
-	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
+	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq.norm) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
@@ -1569,9 +1569,10 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      nocb_entry_rdp);
 
 	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
-	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL], rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL],
+		rsclp->gp_seq[RCU_WAIT_TAIL].norm);
 	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
-		      rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+		rsclp->gp_seq[RCU_NEXT_READY_TAIL].norm);
 	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
 	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
-- 
2.53.0-Meta

