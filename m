Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE132C54FCE
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B614206F9
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W15SZMFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgCWLgg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43450 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgCWLgf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id g27so5309084ljn.10;
        Mon, 23 Mar 2020 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mOVjkq/uh3qqnXdTMiFS5Ce0Kz/BKSeK32jdxLnDdmY=;
        b=W15SZMFv5MAL2no30hPQVvtLVj9D7JqjEbgvg1qks5jVLt94FqWxtuyFTTLKhbTSms
         J7pFwVHlTRxIA8cQKgI8RUZwrWgp6UB8O4IJHehwNuPRL3kRL/yt9o1k5qIgJ2ptSoTV
         ABT0Kohv8CfR7/p7VnMheIT/Z6q6RXhgGjmf1EDYta7eh/TZ9W5qG7eqMgJEGr1fBrkn
         fq0C/zQAFsSscoOBvfLRavwIVv318Ypi3wotN/X6PbpExAaSgBJl0MuOXGRaaXeg+1bZ
         6O84BSmL2nSTXX3XObYY8fXFN0EP0hlCrGaxrTjSrW+XA2NiaSFU3vnRs84PmeLve6XD
         g9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mOVjkq/uh3qqnXdTMiFS5Ce0Kz/BKSeK32jdxLnDdmY=;
        b=rM6/6/G/BEm+7AUmyy6SRYLMLdBx60SzkqI34LIFGzAicZ0naudNp20mAG8vM9acJp
         qoW81yV0+d6YVHapVPB/WAMBU+9IEXeCgi4OFwnjH38tIKIqLkuFBvHCuDvoJ4Squ6wZ
         H6T5gSjh1HF8i6Sk8Kp9Ugz/W37/xAbYvJT6gDrfTO24wL1qH14AKbLzexLqKXIA2Ehp
         u8+gOcdJ/HmImQSorNdTrS720d6A99DPNj5HXONPEueLs9zb9bQ5lwRvNP7PP2De3q1A
         MYzUyaBmmvMRkx6sMtxD4n7Lzj8cm3vt38ezlqiY+4nUqHuM0E035LmEvPNzQOlVBMQw
         GPEQ==
X-Gm-Message-State: ANhLgQ3JO0XHioHGMGVwJwgUfRNwvgCNgGLKoU6PCULwGplX2m2T0mJe
        h2w/alKyD8v2YTobP+tw70ItFVT5dlM=
X-Google-Smtp-Source: ADFU+vvyJy3+DXXvQ/bIsN1JfdJQ84qO6t1OFLNMk/WKUkOO1qLA2WQq+kOSiL/r1I2yxZl6UGR6IA==
X-Received: by 2002:a2e:8350:: with SMTP id l16mr13012205ljh.202.1584963392176;
        Mon, 23 Mar 2020 04:36:32 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:31 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/7] rcu/tree: maintain separate array for vmalloc ptrs
Date:   Mon, 23 Mar 2020 12:36:16 +0100
Message-Id: <20200323113621.12048-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
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
---
 kernel/rcu/tree.c | 179 ++++++++++++++++++++++++++++------------------
 1 file changed, 108 insertions(+), 71 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 49ba1ff50af5..20d08eca7006 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2741,38 +2741,36 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_N_BATCHES 2
 
 /**
- * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
+ * struct kvfree_rcu_bulk_data - single block to store kvfree() pointers
  * @nr_records: Number of active pointers in the array
- * @records: Array of the kfree_rcu() pointers
  * @next: Next bulk object in the block chain
- * @head_free_debug: For debug, when CONFIG_DEBUG_OBJECTS_RCU_HEAD is set
+ * @records: Array of the SLAB pointers
  */
