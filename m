Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3CCC433DF
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA6720823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029575;
	bh=HrZ1XscrqQOi3wYONUEMuKeFfEhXTfN7U1bw47Gat7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yY0Ko1jKWmIwtTvkog8Ql3A4t741M0Zitlchx/uuUxfEu8bsnUewTtoMLWPR+Yhh
	 xDpitCrfkqtOl16TgNA09MGYKWG5/BKAN2CRUXFlPOt5Hi3nszo/jHiS9xtQ0UDSL5
	 PabPPgv9WGNeLTwmFrBf+5NWoyhiUKmxIrMs//b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406403AbgFXUMc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406386AbgFXUMb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E458921473;
        Wed, 24 Jun 2020 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029550;
        bh=HrZ1XscrqQOi3wYONUEMuKeFfEhXTfN7U1bw47Gat7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNrBZi8gii5h/gzbzpPugIpRjfKY6DaxtNnAcL+8vTmeuyS/EhmL2HToAZAPL+i64
         QdEOIHZRO0UvtYqjbECxQcBMp5bvEvqxtC8l+r2XflJjA7MJkd8ZvPro+e21f11Lpc
         /cZPDuhPW9OzPgDLuQ/KMrIBgpHSRuQadPOwaNAY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/17] rcu/tree: cache specified number of objects
Date:   Wed, 24 Jun 2020 13:12:18 -0700
Message-Id: <20200624201226.21197-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++
 kernel/rcu/tree.c                               | 66 +++++++++++++++++++++++--
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..befaa63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4038,6 +4038,14 @@
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
index 4fba1e9..f767a37 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -175,6 +175,15 @@ module_param(gp_init_delay, int, 0444);
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
@@ -2979,7 +2988,6 @@ struct kfree_rcu_cpu_work {
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
- * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2995,13 +3003,22 @@ struct kfree_rcu_cpu_work {
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
@@ -3038,6 +3055,31 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
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
@@ -3073,7 +3115,12 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3206,7 +3253,7 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 	/* Check if a new block is required. */
 	if (!krcp->bhead ||
 			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
-		bnode = xchg(&krcp->bcached, NULL);
+		bnode = get_cached_bnode(krcp);
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
@@ -4259,12 +4306,23 @@ static void __init kfree_rcu_batch_init(void)
 
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
2.9.5

