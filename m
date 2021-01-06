Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C083C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36D722BF3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbhAFEvB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbhAFEu6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CE1C23102;
        Wed,  6 Jan 2021 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908538;
        bh=YACBQAKd0OqTjC8v1X/eu+5408oMKqN89vYA+opmwdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEGwOXvK1xvkFDRtoT1w3A7W3leqYvSdeADQUqXDfn9f7Kzt6Cf+aG5K7Ef5mwGoD
         ap6JIaFXdu+7yCIOFFeHVvPtMa0Yjl8JPC/je1jt3s+vNm7rpiZ0xVceLWYXRtAX+a
         of8bNtOnoxnsdUfdIXXDOWNhGiKhNqspnUE9AHK9RqpHhXxoF1jd6UqItxezP1+3j0
         KykOqmgY7v4dJ3VZBMuYLadtLR9bq2A9+sAJpw+rQsEF+1E7L2+gOnjGuYJx4ixp75
         kpJ43LmkLlHGjzeuX5P8LIb2Ycuyn2s00G/Qg8jE3qxiu77HDtR/Zmo1xjmyBtTJ5M
         51+mmH7Hx8Unw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/21] rcu/nocb: Add grace period and task state to show_rcu_nocb_state() output
Date:   Tue,  5 Jan 2021 20:48:50 -0800
Message-Id: <20210106044853.20812-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit improves debuggability by indicating which grace period each
batch of nocb callbacks is waiting on and by showing the task state and
last CPU for reach nocb kthread.

[ paulmck: Handle !SMP CB offloading per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 11 +++++++++++
 kernel/rcu/tree_plugin.h   | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index afad6fc..3110602 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -117,6 +117,17 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 	return !READ_ONCE(*READ_ONCE(rsclp->tails[seg]));
 }
 
+/*
+ * Is the specified segment of the specified rcu_segcblist structure
+ * empty of callbacks?
+ */
+static inline bool rcu_segcblist_segempty(struct rcu_segcblist *rsclp, int seg)
+{
+	if (seg == RCU_DONE_TAIL)
+		return &rsclp->head == rsclp->tails[RCU_DONE_TAIL];
+	return rsclp->tails[seg - 1] == rsclp->tails[seg];
+}
+
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8641b72..5ee1113 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2672,6 +2672,19 @@ void rcu_bind_current_to_nocb(void)
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
+// The ->on_cpu field is available only in CONFIG_SMP=y, so...
+#ifdef CONFIG_SMP
+static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
+{
+	return tsp && tsp->state == TASK_RUNNING && !tsp->on_cpu ? "!" : "";
+}
+#else // #ifdef CONFIG_SMP
+static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
+{
+	return "";
+}
+#endif // #else #ifdef CONFIG_SMP
+
 /*
  * Dump out nocb grace-period kthread state for the specified rcu_data
  * structure.
@@ -2680,7 +2693,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	pr_info("nocb GP %d %c%c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu\n",
+	pr_info("nocb GP %d %c%c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
 		rdp->cpu,
 		"kK"[!!rdp->nocb_gp_kthread],
 		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
@@ -2694,12 +2707,17 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		".B"[!!rdp->nocb_gp_bypass],
 		".G"[!!rdp->nocb_gp_gp],
 		(long)rdp->nocb_gp_seq,
-		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops));
+		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
+		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 }
 
 /* Dump out nocb kthread state for the specified rcu_data structure. */
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
+	char bufw[20];
+	char bufr[20];
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
 	bool wastimer;
@@ -2708,7 +2726,9 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	if (rdp->nocb_gp_rdp == rdp)
 		show_rcu_nocb_gp_state(rdp);
 
-	pr_info("   CB %d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%c%c%c q%ld\n",
+	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
@@ -2720,11 +2740,16 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		jiffies - rdp->nocb_nobypass_last,
 		rdp->nocb_nobypass_count,
 		".D"[rcu_segcblist_ready_cbs(rsclp)],
-		".W"[!rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL)],
-		".R"[!rcu_segcblist_restempty(rsclp, RCU_WAIT_TAIL)],
-		".N"[!rcu_segcblist_restempty(rsclp, RCU_NEXT_READY_TAIL)],
+		".W"[!rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL) ? "" : bufw,
+		".R"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL) ? "" : bufr,
+		".N"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL)],
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
-		rcu_segcblist_n_cbs(&rdp->cblist));
+		rcu_segcblist_n_cbs(&rdp->cblist),
+		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 
 	/* It is OK for GP kthreads to have GP state. */
 	if (rdp->nocb_gp_rdp == rdp)
-- 
2.9.5

