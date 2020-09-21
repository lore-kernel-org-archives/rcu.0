Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49460C43466
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F358620888
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cLLutTfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIUBWB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Sep 2020 21:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUBWA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Sep 2020 21:22:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B3C0613D1
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so13387294qkn.11
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eAEsrai5Jz6rS2hapeOWYn1RfZ/IX16bKE2QT0/Sq58=;
        b=cLLutTfHzOugst1gUPNx2p6JGjsoZgcTnhJhr+1hh2QoAIPo/Vt/nxs8x5GVTk3Mgf
         oMdUbyHj8S2zlEf3mPmIhyj6iXWpbg7klmo3OAMS6oUWabnxZutaxvr+NwEgJUvYVhay
         UcEq/ruCgL+Omtt3t6JbDxuFybX6i057KRFCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eAEsrai5Jz6rS2hapeOWYn1RfZ/IX16bKE2QT0/Sq58=;
        b=WHAwguTMxasE4Xg5GEmiq2EN5rJY6V1SWV8EXyOIqOPPqCsTRnGJ8EF/o4xTvN1qxh
         9R/BZ2nXHHCp8KY2OFC9T3HUNEcMZ2SRdNzrkkk7TFkjAFVqeMG4G0pWiCwwX5KM4RXs
         DGSW3eoksLT/vr3AoQ6plMTNYSSao+4+7Hru9nVq3w9fwzCx+xrE/1xZXzBWRSGjCr2j
         Io3P482CDkAEeP0B3iEQ/OkuytJjMGjQiDj1etsFGpHujgX2Wr92pSlW6WjsC2tpT1b0
         1vYw+TeGfxZXTpMamyX+QdgoHLTOQEFgiUWNihHzQ7zU70FtcCxBA7G++z/HIvepxWu8
         KbYQ==
X-Gm-Message-State: AOAM531qIvyUcVXpqzM4XVR7gHi6FJBb9k+jJW6eFB1qn6rbJWwascYR
        P1iD6tgaZEPR2ym7fTc5p6K+OA==
X-Google-Smtp-Source: ABdhPJwR0RwLKAXbgz+8Rz8ebZxdwS5m+Tjq1FMSEmyQs3Y49f2uoiMJ6SqaP/PAIHpzVg8cByS53g==
X-Received: by 2002:a37:c4b:: with SMTP id 72mr43050125qkm.176.1600651319681;
        Sun, 20 Sep 2020 18:21:59 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l26sm7741951qki.62.2020.09.20.18.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:21:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v5 2/5] rcu/segcblist: Add counters to segcblist datastructure
Date:   Sun, 20 Sep 2020 21:21:49 -0400
Message-Id: <20200921012152.2831904-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921012152.2831904-1-joel@joelfernandes.org>
References: <20200921012152.2831904-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add counting of segment lengths of segmented callback list.

This will be useful for a number of things such as knowing how big the
ready-to-execute segment have gotten. The immediate benefit is ability
to trace how the callbacks in the segmented callback list change.

Also this patch remove hacks related to using donecbs's ->len field as a
temporary variable to save the segmented callback list's length. This is not
needed any more.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcu_segcblist.h |   2 +
 kernel/rcu/rcu_segcblist.c    | 137 +++++++++++++++++++++-------------
 kernel/rcu/rcu_segcblist.h    |   4 -
 kernel/rcu/srcutree.c         |   1 -
 kernel/rcu/tree.c             |   2 -
 5 files changed, 88 insertions(+), 58 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index b36afe7b22c9..d462ae5e340a 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -69,8 +69,10 @@ struct rcu_segcblist {
 	unsigned long gp_seq[RCU_CBLIST_NSEGS];
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_t len;
+	atomic_long_t seglen[RCU_CBLIST_NSEGS];
 #else
 	long len;
+	long seglen[RCU_CBLIST_NSEGS];
 #endif
 	u8 enabled;
 	u8 offloaded;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index bb246d8c6ef1..314799426c2d 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -88,6 +88,62 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 #endif
 }
 
