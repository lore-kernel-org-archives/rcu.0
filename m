Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A5CC43470
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B922D61432
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhEKW43 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhEKW40 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:56:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7A1F61939;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=/MJUwVofubq6Zyah+Fq1Gx9CcMJRrCkJYTJTjNCxQR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFfWGyVtaOQ7BNktldhxiD3V8Tz9HbfBNLlanO24o6eYrNuX9Q3YtH5T37/6VranQ
         6BaEo+P/xssPtVkIM+Zgtd/zYduY06TLjP0u+r1BJBXqInPQz8M3U00gGkkpkkult3
         gnUtqKEwdVV0hNMWoeoK8sPbadG0XFMEnKaz8rmQhd254WXkqlYqi6dTm/NhSAzVd7
         GsMS48QTpqJR5n8xP0prad9F2Jw4kV3N+/++hKuHadqpW69qBOmB1RN7kMsLDrE06O
         Y9W9gQTuNGkiXueygF8eMf/dVkOLA5Bpe96f796GCjOJMEvaBkbz4s+3sikJX0b0fE
         PRrO9+c5+BiEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 129BD5C0DD7; Tue, 11 May 2021 15:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 7/7] kvfree_rcu: Refactor kfree_rcu_monitor()
Date:   Tue, 11 May 2021 15:55:16 -0700
Message-Id: <20210511225516.2893420-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Currently we have three functions which depend on each other.
Two of them are quite tiny and the last one where the most
work is done. All of them are related to queuing RCU batches
to reclaim objects after a GP.

1. kfree_rcu_monitor(). It consist of few lines. It acquires a spin-lock
   and calls kfree_rcu_drain_unlock().

2. kfree_rcu_drain_unlock(). It also consists of few lines of code. It
   calls queue_kfree_rcu_work() to queue the batch.  If this fails,
   it rearms the monitor work to try again later.

3. queue_kfree_rcu_work(). This provides the bulk of the functionality,
   attempting to start a new batch to free objects after a GP.

Since there are no external users of functions [2] and [3], both
can eliminated by moving all logic directly into [1], which both
shrinks and simplifies the code.

Also replace comments which start with "/*" to "//" format to make it
unified across the file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 84 +++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 58 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b043af7b0212..618ec9152e5e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3379,29 +3379,26 @@ static void kfree_rcu_work(struct work_struct *work)
 }
 
 /*
- * Schedule the kfree batch RCU work to run in workqueue context after a GP.
- *
- * This function is invoked by kfree_rcu_monitor() when the KFREE_DRAIN_JIFFIES
- * timeout has been reached.
+ * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
-static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
+static void kfree_rcu_monitor(struct work_struct *work)
 {
-	struct kfree_rcu_cpu_work *krwp;
-	bool repeat = false;
+	struct kfree_rcu_cpu *krcp = container_of(work,
+		struct kfree_rcu_cpu, monitor_work.work);
+	unsigned long flags;
 	int i, j;
 
-	lockdep_assert_held(&krcp->lock);
+	raw_spin_lock_irqsave(&krcp->lock, flags);
 
+	// Attempt to start a new batch.
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
-		krwp = &(krcp->krw_arr[i]);
+		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		/*
-		 * Try to detach bkvhead or head and attach it over any
-		 * available corresponding free channel. It can be that
-		 * a previous RCU batch is in progress, it means that
-		 * immediately to queue another one is not possible so
-		 * return false to tell caller to retry.
-		 */
+		// Try to detach bkvhead or head and attach it over any
+		// available corresponding free channel. It can be that
+		// a previous RCU batch is in progress, it means that
+		// immediately to queue another one is not possible so
+		// in that case the monitor work is rearmed.
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
@@ -3423,57 +3420,28 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 
 			WRITE_ONCE(krcp->count, 0);
 
-			/*
-			 * One work is per one batch, so there are three
-			 * "free channels", the batch can handle. It can
-			 * be that the work is in the pending state when
-			 * channels have been detached following by each
-			 * other.
-			 */
+			// One work is per one batch, so there are three
+			// "free channels", the batch can handle. It can
+			// be that the work is in the pending state when
+			// channels have been detached following by each
+			// other.
 			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
-
-		// Repeat if any "free" corresponding channel is still busy.
-		if (krcp->bkvhead[0] || krcp->bkvhead[1] || krcp->head)
-			repeat = true;
 	}
 
-	return !repeat;
-}
-
-static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-					  unsigned long flags)
-{
-	// Attempt to start a new batch.
-	if (queue_kfree_rcu_work(krcp)) {
-		// Success! Our job is done here.
+	// If there is nothing to detach, it means that our job is
+	// successfully done here. In case of having at least one
+	// of the channels that is still busy we should rearm the
+	// work to repeat an attempt. Because previous batches are
+	// still in progress.
+	if (!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head)
 		krcp->monitor_todo = false;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-		return;
-	}
+	else
+		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 
-	// Previous RCU batch still in progress, try again later.
-	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
-/*
- * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
- * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
- */
-static void kfree_rcu_monitor(struct work_struct *work)
-{
-	unsigned long flags;
-	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
-						 monitor_work.work);
-
-	raw_spin_lock_irqsave(&krcp->lock, flags);
-	if (krcp->monitor_todo)
-		kfree_rcu_drain_unlock(krcp, flags);
-	else
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-}
-
 static enum hrtimer_restart
 schedule_page_work_fn(struct hrtimer *t)
 {
-- 
2.31.1.189.g2e36527f23

