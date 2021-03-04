Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AABC43381
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F2A64F80
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhCDBA7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448485AbhCDAZz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86AC164EE3;
        Thu,  4 Mar 2021 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817394;
        bh=ACmOLMPxBxJ21CKaJHWqFcZB8U+4BbhPAyA/yBe7XrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdwkPSwCFv99Jf1fclwG4SQTeeORV1GkyzEKQ/Cv/G6JCO4NlAQoJZOE7ClYnxniI
         ClQ9TBLhgrrR52ZQZgLuJ7lb4/r6goBPOHrS5n3ngARP1EU9GFPaBfh9M7yGchRNDN
         JFtCoRP8jwy+xiIHsOzLX4lsUa1XxOobTwaYY/9+K5qiios1VXJOmBU8cMWU6mwSAx
         0tuQg8+2TOyOvvXjAf52O3aYEIdwLtbEY6e6wDipHiL7QfDdi/gfuOBMSJV8mSngcw
         68wougs89eqqhwYD/A8fas/di/tCn3HIRJiVOO6gU9a1gX/B4leg7yd8IKv4XeDwhP
         XwRjcY4wYzRzA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/12] rcu/nocb: Rename nocb_gp_update_state to nocb_gp_update_state_deoffloading
Date:   Wed,  3 Mar 2021 16:23:06 -0800
Message-Id: <20210304002311.23655-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The name nocb_gp_update_state() is unenlightening, so this commit changes
it to nocb_gp_update_state_deoffloading().  This function now does what
its name says, updates state and returns true if the CPU corresponding to
the specified rcu_data structure is in the process of being de-offloaded.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6a7f77d..93d3938 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2016,7 +2016,8 @@ static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
 	return rcu_segcblist_test_flags(&rdp->cblist, flags);
 }
 
-static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_state)
+static inline bool nocb_gp_update_state_deoffloading(struct rcu_data *rdp,
+						     bool *needwake_state)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
 
@@ -2026,7 +2027,7 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
 				*needwake_state = true;
 		}
-		return true;
+		return false;
 	}
 
 	/*
@@ -2037,7 +2038,7 @@ static inline bool nocb_gp_update_state(struct rcu_data *rdp, bool *needwake_sta
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
 	if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
 		*needwake_state = true;
-	return false;
+	return true;
 }
 
 
@@ -2075,7 +2076,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			continue;
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
-		if (!nocb_gp_update_state(rdp, &needwake_state)) {
+		if (nocb_gp_update_state_deoffloading(rdp, &needwake_state)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			if (needwake_state)
 				swake_up_one(&rdp->nocb_state_wq);
-- 
2.9.5

