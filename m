Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A147CC433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6960022D01
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbhAFB1A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAFB07 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:26:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD30A22D01;
        Wed,  6 Jan 2021 01:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896378;
        bh=jN9NdEnuR9c2ErjPZ57T2P7JYMhtHrOC4839Om1h31g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTbkiyOtJdppMZntpKFR0Ob0wiPpRt3IIGW7kvYt5MLfpOJEnEJG9pMaqwuVZ83e+
         PGA1bPh2t9XFot+tDrlMCfTLvKV2S3X7TlkRJ2HKnY1tpsBYYYxuHS6XUa5IVnxocY
         EKMFYbf1vhszsvd1YZFerbOQsI+lUHpzIbIuug46mGVxiQW9ofwN2CtPiUHRAfnrJZ
         dCwZ7LpEpnD2PdBqahl7xlu1BtGr2V7nE3GHIUpWTpjJrEGT2SDC5MSMZ8D5K2g2x1
         rYjGKdWMeRg+OcZlcLqqHeVsj6YwnTx+hwiBwVnbxkuq4AjqmYdwhR/rBZBTIV8uA2
         aOAz84UJiJ1lg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/6] rcu/tree: Make rcu_do_batch count how many callbacks were executed
Date:   Tue,  5 Jan 2021 17:26:12 -0800
Message-Id: <20210106012617.14122-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106012541.GA13972@paulmck-ThinkPad-P72>
References: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rcu_do_batch() function extracts the ready-to-invoke callbacks
from the rcu_segcblist located in the ->cblist field of the current
CPU's rcu_data structure.  These callbacks are first moved to a local
(unsegmented) rcu_cblist.  The rcu_do_batch() function then uses this
rcu_cblist's ->len field to count how many CBs it has invoked, but it
does so by counting that field down from zero.  Finally, this function
negates the value in this ->len field (resulting in a positive number)
and subtracts the result from the ->len field of the current CPU's
->cblist field.

Except that it is sometimes necessary for rcu_do_batch() to stop invoking
callbacks mid-stream, despite there being more ready to invoke, for
example, if a high-priority task wakes up.  In this case the remaining
not-yet-invoked callbacks are requeued back onto the CPU's ->cblist,
but remain in the ready-to-invoke segment of that list.  As above, the
negative of the local rcu_cblist's ->len field is still subtracted from
the ->len field of the current CPU's ->cblist field.

The design of counting down from 0 is confusing and error-prone, plus
use of a positive count will make it easier to provide a uniform and
consistent API to deal with the per-segment counts that are added
later in this series.  For example, rcu_segcblist_extract_done_cbs()
can unconditionally populate the resulting unsegmented list's ->len
field during extraction.

This commit therefore explicitly counts how many callbacks were executed
in rcu_do_batch() itself, counting up from zero, and then uses that
to update the per-CPU segcb list's ->len field, without relying on the
downcounting of rcl->len from zero.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c |  2 +-
 kernel/rcu/rcu_segcblist.h |  1 +
 kernel/rcu/tree.c          | 11 +++++------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 2d2a6b6b9..bb246d8 100644
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
index 492262b..1d2d614 100644
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
index 40e5e3d..cc6f379 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2434,7 +2434,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2479,6 +2479,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2492,15 +2493,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
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
@@ -2517,7 +2517,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2525,7 +2524,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
-- 
2.9.5

