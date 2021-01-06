Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AFDC43332
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A38E22CB9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAFB1B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbhAFB1B (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:27:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21CC922EBF;
        Wed,  6 Jan 2021 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896379;
        bh=KpJA4T31mMx8zQ9gfEHymN9LDd57b9rAN8IpR/Y+OPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6rso7YdE1ZA3xSuyZTQdvaOX5WiSSf+wEv/11Hwqww24E9hljtks4hQ5C2EcpkZR
         zSKFO2PJTqzGRfHayi5c41Mf2QhGsuwqz6/rwdkfZV9Hdpo3GwQ2snZkDYC3c4Qdky
         4W9/IQynSoWH/yNKmhDta631UKqfbNAYFhMCe6RbSx2IwARnzh6G+bBB+Q5pl9oLJn
         90h1tb630j6tFpb7M0lKKZVY1Z1MUm77lHlo3nNHcOPrcNFpp8HPRXXxbgUAWIse6e
         86JVESegFMf1z+yBBQS5vn+co2Sg0jekHyCuopzO3gPKd5PHaAtO7AzUEwHo4VTqhQ
         yZxEQGaeDng7Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/6] rcu/segcblist: Add counters to segcblist datastructure
Date:   Tue,  5 Jan 2021 17:26:14 -0800
Message-Id: <20210106012617.14122-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106012541.GA13972@paulmck-ThinkPad-P72>
References: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Add counting of segment lengths of segmented callback list.

This will be useful for a number of things such as knowing how big the
ready-to-execute segment have gotten. The immediate benefit is ability
to trace how the callbacks in the segmented callback list change.

Also this patch remove hacks related to using donecbs's ->len field as a
temporary variable to save the segmented callback list's length. This cannot be
done anymore and is not needed.

Also fix SRCU:
The negative counting of the unsegmented list cannot be used to adjust
the segmented one. To fix this, sample the unsegmented length in
advance, and use it after CB execution to adjust the segmented list's
length.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h |   1 +
 kernel/rcu/rcu_segcblist.c    | 120 +++++++++++++++++++++++++++---------------
 kernel/rcu/rcu_segcblist.h    |   2 -
 kernel/rcu/srcutree.c         |   5 +-
 4 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index b36afe7..6c01f09 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -72,6 +72,7 @@ struct rcu_segcblist {
 #else
 	long len;
 #endif
+	long seglen[RCU_CBLIST_NSEGS];
 	u8 enabled;
 	u8 offloaded;
 };
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 0f55864..0504fc83 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -7,10 +7,10 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
-#include <linux/rcupdate.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
 
 #include "rcu_segcblist.h"
 
@@ -88,6 +88,46 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 #endif
 }
 
+/* Get the length of a segment of the rcu_segcblist structure. */
+static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+	return READ_ONCE(rsclp->seglen[seg]);
+}
+
+/* Set the length of a segment of the rcu_segcblist structure. */
+static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+	WRITE_ONCE(rsclp->seglen[seg], v);
+}
+
+/* Increase the numeric length of a segment by a specified amount. */
+static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
+}
+
+/* Move from's segment length to to's segment. */
+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
+{
+	long len;
+
+	if (from == to)
+		return;
+
+	len = rcu_segcblist_get_seglen(rsclp, from);
+	if (!len)
+		return;
+
+	rcu_segcblist_add_seglen(rsclp, to, len);
+	rcu_segcblist_set_seglen(rsclp, from, 0);
+}
+
+/* Increment segment's length. */
+static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+	rcu_segcblist_add_seglen(rsclp, seg, 1);
+}
+
 /*
  * Increase the numeric length of an rcu_segcblist structure by the
  * specified amount, which can be negative.  This can cause the ->len
@@ -180,26 +220,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
 }
 
 /*
- * Exchange the numeric length of the specified rcu_segcblist structure
- * with the specified value.  This can cause the ->len field to disagree
- * with the actual number of callbacks on the structure.  This exchange is
- * fully ordered with respect to the callers accesses both before and after.
- */
-static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
-{
-#ifdef CONFIG_RCU_NOCB_CPU
-	return atomic_long_xchg(&rsclp->len, v);
-#else
-	long ret = rsclp->len;
-
-	smp_mb(); /* Up to the caller! */
-	WRITE_ONCE(rsclp->len, v);
-	smp_mb(); /* Up to the caller! */
-	return ret;
-#endif
-}
-
-/*
  * Initialize an rcu_segcblist structure.
  */
 void rcu_segcblist_init(struct rcu_segcblist *rsclp)
