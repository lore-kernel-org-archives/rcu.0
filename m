Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661B37F8BC;
	Fri, 17 Apr 2026 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467564; cv=none; b=NoFnl0/SUjCqlKh6Zf3YukWbTm8OVX+vFIRPH/VAhao1q4HpaIEq1vW4s81a5o3RtSYLhvh17hqJqwe8xfXp9UlyLlFBfXlTQXBcQnuNCODNVDoiLvAEzB5boSj4vbIMQW0CjPE8iB9xi413+DIjIt89zXDEJ4Xsb2SAdet6jQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467564; c=relaxed/simple;
	bh=wrXdBi5brAzJbWSmNWhO65bT1HBCk/2mh00lko23neI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amQ3523z5DDIVDpH1d79+CLNb1xK5VEi3e2evt2qPe6i16UpWdUwrMlCbcoIl6vNj70Mgl14mTa+YFSV8BJE/aDcDtELoTQ2TkBL81kmAxGB79RnDIULZvJoWwIdzzKTjDIAPJbmVZEDxWrZdseQoSzDY2pWNaIKwBrd6qLlW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0JD3aV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0JD3aV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A22C19425;
	Fri, 17 Apr 2026 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467563;
	bh=wrXdBi5brAzJbWSmNWhO65bT1HBCk/2mh00lko23neI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0JD3aV5hrSiyMrLH5PbIml8lYGzKExRlE0PDME2m6ZN/v4IZ7SWw6Q/cLEOV1+iY
	 4iDNf5dJl0tW4f98/dYS7BAlBHbYDlTirdrAf+JjXmrL3D/TRMTkuD1o4IjhaEckDz
	 CesDyLKYZ/vtowv/kwH/LpOZEZj4I2zDoa/fncNdR9J5Dhlc9KR0Ugxktxtwr0prD3
	 Pom52d65ljSSggyoM3gyRSMmvhfvTVCt7oLBCRlzM4B5NjoAEK2dMZoamffJ5/krhK
	 40uKDE35vivah6tvRr6JzF+WT+K0DJwPyM+flSFuRv5LNllWnBkFNmxO/rDwADd4Ol
	 kMBT/qMNLe72Q==
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
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH 03/10] rcu/segcblist: Change gp_seq to struct rcu_gp_oldstate gp_seq_full
Date: Fri, 17 Apr 2026 16:11:51 -0700
Message-ID: <20260417231203.785172-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417231203.785172-1-puranjay@kernel.org>
References: <20260417231203.785172-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit renames the ->gp_seq[] field in struct rcu_segcblist to
->gp_seq_full[] and changes its type from unsigned long to struct
rcu_gp_oldstate. This prepares the callback tracking infrastructure to
support both normal and expedited grace periods.

All function signatures are updated to pass struct rcu_gp_oldstate
pointers: rcu_segcblist_nextgp(), rcu_segcblist_advance(), and
rcu_segcblist_accelerate() now take struct rcu_gp_oldstate * instead of
unsigned long. All callers are updated to use the .rgos_norm field for
comparisons and assignments.

The SRCU and Tasks RCU wrappers now construct an rcu_gp_oldstate with
just .rgos_norm set and forward to the core functions.

No functional change: only the .rgos_norm field is used in place of
gp_seq.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/rcu_segcblist.h |  2 +-
 include/trace/events/rcu.h    |  5 +++--
 kernel/rcu/rcu_segcblist.c    | 30 +++++++++++++++++-------------
 kernel/rcu/rcu_segcblist.h    |  6 +++---
 kernel/rcu/tree.c             | 25 ++++++++++++++-----------
 kernel/rcu/tree_nocb.h        | 29 +++++++++++++++--------------
 6 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 2fdc2208f1ca..59c68f2ba113 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -190,7 +190,7 @@ struct rcu_cblist {
 struct rcu_segcblist {
 	struct rcu_head *head;
 	struct rcu_head **tails[RCU_CBLIST_NSEGS];
-	unsigned long gp_seq[RCU_CBLIST_NSEGS];
+	struct rcu_gp_oldstate gp_seq_full[RCU_CBLIST_NSEGS];
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_t len;
 #else
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5fbdabe3faea..2b859b274592 100644
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
+				__entry->gp_seq[i] = rs->gp_seq_full[i].rgos_norm;
 		),
 
 		TP_printk("%s seglen: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld) "
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 421f1dadb5e5..00e164db8b74 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -238,8 +238,8 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 {
 	int i;
 
-	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
-	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
+	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq_full));
+	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq_full));
 	rsclp->head = NULL;
 	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
 		rsclp->tails[i] = &rsclp->head;
@@ -307,13 +307,13 @@ struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp)
 
 /*
  * Return false if there are no CBs awaiting grace periods, otherwise,
- * return true and store the nearest waited-upon grace period into *lp.
+ * return true and store the nearest waited-upon grace period state into *rgosp.
  */
-bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
+bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)
 {
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return false;
-	*lp = rsclp->gp_seq[RCU_WAIT_TAIL];
+	*rgosp = rsclp->gp_seq_full[RCU_WAIT_TAIL];
 	return true;
 }
 
@@ -488,7 +488,7 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
 			break;  /* No more callbacks. */
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
 		rcu_segcblist_move_seglen(rsclp, i, j);
-		rsclp->gp_seq[j] = rsclp->gp_seq[i];
+		rsclp->gp_seq_full[j] = rsclp->gp_seq_full[i];
 	}
 }
 
