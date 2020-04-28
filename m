Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62112C83000
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D0C206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNThmBlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD1U7q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgD1U7p (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794A3C03C1AC;
        Tue, 28 Apr 2020 13:59:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f11so262741ljp.1;
        Tue, 28 Apr 2020 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7MAhKyzz3e/Fs+xMmtreUpZYUfkP//qliijuNNwt88=;
        b=gNThmBlgvLEzpTWBz/Tdzm5eAZCPB+MOs15tK50M58/qOBM52ODhszfoSq263IU3LT
         Ehgz57/3S2aIuF4Od5GJ4jtPkq7d1mltUSg1irz55gTBrk642USk/FSe2bHNVza5RYIk
         5DrBJTG/1Lr4FA0cgEtfKvws1xajGL8GGtmrkHB8Lcnn3oikYKb8EqbUCZxeQ2urkXXV
         /KKrb0Nthxf2ertDsOBSpi+yibfYXOJrboiN3xus/oaau/rlrdLOBcTrtEqakkNQiQpv
         svLYJQoNUarBkkiHOsN5ElAfWEJ3uAiGrteOZSP2HWRnFJpHAVXg7kh7yFKZlB+kYIvN
         opSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7MAhKyzz3e/Fs+xMmtreUpZYUfkP//qliijuNNwt88=;
        b=cin3L1hSH4KDvfrSYJ730foKk8mge7m33VKQPJO6/CIdkgm+OUKbwRDkelN/dnALa3
         5mRb2ep+0X+2mN6b7p85YVNaFXoWN7YAJprPSHYLh91aJ47jHhwa42jPSsguGK7wyv0t
         TdksNHAawsMF3L4UyjHoyqboTqtdhv5Oeuspap8VaxjHkxo/QFkFsjOVqpILyOC3n17t
         uaQUsMhAv3+bHghMUBVAX5nCaW3/IUD2P0aiez3iKTNJHzR3gnx+WhcBhjEoL/MkrICN
         cvqqbxpDqBoKvJUcikl5ZUujCpoEHMmXTOMoBwyFWmrst9HydWSORFQzjcK233Hglaq0
         uFcA==
X-Gm-Message-State: AGi0PuYPUn/ZBvvjxzCeH7LaxCzfj0DCMJ4g0iuWOJeZu7UCqqbWBpWP
        sbGx5XYO4JDw+1b8WwQrNq7Gp5VEQWrEQg==
X-Google-Smtp-Source: APiQypKy5Gc8UNnfKygMNixPeCTeypgmTqWb7IbpYgGy5qBBM4NMrym+NReeOhx65Lv2MWtL6RpzeA==
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr20378110lfe.96.1588107582020;
        Tue, 28 Apr 2020 13:59:42 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:41 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 11/24] rcu/tree: Maintain separate array for vmalloc ptrs
Date:   Tue, 28 Apr 2020 22:58:50 +0200
Message-Id: <20200428205903.61704-12-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To do so we use an array of common kvfree_rcu_bulk_data
structure. It consists of two elements, index number 0
corresponds to SLAB ptrs., whereas vmalloc pointers can
be accessed by using index number 1.

The reason of not mixing pointers is to have an easy way
to to distinguish them.

It is also the preparation patch for head-less objects
support. When an object is head-less we can not queue
it into any list, instead a pointer is placed directly
into an array.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 172 +++++++++++++++++++++++++++++-----------------
 1 file changed, 109 insertions(+), 63 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d8975819b1c9..7983926af95b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -57,6 +57,7 @@
 #include <linux/slab.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/clock.h>
+#include <linux/mm.h>
 #include "../time/tick-internal.h"
 
 #include "tree.h"
@@ -2857,44 +2858,44 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_N_BATCHES 2
 
 /**
- * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
+ * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
  * @nr_records: Number of active pointers in the array
- * @records: Array of the kfree_rcu() pointers
  * @next: Next bulk object in the block chain
+ * @records: Array of the kvfree_rcu() pointers
  */
