Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4098C5519F
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 16:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F09247E0
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 16:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SE9bSGsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgKRQPu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Nov 2020 11:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQPu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Nov 2020 11:15:50 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B9C0613D4
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2020 08:15:48 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so1964483qtb.10
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2020 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJE6rXIzbWSElRW1phJDk97yNh0I3oGRFmJIDcQescw=;
        b=SE9bSGsY7rY7vZ/YERAqp5Aap2XbtOGXi5TykZmuL6lnXFT1tP0Hiy08Y6aKkcx3eU
         09nQLfYB9+JCKnQho7Dq7ZUKlVbBCqXx+8li0Ih4MCsdYi9sB8w909NPOxoQd/8X5mFh
         P5lRTk8JRM+XhkAuWwPLHRv6yWJsn0Y1omjVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IJE6rXIzbWSElRW1phJDk97yNh0I3oGRFmJIDcQescw=;
        b=fOT2tzrNTZNEjsJO30pwndby3nkru85omzh4+VV4RkWy0n6ngpF/ZWqbo3Ob0OgQXW
         8nbb5XUHYelzxJpE6XUCc1wQC4VtVCMe9m5Uqr1hPWHBSAzwzmgoTj/KsQ67Vvsn+I8n
         zqKNDPGoWJVGeXDG91Bf2F62SvNyxeq8WVw0YH4TqEnxpxdf9ybiR+bx30ILpz4MV710
         A27HbXD6KQJUbcKAnQdKWCtyra3o6FMW0rQCj8FZ7xY3tOfXq4SN5ciYfO144epi8yTd
         HgvAzblpSaO3X2JRGKLZRUP2WRhrTlUR73x6XfeFx9igktoO2novYGB/IfRlkMbXHY+M
         HdPw==
X-Gm-Message-State: AOAM532Ejs5qaUMK8GtDODf5II1h0VGCLjI6L5gK8jA8xRhB6PBXACf3
        zejFTHng5SewkgYS97pA9+FOlg==
X-Google-Smtp-Source: ABdhPJxt4kX6XjIEzA4VfTUA005xth8CjWWyICEF6/zG8klopHRXmTIBquPttrtC6/50FW9tKOVccw==
X-Received: by 2002:ac8:6f1c:: with SMTP id g28mr5386731qtv.65.1605716147933;
        Wed, 18 Nov 2020 08:15:47 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r62sm17089383qkd.80.2020.11.18.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:15:47 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2] rcu/segcblist: Add debug checks for segment lengths
Date:   Wed, 18 Nov 2020 11:15:41 -0500
Message-Id: <20201118161541.3844924-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

After rcu_do_batch(), add a check for whether the seglen counts went to
zero if the list was indeed empty.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Added more debug checks.

 kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  3 +++
 kernel/rcu/tree.c          |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5059b6102afe..6e98bb3804f0 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
 	return READ_ONCE(rsclp->seglen[seg]);
 }
 
+/* Return number of callbacks in segmented callback list by totalling seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp)
+{
+	long len = 0;
+	int i;
+
+	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
+		len += rcu_segcblist_get_seglen(rsclp, i);
+
+	return len;
+}
+
 /* Set the length of a segment of the rcu_segcblist structure. */
 static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
 {
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9faaf51..46a42d77f7e1 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+/* Return number of callbacks in segmented callback list by totalling seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
+
 void rcu_cblist_init(struct rcu_cblist *rclp);
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f5b61e10f1de..91e35b521e51 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2553,6 +2553,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
+	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
+	WARN_ON_ONCE(count != 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-- 
2.29.2.299.gdc1121823c-goog
