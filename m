Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5003C43470
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B1561184
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEKWyQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhEKWyN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF98161421;
        Tue, 11 May 2021 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773586;
        bh=JVZ4K6AwP1wfBYd0STTrYWVB7kKFGknxFXL/doxIKrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYJ/JKSnG1UIfmQiOxRnT1YC08K0xs8ESMT4tn7AvIPqMBEefsInA7mayKs/g48gi
         DQO7tweKo9gop3n82wF6vRerXpP7ts8khe68VcXPmG7bJHeBWhfmbAE0y0VBQuElH7
         yTlCOAUct0Tb5Bb4P8ICQy+RDcJXUYu5auhtXewchBFWWREZDNGmVW7yNAI6ZAzhmp
         A5ebj7rV5JfSigo/GAVuBsswm3rUqO4ainZVqGV4FmQAsf+Ot5pa1OTiM0lWwgPInk
         BT/y4jHIlRquPv6da9tc7xjYjGFSQraNn71ZWrDDSfuQht4Qa6t5JD6ZotbN/czruX
         VNtNg2Lv55eIQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8CF245C09EF; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/19] rcu: Improve tree.c comments and add code cleanups
Date:   Tue, 11 May 2021 15:52:48 -0700
Message-Id: <20210511225304.2893154-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

This commit cleans up some comments and code in kernel/rcu/tree.c.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f6543b8004c0..06f3de96997c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -202,7 +202,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  * the need for long delays to increase some race probabilities with the
  * need for fast grace periods to increase other race probabilities.
  */
-#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays. */
+#define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays for debugging. */
 
 /*
  * Compute the mask of online CPUs for the specified rcu_node structure.
@@ -937,7 +937,7 @@ EXPORT_SYMBOL_GPL(rcu_idle_exit);
  */
 void noinstr rcu_user_exit(void)
 {
-	rcu_eqs_exit(1);
+	rcu_eqs_exit(true);
 }
 
 /**
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 #endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
 
 /*
- * We are reporting a quiescent state on behalf of some other CPU, so
+ * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
  * of the rcu_node ->gp_seq counter with respect to the rcu_data counters.
  * After all, the CPU might be in deep idle state, and thus executing no
@@ -2607,7 +2607,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
  * state, for example, user mode or idle loop.  It also schedules RCU
  * core processing.  If the current grace period has gone on too long,
  * it will ask the scheduler to manufacture a context switch for the sole
- * purpose of providing a providing the needed quiescent state.
+ * purpose of providing the needed quiescent state.
  */
 void rcu_sched_clock_irq(int user)
 {
@@ -3236,7 +3236,7 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->bhead_free or ->head_free.
+ * It frees all the objects queued on ->bkvhead_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
@@ -3263,7 +3263,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	krwp->head_free = NULL;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// Handle two first channels.
+	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		for (; bkvhead[i]; bkvhead[i] = bnext) {
 			bnext = bkvhead[i]->next;
@@ -3530,11 +3530,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 }
 
 /*
- * Queue a request for lazy invocation of appropriate free routine after a
- * grace period. Please note there are three paths are maintained, two are the
- * main ones that use array of pointers interface and third one is emergency
- * one, that is used only when the main path can not be maintained temporary,
- * due to memory pressure.
+ * Queue a request for lazy invocation of the appropriate free routine
+ * after a grace period.  Please note that three paths are maintained,
+ * two for the common case using arrays of pointers and a third one that
+ * is used only when the main paths cannot be used, for example, due to
+ * memory pressure.
  *
  * Each kvfree_call_rcu() request is added to a batch. The batch will be drained
  * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
@@ -4708,7 +4708,7 @@ void __init rcu_init(void)
 		rcutree_online_cpu(cpu);
 	}
 
-	/* Create workqueue for expedited GPs and for Tree SRCU. */
+	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-- 
2.31.1.189.g2e36527f23

