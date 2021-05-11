Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CF8C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4786192B
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhEKW42 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhEKW40 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:56:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB7CE61937;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=P/8AFhRlFg6AWceemV1wsSjoIzubJn3jrj3JfmvPyDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP5oXuykx2zmZSL2bRH5SDhH9ltj/tYqHtxjSSVz5s9y3sauUQahW3mJMWZYsvgrF
         H4w81P5PSV9EwjPsbNVofsjHlfmcPkuINrGLO5noIDKxqDZgb/j9HClQ5B8g9xXxam
         5P9dNHI8v+K+qUbTuqgsOof+u2q/SuwLb4flQo9XdFJ1DBpL/qRO4+YxYeUy4b15/j
         Dq1Gy0bTe/x8gbu4pfBvBz9YA5d9F7kAg7QExI/lr7ZTy+NgogvxEuVpSwyt3ZHj/J
         40H8/3Se0S/KgkzTc/sBBeB5X1rfmvXAEFgyGUKQvss5LSsaJwsMeWELKejmuXt0Yt
         pQSkV2IYIzVRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 10D405C0DB3; Tue, 11 May 2021 15:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 6/7] kvfree_rcu: Fix comments according to current code
Date:   Tue, 11 May 2021 15:55:15 -0700
Message-Id: <20210511225516.2893420-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() function now defers allocations in the common
case due to the fact that there is no lockless access to the
memory-allocator caches/pools.  In addition, in CONFIG_PREEMPT_NONE=y
and in CONFIG_PREEMPT_VOLUNTARY=y kernels, there is no reliable way to
determine if spinlocks are held.  As a result, allocation is deferred in
the common case, and the two-argument form of kvfree_rcu() thus uses the
"channel 3" queue through all the rcu_head structures.  This channel
is called referred to as the emergency case in comments, and these
comments are now obsolete.

This commit therefore updates these comments to reflect the new
common-case nature of such emergencies.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d643fd8327b6..b043af7b0212 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3355,9 +3355,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * Emergency case only. It can happen under low memory
-	 * condition when an allocation gets failed, so the "bulk"
-	 * path can not be temporary maintained.
+	 * This is used when the "bulk" path can not be used for the
+	 * double-argument of kvfree_rcu().  This happens when the
+	 * page-cache is empty, which means that objects are instead
+	 * queued on a linked list through their rcu_head structures.
+	 * This list is named "Channel 3".
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
@@ -3403,8 +3405,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
 			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
 				(krcp->head && !krwp->head_free)) {
-			// Channel 1 corresponds to SLAB ptrs.
-			// Channel 2 corresponds to vmalloc ptrs.
+			// Channel 1 corresponds to the SLAB-pointer bulk path.
+			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
 				if (!krwp->bkvhead_free[j]) {
 					krwp->bkvhead_free[j] = krcp->bkvhead[j];
@@ -3412,7 +3414,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 				}
 			}
 
-			// Channel 3 corresponds to emergency path.
+			// Channel 3 corresponds to both SLAB and vmalloc
+			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				krcp->head = NULL;
-- 
2.31.1.189.g2e36527f23