@@ -496,7 +496,7 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
  * Advance the callbacks in the specified rcu_segcblist structure based
  * on the current value passed in for the grace-period counter.
  */
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)
 {
 	int i;
 
@@ -509,7 +509,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
 	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
-		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
+		if (ULONG_CMP_LT(rgosp->rgos_norm, rsclp->gp_seq_full[i].rgos_norm))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
 		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
@@ -537,7 +537,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  * ready to invoke.  Returns true if there are callbacks that won't be
  * ready to invoke until seq, false otherwise.
  */
-bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
+bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)
 {
 	int i, j;
 
@@ -555,7 +555,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 */
 	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
 		if (!rcu_segcblist_segempty(rsclp, i) &&
-		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
+		    ULONG_CMP_LT(rsclp->gp_seq_full[i].rgos_norm, rgosp->rgos_norm))
 			break;
 
 	/*
@@ -595,7 +595,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 */
 	for (; i < RCU_NEXT_TAIL; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
-		rsclp->gp_seq[i] = seq;
+		rsclp->gp_seq_full[i].rgos_norm = rgosp->rgos_norm;
 	}
 	return true;
 }
@@ -637,10 +637,14 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 
 void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	rcu_segcblist_advance(rsclp, seq);
+	struct rcu_gp_oldstate rgos = { .rgos_norm = seq };
+
+	rcu_segcblist_advance(rsclp, &rgos);
 }
 
 bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	return rcu_segcblist_accelerate(rsclp, seq);
+	struct rcu_gp_oldstate rgos = { .rgos_norm = seq };
+
+	return rcu_segcblist_accelerate(rsclp, &rgos);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 956f2967d9d2..2c06ab830a3d 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -124,7 +124,7 @@ bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
-bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
+bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp);
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
@@ -139,8 +139,8 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
-bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp);
+bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
 void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..cbc170dc3f72 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1142,7 +1142,7 @@ static void rcu_gp_kthread_wake(void)
  */
 static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	unsigned long gp_seq_req;
+	struct rcu_gp_oldstate rgos;
 	bool ret = false;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
@@ -1164,15 +1164,15 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
-		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
+	rgos.rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
+	if (rcu_segcblist_accelerate(&rdp->cblist, &rgos))
+		ret = rcu_start_this_gp(rnp, rdp, rgos.rgos_norm);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, rgos.rgos_norm, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, rgos.rgos_norm, TPS("AccReadyCB"));
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
 
@@ -1189,14 +1189,14 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 					struct rcu_data *rdp)
 {
-	unsigned long c;
+	struct rcu_gp_oldstate rgos;
 	bool needwake;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
-	c = rcu_seq_snap(&rcu_state.gp_seq);
-	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
+	rgos.rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
+	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, rgos.rgos_norm)) {
 		/* Old request still live, so mark recent callbacks. */
-		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
+		(void)rcu_segcblist_accelerate(&rdp->cblist, &rgos);
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -1218,6 +1218,8 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
  */
 static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
+	struct rcu_gp_oldstate rgos;
+
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1229,7 +1231,8 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * Find all callbacks whose ->gp_seq numbers indicate that they
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
 	 */
-	rcu_segcblist_advance(&rdp->cblist, rnp->gp_seq);
+	rgos.rgos_norm = rnp->gp_seq;
+	rcu_segcblist_advance(&rdp->cblist, &rgos);
 
 	/* Classify any remaining callbacks. */
 	return rcu_accelerate_cbs(rnp, rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1047b30cd46b..1837eedfb8c2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -433,7 +433,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				bool lazy)
 {
 	unsigned long c;
-	unsigned long cur_gp_seq;
+	struct rcu_gp_oldstate cur_gp_seq_full;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	long lazy_len = READ_ONCE(rdp->lazy_len);
@@ -501,8 +501,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			return false; // Caller must enqueue the callback.
 		}
 		if (j != rdp->nocb_gp_adv_time &&
-		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
+		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
+		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq_full.rgos_norm)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
@@ -659,7 +659,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool bypass = false;
 	int __maybe_unused cpu = my_rdp->cpu;
-	unsigned long cur_gp_seq;
+	struct rcu_gp_oldstate cur_gp_seq_full;
 	unsigned long flags;
 	bool gotcbs = false;
 	unsigned long j = jiffies;
@@ -730,8 +730,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		needwake_gp = false;
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
-		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
+		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
+		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq_full.rgos_norm))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
 			wasempty = rcu_segcblist_restempty(&rdp->cblist,
@@ -742,10 +742,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		WARN_ON_ONCE(wasempty &&
 			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
-		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
+		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full)) {
 			if (!needwait_gp ||
-			    ULONG_CMP_LT(cur_gp_seq, wait_gp_seq))
-				wait_gp_seq = cur_gp_seq;
+			    ULONG_CMP_LT(cur_gp_seq_full.rgos_norm, wait_gp_seq))
+				wait_gp_seq = cur_gp_seq_full.rgos_norm;
 			needwait_gp = true;
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("NeedWaitGP"));
@@ -877,7 +877,7 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
 static void nocb_cb_wait(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	unsigned long cur_gp_seq;
+	struct rcu_gp_oldstate cur_gp_seq_full;
 	unsigned long flags;
 	bool needwake_gp = false;
 	struct rcu_node *rnp = rdp->mynode;
@@ -918,8 +918,8 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
-	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
-	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
+	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq_full) &&
+	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq_full.rgos_norm) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
@@ -1569,9 +1569,10 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      nocb_entry_rdp);
 
 	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
-	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL], rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL],
+		rsclp->gp_seq_full[RCU_WAIT_TAIL].rgos_norm);
 	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
-		      rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+		rsclp->gp_seq_full[RCU_NEXT_READY_TAIL].rgos_norm);
 	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
 	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
-- 
2.52.0

