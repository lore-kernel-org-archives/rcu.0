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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF65EC433B4
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6FB60FF3
	for <rcu@archiver.kernel.org>; Wed, 14 Apr 2021 12:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhDNMM6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhDNMM6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Apr 2021 08:12:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0354FC061574;
        Wed, 14 Apr 2021 05:12:37 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n138so32890029lfa.3;
        Wed, 14 Apr 2021 05:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKbRLJoDqZv6FU9vP3C4Wznok1ZQCQUcpdPyVp9b0EM=;
        b=ePxABEF554Kh12IFcitwJFHw8OgQfatpPxz2qTHdZA0qlvyvVC3a1GjOaxlRduj2oa
         1n9Yfv7+n+91s6fF/kfNADgeF9tgHKoU7c42PD3E+nXJ0/QXnbli7LVclp4zQdFU57Fb
         Fw4cMauexffEtlUz0kWuVyogJQMdOJ7Rz6Ukyhd9CIrzR5ufW3wXmVSR3LthfHzTy8dP
         KShqTBjhPUQqriBc41KRVl4l7CIaWw6IDI+mPUsoGZcWu4hJhYU6MElUYoVkLJ0xSkaz
         kXEZijTHu7TVvJG2wSYoWGG+/xv6+tSiCM541FgWkdKp3j2D2AOt+fkFiiLDC36b2fD8
         VcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKbRLJoDqZv6FU9vP3C4Wznok1ZQCQUcpdPyVp9b0EM=;
        b=Yrx6/vvaGnhdAASu059dtLT4X5tdUj9lIHNIhVGhLFp0GWRN6dbB+xsXJlmuGj0Mjh
         nrUi+0j1UBoIL/wyQLVJ/XDbiaoFYw5V0o07mzmGoUCgwskyrJriLe9owHRrBJU2ZR4N
         XZor3q6jU3nfotN8+vD/z5PhOkVip9AMQ0FFLjz02ZHo4cGbY0JHr7HsSgFlygVKDHMU
         otessuvRKrBUbQUW7GKjd1BYDTIgeZvOJBSaf0d1VzwlM+YjY6M8BuXmCmEY2AkwE5io
         HtV05uqsdHgIkHZSVvjvMcRF9x9yjGt67Va0Wlf9tAGmArbk3F1jHWNIVfC7ydI/zxXT
         X6Tg==
X-Gm-Message-State: AOAM530o7rD+PUTu+abSh8CmIyJfMx+OORGnLNyYMW7hS94WVuwots/X
        8huFSLIvsfsxdLaAxCxRhI1lkdYugMo0tw==
X-Google-Smtp-Source: ABdhPJzW8j2k8Eu3l0gqSAkhrBB15VjWKh5lhHg9xIwNX7R38qW04wBW8bSlbE+R8ap/YWseKuKDWg==
X-Received: by 2002:ac2:5fa2:: with SMTP id s2mr26097207lfe.486.1618402355444;
        Wed, 14 Apr 2021 05:12:35 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id i4sm4338061lfu.33.2021.04.14.05.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:12:35 -0700 (PDT)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Zhang Qiang <qiang.zhang@windriver.com>
Subject: [PATCH 1/6] kvfree_rcu: Release a page cache under memory pressure
Date:   Wed, 14 Apr 2021 14:12:21 +0200
Message-Id: <20210414121226.2650-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Add a drain_page_cache() function to drain a per-cpu page cache.
The reason behind of it is a system can run into a low memory
condition, in that case a page shrinker can ask for its users
to free their caches in order to get extra memory available for
other needs in a system.

When a system hits such condition, a page cache is drained for
all CPUs in a system. By default a page cache work is delayed
with 5 seconds interval until a memory pressure disappears, if
needed it can be changed. See a rcu_delay_page_cache_fill_msec
module parameter.

Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 70 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c9cf4df942c..8b74edcd11d4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -186,6 +186,17 @@ module_param(rcu_unlock_delay, int, 0444);
 static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 
+// A page shrinker can ask for freeing extra pages to get them
+// available for other needs in a system. Usually it happens
+// under low memory condition, in that case we should hold on
+// a bit with page cache filling.
+//
+// Default value is 5 seconds. That is long enough to reduce
+// an interfering and racing with a shrinker where the cache
+// is drained.
+static int rcu_delay_page_cache_fill_msec = 5000;
+module_param(rcu_delay_page_cache_fill_msec, int, 0444);
+
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -3144,6 +3155,7 @@ struct kfree_rcu_cpu_work {
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
  * @page_cache_work: A work to refill the cache when it is empty
+ * @backoff_page_cache_fill: Delay a cache filling
  * @work_in_progress: Indicates that page_cache_work is running
  * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
@@ -3163,7 +3175,8 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
+	atomic_t backoff_page_cache_fill;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
@@ -3229,6 +3242,26 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 }
 
+static int
+drain_page_cache(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	struct llist_node *page_list, *pos, *n;
+	int freed = 0;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	page_list = llist_del_all(&krcp->bkvcache);
+	krcp->nr_bkv_objs = 0;
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
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3419,7 +3452,7 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
 	return HRTIMER_NORESTART;
 }
 
@@ -3428,12 +3461,16 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
+	int nr_pages;
 	bool pushed;
 	int i;
 
-	for (i = 0; i < rcu_min_cached_objs; i++) {
+	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
+		1 : rcu_min_cached_objs;
+
+	for (i = 0; i < nr_pages; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
@@ -3450,6 +3487,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	}
 
 	atomic_set(&krcp->work_in_progress, 0);
+	atomic_set(&krcp->backoff_page_cache_fill, 0);
 }
 
 static void
@@ -3457,10 +3495,15 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-		krcp->hrtimer.function = schedule_page_work_fn;
-		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+			queue_delayed_work(system_wq,
+				&krcp->page_cache_work,
+					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
 	}
 }
 
@@ -3612,12 +3655,19 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
+	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
+
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		count += krcp->nr_bkv_objs;
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
 	return count;
@@ -3634,6 +3684,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += drain_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
@@ -4608,7 +4660,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.20.1

