Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D32C54FCB
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7F3205C9
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P/kTwmQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgDTPjA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgDTPi7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 11:38:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643E0C061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:38:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z90so8775932qtd.10
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzIr8u4DpHRRhffIhSna4BhsKf3lZyZ3vmj3ZUPE2OE=;
        b=P/kTwmQ6z7Xx4aRk9mcKvEj3fqJe7JgwQU8GQZaJ7P67JgNlw7hy43SAJ8u32ykeOa
         JBQvIgfw8GfLp18TZ3Um2JtuqT35K8xy2oEhodsFo44Tu2P5EmfgOnfBPQOozzzcTqbG
         TzEi22HFUsOdKrhf0Pz+/ojZjxSZOrXuf47xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzIr8u4DpHRRhffIhSna4BhsKf3lZyZ3vmj3ZUPE2OE=;
        b=ZnYmjr5VQ5F1y0kIUh2Jfc6iKmCDk0BKauMYWdomrue1NJtmu/W+3Y4r1wwZQ+7GLc
         JecxpLhAfwKAh6WJhgOSJucgjNJk5w4Q6HS+GWxZ0Ji1105divV2Q2UMp2eU2yYEN4cx
         +tTmTQ+yRQmbQ6368FnmOZ14BOZofs58V1MYn287wIm4YYmYx+7fXhApnGHC3oiTnE/m
         m3vj6GsjUXYpn0YIn6qFg0eFV1oxAMBSWUnCDZDwZ+zyr5rw6lYB37EQdzDf7x1tQMT8
         rXj2OpQVd7rTdq4Uq5jaZz1sduR95RuJ8fvOFHgrMTxMZYiCmXg/F2ZXSvfGaO1rNwKy
         iwPg==
X-Gm-Message-State: AGi0PuYJXH4WMjig5zp6CwkkFNfV46bxT6qA7Rcdjk34K1w6D43Gp53v
        6L5dwlWudxjsLLsPpbkC1ARowg==
X-Google-Smtp-Source: APiQypLiEafuL37d+nd29LLnkdjUX7vlQnwIg5j4PuMBbxG4n/PzHLLC+Ad1XhKOmlIKntWv3WniLQ==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr16379209qtt.252.1587397138520;
        Mon, 20 Apr 2020 08:38:58 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v16sm765453qkf.80.2020.04.20.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:38:58 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        urezki@gmail.com, bigeasy@linutronix.de,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu/dev -fixes 1/4] rcu/tree: Keep kfree_rcu() awake during lock contention
Date:   Mon, 20 Apr 2020 11:38:34 -0400
Message-Id: <20200420153837.194532-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420153837.194532-1-joel@joelfernandes.org>
References: <20200420153837.194532-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On PREEMPT_RT kernels, contending on the krcp spinlock can cause
sleeping as on these kernels, the spinlock is converted to an rt-mutex.
To prevent breakage of possible usage of kfree_rcu() now or in the
future, make use of raw spinlocks which are not subject to such
conversions.

Vetting all code paths, there is no reason to believe that the raw
spinlock will be held for long time so PREEMPT_RT should not suffer from
lengthy acquirals of the lock.

Cc: urezki@gmail.com
Cc: bigeasy@linutronix.de
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477ee1c26..cf68d3d9f5b81 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2905,7 +2905,7 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_bulk_data *bhead;
 	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
@@ -2939,12 +2939,12 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3047,14 +3047,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
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
@@ -3067,11 +3067,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3142,7 +3142,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
-		spin_lock(&krcp->lock);
+		raw_spin_lock(&krcp->lock);
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(head)) {
@@ -3173,7 +3173,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	if (krcp->initialized)
-		spin_unlock(&krcp->lock);
+		raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
@@ -3205,11 +3205,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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
@@ -3236,15 +3236,15 @@ void __init kfree_rcu_scheduler_running(void)
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
 
@@ -4140,7 +4140,7 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_init(&krcp->lock);
+		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.26.1.301.g55bc3eb7cb9-goog

