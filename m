Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B44C433E0
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EEA2313B
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbhATEdX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:33:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbhATEdT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Jan 2021 23:33:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2504023131;
        Wed, 20 Jan 2021 04:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611117158;
        bh=+qwxBSBb+IczyNUU3GdAHlUq7F4qi8ovaYjwyWcFa3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwuzulgRU4EM73VMJuE9UNdFmPYxKDMZlKh3srSTtpEkO4+U2LOg8xXqhtF7ZuMn/
         G5H6W/Mpx6D6+hF9DmgIwJd3d+LKtRdMcsm3anv1sZ7d+QiJW1Fr6Dq24jTfGV1wk7
         MCfUWNvJMYASpqsQMoK/gfOg9LXkKtAtjhrNJZXyS93WhCax93pBnsIOp9hMp4oESi
         ucHM366aQImylZ65GbC+Ps1kekbDe25o6p4mWFxwUXblFe1HgLEzon15LhKWo/wiHB
         FB4iqiAF6q3oTI2dJrj1NwNAIpKetskLOC33YHrMzCBKmt6ynE9z/UPgYxwdpB30lV
         ac7iNJkXjkvGw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH tip/core/rcu 1/4] rcu: Expedite deboost in case of deferred quiescent state
Date:   Tue, 19 Jan 2021 20:32:33 -0800
Message-Id: <20210120043236.7254-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210120043144.GA7045@paulmck-ThinkPad-P72>
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Historically, a task that has been subjected to RCU priority boosting is
deboosted at rcu_read_unlock() time.  However, with the advent of deferred
quiescent states, if the outermost rcu_read_unlock() was invoked with
either bottom halves, interrupts, or preemption disabled, the deboosting
will be delayed for some time.  During this time, a low-priority process
might be incorrectly running at a high real-time priority level.

Fortunately, rcu_read_unlock_special() already provides mechanisms for
forcing a minimal deferral of quiescent states, at least for kernels
built with CONFIG_IRQ_WORK=y.  These mechanisms are currently used
when expedited grace periods are pending that might be blocked by the
current task.  This commit therefore causes those mechanisms to also be
used in cases where the current task has been or might soon be subjected
to RCU priority boosting.  Note that this applies to all kernels built
with CONFIG_RCU_BOOST=y, regardless of whether or not they are also
built with CONFIG_PREEMPT_RT=y.

This approach assumes that kernels build for use with aggressive real-time
applications are built with CONFIG_IRQ_WORK=y.  It is likely to be far
simpler to enable CONFIG_IRQ_WORK=y than to implement a fast-deboosting
scheme that works correctly in its absence.

While in the area, alphabetize the rcu_preempt_deferred_qs_handler()
function's local variables.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8b0feb2..fca31c6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -660,9 +660,9 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 static void rcu_read_unlock_special(struct task_struct *t)
 {
 	unsigned long flags;
+	bool irqs_were_disabled;
 	bool preempt_bh_were_disabled =
 			!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
-	bool irqs_were_disabled;
 
 	/* NMI handlers cannot block and cannot safely manipulate state. */
 	if (in_nmi())
@@ -671,30 +671,32 @@ static void rcu_read_unlock_special(struct task_struct *t)
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
 	if (preempt_bh_were_disabled || irqs_were_disabled) {
-		bool exp;
+		bool expboost; // Expedited GP in flight or possible boosting.
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		exp = (t->rcu_blocked_node &&
-		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
-		      (rdp->grpmask & READ_ONCE(rnp->expmask));
+		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
+			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
+			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
+			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
+		if (use_softirq && (in_irq() || (expboost && !irqs_were_disabled))) {
 			// Using softirq, safe to awaken, and either the
-			// wakeup is free or there is an expedited GP.
+			// wakeup is free or there is either an expedited
+			// GP in flight or a potential need to deboost.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting, slow is OK.
-			// Plus nohz_full CPUs eventually get tick enabled.
+			// Also if no expediting and no possible deboosting,
+			// slow is OK.  Plus nohz_full CPUs eventually get
+			// tick enabled.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
+			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw,
-					      rcu_preempt_deferred_qs_handler);
+				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
-- 
2.9.5

