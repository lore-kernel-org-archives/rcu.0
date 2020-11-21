Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3BDC64E8A
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5742B23A65
	for <rcu@archiver.kernel.org>; Sat, 21 Nov 2020 00:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z3ecfHMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKUA7c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgKUA7W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Nov 2020 19:59:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C452415A;
        Sat, 21 Nov 2020 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605920361;
        bh=W/S2m/VadUOhISjmRqts6KrTfwpyKxEGsMBt8JeMGZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3ecfHMzmKO6GDuqD1KLvf9TTeqIDDB85TQfX8J6u7M/sGx2jpfZPR3H7M0FIvaPT
         /r0hRh/MJ3GTw+k10jRexPKx++qNddJT/Ms+M1HbI+H5XWxu1gEZxaFhdCed2HpjGi
         2+Sl02j4y01vAn/u/LArFaWbYSDh3bgtrBUbvwh8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, kent.overstreet@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 tip/core/rcu 3/6] srcu: Provide internal interface to start a Tree SRCU grace period
Date:   Fri, 20 Nov 2020 16:59:16 -0800
Message-Id: <20201121005919.17152-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <@@@>
References: <@@@>
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
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
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

