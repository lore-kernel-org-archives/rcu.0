Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0599C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A8822BF3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhAFEuR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbhAFEuR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F25DA22D6F;
        Wed,  6 Jan 2021 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908536;
        bh=KQhfJeTv14yGPdiTx8LR1XhyQO9nScXoOGtvs+u34OE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsvGdPKm8TEzBVH4bQFDfhig4oiPeTAEhw/enN7sihmPdClVDfJI74bqttYpohXJG
         H2s2Rh8efZeSttCpWYZJ+PJyJa/FAV2g5C4bLpVJYQ18oS2Od1wwsYA5Kxd0MudDqe
         tUoHVfMhMX0eTZhBlMAlv8ANHUpXb0pMz6hoKU3FKBzEG18Ni9sztUZvgGjFQEkCik
         wTWr0o3VX+45tXdXDfNbvPXXBaUtqAoNcpOpY53m86x3phjd5ftonRrWUjgV8u9HQz
         3PgrvQNqH7MiM7gvayHPXChfBmdUDrf3pvfzTazqtKX+YYqFRntrb0TRxnfJA5E688
         L5PEODUdYMJFw==
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
Subject: [PATCH tip/core/rcu 06/21] rcu/nocb: De-offloading GP kthread
Date:   Tue,  5 Jan 2021 20:48:38 -0800
Message-Id: <20210106044853.20812-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

To de-offload callback processing back onto a CPU, it is necessary
to clear SEGCBLIST_OFFLOAD and notify the nocb GP kthread, which will
then clear its own bit flag and ignore this CPU until further notice.
Whichever of the nocb CB and nocb GP kthreads is last to clear its own
bit notifies the de-offloading worker kthread.  Once notified, this
worker kthread can proceed safe in the knowledge that the nocb CB and
GP kthreads will no longer be manipulating this CPU's RCU callback list.

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 54 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b70cc91..fe46e70 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1928,6 +1928,33 @@ static void do_nocb_bypass_wakeup_timer(struct timer_list *t)
 	__call_rcu_nocb_wake(rdp, true, flags);
 }
 
+static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
+{
+	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
+
+	return rcu_segcblist_test_flags(&rdp->cblist, flags);
+}
+
+static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
+{
+	struct rcu_segcblist *cblist = &rdp->cblist;
+
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
+		return true;
+	} else {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We will ignore this rdp until it ever gets re-offloaded.
+		 */
+		WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+			*needwake_state = true;
+		return false;
+	}
+}
+
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -1956,8 +1983,17 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
+		bool needwake_state = false;
+		if (!nocb_gp_enabled_cb(rdp))
+			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
+		if (!nocb_gp_update_state(rdp, &needwake_state)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			if (needwake_state)
+				swake_up_one(&rdp->nocb_state_wq);
+			continue;
+		}
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -2221,7 +2257,8 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	bool wake_cb = false;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	bool wake_cb = false, wake_gp = false;
 	unsigned long flags;
 
 	printk("De-offloading %d\n", rdp->cpu);
@@ -2247,9 +2284,19 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	if (wake_cb)
 		swake_up_one(&rdp->nocb_cb_wq);
 
-	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB));
+	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	if (rdp_gp->nocb_gp_sleep) {
+		rdp_gp->nocb_gp_sleep = false;
+		wake_gp = true;
+	}
+	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
+
+	swait_event_exclusive(rdp->nocb_state_wq,
+			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
+							SEGCBLIST_KTHREAD_GP));
 	return 0;
 }
 
@@ -2332,6 +2379,7 @@ void __init rcu_init_nohz(void)
 			rcu_segcblist_init(&rdp->cblist);
 		rcu_segcblist_offload(&rdp->cblist, true);
 		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
 	}
 	rcu_organize_nocb_kthreads();
 }
-- 
2.9.5

