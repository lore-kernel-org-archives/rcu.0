Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6DBC43600
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1279B61606
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhEKXEu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEKXEq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEB886193E;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774219;
        bh=pnNo0+6CoC3Y3VXKvc+NLxvvGAuYk+/zPk5hHwrQLjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FIfzuatAT8Xw2hgW3CytMy5KGg37mk0YMO9MsuH347B5BfOpxfMzu1mWlXhQPf67x
         gpCpCiAqNVgP0IDumgls5MQfLcsygU5phEBnNXiLzIOufJcV7gm7ODyPD+NtlkFRbh
         82d9EBr4VXNxJuee3fcEEQW3VLsORfmCTOqbvXxfgWLrk1q+8N9+vAb6njgzRAePBX
         OrUWdxjy8EL6VMXW8itFK+2Ov5+AtHzkJsZ1ouFzgv29DeerbkE0KayFOql5d0LzrR
         aecv5VAeMFeEuNQcCnFtLNy8WwlJ8LYso1V7gg9J74InJwewl4EyyU/33vfueqZVd6
         u8z2q8c4/M/HQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 673325C0DE5; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
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
Subject: [PATCH tip/core/rcu 08/10] rcu/nocb: Prepare for fine-grained deferred wakeup
Date:   Tue, 11 May 2021 16:03:34 -0700
Message-Id: <20210511230336.2894314-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Tuning the deferred wakeup level must be done from a safe wakeup
point. Currently those sites are:

* ->nocb_timer
* user/idle/guest entry
* CPU down
* softirq/rcuc

All of these sites perform the wake up for both RCU_NOCB_WAKE and
RCU_NOCB_WAKE_FORCE.

In order to merge ->nocb_timer and ->nocb_bypass_timer together, we plan
to add a new RCU_NOCB_WAKE_BYPASS that really should be deferred until
a timer fires so that we don't wake up the NOCB-gp kthread too early.

To prepare for that, this commit specifies the per-callsite wakeup
level/limit.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
[ paulmck: Fix non-NOCB rcu_nocb_need_deferred_wakeup() definition. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b2430c16..5f1545aab9ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3911,7 +3911,7 @@ static int rcu_pending(int user)
 	check_cpu_stall(rdp);
 
 	/* Does this CPU need a deferred NOCB wakeup? */
-	if (rcu_nocb_need_deferred_wakeup(rdp))
+	if (rcu_nocb_need_deferred_wakeup(rdp, RCU_NOCB_WAKE))
 		return 1;
 
 	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b280a843bd2c..2510e86265c1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -433,7 +433,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				bool *was_alldone, unsigned long flags);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
-static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp);
+static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_cpu_nocb_kthread(int cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index db28e3123f32..e2e5e4968f43 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2352,13 +2352,14 @@ static int rcu_nocb_cb_kthread(void *arg)
 }
 
 /* Is a deferred wakeup of rcu_nocb_kthread() required? */
-static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
+static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level)
 {
-	return READ_ONCE(rdp->nocb_defer_wakeup) > RCU_NOCB_WAKE_NOT;
+	return READ_ONCE(rdp->nocb_defer_wakeup) >= level;
 }
 
 /* Do a deferred wakeup of rcu_nocb_kthread(). */
-static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
+static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp,
+					   int level)
 {
 	unsigned long flags;
 	int ndw;
@@ -2367,7 +2368,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
-	if (!rcu_nocb_need_deferred_wakeup(rdp_gp)) {
+	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
 		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 		return false;
 	}
@@ -2384,7 +2385,7 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 {
 	struct rcu_data *rdp = from_timer(rdp, t, nocb_timer);
 
-	do_nocb_deferred_wakeup_common(rdp);
+	do_nocb_deferred_wakeup_common(rdp, RCU_NOCB_WAKE);
 }
 
 /*
@@ -2397,8 +2398,8 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 	if (!rdp->nocb_gp_rdp)
 		return false;
 
-	if (rcu_nocb_need_deferred_wakeup(rdp->nocb_gp_rdp))
-		return do_nocb_deferred_wakeup_common(rdp);
+	if (rcu_nocb_need_deferred_wakeup(rdp->nocb_gp_rdp, RCU_NOCB_WAKE))
+		return do_nocb_deferred_wakeup_common(rdp, RCU_NOCB_WAKE);
 	return false;
 }
 
@@ -2939,7 +2940,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 }
 
-static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
+static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level)
 {
 	return false;
 }
-- 
2.31.1.189.g2e36527f23

