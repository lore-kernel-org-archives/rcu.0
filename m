Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F92253F1;
	Thu, 12 Dec 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026544; cv=none; b=d6qA3ZXjQCUPorMD9Ro5OG5BVfko+x6DQcxAnKWy7mbx4MXkavWh4XmEBASKX3ENXzQ48gMA00nSK02Vip3TX8HSw66N/Vn08m6SolgIzWbqemx9GMANyJiqrPBM72Z2wNXHm5TUX/Dusn1JVDC0vUUkl23TSqBpMewkH3Xt58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026544; c=relaxed/simple;
	bh=nR5y2t93aErjpB2uo4lidEKQNm3ZNXrEyNPLM4SF7gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0tz23HVufQNw4cscAvLE3TsllCHZEUARHmgSBTcBL6LUCkVGhwghfJ2+L/5r2pAV+wbIR126qCPb04YVho+JHmAQanHSn+m+NzZlnvK9vjZO2kJ9Ht+izHhLWVcg3S3yELDjlDo5/3d4RMTXte9AjFcU66PzVe0q/h83ZSWRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbQefJsv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbQefJsv"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so970645e87.3;
        Thu, 12 Dec 2024 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026539; x=1734631339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp9n6MzDNw4OHX8MQ5giOdRJWOY1KB9wiTVGm+VZUQY=;
        b=kbQefJsvYHHTlY7zWf6Cmf1FOkSUpV2z/YjKH/enXFOMwmKvjnNbrW6epABBLSr0Kd
         kjVlifj1g09+uN1PY+BklzPq1F/1e7ou0yPlJByxKrm2fPDm/S0GR+cf6zzjkMEK3YC+
         K60uQZGdGm/jWWp+UQo0xTLH8NRtqMOajI3Zz11Eaxuvl+yFO/wlFQMoZhq0l3yOTzT3
         BLsDqTTUF5Pk8bnpKF2Ievz6owVEuNf06M5eDgrGT5NuGrOBAopLLLPFmlgvfPCQrPxy
         W7LrYRRb0KxWQTUOGalIWvxqG7oafWk3ngz9WQWMFREPyTfX1WIFShwG+/jgPJiR4p3y
         xzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026539; x=1734631339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp9n6MzDNw4OHX8MQ5giOdRJWOY1KB9wiTVGm+VZUQY=;
        b=GoggHaEIrmcWZhCl3AhVweTlA+Sr+ydfvd476l8eC21+uq9fVFHxr7BLIMUHckmSG8
         /Me3RbOQUEzPyCccvP7/sJPlfGRhvpGKQGZUcgA72DNHhS0vqtkqwkvj+IykG8qQIWA9
         V4lPUGtQKTSNRh81iisS2+nIvB0okN0sq5HihZrNsmljFPIJXxJAmc3YH8v82XoSRQ80
         VGL4VWdjYeP1OG4MUUo7XH9vLC520Jk8ePT34zBlTxUAMcJQJSeXxtoN8BeGUTJs8qHJ
         WNj0ZuyvcWeyVTO7KmIyoIHKi9gd75Kzk05Htj13ls6z2CtAG9RGSIOlP7ziX7pntCLS
         04OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVST5iioDYRkFNx0MYGry3iIfD09fsHTfK8phMwCn2b74Z/HohrlLrAwQPj18QTCg34xiuo0nWq20rCrkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvunFUYhxTQaQs5rSC3gBZfDjR39jdAT2LAmwVCm8kjDdiXe0s
	H7pmQP61lnlebTZ3kzR6w6lyojym+fv9qMKqlpxx4cpdA4HoZtLp
X-Gm-Gg: ASbGncvmsWArN23brAfbLOcnqfwMlr45+dnMPBotocxy4iTUZFn53mWmon2EhUSjtrt
	h+AA53YPC6v2IIiPJJH53La6+f61yAGGtdTrwVXyaRaEPZ58Uf0f5VA3VfEk+UFtsHn1YEgGQf8
	r4OrCO2kSQsz4z3bltRU/BI2v+W1pkTgMfSiwl8t3R6G6kq8Gv5LrdACdo4UI7hVIFJXQYImpgS
	NgrbVE8lBrrGidRfTNVWCse2h1ybAb7JBC7I5NG8THrIicszYUR
