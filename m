Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC09C433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C134F64EC4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbhCDBAv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388755AbhCDAMQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25AC264E6F;
        Thu,  4 Mar 2021 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816696;
        bh=ZcCtvpL2+87veXgydfPnerIt/zxxJvt9vQWwY7tw3i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PtOy9IUauvFqkEDTwafJoE8PTPyl2NWPQr5tVCD5qPx3wHLKl0ih+8RTHl5deCXgA
         g2xUAQcaOqBDV9etow8KIKjGK/h8awKdq4LByPFoGpOtbpLwYaEkBLL5c4tFCkVZLc
         +dYM78ZgNpSdxrj8VfYygDElSIOPFUjui4Vq79vaXrSCUoG4uP51uyZRuV3gTd4y/e
         wf4ONdUa+xpjouG122NXjLps4jcAWpdZKM56hp/a9C2WV93tCKuSlYHzxtpqvAzSeP
         uSkjlVkPFWj51oxE5tOHPbs3el5IRSYhXoyN39Oi/2Bn6nlIp8dmDfvhN6JYa05f/D
         xQa1G7rLo+Ztw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/6] kvfree_rcu: Directly allocate page for single-argument case
Date:   Wed,  3 Mar 2021 16:11:29 -0800
Message-Id: <20210304001134.22977-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001044.GA22871@paulmck-ThinkPad-P72>
References: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Single-argument kvfree_rcu() must be invoked from sleepable contexts,
so we can directly allocate pages.  Furthermmore, the fallback in case
of page-allocation failure is the high-latency synchronize_rcu(), so it
makes sense to do these page allocations from the fastpath, and even to
permit limited sleeping within the allocator.

This commit therefore allocates if needed on the fastpath using
GFP_KERNEL|__GFP_RETRY_MAYFAIL.  This also has the beneficial effect
of leaving kvfree_rcu()'s per-CPU caches to the double-argument variant
of kvfree_rcu(), given that the double-argument variant cannot directly
invoke the allocator.

[ paulmck: Add add_ptr_to_bulk_krc_lock header comment per Michal Hocko. ]
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..1f8c980 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3493,37 +3493,50 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	}
 }
 
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_alloc is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// Returns true if ptr was successfully recorded, else the caller must
+// use a fallback.
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_alloc)
 {
 	struct kvfree_rcu_bulk_data *bnode;
 	int idx;
 
-	if (unlikely(!krcp->initialized))
+	*krcp = krc_this_cpu_lock(flags);
+	if (unlikely(!(*krcp)->initialized))
 		return false;
 
-	lockdep_assert_held(&krcp->lock);
 	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bkvhead[idx] ||
-			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
-		bnode = get_cached_bnode(krcp);
-		/* Switch to emergency path. */
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+			*krcp = krc_this_cpu_lock(flags);
+		}
+
 		if (!bnode)
 			return false;
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bkvhead[idx];
+		bnode->next = (*krcp)->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bkvhead[idx] = bnode;
+		(*krcp)->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bkvhead[idx]->records
-		[krcp->bkvhead[idx]->nr_records++] = ptr;
+	(*krcp)->bkvhead[idx]->records
+		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
@@ -3561,8 +3574,6 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
@@ -3570,12 +3581,11 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 
 		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	kasan_record_aux_stack(ptr);
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		run_page_cache_worker(krcp);
 
-- 
2.9.5

