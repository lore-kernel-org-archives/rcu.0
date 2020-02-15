Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E60AC35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC3D2082F
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725938;
	bh=4GFFuIDZ97qcJJakEZ1Zip3UB/UbmALQmtom95UvtGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9dOaMm1pdaEumhRjIusUjujqPolRQlGVgOMpkAxZrTQC2+6CwjkiV75RSl8s8zRn
	 cIKN4RzwpDLo/SApuz5/4TR+7Vo+Y/v64Qkbm7e1ogWP7YV8Vpkb6sYbkOUcO+Vpkf
	 Foy+wqEfg2f0ksM/PnKtLtY8cJYoSXKugYGOFhlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBOAS5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAS5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:18:57 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85CDF20848;
        Sat, 15 Feb 2020 00:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725937;
        bh=4GFFuIDZ97qcJJakEZ1Zip3UB/UbmALQmtom95UvtGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G08jsUia2tu6qdDJM8iCSPzsYbwMFA3tv1FZkMNjqdiecomknzA7JuqFZfa7VfR2x
         rqa3RQMX2PAKpICleixmOKOoVTZ2qzg1LfCfU5DjG9099uLM9xpDfr4uOtJy+m4pga
         PLfrIasM5H/FBzT35hVv0LaWswO5+H5P9nON+Jag=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/5] rcu: React to callback overload by aggressively seeking quiescent states
Date:   Fri, 14 Feb 2020 16:18:42 -0800
Message-Id: <20200215001845.15432-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215001816.GA15284@paulmck-ThinkPad-P72>
References: <20200215001816.GA15284@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In default configutions, RCU currently waits at least 100 milliseconds
before asking cond_resched() and/or resched_rcu() for help seeking
quiescent states to end a grace period.  But 100 milliseconds can be
one good long time during an RCU callback flood, for example, as can
happen when user processes repeatedly open and close files in a tight
loop.  These 100-millisecond gaps in successive grace periods during a
callback flood can result in excessive numbers of callbacks piling up,
unnecessarily increasing memory footprint.

