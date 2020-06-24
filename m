Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55854C433E3
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3812720823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029599;
	bh=44gkBO60VbhtMZnAT43mBNScWOy3QmO50MmjS6JrwAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g/fTHKp+W1ww0rDDv6yC96nAhm5Um3ujqV/0eEksLvzh5WGa6oF624D0JYPaZE7wm
	 cWUdj5UVa+LXjhEgGc/tljTFQ23nt4mc2q7uwjAVZhPDMyTMkZNHBHzcXrdt7+SnH4
	 /5B43Wz3RNQ2JduqYe12cAF7Q/oUAIaLI0+mt/lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406503AbgFXUNS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406384AbgFXUMa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60492145D;
        Wed, 24 Jun 2020 20:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029549;
        bh=44gkBO60VbhtMZnAT43mBNScWOy3QmO50MmjS6JrwAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjUXTYy1d/vRtJWGxtMlrgZjNhZ44hinrl1EsJ0yEgFGKKrIw+FiHmb+SklHpPQ89
         KXK73u+my5voVh8v9EeyE/WLYVzvi51E0bjM1a3G1NPGmLZzpLr3sON2KARyCRJOFi
         ZHErrPXtmBngMcmOX+f4GD7cEsBsqhWj4e3h7LR8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/17] rcu/tree: Use static initializer for krc.lock
Date:   Wed, 24 Jun 2020 13:12:17 -0700
Message-Id: <20200624201226.21197-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The per-CPU variable is initialized at runtime in
kfree_rcu_batch_init(). This function is invoked before
'rcu_scheduler_active' is set to 'RCU_SCHEDULER_RUNNING'.
After the initialisation, '->initialized' is to true.

The raw_spin_lock is only acquired if '->initialized' is
set to true. The worqueue item is only used if 'rcu_scheduler_active'
set to RCU_SCHEDULER_RUNNING which happens after initialisation.

Use a static initializer for krc.lock and remove the runtime
initialisation of the lock. Since the lock can now be always
acquired, remove the '->initialized' check.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index edc512e..4fba1e9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2984,7 +2984,7 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
- * @initialized: The @lock and @rcu_work fields have been initialized
+ * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -3004,7 +3004,9 @@ struct kfree_rcu_cpu {
 	int count;
 };
 
-static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
+};
 
 static __always_inline void
 debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
@@ -3024,8 +3026,7 @@ krc_this_cpu_lock(unsigned long *flags)
 
 	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
-	if (likely(krcp->initialized))
-		raw_spin_lock(&krcp->lock);
+	raw_spin_lock(&krcp->lock);
 
 	return krcp;
 }
@@ -3033,8 +3034,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	if (likely(krcp->initialized))
-		raw_spin_unlock(&krcp->lock);
+	raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 
@@ -4260,7 +4260,6 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.9.5

