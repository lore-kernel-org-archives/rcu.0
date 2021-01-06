Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036AC433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBFE23133
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbhAFQ4c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbhAFQ4b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E10832313B;
        Wed,  6 Jan 2021 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952133;
        bh=5kjvvfCBhTpsqpOOzsZqBZ1De3Xk1DqVgVN4tQQCvZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmgmQGI4KUrUjKFN0KZ9jor0+BltfBZYVo0TeTa1CRYimpWcrsXH8yRdZG5U482jP
         0PPFyBNPkJZj5RkBqBLCr65vWKA17QIJmXdChdUaLZrcMbHCxWItimLy6pJRfmG99R
         dMhn0YakBnIIpQEYEKT+WxhSeKVOejuK1Cbaw0Wp3S7KZqhhu4aufpNAlLUraNBale
         7ZvnuhQGJupwmBiCC3Op5c4mxrMs09hAkqFvIATn5iYBwDda9Pssmi/5s2+vZJX+hg
         F/FUjr9cmZ8kw5UHMP9E9y24FgRzxFTsj2bQ/cIUCslWOa6q4xWdoxkvziXtnwnNdO
         WUGvT+ZBFRsuQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/10] srcu: Provide internal interface to start a Tree SRCU grace period
Date:   Wed,  6 Jan 2021 08:55:24 -0800
Message-Id: <20210106165531.20697-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
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
index 0f23d20..9a7b650 100644
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

