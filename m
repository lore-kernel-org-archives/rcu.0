Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985E37F755;
	Fri, 17 Apr 2026 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467560; cv=none; b=fV9KpF/MGbm/G97OWb02Ly/S+S7MuUFBXmMpYvMS0iXhCK/2Ou1hDRPvBhzFU6E4mKwYSg9NRAXNh29rMq9+hCILEV8W0bhBquakTUZwY+z994PtB9k3zpOw8HHmYCYIeOgBB/p1jZT10ehHkmlk+vxhMgtDh+WyenD81GPBKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467560; c=relaxed/simple;
	bh=C6eXVJtdCv0U+mKdmzMLMpRCaEdddKwLfL5AIcr7fbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcvMbaXVIY0/uyoowvO30J5OrvwOjEshDnrcbuzfFZn+y0UkZbZxcp697iksiK3UljvqJjcbgYCWIaqT9lZYVtbmKoE4shskto74FiQzEkEbYPXwSOr0AYKItndgBWjicy12G9/co9qiU78+9xzzKG3038qPMI3T7XDv9MTEfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTrowOah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTrowOah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC841C19425;
	Fri, 17 Apr 2026 23:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467560;
	bh=C6eXVJtdCv0U+mKdmzMLMpRCaEdddKwLfL5AIcr7fbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTrowOahe0C//xWdkTuFzwMFqhSXX1rQuFikSOpiO0yeK32q1LY43mic/GWiK1nGC
	 zZ1K4CW4gzmpVEKQsSuHwi7ml7xEpyBei6OvkBiVdirhm9IMm5AHwJ5azbrfCw1kw4
	 Lr8sKGuTLHUB2CCsmg8FCw57PL2+OMg6MuRCJN34rJCA0aN8JIu6W+uh35G6ci7HVq
	 GUljO4j93QRcxaMaSpAOmXQD1Guy9M7PyGoxVLjnqmMuSDQ8iPG02u2G0w31NjvNBm
	 VOXLqXZeKSPNMFV4aVJh5xzgakP1qekghMq6j0YUmCoUBWk/B370DN8oRASB9/S5Qa
	 XKlpLfmz18nfA==
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
Subject: [RFC PATCH 02/10] rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
Date: Fri, 17 Apr 2026 16:11:50 -0700
Message-ID: <20260417231203.785172-3-puranjay@kernel.org>
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

This commit extracts the tail-pointer cleanup and segment compaction
logic from rcu_segcblist_advance() into a new static helper function,
rcu_segcblist_advance_compact(). This shared logic will be reused by the
upcoming srcu_segcblist_advance() standalone implementation, which
cannot call the core rcu_segcblist_advance() because that function will
use RCU-specific globals.

No functional change.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 50 ++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index da39d818b01b..421f1dadb5e5 100644
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
2.52.0

