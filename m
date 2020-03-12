Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44ABC10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34D920738
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584037077;
	bh=fjI+R94EzQwA0tEzSeSTDZ6iCR8SFLgPUT9TV/qWp/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMYCI5SLE4BX8bccqTCYalWoRPVC+yUFpLWLxlbg133joTk/8utf8PDYX8gzcpxe5
	 Z+KpdM2Cw3h+c2HqOGcCkcs+Hns6BIvp/6YbMqFlGyWVrsHYOWeFNnFbTo5Wn3d4Pw
	 395mxAzmY2jJItdtMTSqA+Kp7RPayjD3JuXgNBO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCLSRG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCLSRF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CCA020739;
        Thu, 12 Mar 2020 18:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037024;
        bh=fjI+R94EzQwA0tEzSeSTDZ6iCR8SFLgPUT9TV/qWp/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPl4FBaD4RxZgn6w4mnc5Ojw6IN77nJImoLIGzaEMcDvhk+DMAQlbUJEJRaG3GjIq
         bEfKXcAeYDev7NmleS8DmFy1q8C88NV3N0aimUij1wtfW3yS+Qbefgx1hvwfh989ld
         HG78uAvFJsOhPTwWqfqN+q5SvSrKWiYTaBmdDWa0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 02/16] rcu: Add per-task state to RCU CPU stall warnings
Date:   Thu, 12 Mar 2020 11:16:48 -0700
Message-Id: <20200312181702.8443-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, an RCU-preempt CPU stall warning simply lists the PIDs of
those tasks holding up the current grace period.  This can be helpful,
but more can be even more helpful.

To this end, this commit adds the nesting level, whether the task
things it was preempted in its current RCU read-side critical section,
whether RCU core has asked this task for a quiescent state, whether the
expedited-grace-period hint is set, and whether the task believes that
it is on the blocked-tasks list (it must be, or it would not be printed,
but if things are broken, best not to take too much for granted).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 502b4dd..6de5a5b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -192,14 +192,39 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+// Communicate task state back to the RCU CPU stall warning request.
+struct rcu_stall_chk_rdr {
+	struct task_struct *t;
+	int nesting;
+	union rcu_special rs;
+	bool on_blkd_list;
+};
+
+/*
+ * Report out the state of a not-running task that is stalling the
+ * current RCU grace period.
+ */
+static void check_slow_task(void *arg)
+{
+	struct rcu_node *rnp;
+	struct rcu_stall_chk_rdr *rscrp = arg;
+	struct task_struct *t = rscrp->t;
+
+	rscrp->nesting = t->rcu_read_lock_nesting;
+	rscrp->rs = t->rcu_read_unlock_special;
+	rnp = t->rcu_blocked_node;
+	rscrp->on_blkd_list = !list_empty(&t->rcu_node_entry);
+}
+
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
  * sections, printing out the tid of each.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp)
 {
-	struct task_struct *t;
 	int ndetected = 0;
+	struct rcu_stall_chk_rdr rscr;
+	struct task_struct *t;
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
@@ -208,7 +233,16 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-		pr_cont(" P%d", t->pid);
+		rscr.t = t;
+		if (!try_invoke_on_nonrunning_task(t, check_slow_task, &rscr))
+			pr_cont(" P%d", t->pid);
+		else
+			pr_cont(" P%d/%d:%c%c%c%c",
+				t->pid, rscr.nesting,
+				".b"[rscr.rs.b.blocked],
+				".q"[rscr.rs.b.need_qs],
+				".e"[rscr.rs.b.exp_hint],
+				".l"[rscr.on_blkd_list]);
 		ndetected++;
 	}
 	pr_cont("\n");
-- 
2.9.5

