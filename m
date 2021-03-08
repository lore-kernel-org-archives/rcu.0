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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244FCC433E0
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 19:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA6E64F4B
	for <rcu@archiver.kernel.org>; Mon,  8 Mar 2021 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhCHTuK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhCHTuC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Mar 2021 14:50:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0DC06174A;
        Mon,  8 Mar 2021 11:50:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v9so23013127lfa.1;
        Mon, 08 Mar 2021 11:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJ+oChyOYJh/v9oodFXBHW5G0EgEfw97McljiozeiGw=;
        b=NOdlhiHp1uo0M5I2ACo0JLw4CWv+Jny+YROQOxbD2HViZI8m9HWd2aXIbUwi4+6ktK
         +ys8Ne6IDj3H5IaP9v4Ips+qly8xB5TqXHtQgPB40NY282EQHRGMjXieJtKp8St+qTTu
         jFfaS5io12tP6Altf0DSXZPujh1H6MSTTkeaoRJ+1dpO2MPpG1mPOkVeztOsmxce9JTB
         WhN+FmvBmuoiaYY/JsUW35ieJwNjCfkhOjYIqfkVCi/hBJasTQKMX+AVNeK/dAEduhbf
         F0Ws2abzHR76kYcisGMJcn1OIdPtmA8Vh8DpMppkBolIuxBS1u8kGIv4OJxx4QGG0E3H
         Cd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJ+oChyOYJh/v9oodFXBHW5G0EgEfw97McljiozeiGw=;
        b=QXu2+2523LGOyDxjTwcEC5AA2ndxN2Ww39IHpOmxlK73Kryg+YVtJG2E4q8xwrhDrF
         p5oUHpUecMy7XosGT1jt7fA/H3YOYafbp4Z3Ph1qMjiYnjT3C2em2T3UDb8Rrc9OBUfv
         4viVtOWpVQ4KAutf0uKRmVhCeYq176RT/i0LvlKrwqF8AZiyedkXK8AlesQxC0JrnBNc
         jLGQ5yFlgGbtgZw/l8EABxrGtiVpiT/LLODLDWXvK9W7dyMOeCpM4ejq1BMTXmn7FUOf
         uwDryucxYDUlBH3bIpLxLLikJOu3g3QmrHegdPtNOXouIJhmBeMmVbzH5Ar4Nu73kC1m
         edPg==
X-Gm-Message-State: AOAM533gSGL53g+8p9nm/hWdh4lwAqv0ypFCjM1HgD/j4viOCI2azs+X
        stvjU9Bj48qLy2XJJRq0ipiFAo1xPDYROQ==
X-Google-Smtp-Source: ABdhPJyu1OlZbdyXRucu3b7PjjVWanFY98YJgJ5C+Day3QqA2x5/6d3yNdRUn/GpOcZf/QvsGpuz1A==
X-Received: by 2002:a05:6512:3693:: with SMTP id d19mr14817809lfs.118.1615233000363;
        Mon, 08 Mar 2021 11:50:00 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j14sm655017lfb.41.2021.03.08.11.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:50:00 -0800 (PST)
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
Subject: [PATCH 2/2] kvfree_rcu: convert a page cache to lock-free variant
Date:   Mon,  8 Mar 2021 20:49:50 +0100
Message-Id: <20210308194950.12320-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210308194950.12320-1-urezki@gmail.com>
References: <20210308194950.12320-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Implement an access to the page cache as lock-free variant. This
is done because there are extra places where an access is required,
therefore making it lock-less will remove any lock contention.

For example we have a shrinker path as well as a reclaim kthread.
In both cases a current CPU can access to a remote per-cpu page
cache that would require taking a lock to protect it.

An "rcuscale" performance test suite can detect it and shows some
slight improvements:

../kvm.sh --memory 16G --torture rcuscale --allcpus --duration 10 \
--kconfig CONFIG_NR_CPUS=64 --bootargs "rcuscale.kfree_rcu_test=1 \
rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
rcuscale.kfree_rcu_test_double=1 torture.disable_onoff_at_boot" --trust-make

100 iterations, checking total time taken by all kfree'ers in ns.:

