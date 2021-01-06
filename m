Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D1C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D039F22CE3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbhAFEuR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbhAFEuR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BF05230FB;
        Wed,  6 Jan 2021 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908536;
        bh=OTBVHVEHm/6Ob8WqGVfrSmkB9XdMstZbqpg5WRQu1pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugxV8+4WPo35PrK3bdj8QcLDcM5ltDvdLTzEgiSc5AiY2J79xY4XDyhsWdyTIkmLM
         XWr2QbpybBxpxEBu5DA9c9BLETK6wpWE2+kKKcGCbGepcF7RyqNwgjs6oJbCDTdBVD
         SxykaBlTK2HS69NSTdtfhU3GVwAhW8OzMlt2qr/ArUh9r08Yse/iE1jP2iqVBSHZAv
         bZTfrcCUFwMMn74TAviVVDUrkLv1JlU9gJzUJbrukmpXUobz5fqlpZcsXjyx75z8jL
         EyYt9mkaLHePj9zgwcu7O2/+b1IaZJ/vNZOz/pW7xAGsG/WXC/8NIKU6QciEXX/52a
         AQcY0KPzl1R9Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/21] rcu/nocb: Re-offload support
Date:   Tue,  5 Jan 2021 20:48:39 -0800
Message-Id: <20210106044853.20812-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

To re-offload the callback processing off of a CPU, it is necessary to
clear SEGCBLIST_SOFTIRQ_ONLY, set SEGCBLIST_OFFLOADED, and then notify
both the CB and GP kthreads so that they both set their own bit flag and
start processing the callbacks remotely.  The re-offloading worker is
then notified that it can stop the RCU_SOFTIRQ handler (or rcuc kthread,
as the case may be) from processing the callbacks locally.

Ordering must be carefully enforced so that the callbacks that used to
be processed locally without locking will have have the same ordering
properties when they are invoked by the nocb CB and GP kthreads.

This commit makes this change.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
[ paulmck: Export rcu_nocb_cpu_offload(). ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |   2 +
 kernel/rcu/tree_plugin.h | 158 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 138 insertions(+), 22 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 40266eb..e0ee52e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -104,9 +104,11 @@ static inline void rcu_user_exit(void) { }
 
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
+int rcu_nocb_cpu_offload(int cpu);
 int rcu_nocb_cpu_deoffload(int cpu);
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 static inline void rcu_init_nohz(void) { }
+static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
 static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fe46e70..03ae1ce 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1928,6 +1928,20 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
 
+/*
+ * Check if we ignore this rdp.
+ *
+ * We check that without holding the nocb lock but
+ * we make sure not to miss a freshly offloaded rdp
+ * with the current ordering:
+ *
+ *  rdp_offload_toggle()        nocb_gp_enabled_cb()
+ * -------------------------   ----------------------------
+ *    WRITE flags                 LOCK nocb_gp_lock
+ *    LOCK nocb_gp_lock           READ/WRITE nocb_gp_sleep
+ *    READ/WRITE nocb_gp_sleep    UNLOCK nocb_gp_lock
+ *    UNLOCK nocb_gp_lock         READ flags
+ */
 static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
 {
 	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
@@ -1940,6 +1954,11 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 	struct rcu_segcblist *cblist = &rdp->cblist;
 
 	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
+			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_GP);
+			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+				*needwake_state = true;
+		}
 		return true;
 	} else {
 		/*
@@ -2003,6 +2022,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
 			continue; /* No callbacks here, try next. */
 		}
 		if (bypass_ncbs) {
@@ -2054,6 +2075,8 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		}
 		if (needwake_gp)
 			rcu_gp_kthread_wake();
+		if (needwake_state)
+			swake_up_one(&rdp->nocb_state_wq);
 	}
 
 	my_rdp->nocb_gp_bypass = bypass;