X-Google-Smtp-Source: AGHT+IEfQdeyIDZrSYGtJ4LX1kF2UVsP+Uht2AT+RfPzpQN9Rl7E74CSxqzZhAPeac2YdUJ9MV7Tsg==
X-Received: by 2002:a05:6512:a95:b0:540:1605:ac62 with SMTP id 2adb3069b0e04-54034107c8fmr546074e87.15.1734026536688;
        Thu, 12 Dec 2024 10:02:16 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39375d36sm1940645e87.7.2024.12.12.10.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:02:16 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 5/5] mm/slab: Move kvfree_rcu() into SLAB
Date: Thu, 12 Dec 2024 19:02:08 +0100
Message-Id: <20241212180208.274813-6-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
References: <20241212180208.274813-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move kvfree_rcu() functionality to the slab_common.c file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h |   1 -
 include/linux/slab.h     |   1 +
 kernel/rcu/tree.c        | 879 --------------------------------------
 mm/slab_common.c         | 880 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 881 insertions(+), 880 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index acb0095b4dbe..48e5c03df1dd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -118,7 +118,6 @@ static inline void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 
 /* Internal to kernel */
 void rcu_init(void);
-void __init kvfree_rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 10a971c2bde3..09eedaecf120 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1099,5 +1099,6 @@ unsigned int kmem_cache_size(struct kmem_cache *s);
 size_t kmalloc_size_roundup(size_t size);
 
 void __init kmem_cache_init_late(void);
