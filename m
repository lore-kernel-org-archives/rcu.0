Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570563B530F;
	Wed, 24 Jun 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307482; cv=none; b=UNRVRP2ZPFkHKWcKLd8YO5jb+EJFSsmVTDxkjxviNkSe6gR56xU6kyw3UpvmuGYh295Kqal124XE+diWD4F/bv2uEWyn1ZF8M6fwdts8JfrWFO94dzKCx8JU+r6eTXQ/3SAfqe/WCF80Ozqv7zj86Zgx/sqRixpNkFaIduxOUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307482; c=relaxed/simple;
	bh=iMSbWzf1BGPZ1UUmi7ofxBJ255NTg9KGFar/X91v65A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/PxorEbyBPvt8YPW3ZhUkWrHn2aJE4iIzTJnhxfvLLyzgAGvsevi0ufi3M2a3rUWo9gKc7Hdc0Pz9Y70eFLWGBgfTH9wjCfJ8JstN/0ZHWgPCf+Py7Qs3R1FiYL9AvX/PJiyTDMer+OOTQhYEVZjRD6Dd8j3Cy4Vy7EVQJFi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqTIKxI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqTIKxI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D091F000E9;
	Wed, 24 Jun 2026 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307481;
	bh=W82U5BWDROK0A683iYTWosQv+Z/3ntlhXNCvoCzJylg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqTIKxI/baT9tx87gWIz9H26TTgFJMrKrfcQSXHcWZe6zJ77rCdqDDU7bLwzkAFh/
	 sVwQaCwi3R/VWj2GAvTXtwcCXaoCZ+MIQp8eGk0uZPRJHemh4Ufsc53pG6cj7sFndh
	 bXHfh4er3OFN2x9mp8ruPTwSX4Uc7gGPTwjh7+43CKKAraVewuhFNlzPq5Drj4/N5H
	 Np7hOmSKL4S1IRvrmNRBjDY1Jc41exIzdATqGuVIc4fPGd1OYphLihPGmIqDQKVota
	 gVpPSdnmgCv7sCBgPQ6FD3UCNTL5KNrRaIY/NJDUUkyzQVi6JjzqR/aZ/CxqapaDIr
	 PpAmZbs8z6GEQ==
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
Subject: [PATCH v1 06/11] rcu: Enable RCU callbacks to benefit from expedited grace periods
Date: Wed, 24 Jun 2026 06:23:48 -0700
Message-ID: <20260624132356.516959-7-puranjay@kernel.org>
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 30 +++++++++++++++++++++++-------
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          |  9 +++------
 kernel/rcu/tree_nocb.h     | 33 +++++++++++++++++++++++----------
 4 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 4e3dfe42bc097..cf8951d33e767 100644
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
index 16b0cb6b32507..431c4466b8898 100644
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
index 095a023b19f1f..91c03887a1228 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1164,7 +1164,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
+	get_state_synchronize_rcu_full(&gs);
 	if (rcu_segcblist_accelerate(&rdp->cblist, &gs))
 		ret = rcu_start_this_gp(rnp, rdp, gs.norm);
 
@@ -1193,7 +1193,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	bool needwake;
 
 	rcu_lockdep_assert_cblist_protected(rdp);
-	gs.norm = rcu_seq_snap(&rcu_state.gp_seq);
+	get_state_synchronize_rcu_full(&gs);
 	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, gs.norm)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, &gs);
@@ -1218,8 +1218,6 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
  */
 static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
-	struct rcu_gp_seq gs;
-
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1231,8 +1229,7 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * Find all callbacks whose ->gp_seq numbers indicate that they
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
 	 */
-	gs.norm = rnp->gp_seq;
-	rcu_segcblist_advance(&rdp->cblist, &gs);
+	rcu_segcblist_advance(&rdp->cblist);
 
 	/* Classify any remaining callbacks. */
 	return rcu_accelerate_cbs(rnp, rdp);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e0274a2e1c1ae..263bb8a65a988 100644
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
@@ -731,7 +731,7 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
 		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
-		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq.norm))) {
+		     poll_state_synchronize_rcu_full(&cur_gp_seq))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
 			wasempty = rcu_segcblist_restempty(&rdp->cblist,
@@ -742,7 +742,18 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		WARN_ON_ONCE(wasempty &&
 			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
-		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
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
+		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
 			if (!needwait_gp ||
 			    ULONG_CMP_LT(cur_gp_seq.norm, wait_gp_seq))
 				wait_gp_seq = cur_gp_seq.norm;
@@ -919,7 +930,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
 	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
-	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq.norm) &&
+	    poll_state_synchronize_rcu_full(&cur_gp_seq) &&
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
2.53.0-Meta

