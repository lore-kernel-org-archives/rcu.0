Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC52C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075BE64EA4
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhCDBBI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1450979AbhCDA0u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 291D464E2E;
        Thu,  4 Mar 2021 00:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817594;
        bh=+GBdYJSR46rekQeBYnYr5OD6KmiT2KIfh+2gyAHrJkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+aBikY9O5FxuRG+7k+5K1H3Mw4EGHQoZg6b2GrzhK3ZYIwNP/H4qdx2j0bINIOVa
         MVDwSLFa+gr1qLe4ow7CZtVslvgI04ZmOXGTmMJRQq4/3sS+1ofYN1o8tOq63hoKx/
         W1bvswLWCjq/ARyAENLZl1fTkO2atxD/X5QWwdmgQrXcnvfX0R/fhHsVQYXwhnyO+z
         2uv4ZuKKBRd/Jh7ykoG0UvQrGODfe1CJFNFfxu36Y3c+Z8exg8N/k/V+BLsw8NJyCp
         0Y+nOZW4CnqHLTyg3nJZSqtFImIMnD2yJErGG1r+/1uKfKmOZ1/eO0ObpNWVKY1cCJ
         LzYjM8OX9YhHQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/3] rcu: Provide polling interfaces for Tiny RCU grace periods
Date:   Wed,  3 Mar 2021 16:26:31 -0800
Message-Id: <20210304002632.23870-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002605.GA23785@paulmck-ThinkPad-P72>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a need for a non-blocking polling interface for RCU grace
periods, so this commit supplies start_poll_synchronize_rcu() and
poll_state_synchronize_rcu() for this purpose.  Note that the existing
get_state_synchronize_rcu() may be used if future grace periods are
inevitable (perhaps due to a later call_rcu() invocation).  The new
start_poll_synchronize_rcu() is to be used if future grace periods
might not otherwise happen.  Finally, poll_state_synchronize_rcu()
provides a lockless check for a grace period having elapsed since
the corresponding call to either of the get_state_synchronize_rcu()
or start_poll_synchronize_rcu().

As with get_state_synchronize_rcu(), the return value from either
get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
to a later call to either poll_state_synchronize_rcu() or the existing
(might_sleep) cond_synchronize_rcu().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 11 ++++++-----
 kernel/rcu/tiny.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 2a97334..69108cf4 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -17,14 +17,15 @@
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
 
-static inline unsigned long get_state_synchronize_rcu(void)
-{
-	return 0;
-}
+unsigned long get_state_synchronize_rcu(void);
+unsigned long start_poll_synchronize_rcu(void);
+bool poll_state_synchronize_rcu(unsigned long oldstate);
 
 static inline void cond_synchronize_rcu(unsigned long oldstate)
 {
-	might_sleep();
+	if (poll_state_synchronize_rcu(oldstate))
+		return;
+	synchronize_rcu();
 }
 
 extern void rcu_barrier(void);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index aa897c3..c8a029f 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -32,12 +32,14 @@ struct rcu_ctrlblk {
 	struct rcu_head *rcucblist;	/* List of pending callbacks (CBs). */
 	struct rcu_head **donetail;	/* ->next pointer of last "done" CB. */
 	struct rcu_head **curtail;	/* ->next pointer of last CB. */
+	unsigned long gp_seq;		/* Grace-period counter. */
 };
 
 /* Definition for rcupdate control block. */
 static struct rcu_ctrlblk rcu_ctrlblk = {
 	.donetail	= &rcu_ctrlblk.rcucblist,
 	.curtail	= &rcu_ctrlblk.rcucblist,
+	.gp_seq		= 0 - 300UL,
 };
 
 void rcu_barrier(void)
@@ -56,6 +58,7 @@ void rcu_qs(void)
 		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
 		raise_softirq_irqoff(RCU_SOFTIRQ);
 	}
+	WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 1);
 	local_irq_restore(flags);
 }
 
@@ -177,6 +180,43 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+/*
+ * Return a grace-period-counter "cookie".  For more information,
+ * see the Tree RCU header comment.
+ */
+unsigned long get_state_synchronize_rcu(void)
+{
+	return READ_ONCE(rcu_ctrlblk.gp_seq);
+}
+EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
+
+/*
+ * Return a grace-period-counter "cookie" and ensure that a future grace
+ * period completes.  For more information, see the Tree RCU header comment.
+ */
+unsigned long start_poll_synchronize_rcu(void)
+{
+	unsigned long gp_seq = get_state_synchronize_rcu();
+
+	if (unlikely(is_idle_task(current))) {
+		/* force scheduling for rcu_qs() */
+		resched_cpu(0);
+	}
+	return gp_seq;
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
+
+/*
+ * Return true if the grace period corresponding to oldstate has completed
+ * and false otherwise.  For more information, see the Tree RCU header
+ * comment.
+ */
+bool poll_state_synchronize_rcu(unsigned long oldstate)
+{
+	return READ_ONCE(rcu_ctrlblk.gp_seq) != oldstate;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
-- 
2.9.5

