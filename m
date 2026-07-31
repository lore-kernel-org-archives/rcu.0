Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66B2BE65B;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459456; cv=none; b=J8ez3SdAR9UMraZoAeacxvUJ2mkU6HxSHOWiKPGZCJYRLYs+0zcjCbsBmSu8GeflX+szOWDN9cwF+nY20cTCXktrQ7x8/2IPx2/C/CRiLqBXR8DwZa7hQ0qGEqVHKQ6GRz16OVaY3pVWPoaZZp9RtFSEH9FBr76soZp6IB7NlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459456; c=relaxed/simple;
	bh=ydfgRGHR35IUB52aEKgDXr9EqITSc5ZEDXCdGysgCdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OKAimcZ0bujHeyx/TNVfi+MMCmicfmyUVN1fGIl7BRDgGpIbDTVOI5NCdWeeFmSEumdlLrl0ag4K8MDD6jEDedvVRv40kmdEWjavlmVNeMHCUd6vK9/dXz5xfCW8Gl4y5EANfiZLOPiP5HNnFvrqHeSpkAbSLqive5mW6V7p/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5drgy3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5drgy3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7D11F000E9;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=w7dU1I4eYIBRh6DDhLtrQrjbC7m8p1+8pNJM5IZfQJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5drgy3Cp3zMcCw2/RIxweQPLyKgfAAOOA/0LXWgPM1Q9Mt6s9jPwnp0XUcA58Ymw
	 MciTHvCdshICCwonIea4r6ArG7VEOdtBHo6osuXrmwNRfEK0ryMN2c6dSHnZ/jxvYh
	 1zA3qny2oM4auIUC1oMMkerwJdm+/Z+0/fFA0FUiN+hrm56tiijp9O1ol5sdAE7+8x
	 idCSEXhsYDD6S+bY6fOZZ61esv9esG8WILvbD81W6gKoC9pb/Z+JcG+NagIRbW/39p
	 WAA6v/dtXfkuSdbi0bwbNL2d66d6bD/o/0cwXrlUhUODucq2NlFjT/3L0aip0lrI3S
	 sRrASMnY688gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 329BDCE0F69; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 01/12] rcu: Remove unused rdp parameter from trace_rcu_this_gp()
Date: Thu, 30 Jul 2026 17:57:21 -0700
Message-Id: <20260731005732.3530999-1-paulmck@kernel.org>
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

From: Joel Fernandes <joelagnelf@nvidia.com>

The trace_rcu_this_gp() wrapper forwards only the rcu_node structure's
fields and the requested grace-period sequence number to the
rcu_future_grace_period tracepoint.  Its rcu_data pointer parameter
has no users, but every one of the ten call sites must nevertheless
come up with an rcu_data pointer to pass in.

Remove the parameter and update all callers.  This also allows
rcu_future_gp_cleanup() to drop the local rcu_data pointer that
existed solely to feed this trace call.

No functional change.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c      | 23 ++++++++++-------------
 kernel/rcu/tree_nocb.h |  4 ++--
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03a43d3d261607..ef553189ee248e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -986,8 +986,8 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 }
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
-static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
-			      unsigned long gp_seq_req, const char *s)
+static void trace_rcu_this_gp(struct rcu_node *rnp, unsigned long gp_seq_req,
+			      const char *s)
 {
 	trace_rcu_future_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 				      gp_seq_req, rnp->level,
@@ -1026,7 +1026,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	 * Note that rnp_start->lock must not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp_start);
-	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
+	trace_rcu_this_gp(rnp_start, gp_seq_req, TPS("Startleaf"));
 	for (rnp = rnp_start; 1; rnp = rnp->parent) {
 		if (rnp != rnp_start)
 			raw_spin_lock_rcu_node(rnp);
@@ -1034,8 +1034,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 		    rcu_seq_started(&rnp->gp_seq, gp_seq_req) ||
 		    (rnp != rnp_start &&
 		     rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))) {
-			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
-					  TPS("Prestarted"));
+			trace_rcu_this_gp(rnp, gp_seq_req, TPS("Prestarted"));
 			goto unlock_out;
 		}
 		WRITE_ONCE(rnp->gp_seq_needed, gp_seq_req);
@@ -1046,7 +1045,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 			 * rcu_gp_cleanup() will see the marking.  Bail to
 			 * reduce contention.
 			 */
-			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
+			trace_rcu_this_gp(rnp_start, gp_seq_req,
 					  TPS("Startedleaf"));
 			goto unlock_out;
 		}
@@ -1058,14 +1057,14 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 
 	/* If GP already in progress, just leave, otherwise start one. */
 	if (rcu_gp_in_progress()) {
-		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
+		trace_rcu_this_gp(rnp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
-	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
+	trace_rcu_this_gp(rnp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 	if (!READ_ONCE(rcu_state.gp_kthread)) {
-		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
+		trace_rcu_this_gp(rnp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
 	trace_rcu_grace_period(rcu_state.name, data_race(rcu_state.gp_seq), TPS("newreq"));
@@ -1088,12 +1087,11 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 {
 	bool needmore;
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	needmore = ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed);
 	if (!needmore)
 		rnp->gp_seq_needed = rnp->gp_seq; /* Avoid counter wrap. */
-	trace_rcu_this_gp(rnp, rdp, rnp->gp_seq,
+	trace_rcu_this_gp(rnp, rnp->gp_seq,
 			  needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
 }
@@ -2252,8 +2250,7 @@ static noinline void rcu_gp_cleanup(void)
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
-		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
-				  TPS("CleanupMore"));
+		trace_rcu_this_gp(rnp, rnp->gp_seq_needed, TPS("CleanupMore"));
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 373b877cf171d3..c4a5b4662b3afa 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -802,12 +802,12 @@ static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
 		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
+		trace_rcu_this_gp(rnp, wait_gp_seq, TPS("StartWait"));
 		swait_event_interruptible_exclusive(
 			rnp->nocb_gp_wq[rcu_seq_ctr(wait_gp_seq) & 0x1],
 			rcu_seq_done(&rnp->gp_seq, wait_gp_seq) ||
 			!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
+		trace_rcu_this_gp(rnp, wait_gp_seq, TPS("EndWait"));
 	}
 
 	if (!rcu_nocb_poll) {
-- 
2.40.1

