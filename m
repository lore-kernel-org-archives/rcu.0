Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2F3B8921;
	Wed, 24 Jun 2026 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307468; cv=none; b=GnLmoeoigSOfsFpZ2KZmiRWKuaO1BHKiLOCjIdFw7HgY8rLnczRLbDV37zZOpNjrHTmTKWs8M99PznutS3F4ix4f5Ezj0WS2XrQTKRChiOwDR+AC64t7rC0rv+Map9dNeZP6WVSUhZCJdy87eo7WEkgmEjW4tGSuKW0844hJ6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307468; c=relaxed/simple;
	bh=lHsTVqdiXfrfE5DlZgrYRVhWysjvWHd2uU5QQM7L3FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+e/BC7aa1K5e5SjfdvkE1UlvEZDp/YXAmF11OpDrKrAAjg9inkO+jSGZwHDKEx1yTQDlU5h3GiYPFMOxw+tfv5O3f2VDSHk/qC/UjHkKM4YUFl/K92aaJEZWy7Eq9llVnTW0z3BYkoaEdtH1/asri/Tz6G3bGMXprNbKtrHRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC2bJSmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC2bJSmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0741F000E9;
	Wed, 24 Jun 2026 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307466;
	bh=37Vympv9q58Xl9PWJomPTeT9Qn5DfOePG6UAXinKmZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MC2bJSmTBPGppIyxUV0YZg0xq4+QDuSEsSrpXqhJplSIKe+YKQcriiwARVYNwT/Kb
	 u2ZZTqIwRC9MD2w/LmDXLV+tzdptxkt0LY8iXj58Mi8XJIT+85Ebff8HjOcxtZWP30
	 72JsIKqgtLZ37Zt73Klsj2Zw13Xj38Q+NluNchNVlAcw1FnLo3uPxujjJw+hJ1UULV
	 lid99rqeC8GV2JqhDuBu6TRTw/6Bd45BzjF1h4yFH42wKohBPN9s/2g9OFt5D1+Pmz
	 KY1g3CAG6h6OFo7A5X7gAbgHkaycilazpTFPSawF/SnfGmJMN2B5psbAmVlpJXMC8w
	 KNpSanzvyxuaw==
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
Subject: [PATCH v1 02/11] rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
Date: Wed, 24 Jun 2026 06:23:44 -0700
Message-ID: <20260624132356.516959-3-puranjay@kernel.org>
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

Add srcu_segcblist_advance() and srcu_segcblist_accelerate() wrappers
that forward to the core rcu_segcblist_advance() and
rcu_segcblist_accelerate() functions, and switch all SRCU (srcutree.c)
and Tasks RCU (tasks.h) callers to use these wrappers.

This isolates SRCU and Tasks RCU from upcoming changes to the core
advance/accelerate functions, which will switch to struct
rcu_gp_seq for dual normal/expedited GP tracking. Because SRCU and
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
index 298a2c573f02c..da39d818b01b1 100644
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
index fadc08ad4b7b6..956f2967d9d29 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -143,3 +143,5 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
+bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7a..519a35719c896 100644
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
index f4da5fad70f51..92971499a12c5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -481,8 +481,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
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
@@ -565,7 +565,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	if (rcu_segcblist_empty(&rtpcp->cblist))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+	srcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
 	rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	len = rcl.len;
@@ -578,7 +578,7 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 	}
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_add_len(&rtpcp->cblist, -len);
-	(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+	(void)srcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 
-- 
2.53.0-Meta

