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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B79C433DB
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 19:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CA464F11
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCHTuJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhCHTuB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Mar 2021 14:50:01 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B15C06174A;
        Mon,  8 Mar 2021 11:50:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u4so17669149ljh.6;
        Mon, 08 Mar 2021 11:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOnYTHVN2hanDBabSqYrW+ieOq1UWygtoR8Sx8gbqOs=;
        b=SFpbJlLtAcXarFIezpYYW10MWKsw7ruJhp3J/+z00YzqX67C0TgSN9Hbdi+hIcqHln
         XDEtBkq+LhYSKFW3j0VQ5dd67fjWZn6rZt/wwOz3R3jwaHhIOcT4jOWC+SS5jEZrIDLV
         kxZAGdKbmgr1WSsiGlDMgluoQ5rfgUhxESLgv/NBJlvINScduCJL4iw0yS2rFAkFRokW
         An5ADZdVAV5ZAfVVvlWOGaUbw6uFsLN5Gfuw925lDhFn/ZwkkNW4eSE8CwqXtNs/0LCn
         xarTdDHR/O4xY5Oosmn48ttEG/1+CcH1LkiA6HXWXd7vdB1lK2dMfUjgcLdfMbSn95Zn
         7fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lOnYTHVN2hanDBabSqYrW+ieOq1UWygtoR8Sx8gbqOs=;
        b=jC9um9nsRsbWOYgo/xeVbN0XuR8hLwSnpb5IQKmMK3COVX1IZh51dYVioAyrYur8XR
         dYFPOP1XU/E2QIi2x5e8swLDlF85xbnQ9Ib1gn3kZ5ebN5WmUC15pqDMhMK8Pz6mRuwW
         hRoDWsOhsfBfFCwWvbPe3uRWW7RVpbrKpo1X5BbIDPI/dLTAQIZeExkchlwM32v4EmO3
         6V6Ugw1YSRMm82lqOW1skAngg1/y9t7UZjZJAibaogLy5rr5dsRcs/AZvb8qTU6HIm2B
         Re7yQ1WfvT5eLT8tD14KJR3Tjrd8ajwvbbNeW5+kMF79OQlCg7O4ORlgaZHeD1G8LmSV
         LruQ==
X-Gm-Message-State: AOAM531ku0JES8pn92QgTSgbbTzBDgHiCaFWLlucJtKKm+/kh1XkH+Yi
        DP80yAY2C+nCVqIm7Qz2JUhbTEpqsx9vug==
X-Google-Smtp-Source: ABdhPJybTX4Habt2hE8eoMXT5qwSTZrGUcOXx9626ySUxFHuDqwA2CvvBcBGmOAMVaR5a86J5rG7Gg==
X-Received: by 2002:a2e:2a85:: with SMTP id q127mr14642963ljq.379.1615232999372;
        Mon, 08 Mar 2021 11:49:59 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j14sm655017lfb.41.2021.03.08.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:49:59 -0800 (PST)
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
Subject: [PATCH 1/2] kvfree_rcu: Release a page cache under memory pressure
Date:   Mon,  8 Mar 2021 20:49:49 +0100
Message-Id: <20210308194950.12320-1-urezki@gmail.com>
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
all CPUs in a system. Apart of that a page cache work is delayed
with 5 seconds interval until a memory pressure disappears.

Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/rcu/tree.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c9cf4df942c..9c8cfb01e9a6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3163,7 +3163,7 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
@@ -3175,6 +3175,17 @@ static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
 };
 
+// A page shrinker can ask for freeing extra pages
+// to get them available for other needs in a system.
+// Usually it happens under low memory condition, in
+// that case hold on a bit with page cache filling.
+static bool backoff_page_cache_fill;
+
+// 5 seconds delay. That is long enough to reduce
+// an interfering and racing with a shrinker where
+// the cache is drained.
+#define PAGE_CACHE_FILL_DELAY (5 * HZ)
+
 static __always_inline void
 debug_rcu_bhead_unqueue(struct kvfree_rcu_bulk_data *bhead)
 {
@@ -3229,6 +3240,26 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
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
@@ -3419,7 +3450,7 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
 	return HRTIMER_NORESTART;
 }
 
@@ -3428,7 +3459,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
 	bool pushed;
 	int i;
@@ -3457,10 +3488,14 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-		krcp->hrtimer.function = schedule_page_work_fn;
-		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		if (xchg(&backoff_page_cache_fill, false)) {
+			queue_delayed_work(system_wq,
+				&krcp->page_cache_work, PAGE_CACHE_FILL_DELAY);
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
 	}
 }
 
@@ -3612,14 +3647,20 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
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
 	}
 
+	WRITE_ONCE(backoff_page_cache_fill, true);
 	return count;
 }
 
@@ -3634,6 +3675,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += drain_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
@@ -4608,7 +4651,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.20.1