default: AVG: 10968415107.5 MIN: 10668412500 MAX: 11312145160
patch:   AVG: 10787596486.1 MIN: 10397559880 MAX: 11214901050

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 91 +++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9c8cfb01e9a6..4f04664d5ac0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3167,8 +3167,9 @@ struct kfree_rcu_cpu {
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
+	// lock-free cache.
 	struct llist_head bkvcache;
-	int nr_bkv_objs;
+	atomic_t nr_bkv_objs;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
@@ -3215,49 +3216,79 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+/*
+ * Increment 'v', if 'v' is below 'thresh'. Returns true if we
+ * succeeded, false if 'v' + 1 would be bigger than 'thresh'.
+ *
+ * Decrement 'v' if 'v' is upper 'thresh'. Returns true if we
+ * succeeded, false if 'v' - 1 would be smaller than 'thresh'.
+ */
+static inline bool
+atomic_test_inc_dec(atomic_t *v, unsigned int thresh, bool inc)
+{
+	unsigned int cur = atomic_read(v);
+	unsigned int old;
+
+	for (;;) {
+		if (inc) {
+			if (cur >= thresh)
+				return false;
+		} else {
+			if (cur <= thresh)
+				return false;
+		}
+
+		old = atomic_cmpxchg(v, cur, inc ? (cur + 1):(cur - 1));
+		if (old == cur)
+			break;
+
+		cur = old;
+	}
+
+	return true;
+}
+
 static inline struct kvfree_rcu_bulk_data *
 get_cached_bnode(struct kfree_rcu_cpu *krcp)
 {
-	if (!krcp->nr_bkv_objs)
-		return NULL;
+	struct kvfree_rcu_bulk_data *bnode = NULL;
 
-	krcp->nr_bkv_objs--;
-	return (struct kvfree_rcu_bulk_data *)
-		llist_del_first(&krcp->bkvcache);
+	if (atomic_test_inc_dec(&krcp->nr_bkv_objs, 0, false))
+		bnode = (struct kvfree_rcu_bulk_data *)
+			llist_del_first(&krcp->bkvcache);
+
+	return bnode;
 }
 
 static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
 	struct kvfree_rcu_bulk_data *bnode)
 {
-	// Check the limit.
-	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
-		return false;
-
-	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
-	krcp->nr_bkv_objs++;
-	return true;
+	if (atomic_test_inc_dec(&krcp->nr_bkv_objs, rcu_min_cached_objs, true)) {
+		llist_add((struct llist_node *) bnode, &krcp->bkvcache);
+		return true;
+	}
 
+	return false;
 }
 
 static int
 drain_page_cache(struct kfree_rcu_cpu *krcp)
 {
-	unsigned long flags;
-	struct llist_node *page_list, *pos, *n;
-	int freed = 0;
+	struct kvfree_rcu_bulk_data *bnode;
+	int num_pages, i;
 
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	page_list = llist_del_all(&krcp->bkvcache);
-	krcp->nr_bkv_objs = 0;
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+	num_pages = atomic_read(&krcp->nr_bkv_objs);
+
+	for (i = 0; i < num_pages; i++) {
+		bnode = get_cached_bnode(krcp);
+		if (!bnode)
+			break;
 
-	llist_for_each_safe(pos, n, page_list) {
-		free_page((unsigned long)pos);
-		freed++;
+		free_page((unsigned long) bnode);
 	}
 
-	return freed;
+	return i;
 }
 
 /*
@@ -3314,10 +3345,8 @@ static void kfree_rcu_work(struct work_struct *work)
 			}
 			rcu_lock_release(&rcu_callback_map);
 
-			raw_spin_lock_irqsave(&krcp->lock, flags);
 			if (put_cached_bnode(krcp, bkvhead[i]))
 				bkvhead[i] = NULL;
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 			if (bkvhead[i])
 				free_page((unsigned long) bkvhead[i]);
@@ -3460,7 +3489,6 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
 			page_cache_work.work);
-	unsigned long flags;
 	bool pushed;
 	int i;
 
@@ -3469,10 +3497,7 @@ static void fill_page_cache_func(struct work_struct *work)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
 		if (bnode) {
-			raw_spin_lock_irqsave(&krcp->lock, flags);
 			pushed = put_cached_bnode(krcp, bnode);
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
 			if (!pushed) {
 				free_page((unsigned long) bnode);
 				break;
@@ -3647,17 +3672,13 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
-	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->nr_bkv_objs;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		count += atomic_read(&krcp->nr_bkv_objs);
 	}
 
 	WRITE_ONCE(backoff_page_cache_fill, true);
-- 
2.20.1

