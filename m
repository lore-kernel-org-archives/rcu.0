Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2987CC433E1
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 03:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40D32076A
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 03:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gh6Ak5mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGSDmV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jul 2020 23:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGSDmV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jul 2020 23:42:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D2C0619D2
        for <rcu@vger.kernel.org>; Sat, 18 Jul 2020 20:42:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q2so1499760qkc.8
        for <rcu@vger.kernel.org>; Sat, 18 Jul 2020 20:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fY9o1t8e8sG+JO7jEG+2eTqOGSQI+xJHynD2kEHDWCw=;
        b=gh6Ak5mDuEglr56h5ylgIon14jSInTer3CxXVkSMSNRKZ14Epu+ntUJf2INM7ogyDF
         1xMO7aXBBDO9DJqGYmoWKpFlyPhG2K0m4Bv50OlXpGLL0rE/HZ8nTpPTbD9a0mteBzj8
         FoxDLUC2IK+Pq1LoF5XSPOd6MpI/wxYNC1IwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fY9o1t8e8sG+JO7jEG+2eTqOGSQI+xJHynD2kEHDWCw=;
        b=MPxRrx4C36Iea9iMq51LbPPxUhWov4z8yI05ChNPBg8K+ACuD4YoviST7m1ayqv/j7
         K6364wXi9aHZ0dL8ApICGfl2BwPtiQPaNDNjCzbL7PaqCin/Az2TBhpyoXeQVHq6yMBj
         5+eTrRqV7CbFPYfA7uqK3fO+doKs6TdMckIhFM5WfIbputoJygwJ4EKsBlde8mnNRc9C
         StutgihUbubBDFURMJvuXFd0HcVaMfLYhLBKg0ewlBIywlG/CNqCpCk8bNgMM7jiGEDC
         GPBgAmQYu8xyIaLtd4a5TA39i/lsueG34vMPOqk9G2M7Tib///YUbnDjhzX6b6JrSwXM
         Tlkw==
X-Gm-Message-State: AOAM530eXyzbnpqsW16E4n8oEkEQre+5+04PYVzxt62jBMp6CvSkLd5D
        FMEUPMNPmmCAyb/QyxEHYAEkjA==
X-Google-Smtp-Source: ABdhPJyx7jDtrgjWcFzFlbvM7mzEXGf5sucOy8BduR0/xI3KGjiQGkbYhC9dovQGSAIVUbXRE3Yq4A==
X-Received: by 2002:a05:620a:79a:: with SMTP id 26mr16279539qka.169.1595130139716;
        Sat, 18 Jul 2020 20:42:19 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id a203sm1261550qkg.30.2020.07.18.20.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 20:42:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH RFC] rcu/segcblist: Add counters to segcblist datastructure
Date:   Sat, 18 Jul 2020 23:42:10 -0400
Message-Id: <20200719034210.2382053-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Joel Fernandes <joelaf@google.com>

Add counting of segment lengths of segmented callback list.

This will be useful for a number of things such as knowing how big the
ready-to-execute segment have gotten. The immediate benefit is ability
to trace how the callbacks in the segmented callback list change.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 include/linux/rcu_segcblist.h |  2 +
 kernel/rcu/rcu_segcblist.c    | 96 +++++++++++++++++++++++++++++++----
 2 files changed, 89 insertions(+), 9 deletions(-)

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
index 9a0f66133b4b..8d4ade6523b8 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -79,15 +79,66 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 }
 
 /* Set the length of an rcu_segcblist structure. */
-static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
+void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
-	atomic_long_set(&rsclp->len, v);
+       atomic_long_set(&rsclp->len, v);
 #else
-	WRITE_ONCE(rsclp->len, v);
+       WRITE_ONCE(rsclp->len, v);
+#endif
+}
+
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
 #endif
 }
 
+/* Move from's segment length to to's segment. */
+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
+{
+	long len = rcu_segcblist_get_seglen(rsclp, from);
+
+	if (!len || from == to)
+		return;
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
@@ -149,8 +200,11 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
 	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
 	rsclp->head = NULL;
-	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
 		rsclp->tails[i] = &rsclp->head;
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
+
 	rcu_segcblist_set_len(rsclp, 0);
 	rsclp->enabled = 1;
 }
@@ -245,6 +299,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
+	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
@@ -274,6 +329,7 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] != rsclp->tails[i - 1])
 			break;
+	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
 		WRITE_ONCE(rsclp->tails[i], &rhp->next);
@@ -307,6 +363,9 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_ready_cbs(rsclp))
 		return; /* Nothing to do. */
+
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
+
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
@@ -314,6 +373,8 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
+
+	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
 /*
@@ -330,11 +391,19 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return; /* Nothing to do. */
+
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
+
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
+
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
-	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
+	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 }
 
 /*
@@ -359,8 +428,11 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rclp->head)
 		return; /* No callbacks to move. */
+
+	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, rclp->head);
+
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
 		if (&rsclp->head == rsclp->tails[i])
 			WRITE_ONCE(rsclp->tails[i], rclp->tail);
@@ -379,6 +451,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 {
 	if (!rclp->head)
 		return; /* Nothing to do. */
+
+	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
 }
@@ -403,6 +477,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
 	}
 
 	/* If no callbacks moved, nothing more need be done. */
@@ -419,10 +494,9 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * callbacks.  The overall effect is to copy down the later pointers
 	 * into the gap that was created by the now-ready segments.
 	 */
-	for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++, j++) {
-		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
-			break;  /* No more callbacks. */
+	for (j = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL && j < RCU_NEXT_TAIL; i++, j++) {
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, j);
 		rsclp->gp_seq[j] = rsclp->gp_seq[i];
 	}
 }
@@ -444,7 +518,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i;
+	int i, j;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -479,6 +553,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (++i >= RCU_NEXT_TAIL)
 		return false;
 
+	/* Accounting: everything below i is about to get merged into i. */
+	for (j = i; j <= RCU_NEXT_TAIL; j++)
+		rcu_segcblist_move_seglen(rsclp, j, i);
+
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
 	 * into the segment located by the for-loop above.  Assign "seq"
-- 
2.28.0.rc0.105.gf9edc3c819-goog

