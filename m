Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E64C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A152A21734
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970776;
	bh=hPuCExeZVOv5dD+lcqaWNfQ5IoLCr02D3PMs1k3qDLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMbaiC7EM3D/PUUXxKyvdVtcC2y8b/emIDqqm6+ePND7YCJV/MCuP9JLaaOTZ/JDV
	 jZBMW+E9HAC6EkVcN7XMYfU+otuB+0MM3YqDjgeXEsslP6zyoEV5NWaVcLRUhveTpu
	 OXHEHTp35sKLUZDLSIUGXHLwxWA7fsluqwFfmy7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416415AbgDORMp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410711AbgDORK6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341A521BE5;
        Wed, 15 Apr 2020 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970657;
        bh=hPuCExeZVOv5dD+lcqaWNfQ5IoLCr02D3PMs1k3qDLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbpfFzVP/gKU+QI3LCAjWgg3OpxkfKHvvE/f8iXyzSYt+i5ga48VXLEsQDUJVS8WA
         N26kdOXoqtuFNrKct/TkaHRwz/jMJ+TiObpZVwiorRYGijp6mPlDrk+QvoMElCHzs0
         NwU40HHDbFyRikJfAeHkn6g2Dpd4XqpNfJw2Bjs4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/19] rcu: Add *_ONCE() and data_race() to rcu_node ->exp_tasks plus locking
Date:   Wed, 15 Apr 2020 10:10:39 -0700
Message-Id: <20200415171054.9013-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There are lockless loads from the rcu_node structure's ->exp_tasks field,
so this commit causes all stores to use WRITE_ONCE() and all lockless
loads to use READ_ONCE() or data_race(), with the latter for debug
prints.  This code also did a unprotected traversal of the linked list
pointed into by ->exp_tasks, so this commit also acquires the rcu_node
structure's ->lock to properly protect this traversal.  This list was
traversed unprotected only when printing an RCU CPU stall warning for
an expedited grace period, so the odds of seeing this in production are
not all that high.

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 19 +++++++++++--------
 kernel/rcu/tree_plugin.h |  8 ++++----
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a617b9..c2b04da 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -150,7 +150,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
 static bool sync_rcu_exp_done(struct rcu_node *rnp)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	return rnp->exp_tasks == NULL &&
+	return READ_ONCE(rnp->exp_tasks) == NULL &&
 	       READ_ONCE(rnp->expmask) == 0;
 }
 
@@ -373,7 +373,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	 * until such time as the ->expmask bits are cleared.
 	 */
 	if (rcu_preempt_has_tasks(rnp))
-		rnp->exp_tasks = rnp->blkd_tasks.next;
+		WRITE_ONCE(rnp->exp_tasks, rnp->blkd_tasks.next);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
@@ -542,8 +542,8 @@ static void synchronize_rcu_expedited_wait(void)
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 			jiffies - jiffies_start, rcu_state.expedited_sequence,
-			READ_ONCE(rnp_root->expmask),
-			".T"[!!rnp_root->exp_tasks]);
+			data_race(rnp_root->expmask),
+			".T"[!!data_race(rnp_root->exp_tasks)]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
 			rcu_for_each_node_breadth_first(rnp) {
@@ -553,8 +553,8 @@ static void synchronize_rcu_expedited_wait(void)
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-					READ_ONCE(rnp->expmask),
-					".T"[!!rnp->exp_tasks]);
+					data_race(rnp->expmask),
+					".T"[!!data_race(rnp->exp_tasks)]);
 			}
 			pr_cont("\n");
 		}
@@ -721,17 +721,20 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 {
-	struct task_struct *t;
+	unsigned long flags;
 	int ndetected = 0;
+	struct task_struct *t;
 
-	if (!rnp->exp_tasks)
+	if (!READ_ONCE(rnp->exp_tasks))
 		return 0;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
 		pr_cont(" P%d", t->pid);
 		ndetected++;
 	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return ndetected;
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 097635c..35d77db 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -226,7 +226,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq);
 	}
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
-		rnp->exp_tasks = &t->rcu_node_entry;
+		WRITE_ONCE(rnp->exp_tasks, &t->rcu_node_entry);
 	WARN_ON_ONCE(!(blkd_state & RCU_GP_BLKD) !=
 		     !(rnp->qsmask & rdp->grpmask));
 	WARN_ON_ONCE(!(blkd_state & RCU_EXP_BLKD) !=
@@ -500,7 +500,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		if (&t->rcu_node_entry == rnp->gp_tasks)
 			WRITE_ONCE(rnp->gp_tasks, np);
 		if (&t->rcu_node_entry == rnp->exp_tasks)
-			rnp->exp_tasks = np;
+			WRITE_ONCE(rnp->exp_tasks, np);
 		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
 			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
 			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
@@ -761,7 +761,7 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
 	pr_info("%s: ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p\n",
 		__func__, READ_ONCE(rnp->gp_tasks), rnp->boost_tasks,
-		rnp->exp_tasks);
+		READ_ONCE(rnp->exp_tasks));
 	pr_info("%s: ->blkd_tasks", __func__);
 	i = 0;
 	list_for_each(lhp, &rnp->blkd_tasks) {
@@ -1036,7 +1036,7 @@ static int rcu_boost_kthread(void *arg)
 	for (;;) {
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
-		rcu_wait(rnp->boost_tasks || rnp->exp_tasks);
+		rcu_wait(rnp->boost_tasks || READ_ONCE(rnp->exp_tasks));
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
-- 
2.9.5