+/* Get the length of a segment of the rcu_segcblist structure. */
+static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	return atomic_long_read(&rsclp->seglen[seg]);
+#else
+	return READ_ONCE(rsclp->seglen[seg]);
+#endif
+}
+
+/* Set the length of a segment of the rcu_segcblist structure. */
+static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	atomic_long_set(&rsclp->seglen[seg], v);
+#else
+	WRITE_ONCE(rsclp->seglen[seg], v);
+#endif
+}
+
+/* Return number of callbacks in a segment of the segmented callback list. */
+static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	smp_mb__before_atomic(); /* Up to the caller! */
+	atomic_long_add(v, &rsclp->seglen[seg]);
+	smp_mb__after_atomic(); /* Up to the caller! */
+#else
+	smp_mb(); /* Up to the caller! */
+	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
+	smp_mb(); /* Up to the caller! */
+#endif
+}
+
+/* Move from's segment length to to's segment. */
+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
+{
+	long len;
+
+	if (from == to)
+		return;
+
+	len = rcu_segcblist_get_seglen(rsclp, from);
+	if (!len)
+		return;
+
+	rcu_segcblist_add_seglen(rsclp, to, len);
+	rcu_segcblist_set_seglen(rsclp, from, 0);
+}
+
+/* Increment segment's length. */
+static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+	rcu_segcblist_add_seglen(rsclp, seg, 1);
+}
+
 /*
  * Increase the numeric length of an rcu_segcblist structure by the
  * specified amount, which can be negative.  This can cause the ->len
@@ -119,26 +175,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
 	rcu_segcblist_add_len(rsclp, 1);
 }
 
-/*
- * Exchange the numeric length of the specified rcu_segcblist structure
- * with the specified value.  This can cause the ->len field to disagree
- * with the actual number of callbacks on the structure.  This exchange is
- * fully ordered with respect to the callers accesses both before and after.
- */
-static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
-{
-#ifdef CONFIG_RCU_NOCB_CPU
-	return atomic_long_xchg(&rsclp->len, v);
-#else
-	long ret = rsclp->len;
-
-	smp_mb(); /* Up to the caller! */
-	WRITE_ONCE(rsclp->len, v);
-	smp_mb(); /* Up to the caller! */
-	return ret;
-#endif
-}
-
 /*
  * Initialize an rcu_segcblist structure.
  */
@@ -149,8 +185,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
 	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
 	rsclp->head = NULL;
-	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
 		rsclp->tails[i] = &rsclp->head;
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 	rcu_segcblist_set_len(rsclp, 0);
 	rsclp->enabled = 1;
 }
@@ -245,6 +283,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
+	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
@@ -274,27 +313,13 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] != rsclp->tails[i - 1])
 			break;
+	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
 		WRITE_ONCE(rsclp->tails[i], &rhp->next);
 	return true;
 }
 
-/*
- * Extract only the counts from the specified rcu_segcblist structure,
- * and place them in the specified rcu_cblist structure.  This function
- * supports both callback orphaning and invocation, hence the separation
- * of counts and callbacks.  (Callbacks ready for invocation must be
- * orphaned and adopted separately from pending callbacks, but counts
- * apply to all callbacks.  Locking must be used to make sure that
- * both orphaned-callbacks lists are consistent.)
- */
-void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
-					       struct rcu_cblist *rclp)
-{
-	rclp->len = rcu_segcblist_xchg_len(rsclp, 0);
-}
-
 /*
  * Extract only those callbacks ready to be invoked from the specified
  * rcu_segcblist structure and place them in the specified rcu_cblist
@@ -307,6 +332,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_ready_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
@@ -314,6 +340,8 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
+	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
+	rcu_segcblist_add_len(rsclp, -(rclp->len));
 }
 
 /*
@@ -330,22 +358,17 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
-	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
+	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
-}
-
-/*
- * Insert counts from the specified rcu_cblist structure in the
- * specified rcu_segcblist structure.
- */
-void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
-				struct rcu_cblist *rclp)
-{
-	rcu_segcblist_add_len(rsclp, rclp->len);
-	rclp->len = 0;
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
+	rcu_segcblist_add_len(rsclp, -(rclp->len));
 }
 
 /*
@@ -359,6 +382,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rclp->head)
 		return; /* No callbacks to move. */
+	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, rclp->head);
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
@@ -368,6 +392,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 			break;
 	rclp->head = NULL;
 	rclp->tail = &rclp->head;
+	rcu_segcblist_add_len(rsclp, rclp->len);
 }
 
 /*
@@ -379,8 +404,11 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 {
 	if (!rclp->head)
 		return; /* Nothing to do. */
+
+	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
+	rcu_segcblist_add_len(rsclp, rclp->len);
 }
 
 /*
@@ -403,6 +431,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
 	}
 
 	/* If no callbacks moved, nothing more need be done. */
@@ -423,6 +452,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
 			break;  /* No more callbacks. */
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, j);
 		rsclp->gp_seq[j] = rsclp->gp_seq[i];
 	}
 }
@@ -444,7 +474,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i;
+	int i, j;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -487,6 +517,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
+	/* Accounting: everything below i is about to get merged into i. */
+	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
+		rcu_segcblist_move_seglen(rsclp, j, i);
+
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
 	 * into the segment located by the for-loop above.  Assign "seq"
@@ -516,11 +550,12 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 
 	rcu_cblist_init(&donecbs);
 	rcu_cblist_init(&pendcbs);
-	rcu_segcblist_extract_count(src_rsclp, &donecbs);
+
 	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
-	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
+
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
+
 	rcu_segcblist_init(src_rsclp);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index b90725f81d77..7f4e02bbb806 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -89,14 +89,10 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
-void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
-				 struct rcu_cblist *rclp);
 void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 				    struct rcu_cblist *rclp);
 void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 				    struct rcu_cblist *rclp);
-void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
-				struct rcu_cblist *rclp);
 void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 				   struct rcu_cblist *rclp);
 void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0f23d20d485a..62b83fb997ee 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1196,7 +1196,6 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	 * schedule another round of callback invocation.
 	 */
 	spin_lock_irq_rcu_node(sdp);
-	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 50af465729f4..ab4d4e9ff549 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2516,8 +2516,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-- 
2.28.0.681.g6f77f65b4e-goog

