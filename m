Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7D1DA0EB;
	Wed, 11 Dec 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931687; cv=none; b=ACDv1RjiLkDFMknpoM1gAsThqHRu6hH/NdPqA1WVlfDL+Qzkw+sM8wfrBo/F9tPwJlSLRsYmLg4yplSmapsCwenOm9INEpy19U+SwrEIw3hl3Vu96mh2PoCKxEk48WTJSfNmjKkpN/t4j0e4XFlj9Ap7q1XYuG4SjBjHg07IvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931687; c=relaxed/simple;
	bh=C3BuQ9AhoZOPgKjizUoNBYGAfs9VgXd86X6HfcHTAjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDlm4Jt+vMmY2IxVS1y/p2qvE3iM0rsQqwLEZdMo7I3vvhzYTlv6FzlFe664S7k8wbxwBOQBp7x69HuL9Oacq24DlfMauNxF6L2UPfDxVwprscPL8GYVR4hpAhhHFwT88amEl0p9Q2l/DqDD10tslqcZQIrumNF0ou0tALaUvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlQaT9QM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlQaT9QM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236DAC4CEE2;
	Wed, 11 Dec 2024 15:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931684;
	bh=C3BuQ9AhoZOPgKjizUoNBYGAfs9VgXd86X6HfcHTAjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlQaT9QM5IM14zjcjBg1JUylks/dij8atocucfV8ML0+u8jXhcRtMLX/t8q1F6Ogx
	 yxCT8S2/DsL7Ll64TOKdSJ0w00IEMLsW/XwZTx9gTJkvfM4vR0k1ZexTHS8re4sL5c
	 GkVOzKCVrpNkF9IBXsgz7MIA6xguRm66rEvyozRa3ZRqeAdvRjcGlFh07cKxLgv7pq
	 g3foCSmABKnF/qxw5lvC9hQk0dOtxk2qx+ZtUWVqWvMdaWgwwwrEvo64hLHGEMM5R8
	 eJs3/q9g4hzP7NUwiSUo1OH4GLPZ9eqHsyzcf/zk4ExT8S1JBCU7iwRNpcXoS/t3Qc
	 3FAIYD/gahe+g==
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
Subject: [PATCH 16/19] rcu: Use kthread preferred affinity for RCU boost
Date: Wed, 11 Dec 2024 16:40:29 +0100
Message-ID: <20241211154035.75565-17-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that kthreads have an infrastructure to handle preferred affinity
against CPU hotplug and housekeeping cpumask, convert RCU boost to use
it instead of handling all the constraints by itself.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        | 27 +++++++++++++++++++--------
 kernel/rcu/tree_plugin.h | 11 ++---------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff98233d4aa5..4a4c49821058 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -149,7 +149,6 @@ static int rcu_scheduler_fully_active __read_mostly;
 
 static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
-static struct task_struct *rcu_boost_task(struct rcu_node *rnp);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
@@ -5011,6 +5010,22 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	return 0;
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
 /*
  * Update kthreads affinity during CPU-hotplug changes.
  *
@@ -5030,19 +5045,18 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct task_struct *task_boost, *task_exp;
+	struct task_struct *task_exp;
 
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 
-	task_boost = rcu_boost_task(rnp);
 	task_exp = rcu_exp_par_gp_task(rnp);
 
 	/*
-	 * If CPU is the boot one, those tasks are created later from early
+	 * If CPU is the boot one, this task is created later from early
 	 * initcall since kthreadd must be created first.
 	 */
-	if (!task_boost && !task_exp)
+	if (!task_exp)
 		return;
 
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
@@ -5064,9 +5078,6 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 	if (task_exp)
 		set_cpus_allowed_ptr(task_exp, cm);
 
-	if (task_boost)
-		set_cpus_allowed_ptr(task_boost, cm);
-
 	mutex_unlock(&rnp->kthread_mutex);
 
 	free_cpumask_var(cm);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3927ea5f7955..b141b8cc4f41 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1217,16 +1217,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+	rcu_thread_affine_rnp(t, rnp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 }
 
-static struct task_struct *rcu_boost_task(struct rcu_node *rnp)
-{
-	return READ_ONCE(rnp->boost_kthread_task);
-}
-
 #else /* #ifdef CONFIG_RCU_BOOST */
 
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
@@ -1243,10 +1240,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static struct task_struct *rcu_boost_task(struct rcu_node *rnp)
-{
-	return NULL;
-}
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 /*
-- 
2.46.0

