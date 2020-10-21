Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14DDC56202
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 19:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B84722470
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 19:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oTw1OO/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504712AbgJUTIZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504707AbgJUTIZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:25 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C68C0613CE
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 12:08:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so3615961qkg.8
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWsvRyJdoZJ0Iy1nK3H0MirMsg0OsjhNU+4oMtapmg0=;
        b=oTw1OO/k8vgJDEDOkV5+3d2CKbqAjj7IZjyjmIFElx01DzNVEi7vDGMNILtBAhXEJU
         xK1Rw7VPHJ1puAILprlaUxD82NoAyDZjZ/5Wl54CP+2zqUg+thaNxBmvj+pNQlrF4s2o
         jo96VDOA7Vc7fWfL7rKFDHYtwVjTbgYladtyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWsvRyJdoZJ0Iy1nK3H0MirMsg0OsjhNU+4oMtapmg0=;
        b=P9gag8cN01vCTivU874U/4feHYhJHdhL8h7AXwgmOeQI80x15cqYXmfvEhQ20GM+Ko
         Ybp8qgOLv+YTkB4xM8TTjueaCypR7tGwA04mqZzOtANWqFkdysCYmKuSILwrn+IsIeBM
         hW2DZTwqDcMjpsdAi4PHrIfmdnemN0NuOzRWkGfhJ+CbnKsLSTvHEeGmQtoGMpD4AYhm
         ZM1/y7Qp4qZqawJUWLG7bmXQvDXXSgb1l9VIsM59m+Fw5fhOwybKpan2g618RlEMu76T
         bovkLCJfv/bN/ow6TmT+g0GV535PuyxKt6aeB5gWevheSGxNE4EZhy2Ep+o9mtC6RO32
         NHjw==
X-Gm-Message-State: AOAM533AqSs4zZ2EOy5NIEnE2c5bdI/MaH3J7SInb8hsjl6n3ZtJnjTl
        rQWJJ6IYGaAjUK/NxwNTWER4UQ==
X-Google-Smtp-Source: ABdhPJzA7fPGYm67jSd0Tqe3Q80R+TJGQah4KbjoThENfRfvp/gvqn+bCji4bwG0LM4mOdbogQIfwQ==
X-Received: by 2002:a37:7e41:: with SMTP id z62mr4519090qkc.495.1603307304271;
        Wed, 21 Oct 2020 12:08:24 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:23 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v8 5/6] rcu/tree: segcblist: Remove redundant smp_mb()s
Date:   Wed, 21 Oct 2020 15:08:12 -0400
Message-Id: <20201021190813.3005054-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021190813.3005054-1-joel@joelfernandes.org>
References: <20201021190813.3005054-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This memory barrier is not needed as rcu_segcblist_add_len() already
includes a memory barrier *before* the length of the list is updated.

Same reasoning for rcu_segcblist_enqueue().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 kernel/rcu/tree.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 19ff82b805fb..f0fcdf9d0f7f 100644
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
index 346a05506935..6c6d3c7036e6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2525,7 +2525,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.29.0.rc1.297.gfa9743e501-goog

