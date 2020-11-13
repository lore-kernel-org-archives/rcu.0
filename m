Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD6C388F7
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147B322240
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 12:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdgSjKpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKMMN5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgKMMNv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 07:13:51 -0500
Received: from localhost.localdomain (unknown [176.167.84.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860492224C;
        Fri, 13 Nov 2020 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605269630;
        bh=ccgSkJ3Yla91kA4Y5xWUxT9tu1mqAsnEtc751dXwb+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tdgSjKpvlonC8454XodD+XHug6pUeYLjnRRSZrRh6Sd1hSV/j5knVFe2jnGky9zmi
         qHU9v6e8ern8+s+bU6PDQv9TSqsxjik/h7vuPYZWz6eeI0eiEJMpYD0+VbmAeowwTE
         XsRrNup14rN3NN9Dih18ClrVGyFMsRIRVUMbjBZo=
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
Subject: [PATCH 02/19] rcu/nocb: Provide basic callback offloading state machine bits
Date:   Fri, 13 Nov 2020 13:13:17 +0100
Message-Id: <20201113121334.166723-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We'll need to be able to runtime offload and de-offload the processing
of callback for a given CPU. In order to support a smooth transition
from unlocked local processing (softirq/rcuc) to locked offloaded
processing (rcuop/rcuog) and the reverse, provide the necessary bits and
documentation for the state machine that will carry up all the steps to
enforce correctness while serving callbacks processing all along.

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
 include/linux/rcu_segcblist.h | 115 +++++++++++++++++++++++++++++++++-
 kernel/rcu/rcu_segcblist.c    |   1 +
 kernel/rcu/rcu_segcblist.h    |  12 +++-
 kernel/rcu/tree.c             |   3 +
 4 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 4714b0263c76..4ca08b089faf 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -63,8 +63,121 @@ struct rcu_cblist {
 #define RCU_NEXT_TAIL		3
 #define RCU_CBLIST_NSEGS	4
 
+
+/*
+ *                     ==NOCB Offloading state machine==
+ *
+ *
+ *  ----------------------------------------------------------------------------
+ *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                                                                          |
+ *  |  Callbacks processed by rcu_core() from softirqs or local                |
+ *  |  rcuc kthread, without holding nocb_lock.                                |
+ *  ----------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *  ----------------------------------------------------------------------------
+ *  |                        SEGCBLIST_OFFLOADED                               |
+ *  |                                                                          |
+ *  | Callbacks processed by rcu_core() from softirqs or local                 |
+ *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads,     |
+ *  | allowing nocb_timer to be armed.                                        |
+ *  ----------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *                        -----------------------------------
+ *                        |                                 |
+ *                        v                                 v
+ *  ---------------------------------------  ----------------------------------|
+ *  |        SEGCBLIST_OFFLOADED |        |  |     SEGCBLIST_OFFLOADED |       |
+ *  |        SEGCBLIST_KTHREAD_CB         |  |     SEGCBLIST_KTHREAD_GP        |
+ *  |                                     |  |                                 |
+ *  |                                     |  |                                 |
+ *  | CB kthread woke up and              |  | GP kthread woke up and          |
+ *  | acknowledged SEGCBLIST_OFFLOADED.   |  | acknowledged SEGCBLIST_OFFLOADED|
+ *  | Processes callbacks concurrently    |  |                                 |
+ *  | with rcu_core(), holding            |  |                                 |
+ *  | nocb_lock.                          |  |                                 |
+ *  ---------------------------------------  -----------------------------------
+ *                        |                                 |
+ *                        -----------------------------------
+ *                                         |
+ *                                         v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
+ *  |   handling callbacks.                                                    |
+ *  ----------------------------------------------------------------------------
+ */
+
+
+
+/*
+ *                       ==NOCB De-Offloading state machine==
+ *
+ *
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
+ *  |   ignores callbacks.                                                     |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *                     -----------------------------------
+ *                     |                                 |
+ *                     v                                 v
+ *  ---------------------------------------------------------------------------|
+ *  |                                                                          |
+ *  |        SEGCBLIST_KTHREAD_CB         |       SEGCBLIST_KTHREAD_GP         |
+ *  |                                     |                                    |
+ *  | GP kthread woke up and              |   CB kthread woke up and           |
+ *  | acknowledged the fact that          |   acknowledged the fact that       |
+ *  | SEGCBLIST_OFFLOADED got cleared.    |   SEGCBLIST_OFFLOADED got cleared. |
+ *  |                                     |   The CB kthread goes to sleep     |
+ *  | The callbacks from the target CPU   |   until it ever gets re-offloaded. |
+ *  | will be ignored from the GP kthread |                                    |
+ *  | loop.                               |                                    |
+ *  ----------------------------------------------------------------------------
+ *                      |                                 |
+ *                      -----------------------------------
+ *                                      |
+ *                                      v
+ *  ----------------------------------------------------------------------------
+ *  |                                   0                                      |
+ *  |                                                                          |
+ *  | Callbacks processed by rcu_core() from softirqs or local                 |
+ *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
+ *  | Flush pending nocb_timer. Flush nocb bypass callbacks.                   |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  ----------------------------------------------------------------------------
+ *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                                                                          |
+ *  |  Callbacks processed by rcu_core() from softirqs or local                |
+ *  |  rcuc kthread, without holding nocb_lock.                                |
+ *  ----------------------------------------------------------------------------
+ */
 #define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_OFFLOADED	BIT(1)
+#define SEGCBLIST_SOFTIRQ_ONLY	BIT(1)
+#define SEGCBLIST_KTHREAD_CB	BIT(2)
+#define SEGCBLIST_KTHREAD_GP	BIT(3)
+#define SEGCBLIST_OFFLOADED	BIT(4)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index e374f9c3ec2c..d7cb9dc044ea 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -254,6 +254,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
 	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 3d1195dbf030..70e108c0e7c9 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -80,8 +80,16 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED);
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
+		/*
+		 * Complete de-offloading happens only when SEGCBLIST_SOFTIRQ_ONLY
+		 * is set.
+		 */
+		if (!rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
+			return true;
+	}
+
+	return false;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 413831b48648..48e8e63cdeb2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -83,6 +83,9 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+#ifdef CONFIG_RCU_NOCB_CPU
+	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
+#endif
 };
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
-- 
2.25.1

