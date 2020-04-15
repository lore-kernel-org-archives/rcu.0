Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FCDC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A059206F9
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 16:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415127AbgDOQAz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:00:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51737 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414829AbgDOQAy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 12:00:54 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOkSx-0005uv-Ld; Wed, 15 Apr 2020 18:00:43 +0200
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
Subject: [PATCH 2/3] rcu: Use consistent locking around kfree_rcu_drain_unlock()
Date:   Wed, 15 Apr 2020 18:00:33 +0200
Message-Id: <20200415160034.662274-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415160034.662274-1-bigeasy@linutronix.de>
References: <20200415160034.662274-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Remove the conditional unlocking around in kfree_rcu_drain_unlock().
There is no need for this even with the _unlock() suffix.
Both callers can do the locking and unlocking.

There is no need for _irqsave(). The worker and the shrinker are always
invoked with enabled interrupts, use _irq() suffix.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5b0b63dd04b02..b31b61721a9ff 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3040,38 +3040,32 @@ static inline bool queue_kfree_rcu_work(struct kfre=
e_rcu_cpu *krcp)
 	return queued;
 }
=20
-static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
-					  unsigned long flags)
+static void kfree_rcu_drain(struct kfree_rcu_cpu *krcp)
 {
 	// Attempt to start a new batch.
 	krcp->monitor_todo =3D false;
-	if (queue_kfree_rcu_work(krcp)) {
+	if (queue_kfree_rcu_work(krcp))
 		// Success! Our job is done here.
-		spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
-	}
=20
 	// Previous RCU batch still in progress, try again later.
 	krcp->monitor_todo =3D true;
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
-	spin_unlock_irqrestore(&krcp->lock, flags);
 }
=20
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
- * It invokes kfree_rcu_drain_unlock() to attempt to start another batch.
+ * It invokes kfree_rcu_drain() to attempt to start another batch.
  */
 static void kfree_rcu_monitor(struct work_struct *work)
 {
-	unsigned long flags;
 	struct kfree_rcu_cpu *krcp =3D container_of(work, struct kfree_rcu_cpu,
 						 monitor_work.work);
=20
-	spin_lock_irqsave(&krcp->lock, flags);
+	spin_lock_irq(&krcp->lock);
 	if (krcp->monitor_todo)
-		kfree_rcu_drain_unlock(krcp, flags);
-	else
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		kfree_rcu_drain(krcp);
+	spin_unlock_irq(&krcp->lock);
 }
=20
 static inline bool
@@ -3191,18 +3185,16 @@ static unsigned long
 kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu, freed =3D 0;
-	unsigned long flags;
=20
 	for_each_online_cpu(cpu) {
 		int count;
 		struct kfree_rcu_cpu *krcp =3D per_cpu_ptr(&krc, cpu);
=20
 		count =3D krcp->count;
-		spin_lock_irqsave(&krcp->lock, flags);
+		spin_lock_irq(&krcp->lock);
 		if (krcp->monitor_todo)
-			kfree_rcu_drain_unlock(krcp, flags);
-		else
-			spin_unlock_irqrestore(&krcp->lock, flags);
+			kfree_rcu_drain(krcp);
+		spin_unlock_irq(&krcp->lock);
=20
 		sc->nr_to_scan -=3D count;
 		freed +=3D count;
--=20
2.26.0

