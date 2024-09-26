Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0951B3725;
	Thu, 26 Sep 2024 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391010; cv=none; b=Ji9g3Mtm+10nviW+VjlRN9XCeaqaXyDTXz1ZFyErxOjQCVunUB73WIij7gdxXiYfQaB6Bnfv6FKlgVX5+zvWG/WkfUm6goADqcNh/GV2OEXR1vi3IhvorwpesXMTffmofe6um8FLHtExVnv7Cic2VGbCxnvR+OrkUIEcCUCi5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391010; c=relaxed/simple;
	bh=HhhGy9lcKYwacFx42C9dv/c41qI/bpaVk8il7/rFSP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxJN2YknHdTR7n9Nd029iPpIoQSWBPrUcfmaV/52IwwcH6o5ZHKPaa3VvqYRUfQyu/vYvjNJLWovInyiSQVHK27iqHcTXVN8aQ9McvyzE5xRdbep8s9+/HClFISrqPBX29y52c/j92A+n5VWwqGTEZ2FVc4NAMMojOqMKeBYOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpSrgBYH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpSrgBYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7193BC4CECF;
	Thu, 26 Sep 2024 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727391010;
	bh=HhhGy9lcKYwacFx42C9dv/c41qI/bpaVk8il7/rFSP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpSrgBYH+mrXHuAzre0ZglTpX5h6cK+vBuIqQVKelJ4h80/S1PgwtOa3rgHq+dmC0
	 qkXdmbR82RgmwbwxO5KMxAWV6vXCcWe5afkH9AQwfxYVVf2pppWXzU8bb7OaC+CIty
	 9/TchZOG+DEp/p/IJvVpGm9Fe35F43uO/VUFwLLO6k+vCUpaPs3tzNa1MOWAanEDfV
	 bWcVxBLv7WLfr7UVkJLWzTKMBMhp4ECJXJkfsJZVQ5kh4FLl0lUhB9rXiLfIwWe+q0
	 3ZWcBWhrXM6ne0TevxHaqv3JCz0RNLYW/gmiKsMRXnUOKAeqfz6JX9Iq6hFc3BX+e4
	 gtuiXSaZAHmhg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 20/20] rcu: Use kthread preferred affinity for RCU exp kworkers
Date: Fri, 27 Sep 2024 00:49:08 +0200
Message-ID: <20240926224910.11106-21-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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
index a44228b0949a..d377a162c56c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4890,6 +4890,22 @@ rcu_boot_init_percpu_data(int cpu)
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
@@ -4902,7 +4918,7 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 	if (rnp->exp_kworker)
 		return;
 
-	kworker = kthread_run_worker(0, name, rnp_index);
+	kworker = kthread_create_worker(0, name, rnp_index);
 	if (IS_ERR_OR_NULL(kworker)) {
 		pr_err("Failed to create par gp kworker on %d/%d\n",
 		       rnp->grplo, rnp->grphi);
@@ -4912,16 +4928,9 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 
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
@@ -5006,79 +5015,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
@@ -5107,7 +5043,6 @@ int rcutree_online_cpu(unsigned int cpu)
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
-	rcutree_affinity_setting(cpu, -1);
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
@@ -5324,8 +5259,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	rnp->ffmask &= ~rdp->grpmask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
-	rcutree_affinity_setting(cpu, cpu);
-
 	// nohz_full CPUs need the tick for stop-machine to work quickly
 	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
-- 
2.46.0

