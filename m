Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF9233D81;
	Tue, 10 Dec 2024 16:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848848; cv=none; b=rMRgo/VfOM3P7/Kovp1+M0bsqI9Ow68/Ie3r5CyXluazPWauhLgLWTe4xYA9SLB7fwP404rX+eFvNZPEx7OlpFAqyR53oy563vV3sOZAf58fq2cHefNevz6hcpUYXxLlmD48XZhT9/gc5GEy2EnstCAWVafmhaPgzCPw11s1PHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848848; c=relaxed/simple;
	bh=VKftjw03RHaWnGNolD1PpEtAWpyo9AqfiOBo2S3AN3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+CxE6FFzYG426O+wCTv8ynEv5oI8oJ0iFybMutnsAU+j4h1zn/g5n9vM7RENjcoAGVBIiLRS4O8xEhD3C94xjh8WD8VRSQ7cxRMItVP2GEQ7lRZb2p0+zpQs8n0kU6T39thotAykeamPYL+VELZZsqzUHFcMlLY7dmOyIqPGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT2Tlqmm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT2Tlqmm"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so3087230e87.0;
        Tue, 10 Dec 2024 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848844; x=1734453644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZyu20V0IT5sFAUs0VabPR/e3lkWhuOMoGZgqAXATFM=;
        b=eT2Tlqmm4pq98XTggghZxaYFQjukWXFu7/1IPTHi8F0PvkE5wKb5qh6FJR+mn/UzUb
         TDEK0wUS4yEHz3xPlFkHRXxcePVCCI80HYeUPRZnUe5B2xkhUCR0rtZ3W7CwQSkkUcbZ
         6C4zjNOUJgoqi2F5i/2fdfibA+LyAdK0Ofa9BLKDtYgYkycHysL0byNYOjbOTYIwCyvY
         uh2M5cOAzlD8arLC+g0rUR0mEsDfLDkFg2k8yxL+NUpoGDNYzqchd3XfHBCIimVrmd6+
         OfOrLzhgpgqLiaQiFgKf+QW7KepDurOZCoAb67RC1tvoE30UAb4KelGAOzuS6ttDaQ4b
         rkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848844; x=1734453644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZyu20V0IT5sFAUs0VabPR/e3lkWhuOMoGZgqAXATFM=;
        b=Mj1ue6wry2cPJlFZg9P5KysGKsOc4ec1fY3djrpwN/ulVArJStcASLpxNI86EZ6BIC
         D+Qo/wwH0OOziva54mTuQSrQZZ78gZhU0mqnEe6+V4BZJR9TiNtJp1dZH1mSuN//rzN4
         oY9PNmboFqGKDch9EZuo0S2M9eEVRSsZ59e+nbpwo1Q+jvHGFq14Zkhf5zTyMG/2eDBI
         VYp0UEkVJCAlGnM1Ng8maEOl5um3Ht8bxNnZbkR0Asqg5eBD/iiM+eXWGgmAVlD1K190
         3ONun/wb9PDhEMqxdVvr90SQt+hHQds8AL3yNmIn0bURzxusZ55YFgdHgHYEnlp+//Ws
         ht7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGxIPeclRwcu/hNygn4gp+yVMyLUannbaJvw7JFJCDeZ5/5IFa3Act00rH+r1bZAq+EtlJY1Z88V8i89o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMfC2yoQ0L3/1YLG3OFxllq3el8RluB9mqZRNZxV2+OrOxTAM
	hFn0T49CiyIryIBPut6KjeJ9D4Jqbqeza4onao7UhQZS3Q0kr9Ax
X-Gm-Gg: ASbGncvjVB910mW41LA3banA3h2O/idKhb8Wled82cfW5oj7cXrbgrwZz+JtQBu3py7
	FPzWGP1wCPF2gbOo/QefWrQdDpcOvMJQsEKB1kjscL+6eDpFyqe9/MHtXNEMvlAOl71Ep77ovCq
	0jfDyGNbYeR0G9eTI2e06BwheQite2Mzt0gNXbAZXfKQ21OiUYbikXZoanh481w/BCJcyVcg7JE
	VnU1yEsaHHCQYWw84siCaMPtazjxN2EkeLTtvXmwmnsy7nUsQ==
X-Google-Smtp-Source: AGHT+IGC7l/kzkPm03FA64LMQLtPLRrGPZWNRGEIpVIvobJcPaCqJsqgeIavMCRlV0yqxEXaUpJUUg==
X-Received: by 2002:a05:6512:6c8:b0:53f:f71:4d74 with SMTP id 2adb3069b0e04-53f0f714e3amr5537287e87.8.1733848842959;
        Tue, 10 Dec 2024 08:40:42 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93377eefsm1031875e87.67.2024.12.10.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:40:41 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [RFC v1 5/5] mm/slab: Move kvfree_rcu() into SLAB
Date: Tue, 10 Dec 2024 17:40:35 +0100
Message-Id: <20241210164035.3391747-6-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210164035.3391747-1-urezki@gmail.com>
References: <20241210164035.3391747-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A final move of kvfree_rcu() functionality into slab_common.c file:

