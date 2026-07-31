Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031A2D8376;
	Fri, 31 Jul 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459458; cv=none; b=QcRD6HDugum6aC83FI2/b42ly96kOkvU6pHNSnRT3wRpLH1vcdOlERdy1LUt233EJludElDanHsFNSp5bTotRwvrTF3B00r5yRSZneV+jGxCIQjU+5FZbwFAgP0hMusTlhr2iOSHLxodIibPCAgcLOV7oRT3EFbO64mIiLZOFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459458; c=relaxed/simple;
	bh=oArlNBL57S3nlUkshQuv2jFL2MnOXn4NPuqhpRwc6p0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PTq+RfPXq6J8i8jONkaJCkAQ+mYB8rEnAeNmiDsi/JlQz1Rue4/pgHfmllNkpsrhyfsJORIxycDVRtB/VufIa922vJDzWDHZ9y36+Wjz/IxqJapcSuXqDMOid1n1CNPEbctBa7oGPxqZM4GfJLqwz7XGR9Th7YhozyLhmw3TKy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a37REidm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a37REidm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13D11F0155B;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=IX6H98YIqWF3h/WrKfK5FhQI5S6bZZPNpHkMgf4IwRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a37REidmJvyoM2AVLfc5wxXyEYnP952EN1B4zdbZMiiqBp9QdID/7P7NutwhGsxoN
	 cQO2bGjoqR5v7/sr/WEtK2rFC0MRqwGENKQigVXNkLnff7v3rz1h4VI2WtJUGuGbIV
	 aNdK4u8vICLvE5qn8Puyqughh2oHw3e2kilnoA/pQb85Xh4ZjGfGc8ASU2qfUoh7L3
	 /+C2Z5sv6g4l/qLBFqkohOxTUZTPQGdCLW+rE9uFE4l24jKLGW/vOZ3wqrQ/tf0ON4
	 AnNZwQpSVGOuJAUkGQQUV6C6DUCouwKQ+EOwUVZDMoloPGPq8c7bkAkQiaxT9iFpNj
	 HjlXdejm/E0WA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 43ADFCE1059; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 07/12] rcu: Enable RCU callbacks to benefit from expedited grace periods
Date: Thu, 30 Jul 2026 17:57:27 -0700
Message-Id: <20260731005732.3530999-7-paulmck@kernel.org>
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

Currently, RCU callbacks only track normal grace-period sequence
numbers.  This means callbacks must wait for normal grace periods to
complete even when expedited grace periods have already elapsed.

Use the full struct rcu_gp_seq (which tracks both the normal and
expedited grace-period sequences) throughout the callback
infrastructure.

rcu_segcblist_advance() now checks both normal and expedited GP
completion via poll_state_synchronize_rcu_full(), and becomes
parameterless since it reads the grace-period state internally.
rcu_segcblist_accelerate() stores the full state (both sequences)
instead of just the normal one.  rcu_accelerate_cbs() and
rcu_accelerate_cbs_unlocked() use get_state_synchronize_rcu_full() to
capture both sequences, and the NOCB advance checks use
poll_state_synchronize_rcu_full() instead of comparing only the normal
sequence.

srcu_segcblist_advance() becomes a standalone implementation because it
compares SRCU sequences directly and cannot use
poll_state_synchronize_rcu_full(), which reads RCU-specific globals.
srcu_segcblist_accelerate() sets the ->exp field to
RCU_GET_STATE_NOT_TRACKED so that poll_state_synchronize_rcu_full()
compares only ->norm and ignores ->exp.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 30 +++++++++++++++++++++++-------
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          |  9 +++------
 kernel/rcu/tree_nocb.h     | 22 ++++++++++++----------
 4 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 4e3dfe42bc097b..cf8951d33e767f 100644
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
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
 {
 	int i;
 
@@ -509,7 +510,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
 	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
-		if (ULONG_CMP_LT(gsp->norm, rsclp->gp_seq[i].norm))
+		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
 		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
@@ -595,7 +596,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gs
 	 */
 	for (; i < RCU_NEXT_TAIL; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_NEXT_TAIL]);
