Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7032694E;
	Fri, 17 Apr 2026 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467575; cv=none; b=JAGftmTBMSiyw7GQTYxa2SZ2fTCC8er0BS9BMtqnPkf9PRVY/N1TdLWg71tMHwwQxQinrcQZ62LYwYv1b7eRRkdFpf4WGJ1uc4q+vy8BqwOsVStb0GQjokRtS8wy3B0ENwGWTkoIeHJTa7wrPl1ltLGLShED3tH6IO6y0mBURRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467575; c=relaxed/simple;
	bh=ijJHWZ0+bnZmKe3fyXf+j+evxzhD2vZT6zxeieS18ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=admHiU3sVpCj8OqshXIUny7NKVWMCHQiQs8cjS9KxYQWhmvQD68MVnWy953hSzaLzIilfKtEotB169RPS76qv2wbrv+u+TtrasoHNcgNBRVAN5zokThFPz+5Hiy1ANHS/igE77d8IQFDQgKwki8c/q3UgqDrZnf1Olr0nzfYjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRxPFpzi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRxPFpzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691DAC2BCB3;
	Fri, 17 Apr 2026 23:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467575;
	bh=ijJHWZ0+bnZmKe3fyXf+j+evxzhD2vZT6zxeieS18ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRxPFpzi3E+s0oBAxKE9GOrC8DV9J3clzQdIZ0bikjCBzNfWl3Ri14KJcRw72056Y
	 WjXFnewjG4eGRzorxUlc0GsnQJEs3y3hU7bAO4veBENouXHiZ4pD1NkVbmNqRJDsXd
	 JRVuXYK+avfd+JbCvOPtR8fC/aghyN0Hi0lmoEyMxC7bBmmr31ei68tyC9hvb6rKWD
	 DFGVQLVkB6+gMIOUdxmr7umHYhMQdGGukv/ZB+xGN5oi2qCj+WoXacTQJpAkJUssJ0
	 S67jVcgdfaDbc9Wc3PRxiXoqTUJ2Ul6gxWhGEPMYObimnEn9AvXuJ0Q5BqgfZhL9Ur
	 cl0IODTqsMSyA==
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
Subject: [RFC PATCH 06/10] rcu: Update comments for gp_seq_full and expedited GP tracking
Date: Fri, 17 Apr 2026 16:11:54 -0700
Message-ID: <20260417231203.785172-7-puranjay@kernel.org>
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

This commit updates documentation comments throughout the RCU callback
infrastructure to reflect the transition from single grace-period
sequence numbers to the full rcu_gp_oldstate structure that tracks both
normal and expedited grace periods.

