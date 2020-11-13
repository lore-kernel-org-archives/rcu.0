Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5966CC388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085202085B
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrsyUhx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKMMP3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgKMMOH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:14:07 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5EF22249;
        Fri, 13 Nov 2020 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269645;
        bh=q7NHZ+oRGrAZD0DAyhWbqIuqvDCvMK63fBwv6s5bAJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrsyUhx+ypzBsRA6NIlOFSK4I9gmqR3gAqsxwAWa1v18sJ55qB1j15qDY6qAFOpZU
         LWLbkIUlBLILI4QGL1IfeExKl8B13P5ygEWssr3kujEfNeReq1xi7mV1afbj8O2tkr
         DifzbPj/0Q+H0E9jtBhhiF8gBsYFA2Tc5cB4km0c=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 07/19] rcu/nocb: Re-offload support
Date:   Fri, 13 Nov 2020 13:13:22 +0100
Message-Id: <20201113121334.166723-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to re-offload the callbacks processing of an rdp, we must clear
SEGCBLIST_SOFTIRQ_ONLY, set SEGCBLIST_OFFLOADED and notify the CB and GP
kthreads so that they both set their own bit flag and start processing
the callbacks remotely. The re-offloading worker is then notified that
it can stop processing the callbacks locally.

Ordering must be carefully enforced so that the callbacks that used to
be processed locally without locking must have their latest updates
visible by the time they get processed by the kthreads.

Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rcupdate.h |   2 +
 kernel/rcu/tree_plugin.h | 162 +++++++++++++++++++++++++++++++++------
 2 files changed, 140 insertions(+), 24 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 40266eb418b6..e0ee52e2756d 100644
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
index 10e7a8962a47..3b4f01a111d8 100644
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
@@ -2254,12 +2282,44 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 		do_nocb_deferred_wakeup_common(rdp);
 }
 
+static int rdp_offload_toggle(struct rcu_data *rdp,
+			       bool offload, unsigned long flags)
+	__releases(rdp->nocb_lock)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	bool wake_gp = false;
+
+	rcu_segcblist_offload(cblist, offload);
+
+	if (rdp->nocb_cb_sleep)
+		rdp->nocb_cb_sleep = false;
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
+	/*
+	 * Ignore former value of nocb_cb_sleep and force wake up as it could
+	 * have been spuriously set to false already.
+	 */
+	swake_up_one(&rdp->nocb_cb_wq);
+
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (rdp_gp->nocb_gp_sleep) {
+		rdp_gp->nocb_gp_sleep = false;
+		wake_gp = true;
+	}
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
+
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
+
+	return 0;
+}
+
 static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
-	bool wake_cb = false, wake_gp = false;
 	unsigned long flags;
+	int ret;
 
 	printk("De-offloading %d\n", rdp->cpu);
 
@@ -2273,31 +2333,11 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 		return -EBUSY;
 	}
 
-	rcu_segcblist_offload(cblist, false);
-
-	if (rdp->nocb_cb_sleep) {
-		rdp->nocb_cb_sleep = false;
-		wake_cb = true;
-	}
-	rcu_nocb_unlock_irqrestore(rdp, flags);
-
-	if (wake_cb)
-		swake_up_one(&rdp->nocb_cb_wq);
-
-	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-	if (rdp_gp->nocb_gp_sleep) {
-		rdp_gp->nocb_gp_sleep = false;
-		wake_gp = true;
-	}
-	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
-
-	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
-
+	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	return 0;
+	return ret;
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
@@ -2334,6 +2374,80 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	return ret;
 }
 
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
+
+
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-- 
2.25.1

