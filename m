Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10EC43470
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB5E61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEKWyU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 144A36193D;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=whIQ3iED4fSPGIJAPepnQBHs4PtIh3o4kkhi3aBaxO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA9rKGsKVz0hYFot2+V6tt8JP7EbP86zvyLwBvXNhqMUfDF2kogDO/lbPKqZVJ7jV
         XR56jzDHvns0tj5x9xwepZGWAUTYmp2Kqtkx4nJ1TrHOLZeNoNdOx77gnk2NzkKyHJ
         jMh4BLxkddefwzAeSQKoOXRzEP+mssIunyr2/sywnSbEF2kp9Rfrp9tCPoTN18942V
         zI6T3zx0AIZzOsO25YecwwiCCKJgjXHiMXQfPd0Z9bDjERZivO4diCJkSyzF0WJQeV
         mmNnc+SlF7YwZqRm6DMnSMNDJtGKUZvfz2fkaisLngabYo7jWIMjX3GXNcKvML4kGi
         aRh1vNayuhHaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 97A505C0DE7; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/19] rcu: Add quiescent states and boost states to show_rcu_gp_kthreads() output
Date:   Tue, 11 May 2021 15:52:54 -0700
Message-Id: <20210511225304.2893154-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds each rcu_node structure's ->qsmask and "bBEG" output
indicating whether: (1) There is a boost kthread, (2) A reader needs
to be (or is in the process of being) boosted, (3) A reader is blocking
an expedited grace period, and (4) A reader is blocking a normal grace
period.  This helps diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h |  1 +
 kernel/rcu/tree_stall.h  | 12 +++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 71821d59d95c..5fd0c443517e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -115,6 +115,7 @@ struct rcu_node {
 				/*  boosting for this rcu_node structure. */
 	unsigned int boost_kthread_status;
 				/* State of boost_kthread_task for tracing. */
+	unsigned long n_boosts;	/* Number of boosts for this rcu_node structure. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2cbe8f8456e6..ef004cc7101d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1098,6 +1098,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
 	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
+	rnp->n_boosts++;
 
 	return READ_ONCE(rnp->exp_tasks) != NULL ||
 	       READ_ONCE(rnp->boost_tasks) != NULL;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a4e2bb3bdce7..c1f83864a18e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -749,9 +749,15 @@ void show_rcu_gp_kthreads(void)
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
 				 READ_ONCE(rnp->gp_seq_needed)))
 			continue;
-		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)data_race(rnp->gp_seq),
-			(long)data_race(rnp->gp_seq_needed));
+		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
+			rnp->grplo, rnp->grphi,
+			(long)data_race(rnp->gp_seq), (long)data_race(rnp->gp_seq_needed),
+			data_race(rnp->qsmask),
+			".b"[!!data_race(rnp->boost_kthread_task)],
+			".B"[!!data_race(rnp->boost_tasks)],
+			".E"[!!data_race(rnp->exp_tasks)],
+			".G"[!!data_race(rnp->gp_tasks)],
+			data_race(rnp->n_boosts));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
-- 
2.31.1.189.g2e36527f23

