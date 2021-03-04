Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA08C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FC764EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhCDBBB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448491AbhCDAZz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66AA464EEE;
        Thu,  4 Mar 2021 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817395;
        bh=gu8YZFAz7kL4KL+4QRifWNJCAsuV026Hq+FZDTnpYOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHngxzlMQMWphj4c79/9lBKK74k/bqgIEZsmBRlqf0Pfd1k2Nk89IYeXi9suLOLOu
         DxrkIkhwgiz0v8s8Y1NzXvXYcOTX3sTbqP/C+nhoHLl0rmVKxyRHLFpo7tqoZ9jBd4
         LpIBRwEcoe3ZtJUEU91OihpcaOiZaWXnrrP4S9AfJrK19bOJBqQ6EKue6X27BRNMeL
         rKJJ4RvsiIyT4NppUD6jxAF5uAHbbyTsBmG270qqPYjKZVnh5eERsCjhr5rHAmIY+x
         JxxrpPUBbYWzAkbdGf8E+R9NT3sBf+J7wr1L0CVkkRmHxHz9c4FiLkz3Y5DSbjcJfN
         YrqK6u9KuNH2A==
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
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/12] rcu/nocb: Disable bypass when CPU isn't completely offloaded
Date:   Wed,  3 Mar 2021 16:23:09 -0800
Message-Id: <20210304002311.23655-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Currently, the bypass is flushed at the very last moment in the
deoffloading procedure.  However, this approach leads to a larger state
space than would be preferred.  This commit therefore disables the
bypass at soon as the deoffloading procedure begins, then flushes it.
This guarantees that the bypass remains empty and thus out of the way
of the deoffloading procedure.

Symmetrically, this commit waits to enable the bypass until the offloading
procedure has completed.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h |  7 ++++---
 kernel/rcu/tree_plugin.h      | 38 +++++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 8afe886..3db96c4 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -109,7 +109,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
- *  |   handling callbacks.                                                    |
+ *  |   handling callbacks. Enable bypass queueing.                            |
  *  ----------------------------------------------------------------------------
  */
 
@@ -125,7 +125,7 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
- *  |   ignores callbacks.                                                     |
+ *  |   ignores callbacks. Bypass enqueue is enabled.                          |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
@@ -134,7 +134,8 @@ struct rcu_cblist {
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
  *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
- *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary. Disable    |
+ *  |   bypass enqueue.                                                        |
  *  ----------------------------------------------------------------------------
  *                                      |
  *                                      v
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e392bd1..b08564b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1830,11 +1830,22 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 
+	lockdep_assert_irqs_disabled();
+
+	// Pure softirq/rcuc based processing: no bypassing, no
+	// locking.
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		return false;
+	}
+
+	// In the process of (de-)offloading: no bypassing, but
+	// locking.
+	if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
+		rcu_nocb_lock(rdp);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
-	lockdep_assert_irqs_disabled();
 
 	// Don't use ->nocb_bypass during early boot.
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
@@ -2416,7 +2427,16 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	pr_info("De-offloading %d\n", rdp->cpu);
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-
+	/*
+	 * Flush once and for all now. This suffices because we are
+	 * running on the target CPU holding ->nocb_lock (thus having
+	 * interrupts disabled), and because rdp_offload_toggle()
+	 * invokes rcu_segcblist_offload(), which clears SEGCBLIST_OFFLOADED.
+	 * Thus future calls to rcu_segcblist_completely_offloaded() will
+	 * return false, which means that future calls to rcu_nocb_try_bypass()
+	 * will refuse to put anything into the bypass.
+	 */
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
@@ -2428,21 +2448,21 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	del_timer_sync(&rdp->nocb_timer);
 
 	/*
-	 * Flush bypass. While IRQs are disabled and once we set
-	 * SEGCBLIST_SOFTIRQ_ONLY, no callback is supposed to be
-	 * enqueued on bypass.
+	 * Theoretically we could set SEGCBLIST_SOFTIRQ_ONLY with CB unlocked
+	 * and IRQs disabled but let's be paranoid.
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
-	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
 	/*
 	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
-	 * rcu_nocb_unlock_irqrestore() anymore. Theoretically we
-	 * could set SEGCBLIST_SOFTIRQ_ONLY with cb unlocked and IRQs
-	 * disabled now, but let's be paranoid.
+	 * rcu_nocb_unlock_irqrestore() anymore.
 	 */
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
+	/* Sanity check */
+	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+
+
 	return ret;
 }
 
-- 
2.9.5

