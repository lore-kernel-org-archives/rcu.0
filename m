Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E893BC83004
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B5E20731
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWBRAk5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD1VAl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbgD1U7m (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85974C03C1AC;
        Tue, 28 Apr 2020 13:59:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so202951ljb.9;
        Tue, 28 Apr 2020 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLSwCcFlhT2VhQKTC73KXNQ7m5lfVddOJ9NrXpevtsw=;
        b=EWBRAk5kGzdsYCoM7US1OsnIhAydgAQIeV2ADHVhbDIYUFCzjmHePpJIfhPdwMe0ZD
         kjLHUK9aENp8DOOf3Fd1kQNXJuX5HAHNlbv4hbNhCcA5o9Mn72gnGvfAVrDyjHyIL0PU
         1XUf3HUpRQ94dzVqzsdqsxlKrAFWC+tTMHx5DWFJ+Pvq2rtBCvD4Kc5ER4tTd2FoSUnR
         HyOhVXNKFX7miwg9KAvYD2LVZYuJzeBoT8LRFkEBlPqoUzkmzDTLLWQrUP6ni9nIjU1D
         T2mtsu1K9aFpnb4aWigTJRdnHQP1nijHY8L8wITm7Y1MDko6M/KPYlOfV/x3k2utaP3H
         1O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLSwCcFlhT2VhQKTC73KXNQ7m5lfVddOJ9NrXpevtsw=;
        b=cFa1ZurRlfRD6rs2w8UqkyE/sKUmdanYhqUUfKRSBsgnEYxc4ZYDqqBZv2nIagHi8W
         ksGDrrp/yJGmbg+6oHjiQ2a+Yx2xxZWqSIYqYcfHVJ8uL2ltARzkgo5+lrOS5l5iLiLd
         J1f9FB2eD62CmQFoFpWonudVX2JV1lkwOUIaOaMYa7vz3LBHS1+bF+J5eGMAAb//thKt
         /7dXDnl2VP2GwdAdiZa4Cm1gQgtKwmgPVqXGJoCcsZFHq/QaIpy+CePZxEMSdjccTEdU
         TgPy73l1urUrsQ264xiZyaqnCK31xtAFULi4zBE+7N5IpKTTiWgA9OolqReZ+qamgTqt
         Zy6Q==
X-Gm-Message-State: AGi0PubHXcrMZ3dEMy3KKc1IA8+seMqlmJAx/MmW43v4ilHqPoaR21yk
        1Q9IXj+YV8T4m1xGoW53yK6dZ7n9F95UHw==
X-Google-Smtp-Source: APiQypLBd6ihKL4ASunwou7LRD3kt57nhTc35mEMNnUP9p5PGWGHowh92faeH1ivrYe/6p3mH9nN5w==
X-Received: by 2002:ac2:48b1:: with SMTP id u17mr19859185lfg.187.1588107579619;
        Tue, 28 Apr 2020 13:59:39 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:39 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 09/24] rcu/tree: cache specified number of objects
Date:   Tue, 28 Apr 2020 22:58:48 +0200
Message-Id: <20200428205903.61704-10-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Cache some extra objects per-CPU. During reclaim process
some pages are cached instead of releasing by linking them
into the list. Such approach provides O(1) access time to
the cache.

That reduces number of requests to the page allocator, also
that makes it more helpful if a low memory condition occurs.

A parameter reflecting the minimum allowed pages to be
cached per one CPU is propagated via sysfs, it is read
only, the name is "rcu_min_cached_objs".

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 89e9ca3f4e3e..d8975819b1c9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -178,6 +178,14 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+/*
+ * This rcu parameter is read-only, but can be write also.
+ * It reflects the minimum allowed number of objects which
+ * can be cached per-CPU. Object size is equal to one page.
+ */
+int rcu_min_cached_objs = 2;
+module_param(rcu_min_cached_objs, int, 0444);
+
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -2887,7 +2895,6 @@ struct kfree_rcu_cpu_work {
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
- * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2902,7 +2909,6 @@ struct kfree_rcu_cpu_work {
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
 	struct kfree_rcu_bulk_data *bhead;
-	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2910,6 +2916,15 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	// Number of objects for which GP not started
 	int count;
+
+	/*
+	 * Number of cached objects which are queued into
+	 * the lock-less list. This cache is used by the
+	 * kvfree_call_rcu() function and as of now its
+	 * size is static.
+	 */
+	struct llist_head bkvcache;
+	int nr_bkv_objs;
 };
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
@@ -2946,6 +2961,31 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
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
+	/* Check the limit. */
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
@@ -2981,7 +3021,12 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3114,7 +3159,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 	/* Check if a new block is required. */
 	if (!krcp->bhead ||
 			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
-		bnode = xchg(&krcp->bcached, NULL);
+		bnode = get_cached_bnode(krcp);
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
@@ -4167,12 +4212,23 @@ static void __init kfree_rcu_batch_init(void)
 
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

