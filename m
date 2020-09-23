Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F97AC2D0A8
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F8721D7D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tK1EqB2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgIWPWR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWPWQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9AC0613CE
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2020 08:22:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so23112099qkn.11
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2020 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5j4t27+l0WYqDu/xeamzQpCWOqmDCckcWi8FrgNWBc=;
        b=tK1EqB2bR9LJRqoXs5CmpOMPYB+VH1hMorNjp4Hkhq5DnyCC8II3Av9uv7KnEA/1sI
         WOqujnhJL7302ks4RCDOH9YQpzb7rZBjudaKR3aysv11x+I0EtH7to0vXzolYGWnNuSk
         pUI3bWoQXntwKnQB2SoSVnzf0k8nNDTad0q34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5j4t27+l0WYqDu/xeamzQpCWOqmDCckcWi8FrgNWBc=;
        b=Phd6SodkZ3dDZzqQ4+PvmjaHdlZr8fHbs4w8bxkdUigVSN1r8uP4raplZJKB26OsDA
         mHqdHljSYjwxb23gSM7hFgpQ5GGg4Fb21K5O/AredmZtsJPfYIB3B4iQz8fstaWofLXI
         vJtQFTxm02yOsUTO0RPO7BivPqSX16/ak8zwZi2pec9TuqksnZx38gpQ9JQRHybD2Rjw
         EKHEvaDZA0zSVEtALNLcelifmfVii+Y5PPVeLjpPOpa3nIa90fxEZG3tLWsqZwRplKz8
         Y8hg24xxzJK8RlG/geAgrQ2SGSQUNLOfPxuJ8bIhsrdxLsvk44zc9QKbMldjQZNm1Efn
         hunA==
X-Gm-Message-State: AOAM531g2CnUwf7IGUB3DqeQO2SzIy5chNwcOHU0MEdH5CCH+qF6HTiT
        i/UFVESUGczSi3c9rHB4pslpQw==
X-Google-Smtp-Source: ABdhPJwjVz4hlIIUQqDlMsdkGwdJMIaFsGbu1Hk3HidQzRFK5WMQrlfqCSKtaaNV0Gu3cejRvbnmPw==
X-Received: by 2002:a37:96c7:: with SMTP id y190mr378126qkd.152.1600874535684;
        Wed, 23 Sep 2020 08:22:15 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:15 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v6 1/4] rcu/tree: Make rcu_do_batch count how many callbacks were executed
Date:   Wed, 23 Sep 2020 11:22:08 -0400
Message-Id: <20200923152211.2403352-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923152211.2403352-1-joel@joelfernandes.org>
References: <20200923152211.2403352-1-joel@joelfernandes.org>
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

This commit therefore explicitly counts have many callbacks were executed in
rcu_do_batch() itself, and uses that to update the per-CPU segcb list's ->len
field, without relying on the negativity of rcl->len.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 kernel/rcu/rcu_segcblist.h | 1 +
 kernel/rcu/tree.c          | 9 ++++-----
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index 5c293afc07b8..b90725f81d77 100644
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
index 7623128d0020..50af465729f4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2427,7 +2427,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2472,6 +2472,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2485,9 +2486,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
-		 * Note: The rcl structure counts down from zero.
 		 */
-		if (-rcl.len >= bl && !offloaded &&
+		if (count >= bl && !offloaded &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
@@ -2510,7 +2510,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2518,7 +2517,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-- 
2.28.0.681.g6f77f65b4e-goog

