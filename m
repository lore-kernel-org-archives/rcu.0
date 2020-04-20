Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE0C3A5A0
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5183B206F6
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="o4NRn4JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgDTPjE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbgDTPjD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 11:39:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FF3C061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:39:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n143so4264958qkn.8
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFEegOkRkgzNWH99LAz5UD+7pvzI0C268KrZLWuLXCg=;
        b=o4NRn4JAgFegFAu759F/q6NnIEAvyAJ32WBrRjeWYfKzAmN4tTnJAhrW4JasTVXCZL
         /JN6NNgHJh3iug7lJ3wuYFr8fZQdZ1TJGQKBuU735iap0JuGhFgi9wGdmWxdLAPw83uz
         MrtN9gg0tedwtCUY+rzN4556Nnnx7TnkJKqPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFEegOkRkgzNWH99LAz5UD+7pvzI0C268KrZLWuLXCg=;
        b=SOkbphIQQbagTgJ214yUZoBHkpweLVgk5QB8Xcp+cS2yy2LZmSLfG9GU9+iLgeGKdR
         yHn5cS40ZX1pAqWK2S3HEh6cRFFFCmLjCnZh6Wdm2PchRam2mNHinuOoL9fkAT036QgQ
         T11xZ2mbmyd6UhmbXXNwBrS/bAHJzwJGiQ2ExVeqU5LQJFB11peF0u7qhhl8veFmHnMD
         aaQWSJvVAkvHgLx3DvksD3aWoPfiI1/VyAGXQkzqarZQjRyyJhJg5ZuUEsWOUsS0N9Gz
         gqZC0fXmRCxA2+qEx2jhyaLJNiyGuG4vbNfvuq5xAWLB/FD/1ESRDQMAu64RLNZmMbhB
         SdbA==
X-Gm-Message-State: AGi0PuaFFi72Qu7GP/9xotxdnJp9z96vTpVHUCqyu3FUV1EyxcmSePkJ
        tcaW+nHp6pErQLuIYix85asUfg==
X-Google-Smtp-Source: APiQypI1at+yjYliDzC4blE0RN6iupG+CCoWb71o1Y8a5j9OvmDeY3Iz7Y/tKHh0FtnTXpg8izbHDg==
X-Received: by 2002:ae9:e014:: with SMTP id m20mr13721065qkk.200.1587397142052;
        Mon, 20 Apr 2020 08:39:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v16sm765453qkf.80.2020.04.20.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:39:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        bigeasy@linutronix.de, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH rcu/dev -fixes 4/4] rcu/tree: Use consistent style for comments
Date:   Mon, 20 Apr 2020 11:38:37 -0400
Message-Id: <20200420153837.194532-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420153837.194532-1-joel@joelfernandes.org>
References: <20200420153837.194532-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Simple clean up of comments in kfree_rcu() code to keep it consistent
with majority of commenting styles.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f6eb3aee0935e..0512e0f9e2f31 100644
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
@@ -3152,14 +3152,14 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
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
@@ -3177,7 +3177,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
-	// Set timer to drain after KFREE_DRAIN_JIFFIES.
+	/* Set timer to drain after KFREE_DRAIN_JIFFIES. */
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
 		krcp->monitor_todo = true;
@@ -3723,7 +3723,7 @@ int rcutree_offline_cpu(unsigned int cpu)
 
 	rcutree_affinity_setting(cpu, cpu);
 
-	// nohz_full CPUs need the tick for stop-machine to work quickly
+	/* nohz_full CPUs need the tick for stop-machine to work quickly */
 	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
 }
-- 
2.26.1.301.g55bc3eb7cb9-goog