-		rsclp->gp_seq[i].norm = gsp->norm;
+		rsclp->gp_seq[i] = *gsp;
 	}
 	return true;
 }
@@ -637,14 +638,29 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 
 void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	struct rcu_gp_seq gs = { .norm = seq };
+	int i;
+
+	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
+	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
+		return;
+
+	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
+		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i].norm))
+			break;
+		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
+	}
+
+	/* If no callbacks moved, nothing more need be done. */
+	if (i == RCU_WAIT_TAIL)
+		return;
 
-	rcu_segcblist_advance(rsclp, &gs);
+	rcu_segcblist_advance_compact(rsclp, i);
 }
 
 bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	struct rcu_gp_seq gs = { .norm = seq };
+	struct rcu_gp_seq gs = { .norm = seq, .exp = RCU_GET_STATE_NOT_TRACKED };
 
 	return rcu_segcblist_accelerate(rsclp, &gs);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 16b0cb6b32507a..431c4466b88984 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -139,7 +139,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
-void rcu_segcblist_advance(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp);
+void rcu_segcblist_advance(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 640ebe055a2460..f63ce75c5b4f5c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1159,7 +1159,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
+	get_state_synchronize_rcu_full(&gs);
 	if (rcu_segcblist_accelerate(&rdp->cblist, &gs))
 		ret = rcu_start_this_gp(rnp, rdp, gs.norm);
 
@@ -1188,7 +1188,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	bool needwake;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
-	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
+	get_state_synchronize_rcu_full(&gs);
 	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, gs.norm)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, &gs);
@@ -1213,8 +1213,6 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
  */
 static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	struct rcu_gp_seq gs;
-
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1226,8 +1224,7 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * Find all callbacks whose ->gp_seq numbers indicate that they
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
 	 */
-	gs.norm = rnp->gp_seq;
-	rcu_segcblist_advance(&rdp->cblist, &gs);
+	rcu_segcblist_advance(&rdp->cblist);
 
 	/* Classify any remaining callbacks. */
 	return rcu_accelerate_cbs(rnp, rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index eaa1ad5297e293..876dd897f18be3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -502,7 +502,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		}
 		if (j != rdp->nocb_gp_adv_time &&
 		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq.norm)) {
+		    poll_state_synchronize_rcu_full(&cur_gp_seq)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
 		}
@@ -731,17 +731,17 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
 		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq.norm))) {
+		     poll_state_synchronize_rcu_full(&cur_gp_seq))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
 			wasempty = rcu_segcblist_restempty(&rdp->cblist,
 							   RCU_NEXT_READY_TAIL);
 			raw_spin_unlock_rcu_node(rnp); /* irqs disabled. */
 		}
-		// Need to wait on some grace period?
 		WARN_ON_ONCE(wasempty &&
 			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
+		// Need to wait on some grace period?
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
 			if (!needwait_gp ||
 			    ULONG_CMP_LT(cur_gp_seq.norm, wait_gp_seq))
@@ -919,7 +919,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
 	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
-	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq.norm) &&
+	    poll_state_synchronize_rcu_full(&cur_gp_seq) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
@@ -1548,8 +1548,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
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
@@ -1569,10 +1569,12 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      nocb_entry_rdp);
 
 	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
-	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL],
-		rsclp->gp_seq[RCU_WAIT_TAIL].norm);
-	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
-		rsclp->gp_seq[RCU_NEXT_READY_TAIL].norm);
+	sprintf(bufw, "%ld(%ld/%ld)", rsclp->seglen[RCU_WAIT_TAIL],
+		rsclp->gp_seq[RCU_WAIT_TAIL].norm,
+		rsclp->gp_seq[RCU_WAIT_TAIL].exp);
+	sprintf(bufr, "%ld(%ld/%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
+		rsclp->gp_seq[RCU_NEXT_READY_TAIL].norm,
+		rsclp->gp_seq[RCU_NEXT_READY_TAIL].exp);
 	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
 	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
-- 
2.40.1

