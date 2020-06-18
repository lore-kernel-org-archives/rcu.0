Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74787C433E1
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABFA207DD
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ltOWHmgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgFRUaL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbgFRUaH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102EC0613EF
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q2so6957572qkb.2
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJ6iVkq04FxNtyOXJkAufZ2LVSoK80HP6aYhYz31ppg=;
        b=ltOWHmgE67kpom8qEcg4f2cgclspP7Nd8j9PIGZWy7hVj93lwe56HBaZUqxjS1Kehq
         Nf9pQKYM81R8cYd35yAMsXLYQSn++jBpn8s+2NZsw8Sz8H4c2t/OCzzhrJVBK9jly6Gz
         fQ6Lr3VN5W+/vSWi44B8R+TqCVxyNZAmvlkjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sJ6iVkq04FxNtyOXJkAufZ2LVSoK80HP6aYhYz31ppg=;
        b=uK/n9sc/6diHb8PlagI2PsHXODKzYsrgKsRvu7s0c8Ok4fJKErbYFQuO7UipE0v8R2
         jJW/1ZLXjLBc8GO3kVvS0oX3RdcOnvC9HUd0y/xJynSdrIReVUEH+DUyv4ffmpxI8ZoN
         Vc6Sn3L4Sc1iY3l/KOcVIH5gqrwRC+gIhIDh9Yob3rFzfdisGEGUOmAsZysfp6HFkC6i
         CIdzMn9xWNxnqlR8HbW/ijjK6PRbrQLDS5TH8vV/tWjNi+lXUykWLvs3iVGl3wBGsr+B
         oP1F20gx7c6EbsLf99CHOdurWejDds4M2Hg9b9MafXCpoe5creU2XEbRBVtK96nieKHV
         ChLg==
X-Gm-Message-State: AOAM533OBx17U7rJIu+9UXFip80dlQVVvmD90j+vHi7VTCuPDasITZDy
        Hwi7qydZVqR2McOHTXY4hLmDIw==
X-Google-Smtp-Source: ABdhPJw+It7eBFRi3g8+yZD7LrVpqIaKl/CHqZkV1p8uazkGqrUdFh1QUe/xriIfkbGX8fMBBiiwFA==
X-Received: by 2002:a37:4147:: with SMTP id o68mr187414qka.491.1592512205659;
        Thu, 18 Jun 2020 13:30:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 2/7] rcu/trace: Add tracing for how segcb list changes
Date:   Thu, 18 Jun 2020 16:29:50 -0400
Message-Id: <20200618202955.4024-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Track how the segcb list changes before/after acceleration, during
queuing and during dequeuing.

This has proved useful to discover an optimization to avoid unwanted GP
requests when there are no callbacks accelerated.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.c | 37 +++++++++++++++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.h |  7 +++++++
 kernel/rcu/tree.c          | 24 ++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 02dcd119f3263..a6d49864dcc27 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -507,6 +507,31 @@ TRACE_EVENT_RCU(rcu_callback,
 		  __entry->qlen)
 );
 
+TRACE_EVENT_RCU(rcu_segcb,
+
+		TP_PROTO(const char *ctx, int *cb_count, unsigned long *gp_seq),
+
+		TP_ARGS(ctx, cb_count, gp_seq),
+
+		TP_STRUCT__entry(
+			__field(const char *, ctx)
+			__array(int, cb_count, 4)
+			__array(unsigned long, gp_seq, 4)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->cb_count, cb_count, 4 * sizeof(int));
+			memcpy(__entry->gp_seq, gp_seq, 4 * sizeof(unsigned long));
+		),
+
+		TP_printk("%s cb_count: (DONE=%d, WAIT=%d, NEXT_READY=%d, NEXT=%d) "
+			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  __entry->cb_count[0], __entry->cb_count[1], __entry->cb_count[2], __entry->cb_count[3],
+			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
+
+);
+
 /*
  * Tracepoint for the registration of a single RCU callback of the special
  * kfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 4782cf17bf4f9..036d4abac7c5a 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -316,6 +316,43 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
 }
 
+/*
+ * Return how many CBs each segment along with their gp_seq values.
+ *
+ * This function is O(N) where N is the number of callbacks. Only used from
+ * tracing code which is usually disabled in production.
+ */
+#ifdef CONFIG_RCU_TRACE
+void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
+			 int cbcount[RCU_CBLIST_NSEGS],
+			 unsigned long gpseq[RCU_CBLIST_NSEGS])
+{
+	struct rcu_head **cur_tail, *h;
+	int i, c;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+		cbcount[i] = 0;
+
+	cur_tail = &(rsclp->head);
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
+		c = 0;
+		// List empty?
+		if (rsclp->tails[i] != cur_tail) {
+			// The loop skips the last node
+			c = 1;
+			for (h = *cur_tail; h->next != *(rsclp->tails[i]); h = h->next) {
+				c++;
+			}
+		}
+
+		cbcount[i] = c;
+		gpseq[i] = rsclp->gp_seq[i];
+		cur_tail = rsclp->tails[i];
+	}
+}
+#endif
+
 /*
  * Extract only those callbacks still pending (not yet ready to be
  * invoked) from the specified rcu_segcblist structure and place them in
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293afc07b8e..0a8dbac438529 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -104,3 +104,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+#ifdef CONFIG_RCU_TRACE
+void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
+			 int cbcount[RCU_CBLIST_NSEGS],
+			 unsigned long gpseq[RCU_CBLIST_NSEGS]);
+#else
+#define rcu_segcblist_countseq(...)
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ebce14e470d0e..c61af6a33fbfd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1407,6 +1407,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	unsigned long gp_seq_req;
 	bool ret = false;
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
 
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -1415,6 +1417,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	/* Count CBs for tracing. */
+	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
+	trace_rcu_segcb("SegCbPreAcc", cbs, gps);
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1434,6 +1440,11 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
 	else
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
+
+	/* Count CBs for tracing. */
+	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
+	trace_rcu_segcb("SegCbPostAcc", cbs, gps);
+
 	return ret;
 }
 
@@ -2316,6 +2327,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
 	long pending, tlimit = 0;
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
@@ -2350,6 +2363,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
+	/* Count CBs for tracing. */
+	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
+	trace_rcu_segcb("SegCbDequeued", cbs, gps);
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2808,6 +2826,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct rcu_data *rdp;
 	bool was_alldone;
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2852,6 +2872,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	/* Count CBs for tracing. */
+	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
+	trace_rcu_segcb("SegCBQueued", cbs, gps);
+
 	/* Go handle any RCU core processing required. */
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
-- 
2.27.0.111.gc72c7da667-goog

