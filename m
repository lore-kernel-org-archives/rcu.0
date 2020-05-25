Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEAAC433DF
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C51206C3
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkNESquX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgEYVsP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbgEYVsO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA11C061A0E;
        Mon, 25 May 2020 14:48:13 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c12so11162399lfc.10;
        Mon, 25 May 2020 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGk+1Dv1xZWBD45WykPdecLcAYKfFE81IWJLJfIPzl4=;
        b=YkNESquXqQUg7n7ikcJ7p3fXioH3Tb6MRVXMx68ADYtDErZ6m8ILzBiSS96gBU5/K+
         k9UbRIKwDOM3N4BQnVG/G+Tj8CfCAxkECW0eonIxdrxJC0Vx5fF7IWSYNPOe+/8UP+yt
         fJ4tdGUTbs+yFPo59NDWlvhSlCCqZFyBfIRrLpwmecehEm9mRb6yAqVBUgoerjSRTOBP
         G8E0yivmIeyNqO+QxWa/lIz721ZFs3qiyu4ayiVW9W+xMQPBkIxhCaKXQGpoxMLXDc1R
         bvj1/OuViAYkvPW7eieykUzB0ZkLpSny5Svu+2JDtcfZD4la8g0XljN0WF9w2EqxISt2
         9RPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGk+1Dv1xZWBD45WykPdecLcAYKfFE81IWJLJfIPzl4=;
        b=V1X9tEt63Zfr/NMKOvtJuqaigLvrf25zmqrQdbeWzHvFo+Mf9HFRNyEtktgT3Nwfo+
         Y/hJEYZWcUZTg+X/4kvAW6Kh4lXLBRKhc8xwHD7tK89gnrp6nbEFMcEvotAmBdUrPEPz
         yufHKhrxU8ssp/5E+N2UveW6J8dR0+o6Sv4HFfDlox48L+DY/leyNC0Fw2y0dK1f/nsR
         7SZdOQClCxZIXU9CHU95U+Y+qhgUWcy26pgqmxJLCUkcP5fRjjWVNhul+38zY6xOVzFH
         36AepKLN2H6XENpi9PNUVqxpbH9NRZzDBuQUhjPFnRYYZIEcqL5tcSuZOKfnqWohf7W0
         d8fw==
X-Gm-Message-State: AOAM532qQK3/S0c4vLihZSuViM0KrjSTCzrwrqhNk5Ifdb7da9JdgjYO
        osXch6OFCxtlGgpHLoutRzAzrWvAhBiULA==
X-Google-Smtp-Source: ABdhPJxnmRdUPLkFsmHymHpSeTqdd/iueRk3nTcSAYw1dqYbXgKIV3RatLW1vOgritqB/JVx2XTE6g==
X-Received: by 2002:a19:6b14:: with SMTP id d20mr9822238lfa.202.1590443291199;
        Mon, 25 May 2020 14:48:11 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:10 -0700 (PDT)
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
Subject: [PATCH v2 01/16] rcu/tree: Keep kfree_rcu() awake during lock contention
Date:   Mon, 25 May 2020 23:47:45 +0200
Message-Id: <20200525214800.93072-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 kernel/rcu/tree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6e120be29332..6e967a9d6704 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2882,7 +2882,7 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_bulk_data *bhead;
 	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
@@ -2915,12 +2915,12 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3023,14 +3023,14 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
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
@@ -3043,11 +3043,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3118,7 +3118,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
-		spin_lock(&krcp->lock);
+		raw_spin_lock(&krcp->lock);
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(head)) {
@@ -3149,7 +3149,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	if (krcp->initialized)
-		spin_unlock(&krcp->lock);
+		raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
@@ -3181,11 +3181,11 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
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
@@ -3212,15 +3212,15 @@ void __init kfree_rcu_scheduler_running(void)
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
 
@@ -4113,7 +4113,7 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		spin_lock_init(&krcp->lock);
+		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.20.1