@@ -2159,6 +2182,11 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	WRITE_ONCE(rdp->nocb_cb_sleep, true);
 
 	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB)) {
+			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_CB);
+			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP))
+				needwake_state = true;
+		}
 		if (rcu_segcblist_ready_cbs(cblist))
 			WRITE_ONCE(rdp->nocb_cb_sleep, false);
 	} else {
@@ -2254,35 +2282,25 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
-static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+static int rdp_offload_toggle(struct rcu_data *rdp,
+			       bool offload, unsigned long flags)
+	__releases(rdp->nocb_lock)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
-	bool wake_cb = false, wake_gp = false;
-	unsigned long flags;
-
-	printk("De-offloading %d\n", rdp->cpu);
-
-	rcu_nocb_lock_irqsave(rdp, flags);
-	/*
-	 * If there are still pending work offloaded, the offline
-	 * CPU won't help much handling them.
-	 */
-	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		return -EBUSY;
-	}
+	bool wake_gp = false;
 
-	rcu_segcblist_offload(cblist, false);
+	rcu_segcblist_offload(cblist, offload);
 
-	if (rdp->nocb_cb_sleep) {
+	if (rdp->nocb_cb_sleep)
 		rdp->nocb_cb_sleep = false;
-		wake_cb = true;
-	}
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	if (wake_cb)
-		swake_up_one(&rdp->nocb_cb_wq);
+	/*
+	 * Ignore former value of nocb_cb_sleep and force wake up as it could
+	 * have been spuriously set to false already.
+	 */
+	swake_up_one(&rdp->nocb_cb_wq);
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 	if (rdp_gp->nocb_gp_sleep) {
@@ -2294,10 +2312,32 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	if (wake_gp)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
 
+	return 0;
+}
+
+static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+	int ret;
+
+	printk("De-offloading %d\n", rdp->cpu);
+
+	rcu_nocb_lock_irqsave(rdp, flags);
+	/*
+	 * If there are still pending work offloaded, the offline
+	 * CPU won't help much handling them.
+	 */
+	if (cpu_is_offline(rdp->cpu) && !rcu_segcblist_empty(&rdp->cblist)) {
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+		return -EBUSY;
+	}
+
+	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	return 0;
+	return ret;
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
@@ -2335,6 +2375,80 @@ int rcu_nocb_cpu_deoffload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
+static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * For now we only support re-offload, ie: the rdp must have been
+	 * offloaded on boot first.
+	 */
+	if (!rdp->nocb_gp_rdp)
+		return -EINVAL;
+
+	printk("Offloading %d\n", rdp->cpu);
+	/*
+	 * Can't use rcu_nocb_lock_irqsave() while we are in
+	 * SEGCBLIST_SOFTIRQ_ONLY mode.
+	 */
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	/*
+	 * We didn't take the nocb lock while working on the
+	 * rdp->cblist in SEGCBLIST_SOFTIRQ_ONLY mode.
+	 * Every modifications that have been done previously on
+	 * rdp->cblist must be visible remotely by the nocb kthreads
+	 * upon wake up after reading the cblist flags.
+	 *
+	 * The layout against nocb_lock enforces that ordering:
+	 *
+	 *  __rcu_nocb_rdp_offload()   nocb_cb_wait()/nocb_gp_wait()
+	 * -------------------------   ----------------------------
+	 *      WRITE callbacks           rcu_nocb_lock()
+	 *      rcu_nocb_lock()           READ flags
+	 *      WRITE flags               READ callbacks
+	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
+	 */
+	ret = rdp_offload_toggle(rdp, true, flags);
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
+			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+
+	return ret;
+}
+
+static long rcu_nocb_rdp_offload(void *arg)
+{
+	struct rcu_data *rdp = arg;
+
+	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	return __rcu_nocb_rdp_offload(rdp);
+}
+
+int rcu_nocb_cpu_offload(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	int ret = 0;
+
+	mutex_lock(&rcu_state.barrier_mutex);
+	cpus_read_lock();
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
+		if (cpu_online(cpu)) {
+			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+		} else {
+			ret = __rcu_nocb_rdp_offload(rdp);
+		}
+		if (!ret)
+			cpumask_set_cpu(cpu, rcu_nocb_mask);
+	}
+	cpus_read_unlock();
+	mutex_unlock(&rcu_state.barrier_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-- 
2.9.5

