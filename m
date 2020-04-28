Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C83C83008
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E47E214D8
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiSiQD7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD1U73 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD1U72 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1FEC03C1AC;
        Tue, 28 Apr 2020 13:59:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id l19so196562lje.10;
        Tue, 28 Apr 2020 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20juLYXIkeuaSxH0ZOfDE2aYGH0+hGPgd5TgVWNgKV0=;
        b=IiSiQD7Iu4uhe8rSKiFsy+4MM1PYZAifb/4X08Jtk+cZrudizBa+RKHTmspM1N+54J
         zqJhTvKu/5RQ6kvBm1U2XnFtEFoT5WK+zwPhKmJkjxoJF7GUThJw2k4x9UKsHyN3uVGr
         t1obO+H+JCn5et6c+tkfu4seuB0gVaBP66MA3RnOVoiWWR6yNpPVLWRXguro8HTAimgy
         dWMKPS6AWlRiBSdUP8vLP6smxvt8NoPstE7Me+W9nAo+jVxPe1UXCLY3/kLTgCPzwEGN
         UqOgOltC5P1qNzlwU+eozjY3EfiF2YNtHyaDio7PldqVoXdf4YBXbYJs+pJcbBW0vSZH
         qZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20juLYXIkeuaSxH0ZOfDE2aYGH0+hGPgd5TgVWNgKV0=;
        b=D5x6PWvjIvvDkOlzC8ZGQs1HuuFnrOMAAIYq+ZZHzMOMPBOus0fb77G2T+Xoa5Thyu
         u+t26XNum7+iX54g2DUx8HqVkSpsOLhpxnfWOYze8SkK60JhOE7oeTgyGI4P9GwioFnk
         adjPimzfU7Tt84YWSUNYPyFrmUgpVj0qlFu0LSWMSU8C8LUD3tppEiX+kQed90/dXG1V
         8U+eFxUZfD2fuxvM2bYU2cXQaxJbd2iDsfCayVlVS6fQAtZHOkecmP+LixOttB5WJ2Z6
         ry/OJL3WtEiu1U2GYtJoYBqU+rGU4IbsdHZ+y6XZhlwGZZ4fkgnNxLZub0RcoLiQ3uMi
         1D8Q==
X-Gm-Message-State: AGi0Pualo/iUg5MrGqFrJlcC5JRxqSz9iTaIoY4OZUedSDoK2Sn1wILt
        b3X9NXAA9fIl/a6CSVsl0F60TabnnBY9tg==
X-Google-Smtp-Source: APiQypIzU/HDHdtBEfR5w4aVQIlns0HcLgmvrgZUF/xNsiisHjiPOjyV2oZEMK3gwdyuCi4Uq6EsKQ==
X-Received: by 2002:a19:7008:: with SMTP id h8mr20057304lfc.43.1588107566139;
        Tue, 28 Apr 2020 13:59:26 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:23 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        bigeasy@linutronix.de
Subject: [PATCH 01/24] rcu/tree: Keep kfree_rcu() awake during lock contention
Date:   Tue, 28 Apr 2020 22:58:40 +0200
Message-Id: <20200428205903.61704-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

On PREEMPT_RT kernels, contending on the krcp spinlock can cause
sleeping as on these kernels, the spinlock is converted to an rt-mutex.
To prevent breakage of possible usage of kfree_rcu() now or in the
future, make use of raw spinlocks which are not subject to such
conversions.

Vetting all code paths, there is no reason to believe that the raw
spinlock will be held for long time so PREEMPT_RT should not suffer from
lengthy acquirals of the lock.

Cc: bigeasy@linutronix.de
Cc: Uladzislau Rezki <urezki@gmail.com>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f288477ee1c2..cf68d3d9f5b8 100644
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
2.20.1

