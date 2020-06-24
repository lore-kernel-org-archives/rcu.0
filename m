Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC18C433E2
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D094C2084D
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029598;
	bh=vcy/8t17m4cgmRq5RCI0nkupUPMBoViZmO448RsmEtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gDlAFda7//SZLOZwFi83MPbj5iTxzUohfq9Mga/DY4Qx3cm3pm7ymfKQ874O4nFrn
	 lQNvnRdCz/IW5h1pwowqBf3iPwCN1OprV7RgkFrAmlKGE9k0+P6o3748cOwYyPJHl/
	 WJTo1tWNTZ1g5cmCIMhf3t9ht3M/0VjD5H7dBk/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406390AbgFXUMa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406271AbgFXUM3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F69F20885;
        Wed, 24 Jun 2020 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029548;
        bh=vcy/8t17m4cgmRq5RCI0nkupUPMBoViZmO448RsmEtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5QVpWUv1ITUGk3KanKMkAGY5dsuW8PCFyA4O74d9LDCyq3SEf7Ara0g8TBgG84DR
         x4MB2W0sjs7Mud2ztuy/i5Z8bbgL/ihOMymAGPRvOrc0x7ZlL6365nyU1I/k+yaecr
         wNtTAI/3KofCEIwfH2Ira8IqPEmSjqBgJ0G4TH1U=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        bigeasy@linutronix.de, Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/17] rcu/tree: Keep kfree_rcu() awake during lock contention
Date:   Wed, 24 Jun 2020 13:12:11 -0700
Message-Id: <20200624201226.21197-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

On PREEMPT_RT kernels, the krcp spinlock gets converted to an rt-mutex
and causes kfree_rcu() callers to sleep. This makes it unusable for
callers in purely atomic sections such as non-threaded IRQ handlers and
raw spinlock sections. Fix it by converting the spinlock to a raw
spinlock.

Vetting all code paths, there is no reason to believe that the raw
spinlock will hurt RT latencies as it is not held for a long time.

Cc: bigeasy@linutronix.de
Cc: Uladzislau Rezki <urezki@gmail.com>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 912d466..64592b4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2998,7 +2998,7 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_bulk_data *bhead;
 	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
@@ -3031,12 +3031,12 @@ static void kfree_rcu_work(struct work_struct *work)
 	krwp = container_of(to_rcu_work(work),
 			    struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
-	spin_lock_irqsave(&krcp->lock, flags);
+	raw_spin_lock_irqsave(&krcp->lock, flags);
 	head = krwp->head_free;
 	krwp->head_free = NULL;
 	bhead = krwp->bhead_free;
 	krwp->bhead_free = NULL;
-	spin_unlock_irqrestore(&krcp->lock, flags);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	/* "bhead" is now private, so traverse locklessly. */
 	for (; bhead; bhead = bnext) {
@@ -3139,14 +3139,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
 		// Success! Our job is done here.
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
 	}
 
 	// Previous RCU batch still in progress, try again later.
 	krcp->monitor_todo = true;
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
-	spin_unlock_irqrestore(&krcp->lock, flags);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 /*
@@ -3159,11 +3159,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	struct kfree_rcu_cpu *krcp = container_of(work, struct kfree_rcu_cpu,
 						 monitor_work.work);
 
-	spin_lock_irqsave(&krcp->lock, flags);
+	raw_spin_lock_irqsave(&krcp->lock, flags);
 	if (krcp->monitor_todo)
 		kfree_rcu_drain_unlock(krcp, flags);
 	else
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static inline bool
@@ -3234,7 +3234,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
-		spin_lock(&krcp->lock);
+		raw_spin_lock(&krcp->lock);
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(head)) {
@@ -3265,7 +3265,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	if (krcp->initialized)
-		spin_unlock(&krcp->lock);
+		raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
@@ -3297,11 +3297,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
-		spin_lock_irqsave(&krcp->lock, flags);
+		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
 		else
-			spin_unlock_irqrestore(&krcp->lock, flags);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 		sc->nr_to_scan -= count;
 		freed += count;
@@ -3328,15 +3328,15 @@ void __init kfree_rcu_scheduler_running(void)
 	for_each_online_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_irqsave(&krcp->lock, flags);
+		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (!krcp->head || krcp->monitor_todo) {
-			spin_unlock_irqrestore(&krcp->lock, flags);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
 		krcp->monitor_todo = true;
 		schedule_delayed_work_on(cpu, &krcp->monitor_work,
 					 KFREE_DRAIN_JIFFIES);
-		spin_unlock_irqrestore(&krcp->lock, flags);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
 
@@ -4232,7 +4232,7 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_init(&krcp->lock);
+		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.9.5

