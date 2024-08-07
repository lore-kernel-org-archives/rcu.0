Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DB145B2E;
	Wed,  7 Aug 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046609; cv=none; b=BcHiZQ+MoTbbXBkq21W2aS9OpoUgpmDiSAopgbjWDs9dlMGIxJu44pDAKTruhsq+P4Lnr5L/fQAonaqV9+Kzh45x9y3CdOPFA3zehALX4XM9e9GJVKB8l0pDllBHShagsrvH7I/05CJy4DU6rCjcgZBg8YJ007rY7vm9gq2ezXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046609; c=relaxed/simple;
	bh=YkDPolWzrbmlPbWb3+WNRO58pHRGY65SSsMMAwry6vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lqyv6pJm0GZLRB+moRAvSyjpK73KxzHs1jsSRQ/rtjl5CmzEhimX7DSOLRwz724nePXFvPF6/tIcTzOq3ZPR/iB6xb1prBo/1vG5MGrVAmAls8k6kQDBBa1gZxP0fNtmalMkBmvvjkaspdy9jxEcV8L889horgWac4wEqm169AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AThBGUuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AThBGUuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD74C4AF0D;
	Wed,  7 Aug 2024 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046609;
	bh=YkDPolWzrbmlPbWb3+WNRO58pHRGY65SSsMMAwry6vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AThBGUuYq7Y2XTGld+MpH15sepu3BMI02QuJkLK3qWuOnS5Ktyjc6yRMAPRNt2Yej
	 xoR8aUtXDQgXgDxXRwbzkQAALFf8UbrEHx8D0KwjswFePypqz8mjo8DMncgKSUWlQX
	 wYPdBlk6XWlxOK6AZT8V4AyXbSd/Urd7Kheb/qo1PrOvu3sWru2ibX5Bxik5Yv5Qge
	 ecRHoJBmm6yKhr1CtK3wgJ6p9rgWUmS0ZSUaVBnE2L5UDCmAUXJUKTo+yWMt5qNqo7
	 vebhNaslqQz7M998AZLCfYpLPgtneK1ZooSLebzfthKzMnvd+EhNMq1OHudZMEfheP
	 lnKk5L5KHGqQw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 19/19] rcu: Use kthread preferred affinity for RCU exp kworkers
Date: Wed,  7 Aug 2024 18:02:25 +0200
Message-ID: <20240807160228.26206-20-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807160228.26206-1-frederic@kernel.org>
References: <20240807160228.26206-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that kthreads have an infrastructure to handle preferred affinity
against CPU hotplug and housekeeping cpumask, convert RCU exp workers to
use it instead of handling all the constraints by itself.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c | 105 +++++++++-------------------------------------
 1 file changed, 19 insertions(+), 86 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 902d4b5abbe7..118477a6dda4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4815,6 +4815,22 @@ rcu_boot_init_percpu_data(int cpu)
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
+static void rcu_thread_affine_rnp(struct task_struct *t, struct rcu_node *rnp)
+{
+	cpumask_var_t affinity;
+	int cpu;
+
+	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
+		return;
+
+	for_each_leaf_node_possible_cpu(rnp, cpu)
+		cpumask_set_cpu(cpu, affinity);
+
+	kthread_affine_preferred(t, affinity);
+
+	free_cpumask_var(affinity);
+}
+
 struct kthread_worker *rcu_exp_gp_kworker;
 
 static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
@@ -4827,7 +4843,7 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 	if (rnp->exp_kworker)
 		return;
 
-	kworker = kthread_run_worker(0, name, rnp_index);
+	kworker = kthread_create_worker(0, name, rnp_index);
 	if (IS_ERR_OR_NULL(kworker)) {
 		pr_err("Failed to create par gp kworker on %d/%d\n",
 		       rnp->grplo, rnp->grphi);
@@ -4837,16 +4853,9 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 
 	if (IS_ENABLED(CONFIG_RCU_EXP_KTHREAD))
 		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
-}
 
-static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
-{
-	struct kthread_worker *kworker = READ_ONCE(rnp->exp_kworker);
-
-	if (!kworker)
-		return NULL;
-
-	return kworker->task;
+	rcu_thread_affine_rnp(kworker->task, rnp);
+	wake_up_process(kworker->task);
 }
 
 static void __init rcu_start_exp_gp_kworker(void)
@@ -4931,79 +4940,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	return 0;
 }
 
-static void rcu_thread_affine_rnp(struct task_struct *t, struct rcu_node *rnp)
-{
-	cpumask_var_t affinity;
-	int cpu;
-
-	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
-		return;
-
-	for_each_leaf_node_possible_cpu(rnp, cpu)
-		cpumask_set_cpu(cpu, affinity);
-
-	kthread_affine_preferred(t, affinity);
-
-	free_cpumask_var(affinity);
-}
-
-/*
- * Update kthreads affinity during CPU-hotplug changes.
- *
- * Set the per-rcu_node kthread's affinity to cover all CPUs that are
- * served by the rcu_node in question.  The CPU hotplug lock is still
- * held, so the value of rnp->qsmaskinit will be stable.
- *
- * We don't include outgoingcpu in the affinity set, use -1 if there is
- * no outgoing CPU.  If there are no CPUs left in the affinity set,
- * this function allows the kthread to execute on any CPU.
- *
- * Any future concurrent calls are serialized via ->kthread_mutex.
- */
-static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
-{
-	cpumask_var_t cm;
-	unsigned long mask;
-	struct rcu_data *rdp;
-	struct rcu_node *rnp;
-	struct task_struct *task_exp;
-
-	rdp = per_cpu_ptr(&rcu_data, cpu);
-	rnp = rdp->mynode;
-
-	task_exp = rcu_exp_par_gp_task(rnp);
-
-	/*
-	 * If CPU is the boot one, this task is created later from early
-	 * initcall since kthreadd must be created first.
-	 */
-	if (!task_exp)
-		return;
-
-	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
-		return;
-
-	mutex_lock(&rnp->kthread_mutex);
-	mask = rcu_rnp_online_cpus(rnp);
-	for_each_leaf_node_possible_cpu(rnp, cpu)
-		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
-		    cpu != outgoingcpu)
-			cpumask_set_cpu(cpu, cm);
-	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
-	if (cpumask_empty(cm)) {
-		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
-		if (outgoingcpu >= 0)
-			cpumask_clear_cpu(outgoingcpu, cm);
-	}
-
-	if (task_exp)
-		set_cpus_allowed_ptr(task_exp, cm);
-
-	mutex_unlock(&rnp->kthread_mutex);
-
-	free_cpumask_var(cm);
-}
-
 /*
  * Has the specified (known valid) CPU ever been fully online?
  */
@@ -5032,7 +4968,6 @@ int rcutree_online_cpu(unsigned int cpu)
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
-	rcutree_affinity_setting(cpu, -1);
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
@@ -5249,8 +5184,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	rnp->ffmask &= ~rdp->grpmask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
-	rcutree_affinity_setting(cpu, cpu);
-
 	// nohz_full CPUs need the tick for stop-machine to work quickly
 	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
-- 
2.45.2

