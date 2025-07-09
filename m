Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BF2BCF45;
	Wed,  9 Jul 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057727; cv=none; b=GCEHvMuv/uTCv0WEl6WQlCZ1wj/r4GjHQsNW+iEADoZH3nw3T0M9y4Zsss8VL4Nd1dfR/JyugIL7h533I0GH6lXpAN/nasL7CdW025rXfVyRDJOx+eAZ7DVTQ+nEvZ54mYJWKB9ZO4tbCenZj3u0QUyoTl2/BGgNNf2PaP8HXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057727; c=relaxed/simple;
	bh=8kxDM7bPpCuwllffDDYVDUsn4K5+87KDsl5bcSGamoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2wzXC4Xq4tEFRyN9z8REFBoq/WDNmcI8bEGVsUU/gc34m+0+SKwYR4y3578GYeR1BbgTohbpjzONGD+8O8K2ZjK/mQi+yeyev65Ak4W//tqH4vn+Y05qiVus6+X44iLQ1xsWAJcgk+soSHowu0edpHqidqqzGEtQTHnq9J4et4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8/cakJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8/cakJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1AFC4CEEF;
	Wed,  9 Jul 2025 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057726;
	bh=8kxDM7bPpCuwllffDDYVDUsn4K5+87KDsl5bcSGamoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8/cakJw40StZnliKOAJmGmsMRMG2Q7WoUEjrahB2WfMc2h7eDWMwPWbXFxAFzIPb
	 azfy80jHExV0Tzgib8th5milOH3JT0Ltg/hd26fehFlGjp7ajIvBN1lkU9g/M7vKHE
	 t0dWXUOkLM40m9zpeN2mkH2fhAqZVQRoaMM0y1hSHhbs7549tWzZSwZetZiSzlyC57
	 yoH3wyS6HrwzMQi1GzpCVHXr480jyTtMe87i2llwYq9xGWR/s6QSo+pxRCrKZvl3Cl
	 mKirOC4+scfDyFMi4Xv/c2vpyYj6Ftzd8sEP3gMk41qkn+kUPIQ8PtecHmhKRBHVO6
	 2t5qvkEB+i2UQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>
Subject: [PATCH rcu 5/5] rcu: Fix rcu_read_unlock() deadloop due to IRQ work
Date: Wed,  9 Jul 2025 16:11:18 +0530
Message-Id: <20250709104118.15532-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

During rcu_read_unlock_special(), if this happens during irq_exit(), we
can lockup if an IPI is issued. This is because the IPI itself triggers
the irq_exit() path causing a recursive lock up.

This is precisely what Xiongfeng found when invoking a BPF program on
the trace_tick_stop() tracepoint As shown in the trace below. Fix by
managing the irq_work state correctly.

irq_exit()
  __irq_exit_rcu()
    /* in_hardirq() returns false after this */
    preempt_count_sub(HARDIRQ_OFFSET)
    tick_irq_exit()
      tick_nohz_irq_exit()
	    tick_nohz_stop_sched_tick()
	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
		   __bpf_trace_tick_stop()
		      bpf_trace_run2()
			    rcu_read_unlock_special()
                              /* will send a IPI to itself */
			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);

A simple reproducer can also be obtained by doing the following in
tick_irq_exit(). It will hang on boot without the patch:

  static inline void tick_irq_exit(void)
  {
 +	rcu_read_lock();
 +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
 +	rcu_read_unlock();
 +

Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
Tested-by: Qi Xi <xiqi2@huawei.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.h        | 11 ++++++++++-
 kernel/rcu/tree_plugin.h | 23 +++++++++++++++++++----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3830c19cf2f6..f8f612269e6e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -174,6 +174,15 @@ struct rcu_snap_record {
 	unsigned long   jiffies;	/* Track jiffies value */
 };
 
+/*
+ * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
+ * It can be in one of the following states:
+ * - DEFER_QS_IDLE: An IRQ work was never scheduled.
+ * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
+ */
+#define DEFER_QS_IDLE		0
+#define DEFER_QS_PENDING	1
+
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
@@ -192,7 +201,7 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
+	int defer_qs_iw_pending;	/* Scheduler attention pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a91b2322a0cd..aec584812574 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	struct rcu_node *rnp;
 	union rcu_special special;
 
+	rdp = this_cpu_ptr(&rcu_data);
+	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
+		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
+
 	/*
 	 * If RCU core is waiting for this CPU to exit its critical section,
 	 * report the fact that it has exited.  Because irqs are disabled,
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->cpu_no_qs.b.exp) {
 		local_irq_restore(flags);
 		return;
@@ -629,7 +632,18 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
 	local_irq_save(flags);
-	rdp->defer_qs_iw_pending = false;
+
+	/*
+	 * Requeue the IRQ work on next unlock in following situation:
+	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
+	 * 2. CPU enters new rcu_read_lock()
+	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
+	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
+	 * 5. Deferred QS reporting does not happen.
+	 */
+	if (rcu_preempt_depth() > 0)
+		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
+
 	local_irq_restore(flags);
 }
 
@@ -676,7 +690,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
+			    cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
@@ -686,7 +701,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 				else
 					init_irq_work(&rdp->defer_qs_iw,
 						      rcu_preempt_deferred_qs_handler);
-				rdp->defer_qs_iw_pending = true;
+				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
 		}
-- 
2.40.1