- Rename kfree_rcu_batch_init() to the kvfree_rcu_init();
- Invoke the kvfree_rcu_init() function from main.c after rcu_init();
- Move the rest of functionality to the slab_common.c file;
- Fully remove kvfree_rcu() from the kernel/rcu/tree.c file;
- Remove a temporary solution to handle freeing ptrs. after GP;
- Remove "__maybe_unused" from the slab_common.c file;
- Do not export main functionality for CONFIG_TINY_RCU case.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/slab.h |   1 +
 init/main.c          |   1 +
 kernel/rcu/tree.c    | 893 +------------------------------------------
 mm/slab_common.c     | 256 +++++++++++--
 4 files changed, 225 insertions(+), 926 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b35e2db7eb0e..8a2d006119f8 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1076,5 +1076,6 @@ unsigned int kmem_cache_size(struct kmem_cache *s);
 size_t kmalloc_size_roundup(size_t size);
 
 void __init kmem_cache_init_late(void);
+void __init kvfree_rcu_init(void);
 
 #endif	/* _LINUX_SLAB_H */
diff --git a/init/main.c b/init/main.c
index c4778edae797..27d177784f3a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -995,6 +995,7 @@ void start_kernel(void)
 	workqueue_init_early();
 
 	rcu_init();
+	kvfree_rcu_init();
 
 	/* Trace events are available after this */
 	trace_init();
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ab24229dfa73..4c9c16945e3a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -186,26 +186,6 @@ static int rcu_unlock_delay;
 module_param(rcu_unlock_delay, int, 0444);
 #endif
 
-/*
- * This rcu parameter is runtime-read-only. It reflects
- * a minimum allowed number of objects which can be cached
- * per-CPU. Object size is equal to one page. This value
- * can be changed at boot time.
- */
-static int rcu_min_cached_objs = 5;
-module_param(rcu_min_cached_objs, int, 0444);
-
-// A page shrinker can ask for pages to be freed to make them
-// available for other parts of the system. This usually happens
-// under low memory conditions, and in that case we should also
-// defer page-cache filling for a short time period.
-//
-// The default value is 5 seconds, which is long enough to reduce
-// interference with the shrinker while it asks other systems to
-// drain their caches.
-static int rcu_delay_page_cache_fill_msec = 5000;
-module_param(rcu_delay_page_cache_fill_msec, int, 0444);
-
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -2559,19 +2539,13 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
 		f = rhp->func;
+		debug_rcu_head_callback(rhp);
+		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+		f(rhp);
 
