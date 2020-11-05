Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B9FC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF09520719
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604617765;
	bh=cLiAusonPv4tCQb0QUWkF5lsOrakxhbxXbRLovsOtas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFJ7mAbTVGVPVneNCAc47vpGspheI/WwyWAqeAugL4LOp1uRSPQrlehE6a8mjkVAX
	 pSZGgnPSE3RbJJnF9N/oNf7cWIK6duysX+BxNNnFVWtEC9L4sUdIxeP8fdF6xAOJ+4
	 sLdVGYg3MzhIqmOLitWeoPrx0Zfimn9/w96jlJGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgKEXJZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXJY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:09:24 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F74920715;
        Thu,  5 Nov 2020 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604617763;
        bh=cLiAusonPv4tCQb0QUWkF5lsOrakxhbxXbRLovsOtas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJQdcD1aw6BRs37FdhQuxUotiIFH8Mb7rRArI4oar9fC0luu1RL0yWRtpDAzdBcgm
         s699IHQ2o9xZ0EHTtu2o4aahUKIMOEXAkGbV6nvM+THmGpila7vG7uv5sXlIM3BZoD
         t/HmHap28uUmY7SfYXwMvy85iYje4FuJ48q4tWa0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/16] rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
Date:   Thu,  5 Nov 2020 15:09:06 -0800
Message-Id: <20201105230921.19017-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105230856.GA18904@paulmck-ThinkPad-P72>
References: <20201105230856.GA18904@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The try_invoke_on_locked_down_task() function requires that
interrupts be enabled, but it is called with interrupts disabled from
rcu_print_task_stall(), resulting in an "IRQs not enabled as expected"
diagnostic.  This commit therefore updates rcu_print_task_stall()
to accumulate a list of the first few tasks while holding the current
leaf rcu_node structure's ->lock, then releases that lock and only then
uses try_invoke_on_locked_down_task() to attempt to obtain per-task
detailed information.  Of course, as soon as ->lock is released, the
task might exit, so the get_task_struct() function is used to prevent
the task structure from going away in the meantime.

Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
Reported-by: syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0fde39b..ca21d28 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -249,13 +249,16 @@ static bool check_slow_task(struct task_struct *t, void *arg)
 
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
- * sections, printing out the tid of each.
+ * sections, printing out the tid of each of the first few of them.
  */
-static int rcu_print_task_stall(struct rcu_node *rnp)
+static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
+	int i = 0;
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *ts[8];
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
@@ -264,6 +267,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		get_task_struct(t);
+		ts[i++] = t;
+		if (i >= ARRAY_SIZE(ts))
+			break;
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	for (i--; i; i--) {
+		t = ts[i];
 		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
@@ -273,6 +284,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list]);
+		put_task_struct(t);
 		ndetected++;
 	}
 	pr_cont("\n");
@@ -293,8 +305,9 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections.
  */
-static int rcu_print_task_stall(struct rcu_node *rnp)
+static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 {
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
 }
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
@@ -472,7 +485,6 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		ndetected += rcu_print_task_stall(rnp);
 		if (rnp->qsmask != 0) {
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
@@ -480,7 +492,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 					ndetected++;
 				}
 		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
 	}
 
 	for_each_possible_cpu(cpu)
-- 
2.9.5

