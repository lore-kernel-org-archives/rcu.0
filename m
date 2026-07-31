Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57C199EAD;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459459; cv=none; b=LHDfBUYnAFN+ZHU/ue9TUYtgJz+a4uk2sHt2FdLKEm5+gfMnj98RqNNQsau6hEA4r01DNgTe4nhGGeloROOeQLTfanbhoso5zXev01Jg0YZUG9/38HKjkv02sKDLoG4Y6DkaEAQC/Ml9yalwvZkxQ/gGhncMoC5FwdJ64bp2n7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459459; c=relaxed/simple;
	bh=at9kSnzuo2h1rAuYkClV1HLM+3RCOupGo1odC9IdXnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEKbaydEIz1sLAFm9R0WiSLhc5j/ubtyK5+z7LcgML4elAsoD6LbLnzdaDJ6/RsgI0MXXZRQ1rF9hpj3JzR4K0MEv4at7witcKukizDHaR+QSnhfZjHfnBQ7PPH2FyW4MWXX7OwUoV0I0RCJuvDja6ePDg5m1ROX4ptg7l+Vrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odNT82pW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odNT82pW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788081F00A3E;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=ipRQtg27U8zrAsaabNwNYnzMMRmegqeZb/5LLNnp01s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odNT82pW4SzWierWrzw9/3hakGYtlLOIhjUlPp4K9R1QskBGEVztURdfD9PIrmH/N
	 bjQCoJplroqAuN2ZOhxtR/tMVT3t6bKYqaUDrlqxlXLLQIRH5T+Had4MTxYLSpK/4+
	 suvpAeDAMeSiekitPGG6mo1gl00Seo0DcaNc8bYT7ChQAlCmKylDORpqx06lV0S593
	 14QmqTBYQG5A2MIp8dVIxmtShCUeHLpTklfagu1LGK7HxmmDK/erTgXgS1DfPIO71g
	 +jwpSakZYDCKdDNFpdv8UnI+LOtBtMlQ/RDvjxL+Lv5GOOx/vE6Jy9GwsjB55RYV6y
	 0R21acP1LKKOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 390A2CE0F7B; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH RFC 03/12] rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
Date: Thu, 30 Jul 2026 17:57:23 -0700
Message-Id: <20260731005732.3530999-3-paulmck@kernel.org>
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
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 10 ++++++++++
 kernel/rcu/rcu_segcblist.h |  2 ++
 kernel/rcu/srcutree.c      | 14 +++++++-------
 kernel/rcu/tasks.h         |  8 ++++----
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 298a2c573f02c3..da39d818b01b10 100644
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
index fadc08ad4b7b60..956f2967d9d294 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -143,3 +143,5 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+void srcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
+bool srcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7ae..519a35719c8961 100644
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
index f4da5fad70f516..92971499a12c55 100644
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
2.40.1

