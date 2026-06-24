Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E543B9D91;
	Wed, 24 Jun 2026 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307471; cv=none; b=liXx87lRRwUpDAb4x7tz/kb7yB32iXFTP9PddBOWfjWiihBPhuE6MD2a/DJlnBZPjMfo7dNuLTDtUyQw30Yc0GqyHfNBkJRjgZcXJIeXEMcCH1NjqVLgykTlnd8ilG7mayjAOyM6cU+MW8+B6/sIU9y4JJC94kWEuP9x2/+B/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307471; c=relaxed/simple;
	bh=Ni+/jMs8hYvq8gRV8cLdAXi7+fOk5cxrIr24qvIU+ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5h+fbiQCRGVz5+eNmlyLJIewSTyiBFsHBmC5/h9wHXcmvI+rzwCUKCZBkuzejiX9XPrMLucG4mgB9MZOnkh/1FzucL2S1HWR6Qt25bdYmJlMslRts2PohnjadhSMJO3S3e8+RlJ6DOLNfULJHAeeuBB72Ox5aeHwH1XGSBCXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEntZ4eC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEntZ4eC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137401F000E9;
	Wed, 24 Jun 2026 13:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307470;
	bh=Hcg9GLK9uQGKKCwrJ+9xngkZh1qeDPCKca/RRUouvp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YEntZ4eCYY1rMBpkaGX4ckkJlDNj0tsTpI9Ybsirmd3KVOIexQjxB+af4Apr/CBZE
	 BG/81eciwFhfaNQUVtlcJL3TCKHeXOfM9kUKQu1FCvORWDIFMkECLZ1ESBiBcoyvg8
	 OggKFySw7thKf46ao8BlGIQOutqUBKMUJopAnNH6H0cPvBCWjgxR8lz9UuerLsh9C1
	 djKx0o02IK0XczPlLuwzwFXGNTPDekCKmuCBGV990FOIj9I5nWNHRzzqjUM3V9jA6m
	 OHNotJ/xTmpqqXvptgxt7HCVg4omy292zERqbVaM+Cwd8Y1Os3J4GzSg0uhb4jK5hK
	 uowzZOnCq2cow==
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
Subject: [PATCH v1 03/11] rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
Date: Wed, 24 Jun 2026 06:23:45 -0700
Message-ID: <20260624132356.516959-4-puranjay@kernel.org>
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
index da39d818b01b1..421f1dadb5e55 100644
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
2.53.0-Meta

