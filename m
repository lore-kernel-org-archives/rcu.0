Return-Path: <SRS0=Bg9d=3J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35345C2D0DB
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9B822464
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMYX0rKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgATOmj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:42:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41305 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATOmj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 09:42:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so34083384ljc.8;
        Mon, 20 Jan 2020 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuCPjIVPwcrq+ejNC/mrcjXihMtSSCgSjfEso6fmOgw=;
        b=GMYX0rKrBuOIbsX9Hj7I2TPBsGS5soBaFUShh9DHy63Ed9+M+9qi1S0Zz0I55KCm/a
         zAv4GebxFWD9IrXvskxGnHIzGosCs2B/gTnsz7tfXAObjnB9q/nsL5Mowcet+CxZim/W
         kQYLyJo/MliJ3yeCpxmgDav86PYlHprAJP6r3oANPaeu4YH19U/s10rdT8yWsUAkLrs2
         uk4RWVh64gHL89xlPds3JYyRoWcNAF6tIePoWUsllokQPYXYQ9KqNsTCPNhbG8BnBI04
         p3Dv63nG5Qonl/C43LhxK6ty9dnaz7HdBERXT0PLcIlH5irmhPPWcocvU/qY4R0wCMzo
         XaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuCPjIVPwcrq+ejNC/mrcjXihMtSSCgSjfEso6fmOgw=;
        b=RQbomFFP23yeD8Wb4Qgwstdw/F36hgvyd7/QfowY/yDSrF8We9gUj6NYcjFilT3QXC
         t4rufJM34n1fzflXSOJZvCjhh5Bk5/i1ynw3fi1UtFCasiOFdk/gEi7/X6rCgQBdTjWi
         WulE4iNf2nWxDbeUQ95A5lQjsBnZvG01CkLoVT/i5z/qA6hThctAPGqT3UNEwYh8zVvU
         jQY70z1FyqK9g03UZxFrIR9awkpM37F0vj4Pe5JUo8+ULdV64ImXUvzszISzK61WHN9P
         wmPIsoT1Nh7SIj+WFtbW2rAD/XiX3nY73GTiPA/WwWcM8QLr/XRjlmWY3cZ6lNvT3PE5
         tftw==
X-Gm-Message-State: APjAAAVTF32+p/omxUUMmIcTfSItB/cH48gEYm0YhjXanvb68KFiPEjQ
        M3VOtRabJsGhuiDy39zwG39MFK2CYHFmNg==
X-Google-Smtp-Source: APXvYqw3c0rbEiDx/6fCULLJbd9OkoCvIWH9HtM2dmrUuJXhqPMrpvdKeHqI376dvhwwW95qzd870Q==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr13768730ljo.86.1579531354537;
        Mon, 20 Jan 2020 06:42:34 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id 21sm16945432ljv.19.2020.01.20.06.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:42:34 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [v2 PATCH 1/2] rcu/tree: support kfree_bulk() interface in kfree_rcu()
Date:   Mon, 20 Jan 2020 15:42:25 +0100
Message-Id: <20200120144226.27538-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120144226.27538-1-urezki@gmail.com>
References: <20200120144226.27538-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

kfree_rcu() logic can be improved further by using kfree_bulk()
interface along with "basic batching support" introduced earlier.

The are at least two advantages of using "bulk" interface:
- in case of large number of kfree_rcu() requests kfree_bulk()
  reduces the per-object overhead caused by calling kfree()
  per-object.

- reduces the number of cache-misses due to "pointer chasing"
  between objects which can be far spread between each other.

This approach defines a new kfree_rcu_bulk_data structure that
stores pointers in an array with a specific size. Number of entries
in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
structure to be exactly one page.

Since it deals with "block-chain" technique there is an extra
need in dynamic allocation when a new block is required. Memory
is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
allows to skip direct reclaim under low memory condition to
prevent stalling and fails silently under high memory pressure.

The "emergency path" gets maintained when a system is run out
of memory. In that case objects are linked into regular list
and that is it.

In order to evaluate it, the "rcuperf" was run to analyze how
much memory is consumed and what is kfree_bulk() throughput.

1) Testing on the Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz, 12xCPUs
with following parameters:

kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1 kfree_vary_obj_size=1
dev.2020.01.10a branch

