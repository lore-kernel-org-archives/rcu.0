Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B7C433DF
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 02:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74767204EC
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 02:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fsoRajiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgHYCtE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgHYCs4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Aug 2020 22:48:56 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96208C061796
        for <rcu@vger.kernel.org>; Mon, 24 Aug 2020 19:48:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p25so9757982qkp.2
        for <rcu@vger.kernel.org>; Mon, 24 Aug 2020 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rr2wu86hvyBvF0qDYpQKgu2V3m2RjeVp5RhnLSFtTac=;
        b=fsoRajizjPljsgm6M/MbWqMqC696sWJI9F7blcRie8ChI/LkHG2OMuVlQ2IN63I8RN
         YQVsiH7wHQ5OkWiA12juc9HSqryWRcczlxnkJmasVTcQArh+RUUhO+ioiH37mhRgObbh
         lpjr1AJPjZXAn8qhT5zbB5G4pVeQxFNcd2rAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rr2wu86hvyBvF0qDYpQKgu2V3m2RjeVp5RhnLSFtTac=;
        b=iR/rICLN7ORQOOv0/yY4WLTQSf8iXdSezcvH+EdncK4F33JPa6xS9TB9LB/utmgzQQ
         SyCOERv3lD+zpR5HiqD5IkB4ThCcVJLQOyHEN/ruH+BMwOBNkrijCYzNg0D8kGM/ek1i
         B29uGIfJc4F9mFJU+pw32KM6CGERkBej2r2fk+DvIu9axxcMigWX5WIoaByLpwn3HxpP
         Wd/4c0lJK8K982ktmfmpmdBjuf4FqIeGjcD9KaoM4cU57AnTB3OKBXJ1FB+pPLxuOH6r
         /JSV4bjECoFbTHmOgwo9XqOT9V6queNhpQW7/TfFHPpwN6zYDAX1otVLnd1upckKJHSb
         4Cjw==
X-Gm-Message-State: AOAM531nFHw4JRz/wut8Qg0DbrYaEmxFkI5g5B1KJDsGNF/4/VfFr6Xf
        hetaR7DtFLXVfLOS5fIYp98mwQ==
X-Google-Smtp-Source: ABdhPJxAdm+O9SlFrjOmVisv5gQ8PXG15WctozW0BSZ2pM1/XomNp0wSwAyBGPFNBWi38oVInqiwsQ==
X-Received: by 2002:a37:b88:: with SMTP id 130mr7652261qkl.222.1598323733772;
        Mon, 24 Aug 2020 19:48:53 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n14sm2159188qtk.50.2020.08.24.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:48:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        boqun.feng@gmail.com, dave@stgolabs.net,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: [PATCH v4 -rcu 4/4] rcu/trace: Add tracing for how segcb list changes
Date:   Mon, 24 Aug 2020 22:48:42 -0400
Message-Id: <20200825024842.3408659-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200825024842.3408659-1-joel@joelfernandes.org>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Track how the segcb list changes before/after acceleration, during
queuing and during dequeuing.

This has proved useful to discover an optimization to avoid unwanted GP
requests when there are no callbacks accelerated. The overhead is minimal as
each segment's length is now stored in the respective segment.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/trace/events/rcu.h | 25 +++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.c | 27 +++++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.h |  7 +++++++
 kernel/rcu/tree.c          | 23 +++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb43cfd..7b84df3c95df 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -505,6 +505,31 @@ TRACE_EVENT_RCU(rcu_callback,
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
  * kvfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 73a103464ea4..6419dbbaecde 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -378,6 +378,33 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
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
+	struct rcu_head **cur_tail;
+	int i;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+		cbcount[i] = 0;
+
+	cur_tail = &(rsclp->head);
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
+		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
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
index b90725f81d77..5f7cdfed0ba4 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -105,3 +105,10 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
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
index 51348144a4ea..16ad99a9ebba 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1476,6 +1476,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	unsigned long gp_seq_req;
 	bool ret = false;
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
 
 	rcu_lockdep_assert_cblist_protected(rdp);
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -1484,6 +1486,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	/* Count CBs for tracing. */
+	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
+	trace_rcu_segcb("SegCbPreAcc", cbs, gps);
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1504,6 +1510,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	/* Count CBs for tracing. */
+	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
+	trace_rcu_segcb("SegCbPostAcc", cbs, gps);
+
 	return ret;
 }
 
@@ -2421,6 +2431,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
 	long pending, tlimit = 0;
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
 
 	/* If no callbacks are ready, just return. */
 	if (!rcu_segcblist_ready_cbs(&rdp->cblist)) {
@@ -2461,6 +2473,11 @@ static void rcu_do_batch(struct rcu_data *rdp)
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
 
@@ -2929,6 +2946,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct rcu_data *rdp;
 	bool was_alldone;
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2974,6 +2993,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
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
2.28.0.297.g1956fa8f8d-goog