-struct kfree_rcu_bulk_data {
+struct kvfree_rcu_bulk_data {
 	unsigned long nr_records;
-	void *records[KFREE_BULK_MAX_ENTR];
-	struct kfree_rcu_bulk_data *next;
+	struct kvfree_rcu_bulk_data *next;
+	void *records[];
 };
 
 /*
  * This macro defines how many entries the "records" array
  * will contain. It is based on the fact that the size of
- * kfree_rcu_bulk_data structure becomes exactly one page.
+ * kvfree_rcu_bulk_data become exactly one page.
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
+ * @bkvhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
-
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
-	struct kfree_rcu_bulk_data *bhead_free;
+	struct kvfree_rcu_bulk_data *bkvhead_free[2];
 	struct kfree_rcu_cpu *krcp;
 };
 
@@ -2794,8 +2792,9 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
-	struct kfree_rcu_bulk_data *bhead;
-	struct kfree_rcu_bulk_data *bcached;
+	struct kvfree_rcu_bulk_data *bkvhead[2];
+	struct kvfree_rcu_bulk_data *bkvcache[2];
+
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2808,7 +2807,7 @@ struct kfree_rcu_cpu {
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 static __always_inline void
-debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
+debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 {
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 	for (int i = 0; i < bhead->nr_records; i++)
@@ -2823,45 +2822,77 @@ debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
+	struct kvfree_rcu_bulk_data *bkhead, *bknext;
+	struct kvfree_rcu_bulk_data *bvhead, *bvnext;
 	struct rcu_head *head, *next;
-	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	int i;
 
 	krwp = container_of(to_rcu_work(work),
-			    struct kfree_rcu_cpu_work, rcu_work);
+				struct kfree_rcu_cpu_work, rcu_work);
+
 	krcp = krwp->krcp;
 	spin_lock_irqsave(&krcp->lock, flags);
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
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
-	/* "bhead" is now private, so traverse locklessly. */
-	for (; bhead; bhead = bnext) {
-		bnext = bhead->next;
+	/* kmalloc()/kfree() channel. */
+	for (; bkhead; bkhead = bknext) {
+		bknext = bkhead->next;
 
-		debug_rcu_bhead_unqueue(bhead);
+		debug_rcu_bhead_unqueue(bkhead);
 
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
-			bhead->nr_records, bhead->records);
+			bkhead->nr_records, bkhead->records);
+
+		kfree_bulk(bkhead->nr_records, bkhead->records);
+		rcu_lock_release(&rcu_callback_map);
+
+		if (cmpxchg(&krcp->bkvcache[0], NULL, bkhead))
+			free_page((unsigned long) bkhead);
+
+		cond_resched_tasks_rcu_qs();
+	}
+
+	/* vmalloc()/vfree() channel. */
+	for (; bvhead; bvhead = bvnext) {
+		bvnext = bvhead->next;
+
+		debug_rcu_bhead_unqueue(bvhead);
 
-		kfree_bulk(bhead->nr_records, bhead->records);
+		rcu_lock_acquire(&rcu_callback_map);
+		for (i = 0; i < bvhead->nr_records; i++) {
+			trace_rcu_invoke_kvfree_callback(rcu_state.name,
+				(struct rcu_head *) bvhead->records[i], 0);
+			vfree(bvhead->records[i]);
+		}
 		rcu_lock_release(&rcu_callback_map);
 
-		if (cmpxchg(&krcp->bcached, NULL, bhead))
-			free_page((unsigned long) bhead);
+		if (cmpxchg(&krcp->bkvcache[1], NULL, bvhead))
+			free_page((unsigned long) bvhead);
 
 		cond_resched_tasks_rcu_qs();
 	}
 
 	/*
-	 * We can end up here either with 1) vmalloc() pointers or 2) were low
-	 * on memory and could not allocate a bulk array. It can happen under
-	 * low memory condition when an allocation gets failed, so the "bulk"
-	 * path can not be temporarly used.
+	 * This path covers emergency case only due to high
+	 * memory pressure also means low memory condition,
+	 * when we could not allocate a bulk array.
+	 *
+	 * Under that condition an object is queued to the
+	 * list instead.
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
@@ -2898,21 +2929,34 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
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
+			}
+
+			/*
+			 * Channel 2 corresponds to vmalloc ptrs.
+			 */
+			if (!krwp->bkvhead_free[1]) {
+				krwp->bkvhead_free[1] = krcp->bkvhead[1];
+				krcp->bkvhead[1] = NULL;
 			}
 
-			/* Channel 2. */
+			/*
+			 * Channel 3 corresponds to emergency path.
+			 */
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
@@ -2921,10 +2965,11 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
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
 			queued = true;
@@ -2969,26 +3014,25 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
+	idx = !is_vmalloc_addr(ptr) ? 0:1;
 
 	/* Check if a new block is required. */
-	if (!krcp->bhead ||
-			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
-		bnode = xchg(&krcp->bcached, NULL);
-		if (!bnode) {
-			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
-
-			bnode = (struct kfree_rcu_bulk_data *)
+	if (!krcp->bkvhead[idx] ||
+			krcp->bkvhead[idx]->nr_records ==
+				KVFREE_BULK_MAX_ENTR) {
+		bnode = xchg(&krcp->bkvcache[idx], NULL);
+		if (!bnode)
+			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-		}
 
 		/* Switch to emergency path. */
 		if (unlikely(!bnode))
@@ -2996,30 +3040,30 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 
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
- * Queue a request for lazy invocation of kfree_bulk()/kvfree() after a grace
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
  * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
  * be free'd in workqueue context. This allows us to: batch requests together to
- * reduce the number of grace periods during heavy kfree_rcu() load.
+ * reduce the number of grace periods during heavy kfree_rcu()/kvfree_rcu() load.
  */
 void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -3043,17 +3087,10 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	/*
-	 * We do not queue vmalloc pointers into array,
-	 * instead they are just queued to the list. We
-	 * do it because of:
-	 *    a) to distinguish kmalloc()/vmalloc() ptrs;
-	 *    b) there is no vmalloc_bulk() interface.
-	 *
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (is_vmalloc_addr(ptr) ||
-	    !kfree_call_rcu_add_ptr_to_bulk(krcp, head, func)) {
+	if (!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr)) {
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
-- 
2.20.1

