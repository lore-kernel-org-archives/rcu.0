Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7371C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB53022D01
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbhAFEvB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbhAFEu6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A15822EBD;
        Wed,  6 Jan 2021 04:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908539;
        bh=5SeAK+bq0bQ/1fswjZJ7SP6VISQRi8xTmdWNusdE4MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHoF+r0szJOAFdzUMLKdChPv19XGUawu3K4Y91ff1VBZM+FUYIxjq+nEGyMQ4ACxj
         +22eqL6FHh1K0MP0A6BkemFJYQfGI0fFDjtf4Wp3KoUj9A3bWK6xKaRPXRKXxgfWQN
         YWnFqGWbKspXy3jmjVTenhlJNK8GH+aW1r8V/xHSwAAg4fkRphqaueRZOCDwmm++VQ
         fz1+7rtgz6hbb3wDdAoaRQH//ROe3dFPSggwJF6tgsr+GuaF7vLs3PDbN80S1x/k3A
         4MUkbE8LFNB28t2G6C3iG1OGkDay0qC6f17BTbpgLJMQRP8C4q4RIeWbZ++xyzNLT6
         Lf0IqTVaKspHQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH tip/core/rcu 20/21] rcu/nocb: Code-style nits in callback-offloading toggling
Date:   Tue,  5 Jan 2021 20:48:52 -0800
Message-Id: <20210106044853.20812-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit addresses a few code-style nits in callback-offloading
toggling, including one that predates this toggling.

Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 19 ++++++-------------
 kernel/rcu/tree_plugin.h   | 10 +++++-----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 3110602..9a19328 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -80,17 +80,12 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 	return rcu_segcblist_test_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
-/* Is the specified rcu_segcblist offloaded?  */
+/* Is the specified rcu_segcblist offloaded, or is SEGCBLIST_SOFTIRQ_ONLY set? */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
-		/*
-		 * Complete de-offloading happens only when SEGCBLIST_SOFTIRQ_ONLY
-		 * is set.
-		 */
-		if (!rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
-			return true;
-	}
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+	    !rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
+		return true;
 
 	return false;
 }
@@ -99,10 +94,8 @@ static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rscl
 {
 	int flags = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP | SEGCBLIST_OFFLOADED;
 
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
-		if ((rsclp->flags & flags) == flags)
-			return true;
-	}
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) && (rsclp->flags & flags) == flags)
+		return true;
 
 	return false;
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bc63a6b..0ad278d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2160,11 +2160,11 @@ static inline bool nocb_cb_wait_cond(struct rcu_data *rdp)
 static void nocb_cb_wait(struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
-	struct rcu_node *rnp = rdp->mynode;
-	bool needwake_state = false;
-	bool needwake_gp = false;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
+	bool needwake_state = false;
+	bool needwake_gp = false;
+	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
 	rcu_momentary_dyntick_idle();
@@ -2217,8 +2217,8 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		swait_event_interruptible_exclusive(rdp->nocb_cb_wq,
 						    nocb_cb_wait_cond(rdp));
 
-		/* ^^^ Ensure CB invocation follows _sleep test. */
-		if (smp_load_acquire(&rdp->nocb_cb_sleep)) {
+		// VVV Ensure CB invocation follows _sleep test.
+		if (smp_load_acquire(&rdp->nocb_cb_sleep)) { // ^^^
 			WARN_ON(signal_pending(current));
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WokeEmpty"));
 		}
-- 
2.9.5

