Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E8BC433DF
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D9322257
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YSrLZ7oY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgJOBk1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389071AbgJOBjh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6335CC0F26D8
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so2050766ioh.7
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m26A9thbL3zyXa9u7AGFGUvSWoHujSDDgY8oUG+AnDI=;
        b=YSrLZ7oYJWrCA/Vj2oQHH0S5VNYiMhveMVsraj/cvaCPZ8Dub2d2csdPCJklAGFu2f
         V/BMNSBZlYRc8JxYUdYSJWpYXKEbSGfcu1A77M006GTBgVmWi/84zkn3Xv5aCN/oZ08E
         1T5CQyc2KzGY9qeas4QT90ANC4qwiIwjK7IY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m26A9thbL3zyXa9u7AGFGUvSWoHujSDDgY8oUG+AnDI=;
        b=sV5svuAwW9tkLtI5YCCPOoDAB4TNgo5qUsfrltvbi0vKsQwZMvbdnfyyJPHGfg77LQ
         F7v7m3ai/jPJgqhFTB2Tz4XTdiVABxeSRArwpqbiu8FNUiWL4hLLXTgR7l9MbSSOexW1
         TR4opLUndyosg29PM7mH66/3oHkmWKSZqbz6U4gyXwp09rGB6qQSSJy2KtKQfKzlePYh
         pSXge7Fs51QX63dRAwi0J9QI+v6vVbKMtLXwJnOcXFpTsXvH8gTldYvSYTlFZRjUl/i6
         Sb+K/+G4EH2cL2AI28Y0z5wdgQET1rEBX+d6JAgsiS4IBLUgLDPuqEGEnD03iKAF9UUR
         r84w==
X-Gm-Message-State: AOAM532gd7jnCcVJt+uOor/kQWPNBWyEQ8CmEB07x3kYNPCwQknKZeq4
        LQ/1+JLjIkbydynPHT8Uk6cpLw==
X-Google-Smtp-Source: ABdhPJwzU6SPK6jPAz8XX93BFAC1CDaDI+Di0ltXJpf1AgHmSbrQOy1FAMbacvIXDiGQQSxN5gcBAQ==
X-Received: by 2002:a5d:9d15:: with SMTP id j21mr1400650ioj.100.1602721388656;
        Wed, 14 Oct 2020 17:23:08 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 2/6] rcu/segcblist: Add counters to segcblist datastructure
Date:   Wed, 14 Oct 2020 20:22:57 -0400
Message-Id: <20201015002301.101830-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201015002301.101830-1-joel@joelfernandes.org>
References: <20201015002301.101830-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add counting of segment lengths of segmented callback list.

This will be useful for a number of things such as knowing how big the
ready-to-execute segment have gotten. The immediate benefit is ability
to trace how the callbacks in the segmented callback list change.

Also this patch remove hacks related to using donecbs's ->len field as a
temporary variable to save the segmented callback list's length. This cannot be
done anymore and is not needed.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcu_segcblist.h |   2 +
 kernel/rcu/rcu_segcblist.c    | 133 +++++++++++++++++++++++-----------
 kernel/rcu/rcu_segcblist.h    |   2 -
 3 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index b36afe7b22c9..d462ae5e340a 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -69,8 +69,10 @@ struct rcu_segcblist {
 	unsigned long gp_seq[RCU_CBLIST_NSEGS];
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_t len;
+	atomic_long_t seglen[RCU_CBLIST_NSEGS];
 #else
 	long len;
+	long seglen[RCU_CBLIST_NSEGS];
 #endif
 	u8 enabled;
 	u8 offloaded;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index bb246d8c6ef1..d9fab49dee1b 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -7,10 +7,11 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/rcupdate.h>
+#include <linux/types.h>
 
 #include "rcu_segcblist.h"
 
@@ -88,6 +89,58 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 #endif
 }
 