-		/* This is temporary, it will be removed when migration is over. */
-		if (__is_kvfree_rcu_offset((unsigned long) f)) {
-			trace_rcu_invoke_kvfree_callback("", rhp, (unsigned long) f);
-			kvfree((void *) rhp - (unsigned long) f);
-		} else {
-			trace_rcu_invoke_callback(rcu_state.name, rhp);
-			debug_rcu_head_callback(rhp);
-			WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
-			f(rhp);
-		}
 		rcu_lock_release(&rcu_callback_map);
 
 		/*
@@ -3197,815 +3171,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-/* Maximum number of jiffies to wait before draining a batch. */
-#define KFREE_DRAIN_JIFFIES (5 * HZ)
-#define KFREE_N_BATCHES 2
-#define FREE_N_CHANNELS 2
-
-/**
- * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
- * @list: List node. All blocks are linked between each other
- * @gp_snap: Snapshot of RCU state for objects placed to this bulk
- * @nr_records: Number of active pointers in the array
- * @records: Array of the kvfree_rcu() pointers
- */
-struct kvfree_rcu_bulk_data {
-	struct list_head list;
-	struct rcu_gp_oldstate gp_snap;
-	unsigned long nr_records;
-	void *records[] __counted_by(nr_records);
-};
-
-/*
- * This macro defines how many entries the "records" array
- * will contain. It is based on the fact that the size of
- * kvfree_rcu_bulk_data structure becomes exactly one page.
- */
-#define KVFREE_BULK_MAX_ENTR \
-	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
-
-/**
- * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
- * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
- * @head_free: List of kfree_rcu() objects waiting for a grace period
- * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
- * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
- * @krcp: Pointer to @kfree_rcu_cpu structure
- */
-
-struct kfree_rcu_cpu_work {
-	struct rcu_work rcu_work;
-	struct rcu_head *head_free;
-	struct rcu_gp_oldstate head_free_gp_snap;
-	struct list_head bulk_head_free[FREE_N_CHANNELS];
-	struct kfree_rcu_cpu *krcp;
-};
-
-/**
- * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
- * @head: List of kfree_rcu() objects not yet waiting for a grace period
- * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
- * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
- * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
- * @lock: Synchronize access to this structure
- * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
- * @initialized: The @rcu_work fields have been initialized
- * @head_count: Number of objects in rcu_head singular list
- * @bulk_count: Number of objects in bulk-list
- * @bkvcache:
- *	A simple cache list that contains objects for reuse purpose.
- *	In order to save some per-cpu space the list is singular.
- *	Even though it is lockless an access has to be protected by the
- *	per-cpu lock.
- * @page_cache_work: A work to refill the cache when it is empty
- * @backoff_page_cache_fill: Delay cache refills
- * @work_in_progress: Indicates that page_cache_work is running
- * @hrtimer: A hrtimer for scheduling a page_cache_work
- * @nr_bkv_objs: number of allocated objects at @bkvcache.
- *
- * This is a per-CPU structure.  The reason that it is not included in
- * the rcu_data structure is to permit this code to be extracted from
- * the RCU files.  Such extraction could allow further optimization of
- * the interactions with the slab allocators.
- */
-struct kfree_rcu_cpu {
-	// Objects queued on a linked list
-	// through their rcu_head structures.
-	struct rcu_head *head;
-	unsigned long head_gp_snap;
-	atomic_t head_count;
-
-	// Objects queued on a bulk-list.
-	struct list_head bulk_head[FREE_N_CHANNELS];
-	atomic_t bulk_count[FREE_N_CHANNELS];
-
-	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
-	raw_spinlock_t lock;
-	struct delayed_work monitor_work;
-	bool initialized;
-
-	struct delayed_work page_cache_work;
-	atomic_t backoff_page_cache_fill;
-	atomic_t work_in_progress;
-	struct hrtimer hrtimer;
-
-	struct llist_head bkvcache;
-	int nr_bkv_objs;
-};
-
-static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
-	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
-};
-
-static __always_inline void
-debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
-{
-#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	int i;
-
-	for (i = 0; i < bhead->nr_records; i++)
-		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
-#endif
-}
-
-static inline struct kfree_rcu_cpu *
-krc_this_cpu_lock(unsigned long *flags)
-{
-	struct kfree_rcu_cpu *krcp;
-
-	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	raw_spin_lock(&krcp->lock);
-
-	return krcp;
-}
-
-static inline void
-krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
-{
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
-}
-
-static inline struct kvfree_rcu_bulk_data *
-get_cached_bnode(struct kfree_rcu_cpu *krcp)
-{
-	if (!krcp->nr_bkv_objs)
-		return NULL;
-
-	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
-	return (struct kvfree_rcu_bulk_data *)
-		llist_del_first(&krcp->bkvcache);
-}
-
-static inline bool
-put_cached_bnode(struct kfree_rcu_cpu *krcp,
-	struct kvfree_rcu_bulk_data *bnode)
-{
-	// Check the limit.
-	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
-		return false;
-
-	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
-	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
-	return true;
-}
-
-static int
-drain_page_cache(struct kfree_rcu_cpu *krcp)
-{
-	unsigned long flags;
-	struct llist_node *page_list, *pos, *n;
-	int freed = 0;
-
-	if (!rcu_min_cached_objs)
-		return 0;
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	page_list = llist_del_all(&krcp->bkvcache);
-	WRITE_ONCE(krcp->nr_bkv_objs, 0);
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-	llist_for_each_safe(pos, n, page_list) {
-		free_page((unsigned long)pos);
-		freed++;
-	}
-
-	return freed;
-}
-
-static void
-kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
-	struct kvfree_rcu_bulk_data *bnode, int idx)
-{
-	unsigned long flags;
-	int i;
-
-	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
-		debug_rcu_bhead_unqueue(bnode);
-		rcu_lock_acquire(&rcu_callback_map);
-		if (idx == 0) { // kmalloc() / kfree().
-			trace_rcu_invoke_kfree_bulk_callback(
-				rcu_state.name, bnode->nr_records,
-				bnode->records);
-
-			kfree_bulk(bnode->nr_records, bnode->records);
-		} else { // vmalloc() / vfree().
-			for (i = 0; i < bnode->nr_records; i++) {
-				trace_rcu_invoke_kvfree_callback(
-					rcu_state.name, bnode->records[i], 0);
-
-				vfree(bnode->records[i]);
-			}
-		}
-		rcu_lock_release(&rcu_callback_map);
-	}
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	if (put_cached_bnode(krcp, bnode))
-		bnode = NULL;
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-	if (bnode)
-		free_page((unsigned long) bnode);
-
-	cond_resched_tasks_rcu_qs();
-}
-
-static void
-kvfree_rcu_list(struct rcu_head *head)
-{
-	struct rcu_head *next;
-
-	for (; head; head = next) {
-		void *ptr = (void *) head->func;
-		unsigned long offset = (void *) head - ptr;
-
-		next = head->next;
-		debug_rcu_head_unqueue((struct rcu_head *)ptr);
-		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
-
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree(ptr);
-
-		rcu_lock_release(&rcu_callback_map);
-		cond_resched_tasks_rcu_qs();
-	}
-}
-
-/*
- * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->bulk_head_free or ->head_free.
- */
-static void kfree_rcu_work(struct work_struct *work)
-{
-	unsigned long flags;
-	struct kvfree_rcu_bulk_data *bnode, *n;
-	struct list_head bulk_head[FREE_N_CHANNELS];
-	struct rcu_head *head;
-	struct kfree_rcu_cpu *krcp;
-	struct kfree_rcu_cpu_work *krwp;
-	struct rcu_gp_oldstate head_gp_snap;
-	int i;
-
-	krwp = container_of(to_rcu_work(work),
-		struct kfree_rcu_cpu_work, rcu_work);
-	krcp = krwp->krcp;
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	// Channels 1 and 2.
-	for (i = 0; i < FREE_N_CHANNELS; i++)
-		list_replace_init(&krwp->bulk_head_free[i], &bulk_head[i]);
-
-	// Channel 3.
-	head = krwp->head_free;
-	krwp->head_free = NULL;
-	head_gp_snap = krwp->head_free_gp_snap;
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-	// Handle the first two channels.
-	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		// Start from the tail page, so a GP is likely passed for it.
-		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
-			kvfree_rcu_bulk(krcp, bnode, i);
-	}
-
-	/*
-	 * This is used when the "bulk" path can not be used for the
-	 * double-argument of kvfree_rcu().  This happens when the
-	 * page-cache is empty, which means that objects are instead
-	 * queued on a linked list through their rcu_head structures.
-	 * This list is named "Channel 3".
-	 */
-	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
-		kvfree_rcu_list(head);
-}
-
-static bool
-need_offload_krc(struct kfree_rcu_cpu *krcp)
-{
-	int i;
-
-	for (i = 0; i < FREE_N_CHANNELS; i++)
-		if (!list_empty(&krcp->bulk_head[i]))
-			return true;
-
-	return !!READ_ONCE(krcp->head);
-}
-
-static bool
-need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
-{
-	int i;
-
-	for (i = 0; i < FREE_N_CHANNELS; i++)
-		if (!list_empty(&krwp->bulk_head_free[i]))
-			return true;
-
-	return !!krwp->head_free;
-}
-
-static int krc_count(struct kfree_rcu_cpu *krcp)
-{
-	int sum = atomic_read(&krcp->head_count);
-	int i;
-
-	for (i = 0; i < FREE_N_CHANNELS; i++)
-		sum += atomic_read(&krcp->bulk_count[i]);
-
-	return sum;
-}
-
-static void
-schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
-{
-	long delay, delay_left;
-
-	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
-	if (delayed_work_pending(&krcp->monitor_work)) {
-		delay_left = krcp->monitor_work.timer.expires - jiffies;
-		if (delay < delay_left)
-			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
-		return;
-	}
-	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
-}
-
-static void
-kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
-{
-	struct list_head bulk_ready[FREE_N_CHANNELS];
-	struct kvfree_rcu_bulk_data *bnode, *n;
-	struct rcu_head *head_ready = NULL;
-	unsigned long flags;
-	int i;
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		INIT_LIST_HEAD(&bulk_ready[i]);
-
-		list_for_each_entry_safe_reverse(bnode, n, &krcp->bulk_head[i], list) {
-			if (!poll_state_synchronize_rcu_full(&bnode->gp_snap))
-				break;
-
-			atomic_sub(bnode->nr_records, &krcp->bulk_count[i]);
-			list_move(&bnode->list, &bulk_ready[i]);
-		}
-	}
-
-	if (krcp->head && poll_state_synchronize_rcu(krcp->head_gp_snap)) {
-		head_ready = krcp->head;
-		atomic_set(&krcp->head_count, 0);
-		WRITE_ONCE(krcp->head, NULL);
-	}
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		list_for_each_entry_safe(bnode, n, &bulk_ready[i], list)
-			kvfree_rcu_bulk(krcp, bnode, i);
-	}
-
-	if (head_ready)
-		kvfree_rcu_list(head_ready);
-}
-
-/*
- * Return: %true if a work is queued, %false otherwise.
- */
-static bool
-kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
-{
-	unsigned long flags;
-	bool queued = false;
-	int i, j;
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-
-	// Attempt to start a new batch.
-	for (i = 0; i < KFREE_N_BATCHES; i++) {
-		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
-
-		// Try to detach bulk_head or head and attach it, only when
-		// all channels are free.  Any channel is not free means at krwp
-		// there is on-going rcu work to handle krwp's free business.
-		if (need_wait_for_krwp_work(krwp))
-			continue;
-
-		// kvfree_rcu_drain_ready() might handle this krcp, if so give up.
-		if (need_offload_krc(krcp)) {
-			// Channel 1 corresponds to the SLAB-pointer bulk path.
-			// Channel 2 corresponds to vmalloc-pointer bulk path.
-			for (j = 0; j < FREE_N_CHANNELS; j++) {
-				if (list_empty(&krwp->bulk_head_free[j])) {
-					atomic_set(&krcp->bulk_count[j], 0);
-					list_replace_init(&krcp->bulk_head[j],
-						&krwp->bulk_head_free[j]);
-				}
-			}
-
-			// Channel 3 corresponds to both SLAB and vmalloc
-			// objects queued on the linked list.
-			if (!krwp->head_free) {
-				krwp->head_free = krcp->head;
-				get_state_synchronize_rcu_full(&krwp->head_free_gp_snap);
-				atomic_set(&krcp->head_count, 0);
-				WRITE_ONCE(krcp->head, NULL);
-			}
-
-			// One work is per one batch, so there are three
-			// "free channels", the batch can handle. Break
-			// the loop since it is done with this CPU thus
-			// queuing an RCU work is _always_ success here.
-			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
-			WARN_ON_ONCE(!queued);
-			break;
-		}
-	}
-
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
-	return queued;
-}
-
-/*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
- */
-static void kfree_rcu_monitor(struct work_struct *work)
-{
-	struct kfree_rcu_cpu *krcp = container_of(work,
-		struct kfree_rcu_cpu, monitor_work.work);
-
-	// Drain ready for reclaim.
-	kvfree_rcu_drain_ready(krcp);
-
-	// Queue a batch for a rest.
-	kvfree_rcu_queue_batch(krcp);
-
-	// If there is nothing to detach, it means that our job is
-	// successfully done here. In case of having at least one
-	// of the channels that is still busy we should rearm the
-	// work to repeat an attempt. Because previous batches are
-	// still in progress.
-	if (need_offload_krc(krcp))
-		schedule_delayed_monitor_work(krcp);
-}
-
-static enum hrtimer_restart
-schedule_page_work_fn(struct hrtimer *t)
-{
-	struct kfree_rcu_cpu *krcp =
-		container_of(t, struct kfree_rcu_cpu, hrtimer);
-
-	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
-	return HRTIMER_NORESTART;
-}
-
-static void fill_page_cache_func(struct work_struct *work)
-{
-	struct kvfree_rcu_bulk_data *bnode;
-	struct kfree_rcu_cpu *krcp =
-		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work.work);
-	unsigned long flags;
-	int nr_pages;
-	bool pushed;
-	int i;
-
-	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
-		1 : rcu_min_cached_objs;
-
-	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
-		bnode = (struct kvfree_rcu_bulk_data *)
-			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
-
-		if (!bnode)
-			break;
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		pushed = put_cached_bnode(krcp, bnode);
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-		if (!pushed) {
-			free_page((unsigned long) bnode);
-			break;
-		}
-	}
-
-	atomic_set(&krcp->work_in_progress, 0);
-	atomic_set(&krcp->backoff_page_cache_fill, 0);
-}
-
-static void
-run_page_cache_worker(struct kfree_rcu_cpu *krcp)
-{
-	// If cache disabled, bail out.
-	if (!rcu_min_cached_objs)
-		return;
-
-	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_unbound_wq,
-				&krcp->page_cache_work,
-					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
-		} else {
-			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-			krcp->hrtimer.function = schedule_page_work_fn;
-			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
-		}
-	}
-}
-
-// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
-// state specified by flags.  If can_alloc is true, the caller must
-// be schedulable and not be holding any locks or mutexes that might be
-// acquired by the memory allocator or anything that it might invoke.
-// Returns true if ptr was successfully recorded, else the caller must
-// use a fallback.
-static inline bool
-add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
-	unsigned long *flags, void *ptr, bool can_alloc)
-{
-	struct kvfree_rcu_bulk_data *bnode;
-	int idx;
-
-	*krcp = krc_this_cpu_lock(flags);
-	if (unlikely(!(*krcp)->initialized))
-		return false;
-
-	idx = !!is_vmalloc_addr(ptr);
-	bnode = list_first_entry_or_null(&(*krcp)->bulk_head[idx],
-		struct kvfree_rcu_bulk_data, list);
-
-	/* Check if a new block is required. */
-	if (!bnode || bnode->nr_records == KVFREE_BULK_MAX_ENTR) {
-		bnode = get_cached_bnode(*krcp);
-		if (!bnode && can_alloc) {
-			krc_this_cpu_unlock(*krcp, *flags);
-
-			// __GFP_NORETRY - allows a light-weight direct reclaim
-			// what is OK from minimizing of fallback hitting point of
-			// view. Apart of that it forbids any OOM invoking what is
-			// also beneficial since we are about to release memory soon.
-			//
-			// __GFP_NOMEMALLOC - prevents from consuming of all the
-			// memory reserves. Please note we have a fallback path.
-			//
-			// __GFP_NOWARN - it is supposed that an allocation can
-			// be failed under low memory or high memory pressure
-			// scenarios.
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
-			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
-		}
-
-		if (!bnode)
-			return false;
-
-		// Initialize the new block and attach it.
-		bnode->nr_records = 0;
-		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
-	}
-
-	// Finally insert and update the GP for this page.
-	bnode->nr_records++;
-	bnode->records[bnode->nr_records - 1] = ptr;
-	get_state_synchronize_rcu_full(&bnode->gp_snap);
-	atomic_inc(&(*krcp)->bulk_count[idx]);
-
-	return true;
-}
-
-/*
- * Queue a request for lazy invocation of the appropriate free routine
- * after a grace period.  Please note that three paths are maintained,
- * two for the common case using arrays of pointers and a third one that
- * is used only when the main paths cannot be used, for example, due to
- * memory pressure.
- *
- * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
- * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
- * be free'd in workqueue context. This allows us to: batch requests together to
- * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
- */
-void kvfree_call_rcu(struct rcu_head *head, void *ptr)
-{
-	unsigned long flags;
-	struct kfree_rcu_cpu *krcp;
-	bool success;
-
-	if (head) {
-		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
-	} else {
-		synchronize_rcu();
-		kvfree(ptr);
-	}
-
-	/* Disconnect the rest. */
-	return;
-
-	/*
-	 * Please note there is a limitation for the head-less
-	 * variant, that is why there is a clear rule for such
-	 * objects: it can be used from might_sleep() context
-	 * only. For other places please embed an rcu_head to
-	 * your data.
-	 */
-	if (!head)
-		might_sleep();
-
-	// Queue the object but don't yet schedule the batch.
-	if (debug_rcu_head_queue(ptr)) {
-		// Probable double kfree_rcu(), just leak.
-		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
-			  __func__, head);
-
-		// Mark as success and leave.
-		return;
-	}
-
-	kasan_record_aux_stack_noalloc(ptr);
-	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
-	if (!success) {
-		run_page_cache_worker(krcp);
-
-		if (head == NULL)
-			// Inline if kvfree_rcu(one_arg) call.
-			goto unlock_return;
-
-		head->func = ptr;
-		head->next = krcp->head;
-		WRITE_ONCE(krcp->head, head);
-		atomic_inc(&krcp->head_count);
-
-		// Take a snapshot for this krcp.
-		krcp->head_gp_snap = get_state_synchronize_rcu();
-		success = true;
-	}
-
-	/*
-	 * The kvfree_rcu() caller considers the pointer freed at this point
-	 * and likely removes any references to it. Since the actual slab
-	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
-	 * this object (no scanning or false positives reporting).
-	 */
-	kmemleak_ignore(ptr);
-
-	// Set timer to drain after KFREE_DRAIN_JIFFIES.
-	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
-		schedule_delayed_monitor_work(krcp);
-
-unlock_return:
-	krc_this_cpu_unlock(krcp, flags);
-
-	/*
-	 * Inline kvfree() after synchronize_rcu(). We can do
-	 * it from might_sleep() context only, so the current
-	 * CPU can pass the QS state.
-	 */
-	if (!success) {
-		debug_rcu_head_unqueue((struct rcu_head *) ptr);
-		synchronize_rcu();
-		kvfree(ptr);
-	}
-}
-EXPORT_SYMBOL_GPL(kvfree_call_rcu);
-
-/**
- * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
- *
- * Note that a single argument of kvfree_rcu() call has a slow path that
- * triggers synchronize_rcu() following by freeing a pointer. It is done
- * before the return from the function. Therefore for any single-argument
- * call that will result in a kfree() to a cache that is to be destroyed
- * during module exit, it is developer's responsibility to ensure that all
- * such calls have returned before the call to kmem_cache_destroy().
- */
-void kvfree_rcu_barrier(void)
-{
-	struct kfree_rcu_cpu_work *krwp;
-	struct kfree_rcu_cpu *krcp;
-	bool queued;
-	int i, cpu;
-
-	/* Temporary. */
-	rcu_barrier();
-
-	/*
-	 * Firstly we detach objects and queue them over an RCU-batch
-	 * for all CPUs. Finally queued works are flushed for each CPU.
-	 *
-	 * Please note. If there are outstanding batches for a particular
-	 * CPU, those have to be finished first following by queuing a new.
-	 */
-	for_each_possible_cpu(cpu) {
-		krcp = per_cpu_ptr(&krc, cpu);
-
-		/*
-		 * Check if this CPU has any objects which have been queued for a
-		 * new GP completion. If not(means nothing to detach), we are done
-		 * with it. If any batch is pending/running for this "krcp", below
-		 * per-cpu flush_rcu_work() waits its completion(see last step).
-		 */
-		if (!need_offload_krc(krcp))
-			continue;
-
-		while (1) {
-			/*
-			 * If we are not able to queue a new RCU work it means:
-			 * - batches for this CPU are still in flight which should
-			 *   be flushed first and then repeat;
-			 * - no objects to detach, because of concurrency.
-			 */
-			queued = kvfree_rcu_queue_batch(krcp);
-
-			/*
-			 * Bail out, if there is no need to offload this "krcp"
-			 * anymore. As noted earlier it can run concurrently.
-			 */
-			if (queued || !need_offload_krc(krcp))
-				break;
-
-			/* There are ongoing batches. */
-			for (i = 0; i < KFREE_N_BATCHES; i++) {
-				krwp = &(krcp->krw_arr[i]);
-				flush_rcu_work(&krwp->rcu_work);
-			}
-		}
-	}
-
-	/*
-	 * Now we guarantee that all objects are flushed.
-	 */
-	for_each_possible_cpu(cpu) {
-		krcp = per_cpu_ptr(&krc, cpu);
-
-		/*
-		 * A monitor work can drain ready to reclaim objects
-		 * directly. Wait its completion if running or pending.
-		 */
-		cancel_delayed_work_sync(&krcp->monitor_work);
-
-		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			krwp = &(krcp->krw_arr[i]);
-			flush_rcu_work(&krwp->rcu_work);
-		}
-	}
-}
-EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
-
-static unsigned long
-kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
-{
-	int cpu;
-	unsigned long count = 0;
-
-	/* Snapshot count of all CPUs */
-	for_each_possible_cpu(cpu) {
-		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-
-		count += krc_count(krcp);
-		count += READ_ONCE(krcp->nr_bkv_objs);
-		atomic_set(&krcp->backoff_page_cache_fill, 1);
-	}
-
-	return count == 0 ? SHRINK_EMPTY : count;
-}
-
-static unsigned long
-kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
-{
-	int cpu, freed = 0;
-
-	for_each_possible_cpu(cpu) {
-		int count;
-		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-
-		count = krc_count(krcp);
-		count += drain_page_cache(krcp);
-		kfree_rcu_monitor(&krcp->monitor_work.work);
-
-		sc->nr_to_scan -= count;
-		freed += count;
-
-		if (sc->nr_to_scan <= 0)
-			break;
-	}
-
-	return freed == 0 ? SHRINK_STOP : freed;
-}
-
-void __init kfree_rcu_scheduler_running(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-
-		if (need_offload_krc(krcp))
-			schedule_delayed_monitor_work(krcp);
-	}
-}
-
 /*
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.
@@ -5665,62 +4830,12 @@ static void __init rcu_dump_rcu_node_tree(void)
 
 struct workqueue_struct *rcu_gp_wq;
 
-static void __init kfree_rcu_batch_init(void)
-{
-	int cpu;
-	int i, j;
-	struct shrinker *kfree_rcu_shrinker;
-
-	/* Clamp it to [0:100] seconds interval. */
-	if (rcu_delay_page_cache_fill_msec < 0 ||
-		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
-
-		rcu_delay_page_cache_fill_msec =
-			clamp(rcu_delay_page_cache_fill_msec, 0,
-				(int) (100 * MSEC_PER_SEC));
-
-		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
-			rcu_delay_page_cache_fill_msec);
-	}
-
-	for_each_possible_cpu(cpu) {
-		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-
-		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
-			krcp->krw_arr[i].krcp = krcp;
-
-			for (j = 0; j < FREE_N_CHANNELS; j++)
-				INIT_LIST_HEAD(&krcp->krw_arr[i].bulk_head_free[j]);
-		}
-
-		for (i = 0; i < FREE_N_CHANNELS; i++)
-			INIT_LIST_HEAD(&krcp->bulk_head[i]);
-
-		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
-		krcp->initialized = true;
-	}
-
-	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
-	if (!kfree_rcu_shrinker) {
-		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
-		return;
-	}
-
-	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
-	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
-
-	shrinker_register(kfree_rcu_shrinker);
-}
-
 void __init rcu_init(void)
 {
 	int cpu = smp_processor_id();
 
 	rcu_early_boot_tests();
 
-	kfree_rcu_batch_init();
 	rcu_bootup_announce();
 	sanitize_kthread_prio();
 	rcu_init_geometry();
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cffc96bd279a..39de00e2cf88 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1513,7 +1513,7 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 	return true;
 }
 
