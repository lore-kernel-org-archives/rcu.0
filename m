Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74657C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5552561928
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKW40 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhEKW4Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD3861260;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=mPqbQCgaziZTtDwrZlZxiHfmvMUdtnSq/0nzyrOBqJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQYo37ZvtXCDgk4JcV/PMd9q0I088m/SGYoYQs9NOIfiTDjcvyF/2e/o0A/6OlIAH
         neGX8oYamykRRwyW+9HCJIl1kARYhk/zX6UjH3TnX6Bv7gzXrU0ddmHmZ4vPZvKD7h
         bEo/Sduo5R20jraGKGkG0+8REAoz6CdXfrqiRr16815VB1hp0Jzn9S7rW6F3hCJ3PZ
         TwNtBFpK/KbKppFTIq9rjFj7aMzNTwc5mB0nQtWT7wwiptNrrq8t9HNQpoZeRgVHx5
         PMTr1TCMsQ59Venxr1H285WdV8o1W/HaMinkOYXMG386NFHgBSMOMWXSpBn5T0zyBD
         yqH7EDX1PvRDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 08B9D5C014E; Tue, 11 May 2021 15:55:18 -0700 (PDT)
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
Subject: [PATCH tip/core/rcu 2/7] kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
Date:   Tue, 11 May 2021 15:55:11 -0700
Message-Id: <20210511225516.2893420-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

nr_bkv_objs is a count of the objects in the kvfree_rcu page cache.
Accessing it requires holding the ->lock.  Switch to READ_ONCE() and
WRITE_ONCE() macros to provide lockless access to this counter.
This lockless access is used for the shrinker.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 74d840aa877b..676a49ab5b2b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3250,7 +3250,7 @@ get_cached_bnode(struct kfree_rcu_cpu *krcp)
 	if (!krcp->nr_bkv_objs)
 		return NULL;
 
-	krcp->nr_bkv_objs--;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs - 1);
 	return (struct kvfree_rcu_bulk_data *)
 		llist_del_first(&krcp->bkvcache);
 }
@@ -3264,9 +3264,8 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 		return false;
 
 	llist_add((struct llist_node *) bnode, &krcp->bkvcache);
-	krcp->nr_bkv_objs++;
+	WRITE_ONCE(krcp->nr_bkv_objs, krcp->nr_bkv_objs + 1);
 	return true;
-
 }
 
 static int
@@ -3278,7 +3277,7 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	page_list = llist_del_all(&krcp->bkvcache);
-	krcp->nr_bkv_objs = 0;
+	WRITE_ONCE(krcp->nr_bkv_objs, 0);
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	llist_for_each_safe(pos, n, page_list) {
@@ -3682,18 +3681,13 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
-	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
-
-		raw_spin_lock_irqsave(&krcp->lock, flags);
-		count += krcp->nr_bkv_objs;
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
+		count += READ_ONCE(krcp->nr_bkv_objs);
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
-- 
2.31.1.189.g2e36527f23