+/* Get the length of a segment of the rcu_segcblist structure. */
+static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	return atomic_long_read(&rsclp->seglen[seg]);
+#else
+	return READ_ONCE(rsclp->seglen[seg]);
+#endif
+}
+
+/* Set the length of a segment of the rcu_segcblist structure. */
+static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	atomic_long_set(&rsclp->seglen[seg], v);
+#else
+	WRITE_ONCE(rsclp->seglen[seg], v);
+#endif
+}
+
+/* Return number of callbacks in a segment of the segmented callback list. */
+static void rcu_segcblist_add_seglen(struct rcu_segcblist *rsclp, int seg, long v)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	atomic_long_add(v, &rsclp->seglen[seg]);
+#else
+	WRITE_ONCE(rsclp->seglen[seg], rsclp->seglen[seg] + v);
+#endif
+}
+
+/* Move from's segment length to to's segment. */
+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
+{
+	long len;
+
+	if (from == to)
+		return;
+
+	len = rcu_segcblist_get_seglen(rsclp, from);
+	if (!len)
+		return;
+
+	rcu_segcblist_add_seglen(rsclp, to, len);
+	rcu_segcblist_set_seglen(rsclp, from, 0);
+}
+
+/* Increment segment's length. */
+static void rcu_segcblist_inc_seglen(struct rcu_segcblist *rsclp, int seg)
+{
+	rcu_segcblist_add_seglen(rsclp, seg, 1);
+}
+
 /*
  * Increase the numeric length of an rcu_segcblist structure by the
  * specified amount, which can be negative.  This can cause the ->len
@@ -119,26 +172,6 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
 	rcu_segcblist_add_len(rsclp, 1);
 }
 
-/*
- * Exchange the numeric length of the specified rcu_segcblist structure
- * with the specified value.  This can cause the ->len field to disagree
- * with the actual number of callbacks on the structure.  This exchange is
- * fully ordered with respect to the callers accesses both before and after.
- */
-static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
-{
-#ifdef CONFIG_RCU_NOCB_CPU
-	return atomic_long_xchg(&rsclp->len, v);
-#else
-	long ret = rsclp->len;
-
-	smp_mb(); /* Up to the caller! */
-	WRITE_ONCE(rsclp->len, v);
-	smp_mb(); /* Up to the caller! */
-	return ret;
-#endif
-}
-
 /*
  * Initialize an rcu_segcblist structure.
  */
@@ -149,8 +182,10 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 	BUILD_BUG_ON(RCU_NEXT_TAIL + 1 != ARRAY_SIZE(rsclp->gp_seq));
 	BUILD_BUG_ON(ARRAY_SIZE(rsclp->tails) != ARRAY_SIZE(rsclp->gp_seq));
 	rsclp->head = NULL;
-	for (i = 0; i < RCU_CBLIST_NSEGS; i++)
+	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
 		rsclp->tails[i] = &rsclp->head;
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 	rcu_segcblist_set_len(rsclp, 0);
 	rsclp->enabled = 1;
 }
@@ -245,7 +280,7 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp)
 {
 	rcu_segcblist_inc_len(rsclp);
-	smp_mb(); /* Ensure counts are updated before callback is enqueued. */
+	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
 	rhp->next = NULL;
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
@@ -274,27 +309,13 @@ bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 	for (i = RCU_NEXT_TAIL; i > RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] != rsclp->tails[i - 1])
 			break;
+	rcu_segcblist_inc_seglen(rsclp, i);
 	WRITE_ONCE(*rsclp->tails[i], rhp);
 	for (; i <= RCU_NEXT_TAIL; i++)
 		WRITE_ONCE(rsclp->tails[i], &rhp->next);
 	return true;
 }
 
-/*
- * Extract only the counts from the specified rcu_segcblist structure,
- * and place them in the specified rcu_cblist structure.  This function
- * supports both callback orphaning and invocation, hence the separation
- * of counts and callbacks.  (Callbacks ready for invocation must be
- * orphaned and adopted separately from pending callbacks, but counts
- * apply to all callbacks.  Locking must be used to make sure that
- * both orphaned-callbacks lists are consistent.)
- */
-void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
-					       struct rcu_cblist *rclp)
-{
-	rclp->len = rcu_segcblist_xchg_len(rsclp, 0);
-}
-
 /*
  * Extract only those callbacks ready to be invoked from the specified
  * rcu_segcblist structure and place them in the specified rcu_cblist
@@ -307,6 +328,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_ready_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, *rsclp->tails[RCU_DONE_TAIL]);
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
@@ -314,6 +336,7 @@ void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 	for (i = RCU_CBLIST_NSEGS - 1; i >= RCU_DONE_TAIL; i--)
 		if (rsclp->tails[i] == rsclp->tails[RCU_DONE_TAIL])
 			WRITE_ONCE(rsclp->tails[i], &rsclp->head);
+	rcu_segcblist_set_seglen(rsclp, RCU_DONE_TAIL, 0);
 }
 
 /*
@@ -330,11 +353,16 @@ void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rcu_segcblist_pend_cbs(rsclp))
 		return; /* Nothing to do. */