-struct kfree_rcu_bulk_data {
+struct kvfree_rcu_bulk_data {
 	unsigned long nr_records;
-	struct kfree_rcu_bulk_data *next;
+	struct kvfree_rcu_bulk_data *next;
 	void *records[];
 };
 
 /*
  * This macro defines how many entries the "records" array
  * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
+ * kvfree_rcu_bulk_data structure becomes exactly one page.
  */
-#define KFREE_BULK_MAX_ENTR \
-	((PAGE_SIZE - sizeof(struct kfree_rcu_bulk_data)) / sizeof(void *))
+#define KVFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
 
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
- * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
+ * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
-	struct kfree_rcu_bulk_data *bhead_free;
+	struct kvfree_rcu_bulk_data *bkvhead_free[2];
 	struct kfree_rcu_cpu *krcp;
 };
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
- * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
+ * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2908,7 +2909,7 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
-	struct kfree_rcu_bulk_data *bhead;
+	struct kvfree_rcu_bulk_data *bkvhead[2];
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2932,7 +2933,7 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
 };
 
 static __always_inline void
-debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
+debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	int i;
@@ -2961,20 +2962,20 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 	local_irq_restore(flags);
 }
 
-static inline struct kfree_rcu_bulk_data *
+static inline struct kvfree_rcu_bulk_data *
 get_cached_bnode(struct kfree_rcu_cpu *krcp)
 {
 	if (!krcp->nr_bkv_objs)
 		return NULL;
 
 	krcp->nr_bkv_objs--;
-	return (struct kfree_rcu_bulk_data *)
+	return (struct kvfree_rcu_bulk_data *)
 		llist_del_first(&krcp->bkvcache);
 }
 
 static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
