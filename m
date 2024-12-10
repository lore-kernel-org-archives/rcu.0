Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071322FE17;
	Tue, 10 Dec 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848845; cv=none; b=CkE8zZ9Ko7y/CyBF8HCRmgjuKfx19kNMjiOdwORQpz14RIDUAvGpHzo4uxqo223yLUyPE2oycXrxzgeUJxT4L3IZy5uGqPBSWfZMB0XbJrI/1L9+s4ptPW4ACEaNu1PJq/mzluHjdexhGCGvHo4Km/uqN/X2eIR5/TnGgS6HNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848845; c=relaxed/simple;
	bh=JcJp/kjpV8uX8ed5/eGkNqXQaPsJfJogE2GsATef6rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o54AbWiSgtMn3TnxEGuB5NsSrPqTx/VqFQxyM1wcNSnU9L4QvC1JtpMZWV//uo5VH2ouqNdwkXjLZbNBpH+yz0xkt2fLPgBRnAwaSNNcJLulesIg0gfmEDBF19bB/0WgH4MRNybPmWr1m0Flexs5mTTathuuD2i94AaOQqW8GUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drjAHxoh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drjAHxoh"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-540201cfedbso2024829e87.3;
        Tue, 10 Dec 2024 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848841; x=1734453641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvLl1/wUXAtZR/OsurduIKqJhQ3HiLLZga1zIHvCWGI=;
        b=drjAHxohUQJ2lDAITrV5THxv2qShkOV0JhRSZ6PpDfMXbKnWGRAT6gOI1WIBrFGOZs
         l4hiaa7dYVeR0j/O1OCli0bi9xMIRDAQiW0hcO14ivzAgwhMqIMGRxxo65TqYM3edo8z
         FROV+FK88a73yYax+i/jqI+dthDZBvqdAR7QsZDXbkuEla0bngPGOKbNTTIpCNbm3TxZ
         5IwRiJKZgxqceiJdRhDcJmcji1VCZrAAnGuzwQg1qowFwBaJNvS69w0xhAOq6gDBiWID
         hblYZv33WC4DniJnfI7mSI5cZBSnPONS2V1SjpnhLDPb8YAJlGAuFFO5J0A3kJ0FYOMj
         KPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848841; x=1734453641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvLl1/wUXAtZR/OsurduIKqJhQ3HiLLZga1zIHvCWGI=;
        b=JOEFEX0rlklpMxc6Tv1xTMrYJrz6UmZhMUAWbyU3AQCI5sN7n+UZbY/nHT9LEnAVpA
         z3cYZEu8Wvx7DhBeAUOUtfW9x9w2GT9YxUeX9zJU9gMMUWA+h/nZaofcqWhZNz93xuhK
         1ZCpr2CDzAYh92w4FVe7ImluyL8lw3ifdua9CSRniJfpSzre03jqJ4C/ogkBk3IrIHsm
         Zp/iOWHf4qRzW4475fBgNn5/CmXX822+7M5f3+R1REpqzVWXs1bYnqKWW0GaF1dSfo+H
         5FXwLI0iBkqYOanB64VVyuL5+ChJdtR+SHPJo2c17pByy2xl+8IyNF5eznOCRpCmWCip
         B1gA==
X-Forwarded-Encrypted: i=1; AJvYcCVu31PseQ76SF4zzIJB+NBpfM+qicXP6Wmsl/2NE1POuS1bSFbommknZ+k8AEuQL0m9GEc0rXGBLpHGdGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDNNRtPYwFe9GhgzpIC8DfR2kATfQE5ea97+8S+6fZviGU/J/
	2nRPbLQDIcs9wLRmmeFcor4NbpRfxqYNFgk4t8LUFBykbJ9oD0SP
X-Gm-Gg: ASbGncsPaNezW/YFTICyZgrc507B6Do0IULgoZBIJxuItkQlaa6k2rayU85Xv7vad1Q
	uxixFlDH/Kb0aFd+C4XEqOsGFt50oxyzEMRHiAAx9xb0LXff5a4tVlPUcM+3eCJHqKqthpAwTgv
	XwMBrtA2Sfo5wv2GxYwQqogdnsJQf2ZCUXJhFrkll/fJwR91WFCbZ2KhSrXUzejiJcNf1wcl6Ds
	hqEgGPjyhBJcPnfhXRiKzKosJHNzLW97TEMFx0AwoF8IxKZzA==
X-Google-Smtp-Source: AGHT+IEEONV/UlxxlrdyYro3lAWzK8q69rAAkBvPwN5AeuK8TFPXVq4XWd7GAu8I2w2bCJc4ds24Ug==
X-Received: by 2002:ac2:42c6:0:b0:540:2542:cba6 with SMTP id 2adb3069b0e04-5402542cde0mr971031e87.21.1733848840603;
        Tue, 10 Dec 2024 08:40:40 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93377eefsm1031875e87.67.2024.12.10.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:40:39 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [RFC v1 3/5] mm/slab: Copy internal functions of kvfree_rcu()
Date: Tue, 10 Dec 2024 17:40:33 +0100
Message-Id: <20241210164035.3391747-4-urezki@gmail.com>
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

Copy main functions of kvfree_rcu() from the kernel/rcu/tree.c
to the slab_common.c file. In order to prevent a compiler warnings
about defined but not used functions, below ones:

run_page_cache_worker()
fill_page_cache_func()
kfree_rcu_monitor()
kfree_rcu_work()
drain_page_cache()

are temporary marked as "__maybe_unused" in the slab_common.c file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/slab_common.c | 507 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 507 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a249fdb0d92e..e7e1d5b5f31b 100644
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
 
@@ -1433,3 +1435,508 @@ struct kfree_rcu_cpu {
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
+
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
+static int __maybe_unused
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
+static void __maybe_unused
+kfree_rcu_work(struct work_struct *work)
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
+schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
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
+static void __maybe_unused
+kfree_rcu_monitor(struct work_struct *work)
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
+static void __maybe_unused
+fill_page_cache_func(struct work_struct *work)
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
+static void __maybe_unused
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
-- 
2.39.5

