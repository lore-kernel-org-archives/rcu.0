Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9530BC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB3620A8B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617789;
	bh=HTRdC3uMZY3/UKobYLnSFwplkkOVrTEubhNuG4FsDbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J0TzfrddVGVjHLB3ypxdvZqrm3Into3x6V+G/whjarutHSEN1xSnL2wiiOFluRAQh
	 MDAEBosK7xj3Bb3hKBK3GknGhke3vcrvSPvrxmRoYM6GaaXn/XU7wvrHE7eFaOXgJk
	 62gYQx50htWVjSQWKvfJKdLy9SWCA1HDbM4K02Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgKEXJs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732696AbgKEXJa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E4E22203;
        Thu,  5 Nov 2020 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617770;
        bh=HTRdC3uMZY3/UKobYLnSFwplkkOVrTEubhNuG4FsDbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SmMZhBZ4m/SknhZzDWNz75Hhcyeyk6nVFolaysPnH3iVaBlBM/tRZpTv1kVw8VA8s
         0v6WMZP62YMEAp6uhp6lKZRbl8OwtlbCzEK7vMMesqBhyOB2NqGp4PWC2VF59YjIrp
         vT6lQo0stafZNLg4v/DdKvb0vRF5S5aBMzNKAKjI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/16] rcu/tree: Defer kvfree_rcu() allocation to a clean context
Date:   Thu,  5 Nov 2020 15:09:20 -0800
Message-Id: <20201105230921.19017-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The current memmory-allocation interface causes the following difficulties
for kvfree_rcu():

a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
   complain about violation of the nesting rules, as in "BUG: Invalid
   wait context".  This Kconfig option checks for proper raw_spinlock
   vs. spinlock nesting, in particular, it is not legal to acquire a
   spinlock_t while holding a raw_spinlock_t.

   This is a problem because kfree_rcu() uses raw_spinlock_t whereas the
   "page allocator" internally deals with spinlock_t to access to its
   zones. The code also can be broken from higher level of view:
   <snip>
       raw_spin_lock(&some_lock);
       kfree_rcu(some_pointer, some_field_offset);
   <snip>

b) If built with CONFIG_PREEMPT_RT, spinlock_t is converted into
   sleeplock.  This means that invoking the page allocator from atomic
   contexts results in "BUG: scheduling while atomic".

c) Please note that call_rcu() is already invoked from raw atomic context,
   so it is only reasonable to expaect that kfree_rcu() and kvfree_rcu()
   will also be called from atomic raw context.

This commit therefore defers page allocation to a clean context using the
combination of an hrtimer and a workqueue.  The hrtimer stage is required
in order to avoid deadlocks with the scheduler.  This deferred allocation
is required only when kvfree_rcu()'s per-CPU page cache is empty.

Link: https://lore.kernel.org/lkml/20200630164543.4mdcf6zb4zfclhln@linutronix.de/
Fixes: 3042f83f19be ("rcu: Support reclaim for head-less object")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 109 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e825b3b..0d06a1b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
  * per-CPU. Object size is equal to one page. This value
  * can be changed at boot time.
  */
-static int rcu_min_cached_objs = 2;
+static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 
 /* Retrieve RCU kthreads priority for rcutorture */
@@ -3089,6 +3089,9 @@ struct kfree_rcu_cpu_work {
  *	In order to save some per-cpu space the list is singular.
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
+ * @page_cache_work: A work to refill the cache when it is empty
+ * @work_in_progress: Indicates that page_cache_work is running
+ * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -3105,6 +3108,11 @@ struct kfree_rcu_cpu {
 	bool monitor_todo;
 	bool initialized;
 	int count;
+
+	struct work_struct page_cache_work;
+	atomic_t work_in_progress;
+	struct hrtimer hrtimer;
+
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
@@ -3222,10 +3230,10 @@ static void kfree_rcu_work(struct work_struct *work)
 			}
 			rcu_lock_release(&rcu_callback_map);
 
-			krcp = krc_this_cpu_lock(&flags);
+			raw_spin_lock_irqsave(&krcp->lock, flags);
 			if (put_cached_bnode(krcp, bkvhead[i]))
 				bkvhead[i] = NULL;
-			krc_this_cpu_unlock(krcp, flags);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 			if (bkvhead[i])
 				free_page((unsigned long) bkvhead[i]);
@@ -3352,6 +3360,57 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static enum hrtimer_restart
+schedule_page_work_fn(struct hrtimer *t)
+{
+	struct kfree_rcu_cpu *krcp =
+		container_of(t, struct kfree_rcu_cpu, hrtimer);
+
+	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	return HRTIMER_NORESTART;
+}
+
+static void fill_page_cache_func(struct work_struct *work)
+{
+	struct kvfree_rcu_bulk_data *bnode;
+	struct kfree_rcu_cpu *krcp =
+		container_of(work, struct kfree_rcu_cpu,
+			page_cache_work);
+	unsigned long flags;
+	bool pushed;
+	int i;
+
+	for (i = 0; i < rcu_min_cached_objs; i++) {
+		bnode = (struct kvfree_rcu_bulk_data *)
+			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+
+		if (bnode) {
+			raw_spin_lock_irqsave(&krcp->lock, flags);
+			pushed = put_cached_bnode(krcp, bnode);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+			if (!pushed) {
+				free_page((unsigned long) bnode);
+				break;
+			}
+		}
+	}
+
+	atomic_set(&krcp->work_in_progress, 0);
+}
+
+static void
+run_page_cache_worker(struct kfree_rcu_cpu *krcp)
+{
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+			!atomic_xchg(&krcp->work_in_progress, 1)) {
+		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
+			HRTIMER_MODE_REL);
+		krcp->hrtimer.function = schedule_page_work_fn;
+		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+	}
+}
+
 static inline bool
 kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 {
@@ -3368,32 +3427,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	if (!krcp->bkvhead[idx] ||
 			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(krcp);
-		if (!bnode) {
-			/*
-			 * To keep this path working on raw non-preemptible
-			 * sections, prevent the optional entry into the
-			 * allocator as it uses sleeping locks. In fact, even
-			 * if the caller of kfree_rcu() is preemptible, this
-			 * path still is not, as krcp->lock is a raw spinlock.
-			 * With additional page pre-allocation in the works,
-			 * hitting this return is going to be much less likely.
-			 */
-			if (IS_ENABLED(CONFIG_PREEMPT_RT))
-				return false;
-
-			/*
-			 * NOTE: For one argument of kvfree_rcu() we can
-			 * drop the lock and get the page in sleepable
-			 * context. That would allow to maintain an array
-			 * for the CONFIG_PREEMPT_RT as well if no cached
-			 * pages are available.
-			 */
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-		}
-
 		/* Switch to emergency path. */
-		if (unlikely(!bnode))
+		if (!bnode)
 			return false;
 
 		/* Initialize the new block. */
@@ -3457,12 +3492,10 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
-	/*
-	 * Under high memory pressure GFP_NOWAIT can fail,
-	 * in that case the emergency path is maintained.
-	 */
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
+		run_page_cache_worker(krcp);
+
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
 			goto unlock_return;
@@ -4482,24 +4515,14 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
-		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-
-			if (bnode)
-				put_cached_bnode(krcp, bnode);
-			else
-				pr_err("Failed to preallocate for %d CPU!\n", cpu);
-		}
-
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.9.5

