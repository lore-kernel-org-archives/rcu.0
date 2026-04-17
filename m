Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDA24A047;
	Fri, 17 Apr 2026 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467573; cv=none; b=XAy9MqqPYiNDsjKAiQmL6OzzZ6wjMnM5caBnXKN55X1gn0aSWpBtrh2KM7eTvHxLpu9368h9YWpIXCj7bDRm8ad8QJc4HYihP/b8hnu9TPHZhVVvN+zeO78RvtSbLG17RY2Xcrvdtfo6X1LuHy4HiQCf/NwwpJ6gVRaIAX4iD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467573; c=relaxed/simple;
	bh=y5fMa7uAzSPjju8kLmpBtfzSCYDLG4AqFk15xYbh1Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evVSxId1Q/9LeYyVDx9/oQmebOC1wk1Ti7+qQmKUZuT2oJ+A2Pzt0ahG4YpBdMCUPhAfH8mQN8ME6qyr5ZPPFOzVh0V3NbCVmWA1XvweEzcvhBi0FsOVBTi0NYxS+ZvG8abqEq0eq28SzGe/dDgNUIch0O6YndNuI796SSpQAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKHQUpO/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKHQUpO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A163C19425;
	Fri, 17 Apr 2026 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467571;
	bh=y5fMa7uAzSPjju8kLmpBtfzSCYDLG4AqFk15xYbh1Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKHQUpO/Y39JW1+e2YgH0j1LLM02EU63KkYZJpSqSg6AUfO9ihNcaRI/O55Mw0Kdo
	 bGQWqpmCbCFLXwBd/C3eIU+Yu9N3B+mL1XSm/DGJQmpeB2vHN6r6fiJp3hIsRSVFBn
	 Xdlhkq0WAHfyu5eQnFTX6/Df4dNzHcrSz2s/zb1e6a9gTijLXdzL46jQBlAnPrmlyE
	 wOAkBuPmOfUcEdPOgrTGrwAQ5u3HRIEjyHKVBvoUIONNhCAIKczWrAPEIOuR14Ul0k
	 soZDfngwSseZi0M72ahRXOEPwbGgDdMvdMnK6q2UxglH99UY6xA36RABdC2h62gesk
	 6o8+ZYMzpKj6A==
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
Subject: [RFC PATCH 05/10] rcu: Enable RCU callbacks to benefit from expedited grace periods
Date: Fri, 17 Apr 2026 16:11:53 -0700
Message-ID: <20260417231203.785172-6-puranjay@kernel.org>
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

Currently, RCU callbacks only track normal grace period sequence
numbers.  This means callbacks must wait for normal grace periods to
complete even when expedited grace periods have already elapsed.

This commit uses the full rcu_gp_oldstate structure (which tracks both
normal and expedited GP sequences) throughout the callback
infrastructure.

The rcu_segcblist_advance() function now checks both normal and
expedited GP completion via poll_state_synchronize_rcu_full(), becoming
parameterless since it reads the GP state internally.
rcu_segcblist_accelerate() stores the full GP state (both normal and
expedited sequences) instead of just the normal sequence.

The rcu_accelerate_cbs() and rcu_accelerate_cbs_unlocked() functions use
get_state_synchronize_rcu_full() to capture both GP sequences. The NOCB
code uses poll_state_synchronize_rcu_full() for advance checks instead
of comparing only the normal GP sequence.

srcu_segcblist_advance() become standalone implementations because
compares SRCU sequences directly (it cannot use
poll_state_synchronize_rcu_full(), which reads RCU-specific globals).
srcu_segcblist_accelerate() sets rgos_exp to RCU_GET_STATE_NOT_TRACKED
so poll_state_synchronize_rcu_full() only compares the rgosp->rgos_norm
and ignores rgos_exp.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 30 ++++++++++++++++++++++++------
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          |  9 +++------
 kernel/rcu/tree_nocb.h     | 33 +++++++++++++++++++++++----------
 4 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 00e164db8b74..11174e2be3c2 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 
+#include "rcu.h"
 #include "rcu_segcblist.h"
 
 /* Initialize simple callback list. */
@@ -494,9 +495,9 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
 
 /*
  * Advance the callbacks in the specified rcu_segcblist structure based
- * on the current value passed in for the grace-period counter.
+ * on the current value of the grace-period counter.
  */
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
 {
 	int i;
 
@@ -509,7 +510,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
 	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
-		if (ULONG_CMP_LT(rgosp->rgos_norm, rsclp->gp_seq_full[i].rgos_norm))
+		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq_full[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
 		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
@@ -595,7 +596,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstat
 	 */
 	for (; i < RCU_NEXT_TAIL; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
-		rsclp->gp_seq_full[i].rgos_norm = rgosp->rgos_norm;
+		rsclp->gp_seq_full[i] = *rgosp;
 	}
 	return true;
 }
@@ -637,14 +638,31 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 
 void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	struct rcu_gp_oldstate rgos = { .rgos_norm = seq };
+	int i;
 
-	rcu_segcblist_advance(rsclp, &rgos);
+	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
+	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
+		return;
+
+	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
+		if (ULONG_CMP_LT(seq, rsclp->gp_seq_full[i].rgos_norm))
+			break;
+		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
+	}
+
+	/* If no callbacks moved, nothing more need be done. */
+	if (i == RCU_WAIT_TAIL)
+		return;
+
+	rcu_segcblist_advance_compact(rsclp, i);
 }
 
 bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
 	struct rcu_gp_oldstate rgos = { .rgos_norm = seq };
 
