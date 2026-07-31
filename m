Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404052D9ECA;
	Fri, 31 Jul 2026 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459458; cv=none; b=M3PnBoffBU6ZjFx9hQBNKdBbOuU1DLubsCJNYTvVQrn+nWm2OCVChqS2a1lEx6aQF77wm+tVWGx263vqzllR9upzt9ySvSgrzJsXQfau+qzLLZgL7tywWEOhpvsu43xecyDfgRMoDaYqvzehFbNABNV16RQhNx6d1QU3wLqPUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459458; c=relaxed/simple;
	bh=H+1TwhGUOITL1VogcKEx5ynLP0QS49DSpPo1m4Qtumk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFO4YYiMyUu3vQm0eyVOo8olvybKt6PBzwn6b78YXTJb4n/oLjPLjSOtpq/luEl9xxmUyfFqg0mGl+zSz+t6LE5vGkAOwA0zi+ddpYr4P8Ncbf3hQ9rmIHuU5oGhZa/+HDgGfpUb9jd4FBhh9zpojPYhrnL6e+kzakOnimT6nlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHwq4dEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHwq4dEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF401F00ADB;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=0pqAU/XCtPQeQ+dV6lUI06IwlKfSqYpSY7K/xIkKwm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OHwq4dEF5+gz7yi5eLvmkImEQrP0B+OssGc0EBjlhmFV/uWppohFfYFG/U5dizt4k
	 G5tXSp5vfK3ZWD1qSMxJc2jvHSymiH2TvcV5lEYy4DSOi8AxU4cja8t9JXTGij3EY0
	 UEJztgyUnxI6mt1mlSY7v1sbfrAv+hmOCpI8PmRwxRdPMjeaQ0gRhwenFrxbrA8Rlv
	 BsBK4hPUt1dXUiB8MDFCWxNYiSx5Eb2fiwDAuTc+48eZaRRvl1lge05AhL+QHjl2fl
	 Jw08zk8MvTaIvyMbpz5PLOjZxlzl0kiUbYpq23BUBcnt2zV+ci/T/oL5VLWBjt/RC3
	 c2gqgEjadnWvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4650BCE1497; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH RFC 08/12] rcu: Update comments for gp_seq and expedited GP tracking
Date: Thu, 30 Jul 2026 17:57:28 -0700
Message-Id: <20260731005732.3530999-8-paulmck@kernel.org>
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

Update documentation comments throughout the RCU callback infrastructure
to reflect the transition from a single grace-period sequence number to
the full struct rcu_gp_seq that tracks both normal and expedited grace
periods.

The ->gp_seq[] array documentation in rcu_segcblist.h is updated to
describe dual (normal and expedited) GP tracking.  The
rcu_segcblist_advance(), rcu_segcblist_accelerate(), and
rcu_advance_cbs() comments are updated to refer to the struct rcu_gp_seq
state (gsp) instead of the old bare grace-period sequence number (seq).

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 14 +++++++-----
 kernel/rcu/rcu_segcblist.c    | 43 +++++++++++++++++++++++------------
 kernel/rcu/tree.c             |  6 ++---
 3 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 137cc23b024c5f..08b63ecf719b2d 100644
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
+ * The ->gp_seq[] array contains the grace-period state at which the
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
index cf8951d33e767f..dd770006e7f8be 100644
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
 		if (!poll_state_synchronize_rcu_full(&rsclp->gp_seq[i]))
@@ -534,9 +537,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp)
  * them to complete at the end of the earlier grace period.
  *
  * This function operates on an rcu_segcblist structure, and also the
- * grace-period sequence number seq at which new callbacks would become
+ * grace-period state gsp at which new callbacks would become
  * ready to invoke.  Returns true if there are callbacks that won't be
