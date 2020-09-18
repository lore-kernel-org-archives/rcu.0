Return-Path: <SRS0=xZUe=C3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5609C43464
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9007321D42
	for <rcu@archiver.kernel.org>; Fri, 18 Sep 2020 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsLGoR1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIRTsl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRTsk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Sep 2020 15:48:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED33C0613CE;
        Fri, 18 Sep 2020 12:48:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u21so6021419ljl.6;
        Fri, 18 Sep 2020 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhLXWlpxd3kg9Dw7Z+xdLIdqyBDd0WYhln7MlbVfq8o=;
        b=OsLGoR1E8NC1PkjPfwdexAD/f6MYLMg5cdwRLXrWpg0UBZphtr1LtxqUiw66rpXU5H
         j6LVxbBrzDWbNhVASenQKtUnM4NMvywXwu1Yk/sMflp58j91WXbkkq7bquHulmheLZCg
         ax1KY2tb7+ydczYpRXm+uusDWZmMlOzK0WIMeR8pmB9N8KA614+R1c1xHhPZ5Xy4mShu
         F/6gtmo1xPtux3JE5e6e8V4p/UDvPjCc/7IqTsPaHxTF/A7iS+Jv6AWPut9tLxGGViR0
         2CpyijXyKmRnk27mzzeqD+ZvgTvj1sbA/lPCdPz4/UE8SsvKsxtraV0Ul+GqnJYzm3dl
         MZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhLXWlpxd3kg9Dw7Z+xdLIdqyBDd0WYhln7MlbVfq8o=;
        b=t2wqIJLkoD0ZMMYf7uwfa4sRe+4WenPKZNYp8PvNgopYHFmZplLc1N7g1YgxhPrtL1
         8jOOg4r1n9pQmQFxNLPVtoZ4eJeDDGxgS/RsjEJywtnOXjOdd+P4it+o4Ia8Af4hAC14
         NsC8VvH0WTTQ+xjTB+YLruHDkq85WLa7RsrXRP6MKAjMiza1W4mmiIEgslf9R5aGs2W3
         jo8V4ITdbR2MvWJuRPNxHPjXiuf5a3g5fdjPPU/nRggQYdRRZyB+lq+DJ8bLXthL1zyv
         Y7jVzeJZZ4fieWO18nGLy1zO+5HgCYtjp73lNYQiOIquEznJH6qaogBZOmzIFXNYyfVB
         jemA==
X-Gm-Message-State: AOAM533Bal2QzO4JyO9NtN7h5WaNH9TC0Q/quk5ClqwF/Nx5J37IlsDk
        JAUlRBq0mOd1AeTycH3/7RdPWxrnydf8Iwyi
X-Google-Smtp-Source: ABdhPJxbsbV1YD3UHexm/CMuadg/sM3dvj4yy9obt+hyvmnL1YMSmdfhTYP8qmlhHuu4Bz9bGVGH/Q==
X-Received: by 2002:a2e:81d7:: with SMTP id s23mr13083916ljg.69.1600458518216;
        Fri, 18 Sep 2020 12:48:38 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a17sm766769lfd.148.2020.09.18.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 12:48:37 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 1/4] rcu/tree: Add a work to allocate pages from regular context
Date:   Fri, 18 Sep 2020 21:48:14 +0200
Message-Id: <20200918194817.48921-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918194817.48921-1-urezki@gmail.com>
References: <20200918194817.48921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The current memmory-allocation interface presents to following
difficulties that this patch is designed to overcome:

a) If built with CONFIG_PROVE_RAW_LOCK_NESTING, the lockdep will
   complain about violation("BUG: Invalid wait context") of the
   nesting rules. It does the raw_spinlock vs. spinlock nesting
   checks, i.e. it is not legal to acquire a spinlock_t while
   holding a raw_spinlock_t.

   Internally the kfree_rcu() uses raw_spinlock_t whereas the
   "page allocator" internally deals with spinlock_t to access
   to its zones. The code also can be broken from higher level
   of view:
   <snip>
       raw_spin_lock(&some_lock);
       kfree_rcu(some_pointer, some_field_offset);
   <snip>

b) If built with CONFIG_PREEMPT_RT. Please note, in that case spinlock_t
   is converted into sleepable variant. Invoking the page allocator from
   atomic contexts leads to "BUG: scheduling while atomic".

c) call_rcu() is invoked from raw atomic context and kfree_rcu()
   and kvfree_rcu() are expected to be called from atomic raw context
   as well.

Move out a page allocation from contexts which trigger kvfree_rcu()
function to the separate worker. When a k[v]free_rcu() per-cpu page
cache is empty a fallback mechanism is used and a special job is
scheduled to refill the per-cpu cache.

As a side effect, maintaining of the bulk arrays in the separate
worker thread and not by request, will introduce other drawbacks.

a) There is an extra latency window, a time during which a fallback
   mechanism is used until pages are obtained via the special worker
   for further pointers collecting over arrays.

b) It is impossible to predict how many pages will be required to
   cover a demand that is controlled by different workloads on various
   systems.

c) Memory overhead since we do not know how much pages should be
   preloaded.

Above three concerns should be fixed by introducing a lock-free page
allocation interface.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 91 +++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 548404489c04..4bfc46a1e9d1 100644
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
@@ -3100,6 +3100,8 @@ struct kfree_rcu_cpu {
 	 * lockless an access has to be protected by the
 	 * per-cpu lock.
 	 */
+	struct work_struct page_cache_work;
+	atomic_t work_in_progress;
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
@@ -3217,10 +3219,10 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3347,6 +3349,42 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
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
+		/*
+		 * We would like to minimize a reclaiming process,
+		 * that is why GFP_NOWAIT is here. It can wakeup a
+		 * kswapd, what is fine, because somebody soon or
+		 * later will kick it to get the freelist back to
+		 * the watermarks.
+		 */
+		bnode = (struct kvfree_rcu_bulk_data *)
+			__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
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
 static inline bool
 kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 {
@@ -3363,32 +3401,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
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
@@ -3422,6 +3436,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	bool irq_disabled = irqs_disabled();
 	bool success;
 	void *ptr;
 
@@ -3452,12 +3467,12 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
-	/*
-	 * Under high memory pressure GFP_NOWAIT can fail,
-	 * in that case the emergency path is maintained.
-	 */
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
+		// TODO: schedule the work from the hrtimer.
+		if (!irq_disabled && !atomic_xchg(&krcp->work_in_progress, 1))
+			queue_work(system_highpri_wq, &krcp->page_cache_work);
+
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
 			goto unlock_return;
@@ -4449,24 +4464,14 @@ static void __init kfree_rcu_batch_init(void)
 
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
2.20.1