-static int __maybe_unused
+static int
 drain_page_cache(struct kfree_rcu_cpu *krcp)
 {
 	unsigned long flags;
@@ -1600,7 +1600,7 @@ kvfree_rcu_list(struct rcu_head *head)
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bulk_head_free or ->head_free.
  */
-static void __maybe_unused
+static void
 kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
@@ -1793,7 +1793,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
-static void __maybe_unused
+static void
 kfree_rcu_monitor(struct work_struct *work)
 {
 	struct kfree_rcu_cpu *krcp = container_of(work,
@@ -1814,17 +1814,7 @@ kfree_rcu_monitor(struct work_struct *work)
 		schedule_delayed_monitor_work(krcp);
 }
 
-static enum hrtimer_restart
-schedule_page_work_fn(struct hrtimer *t)
-{
-	struct kfree_rcu_cpu *krcp =
-		container_of(t, struct kfree_rcu_cpu, hrtimer);
-
-	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
-	return HRTIMER_NORESTART;
-}
-
-static void __maybe_unused
+static void
 fill_page_cache_func(struct work_struct *work)
 {
 	struct kvfree_rcu_bulk_data *bnode;
@@ -1860,27 +1850,6 @@ fill_page_cache_func(struct work_struct *work)
 	atomic_set(&krcp->backoff_page_cache_fill, 0);
 }
 
-static void __maybe_unused
-run_page_cache_worker(struct kfree_rcu_cpu *krcp)
-{
-	// If cache disabled, bail out.
-	if (!rcu_min_cached_objs)
-		return;
-
-	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_unbound_wq,
-				&krcp->page_cache_work,
-					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
-		} else {
-			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-			krcp->hrtimer.function = schedule_page_work_fn;
-			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
-		}
-	}
-}
-
 // Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
 // state specified by flags.  If can_alloc is true, the caller must
 // be schedulable and not be holding any locks or mutexes that might be
