Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176DCC43466
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D1720888
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 01:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gNBI/VMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIUBWD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Sep 2020 21:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgIUBWB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Sep 2020 21:22:01 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C05EC061755
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o16so13403675qkj.10
        for <rcu@vger.kernel.org>; Sun, 20 Sep 2020 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4dCcj2aIPeMu97ITQjVMX+AXZqRg6ZN64LfwJhTHAs=;
        b=gNBI/VMBq4ECyrD0v65eTyivjMRH5CImLVww0RA4eFmlzxf71wnvwob5fTp+9WoCnL
         Itg9daCoYA5XlcPkthj4gOF+CX9rv4lJqxBR8nJVaeKlyNe1nimGXaJBvOkSp9K15Yft
         PjpkLw/CSInfNc42Ak0R82w/Im2lhBAY/l3rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4dCcj2aIPeMu97ITQjVMX+AXZqRg6ZN64LfwJhTHAs=;
        b=E6FnqoMiOnz5mA9RmGZdZkJ1JL3/KCfWXDOZYiG6CC6L+ZVI82PdxrjPTZ+rOSWaXP
         HC7II5joSFJoehFqfHuBTQtdybaE9BzdXVeSIZlqu/2Oaulq+/kDyda5gTiRre95N/ih
         DKAQ1cehXTxtutKPfl9XCDDG7XeIvjspnYwrqVHN1fUsdgUhLwIXs8JVxxvyI9/sepgW
         Xh/UYz65AQt01+NzB//VLr9kxNQibZS98L2NCFMLUankgF4UvcLgfb3RgSiqr3ZZU95n
         zszGjuaZq92B4J0qOQq2YN3Qeh3UUzDsf5wSWuKSExhgbS4PsA3rv5BRtgW/PIUWqPNM
         Hn9A==
X-Gm-Message-State: AOAM530NZjWH5x6YcYv05VkwKW3+Z0k/5OZUtM9cnnTVvDb89TtFF5Jc
        cmeyNMoAyXMW7m0RFvIfwNv0yg==
X-Google-Smtp-Source: ABdhPJzjDVo0/UACo+l8K4BtooDvpy+Ry4ScqJspc9ZklxPL+wKM25gRzB/P7la8qnVl8KNj7vncAQ==
X-Received: by 2002:a37:912:: with SMTP id 18mr43005490qkj.29.1600651320735;
        Sun, 20 Sep 2020 18:22:00 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l26sm7741951qki.62.2020.09.20.18.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:22:00 -0700 (PDT)
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
Subject: [RFC v5 3/5] rcu: Fix rcu_barrier() breakage from earlier patch
Date:   Sun, 20 Sep 2020 21:21:50 -0400
Message-Id: <20200921012152.2831904-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200921012152.2831904-1-joel@joelfernandes.org>
References: <20200921012152.2831904-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch is split up because I'm not sure about the patch, and also because
it does not fix the issue I am seeing with TREE04. :-(. Though it does fix the
theoretical issue I was considering, with rcu_barrier.

The previous patch breaks rcu_barrier (in theory at least). This is because
rcu_barrier() may skip queuing a callback and return too early. Fix it by storing
state to indicate that callbacks are being invoked and the callback list should
not appear as non-empty. This is a terrible hack, however it still does not fix
TREE04.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcu_segcblist.h |  1 +
 kernel/rcu/rcu_segcblist.h    | 23 +++++++++++++++++++++--
 kernel/rcu/tree.c             |  4 ++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index d462ae5e340a..319a565f6ecb 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -76,6 +76,7 @@ struct rcu_segcblist {
 #endif
 	u8 enabled;
 	u8 offloaded;
+	u8 invoking;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 7f4e02bbb806..78949e125364 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -40,14 +40,33 @@ static inline bool rcu_segcblist_empty(struct rcu_segcblist *rsclp)
 	return !READ_ONCE(rsclp->head);
 }
 
+static inline void rcu_segcblist_set_invoking(struct rcu_segcblist *rsclp)
+{
+	WRITE_ONCE(rsclp->invoking, 1);
+}
+
+static inline void rcu_segcblist_reset_invoking(struct rcu_segcblist *rsclp)
+{
+	WRITE_ONCE(rsclp->invoking, 0);
+}
+
 /* Return number of callbacks in segmented callback list. */
 static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 {
+	long ret;
 #ifdef CONFIG_RCU_NOCB_CPU
-	return atomic_long_read(&rsclp->len);
+	ret = atomic_long_read(&rsclp->len);
 #else
-	return READ_ONCE(rsclp->len);
+	ret = READ_ONCE(rsclp->len);
 #endif
+
+	/*
+	 * An invoking list should not appear empty. This is required
+	 * by rcu_barrier().
+	 */
+	if (ret)
+		return ret;
+	return READ_ONCE(rsclp->invoking) ? 1 : 0;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ab4d4e9ff549..23fb6d7b6d4a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2461,6 +2461,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	}
 	trace_rcu_batch_start(rcu_state.name,
 			      rcu_segcblist_n_cbs(&rdp->cblist), bl);
+	rcu_segcblist_set_invoking(&rdp->cblist);
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
@@ -2517,6 +2518,9 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 
+	smp_mb();
+	rcu_segcblist_reset_invoking(&rdp->cblist);
+
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
 	if (rdp->blimit >= DEFAULT_MAX_RCU_BLIMIT && count <= qlowmark)
-- 
2.28.0.681.g6f77f65b4e-goog