-	struct kfree_rcu_bulk_data *bnode)
+	struct kvfree_rcu_bulk_data *bnode)
 {
 	/* Check the limit. */
 	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
@@ -2993,41 +2994,73 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
+	struct kvfree_rcu_bulk_data *bkhead, *bvhead, *bnext;
 	struct rcu_head *head, *next;
-	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	int i;
 
 	krwp = container_of(to_rcu_work(work),
 			    struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
+	/* Channel 1. */
+	bkhead = krwp->bkvhead_free[0];
+	krwp->bkvhead_free[0] = NULL;
+
+	/* Channel 2. */
+	bvhead = krwp->bkvhead_free[1];
+	krwp->bkvhead_free[1] = NULL;
+
+	/* Channel 3. */
 	head = krwp->head_free;
 	krwp->head_free = NULL;
-	bhead = krwp->bhead_free;
-	krwp->bhead_free = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	/* "bhead" is now private, so traverse locklessly. */
-	for (; bhead; bhead = bnext) {
-		bnext = bhead->next;
-
-		debug_rcu_bhead_unqueue(bhead);
+	/* kmalloc()/kfree() channel. */
+	for (; bkhead; bkhead = bnext) {
+		bnext = bkhead->next;
+		debug_rcu_bhead_unqueue(bkhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
-			bhead->nr_records, bhead->records);
+			bkhead->nr_records, bkhead->records);
+
+		kfree_bulk(bkhead->nr_records, bkhead->records);
+		rcu_lock_release(&rcu_callback_map);
+
+		krcp = krc_this_cpu_lock(&flags);
+		if (put_cached_bnode(krcp, bkhead))
+			bkhead = NULL;
+		krc_this_cpu_unlock(krcp, flags);
+
+		if (bkhead)
+			free_page((unsigned long) bkhead);
+
+		cond_resched_tasks_rcu_qs();
+	}
+
+	/* vmalloc()/vfree() channel. */
+	for (; bvhead; bvhead = bnext) {
+		bnext = bvhead->next;
+		debug_rcu_bhead_unqueue(bvhead);
 
-		kfree_bulk(bhead->nr_records, bhead->records);
+		rcu_lock_acquire(&rcu_callback_map);
+		for (i = 0; i < bvhead->nr_records; i++) {
+			trace_rcu_invoke_kfree_callback(rcu_state.name,
+				(struct rcu_head *) bvhead->records[i], 0);
+			vfree(bvhead->records[i]);
+		}
 		rcu_lock_release(&rcu_callback_map);
 
 		krcp = krc_this_cpu_lock(&flags);
-		if (put_cached_bnode(krcp, bhead))
-			bhead = NULL;
+		if (put_cached_bnode(krcp, bvhead))
+			bvhead = NULL;
 		krc_this_cpu_unlock(krcp, flags);
 
-		if (bhead)
-			free_page((unsigned long) bhead);
+		if (bvhead)
+			free_page((unsigned long) bvhead);
 
 		cond_resched_tasks_rcu_qs();
 	}
@@ -3047,7 +3080,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree(ptr);
+			kvfree(ptr);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -3072,21 +3105,34 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 		krwp = &(krcp->krw_arr[i]);
 
 		/*
-		 * Try to detach bhead or head and attach it over any
+		 * Try to detach bkvhead or head and attach it over any
 		 * available corresponding free channel. It can be that
 		 * a previous RCU batch is in progress, it means that
 		 * immediately to queue another one is not possible so
 		 * return false to tell caller to retry.
 		 */
-		if ((krcp->bhead && !krwp->bhead_free) ||
+		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
+			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
-			/* Channel 1. */
-			if (!krwp->bhead_free) {
-				krwp->bhead_free = krcp->bhead;
-				krcp->bhead = NULL;
+			/*
+			 * Channel 1 corresponds to SLAB ptrs.
+			 */
+			if (!krwp->bkvhead_free[0]) {
+				krwp->bkvhead_free[0] = krcp->bkvhead[0];
+				krcp->bkvhead[0] = NULL;
 			}
 
-			/* Channel 2. */
+			/*
+			 * Channel 2 corresponds to vmalloc ptrs.
+			 */
+			if (!krwp->bkvhead_free[1]) {
+				krwp->bkvhead_free[1] = krcp->bkvhead[1];
+				krcp->bkvhead[1] = NULL;
+			}
+
+			/*
+			 * Channel 3 corresponds to emergency path.
+			 */
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
@@ -3095,16 +3141,17 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			WRITE_ONCE(krcp->count, 0);
 
 			/*
-			 * One work is per one batch, so there are two "free channels",
-			 * "bhead_free" and "head_free" the batch can handle. It can be
-			 * that the work is in the pending state when two channels have
-			 * been detached following each other, one by one.
+			 * One work is per one batch, so there are three
+			 * "free channels", the batch can handle. It can
+			 * be that the work is in the pending state when
+			 * channels have been detached following by each
+			 * other.
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 
 		/* Repeat if any "free" corresponding channel is still busy. */
-		if (krcp->bhead || krcp->head)
+		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
 			repeat = true;
 	}
 
@@ -3146,23 +3193,22 @@ static void kfree_rcu_monitor(struct work_struct *work)
 }
 
 static inline bool
-kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
-	struct rcu_head *head, rcu_callback_t func)
+kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 {
-	struct kfree_rcu_bulk_data *bnode;
+	struct kvfree_rcu_bulk_data *bnode;
+	int idx;
 
 	if (unlikely(!krcp->initialized))
 		return false;
 
 	lockdep_assert_held(&krcp->lock);
+	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
-	if (!krcp->bhead ||
-			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
+	if (!krcp->bkvhead[idx] ||
+			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(krcp);
 		if (!bnode) {
-			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
-
 			/*
 			 * To keep this path working on raw non-preemptible
 			 * sections, prevent the optional entry into the
@@ -3175,7 +3221,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
-			bnode = (struct kfree_rcu_bulk_data *)
+			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
 
@@ -3185,30 +3231,30 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 
 		/* Initialize the new block. */
 		bnode->nr_records = 0;
-		bnode->next = krcp->bhead;
+		bnode->next = krcp->bkvhead[idx];
 
 		/* Attach it to the head. */
-		krcp->bhead = bnode;
+		krcp->bkvhead[idx] = bnode;
 	}
 
 	/* Finally insert. */
-	krcp->bhead->records[krcp->bhead->nr_records++] =
-		(void *) head - (unsigned long) func;
+	krcp->bkvhead[idx]->records
+		[krcp->bkvhead[idx]->nr_records++] = ptr;
 
 	return true;
 }
 
 /*
- * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
- * period. Please note there are two paths are maintained, one is the main one
- * that uses kfree_bulk() interface and second one is emergency one, that is
- * used only when the main path can not be maintained temporary, due to memory
- * pressure.
+ * Queue a request for lazy invocation of appropriate free routine after a
+ * grace period. Please note there are three paths are maintained, two are the
+ * main ones that use array of pointers interface and third one is emergency
+ * one, that is used only when the main path can not be maintained temporary,
+ * due to memory pressure.
  *
  * Each kfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
- * reduce the number of grace periods during heavy kfree_rcu() load.
+ * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -3231,7 +3277,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
@@ -4212,7 +4258,7 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kfree_rcu_bulk_data *bnode;
+		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
@@ -4220,7 +4266,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kfree_rcu_bulk_data *)
+			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 
 			if (bnode)
-- 
2.20.1

