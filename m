Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D970C43461
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E272A6100C
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhDNMNB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhDNMNA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 08:13:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844BC061574;
        Wed, 14 Apr 2021 05:12:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r128so5790642lff.4;
        Wed, 14 Apr 2021 05:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4iCJgdePB52qaZOoJW1s5JwoorrHqL+LMPAVVU4+HY=;
        b=CpW2ijg5RIF0cGFcUDKAKAetngTMJkWVEUroYCzLOxOvHib+J5cZcelqZs4KQLPtfG
         VBhTxAUNK7g5o4bHoc5qMPmXsNoMlvWsf9YzK0t4R/B0CsMtSvIZiKA81XncpXtIAuZw
         KO1YkVELFQO31zuDr8ST+YwdbcTB0oWFKliYLvTL6e97eBdU7fqm+nMiFA/ymVyof4fv
         dQZ52sC7C1gudtpIGn5Vy362XmJO/dyhnC/7kbn3RKOE1Qhm5SeMylrt38uZ6vUr86DF
         YnqcL8VF11Du/tVRs0nLMhDvpAKiYB3riJ+dFLfJv4YAzdk7A8zMKnb35t5DNOPRKoEM
         /FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4iCJgdePB52qaZOoJW1s5JwoorrHqL+LMPAVVU4+HY=;
        b=X5sXZ/9Xnhlw1DQ6jr0mUk95SS8StrFN7qp5vo97j/NjSnNFuNeedjNmYn8ZPEjo6h
         hjR39BTx6Rb7OjOgmuQ43evk/sg7mXN3GyQe2GRgE1ItOOOZV46OVRgsfEA2UgV4T4xB
         Q6Up9ry4NxutbaJUQdgWAiniryANhDDn2M8/UEqJv+CzVGxGsWcd6GSO9mjo/Cs6YFi7
         YvY4sHXj1fElL2T/XOZwl0K/PShWafaxno5pqGtcyhaSQ8fH847hYSCkolw5r/AsNb2a
         5F1qciMl2gyA4av+CwZe9b6kt6cmT3powtJq+xfZZG8w0uPbCcmx01SqJGeZa0WfeSuy
         8OMA==
X-Gm-Message-State: AOAM530jXQGLqzAAs0tmpodWDIX2vMt+qT8VnBcm4dvW5kt7W4yqbM/Y
        blhJ/rAje6yUM+3Zmm4QvqXm52U76eEqfg==
X-Google-Smtp-Source: ABdhPJzzcPhCseOSu9c53QvHwjQ3dK5Byz8L8UsPAhu5kUGqtZmm4zg/+fO4vK0OGfkgh1ySITB8EQ==
X-Received: by 2002:a19:6109:: with SMTP id v9mr26834587lfb.331.1618402357163;
        Wed, 14 Apr 2021 05:12:37 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i4sm4338061lfu.33.2021.04.14.05.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:12:36 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 3/6] kvfree_rcu: introduce "flags" variable
Date:   Wed, 14 Apr 2021 14:12:23 +0200
Message-Id: <20210414121226.2650-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210414121226.2650-1-urezki@gmail.com>
References: <20210414121226.2650-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We have a few extra variables within kfree_rcu_cpu structure
which are control ones and behave as regular booleans. Instead
we can pack them into only one, define bit descriptions which
will represent an individual boolean state.

This reduces the size of the per-cpu kfree_rcu_cpu structure.
To access to the flags variable atomic bit operations are used.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 61 ++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1b0289fa1cdd..31ee820c3d9e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3139,6 +3139,24 @@ struct kfree_rcu_cpu_work {
 	struct kfree_rcu_cpu *krcp;
 };
 