@@ -209,8 +229,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
 	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
 	rsclp->head = NULL;
-	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
 		rsclp->tails[i] = &rsclp->head;
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 	rcu_segcblist_set_len(rsclp, 0);
 	rsclp->enabled = 1;
 }
@@ -306,6 +328,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 {
 	rcu_segcblist_inc_len(rsclp);
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
+	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
@@ -334,6 +357,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] != rsclp->tails[i - 1])
 			break;
+	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
 		WRITE_ONCE(rsclp->tails[i], &rhp->next);
@@ -341,21 +365,6 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 }
 
 /*
- * Extract only the counts from the specified rcu_segcblist structure,
- * and place them in the specified rcu_cblist structure.  This function
- * supports both callback orphaning and invocation, hence the separation
- * of counts and callbacks.  (Callbacks ready for invocation must be
- * orphaned and adopted separately from pending callbacks, but counts
- * apply to all callbacks.  Locking must be used to make sure that
- * both orphaned-callbacks lists are consistent.)
- */
-void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
-					       struct rcu_cblist *rclp)
-{
-	rclp->len = rcu_segcblist_xchg_len(rsclp, 0);
-}
-
-/*
  * Extract only those callbacks ready to be invoked from the specified
  * rcu_segcblist structure and place them in the specified rcu_cblist
  * structure.
@@ -367,6 +376,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_ready_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
@@ -374,6 +384,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
+	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
 /*
@@ -390,11 +401,15 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = 0;
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
-	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
+	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
+		rclp->len += rcu_segcblist_get_seglen(rsclp, i);
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 }
 
 /*
@@ -405,7 +420,6 @@ void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
 				struct rcu_cblist *rclp)
 {
 	rcu_segcblist_add_len(rsclp, rclp->len);
-	rclp->len = 0;
 }
 
 /*
@@ -419,6 +433,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rclp->head)
 		return; /* No callbacks to move. */
+	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, rclp->head);
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
@@ -439,6 +454,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 {
 	if (!rclp->head)
 		return; /* Nothing to do. */
+
+	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
 }
@@ -463,6 +480,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
 	}
 
 	/* If no callbacks moved, nothing more need be done. */
@@ -483,6 +501,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
 			break;  /* No more callbacks. */
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, j);
 		rsclp->gp_seq[j] = rsclp->gp_seq[i];
 	}
 }
@@ -504,7 +523,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i;
+	int i, j;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -547,6 +566,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
+	/* Accounting: everything below i is about to get merged into i. */
+	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
+		rcu_segcblist_move_seglen(rsclp, j, i);
+
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
 	 * into the segment located by the for-loop above.  Assign "seq"
@@ -574,13 +597,24 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 	struct rcu_cblist donecbs;
 	struct rcu_cblist pendcbs;
 
+	lockdep_assert_cpus_held();
+
 	rcu_cblist_init(&donecbs);
 	rcu_cblist_init(&pendcbs);
-	rcu_segcblist_extract_count(src_rsclp, &donecbs);
+
 	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
+
+	/*
+	 * No need smp_mb() before setting length to 0, because CPU hotplug
+	 * lock excludes rcu_barrier.
+	 */
+	rcu_segcblist_set_len(src_rsclp, 0);
+
 	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
+	rcu_segcblist_insert_count(dst_rsclp, &pendcbs);
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
+
 	rcu_segcblist_init(src_rsclp);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 1d2d614..cd35c9f 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -89,8 +89,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
-void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
-				 struct rcu_cblist *rclp);
 void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 				    struct rcu_cblist *rclp);
 void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0f23d20..79b7081 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1160,6 +1160,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
  */
 static void srcu_invoke_callbacks(struct work_struct *work)
 {
+	long len;
 	bool more;
 	struct rcu_cblist ready_cbs;
 	struct rcu_head *rhp;
@@ -1182,6 +1183,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	/* We are on the job!  Extract and invoke ready callbacks. */
 	sdp->srcu_cblist_invoking = true;
 	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
+	len = ready_cbs.len;
 	spin_unlock_irq_rcu_node(sdp);
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
@@ -1190,13 +1192,14 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 		rhp->func(rhp);
 		local_bh_enable();
 	}
+	WARN_ON_ONCE(ready_cbs.len);
 
 	/*
 	 * Update counts, accelerate new callbacks, and if needed,
 	 * schedule another round of callback invocation.
 	 */
 	spin_lock_irq_rcu_node(sdp);
-	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
+	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
-- 
2.9.5

