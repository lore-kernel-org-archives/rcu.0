Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96150143C48;
	Wed,  7 Aug 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046600; cv=none; b=UdQxo2RObZcHs3EDuZT0C9P5234urFexjA0U87/M4+FIMnHztxe7jzFrT3IdB0uTMD4WceeD06LVTki/ciLUkU5sAZ6yj9u7WyP0mIgjA/dTx9TeS5u5xzRakrzr6lqfvJH1Nx6FofHk4PE+71V4bpWS54iz3TJaUQB6nmwuJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046600; c=relaxed/simple;
	bh=Ne/dsyLLelRxT9PNILuzlG076E3PMgXD7LoRFHFuxtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GplTWeHneD0YOl68imvb/2DLq2SF8VNbIXdNRV9OmCdI3P7iJe/RjYfAM9BbfGnAgOLmNZa2SUbJmEfwA2zdF4aV5gXFYrP4tMX7AB808TNwZ7Qt3aW8DJU+5NI8kEkr8cwPv5zGd1NaU5Zm8+od1exKOXSmNTEThZhZU9KkOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoSO5HtG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoSO5HtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E79FC32781;
	Wed,  7 Aug 2024 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723046600;
	bh=Ne/dsyLLelRxT9PNILuzlG076E3PMgXD7LoRFHFuxtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoSO5HtGHtyhc8XvQ4DhBLKCeExav2uNL31/lWi3a3QyNF6qLArWOMam4Yj9wOBHp
	 12MaGclgtZfLOmNing6Kj47Y3NRtStVN+Gcq9C3+MrmslvQOQ8opcWB1HIZha/LwA8
	 TFjqsoPZF38cVVUu+Q8ebSgIAI/p15LQdG2zT8CwxXNgG2++JWc21CK35tdank1obK
	 Js3F+BfzLfWX0HyrwtPBWzvrO7YUvtrOP0VH4Yobk9hGD7Brsyk6mNo4Mu3ydE9wpt
	 lqPObX4AXP2hyP9KQYgR9hw3ZBo1CpefUj4tdl0KvUcWUB9lmyKCaqBQ3rRmvLSuP1
	 ZSD+k81l4n5/A==
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
Subject: [PATCH 16/19] rcu: Use kthread preferred affinity for RCU boost
Date: Wed,  7 Aug 2024 18:02:22 +0200
Message-ID: <20240807160228.26206-17-frederic@kernel.org>
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
against CPU hotplug and housekeeping cpumask, convert RCU boost to use
it instead of handling all the constraints by itself.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        | 27 +++++++++++++++++++--------
 kernel/rcu/tree_plugin.h | 11 ++---------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..945e196090ed 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -149,7 +149,6 @@ static int rcu_scheduler_fully_active __read_mostly;
 
 static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
-static struct task_struct *rcu_boost_task(struct rcu_node *rnp);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
@@ -4932,6 +4931,22 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
@@ -4951,19 +4966,18 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
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
@@ -4985,9 +4999,6 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 	if (task_exp)
 		set_cpus_allowed_ptr(task_exp, cm);
 
-	if (task_boost)
-		set_cpus_allowed_ptr(task_boost, cm);
-
 	mutex_unlock(&rnp->kthread_mutex);
 
 	free_cpumask_var(cm);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c569da65b421..d1ff1b982ca2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1216,16 +1216,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
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
@@ -1242,10 +1239,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static struct task_struct *rcu_boost_task(struct rcu_node *rnp)
-{
-	return NULL;
-}
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 /*
-- 
2.45.2

