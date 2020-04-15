Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9358AC2BB55
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E38C206F9
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415129AbgDOQAx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:00:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51720 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415122AbgDOQAv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 12:00:51 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOkSx-0005uv-AF; Wed, 15 Apr 2020 18:00:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] rcu: Use static initializer for krc.lock
Date:   Wed, 15 Apr 2020 18:00:32 +0200
Message-Id: <20200415160034.662274-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415160034.662274-1-bigeasy@linutronix.de>
References: <20200415160034.662274-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The per-CPU variable is initialized at runtime in
kfree_rcu_batch_init(). This function is invoked before
`rcu_scheduler_active' is set to `RCU_SCHEDULER_RUNNING'. After the
initialisation, `->initialized' is to true.

The spin_lock is only acquired if `->initialized' is set to true. The
worqueue item is only used if `rcu_scheduler_active' set to
RCU_SCHEDULER_RUNNING' which happens after initialisation.

Use a static initializer for krc.lock and remove the runtime
initialisation of the lock. Since the lock can now be always acquired,
remove the `->initialized' check.
The local_irq_save() is removed and raw_cpu_ptr() + spin_lock_irqsave()
is used. The worst case scenario is that after raw_cpu_ptr() the code
has been moved to another CPU. This is "okay" because the data strucure
itself is protected with a lock.
Add a warning in kfree_rcu_batch_init() to ensure that this function is
invoked before `RCU_SCHEDULER_RUNNING' to ensure that the worker is not
used earlier.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477ee1c26..5b0b63dd04b02 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2893,7 +2893,6 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
- * @initialized: The @lock and @rcu_work fields have been initialized
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -2908,12 +2907,13 @@ struct kfree_rcu_cpu {
 	spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
-	bool initialized;
 	// Number of objects for which GP not started
 	int count;
 };
=20
-static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) =3D {
+	.lock	=3D __SPIN_LOCK_UNLOCKED(krc.lock),
+};
=20
 static __always_inline void
 debug_rcu_head_unqueue_bulk(struct rcu_head *head)
@@ -3080,9 +3080,6 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *=
krcp,
 {
 	struct kfree_rcu_bulk_data *bnode;
=20
-	if (unlikely(!krcp->initialized))
-		return false;
-
 	lockdep_assert_held(&krcp->lock);
=20
 	/* Check if a new block is required. */
@@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callb=
ack_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
=20
-	local_irq_save(flags);	// For safely calling this_cpu_ptr().
-	krcp =3D this_cpu_ptr(&krc);
-	if (krcp->initialized)
-		spin_lock(&krcp->lock);
+	krcp =3D raw_cpu_ptr(&krc);
+	spin_lock_irqsave(&krcp->lock, flags);
=20
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(head)) {
@@ -3172,9 +3167,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callba=
ck_t func)
 	}
=20
 unlock_return:
-	if (krcp->initialized)
-		spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&krcp->lock, flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
=20
@@ -4137,17 +4130,16 @@ static void __init kfree_rcu_batch_init(void)
 	int cpu;
 	int i;
=20
+	WARN_ON(rcu_scheduler_active =3D=3D RCU_SCHEDULER_RUNNING);
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, cpu);
=20
-		spin_lock_init(&krcp->lock);
 		for (i =3D 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp =3D krcp;
 		}
=20
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		krcp->initialized =3D true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
 		pr_err("Failed to register kfree_rcu() shrinker!\n");
--=20
2.26.0

