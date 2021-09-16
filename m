Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2BC433F5
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4775F61283
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbhIPMM0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239314AbhIPMMW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 08:12:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C41360F4A;
        Thu, 16 Sep 2021 12:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631794262;
        bh=1E+0gkrKQHhzUs0Znhw+hQhC/uCcBN+yengliddJvig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCmFxRA7uuQmYy8uEtEiev9Y3jks05b96i+cUZxP55nKuwCXBS7TNXMJg7f0fpm+i
         hDgLf/DWseqG497zaWIxnZMguYEZw0N/OOnK82Y8AzrnfOxwXWMW0nfzAttXsByqLH
         pVQvS/EvXoHZRWbl6eZkQf2+FbS3tECtyMvVISOemChvk2Y7UOobbzEMK3gcYYI+nS
         XVApNtw7X+1Bvk2xHsuw8KJKWHRdLLQVd0RDPMWd5P5omKSXvCs9TIe6yQrzr3Z/z6
         qJS9iXtzg36ldON27ggdFxuxhryLvl8zNa7/juwBwrhpRVpFJVHI1of9UAKGEWxlvp
         dCPnOZTUxdTcg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: [PATCH 4/4] rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp
Date:   Thu, 16 Sep 2021 14:10:48 +0200
Message-Id: <20210916121048.36623-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916121048.36623-1-frederic@kernel.org>
References: <20210916121048.36623-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Having two fields for the same purpose with subtle differences
on different RCU flavours is confusing, especially when both fields
always exist on both RCU flavours.

Fortunately it's now safe for preemptible RCU to rely on rcu_data.cpu
no_qs.b.exp instead of its own ad-hoc exp_deferred_qs field.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_exp.h    |  5 ++---
 kernel/rcu/tree_plugin.h | 12 ++++++------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb408..ea46ed40f6bc 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -157,7 +157,6 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
-	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
 	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 992f9475d243..64e454345d52 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -255,7 +255,6 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
  */
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
-	rdp->exp_deferred_qs = false;
 	rdp->cpu_no_qs.b.exp = false;
 	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
@@ -656,7 +655,7 @@ static void rcu_exp_handler(void *unused)
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
 		} else {
-			rdp->exp_deferred_qs = true;
+			rdp->cpu_no_qs.b.exp = true;
 			set_tsk_need_resched(t);
 			set_preempt_need_resched();
 		}
@@ -678,7 +677,7 @@ static void rcu_exp_handler(void *unused)
 	if (depth > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
-			rdp->exp_deferred_qs = true;
+			rdp->cpu_no_qs.b.exp = true;
 			t->rcu_read_unlock_special.b.exp_hint = true;
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b20634fde43d..796c4913bbb8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -260,10 +260,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * no need to check for a subsequent expedited GP.  (Though we are
 	 * still in a quiescent state in any case.)
 	 */
-	if (blkd_state & RCU_EXP_BLKD && rdp->exp_deferred_qs)
+	if (blkd_state & RCU_EXP_BLKD && rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
 	else
-		WARN_ON_ONCE(rdp->exp_deferred_qs);
+		WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
 }
 
 /*
@@ -354,7 +354,7 @@ void rcu_note_context_switch(bool preempt)
 	 * means that we continue to block the current grace period.
 	 */
 	rcu_qs();
-	if (rdp->exp_deferred_qs)
+	if (rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
 	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
@@ -481,7 +481,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 */
 	special = t->rcu_read_unlock_special;
 	rdp = this_cpu_ptr(&rcu_data);
-	if (!special.s && !rdp->exp_deferred_qs) {
+	if (!special.s && !rdp->cpu_no_qs.b.exp) {
 		local_irq_restore(flags);
 		return;
 	}
@@ -501,7 +501,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
-	if (rdp->exp_deferred_qs)
+	if (rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
 
 	/* Clean up if blocked during RCU read-side critical section. */
@@ -584,7 +584,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  */
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
-	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
+	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
 	       rcu_preempt_depth() == 0;
 }
-- 
2.25.1

