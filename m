Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095D1C433DF
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7649206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE47/kwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgEYVsW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731521AbgEYVsV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43792C061A0E;
        Mon, 25 May 2020 14:48:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z18so22116758lji.12;
        Mon, 25 May 2020 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lE2u2kHS4No1brUupiLe8POVLpxEzHQVFsb+F2qAz+U=;
        b=mE47/kwiSbkYd41CBx5mG2U+/+3o4+EafOVHvNDHcZlUcNROQrO9SmV490BZ2yU4Zv
         zEimBNytZVO9xBI9ZAO3GTTIGxnCnzhXACeLE/7qZ4/kwZ/bLsFSj1W0mdusKeeHu1Yr
         8G4agwb49X0+GpT+9THihZQDNVHp9/nfQarLlhOmhrc9Q/Mw1gzrEypJ2UI2Hh42AecR
         cnErb4qbgdAwkL/BfB/dPNy83y/kpdHbttDmJruEs4qPuZalMjTWI6R2oCS1GO8gn05j
         NhpZ7Sez5kjxUU/kvjQSy73y6uZZsF39QXJTZ5rYU1CsA8tT62qWRClNBE7l1JwSPiCU
         AS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lE2u2kHS4No1brUupiLe8POVLpxEzHQVFsb+F2qAz+U=;
        b=D4rAN7roAQnzfzNZF7Itex72qEbdtLRLKNIdgwkAzg14aCayoKIP37DVKVEqgSxuTe
         gpg5Wh0T6WdJo6/bfUhdB8pHZ3pPgB/43Rp48hx22P7qRi2jew4NX+eBfAo80e9F57Fy
         SXH87S/gIqJ3xVV7aMtJmasOfP5RqyM6a8EITQZqTYX9Cvh4IBZVpSO25u6UaWqxVd72
         BR5c7F6n4uF6Le6KblSeO+W89uv9mRFFP5+vTwXueh83hzc0kT6wY0ngzkB1mtlpXxBO
         gLJjrePXm6o7b0TNkGE0lJNS5wxFedcKrBnHO74McspR7/2F7fTvrzviMVOVhsYGtvOc
         LW0g==
X-Gm-Message-State: AOAM532w4IuAEoSxP4iEUwzbwiOJ8RinYXUE8CGmuiXYXwm8KmLHvOof
        Q+3257oRbV5I9V6HDPH8gYoQ8LRyYhREkA==
X-Google-Smtp-Source: ABdhPJzFTvgrYh2DM1zyUK1I1YUtgh7ZibMe7YtuD8sPpWEUShk9Ty1z/PVNpVJRpOslAXlqcLY1Nw==
X-Received: by 2002:a2e:6e17:: with SMTP id j23mr14537670ljc.106.1590443299340;
        Mon, 25 May 2020 14:48:19 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:18 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 08/16] rcu/tree: cache specified number of objects
Date:   Mon, 25 May 2020 23:47:52 +0200
Message-Id: <20200525214800.93072-9-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to reduce the dynamic need for pages in kfree_rcu(),
pre-allocate a configurable number of pages per CPU and link
them in a list. When kfree_rcu() reclaims objects, the object's
container page is cached into a list instead of being released
to the low-level page allocator.

Such an approach provides O(1) access to free pages while also
reducing the number of requests to the page allocator. It also
makes the kfree_rcu() code to have free pages available during
a low memory condition.

A read-only sysfs parameter (rcu_min_cached_objs) reflects the
minimum number of allowed cached pages per CPU.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 kernel/rcu/tree.c                             | 66 +++++++++++++++++--
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ea4228779c28..b90af44ee81d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3977,6 +3977,14 @@
 			latencies, which will choose a value aligned
 			with the appropriate hardware boundaries.
 
+	rcutree.rcu_min_cached_objs= [KNL]
+			Minimum number of objects which are cached and
+			maintained per one CPU. Object size is equal
+			to PAGE_SIZE. The cache allows to reduce the
+			pressure to page allocator, also it makes the
+			whole algorithm to behave better in low memory
+			condition.
+
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4b1710c1d8f6..e2267e92de5d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -167,6 +167,15 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+/*
+ * This rcu parameter is runtime-read-only. It reflects
+ * a minimum allowed number of objects which can be cached
+ * per-CPU. Object size is equal to one page. This value
+ * can be changed at boot time.
+ */
+static int rcu_min_cached_objs = 2;
+module_param(rcu_min_cached_objs, int, 0444);
+
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -2863,7 +2872,6 @@ struct kfree_rcu_cpu_work {
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
- * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2879,13 +2887,22 @@ struct kfree_rcu_cpu_work {
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
 	struct kfree_rcu_bulk_data *bhead;
-	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
 	int count;
+
+	/*
+	 * A simple cache list that contains objects for
+	 * reuse purpose. In order to save some per-cpu
+	 * space the list is singular. Even though it is
+	 * lockless an access has to be protected by the
+	 * per-cpu lock.
+	 */
+	struct llist_head bkvcache;
+	int nr_bkv_objs;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
@@ -2922,6 +2939,31 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 	local_irq_restore(flags);
 }
 
+static inline struct kfree_rcu_bulk_data *
+get_cached_bnode(struct kfree_rcu_cpu *krcp)
+{
+	if (!krcp->nr_bkv_objs)
+		return NULL;
+
+	krcp->nr_bkv_objs--;
+	return (struct kfree_rcu_bulk_data *)
+		llist_del_first(&krcp->bkvcache);
+}
+
+static inline bool
+put_cached_bnode(struct kfree_rcu_cpu *krcp,
+	struct kfree_rcu_bulk_data *bnode)
+{
+	// Check the limit.
+	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
+		return false;
+
+	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
+	krcp->nr_bkv_objs++;
+	return true;
+
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -2957,7 +2999,12 @@ static void kfree_rcu_work(struct work_struct *work)
 		kfree_bulk(bhead->nr_records, bhead->records);
 		rcu_lock_release(&rcu_callback_map);
 
-		if (cmpxchg(&krcp->bcached, NULL, bhead))
+		krcp = krc_this_cpu_lock(&flags);
+		if (put_cached_bnode(krcp, bhead))
+			bhead = NULL;
+		krc_this_cpu_unlock(krcp, flags);
+
+		if (bhead)
 			free_page((unsigned long) bhead);
 
 		cond_resched_tasks_rcu_qs();
@@ -3090,7 +3137,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 	/* Check if a new block is required. */
 	if (!krcp->bhead ||
 			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
-		bnode = xchg(&krcp->bcached, NULL);
+		bnode = get_cached_bnode(krcp);
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
@@ -4140,12 +4187,23 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		struct kfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
+		for (i = 0; i < rcu_min_cached_objs; i++) {
+			bnode = (struct kfree_rcu_bulk_data *)
+				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+
+			if (bnode)
+				put_cached_bnode(krcp, bnode);
+			else
+				pr_err("Failed to preallocate for %d CPU!\n", cpu);
+		}
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
-- 
2.20.1

