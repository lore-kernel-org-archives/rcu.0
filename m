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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B5C433DF
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8475820776
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK3e8aoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389133AbgEYVtB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731467AbgEYVsU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E10C061A0E;
        Mon, 25 May 2020 14:48:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so22214818ljo.0;
        Mon, 25 May 2020 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkR7cKj00cDqsyl0thgtTAFScjKfcm7Y5SAgEdcKqZ8=;
        b=BK3e8aoEvFZvx2GLo6YbO7z9wba+ajsVH8bD0AIo5tBZKiiEdOvmUvXq1D72AQ3D0U
         BhAlxjuRUL0CkNAeGcjpL4A1sZb0zuAKogD4IV+qMo8itIJaDnveoNdZrbyDAzUsuGf1
         ebEvHFiSdY70uJGwcfa7Y6NiawaHUmMVWj23IsqFU6dkXo/KHv7c4eWI7w7F4PLvTho3
         ZnsJqv5KSYuUZUiur7lq8L5TSZ3dbhXetGiF1t7zsYYYzBSgZITwMw2g6ubCJNVoSYO3
         JE6G50JexbrP95PxftqxaEKorF1thCAaidKm6BcoLb0Q+t4Hvb/2rBneVIQXVG2dsyG1
         Iijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkR7cKj00cDqsyl0thgtTAFScjKfcm7Y5SAgEdcKqZ8=;
        b=d3KDomf/Lx5MqH0ImsC4xaWvnXsaA47yV2r1nrHEtUTjztbkASjPm9MKo1gwnaIMV+
         GE+Vry1bDd++5jrRTH2GHqSxxLIrbJCylnBTCO253Mx1JwnQmDXQ9f9vE46JjUUDr2/E
         sQea8DdBtTKec0+EiPvrVH0ZdGNf2SSuF2xnc6cM+hsQjRkyEFJJeN+dsPlztdvNZtXf
         s4QzNElJE0YT+vTjEZZOYlt5P95GwT0ikDYizz7OfT6JKHHvmfh/HtGqrCHQnefvJ6lZ
         fmMg1GqxcU1PZ4ngscMI1Vf8P7C/BJJFSo4tW0WvEcPYLWreaQZNd6cpy0MR6pXWB1Ed
         wVeg==
X-Gm-Message-State: AOAM532HChA4dZq11kLHUOqzaEBQpZrZUwTTIEPUN5mTaXPbaOnQQHkX
        UGQQ/gbFAu2pJPxTiHqn+vEhbEVxCK3Cdg==
X-Google-Smtp-Source: ABdhPJxD27sFpaUv8BMMjBCnJmu9ZyHMVn095tD4CKJcg5exgNu/c6OWeJE4ZYEjBTu5Q8PK/El+zw==
X-Received: by 2002:a05:651c:200c:: with SMTP id s12mr13228027ljo.458.1590443298228;
        Mon, 25 May 2020 14:48:18 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:17 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 07/16] rcu/tree: Use static initializer for krc.lock
Date:   Mon, 25 May 2020 23:47:51 +0200
Message-Id: <20200525214800.93072-8-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525214800.93072-1-urezki@gmail.com>
References: <20200525214800.93072-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 kernel/rcu/tree.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c1f4b740cf14..4b1710c1d8f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2868,7 +2868,7 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
- * @initialized: The @lock and @rcu_work fields have been initialized
+ * @initialized: The @rcu_work fields have been initialized
  * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -2888,7 +2888,9 @@ struct kfree_rcu_cpu {
 	int count;
 };
 
-static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
+static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
+};
 
 static __always_inline void
 debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
@@ -2908,8 +2910,7 @@ krc_this_cpu_lock(unsigned long *flags)
 
 	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
-	if (likely(krcp->initialized))
-		raw_spin_lock(&krcp->lock);
+	raw_spin_lock(&krcp->lock);
 
 	return krcp;
 }
@@ -2917,8 +2918,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	if (likely(krcp->initialized))
-		raw_spin_unlock(&krcp->lock);
+	raw_spin_unlock(&krcp->lock);
 	local_irq_restore(flags);
 }
 
@@ -4141,7 +4141,6 @@ static void __init kfree_rcu_batch_init(void)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		raw_spin_lock_init(&krcp->lock);
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
-- 
2.20.1

