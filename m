Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC484C433B4
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B760E611AC
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhDORUm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhDORUi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:20:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F74C061574;
        Thu, 15 Apr 2021 10:20:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y4so249879lfl.10;
        Thu, 15 Apr 2021 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaJfqd8zEhiMYiwa4BhcEBpfnZ8dO5mmWKsq6Sy0sa8=;
        b=bd0zrejGQRtyjWr3KIfKxq2QFUvynvJdnaX/I0gnSnZPL9J8JKh46gHevVI+ojy32k
         DXY9q4tcxkGCadz61CdWfb5uJYsg+IP9+VQSNx/wIB/m3NpDOrJU8X6btgITS2RjAI2Y
         Albf1JD1OWv16SUQKXHvvaksZmyXVOOzz0Au+glm0rHaxweOcUt07KyKxs9HWZsSPUOc
         WAisi8Oz4BgA6usZEMy8+myc4UeDy7dUo9eCK5y+z8O0nxxd70oCe8We2Tap+J4vrtJj
         hgFL9CCDwAzkoxBted1F9gqnz1mS8Ep14Go3REkaokwTLdwU6tk1aya50jN9E4FlOvsV
         68IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaJfqd8zEhiMYiwa4BhcEBpfnZ8dO5mmWKsq6Sy0sa8=;
        b=E+0XocRo7VgInSJy/1swn5pPYDPrw1DTAfMqju0XTkanKBvGkAxdmSd+2s0HyX0mWD
         KcXtLGw146pENJJbZvTa8vwSij3v5gFrd45aV35/sLORsTK9jAnZ8OWlOrRnu0hcByYB
         N/y5SpoCviexqWqr6lj0xQMoP///qeqfqEym+nWt3yJzygd4Q150rwHSOpwJ54fuk+a0
         nnhQzucM58ryv5b/OfcRld17ZQj5hpBW/kzDipTLB2/lTbwnYSwXiMszCsehZE5/dIVC
         gPLZhMUcV0xMbgDIJb4t4/ODRpwr5a+NAT4X6fWTjHI5waNMDC6ZHix+VR4ULfDzqjZk
         EkaQ==
X-Gm-Message-State: AOAM531pERvrNBX4cS7jDaYq5vEHxhef/x0owK2NURabJ7KLmcs892mS
        3D1GTYf0fxDlhATsEhXiACxuBmjOLJ+tgQ==
X-Google-Smtp-Source: ABdhPJw4aNIjAMk/PKdLG9UJ6jQdvVgzfqgNnrVhBRY81kpFY4OSx/JC0QniAEncufJtazKSaRqjHQ==
X-Received: by 2002:a05:6512:3087:: with SMTP id z7mr159241lfd.224.1618507212320;
        Thu, 15 Apr 2021 10:20:12 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm84358lff.276.2021.04.15.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:20:11 -0700 (PDT)
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
Subject: [PATCH v2 1/5] kvfree_rcu: Release a page cache under memory pressure
Date:   Thu, 15 Apr 2021 19:19:56 +0200
Message-Id: <20210415172000.15086-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415172000.15086-1-urezki@gmail.com>
References: <20210415172000.15086-1-urezki@gmail.com>
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
 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/rcu/tree.c                             | 82 +++++++++++++++++--
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 78dc87435ca7..6b769f5cf14c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4154,6 +4154,11 @@
 			whole algorithm to behave better in low memory
 			condition.
 
+	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
+			Set delay for a page-cache refill when a low memory
+			condition occurs. That is in milliseconds. Allowed
+			value is within a 0:100000 range.
+
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c9cf4df942c..742152d6b952 100644
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
@@ -4599,6 +4651,18 @@ static void __init kfree_rcu_batch_init(void)
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
+		pr_info("Adjusting a cache fill delay interval to %d ms.\n",
+			rcu_delay_page_cache_fill_msec);
+	}
+
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -4608,7 +4672,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.20.1