@@ -1941,6 +1910,219 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
+#if !defined(CONFIG_TINY_RCU)
+
+static enum hrtimer_restart
+schedule_page_work_fn(struct hrtimer *t)
+{
+	struct kfree_rcu_cpu *krcp =
+		container_of(t, struct kfree_rcu_cpu, hrtimer);
+
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
+	return HRTIMER_NORESTART;
+}
+
+static void
+run_page_cache_worker(struct kfree_rcu_cpu *krcp)
+{
+	// If cache disabled, bail out.
+	if (!rcu_min_cached_objs)
+		return;
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+			!atomic_xchg(&krcp->work_in_progress, 1)) {
+		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+			queue_delayed_work(system_unbound_wq,
+				&krcp->page_cache_work,
+					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
+	}
+}
+
+/*
+ * Queue a request for lazy invocation of the appropriate free routine
+ * after a grace period.  Please note that three paths are maintained,
+ * two for the common case using arrays of pointers and a third one that
+ * is used only when the main paths cannot be used, for example, due to
+ * memory pressure.
+ *
+ * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
+ * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
+ * be free'd in workqueue context. This allows us to: batch requests together to
+ * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
+ */
+void kvfree_call_rcu(struct rcu_head *head, void *ptr)
+{
+	unsigned long flags;
+	struct kfree_rcu_cpu *krcp;
+	bool success;
+
+	/*
+	 * Please note there is a limitation for the head-less
+	 * variant, that is why there is a clear rule for such
+	 * objects: it can be used from might_sleep() context
+	 * only. For other places please embed an rcu_head to
+	 * your data.
+	 */
+	if (!head)
+		might_sleep();
+
+	// Queue the object but don't yet schedule the batch.
+	if (debug_rcu_head_queue(ptr)) {
+		// Probable double kfree_rcu(), just leak.
+		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
+			  __func__, head);
+
+		// Mark as success and leave.
+		return;
+	}
+
+	kasan_record_aux_stack_noalloc(ptr);
+	success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
+	if (!success) {
+		run_page_cache_worker(krcp);
+
+		if (head == NULL)
+			// Inline if kvfree_rcu(one_arg) call.
+			goto unlock_return;
+
+		head->func = ptr;
+		head->next = krcp->head;
+		WRITE_ONCE(krcp->head, head);
+		atomic_inc(&krcp->head_count);
+
+		// Take a snapshot for this krcp.
+		krcp->head_gp_snap = get_state_synchronize_rcu();
+		success = true;
+	}
+
+	/*
+	 * The kvfree_rcu() caller considers the pointer freed at this point
+	 * and likely removes any references to it. Since the actual slab
+	 * freeing (and kmemleak_free()) is deferred, tell kmemleak to ignore
+	 * this object (no scanning or false positives reporting).
+	 */
+	kmemleak_ignore(ptr);
+
+	// Set timer to drain after KFREE_DRAIN_JIFFIES.
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
+		schedule_delayed_monitor_work(krcp);
+
+unlock_return:
+	krc_this_cpu_unlock(krcp, flags);
+
+	/*
+	 * Inline kvfree() after synchronize_rcu(). We can do
+	 * it from might_sleep() context only, so the current
+	 * CPU can pass the QS state.
+	 */
+	if (!success) {
+		debug_rcu_head_unqueue((struct rcu_head *) ptr);
+		synchronize_rcu();
+		kvfree(ptr);
+	}
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+
+void __init
+kfree_rcu_scheduler_running(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		if (need_offload_krc(krcp))
+			schedule_delayed_monitor_work(krcp);
+	}
+}
+
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	struct kfree_rcu_cpu_work *krwp;
+	struct kfree_rcu_cpu *krcp;
+	bool queued;
+	int i, cpu;
+
+	/*
+	 * Firstly we detach objects and queue them over an RCU-batch
+	 * for all CPUs. Finally queued works are flushed for each CPU.
+	 *
+	 * Please note. If there are outstanding batches for a particular
+	 * CPU, those have to be finished first following by queuing a new.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * Check if this CPU has any objects which have been queued for a
+		 * new GP completion. If not(means nothing to detach), we are done
+		 * with it. If any batch is pending/running for this "krcp", below
+		 * per-cpu flush_rcu_work() waits its completion(see last step).
+		 */
+		if (!need_offload_krc(krcp))
+			continue;
+
+		while (1) {
+			/*
+			 * If we are not able to queue a new RCU work it means:
+			 * - batches for this CPU are still in flight which should
+			 *   be flushed first and then repeat;
+			 * - no objects to detach, because of concurrency.
+			 */
+			queued = kvfree_rcu_queue_batch(krcp);
+
+			/*
+			 * Bail out, if there is no need to offload this "krcp"
+			 * anymore. As noted earlier it can run concurrently.
+			 */
+			if (queued || !need_offload_krc(krcp))
+				break;
+
+			/* There are ongoing batches. */
+			for (i = 0; i < KFREE_N_BATCHES; i++) {
+				krwp = &(krcp->krw_arr[i]);
+				flush_rcu_work(&krwp->rcu_work);
+			}
+		}
+	}
+
+	/*
+	 * Now we guarantee that all objects are flushed.
+	 */
+	for_each_possible_cpu(cpu) {
+		krcp = per_cpu_ptr(&krc, cpu);
+
+		/*
+		 * A monitor work can drain ready to reclaim objects
+		 * directly. Wait its completion if running or pending.
+		 */
+		cancel_delayed_work_sync(&krcp->monitor_work);
+
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			krwp = &(krcp->krw_arr[i]);
+			flush_rcu_work(&krwp->rcu_work);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
+
+#endif /* #if !defined(CONFIG_TINY_RCU) */
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -1982,8 +2164,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return freed == 0 ? SHRINK_STOP : freed;
 }
 
-static void __init __maybe_unused
-kfree_rcu_batch_init(void)
+void __init
+kvfree_rcu_init(void)
 {
 	int cpu;
 	int i, j;
-- 
2.39.5

