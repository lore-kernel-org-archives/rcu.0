Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D7FC2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B06A223AB
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wlhc0v0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgKCO0L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbgKCO0J (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:09 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA144C0613D1
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 06:26:09 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id t5so3108664qtp.2
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 06:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tp7te1kzXnT/gq/QH2KRsigxL1orbCz7LAUDCg1KlQE=;
        b=wlhc0v0Czie0BXzaKbxFb4xph/0NpPbomHEFc18lb7knK03FgR7+pAg8J989qt9J7m
         7I1mfniWYzikd6rqLLrQpriHtpNGBRm1NbJPrOR5fKPqILPHFFTM5QWbC+hK7QK/vDX0
         EJG8dtByJZIGcgBYp7Jh+l5qAXuzFvOsSCCQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tp7te1kzXnT/gq/QH2KRsigxL1orbCz7LAUDCg1KlQE=;
        b=kkmhCw+0GvKyQbe5HlS5aQK0eAD8XLGaWs1W4bIetbNYCnYhl1w4oBGlEGU08Z8gEt
         PfEksN6JMVpL7ocXYgTMTbehPO9LiV8Lk8JOYTusAlrr3/+0bIMEHoUZRkGtIK8/6Sfp
         tVQ2qxhIH/nUIrHFX510wEfkmU8I/4KIHzpscSZHw2e2+xY9aaKrwKDlnE7O1xGinY9E
         0r3UG6HGbtwTuiyiS/IQlrAXj7F0gM/VfUNAx8kssBfRMHE6vC3GtE3RINu8c/WYS2Sa
         Ha31XYsJWRfwGqxdC+w27Sw+FjrorETjwLvRibqodgsnqdu4C+Vx6wkRYP8jZyfQd/wg
         mYIw==
X-Gm-Message-State: AOAM532bbYK/8K8e+YKs8F5FWZRKKA/HjabPG8SVjuAtvd3MQLJ4m8hO
        CNVT5e/ZLGzIhf1WK6sTYYycWQ==
X-Google-Smtp-Source: ABdhPJySEoQ5xKP4qxVgSi5X4qBkdR6m7Yp6pjSLPZFJc5ziZC46BmE6Mp6mw0t/YBYOR5ezt+7rxA==
X-Received: by 2002:ac8:57cb:: with SMTP id w11mr14637860qta.161.1604413568962;
        Tue, 03 Nov 2020 06:26:08 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:08 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v9 1/7] rcu/tree: Make rcu_do_batch count how many callbacks were executed
Date:   Tue,  3 Nov 2020 09:25:57 -0500
Message-Id: <20201103142603.1302207-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103142603.1302207-1-joel@joelfernandes.org>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcu_do_batch() depends on the unsegmented callback list's len field
to know how many CBs are executed. This fields counts down from 0 as CBs are
dequeued.  It is possible that all CBs could not be run because of reaching
limits in which case the remaining unexecuted callbacks are requeued in the
CPU's segcblist.

The number of callbacks that were not requeued are then the negative count (how
many CBs were run) stored in the rcl->len which has been counting down on every
dequeue. This negative count is then added to the per-cpu segmented callback
list's to correct its count.

Such a design works against future efforts to track the length of each segment
of the segmented callback list. The reason is because
rcu_segcblist_extract_done_cbs() will be populating the unsegmented callback
list's length field (rcl->len) during extraction.

Also, the design of counting down from 0 is confusing and error-prone IMHO.

This commit therefore explicitly counts how many callbacks were executed in
rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
field, without relying on the negativity of rcl->len.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c |  2 +-
 kernel/rcu/rcu_segcblist.h |  1 +
 kernel/rcu/tree.c          | 11 +++++------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 2d2a6b6b9dfb..bb246d8c6ef1 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 492262bcb591..1d2d61406463 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 }
 
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 286dc0a1b184..24c00020ab83 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2429,7 +2429,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2474,6 +2474,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2487,15 +2488,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
-		 * Note: The rcl structure counts down from zero.
 		 */
-		if (-rcl.len >= bl && !offloaded &&
+		if (count >= bl && !offloaded &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
-			if (likely((-rcl.len & 31) || local_clock() < tlimit))
+			if (likely((count & 31) || local_clock() < tlimit))
 				continue;
 			/* Exceeded the time limit, so leave. */
 			break;
@@ -2512,7 +2512,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2520,7 +2519,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-- 
2.29.1.341.ge80a0c044ae-goog