The ->gp_seq_full[] array documentation in rcu_segcblist.h is updated
to describe dual GP tracking. The rcu_segcblist_advance(),
rcu_segcblist_accelerate(), and rcu_advance_cbs() comments are updated
to reference ->gp_seq_full[] and rgosp instead of the old ->gp_seq[]
and seq names.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/rcu_segcblist.h | 14 +++++++-----
 kernel/rcu/rcu_segcblist.c    | 43 +++++++++++++++++++++++------------
 kernel/rcu/tree.c             |  6 ++---
 3 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 59c68f2ba113..6052c5750ad3 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -50,12 +50,14 @@ struct rcu_cblist {
  * Note that RCU_WAIT_TAIL cannot be empty unless RCU_NEXT_READY_TAIL is also
  * empty.
  *
- * The ->gp_seq[] array contains the grace-period number at which the
- * corresponding segment of callbacks will be ready to invoke.  A given
- * element of this array is meaningful only when the corresponding segment
- * is non-empty, and it is never valid for RCU_DONE_TAIL (whose callbacks
- * are already ready to invoke) or for RCU_NEXT_TAIL (whose callbacks have
- * not yet been assigned a grace-period number).
+ * The ->gp_seq_full[] array contains the grace-period state at which the
+ * corresponding segment of callbacks will be ready to invoke.  This tracks
+ * both normal and expedited grace periods, allowing callbacks to complete
+ * when either type of GP finishes.  A given element of this array is
+ * meaningful only when the corresponding segment is non-empty, and it is
+ * never valid for RCU_DONE_TAIL (whose callbacks are already ready to
+ * invoke) or for RCU_NEXT_TAIL (whose callbacks have not yet been assigned
+ * a grace-period state).
  */
 #define RCU_DONE_TAIL		0	/* Also RCU_WAIT head. */
 #define RCU_WAIT_TAIL		1	/* Also RCU_NEXT_READY head. */
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 11174e2be3c2..0f13016c0a2c 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -495,7 +495,8 @@ static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
 
 /*
  * Advance the callbacks in the specified rcu_segcblist structure based
- * on the current value of the grace-period counter.
+ * on the current grace-period state.  Checks both normal and expedited
+ * grace periods, advancing callbacks when either GP type completes.
  */
 void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
 {
@@ -506,8 +507,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
 		return;
 
 	/*
-	 * Find all callbacks whose ->gp_seq numbers indicate that they
-	 * are ready to invoke, and put them into the RCU_DONE_TAIL segment.
+	 * Find all callbacks whose grace periods have completed (either
+	 * normal or expedited) and put them into the RCU_DONE_TAIL segment.
+	 * We check against the current global GP state, which includes
+	 * proper memory barriers and handles special completion values.
 	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
 		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq_full[i]))
@@ -534,9 +537,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
  * them to complete at the end of the earlier grace period.
  *
  * This function operates on an rcu_segcblist structure, and also the
- * grace-period sequence number seq at which new callbacks would become
+ * grace-period state rgosp at which new callbacks would become
  * ready to invoke.  Returns true if there are callbacks that won't be
- * ready to invoke until seq, false otherwise.
+ * ready to invoke until the grace period represented by rgosp, false otherwise.
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstate *rgosp)
 {
@@ -548,11 +551,11 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstat
 
 	/*
 	 * Find the segment preceding the oldest segment of callbacks
-	 * whose ->gp_seq[] completion is at or after that passed in via
-	 * "seq", skipping any empty segments.  This oldest segment, along
+	 * whose grace period completion is at or after that passed in via
+	 * "rgosp", skipping any empty segments.  This oldest segment, along
 	 * with any later segments, can be merged in with any newly arrived
-	 * callbacks in the RCU_NEXT_TAIL segment, and assigned "seq"
-	 * as their ->gp_seq[] grace-period completion sequence number.
+	 * callbacks in the RCU_NEXT_TAIL segment, and assigned "rgosp"
+	 * as their grace-period completion state.
 	 */
 	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
 		if (!rcu_segcblist_segempty(rsclp, i) &&
@@ -561,7 +564,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstat
 
 	/*
 	 * If all the segments contain callbacks that correspond to
-	 * earlier grace-period sequence numbers than "seq", leave.
+	 * earlier grace-period sequence numbers than "rgosp", leave.
 	 * Assuming that the rcu_segcblist structure has enough
 	 * segments in its arrays, this can only happen if some of
 	 * the non-done segments contain callbacks that really are
@@ -569,15 +572,15 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstat
 	 * out by the next call to rcu_segcblist_advance().
 	 *
 	 * Also advance to the oldest segment of callbacks whose
-	 * ->gp_seq[] completion is at or after that passed in via "seq",
+	 * ->gp_seq_full[] completion is at or after that passed in via "rgosp",
 	 * skipping any empty segments.
 	 *
 	 * Note that segment "i" (and any lower-numbered segments
 	 * containing older callbacks) will be unaffected, and their
-	 * grace-period numbers remain unchanged.  For example, if i ==
+	 * grace-period states remain unchanged.  For example, if i ==
 	 * WAIT_TAIL, then neither WAIT_TAIL nor DONE_TAIL will be touched.
 	 * Instead, the CBs in NEXT_TAIL will be merged with those in
-	 * NEXT_READY_TAIL and the grace-period number of NEXT_READY_TAIL
+	 * NEXT_READY_TAIL and the grace-period state of NEXT_READY_TAIL
 	 * would be updated.  NEXT_TAIL would then be empty.
 	 */
 	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
@@ -589,8 +592,8 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_oldstat
 
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
-	 * into the segment located by the for-loop above.  Assign "seq"
-	 * as the ->gp_seq[] value in order to correctly handle the case
+	 * into the segment located by the for-loop above.  Assign "rgosp"
+	 * as the grace-period state in order to correctly handle the case
 	 * where there were no pending callbacks in the rcu_segcblist
 	 * structure other than in the RCU_NEXT_TAIL segment.
 	 */
@@ -644,6 +647,10 @@ void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
 		return;
 
+	/*
+	 * Find all callbacks whose normal GP sequence numbers indicate
+	 * that they are ready to invoke.  For SRCU, we only check rgos_norm.
+	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq_full[i].rgos_norm))
 			break;
@@ -658,6 +665,12 @@ void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	rcu_segcblist_advance_compact(rsclp, i);
 }
 
+/*
+ * SRCU wrapper for rcu_segcblist_accelerate() - converts SRCU's unsigned
+ * long GP sequence to rcu_gp_oldstate format with rgos_exp set to
+ * RCU_GET_STATE_NOT_TRACKED (since SRCU does not use expedited GPs)
+ * and calls the core rcu_segcblist_accelerate().
+ */
 bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
 	struct rcu_gp_oldstate rgos = { .rgos_norm = seq };
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35076092f754..0e43866dc4cd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1209,7 +1209,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 /*
  * Move any callbacks whose grace period has completed to the
  * RCU_DONE_TAIL sublist, then compact the remaining sublists and
- * assign ->gp_seq numbers to any callbacks in the RCU_NEXT_TAIL
+ * assign ->gp_seq_full[] state to any callbacks in the RCU_NEXT_TAIL
  * sublist.  This function is idempotent, so it does not hurt to
  * invoke it repeatedly.  As long as it is not invoked -too- often...
  * Returns true if the RCU grace-period kthread needs to be awakened.
@@ -1226,8 +1226,8 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 		return false;
 
 	/*
-	 * Find all callbacks whose ->gp_seq numbers indicate that they
-	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
+	 * Find all callbacks whose grace periods have completed (either
+	 * normal or expedited) and put them into the RCU_DONE_TAIL sublist.
 	 */
 	rcu_segcblist_advance(&rdp->cblist);
 
-- 
2.52.0

