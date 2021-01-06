Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3526EC4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130A122D01
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbhAFB1F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbhAFB1D (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:27:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAF5422EBD;
        Wed,  6 Jan 2021 01:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896379;
        bh=cJOj+l42qVsxBC/Fb21yEyqB5JhGYqpAyF0TScZRQ0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwrA87W43zc44rNT5mPvZ3qkhTmpJU/mFIoSVOoPV1k6zR8btHR3zMJLuCgWh68tp
         5+VeJjuNPAIPK7mN6eCEpzHsA/A3cFlVx1hFncXUfn1fUrQAtvJj1dg1x31GLpD5Xz
         U7cqBKp3qu98yjQq1U+4714/OXRPd3pjEqsTPA/c9S3LsOE2uPq3MEyTnf6EahymIs
         /Gpk0GVkQIJJ6nmYBF4ieONoUBeuI++Drw/z36TrlTdXNUc9jxSj85w4BVVCbO2ECT
         AEpt5Lncma53j4gecpzm6sXWlGH1pOrqriDle/dRn1l/R0kK+qJ6vqEO7eBmbo9YhP
         hChRYLwPN5Ruw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/6] rcu/segcblist: Add debug checks for segment lengths
Date:   Tue,  5 Jan 2021 17:26:17 -0800
Message-Id: <20210106012617.14122-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106012541.GA13972@paulmck-ThinkPad-P72>
References: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit adds debug checks near the end of rcu_do_batch() that emit
warnings if an empty rcu_segcblist structure has non-zero segment counts,
or, conversely, if a non-empty structure has all-zero segment counts.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Fix queue/segment-length checks. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  3 +++
 kernel/rcu/tree.c          |  8 ++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5059b61..094de25 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
 	return READ_ONCE(rsclp->seglen[seg]);
 }
 
+/* Return number of callbacks in segmented callback list by summing seglen. */
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
index cd35c9f..18e101d 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+/* Return number of callbacks in segmented callback list by summing seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
+
 void rcu_cblist_init(struct rcu_cblist *rclp);
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bf269c..8086c04 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2434,6 +2434,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
+	bool __maybe_unused empty;
 	unsigned long flags;
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
@@ -2548,9 +2549,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * The following usually indicates a double call_rcu().  To track
 	 * this down, try building with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
 	 */
-	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
+	empty = rcu_segcblist_empty(&rdp->cblist);
+	WARN_ON_ONCE(count == 0 && !empty);
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
+		     count != 0 && empty);
+	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
+	WARN_ON_ONCE(!empty && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-- 
2.9.5

