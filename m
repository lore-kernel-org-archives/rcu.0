Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF585C64E75
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7BA24682
	for <rcu@archiver.kernel.org>; Tue, 17 Nov 2020 00:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yQoMCs6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgKQAlB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730225AbgKQAk4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Nov 2020 19:40:56 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24EEB24683;
        Tue, 17 Nov 2020 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605573655;
        bh=t3gFUD8UzRILvvObtA79/SJ6FY/Ael1YGmgYzpkRO68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQoMCs6QbXonCbg2LtnDin+Guts5HbvksjXqQuv/RSBTZ8c7v9GBGAGXjCENQuJFD
         Bl9VsSMb7lED9662/ogyONXt6E2IhkRny5/H37qAUZ8dwrn5ldriMEJSMKecBYFN6F
         SGCB/M6xoYt6Ud09lMzsfONrF+e0euiFMEP+oCF8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 3/5] srcu: Provide internal interface to start a Tree SRCU grace period
Date:   Mon, 16 Nov 2020 16:40:50 -0800
Message-Id: <20201117004052.14758-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201117004017.GA7444@paulmck-ThinkPad-P72>
References: <20201117004017.GA7444@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a need for a polling interface for SRCU grace periods.
This polling needs to initiate an SRCU grace period without having
to queue (and manage) a callback.  This commit therefore splits the
Tree SRCU __call_srcu() function into callback-initialization and
queuing/start-grace-period portions, with the latter in a new function
named srcu_gp_start_if_needed().  This function may be passed a NULL
callback pointer, in which case it will refrain from queuing anything.

Why have the new function mess with queuing?  Locking considerations,
of course!

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 66 +++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 79b7081..d930ece 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -808,6 +808,42 @@ static void srcu_leak_callback(struct rcu_head *rhp)
 }
 
 /*
+ * Start an SRCU grace period, and also queue the callback if non-NULL.
+ */
+static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
+{
+	unsigned long flags;
+	int idx;
+	bool needexp = false;
+	bool needgp = false;
+	unsigned long s;
+	struct srcu_data *sdp;
+
+	idx = srcu_read_lock(ssp);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
+	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
+	rcu_segcblist_advance(&sdp->srcu_cblist,
+			      rcu_seq_current(&ssp->srcu_gp_seq));
+	s = rcu_seq_snap(&ssp->srcu_gp_seq);
+	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
+	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
+		sdp->srcu_gp_seq_needed = s;
+		needgp = true;
+	}
+	if (!do_norm && ULONG_CMP_LT(sdp->srcu_gp_seq_needed_exp, s)) {
+		sdp->srcu_gp_seq_needed_exp = s;
+		needexp = true;
+	}
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	if (needgp)
+		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
+	else if (needexp)
+		srcu_funnel_exp_start(ssp, sdp->mynode, s);
+	srcu_read_unlock(ssp, idx);
+}
+
+/*
  * Enqueue an SRCU callback on the srcu_data structure associated with
  * the current CPU and the specified srcu_struct structure, initiating
  * grace-period processing if it is not already running.
@@ -838,13 +874,6 @@ static void srcu_leak_callback(struct rcu_head *rhp)
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
-	unsigned long flags;
-	int idx;
-	bool needexp = false;
-	bool needgp = false;
-	unsigned long s;
-	struct srcu_data *sdp;
-
 	check_init_srcu_struct(ssp);
 	if (debug_rcu_head_queue(rhp)) {
 		/* Probable double call_srcu(), so leak the callback. */
@@ -853,28 +882,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
-	idx = srcu_read_lock(ssp);
-	sdp = raw_cpu_ptr(ssp->sda);
-	spin_lock_irqsave_rcu_node(sdp, flags);
-	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_gp_seq));
-	s = rcu_seq_snap(&ssp->srcu_gp_seq);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
-	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
-		sdp->srcu_gp_seq_needed = s;
-		needgp = true;
-	}
-	if (!do_norm && ULONG_CMP_LT(sdp->srcu_gp_seq_needed_exp, s)) {
-		sdp->srcu_gp_seq_needed_exp = s;
-		needexp = true;
-	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
-	if (needgp)
-		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
-	else if (needexp)
-		srcu_funnel_exp_start(ssp, sdp->mynode, s);
-	srcu_read_unlock(ssp, idx);
+	srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
 
 /**
-- 
2.9.5

