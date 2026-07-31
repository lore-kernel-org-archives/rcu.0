Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04872C0F6D;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459456; cv=none; b=W6pqkS+TPBFmOrDAKBUBeFBSQV9EJ2FHBfo/bkytGveu88juiWuyXw8TMFYKhNVsd9inuQDfGTXyjdpa+79Zyf+Vrtc38oWtIQ2XZLGbWYkhrrJwBNWn+FxmSnYlQsoq3Wg9GN8cxSfqWwz7sZwYj1eOdjFP1SiuWA2DOWrVpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459456; c=relaxed/simple;
	bh=/8aymN6ihLKYybnvB3QeryGLxQ9QARMeZqc7VXFqY5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umEbiIGtJy4bdXPzIayaRxF8vFd8BddGoL7ikySSONOWRNSYq3MY/gBtbKX/v2fRARdOKv/BDNZpiegF26uW+TLAYCJH3OlfVbVjPK1Hv5egjNyZdjbZ2FtoVF4KByqbzOPLrnr3nLwGIBhFn27cYaSWLkHeDqiRTNn6UBz91ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqaqqoiM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqaqqoiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B6A1F00ACF;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=3dj3BHw3xLLuVTQCqZ9K3mYm0gv/QTnBtTMI55DyqGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FqaqqoiMHDUO842NN0mTg13PkDvOAt1FZfsHjQUerW4YtO//dlvzrdmDTjILAxBER
	 1T9SUJ9ZBCGoFKGmGM8jVqrMXrndyjtuFS1uUcLg4UGoGHQAh3mbTYCKVWk3koRwoT
	 lgkwc4uMTG+qPOz+8XpkTl5UHF/PPciLLebkbYxcsbXELddrTo8Idrld6cD5V+merd
	 dz1gKb1t0lI3v9Ixjyw8aSU0Yf3KWXMXQWRBZCWRhDPPBqMqZwZgZXs6VuWg3qghpO
	 O2v/Ow0+Tgl2PFHdFPTH6Uab4+HQ8aoj6uqrK8m3WF+C00v2mF22tlo3R3i6q2Dftg
	 irn6bv5HGo4ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3BD95CE0F82; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH RFC 04/12] rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
Date: Thu, 30 Jul 2026 17:57:24 -0700
Message-Id: <20260731005732.3530999-4-paulmck@kernel.org>
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

This commit extracts the tail-pointer cleanup and segment compaction
logic from rcu_segcblist_advance() into a new static helper function,
rcu_segcblist_advance_compact(). This shared logic will be reused by the
upcoming srcu_segcblist_advance() standalone implementation, which
cannot call the core rcu_segcblist_advance() because that function will
use RCU-specific globals.

No functional change.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 50 ++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index da39d818b01b10..421f1dadb5e55b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -462,13 +462,43 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
 }
 
+/*
+ * Clean up and compact the segmented callback list after callbacks have been
+ * advanced to the RCU_DONE_TAIL segment.  The @i parameter is the index of the
+ * first segment that was NOT advanced (i.e., the segment after the last one
+ * moved to RCU_DONE_TAIL). This function fixes up tail pointers and compacts
+ * any gaps left by the moved segments.
+ */
+static void rcu_segcblist_advance_compact(struct rcu_segcblist *rsclp, int i)
+{
+	int j;
+
+	/* Clean up tail pointers that might have been misordered above. */
+	for (j = RCU_WAIT_TAIL; j < i; j++)
+		WRITE_ONCE(rsclp->tails[j], rsclp->tails[RCU_DONE_TAIL]);
+
+	/*
+	 * Callbacks moved, so there might be an empty RCU_WAIT_TAIL
+	 * and a non-empty RCU_NEXT_READY_TAIL.  If so, copy the
+	 * RCU_NEXT_READY_TAIL segment to fill the RCU_WAIT_TAIL gap
+	 * created by the now-ready-to-invoke segments.
+	 */
+	for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
+		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
+			break;  /* No more callbacks. */
+		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, j);
+		rsclp->gp_seq[j] = rsclp->gp_seq[i];
+	}
+}
+
 /*
  * Advance the callbacks in the specified rcu_segcblist structure based
  * on the current value passed in for the grace-period counter.
  */
 void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i, j;
+	int i;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -489,23 +519,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (i == RCU_WAIT_TAIL)
 		return;
 
-	/* Clean up tail pointers that might have been misordered above. */
-	for (j = RCU_WAIT_TAIL; j < i; j++)
-		WRITE_ONCE(rsclp->tails[j], rsclp->tails[RCU_DONE_TAIL]);
-
-	/*
-	 * Callbacks moved, so there might be an empty RCU_WAIT_TAIL
-	 * and a non-empty RCU_NEXT_READY_TAIL.  If so, copy the
-	 * RCU_NEXT_READY_TAIL segment to fill the RCU_WAIT_TAIL gap
-	 * created by the now-ready-to-invoke segments.
-	 */
-	for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
-		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
-			break;  /* No more callbacks. */
-		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
-		rcu_segcblist_move_seglen(rsclp, i, j);
-		rsclp->gp_seq[j] = rsclp->gp_seq[i];
-	}
+	rcu_segcblist_advance_compact(rsclp, i);
 }
 
 /*
-- 
2.40.1

