Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E301EC433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7ACD2068E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897520;
	bh=A7Frv41HbShMLrvra7ZQ4nWH6TtbcUXyTeRPOsb0uEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OwMhxCrgYUKKXPQbXRQhAytgfGSXOl2UQ4lu0EEDAt9M/ABfhjJFATkRwqDsWlPUZ
	 I8UgLhzTZXWPzJpj71qH4TQ+FRRPlIyasRSffj33hcjinZLBGr9xHQbsEmj/E1JwOC
	 jC84F5FcbSaF0tagtBva6lmnfx49OtrOhO25UH9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgHaSLq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbgHaSL0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:11:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E635521534;
        Mon, 31 Aug 2020 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897484;
        bh=A7Frv41HbShMLrvra7ZQ4nWH6TtbcUXyTeRPOsb0uEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLODH/yZ6DD3ej7n84BRKv+ehFz/gv4epQODy9/5hkj1Vncg31R05Zpln6e+rtkBa
         HdpFM4Js6AZAQGH3IJa2wOK0uWRSLQcVtGYPYllFfWkJsy3CdDRT21IS91IqSNGpwy
         Y+GnpCAuVFNytDgMmmcCqJeCvK2iKtx4f7q2U6X8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/13] rcu: Execute RCU reader shortly after rcu_core for strict GPs
Date:   Mon, 31 Aug 2020 11:11:18 -0700
Message-Id: <20200831181120.1044-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181101.GA950@paulmck-ThinkPad-P72>
References: <20200831181101.GA950@paulmck-ThinkPad-P72>
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
index 4bbedfc..31995b3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2646,6 +2646,14 @@ void rcu_force_quiescent_state(void)
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
@@ -2690,6 +2698,10 @@ static __latent_entropy void rcu_core(void)
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
 	trace_rcu_utilization(TPS("End RCU core"));
+
+	// If strict GPs, schedule an RCU reader in a clean environment.
+	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
 }
 
 static void rcu_core_si(struct softirq_action *h)
@@ -3887,6 +3899,7 @@ rcu_boot_init_percpu_data(int cpu)
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
+	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c96ae35..5831ac0 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -164,6 +164,7 @@ struct rcu_data {
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
 	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
 	struct rcu_segcblist cblist;	/* Segmented callback list, with */
-- 
2.9.5

