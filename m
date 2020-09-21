Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A112C43463
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA0520888
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dAI9eFch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIUBWI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Sep 2020 21:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgIUBWD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Sep 2020 21:22:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2627C061755
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w16so13432010qkj.7
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mf+7JZ/mg/EikmfDrCLNr7s+VRR1YOwhEGeUtqMwDoA=;
        b=dAI9eFchpbd2gCfaYWOGjs6JKRsLvxSaLWl9UaZ3G/qBkLT4MISz1aZNDeM+NF1ZqI
         yQ77W6VhUI9ArysqOwV3uAt/eB2YIIec+g2fK+sjKaF7BKTlnFD0zpKsLpvWgcG0uSKg
         t91rDZVu39lAtwsdiRfLlk6OX7sdgNCp7bwEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mf+7JZ/mg/EikmfDrCLNr7s+VRR1YOwhEGeUtqMwDoA=;
        b=MMyLhrEk+azezrOkOKlbzGfqi2u0bWU9QzfwTkxYawwDy7caRG1RKb/aYBS/bujR+H
         sBih/oJM6IVJu+LSldjVYTyxKBrhMoCaN9Y4VeUcGzuSG3v4XGgWw+L4KuNIZ1p0s7LV
         SeTOrYF9StYFHIEYlh5hcF0g6DOojuoXqlhJW6bJb/BCPtg3nFeumkM8yOmjPhjFrDJ1
         0uH+LbfnwYrvR+O0UitHHAz8hxxyliSMuKqYong46LJL47OZYiFAYehCdl2Bp9Ng9q/H
         e51rt7gASwbixOxMHkQOFNomJV5+p20njG4nhPrLZrnGA+ie7EkHwd55xCPYqSN5P0de
         pWiA==
X-Gm-Message-State: AOAM532/PukPaIhc5/7PpQsCJbEDbrSUDotWylBJgX/AX4xgUl0QXRuq
        u+yYh0HfWkd1FSH45xQP90Ptgw==
X-Google-Smtp-Source: ABdhPJw23fxPBIaqAvwjJto+Fd1JswlYs5Xip9kzTMnfXjrp0y6fA/Wb8YFCwgqrcVkWoEzA8SSEZg==
X-Received: by 2002:a37:b406:: with SMTP id d6mr1481334qkf.485.1600651321944;
        Sun, 20 Sep 2020 18:22:01 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l26sm7741951qki.62.2020.09.20.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:22:01 -0700 (PDT)
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
Subject: [RFC v5 4/5] rcu/trace: Add tracing for how segcb list changes
Date:   Sun, 20 Sep 2020 21:21:51 -0400
Message-Id: <20200921012152.2831904-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921012152.2831904-1-joel@joelfernandes.org>
References: <20200921012152.2831904-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 kernel/rcu/rcu_segcblist.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/rcu_segcblist.h |  5 +++++
 kernel/rcu/tree.c          |  9 +++++++++
 4 files changed, 73 insertions(+)

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
index 314799426c2d..72b284f965aa 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -13,6 +13,7 @@
 #include <linux/rcupdate.h>
 
 #include "rcu_segcblist.h"
+#include "rcu.h"
 
 /* Initialize simple callback list. */
 void rcu_cblist_init(struct rcu_cblist *rclp)
@@ -344,6 +345,39 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	rcu_segcblist_add_len(rsclp, -(rclp->len));
 }
 
+/*
+ * Return how many CBs each segment along with their gp_seq values.
+ *
+ * This function is O(N) where N is the number of callbacks. Only used from
+ * tracing code which is usually disabled in production.
+ */
+#ifdef CONFIG_RCU_TRACE
+static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
+			 int cbcount[RCU_CBLIST_NSEGS],
+			 unsigned long gpseq[RCU_CBLIST_NSEGS])
+{
+	int i;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+		cbcount[i] = 0;
+
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
+		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
+		gpseq[i] = rsclp->gp_seq[i];
+	}
+}
+
+void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context)
+{
+	int cbs[RCU_CBLIST_NSEGS];
+	unsigned long gps[RCU_CBLIST_NSEGS];
+
+	rcu_segcblist_countseq(rsclp, cbs, gps);
+
+	trace_rcu_segcb(context, cbs, gps);
+}
+#endif
+
 /*
  * Extract only those callbacks still pending (not yet ready to be
  * invoked) from the specified rcu_segcblist structure and place them in
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 78949e125364..ca2a403591e4 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -120,3 +120,8 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq);
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq);
 void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 			 struct rcu_segcblist *src_rsclp);
+#ifdef CONFIG_RCU_TRACE
+void trace_rcu_segcb_list(struct rcu_segcblist *rsclp, char *context);
+#else
+#define trace_rcu_segcb_list(...)
+#endif
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 23fb6d7b6d4a..3afb0e4daca6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1492,6 +1492,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	trace_rcu_segcb_list(&rdp->cblist, "SegCbPreAcc");
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1512,6 +1514,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	trace_rcu_segcb_list(&rdp->cblist, "SegCbPostAcc");
+
 	return ret;
 }
 
@@ -2470,6 +2474,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
+	trace_rcu_segcb_list(&rdp->cblist, "SegCbDequeued");
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2984,6 +2991,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	trace_rcu_segcb_list(&rdp->cblist, "SegCBQueued");
+
 	/* Go handle any RCU core processing required. */
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
-- 
2.28.0.681.g6f77f65b4e-goog