Default / CONFIG_SLAB
53607352517 ns, loops: 200000, batches: 1885, memory footprint: 1248MB
53529637912 ns, loops: 200000, batches: 1921, memory footprint: 1193MB
53570175705 ns, loops: 200000, batches: 1929, memory footprint: 1250MB

Patch / CONFIG_SLAB
23981587315 ns, loops: 200000, batches: 810, memory footprint: 1219MB
23879375281 ns, loops: 200000, batches: 822, memory footprint: 1190MB
24086841707 ns, loops: 200000, batches: 794, memory footprint: 1380MB

Default / CONFIG_SLUB
51291025022 ns, loops: 200000, batches: 1713, memory footprint: 741MB
51278911477 ns, loops: 200000, batches: 1671, memory footprint: 719MB
51256183045 ns, loops: 200000, batches: 1719, memory footprint: 647MB

Patch / CONFIG_SLUB
50709919132 ns, loops: 200000, batches: 1618, memory footprint: 456MB
50736297452 ns, loops: 200000, batches: 1633, memory footprint: 507MB
50660403893 ns, loops: 200000, batches: 1628, memory footprint: 429MB

in case of CONFIG_SLAB there is double increase in performance and
slightly higher memory usage. As for CONFIG_SLUB, the performance
figures are better together with lower memory usage.

2) Testing on the HiKey-960, arm64, 8xCPUs with below parameters:

CONFIG_SLAB=y
kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1

102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB

