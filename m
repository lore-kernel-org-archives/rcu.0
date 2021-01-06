Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BE0C433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1422022CB9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbhAFB1S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbhAFB1A (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:27:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0E2230FB;
        Wed,  6 Jan 2021 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896379;
        bh=BZakVGmmFZs3Nsx5FTiFBS7dxQEqfjcF87UEFxArC8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPEnMbj1Cw31ti0w9ebdZpiQlulG+5FhUVoDYqmXx0qsEusw8LyIQtgspSJjR1yS4
         8fjqRJoBVIG5gMvOeWECR+v+r44KvScvFqu8VKJ+5ZZQ1kKcen/INmVbVPHenWStY0
         N9fyLOsHxh1CAX1x3X16mXmwJH9+yDV3L9pbcMpbq+5t28GM9qKQXeGN/7n7s1ju9p
         46hTIiJZChb83kP+lZnzEv8ohDSh6L2ouWxchU1dD/JG4qSGdkutEksOZxrpwWalpZ
         rh7FBJBVK2BDnkXFVwFBcdS59Fz0OdV8kQ86s64I+gXbuiVeq/pRfbRvh/MjUvDX4o
         QK5mGIFt6gI1A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/6] rcu/tree: segcblist: Remove redundant smp_mb()s
Date:   Tue,  5 Jan 2021 17:26:15 -0800
Message-Id: <20210106012617.14122-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106012541.GA13972@paulmck-ThinkPad-P72>
References: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The full memory barriers in rcu_segcblist_enqueue() and in rcu_do_batch()
are not needed because rcu_segcblist_add_len(), and thus also
rcu_segcblist_inc_len(), already includes a memory barrier *before*
and *after* the length of the list is updated.

This commit therefore removes these redundant smp_mb() invocations.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 1 -
 kernel/rcu/tree.c          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 0504fc83..5059b61 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -327,7 +327,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
-	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
 	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cc6f379..b0fb654 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2523,7 +2523,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
-	smp_mb(); /* List handling before counting for rcu_barrier(). */
 	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
-- 
2.9.5