This commit therefore asks cond_resched() and/or resched_rcu() for help
as early as the first FQS scan when at least one of the CPUs has more
than 20,000 callbacks queued, a number that can be changed using the new
rcutree.qovld kernel boot parameter.  An auxiliary qovld_calc variable
is used to avoid acquisition of locks that have not yet been initialized.
Early tests indicate that this reduces the RCU-callback memory footprint
during rcutorture floods by from 50% to 4x, depending on configuration.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reported-by: Tejun Heo <tj@kernel.org>
[ paulmck: Fix bug located by Qian Cai. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Qian Cai <cai@lca.pw>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++
 kernel/rcu/tree.c                               | 75 +++++++++++++++++++++++--
 kernel/rcu/tree.h                               |  4 ++
 kernel/rcu/tree_plugin.h                        |  2 +
 4 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d6..dbd4b4a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3980,6 +3980,15 @@
 			Set threshold of queued RCU callbacks below which
 			batch limiting is re-enabled.
 
+	rcutree.qovld= [KNL]
+			Set threshold of queued RCU callbacks beyond which
+			RCU's force-quiescent-state scan will aggressively
+			enlist help from cond_resched() and sched IPIs to
+			help CPUs more quickly reach quiescent states.
+			Set to less than zero to make this be set based
+			on rcutree.qhimark at boot time and to zero to
+			disable more aggressive help enlistment.
+
 	rcutree.rcu_idle_gp_delay= [KNL]
 			Set wakeup interval for idle CPUs that have
 			RCU callbacks (RCU_FAST_NO_HZ=y).
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31d01f8..48fba22 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -150,6 +150,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
+static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 
 /* rcuc/rcub kthread realtime priority */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
@@ -410,10 +411,15 @@ static long blimit = DEFAULT_RCU_BLIMIT;
 static long qhimark = DEFAULT_RCU_QHIMARK;
 #define DEFAULT_RCU_QLOMARK 100   /* Once only this many pending, use blimit. */
 static long qlowmark = DEFAULT_RCU_QLOMARK;
+#define DEFAULT_RCU_QOVLD_MULT 2
+#define DEFAULT_RCU_QOVLD (DEFAULT_RCU_QOVLD_MULT * DEFAULT_RCU_QHIMARK)
+static long qovld = DEFAULT_RCU_QOVLD; /* If this many pending, hammer QS. */
+static long qovld_calc = -1;	  /* No pre-initialization lock acquisitions! */
 
 module_param(blimit, long, 0444);
 module_param(qhimark, long, 0444);
 module_param(qlowmark, long, 0444);
+module_param(qovld, long, 0444);
 
 static ulong jiffies_till_first_fqs = ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
@@ -1072,7 +1078,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
 	if (!READ_ONCE(*rnhqp) &&
 	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
-	     time_after(jiffies, rcu_state.jiffies_resched))) {
+	     time_after(jiffies, rcu_state.jiffies_resched) ||
+	     rcu_state.cbovld)) {
 		WRITE_ONCE(*rnhqp, true);
 		/* Store rcu_need_heavy_qs before rcu_urgent_qs. */
 		smp_store_release(ruqp, true);
@@ -1089,8 +1096,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 * So hit them over the head with the resched_cpu() hammer!
 	 */
 	if (tick_nohz_full_cpu(rdp->cpu) &&
-		   time_after(jiffies,
-			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
+	     rcu_state.cbovld)) {
 		WRITE_ONCE(*ruqp, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
@@ -1704,8 +1711,9 @@ static void rcu_gp_fqs_loop(void)
  */
 static void rcu_gp_cleanup(void)
 {
-	unsigned long gp_duration;
+	int cpu;
 	bool needgp = false;
+	unsigned long gp_duration;
 	unsigned long new_gp_seq;
 	bool offloaded;
 	struct rcu_data *rdp;
@@ -1751,6 +1759,12 @@ static void rcu_gp_cleanup(void)
 			needgp = __note_gp_changes(rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
 		needgp = rcu_future_gp_cleanup(rnp) || needgp;
+		// Reset overload indication for CPUs no longer overloaded
+		if (rcu_is_leaf_node(rnp))
+			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
+				rdp = per_cpu_ptr(&rcu_data, cpu);
+				check_cb_ovld_locked(rdp, rnp);
+			}
 		sq = rcu_nocb_gp_get(rnp);
 		raw_spin_unlock_irq_rcu_node(rnp);
 		rcu_nocb_gp_cleanup(sq);
@@ -2299,10 +2313,13 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
+	rcu_state.cbovld = rcu_state.cbovldnext;
+	rcu_state.cbovldnext = false;
 	rcu_for_each_leaf_node(rnp) {
 		cond_resched_tasks_rcu_qs();
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
 			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
 			    rcu_preempt_blocked_readers_cgp(rnp)) {
@@ -2584,6 +2601,48 @@ static void rcu_leak_callback(struct rcu_head *rhp)
 }
 
 /*
+ * Check and if necessary update the leaf rcu_node structure's
+ * ->cbovldmask bit corresponding to the current CPU based on that CPU's
+ * number of queued RCU callbacks.  The caller must hold the leaf rcu_node
+ * structure's ->lock.
+ */
+static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp)
+{
+	raw_lockdep_assert_held_rcu_node(rnp);
+	if (qovld_calc <= 0)
+		return; // Early boot and wildcard value set.
+	if (rcu_segcblist_n_cbs(&rdp->cblist) >= qovld_calc)
+		WRITE_ONCE(rnp->cbovldmask, rnp->cbovldmask | rdp->grpmask);
+	else
+		WRITE_ONCE(rnp->cbovldmask, rnp->cbovldmask & ~rdp->grpmask);
+}
+
+/*
+ * Check and if necessary update the leaf rcu_node structure's
+ * ->cbovldmask bit corresponding to the current CPU based on that CPU's
+ * number of queued RCU callbacks.  No locks need be held, but the
+ * caller must have disabled interrupts.
+ *
+ * Note that this function ignores the possibility that there are a lot
+ * of callbacks all of which have already seen the end of their respective
+ * grace periods.  This omission is due to the need for no-CBs CPUs to
+ * be holding ->nocb_lock to do this check, which is too heavy for a
+ * common-case operation.
+ */
+static void check_cb_ovld(struct rcu_data *rdp)
+{
+	struct rcu_node *const rnp = rdp->mynode;
+
+	if (qovld_calc <= 0 ||
+	    ((rcu_segcblist_n_cbs(&rdp->cblist) >= qovld_calc) ==
+	     !!(READ_ONCE(rnp->cbovldmask) & rdp->grpmask)))
+		return; // Early boot wildcard value or already set correctly.
+	raw_spin_lock_rcu_node(rnp);
+	check_cb_ovld_locked(rdp, rnp);
+	raw_spin_unlock_rcu_node(rnp);
+}
+
+/*
  * Helper function for call_rcu() and friends.  The cpu argument will
  * normally be -1, indicating "currently running CPU".  It may specify
  * a CPU only if that CPU is a no-CBs CPU.  Currently, only rcu_barrier()
@@ -2626,6 +2685,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 			rcu_segcblist_init(&rdp->cblist);
 	}
 
+	check_cb_ovld(rdp);
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	/* If we get here, rcu_nocb_try_bypass() acquired ->nocb_lock. */
@@ -3814,6 +3874,13 @@ void __init rcu_init(void)
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
 	srcu_init();
+
+	/* Fill in default value for rcutree.qovld boot parameter. */
+	/* -After- the rcu_node ->lock fields are initialized! */
+	if (qovld < 0)
+		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
+	else
+		qovld_calc = qovld;
 }
 
 #include "tree_stall.h"
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 0c87e4c..9dc2ec0 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -68,6 +68,8 @@ struct rcu_node {
 				/* Online CPUs for next expedited GP. */
 				/*  Any CPU that has ever been online will */
 				/*  have its bit set. */
+	unsigned long cbovldmask;
+				/* CPUs experiencing callback overload. */
 	unsigned long ffmask;	/* Fully functional CPUs. */
 	unsigned long grpmask;	/* Mask to apply to parent qsmask. */
 				/*  Only one bit will be set in this mask. */
@@ -321,6 +323,8 @@ struct rcu_state {
 	atomic_t expedited_need_qs;		/* # CPUs left to check in. */
 	struct swait_queue_head expedited_wq;	/* Wait for check-ins. */
 	int ncpus_snap;				/* # CPUs seen last time. */
+	u8 cbovld;				/* Callback overload now? */
+	u8 cbovldnext;				/* ^        ^  next time? */
 
 	unsigned long jiffies_force_qs;		/* Time at which to invoke */
 						/*  force_quiescent_state(). */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c6ea81c..0be8fad 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -56,6 +56,8 @@ static void __init rcu_bootup_announce_oddness(void)
 		pr_info("\tBoot-time adjustment of callback high-water mark to %ld.\n", qhimark);
 	if (qlowmark != DEFAULT_RCU_QLOMARK)
 		pr_info("\tBoot-time adjustment of callback low-water mark to %ld.\n", qlowmark);
+	if (qovld != DEFAULT_RCU_QOVLD)
+		pr_info("\tBoot-time adjustment of callback overload leval to %ld.\n", qovld);
 	if (jiffies_till_first_fqs != ULONG_MAX)
 		pr_info("\tBoot-time adjustment of first FQS scan delay to %ld jiffies.\n", jiffies_till_first_fqs);
 	if (jiffies_till_next_fqs != ULONG_MAX)
-- 
2.9.5