+void __init kvfree_rcu_init(void);
 
 #endif	/* _LINUX_SLAB_H */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b7ec998f360e..6af042cde972 100644
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
@@ -3191,816 +3171,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
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
-				"slab", bnode->nr_records,
-				bnode->records);
-
-			kfree_bulk(bnode->nr_records, bnode->records);
-		} else { // vmalloc() / vfree().
-			for (i = 0; i < bnode->nr_records; i++) {
-				trace_rcu_invoke_kvfree_callback(
-					"slab", bnode->records[i], 0);
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
-		trace_rcu_invoke_kvfree_callback("slab", head, offset);
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
-__schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
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
-schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	__schedule_delayed_monitor_work(krcp);
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
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
-#if !defined(CONFIG_TINY_RCU)
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
-		__schedule_delayed_monitor_work(krcp);
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
-#endif /* #if !defined(CONFIG_TINY_RCU) */
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
 /*
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.
@@ -5652,55 +4822,6 @@ static void __init rcu_dump_rcu_node_tree(void)
 
 struct workqueue_struct *rcu_gp_wq;
 
-void __init kvfree_rcu_init(void)
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
-	kfree_rcu_shrinker = shrinker_alloc(0, "slab-kvfree-rcu");
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
diff --git a/mm/slab_common.c b/mm/slab_common.c
index a29457bef626..69f2d19010de 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -28,7 +28,9 @@
 #include <asm/page.h>
 #include <linux/memcontrol.h>
 #include <linux/stackdepot.h>
+#include <trace/events/rcu.h>
 
+#include "../kernel/rcu/rcu.h"
 #include "internal.h"
 #include "slab.h"
 
@@ -1282,3 +1284,881 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
+/*
+ * This rcu parameter is runtime-read-only. It reflects
+ * a minimum allowed number of objects which can be cached
+ * per-CPU. Object size is equal to one page. This value
+ * can be changed at boot time.
+ */
+static int rcu_min_cached_objs = 5;
+module_param(rcu_min_cached_objs, int, 0444);
+
+// A page shrinker can ask for pages to be freed to make them
+// available for other parts of the system. This usually happens
+// under low memory conditions, and in that case we should also
+// defer page-cache filling for a short time period.
+//
+// The default value is 5 seconds, which is long enough to reduce
+// interference with the shrinker while it asks other systems to
+// drain their caches.
+static int rcu_delay_page_cache_fill_msec = 5000;
+module_param(rcu_delay_page_cache_fill_msec, int, 0444);
+
+/* Maximum number of jiffies to wait before draining a batch. */
+#define KFREE_DRAIN_JIFFIES (5 * HZ)
+#define KFREE_N_BATCHES 2
+#define FREE_N_CHANNELS 2
+
+/**
+ * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
+ * @list: List node. All blocks are linked between each other
+ * @gp_snap: Snapshot of RCU state for objects placed to this bulk
+ * @nr_records: Number of active pointers in the array
+ * @records: Array of the kvfree_rcu() pointers
+ */
+struct kvfree_rcu_bulk_data {
+	struct list_head list;
+	struct rcu_gp_oldstate gp_snap;
+	unsigned long nr_records;
+	void *records[] __counted_by(nr_records);
+};
+
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kvfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KVFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
+
+/**
+ * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
+ * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
+ * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
+ * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
+ * @krcp: Pointer to @kfree_rcu_cpu structure
+ */
+
+struct kfree_rcu_cpu_work {
+	struct rcu_work rcu_work;
+	struct rcu_head *head_free;
+	struct rcu_gp_oldstate head_free_gp_snap;
+	struct list_head bulk_head_free[FREE_N_CHANNELS];
+	struct kfree_rcu_cpu *krcp;
+};
+
+/**
+ * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
+ * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
+ * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
+ * @lock: Synchronize access to this structure
+ * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
+ * @initialized: The @rcu_work fields have been initialized
+ * @head_count: Number of objects in rcu_head singular list
+ * @bulk_count: Number of objects in bulk-list
+ * @bkvcache:
+ *	A simple cache list that contains objects for reuse purpose.
+ *	In order to save some per-cpu space the list is singular.
+ *	Even though it is lockless an access has to be protected by the
+ *	per-cpu lock.
+ * @page_cache_work: A work to refill the cache when it is empty
+ * @backoff_page_cache_fill: Delay cache refills
+ * @work_in_progress: Indicates that page_cache_work is running
+ * @hrtimer: A hrtimer for scheduling a page_cache_work
+ * @nr_bkv_objs: number of allocated objects at @bkvcache.
+ *
+ * This is a per-CPU structure.  The reason that it is not included in
+ * the rcu_data structure is to permit this code to be extracted from
+ * the RCU files.  Such extraction could allow further optimization of
+ * the interactions with the slab allocators.
+ */
+struct kfree_rcu_cpu {
+	// Objects queued on a linked list
+	// through their rcu_head structures.
+	struct rcu_head *head;
+	unsigned long head_gp_snap;
+	atomic_t head_count;
+
+	// Objects queued on a bulk-list.
+	struct list_head bulk_head[FREE_N_CHANNELS];
+	atomic_t bulk_count[FREE_N_CHANNELS];
+
+	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
+	raw_spinlock_t lock;
+	struct delayed_work monitor_work;
+	bool initialized;
+
+	struct delayed_work page_cache_work;
+	atomic_t backoff_page_cache_fill;
+	atomic_t work_in_progress;
+	struct hrtimer hrtimer;
+
+	struct llist_head bkvcache;
+	int nr_bkv_objs;
+};
+
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
+};
+
+static __always_inline void
+debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
+{
+#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
+	int i;
+
+	for (i = 0; i < bhead->nr_records; i++)
+		debug_rcu_head_unqueue((struct rcu_head *)(bhead->records[i]));
+#endif
+}
+
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	raw_spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+static inline struct kvfree_rcu_bulk_data *
+get_cached_bnode(struct kfree_rcu_cpu *krcp)
+{
+	if (!krcp->nr_bkv_objs)
+		return NULL;
+
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
+	return (struct kvfree_rcu_bulk_data *)
+		llist_del_first(&krcp->bkvcache);
+}
+
+static inline bool
+put_cached_bnode(struct kfree_rcu_cpu *krcp,
+	struct kvfree_rcu_bulk_data *bnode)
+{
+	// Check the limit.
+	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
+		return false;
+
+	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
+	return true;
+}
+
+static int
+drain_page_cache(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	struct llist_node *page_list, *pos, *n;
+	int freed = 0;
+
+	if (!rcu_min_cached_objs)
+		return 0;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	page_list = llist_del_all(&krcp->bkvcache);
+	WRITE_ONCE(krcp->nr_bkv_objs, 0);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	llist_for_each_safe(pos, n, page_list) {
+		free_page((unsigned long)pos);
+		freed++;
+	}
+
+	return freed;
+}
+
+static void
+kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
+	struct kvfree_rcu_bulk_data *bnode, int idx)
+{
+	unsigned long flags;
+	int i;
+
+	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
+		debug_rcu_bhead_unqueue(bnode);
+		rcu_lock_acquire(&rcu_callback_map);
+		if (idx == 0) { // kmalloc() / kfree().
+			trace_rcu_invoke_kfree_bulk_callback(
+				"slab", bnode->nr_records,
+				bnode->records);
+
+			kfree_bulk(bnode->nr_records, bnode->records);
+		} else { // vmalloc() / vfree().
+			for (i = 0; i < bnode->nr_records; i++) {
+				trace_rcu_invoke_kvfree_callback(
+					"slab", bnode->records[i], 0);
+
+				vfree(bnode->records[i]);
+			}
+		}
+		rcu_lock_release(&rcu_callback_map);
+	}
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	if (put_cached_bnode(krcp, bnode))
+		bnode = NULL;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	if (bnode)
+		free_page((unsigned long) bnode);
+
+	cond_resched_tasks_rcu_qs();
+}
+
+static void
+kvfree_rcu_list(struct rcu_head *head)
+{
+	struct rcu_head *next;
+
+	for (; head; head = next) {
+		void *ptr = (void *) head->func;
+		unsigned long offset = (void *) head - ptr;
+
+		next = head->next;
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
+		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kvfree_callback("slab", head, offset);
+
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+			kvfree(ptr);
+
+		rcu_lock_release(&rcu_callback_map);
+		cond_resched_tasks_rcu_qs();
+	}
+}
+
+/*
+ * This function is invoked in workqueue context after a grace period.
+ * It frees all the objects queued on ->bulk_head_free or ->head_free.
+ */
+static void kfree_rcu_work(struct work_struct *work)
+{
+	unsigned long flags;
+	struct kvfree_rcu_bulk_data *bnode, *n;
+	struct list_head bulk_head[FREE_N_CHANNELS];
+	struct rcu_head *head;
+	struct kfree_rcu_cpu *krcp;
+	struct kfree_rcu_cpu_work *krwp;
+	struct rcu_gp_oldstate head_gp_snap;
+	int i;
+
+	krwp = container_of(to_rcu_work(work),
+		struct kfree_rcu_cpu_work, rcu_work);
+	krcp = krwp->krcp;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	// Channels 1 and 2.
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		list_replace_init(&krwp->bulk_head_free[i], &bulk_head[i]);
+
+	// Channel 3.
+	head = krwp->head_free;
+	krwp->head_free = NULL;
+	head_gp_snap = krwp->head_free_gp_snap;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	// Handle the first two channels.
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		// Start from the tail page, so a GP is likely passed for it.
+		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
+			kvfree_rcu_bulk(krcp, bnode, i);
+	}
+
+	/*
+	 * This is used when the "bulk" path can not be used for the
+	 * double-argument of kvfree_rcu().  This happens when the
+	 * page-cache is empty, which means that objects are instead
+	 * queued on a linked list through their rcu_head structures.
+	 * This list is named "Channel 3".
+	 */
+	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
+		kvfree_rcu_list(head);
+}
+
+static bool
+need_offload_krc(struct kfree_rcu_cpu *krcp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (!list_empty(&krcp->bulk_head[i]))
+			return true;
+
+	return !!READ_ONCE(krcp->head);
+}
+
+static bool
+need_wait_for_krwp_work(struct kfree_rcu_cpu_work *krwp)
+{
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		if (!list_empty(&krwp->bulk_head_free[i]))
+			return true;
+
+	return !!krwp->head_free;
+}
+
+static int krc_count(struct kfree_rcu_cpu *krcp)
+{
+	int sum = atomic_read(&krcp->head_count);
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		sum += atomic_read(&krcp->bulk_count[i]);
+
+	return sum;
+}
+
+static void
+__schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	long delay, delay_left;
+
+	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
+	if (delayed_work_pending(&krcp->monitor_work)) {
+		delay_left = krcp->monitor_work.timer.expires - jiffies;
+		if (delay < delay_left)
+			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+		return;
+	}
+	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+}
+
+static void
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	__schedule_delayed_monitor_work(krcp);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+}
+
+static void
+kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
+{
+	struct list_head bulk_ready[FREE_N_CHANNELS];
+	struct kvfree_rcu_bulk_data *bnode, *n;
+	struct rcu_head *head_ready = NULL;
+	unsigned long flags;
+	int i;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		INIT_LIST_HEAD(&bulk_ready[i]);
+
+		list_for_each_entry_safe_reverse(bnode, n, &krcp->bulk_head[i], list) {
+			if (!poll_state_synchronize_rcu_full(&bnode->gp_snap))
+				break;
+
+			atomic_sub(bnode->nr_records, &krcp->bulk_count[i]);
+			list_move(&bnode->list, &bulk_ready[i]);
+		}
+	}
+
+	if (krcp->head && poll_state_synchronize_rcu(krcp->head_gp_snap)) {
+		head_ready = krcp->head;
+		atomic_set(&krcp->head_count, 0);
+		WRITE_ONCE(krcp->head, NULL);
+	}
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		list_for_each_entry_safe(bnode, n, &bulk_ready[i], list)
+			kvfree_rcu_bulk(krcp, bnode, i);
+	}
+
+	if (head_ready)
+		kvfree_rcu_list(head_ready);
+}
+
+/*
+ * Return: %true if a work is queued, %false otherwise.
+ */
+static bool
+kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	bool queued = false;
+	int i, j;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+
+	// Attempt to start a new batch.
+	for (i = 0; i < KFREE_N_BATCHES; i++) {
+		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
+
+		// Try to detach bulk_head or head and attach it, only when
+		// all channels are free.  Any channel is not free means at krwp
+		// there is on-going rcu work to handle krwp's free business.
+		if (need_wait_for_krwp_work(krwp))
+			continue;
+
+		// kvfree_rcu_drain_ready() might handle this krcp, if so give up.
+		if (need_offload_krc(krcp)) {
+			// Channel 1 corresponds to the SLAB-pointer bulk path.
+			// Channel 2 corresponds to vmalloc-pointer bulk path.
+			for (j = 0; j < FREE_N_CHANNELS; j++) {
+				if (list_empty(&krwp->bulk_head_free[j])) {
+					atomic_set(&krcp->bulk_count[j], 0);
+					list_replace_init(&krcp->bulk_head[j],
+						&krwp->bulk_head_free[j]);
+				}
+			}
+
+			// Channel 3 corresponds to both SLAB and vmalloc
+			// objects queued on the linked list.
+			if (!krwp->head_free) {
+				krwp->head_free = krcp->head;
+				get_state_synchronize_rcu_full(&krwp->head_free_gp_snap);
+				atomic_set(&krcp->head_count, 0);
+				WRITE_ONCE(krcp->head, NULL);
+			}
+
+			// One work is per one batch, so there are three
+			// "free channels", the batch can handle. Break
+			// the loop since it is done with this CPU thus
+			// queuing an RCU work is _always_ success here.
+			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
+			WARN_ON_ONCE(!queued);
+			break;
+		}
+	}
+
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	return queued;
+}
+
+/*
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
+ */
+static void kfree_rcu_monitor(struct work_struct *work)
+{
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+
+	// Drain ready for reclaim.
+	kvfree_rcu_drain_ready(krcp);
+
+	// Queue a batch for a rest.
+	kvfree_rcu_queue_batch(krcp);
+
+	// If there is nothing to detach, it means that our job is
+	// successfully done here. In case of having at least one
+	// of the channels that is still busy we should rearm the
+	// work to repeat an attempt. Because previous batches are
+	// still in progress.
+	if (need_offload_krc(krcp))
+		schedule_delayed_monitor_work(krcp);
+}
+
+static void fill_page_cache_func(struct work_struct *work)
+{
+	struct kvfree_rcu_bulk_data *bnode;
+	struct kfree_rcu_cpu *krcp =
+		container_of(work, struct kfree_rcu_cpu,
+			page_cache_work.work);
+	unsigned long flags;
+	int nr_pages;
+	bool pushed;
+	int i;
+
+	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
+		1 : rcu_min_cached_objs;
+
+	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
+		bnode = (struct kvfree_rcu_bulk_data *)
+			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+
+		if (!bnode)
+			break;
+
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		pushed = put_cached_bnode(krcp, bnode);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+		if (!pushed) {
+			free_page((unsigned long) bnode);
+			break;
+		}
+	}
+
+	atomic_set(&krcp->work_in_progress, 0);
+	atomic_set(&krcp->backoff_page_cache_fill, 0);
+}
+
+// Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
+// state specified by flags.  If can_alloc is true, the caller must
+// be schedulable and not be holding any locks or mutexes that might be
+// acquired by the memory allocator or anything that it might invoke.
+// Returns true if ptr was successfully recorded, else the caller must
+// use a fallback.
+static inline bool
+add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
+	unsigned long *flags, void *ptr, bool can_alloc)
+{
+	struct kvfree_rcu_bulk_data *bnode;
+	int idx;
+
+	*krcp = krc_this_cpu_lock(flags);
+	if (unlikely(!(*krcp)->initialized))
+		return false;
+
+	idx = !!is_vmalloc_addr(ptr);
+	bnode = list_first_entry_or_null(&(*krcp)->bulk_head[idx],
+		struct kvfree_rcu_bulk_data, list);
+
+	/* Check if a new block is required. */
+	if (!bnode || bnode->nr_records == KVFREE_BULK_MAX_ENTR) {
+		bnode = get_cached_bnode(*krcp);
+		if (!bnode && can_alloc) {
+			krc_this_cpu_unlock(*krcp, *flags);
+
+			// __GFP_NORETRY - allows a light-weight direct reclaim
+			// what is OK from minimizing of fallback hitting point of
+			// view. Apart of that it forbids any OOM invoking what is
+			// also beneficial since we are about to release memory soon.
+			//
+			// __GFP_NOMEMALLOC - prevents from consuming of all the
+			// memory reserves. Please note we have a fallback path.
+			//
+			// __GFP_NOWARN - it is supposed that an allocation can
+			// be failed under low memory or high memory pressure
+			// scenarios.
+			bnode = (struct kvfree_rcu_bulk_data *)
+				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
+		}
+
+		if (!bnode)
+			return false;
+
+		// Initialize the new block and attach it.
+		bnode->nr_records = 0;
+		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
+	}
+
+	// Finally insert and update the GP for this page.
+	bnode->nr_records++;
+	bnode->records[bnode->nr_records - 1] = ptr;
+	get_state_synchronize_rcu_full(&bnode->gp_snap);
+	atomic_inc(&(*krcp)->bulk_count[idx]);
+
+	return true;
+}
+
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
+void __init kfree_rcu_scheduler_running(void)
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
+		__schedule_delayed_monitor_work(krcp);
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
+static unsigned long
+kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		count += krc_count(krcp);
+		count += READ_ONCE(krcp->nr_bkv_objs);
+		atomic_set(&krcp->backoff_page_cache_fill, 1);
+	}
+
+	return count == 0 ? SHRINK_EMPTY : count;
+}
+
+static unsigned long
+kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu, freed = 0;
+
+	for_each_possible_cpu(cpu) {
+		int count;
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		count = krc_count(krcp);
+		count += drain_page_cache(krcp);
+		kfree_rcu_monitor(&krcp->monitor_work.work);
+
+		sc->nr_to_scan -= count;
+		freed += count;
+
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+
+	return freed == 0 ? SHRINK_STOP : freed;
+}
+
+void __init kvfree_rcu_init(void)
+{
+	int cpu;
+	int i, j;
+	struct shrinker *kfree_rcu_shrinker;
+
+	/* Clamp it to [0:100] seconds interval. */
+	if (rcu_delay_page_cache_fill_msec < 0 ||
+		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
+
+		rcu_delay_page_cache_fill_msec =
+			clamp(rcu_delay_page_cache_fill_msec, 0,
+				(int) (100 * MSEC_PER_SEC));
+
+		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
+			rcu_delay_page_cache_fill_msec);
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			krcp->krw_arr[i].krcp = krcp;
+
+			for (j = 0; j < FREE_N_CHANNELS; j++)
+				INIT_LIST_HEAD(&krcp->krw_arr[i].bulk_head_free[j]);
+		}
+
+		for (i = 0; i < FREE_N_CHANNELS; i++)
+			INIT_LIST_HEAD(&krcp->bulk_head[i]);
+
+		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		krcp->initialized = true;
+	}
+
+	kfree_rcu_shrinker = shrinker_alloc(0, "slab-kvfree-rcu");
+	if (!kfree_rcu_shrinker) {
+		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
+		return;
+	}
+
+	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
+	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
+
+	shrinker_register(kfree_rcu_shrinker);
+}
-- 
2.39.5

