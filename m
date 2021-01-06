Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CBC4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5933E2313B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbhAFQ4h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbhAFQ4d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:56:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43D8423142;
        Wed,  6 Jan 2021 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609952133;
        bh=sGQVtLy7KzVVVr2Y/cRxuREyHSjHXhCs2fInoXvjJQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkFP3De6MqMzkADnwgY4cUDVyBcJUurakfH++CrxS40Qm4H8RPlm4HVlq5Hj4hLCQ
         qboA/X1y1ueJ75M05c4gn3fyBmpMoQBL6s5AUgX4DskAJb3Qi6lr3tqikbixXhiGkN
         dOoDxswnINNq46pf9hvqe2MUeA0ZVnFvnYzHQ2omeIq8tSb2ZD/cdEgQ1tkM/fiEGN
         0Zs5LH6AcV78SsITwFjVkvg3MTdyIFYgdxayObMKazIEu8AxZZLH0EIBC+L1e0DMcJ
         A/upMkfPuCB2zfeqqsZuhK2O66eqkcQbls6bOWxJWcNMk2Xzo1UxdGlu6fmaeYWGNr
         sqRChIxqdtFPg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/10] srcu: Provide polling interfaces for Tree SRCU grace periods
Date:   Wed,  6 Jan 2021 08:55:26 -0800
Message-Id: <20210106165531.20697-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165511.GA20555@paulmck-ThinkPad-P72>
References: <20210106165511.GA20555@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a need for a polling interface for SRCU grace
periods, so this commit supplies get_state_synchronize_srcu(),
start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
purpose.  The first can be used if future grace periods are inevitable
(perhaps due to a later call_srcu() invocation), the second if future
grace periods might not otherwise happen, and the third to check if a
grace period has elapsed since the corresponding call to either of the
first two.

As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
the return value from either get_state_synchronize_srcu() or
start_poll_synchronize_srcu() must be passed in to a later call to
poll_state_synchronize_srcu().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
[ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
[ paulmck: Apply feedback from Neeraj Upadhyay. ]
Link: https://lore.kernel.org/lkml/20201117004017.GA7444@paulmck-ThinkPad-P72/
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9a7b650..c5d0c03 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -810,7 +810,8 @@ static void srcu_leak_callback(struct rcu_head *rhp)
 /*
  * Start an SRCU grace period, and also queue the callback if non-NULL.
  */
-static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
+static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
+					     struct rcu_head *rhp, bool do_norm)
 {
 	unsigned long flags;
 	int idx;
@@ -819,10 +820,12 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
 	unsigned long s;
 	struct srcu_data *sdp;
 
+	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
 	sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
-	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
+	if (rhp)
+		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
 	s = rcu_seq_snap(&ssp->srcu_gp_seq);
@@ -841,6 +844,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp->mynode, s);
 	srcu_read_unlock(ssp, idx);
+	return s;
 }
 
 /*
@@ -874,7 +878,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
-	check_init_srcu_struct(ssp);
 	if (debug_rcu_head_queue(rhp)) {
 		/* Probable double call_srcu(), so leak the callback. */
 		WRITE_ONCE(rhp->func, srcu_leak_callback);
@@ -882,7 +885,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
-	srcu_gp_start_if_needed(ssp, rhp, do_norm);
+	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
 
 /**
@@ -1011,6 +1014,62 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/**
+ * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
+ * @ssp: srcu_struct to provide cookie for.
+ *
+ * This function returns a cookie that can be passed to
+ * poll_state_synchronize_srcu(), which will return true if a full grace
+ * period has elapsed in the meantime.  It is the caller's responsibility
+ * to make sure that grace period happens, for example, by invoking
+ * call_srcu() after return from get_state_synchronize_srcu().
+ */
+unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
+{
+	// Any prior manipulation of SRCU-protected data must happen
+	// before the load from ->srcu_gp_seq.
+	smp_mb();
+	return rcu_seq_snap(&ssp->srcu_gp_seq);
+}
+EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
+
+/**
+ * start_poll_synchronize_srcu - Provide cookie and start grace period
+ * @ssp: srcu_struct to provide cookie for.
+ *
+ * This function returns a cookie that can be passed to
+ * poll_state_synchronize_srcu(), which will return true if a full grace
+ * period has elapsed in the meantime.  Unlike get_state_synchronize_srcu(),
+ * this function also ensures that any needed SRCU grace period will be
+ * started.  This convenience does come at a cost in terms of CPU overhead.
+ */
+unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
+{
+	return srcu_gp_start_if_needed(ssp, NULL, true);
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
+
+/**
+ * poll_state_synchronize_srcu - Has cookie's grace period ended?
+ * @ssp: srcu_struct to provide cookie for.
+ * @cookie: Return value from get_state_synchronize_srcu() or start_poll_synchronize_srcu().
+ *
+ * This function takes the cookie that was returned from either
+ * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
+ * returns @true if an SRCU grace period elapsed since the time that the
+ * cookie was created.
+ */
+bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
+{
+	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
+		return false;
+	// Ensure that the end of the SRCU grace period happens before
+	// any subsequent code that the caller might execute.
+	smp_mb(); // ^^^
+	return true;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
+
 /*
  * Callback function for srcu_barrier() use.
  */
-- 
2.9.5

