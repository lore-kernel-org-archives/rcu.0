Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF8C2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FAD32080D
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TJ1E7uQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgKCO0R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbgKCO0Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:16 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC500C0613D1
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 06:26:15 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 140so14771141qko.2
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pwlmj4S+t9kYvpBmI6FO8yidTh6/5mCBssZ7DgFshcw=;
        b=TJ1E7uQSNXcSGMuratBV9hviR3pgv6AN+eetN3/UkrcDp62+4sE7XMY6HMSVjeG5oo
         ET42mUK0GEZhArCM9KntX5xcsv1D0mSnw2HkrMaDeQIbKEKSzkJZ7AllOZodIw/SnMpV
         8uwwVi8H3+xiWyb1fKTzJhFxtcLyRYwIIUPO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pwlmj4S+t9kYvpBmI6FO8yidTh6/5mCBssZ7DgFshcw=;
        b=JR6kLPwSV9QTRNtxDhYYw0P2/YpYiz6yFXNN/Wm1Qf/HzaN3jtJ5W7Dp+eGp8Hy+11
         Fp0ExcAb17wLwmOXrwN3Cu0LiQgxFxB92bizBwHoDxHLFFX6Zf507OEX//ANkun204oQ
         beyBim9bY8rHbXbdUvSFWHiMVnacVbp1Nxn/M9YcbNYnVxLurstvY3ygriQ0LBFalvyD
         W6UlpItCmz09qZLXSiUcz+pWGSaEb3K1jalAKuNZFK7xnx1s+3NKifE/lznd+GzseZ19
         95tOnGOoeZSIG/9dpCirWJZVTQXGAkA88nKO+ErqPCxzzWCERssXD5C+f3Fxmkh/gtXI
         T45g==
X-Gm-Message-State: AOAM532s5W8RtGtg1Ybv5VN9gZn3eDgq3JT5y0wTMhy75MnNHCnCUV9v
        l5eHuZxCM1s1Or8dOcGMuf7B7Q==
X-Google-Smtp-Source: ABdhPJyyRtLcHUSyoraBwwT3WhoLxP1sA0h0ffWSFOOpCol8pv4a9Pv6TjK7xaN/MedfgD5nav8gpw==
X-Received: by 2002:a37:a606:: with SMTP id p6mr19355711qke.14.1604413575092;
        Tue, 03 Nov 2020 06:26:15 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:14 -0800 (PST)
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
Subject: [PATCH v9 6/7] rcu/tree: segcblist: Remove redundant smp_mb()s
Date:   Tue,  3 Nov 2020 09:26:02 -0500
Message-Id: <20201103142603.1302207-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201103142603.1302207-1-joel@joelfernandes.org>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This memory barrier is not needed as rcu_segcblist_add_len() already
includes a memory barrier *before* and *after* the length of the list is
updated.

Same reasoning for rcu_segcblist_enqueue().

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 kernel/rcu/tree.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index e9e72d72f7a6..d96272e8d604 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -268,7 +268,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
-	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f6c6653b3ec2..fb2a5ac4a59c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.29.1.341.ge80a0c044ae-goog

