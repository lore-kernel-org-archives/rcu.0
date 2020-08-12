Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E8C433DF
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5962122BF5
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597273070;
	bh=VbDmGaf8dc3ynCgB5UvXgHiqHn79VO6Zobq05RMD/2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rghwUMVStjLWqxuGiRKnC/ny6//FoaSvhYWi8KVrWa8/Cp9y8AqJRNBqtI+Y54Pwh
	 vgTca+I5wQh2kgVe4J8x2L9aiwmmboTV5mjpVp0VBZTumHDGi70mi/pY4OWkaB7r+f
	 PO3q/quRCmyDSSOtf4VWH6+dxOP6PujSDNNEB040=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHLW5q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgHLW5h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:37 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2150208B3;
        Wed, 12 Aug 2020 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273056;
        bh=VbDmGaf8dc3ynCgB5UvXgHiqHn79VO6Zobq05RMD/2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYW/Fk59amHZPfhORgdR3EC6XriSmbUH39JJcvEutAUf+2dS2saPb5wCNRgAzqtGZ
         t1j0X1vJevZco8ElkHAUeKGOvLeK4hsLy6n7Ra4qDnU3c2wujS4Z3Esb2dqa4+ac7O
         fHhoJVQKAj4pzVwB/yKLdMRxuNr+7DgEzKE9VOjo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/12] rcu: Execute RCU reader shortly after rcu_core for strict GPs
Date:   Wed, 12 Aug 2020 15:57:31 -0700
Message-Id: <20200812225732.20068-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

A kernel built with CONFIG_RCU_STRICT_GRACE_PERIOD=y needs a quiescent
state to appear very shortly after a CPU has noticed a new grace period.
Placing an RCU reader immediately after this point is ineffective because
this normally happens in softirq context, which acts as a big RCU reader.
This commit therefore introduces a new per-CPU work_struct, which is
used at the end of rcu_core() processing to schedule an RCU read-side
critical section from within a clean environment.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++++++
 kernel/rcu/tree.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index dd7af40..ac37343 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2634,6 +2634,14 @@ void rcu_force_quiescent_state(void)
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
+// Workqueue handler for an RCU reader for kernels enforcing struct RCU
+// grace periods.
+static void strict_work_handler(struct work_struct *work)
+{
+	rcu_read_lock();
+	rcu_read_unlock();
+}
+
 /* Perform RCU core processing work for the current CPU.  */
 static __latent_entropy void rcu_core(void)
 {
@@ -2678,6 +2686,10 @@ static __latent_entropy void rcu_core(void)
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
 	trace_rcu_utilization(TPS("End RCU core"));
+
+	// If strict GPs, schedule an RCU reader in a clean environment.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
 }
 
 static void rcu_core_si(struct softirq_action *h)
@@ -3874,6 +3886,7 @@ rcu_boot_init_percpu_data(int cpu)
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
+	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 309bc7f..e4f66b8 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -165,6 +165,7 @@ struct rcu_data {
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
 	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
 	struct rcu_segcblist cblist;	/* Segmented callback list, with */
-- 
2.9.5

