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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9222CC83000
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675362072A
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OomEXmvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD1U7i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbgD1U7f (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77CC03C1AC;
        Tue, 28 Apr 2020 13:59:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so244318ljp.4;
        Tue, 28 Apr 2020 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNVlKJMZgR8fQGfjNMGlZb0HEXGPqeGS+UCAapReQEQ=;
        b=OomEXmvEimxM1FQU4RZxUQQ6SUm/0rWP04XnM3tyK2N2EVh5hEe+B/wMbpSMFBO2a9
         zfvlE9oG69hOjkwDFfbhn04b0dqQhaPQy92gtamKdDddFXpGJDjR9LDP+4SvN088uTqd
         NN6OYVKWiMckLURyeMjSjqHjcvw0JBhne90WJ384rFV9oE0z5/6+C/NnQNc1krfDkLA7
         DJxLLSbGJOr+kvsKBrxkNkuec+OX1hgRGUPxQbLAUysbTLkm0JAI2Uyu/sWJAuIKOWgd
         F8mQ4JZhQa2Fqd1JAKFuF9bJC8vT4eyTlM9tV9lfACk02DBS0Ayjt9+uDFljqVo1Ne2T
         BJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNVlKJMZgR8fQGfjNMGlZb0HEXGPqeGS+UCAapReQEQ=;
        b=ivgwpI/Eo2rfxk2YmQYlaOQBrTVyktUJRMYTBn07K8BlbV3DaNw7IfHJ134dZXfh6l
         A5CmHPKe1zefVwYnnPSkFxml5npqwaePlkjXWopks+Bjcs+rfTgx7TvALz5Ji7K+5FKU
         hSOtfFVs/z4zl55NxzUyz9UGjQOfwjIVj8O+/zWNhfRMqFXZ6FI6jUOVzKSGxBlr2V9R
         liLCap88mGTHdcl7MChto1tsJvsC9ke7a0Q5YyM+iv1Emj0L8b9p/C9C3ExAIH6XiLVV
         l0A6elNglUBFX9yUNgl3g2jMlZnLrb0xU+kBWRixUJ7YwRkj1topwF3P4oOtTbo1zJgq
         N91A==
X-Gm-Message-State: AGi0PuaqhlZgMQz7a23AfdZItjC1KmRzN2sRf0rxbE3Agid7BGMyaxfG
        wUUJZIlblCkcEdBSp7yJk9r4A3XbaIGwjQ==
X-Google-Smtp-Source: APiQypLM6AK8jKHmA2nJzuwDkDwYvmAhNNN+CNoOBiRU/u2OgnsIOG3G2+TrSv7A9npS7PRZThXzUA==
X-Received: by 2002:a19:f614:: with SMTP id x20mr20240048lfe.84.1588107571728;
        Tue, 28 Apr 2020 13:59:31 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:31 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 03/24] rcu/tree: Use consistent style for comments
Date:   Tue, 28 Apr 2020 22:58:42 +0200
Message-Id: <20200428205903.61704-4-urezki@gmail.com>
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

Simple clean up of comments in kfree_rcu() code to keep it consistent
with majority of commenting styles.

Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cd61649e1b00..1487af8e11e8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3043,15 +3043,15 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
 					  unsigned long flags)
 {
-	// Attempt to start a new batch.
+	/* Attempt to start a new batch. */
 	krcp->monitor_todo = false;
 	if (queue_kfree_rcu_work(krcp)) {
-		// Success! Our job is done here.
+		/* Success! Our job is done here. */
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 		return;
 	}
 
-	// Previous RCU batch still in progress, try again later.
+	/* Previous RCU batch still in progress, try again later. */
 	krcp->monitor_todo = true;
 	schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
@@ -3151,14 +3151,14 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 
-	local_irq_save(flags);	// For safely calling this_cpu_ptr().
+	local_irq_save(flags);	/* For safely calling this_cpu_ptr(). */
 	krcp = this_cpu_ptr(&krc);
 	if (krcp->initialized)
 		raw_spin_lock(&krcp->lock);
 
-	// Queue the object but don't yet schedule the batch.
+	/* Queue the object but don't yet schedule the batch. */
 	if (debug_rcu_head_queue(head)) {
-		// Probable double kfree_rcu(), just leak.
+		/* Probable double kfree_rcu(), just leak. */
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
 		goto unlock_return;
@@ -3176,7 +3176,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
-	// Set timer to drain after KFREE_DRAIN_JIFFIES.
+	/* Set timer to drain after KFREE_DRAIN_JIFFIES. */
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
 		krcp->monitor_todo = true;
@@ -3722,7 +3722,7 @@ int rcutree_offline_cpu(unsigned int cpu)
 
 	rcutree_affinity_setting(cpu, cpu);
 
-	// nohz_full CPUs need the tick for stop-machine to work quickly
+	/* nohz_full CPUs need the tick for stop-machine to work quickly */
 	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
 }
-- 
2.20.1

