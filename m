Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B35C388F7
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F027207BB
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xamyF4mQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgKCO0N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgKCO0M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:12 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CBC0617A6
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 06:26:12 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b18so14735932qkc.9
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 06:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K36lTmcygIVW9GX4CyKRbjzZ9I8J8t7aoDmagNP67Xo=;
        b=xamyF4mQ1HWNRmynLV9Nmwh902AuT4oNHrYm/uYQggun56ZLLojds5LizwcvilZP2U
         OJUI86QvCobbDatJMo22AiPONLvKEkkR3B0ToQD4WroQP+3KgRF5Vq9PSzpvSD3pseYh
         EigdUa0blpBR9wIw8iyZ5BBWmkcDeuhfSmd1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K36lTmcygIVW9GX4CyKRbjzZ9I8J8t7aoDmagNP67Xo=;
        b=SFXmJonxYNH1OWoZbamKRqEyukn/asTTLCJLXhEGXzl2HPIfIZ5uA0e/OLwq+a/9Ox
         fen+wMTTSVSszL4jJxqI9HZ5dtgG0scpeCaniNBhIOYW1YS2RihHdIk5SYz3lmsb/Ehp
         hMhdNCQTbnB3scI5Ly0QIFnwoikJB6FMOKJeHFZine6psyTI8kAy54J5rGwEiL6B4/Th
         6zryx+cLkBZYpD7Y9fLJbHa7TE6tL6ez/HVRf/L2q0t11SYinNmPhDHmyN16yay4Nna/
         IVV4rOaD89YTfRMt/to6r8lka0O6wJB2h1MvWPg2+PFa1Bo4yHsYhgQ6iyKEs3adQni+
         1ioA==
X-Gm-Message-State: AOAM531cMinS0Z+i78mjPjIII6/8+Y0nAEoHTrFfaWZbc/4SihJSPCCD
        I40/fp2iA8HSVMX2yk/uKAWukQ==
X-Google-Smtp-Source: ABdhPJwOhrBBUvwa9ziHirIS7CLjwOg6CTiQdj6jEL5BgZ4EVQpNJurVWc0ps+A45iWg096UfcGKag==
X-Received: by 2002:a05:620a:20d2:: with SMTP id f18mr20404850qka.190.1604413571691;
        Tue, 03 Nov 2020 06:26:11 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:11 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v9 3/7] srcu: Fix invoke_rcu_callbacks() segcb length adjustment
Date:   Tue,  3 Nov 2020 09:25:59 -0500
Message-Id: <20201103142603.1302207-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103142603.1302207-1-joel@joelfernandes.org>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

With earlier patches, the negative counting of the unsegmented list
cannot be used to adjust the segmented one. To fix this, sample the
unsegmented length in advance, and use it after CB execution to adjust
the segmented list's length.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/srcutree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0f23d20d485a..79b7081143a7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1160,6 +1160,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
  */
 static void srcu_invoke_callbacks(struct work_struct *work)
 {
+	long len;
 	bool more;
 	struct rcu_cblist ready_cbs;
 	struct rcu_head *rhp;
@@ -1182,6 +1183,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	/* We are on the job!  Extract and invoke ready callbacks. */
 	sdp->srcu_cblist_invoking = true;
 	rcu_segcblist_extract_done_cbs(&sdp->srcu_cblist, &ready_cbs);
+	len = ready_cbs.len;
 	spin_unlock_irq_rcu_node(sdp);
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
@@ -1190,13 +1192,14 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 		rhp->func(rhp);
 		local_bh_enable();
 	}
+	WARN_ON_ONCE(ready_cbs.len);
 
 	/*
 	 * Update counts, accelerate new callbacks, and if needed,
 	 * schedule another round of callback invocation.
 	 */
 	spin_lock_irq_rcu_node(sdp);
-	rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
+	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
 				       rcu_seq_snap(&ssp->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
-- 
2.29.1.341.ge80a0c044ae-goog

