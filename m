Return-Path: <SRS0=LJ8s=4C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1742C35242
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7385924649
	for <rcu@archiver.kernel.org>; Fri, 14 Feb 2020 23:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581724616;
	bh=RU3ndbHIcx84N7Zau8RC9Qo/Qt8DFa2SxmpMLPxwJyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IF34y9VPk530zwWzZKQPw6uXt3LKkMZcmaUQNtyED00NSLs9XfmxiLrOLFoBo/rcP
	 iULl84vMbwT+9Ki0nxp63aVUAdaEriltluI1mnvZroTLToZPo1f0xD44HFQg1y19Ei
	 B4t7V0tyddD1w1iIXnIkDV78kbqIU7r0aluqpAQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBNX44 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgBNX4z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 18:56:55 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A41B2081E;
        Fri, 14 Feb 2020 23:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581724614;
        bh=RU3ndbHIcx84N7Zau8RC9Qo/Qt8DFa2SxmpMLPxwJyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hu0Ic/xkF8CqEnVM/onpWK4erOhmW9SC855EvLe10rr3+ugdzSyVeUVEahpLKShgd
         P6+gvV3NkYvC9ktQa6AjV7mRdfofVTpeZHApsaiRj+TXl6bWmJIO9RqWhj5RDiqMJI
         pYpgzVTVsxYcMz88lU/VbhXyIzs/O8cB5hVMEmbA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/30] rcu: *_ONCE() for grace-period progress indicators
Date:   Fri, 14 Feb 2020 15:55:49 -0800
Message-Id: <20200214235607.13749-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200214235536.GA13364@paulmck-ThinkPad-P72>
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The various RCU structures' ->gp_seq, ->gp_seq_needed, ->gp_req_activity,
and ->gp_activity fields are read locklessly, so they must be updated with
WRITE_ONCE() and, when read locklessly, with READ_ONCE().  This commit makes
these changes.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 14 +++++++-------
 kernel/rcu/tree_plugin.h |  2 +-
 kernel/rcu/tree_stall.h  | 26 +++++++++++++++-----------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 346321a..53946b1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1175,7 +1175,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 					  TPS("Prestarted"));
 			goto unlock_out;
 		}
-		rnp->gp_seq_needed = gp_seq_req;
+		WRITE_ONCE(rnp->gp_seq_needed, gp_seq_req);
 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
 			/*
 			 * We just marked the leaf or internal node, and a
@@ -1210,8 +1210,8 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 unlock_out:
 	/* Push furthest requested GP to leaf node and rcu_data structure. */
 	if (ULONG_CMP_LT(gp_seq_req, rnp->gp_seq_needed)) {
-		rnp_start->gp_seq_needed = rnp->gp_seq_needed;
-		rdp->gp_seq_needed = rnp->gp_seq_needed;
+		WRITE_ONCE(rnp_start->gp_seq_needed, rnp->gp_seq_needed);
+		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
 	}
 	if (rnp != rnp_start)
 		raw_spin_unlock_rcu_node(rnp);
@@ -1423,7 +1423,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
-		rdp->gp_seq_needed = rnp->gp_seq_needed;
+		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
 	WRITE_ONCE(rdp->gpwrap, false);
 	rcu_gpnum_ovf(rnp, rdp);
 	return ret;
@@ -3276,12 +3276,12 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp);		/* irqs already disabled. */
 	rdp->beenonline = true;	 /* We have now been online. */
-	rdp->gp_seq = rnp->gp_seq;
-	rdp->gp_seq_needed = rnp->gp_seq;
+	rdp->gp_seq = READ_ONCE(rnp->gp_seq);
+	rdp->gp_seq_needed = rdp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
-	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
+	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c6ea81c..b5ba148 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -753,7 +753,7 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 	raw_lockdep_assert_held_rcu_node(rnp);
 	pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 		__func__, rnp->grplo, rnp->grphi, rnp->level,
-		(long)rnp->gp_seq, (long)rnp->completedqs);
+		(long)READ_ONCE(rnp->gp_seq), (long)rnp->completedqs);
 	for (rnp1 = rnp; rnp1; rnp1 = rnp1->parent)
 		pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx\n",
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 55f9b84..3dcbecf 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -592,21 +592,22 @@ void show_rcu_gp_kthreads(void)
 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
 		READ_ONCE(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
-		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
+		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
+				 READ_ONCE(rnp->gp_seq_needed)))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)rnp->gp_seq,
-			(long)rnp->gp_seq_needed);
+			rnp->grplo, rnp->grphi, (long)READ_ONCE(rnp->gp_seq),
+			(long)READ_ONCE(rnp->gp_seq_needed));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
 			if (rdp->gpwrap ||
-			    ULONG_CMP_GE(rcu_state.gp_seq,
-					 rdp->gp_seq_needed))
+			    ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
+					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)rdp->gp_seq_needed);
+				cpu, (long)READ_ONCE(rdp->gp_seq_needed));
 		}
 	}
 	for_each_possible_cpu(cpu) {
@@ -631,7 +632,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	static atomic_t warned = ATOMIC_INIT(0);
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
+	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
+	    		 READ_ONCE(rnp_root->gp_seq_needed)))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
@@ -642,7 +644,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
+	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
+	    		 READ_ONCE(rnp_root->gp_seq_needed)) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
 	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_read(&warned)) {
@@ -655,9 +658,10 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 		raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
-	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
-	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
+	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
+	    		 READ_ONCE(rnp_root->gp_seq_needed)) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_xchg(&warned, 1)) {
 		if (rnp_root != rnp)
 			/* irqs remain disabled. */
-- 
2.9.5

