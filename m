Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFB37F01B;
	Fri, 17 Apr 2026 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467556; cv=none; b=g962PZP0F2LJbdbDLTKIFvuV2cZ8tyS32CM/bf/v71oNAbXqbLQRzJhtM6h/GQeyEQAg1XZs5tw5DX+/3P4lPUbyGOMx8F7WDibRHogn3Oz4p/55EZNn9b2SK9JiNohQpsXZrwRwDvaVT/nTNC+Oe2OCrK3ZopwXvc9KkgN345M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467556; c=relaxed/simple;
	bh=y8k9KesEYjw6UgKPiJ9HqmcTZawjZ2GnNcBT5jS6CwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLw+AbmhyPEE2v/iZXU4iw1qrFBqznq2xcvlrbXiJRnfbEmgH7Al7pESoQLyQyDXBAUbSeqDeXiHFR/FgOvTAeO5SmeYquQZbP9cAAzkJa9I7q1IY7wZp7XRo0jyIEGZsR7AZt7k1hK8Lrvh3IUU/MrNWURzpUkQcmFUst0Il9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQSolrWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQSolrWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090FAC2BCB3;
	Fri, 17 Apr 2026 23:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467556;
	bh=y8k9KesEYjw6UgKPiJ9HqmcTZawjZ2GnNcBT5jS6CwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQSolrWi/5A53syeGXwVoEvkjc97WXv1yBZqnPxxIVb723CzdgTUJzt42yaMt714v
	 BfFOzrbB4iAgG82XRIzKNNobqxL6uc2XaIYE/x1uP6OOghHNdPXU57a+dgJymzxYwe
	 NnI6uRws0yMUkCutNlBZ2WLRJ5Tn3Puw5T5NogoghfZLEWyr7DYSXuwOOe4oFLVsCl
	 OFAt1a4E3ECt2SY7zREgJVpJBioDEW+hSB2mh8qJFqE1w1ylxswv4B3wIaGjjApsVl
	 JRdkScQaDV/ZXqkWbB3pz9pCyVzAEUkdhKb0Oxea/rQBUTZz3V4PK0kREfCuiWte2v
	 oZj47OrJOafvw==
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
Subject: [RFC PATCH 01/10] rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
Date: Fri, 17 Apr 2026 16:11:49 -0700
Message-ID: <20260417231203.785172-2-puranjay@kernel.org>
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

Add srcu_segcblist_advance() and srcu_segcblist_accelerate() wrappers
that forward to the core rcu_segcblist_advance() and
rcu_segcblist_accelerate() functions, and switch all SRCU (srcutree.c)
and Tasks RCU (tasks.h) callers to use these wrappers.

This isolates SRCU and Tasks RCU from upcoming changes to the core
advance/accelerate functions, which will switch to struct
rcu_gp_oldstate for dual normal/expedited GP tracking. Because SRCU and
Tasks RCU use only normal GP sequences, their wrappers will maintain the
existing unsigned long interface.

No functional change.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 10 ++++++++++
 kernel/rcu/rcu_segcblist.h |  2 ++
 kernel/rcu/srcutree.c      | 14 +++++++-------
 kernel/rcu/tasks.h         |  8 ++++----
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 298a2c573f02..da39d818b01b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -620,3 +620,13 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 
 	rcu_segcblist_init(src_rsclp);
 }
+
+void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
+{
+	rcu_segcblist_advance(rsclp, seq);
+}
+
+bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
+{
+	return rcu_segcblist_accelerate(rsclp, seq);
+}
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index fadc08ad4b7b..956f2967d9d2 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -143,3 +143,5 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
+bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7..519a35719c89 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1351,7 +1351,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 *  2) The grace period for RCU_WAIT_TAIL is seen as started but not
 	 *     completed so rcu_seq_current() returns X + SRCU_STATE_SCAN1.
 	 *
-	 *  3) This value is passed to rcu_segcblist_advance() which can't move
+	 *  3) This value is passed to srcu_segcblist_advance() which can't move
 	 *     any segment forward and fails.
 	 *
 	 *  4) srcu_gp_start_if_needed() still proceeds with callback acceleration.
@@ -1360,15 +1360,15 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 *     RCU_NEXT_READY_TAIL segment as started (ie: X + 4 + SRCU_STATE_SCAN1)
 	 *     so it returns a snapshot of the next grace period, which is X + 12.
 	 *
-	 *  5) The value of X + 12 is passed to rcu_segcblist_accelerate() but the
+	 *  5) The value of X + 12 is passed to srcu_segcblist_accelerate() but the
 	 *     freshly enqueued callback in RCU_NEXT_TAIL can't move to
 	 *     RCU_NEXT_READY_TAIL which already has callbacks for a previous grace
 	 *     period (gp_num = X + 8). So acceleration fails.
 	 */
 	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
 	if (rhp) {
-		rcu_segcblist_advance(&sdp->srcu_cblist,
-				      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+		srcu_segcblist_advance(&sdp->srcu_cblist,
+				       rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 		/*
 		 * Acceleration can never fail because the base current gp_seq
 		 * used for acceleration is <= the value of gp_seq used for
@@ -1376,7 +1376,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		 * always be able to be emptied by the acceleration into the
 		 * RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL segments.
 		 */
-		WARN_ON_ONCE(!rcu_segcblist_accelerate(&sdp->srcu_cblist, s));
+		WARN_ON_ONCE(!srcu_segcblist_accelerate(&sdp->srcu_cblist, s));
 	}
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
@@ -1891,8 +1891,8 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rcu_cblist_init(&ready_cbs);
 	raw_spin_lock_irq_rcu_node(sdp);
 	WARN_ON_ONCE(!rcu_segcblist_segempty(&sdp->srcu_cblist, RCU_NEXT_TAIL));
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+	srcu_segcblist_advance(&sdp->srcu_cblist,
+			       rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	/*
 	 * Although this function is theoretically re-entrant, concurrent
 	 * callbacks invocation is disallowed to avoid executing an SRCU barrier
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 48f0d803c8e2..137eb6c48b2c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -480,8 +480,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			if (cpu > 0)
 				ncbsnz += n;
 		}
-		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+		srcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+		(void)srcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
 		if (rtpcp->urgent_gp > 0 && rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
 			if (rtp->lazy_jiffies)
 				rtpcp->urgent_gp--;
@@ -564,7 +564,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	if (rcu_segcblist_empty(&rtpcp->cblist))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+	srcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
 	rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
@@ -577,7 +577,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	}
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_add_len(&rtpcp->cblist, -len);
-	(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+	(void)srcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 
-- 
2.52.0