- * ready to invoke until seq, false otherwise.
+ * ready to invoke until the grace period represented by gsp, false otherwise.
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gsp)
 {
@@ -548,11 +551,11 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gs
 
 	/*
 	 * Find the segment preceding the oldest segment of callbacks
-	 * whose ->gp_seq[] completion is at or after that passed in via
-	 * "seq", skipping any empty segments.  This oldest segment, along
+	 * whose grace period completion is at or after that passed in via
+	 * "gsp", skipping any empty segments.  This oldest segment, along
 	 * with any later segments, can be merged in with any newly arrived
-	 * callbacks in the RCU_NEXT_TAIL segment, and assigned "seq"
-	 * as their ->gp_seq[] grace-period completion sequence number.
+	 * callbacks in the RCU_NEXT_TAIL segment, and assigned "gsp"
+	 * as their grace-period completion state.
 	 */
 	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
 		if (!rcu_segcblist_segempty(rsclp, i) &&
@@ -561,7 +564,7 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gs
 
 	/*
 	 * If all the segments contain callbacks that correspond to
-	 * earlier grace-period sequence numbers than "seq", leave.
+	 * earlier grace-period sequence numbers than "gsp", leave.
 	 * Assuming that the rcu_segcblist structure has enough
 	 * segments in its arrays, this can only happen if some of
 	 * the non-done segments contain callbacks that really are
@@ -569,15 +572,15 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gs
 	 * out by the next call to rcu_segcblist_advance().
 	 *
 	 * Also advance to the oldest segment of callbacks whose
-	 * ->gp_seq[] completion is at or after that passed in via "seq",
+	 * ->gp_seq[] completion is at or after that passed in via "gsp",
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
@@ -589,8 +592,8 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, struct rcu_gp_seq *gs
 
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
-	 * into the segment located by the for-loop above.  Assign "seq"
-	 * as the ->gp_seq[] value in order to correctly handle the case
+	 * into the segment located by the for-loop above.  Assign "gsp"
+	 * as the grace-period state in order to correctly handle the case
 	 * where there were no pending callbacks in the rcu_segcblist
 	 * structure other than in the RCU_NEXT_TAIL segment.
 	 */
@@ -644,6 +647,10 @@ void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
 		return;
 
+	/*
+	 * Find all callbacks whose normal GP sequence numbers indicate
+	 * that they are ready to invoke.  For SRCU, we only check norm.
+	 */
 	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++) {
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i].norm))
 			break;
@@ -658,6 +665,12 @@ void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	rcu_segcblist_advance_compact(rsclp, i);
 }
 
+/*
+ * SRCU wrapper for rcu_segcblist_accelerate() - converts SRCU's unsigned
+ * long GP sequence to rcu_gp_seq format with exp set to
+ * RCU_GET_STATE_NOT_TRACKED (since SRCU does not use expedited GPs)
+ * and calls the core rcu_segcblist_accelerate().
+ */
 bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
 	struct rcu_gp_seq gs = { .norm = seq, .exp = RCU_GET_STATE_NOT_TRACKED };
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f63ce75c5b4f5c..aa11e9a048302d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1204,7 +1204,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 /*
  * Move any callbacks whose grace period has completed to the
  * RCU_DONE_TAIL sublist, then compact the remaining sublists and
- * assign ->gp_seq numbers to any callbacks in the RCU_NEXT_TAIL
+ * assign ->gp_seq[] state to any callbacks in the RCU_NEXT_TAIL
  * sublist.  This function is idempotent, so it does not hurt to
  * invoke it repeatedly.  As long as it is not invoked -too- often...
  * Returns true if the RCU grace-period kthread needs to be awakened.
@@ -1221,8 +1221,8 @@ static bool rcu_advance_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 		return false;
 
 	/*
-	 * Find all callbacks whose ->gp_seq numbers indicate that they
-	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
+	 * Find all callbacks whose grace periods have completed (either
+	 * normal or expedited) and put them into the RCU_DONE_TAIL sublist.
 	 */
 	rcu_segcblist_advance(&rdp->cblist);
 
-- 
2.40.1