+// The per-cpu kfree_rcu_cpu structure was initialized.
+// It is set only once when a system is up and running.
+#define KRC_INITIALIZED	0x1
+
+// Indicates that a page_cache_work has been initialized
+// and is about to be queued for execution. The flag is
+// cleared on exit of the worker function.
+#define KRC_CACHE_WORK_RUN	0x2
+
+// A page shrinker can ask for freeing extra pages to get
+// them available for other needs in a system. Usually it
+// happens under low memory condition, in that case hold
+// on a bit with page cache filling.
+#define KRC_DELAY_CACHE_FILL	0x4
+
+// Tracks whether a "monitor_work" delayed work is pending
+#define KRC_MONITOR_TODO	0x8
+
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
@@ -3146,17 +3164,14 @@ struct kfree_rcu_cpu_work {
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
- * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
- * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
+ * @flags: Atomic flags which describe different states
  * @bkvcache:
  *	A simple cache list that contains objects for reuse purpose.
  *	In order to save some per-cpu space the list is singular.
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
  * @page_cache_work: A work to refill the cache when it is empty
- * @backoff_page_cache_fill: Delay a cache filling
- * @work_in_progress: Indicates that page_cache_work is running
  * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
@@ -3171,13 +3186,10 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
-	bool monitor_todo;
-	bool initialized;
 	int count;
 
+	unsigned long flags;
 	struct delayed_work page_cache_work;
-	atomic_t backoff_page_cache_fill;
-	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
 	struct llist_head bkvcache;
@@ -3415,7 +3427,8 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
 	// Attempt to start a new batch.
-	krcp->monitor_todo = false;
+	clear_bit(KRC_MONITOR_TODO, &krcp->flags);
+
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3423,7 +3436,7 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 	}
 
 	// Previous RCU batch still in progress, try again later.
-	krcp->monitor_todo = true;
+	set_bit(KRC_MONITOR_TODO, &krcp->flags);
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
@@ -3439,7 +3452,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 						 monitor_work.work);
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
-	if (krcp->monitor_todo)
+	if (test_bit(KRC_MONITOR_TODO, &krcp->flags))
 		kfree_rcu_drain_unlock(krcp, flags);
 	else
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3466,7 +3479,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	bool pushed;
 	int i;
 
-	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
+	nr_pages = test_bit(KRC_DELAY_CACHE_FILL, &krcp->flags) ?
 		1 : rcu_min_cached_objs;
 
 	for (i = 0; i < nr_pages; i++) {
@@ -3485,16 +3498,16 @@ static void fill_page_cache_func(struct work_struct *work)
 		}
 	}
 
-	atomic_set(&krcp->work_in_progress, 0);
-	atomic_set(&krcp->backoff_page_cache_fill, 0);
+	clear_bit(KRC_CACHE_WORK_RUN, &krcp->flags);
+	clear_bit(KRC_DELAY_CACHE_FILL, &krcp->flags);
 }
 
 static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+			!test_and_set_bit(KRC_CACHE_WORK_RUN, &krcp->flags)) {
+		if (test_bit(KRC_DELAY_CACHE_FILL, &krcp->flags)) {
 			queue_delayed_work(system_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
@@ -3520,7 +3533,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	int idx;
 
 	*krcp = krc_this_cpu_lock(flags);
-	if (unlikely(!(*krcp)->initialized))
+	if (unlikely(!test_bit(KRC_INITIALIZED, &(*krcp)->flags)))
 		return false;
 
 	idx = !!is_vmalloc_addr(ptr);
@@ -3628,10 +3641,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-	    !krcp->monitor_todo) {
-		krcp->monitor_todo = true;
+			!test_and_set_bit(KRC_MONITOR_TODO, &krcp->flags))
 		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
-	}
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
@@ -3661,7 +3672,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 
 		count += READ_ONCE(krcp->count);
 		count += READ_ONCE(krcp->nr_bkv_objs);
-		atomic_set(&krcp->backoff_page_cache_fill, 1);
+		set_bit(KRC_DELAY_CACHE_FILL, &krcp->flags);
 	}
 
 	return count;
@@ -3681,7 +3692,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		count += drain_page_cache(krcp);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (krcp->monitor_todo)
+		if (test_bit(KRC_MONITOR_TODO, &krcp->flags))
 			kfree_rcu_drain_unlock(krcp, flags);
 		else
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3712,11 +3723,11 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || krcp->monitor_todo) {
+		if (!krcp->head || test_and_set_bit(KRC_MONITOR_TODO, &krcp->flags)) {
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
-		krcp->monitor_todo = true;
+
 		schedule_delayed_work_on(cpu, &krcp->monitor_work,
 					 KFREE_DRAIN_JIFFIES);
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -4655,7 +4666,7 @@ static void __init kfree_rcu_batch_init(void)
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
-		krcp->initialized = true;
+		set_bit(KRC_INITIALIZED, &krcp->flags);
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
 		pr_err("Failed to register kfree_rcu() shrinker!\n");
-- 
2.20.1