+	rclp->len = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL) +
+		    rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
 	*rclp->tail = *rsclp->tails[RCU_DONE_TAIL];
 	rclp->tail = rsclp->tails[RCU_NEXT_TAIL];
 	WRITE_ONCE(*rsclp->tails[RCU_DONE_TAIL], NULL);
-	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++)
+	for (i = RCU_DONE_TAIL + 1; i < RCU_CBLIST_NSEGS; i++) {
 		WRITE_ONCE(rsclp->tails[i], rsclp->tails[RCU_DONE_TAIL]);
+		rcu_segcblist_set_seglen(rsclp, i, 0);
+	}
 }
 
 /*
@@ -345,7 +373,6 @@ void rcu_segcblist_insert_count(struct rcu_segcblist *rsclp,
 				struct rcu_cblist *rclp)
 {
 	rcu_segcblist_add_len(rsclp, rclp->len);
-	rclp->len = 0;
 }
 
 /*
@@ -359,6 +386,7 @@ void rcu_segcblist_insert_done_cbs(struct rcu_segcblist *rsclp,
 
 	if (!rclp->head)
 		return; /* No callbacks to move. */
+	rcu_segcblist_add_seglen(rsclp, RCU_DONE_TAIL, rclp->len);
 	*rclp->tail = rsclp->head;
 	WRITE_ONCE(rsclp->head, rclp->head);
 	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
@@ -379,6 +407,8 @@ void rcu_segcblist_insert_pend_cbs(struct rcu_segcblist *rsclp,
 {
 	if (!rclp->head)
 		return; /* Nothing to do. */
+
+	rcu_segcblist_add_seglen(rsclp, RCU_NEXT_TAIL, rclp->len);
 	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rclp->head);
 	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], rclp->tail);
 }
@@ -403,6 +433,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (ULONG_CMP_LT(seq, rsclp->gp_seq[i]))
 			break;
 		WRITE_ONCE(rsclp->tails[RCU_DONE_TAIL], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, RCU_DONE_TAIL);
 	}
 
 	/* If no callbacks moved, nothing more need be done. */
@@ -423,6 +454,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 		if (rsclp->tails[j] == rsclp->tails[RCU_NEXT_TAIL])
 			break;  /* No more callbacks. */
 		WRITE_ONCE(rsclp->tails[j], rsclp->tails[i]);
+		rcu_segcblist_move_seglen(rsclp, i, j);
 		rsclp->gp_seq[j] = rsclp->gp_seq[i];
 	}
 }
@@ -444,7 +476,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
  */
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
-	int i;
+	int i, j;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -487,6 +519,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
+	/* Accounting: everything below i is about to get merged into i. */
+	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
+		rcu_segcblist_move_seglen(rsclp, j, i);
+
 	/*
 	 * Merge all later callbacks, including newly arrived callbacks,
 	 * into the segment located by the for-loop above.  Assign "seq"
@@ -514,13 +550,24 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 	struct rcu_cblist donecbs;
 	struct rcu_cblist pendcbs;
 
+	lockdep_assert_cpus_held();
+
 	rcu_cblist_init(&donecbs);
 	rcu_cblist_init(&pendcbs);
-	rcu_segcblist_extract_count(src_rsclp, &donecbs);
+
 	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
+
+	/*
+	 * No need smp_mb() before setting to length to 0, because CPU hotplug
+	 * lock excludes rcu_barrier.
+	 */
+	rcu_segcblist_set_len(src_rsclp, 0);
+
 	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
+	rcu_segcblist_insert_count(dst_rsclp, &pendcbs);
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
+
 	rcu_segcblist_init(src_rsclp);
 }
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 1d2d61406463..cd35c9faaf51 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -89,8 +89,6 @@ void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
-void rcu_segcblist_extract_count(struct rcu_segcblist *rsclp,
-				 struct rcu_cblist *rclp);
 void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
 				    struct rcu_cblist *rclp);
 void rcu_segcblist_extract_pend_cbs(struct rcu_segcblist *rsclp,
-- 
2.28.0.1011.ga647a8990f-goog

