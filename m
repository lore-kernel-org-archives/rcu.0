Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EFEC4741F
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43C021775
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335884;
	bh=SInaPT4V0cCi4iLCtFw0IFvBG+iebCOdpu+qQisIIsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UXfUlvW+Cx2FE1uGGVGSG+nJjkfgU3Sr3siHth8+onVReC9N8YP3y/0b0GO7CTDqd
	 J9ukM3M2WMA1c7+oyzaj8tpTXkAD9cI3yjFYvicigaHFKLZ4AJw91sNQTKszV6RoYM
	 PFnuf192T6oWEF4iRmQqSs529RC+jWjos+j4zzz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgI1XbX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbgI1XbI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56A6A21D46;
        Mon, 28 Sep 2020 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335867;
        bh=SInaPT4V0cCi4iLCtFw0IFvBG+iebCOdpu+qQisIIsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHI8grI4gysohQAj4KTnWsNlkOU8lXeKl/iLFjKMqnpRRL5s853+qUHUHNjwAjIBi
         phZCgHgyqp/q2gZHx/hWd+nEJYpt0P7wfbyny+dAafCUdfnF+MGwBPhzMQle0SHAAM
         EMD4Undzt8rtvD32QS21yxPFCoctZQqik/i4nU+Q=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller is preemptible
Date:   Mon, 28 Sep 2020 16:31:01 -0700
Message-Id: <20200928233102.24265-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The current memory-allocation interface poses the following challenges:

a)	In kernels built with CONFIG_PROVE_RAW_LOCK_NESTING, lockdep
	complains ("BUG: Invalid wait context").  This complaint is due
	to the memory allocator acquiring non-raw spinlocks while a raw
	spinlocks is held.  This problem can also arise if kvfree_rcu()
	is invoked while holding a raw spinlock.

b)	In -rt kernels built with CONFIG_PREEMPT_RT, the situation
	described in (a) above results in an attempt to acquire a
	sleeplock while holding a spinlock, which is of course forbidden.
	This can lead to "BUG: scheduling while atomic".

c)	Please note that call_rcu() is invoked from raw atomic context,
	so that kfree_rcu() and kvfree_rcu() are therefore also expected
	to be callable from atomic raw context as well.

However given that CONFIG_PREEMPT_COUNT is unconditionally enabled
by the earlier commits in this series, the preemptible() macro now
properly detects preempt-disable code regions even in kernels built
with CONFIG_PREEMPT_NONE.

This commit therefore uses preemptible() to determine whether allocation
is possible at all for double-argument kvfree_rcu().  If !preemptible(),
then allocation is not possible, and kvfree_rcu() falls back to using
the less cache-friendly rcu_head approach.  Even when preemptible(),
the caller might be involved in reclaim, so the GFP_ flags used by
double-argument kvfree_rcu() must avoid invoking reclaim processing.

Note that single-argument kvfree_rcu() must be invoked in sleepable
contexts, and that its fallback is the relatively high latency
synchronize_rcu().  Single-argument kvfree_rcu() therefore uses
GFP_KERNEL|__GFP_RETRY_MAYFAIL to allow limited sleeping within the
memory allocator.

Link: https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/
Fixes: 3042f83f19be ("rcu: Support reclaim for head-less object")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 70 ++++++++++++++++---------------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9..cc998d7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3166,7 +3166,7 @@ static void kfree_rcu_work(struct work_struct *work)
 			krc_this_cpu_unlock(krcp, flags);
 
 			if (bkvhead[i])
-				free_page((unsigned long) bkvhead[i]);
+				kfree(bkvhead[i]);
 
 			cond_resched_tasks_rcu_qs();
 		}
@@ -3291,43 +3291,28 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }
 
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_sleep)
 {
 	struct kvfree_rcu_bulk_data *bnode;
+	bool can_alloc_page = preemptible();
+	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
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
-		if (!bnode) {
-			/*
-			 * To keep this path working on raw non-preemptible
-			 * sections, prevent the optional entry into the
-			 * allocator as it uses sleeping locks. In fact, even
-			 * if the caller of kfree_rcu() is preemptible, this
-			 * path still is not, as krcp->lock is a raw spinlock.
-			 * With additional page pre-allocation in the works,
-			 * hitting this return is going to be much less likely.
-			 */
-			if (IS_ENABLED(CONFIG_PREEMPT_RT))
-				return false;
-
-			/*
-			 * NOTE: For one argument of kvfree_rcu() we can
-			 * drop the lock and get the page in sleepable
-			 * context. That would allow to maintain an array
-			 * for the CONFIG_PREEMPT_RT as well if no cached
-			 * pages are available.
-			 */
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+	if (!(*krcp)->bkvhead[idx] ||
+			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc_page) {
+			krc_this_cpu_unlock(*krcp, *flags);
+			bnode = kmalloc(PAGE_SIZE, gfp);
+			*krcp = krc_this_cpu_lock(flags);
 		}
 
 		/* Switch to emergency path. */
@@ -3336,15 +3321,15 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 
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
@@ -3382,24 +3367,20 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
-
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
 
-		// Mark as success and leave.
-		success = true;
-		goto unlock_return;
+		return;
 	}
 
 	/*
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
 	if (!success) {
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
@@ -4394,23 +4375,12 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
-		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-
-			if (bnode)
-				put_cached_bnode(krcp, bnode);
-			else
-				pr_err("Failed to preallocate for %d CPU!\n", cpu);
-		}
-
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
-- 
2.9.5