+	if (IS_ENABLED(CONFIG_SMP))
+		rgos.rgos_exp = RCU_GET_STATE_NOT_TRACKED;
 	return rcu_segcblist_accelerate(rsclp, &rgos);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 2c06ab830a3d..6e05fdf93e7b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -139,7 +139,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp);
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 607fc5715cd1..35076092f754 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1164,7 +1164,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	rgos.rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
+	get_state_synchronize_rcu_full(&rgos);
 	if (rcu_segcblist_accelerate(&rdp->cblist, &rgos))
 		ret = rcu_start_this_gp(rnp, rdp, rgos.rgos_norm);
 
@@ -1193,7 +1193,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	bool needwake;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
-	rgos.rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
+	get_state_synchronize_rcu_full(&rgos);
 	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, rgos.rgos_norm)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, &rgos);
@@ -1218,8 +1218,6 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
  */
 static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	struct rcu_gp_oldstate rgos;
-
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1231,8 +1229,7 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * Find all callbacks whose ->gp_seq numbers indicate that they
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
 	 */
-	rgos.rgos_norm = rnp->gp_seq;
-	rcu_segcblist_advance(&rdp->cblist, &rgos);
+	rcu_segcblist_advance(&rdp->cblist);
 
 	/* Classify any remaining callbacks. */
 	return rcu_accelerate_cbs(rnp, rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1837eedfb8c2..7462cd5e2507 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -502,7 +502,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		}
 		if (j != rdp->nocb_gp_adv_time &&
 		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
-		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq_full.rgos_norm)) {
+		    poll_state_synchronize_rcu_full(&cur_gp_seq_full)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
@@ -731,7 +731,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
 		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
-		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq_full.rgos_norm))) {
+		     poll_state_synchronize_rcu_full(&cur_gp_seq_full))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
 			wasempty = rcu_segcblist_restempty(&rdp->cblist,
@@ -742,7 +742,18 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		WARN_ON_ONCE(wasempty &&
 			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
-		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full)) {
+		/*
+		 * Only request a GP wait if the next pending callback's
+		 * GP has not already completed (normal or expedited).
+		 * If poll_state_synchronize_rcu_full() says it completed,
+		 * then rcu_advance_cbs() above already moved those
+		 * callbacks to RCU_DONE_TAIL, so there is no GP to wait
+		 * for.  Any remaining callbacks got new (future) GP
+		 * numbers from rcu_accelerate_cbs() inside
+		 * rcu_advance_cbs() and will be handled on the next pass.
+		 */
+		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq_full) &&
+		    !poll_state_synchronize_rcu_full(&cur_gp_seq_full)) {
 			if (!needwait_gp ||
 			    ULONG_CMP_LT(cur_gp_seq_full.rgos_norm, wait_gp_seq))
 				wait_gp_seq = cur_gp_seq_full.rgos_norm;
@@ -919,7 +930,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
 	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq_full) &&
-	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq_full.rgos_norm) &&
+	    poll_state_synchronize_rcu_full(&cur_gp_seq_full) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
@@ -1548,8 +1559,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
 	char bufd[22];
-	char bufw[45];
-	char bufr[45];
+	char bufw[64];
+	char bufr[64];
 	char bufn[22];
 	char bufb[22];
 	struct rcu_data *nocb_next_rdp;
@@ -1569,10 +1580,12 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      nocb_entry_rdp);
 
 	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
-	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL],
-		rsclp->gp_seq_full[RCU_WAIT_TAIL].rgos_norm);
-	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
-		rsclp->gp_seq_full[RCU_NEXT_READY_TAIL].rgos_norm);
+	sprintf(bufw, "%ld(%ld/%ld)", rsclp->seglen[RCU_WAIT_TAIL],
+		rsclp->gp_seq_full[RCU_WAIT_TAIL].rgos_norm,
+		rsclp->gp_seq_full[RCU_WAIT_TAIL].rgos_exp);
+	sprintf(bufr, "%ld(%ld/%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
+		rsclp->gp_seq_full[RCU_NEXT_READY_TAIL].rgos_norm,
+		rsclp->gp_seq_full[RCU_NEXT_READY_TAIL].rgos_exp);
 	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
 	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
-- 
2.52.0

