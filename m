Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912D6C43460
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788506192B
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEKW40 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhEKW4Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7527C6191D;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=7liwfk1tesTs4HZiYfFEJ1nyjgE8X6W4bnix9glgAs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oo7MCK+nLj9lGzBB9uQDnLrePLHh3qtgAhzBrRv646x7N4PU3QXgqet1dgih4au1/
         Z0WEGqmYcp53+4HxQdz2tHw3UFfXqS1EbwpFHRGH+Jp7K1tN3JBuAgOZ0p2kzJ41V7
         RFM4lfWny43x4FYKyOmV5nDJF5k6SfpTvjzzWfOLjiRHxsaHdyLo1S4ftNpbMb/DzL
         0lY+drFSVQ9CmifIXe30nbFuGdfWCVlp10R7SaPuyc8LYvRZf1oihbEZJoUZuRxkua
         zF7BsgjHeUNsZ4iskgtfAzjBx/Tggh0V2PIxNiXF+aYGVHiRBfvDrkzGWr8zJeXpfE
         U6jRFVw5QzqXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0645C5C0138; Tue, 11 May 2021 15:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/7] kvfree_rcu: Release a page cache under memory pressure
Date:   Tue, 11 May 2021 15:55:10 -0700
Message-Id: <20210511225516.2893420-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/rcu/tree.c                             | 82 +++++++++++++++++--
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..4405fd32e8ab 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4290,6 +4290,11 @@
 			whole algorithm to behave better in low memory
 			condition.
 
+	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
+			Set the page-cache refill delay (in milliseconds)
+			in response to low-memory conditions.  The range
+			of permitted values is in the range 0:100000.
+
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b2430c16..74d840aa877b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -186,6 +186,17 @@ module_param(rcu_unlock_delay, int, 0444);
 static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 
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
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -3171,6 +3182,7 @@ struct kfree_rcu_cpu_work {
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
  * @page_cache_work: A work to refill the cache when it is empty
+ * @backoff_page_cache_fill: Delay cache refills
  * @work_in_progress: Indicates that page_cache_work is running
  * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
@@ -3190,7 +3202,8 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
+	atomic_t backoff_page_cache_fill;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
@@ -3256,6 +3269,26 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
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
@@ -3446,7 +3479,7 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
 	return HRTIMER_NORESTART;
 }
 
@@ -3455,12 +3488,16 @@ static void fill_page_cache_func(struct work_struct *work)
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
 
@@ -3477,6 +3514,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	}
 
 	atomic_set(&krcp->work_in_progress, 0);
+	atomic_set(&krcp->backoff_page_cache_fill, 0);
 }
 
 static void
@@ -3484,10 +3522,15 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
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
 
@@ -3639,12 +3682,19 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
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
@@ -3661,6 +3711,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += drain_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
@@ -4687,6 +4739,18 @@ static void __init kfree_rcu_batch_init(void)
 	int cpu;
 	int i;
 
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
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -4696,7 +4760,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.31.1.189.g2e36527f23