rcuperf shows approximately ~12% better throughput in case of
using "bulk" interface. The "drain logic" or its RCU callback
does the work faster that leads to better throughput.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 204 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 169 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7e0048cd6389..27cb536d25bb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2755,22 +2755,47 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
+
+/**
+ * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
+ * @nr_records: Number of active pointers in the array
+ * @records: Array of the kfree_rcu() pointers
+ * @next: Next bulk object in the block chain
+ * @head_free_debug: For debug, when CONFIG_DEBUG_OBJECTS_RCU_HEAD is set
+ */
+struct kfree_rcu_bulk_data {
+	unsigned long nr_records;
+	void *records[KFREE_BULK_MAX_ENTR];
+	struct kfree_rcu_bulk_data *next;
+	struct rcu_head *head_free_debug;
+};
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
+	struct kfree_rcu_bulk_data *bhead_free;
 	struct kfree_rcu_cpu *krcp;
 };
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
+ * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2784,6 +2809,8 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
+	struct kfree_rcu_bulk_data *bhead;
+	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2793,14 +2820,24 @@ struct kfree_rcu_cpu {
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
+static __always_inline void
+debug_rcu_head_unqueue_bulk(struct rcu_head *head)
+{
+#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
+	for (; head; head = head->next)
+		debug_rcu_head_unqueue(head);
+#endif
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->head_free.
+ * It frees all the objects queued on ->bhead_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
+	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
 
@@ -2810,22 +2847,41 @@ static void kfree_rcu_work(struct work_struct *work)
 	spin_lock_irqsave(&krcp->lock, flags);
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	bhead = krwp->bhead_free;
+	krwp->bhead_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// List "head" is now private, so traverse locklessly.
+	/* "bhead" is now private, so traverse locklessly. */
+	for (; bhead; bhead = bnext) {
+		bnext = bhead->next;
+
+		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+
+		rcu_lock_acquire(&rcu_callback_map);
+		kfree_bulk(bhead->nr_records, bhead->records);
+		rcu_lock_release(&rcu_callback_map);
+
+		if (cmpxchg(&krcp->bcached, NULL, bhead))
+			free_page((unsigned long) bhead);
+
+		cond_resched_tasks_rcu_qs();
+	}
+
+	/*
+	 * Emergency case only. It can happen under low memory
+	 * condition when an allocation gets failed, so the "bulk"
+	 * path can not be temporary maintained.
+	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
 
 		next = head->next;
-		// Potentially optimize with kfree_bulk in future.
 		debug_rcu_head_unqueue(head);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
-			/* Could be optimized with kfree_bulk() in future. */
+		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kfree((void *)head - offset);
-		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -2840,26 +2896,48 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	struct kfree_rcu_cpu_work *krwp;
+	bool queued = false;
 	int i;
-	struct kfree_rcu_cpu_work *krwp = NULL;
 
 	lockdep_assert_held(&krcp->lock);
-	for (i = 0; i < KFREE_N_BATCHES; i++)
-		if (!krcp->krw_arr[i].head_free) {
-			krwp = &(krcp->krw_arr[i]);
-			break;
-		}
 
-	// If a previous RCU batch is in progress, we cannot immediately
-	// queue another one, so return false to tell caller to retry.
-	if (!krwp)
-		return false;
+	for (i = 0; i < KFREE_N_BATCHES; i++) {
+		krwp = &(krcp->krw_arr[i]);
 
-	krwp->head_free = krcp->head;
-	krcp->head = NULL;
-	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krwp->rcu_work);
-	return true;
+		/*
+		 * Try to detach bhead or head and attach it over any
+		 * available corresponding free channel. It can be that
+		 * a previous RCU batch is in progress, it means that
+		 * immediately to queue another one is not possible so
+		 * return false to tell caller to retry.
+		 */
+		if ((krcp->bhead && !krwp->bhead_free) ||
+				(krcp->head && !krwp->head_free)) {
+			/* Channel 1. */
+			if (!krwp->bhead_free) {
+				krwp->bhead_free = krcp->bhead;
+				krcp->bhead = NULL;
+			}
+
+			/* Channel 2. */
+			if (!krwp->head_free) {
+				krwp->head_free = krcp->head;
+				krcp->head = NULL;
+			}
+
+			/*
+			 * One work is per one batch, so there are two "free channels",
+			 * "bhead_free" and "head_free" the batch can handle. It can be
+			 * that the work is in the pending state when two channels have
+			 * been detached following each other, one by one.
+			 */
+			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queued = true;
+		}
+	}
+
+	return queued;
 }
 
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
@@ -2896,19 +2974,65 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static inline bool
+kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
+	struct rcu_head *head, rcu_callback_t func)
+{
+	struct kfree_rcu_bulk_data *bnode;
+
+	if (unlikely(!krcp->initialized))
+		return false;
+
+	lockdep_assert_held(&krcp->lock);
+
+	/* Check if a new block is required. */
+	if (!krcp->bhead ||
+			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
+		bnode = xchg(&krcp->bcached, NULL);
+		if (!bnode) {
+			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
+
+			bnode = (struct kfree_rcu_bulk_data *)
+				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+		}
+
+		/* Switch to emergency path. */
+		if (unlikely(!bnode))
+			return false;
+
+		/* Initialize the new block. */
+		bnode->nr_records = 0;
+		bnode->next = krcp->bhead;
+		bnode->head_free_debug = NULL;
+
+		/* Attach it to the head. */
+		krcp->bhead = bnode;
+	}
+
+#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
+	head->func = func;
+	head->next = krcp->bhead->head_free_debug;
+	krcp->bhead->head_free_debug = head;
+#endif
+
+	/* Finally insert. */
+	krcp->bhead->records[krcp->bhead->nr_records++] =
+		(void *) head - (unsigned long) func;
+
+	return true;
+}
+
 /*
- * Queue a request for lazy invocation of kfree() after a grace period.
+ * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
+ * period. Please note there are two paths are maintained, one is the main one
+ * that uses kfree_bulk() interface and second one is emergency one, that is
+ * used only when the main path can not be maintained temporary, due to memory
+ * pressure.
  *
  * Each kfree_call_rcu() request is added to a batch. The batch will be drained
- * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
- * will be kfree'd in workqueue context. This allows us to:
- *
- * 1.	Batch requests together to reduce the number of grace periods during
- *	heavy kfree_rcu() load.
- *
- * 2.	It makes it possible to use kfree_bulk() on a large number of
- *	kfree_rcu() requests thus reducing cache misses and the per-object
- *	overhead of kfree().
+ * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
+ * be free'd in workqueue context. This allows us to: batch requests together to
+ * reduce the number of grace periods during heavy kfree_rcu() load.
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -2927,9 +3051,16 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 		goto unlock_return;
 	}
-	head->func = func;
-	head->next = krcp->head;
-	krcp->head = head;
+
+	/*
+	 * Under high memory pressure GFP_NOWAIT can fail,
+	 * in that case the emergency path is maintained.
+	 */
+	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+		head->func = func;
+		head->next = krcp->head;
+		krcp->head = head;
+	}
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -3835,8 +3966,11 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_init(&krcp->lock);
-		for (i = 0; i < KFREE_N_BATCHES; i++)
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
+		}
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
-- 
2.20.1

