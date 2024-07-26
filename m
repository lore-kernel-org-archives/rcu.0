Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8815D5C3;
	Fri, 26 Jul 2024 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031069; cv=none; b=CJBau4jJclyozmAuQ3ZF9MCQYGbfglPs7kGD7K16xLdM7xoNEWZdh9cdMckgtsm2XEzYELnZ/Yc+6vRtwroa+YjKeQ3/yaJAtngRkyigrdjBa1GvN+aWQOaMaLw85HbJI2PSjvgS3myaDvQ9Xak9Lgc8SgAI2jxXjjPGX3Hltv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031069; c=relaxed/simple;
	bh=khKkjbT/ZH5M6AKkiB5PGWU0fksrZMOgOpy6DcH7Xws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV04bN8jC9T2fUKbuS1nDSUpxGk/udHp8mHnlwlJ7MKqX20hiFsbgSSIzFWOdAv1Kvu2KobjZomU5YVkMwBhUrcwztIXXwYduA41vAc7zaQP9K1qa1idti1JyLsD4C1q7SfpNi4U+go6HLLsQuAj3UvTmjIOBanRuUxXXfBjlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI/Az33f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI/Az33f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17872C32782;
	Fri, 26 Jul 2024 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722031069;
	bh=khKkjbT/ZH5M6AKkiB5PGWU0fksrZMOgOpy6DcH7Xws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BI/Az33fd593k7oPng2yPoEpT9iGCqXvLQ1HENLex3XgArF2gmp9w6s0K1ZPxk0Xj
	 8Wgk0TjZBt98gAvlqFQP4ZMQ1AwYSHrHfHCYpEYgufr19gmmBeLN9Dj9ysuECqwJaJ
	 nH+zwJU96o2SDm5oBNzhPRvXH2ix3+ssQxwG1VJJryT+vgRn4C+KhSclydsfoYUtTF
	 ID7jVZV9vIz58Xy7J1qJAEULkpqVWOINgL2rkN8w+W1FLdoXUGKrFG9LM0GHLlh7df
	 oSFb/J2PoyDojvYxyJFZV4jTn/w/1KXbD39exywojHa2Fs59ZP50S4O8tbYor/8PBt
	 mcelqv8RZ5TGw==
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
Subject: [RFC PATCH 17/20] rcu: Use kthread preferred affinity for RCU boost
Date: Fri, 26 Jul 2024 23:56:53 +0200
Message-ID: <20240726215701.19459-18-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726215701.19459-1-frederic@kernel.org>
References: <20240726215701.19459-1-frederic@kernel.org>
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

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        | 27 +++++++++++++++++++--------
 kernel/rcu/tree_plugin.h | 11 ++---------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 28c7031711a3..6ff87a3e000b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -148,7 +148,6 @@ static int rcu_scheduler_fully_active __read_mostly;
 
 static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
-static struct task_struct *rcu_boost_task(struct rcu_node *rnp);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
@@ -4894,6 +4893,22 @@ int rcutree_prepare_cpu(unsigned int cpu)
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
@@ -4913,19 +4928,18 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
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
@@ -4947,9 +4961,6 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
 	if (task_exp)
 		set_cpus_allowed_ptr(task_exp, cm);
 
-	if (task_boost)
-		set_cpus_allowed_ptr(task_boost, cm);
-
 	mutex_unlock(&rnp->kthread_mutex);
 
 	free_cpumask_var(cm);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 340bbefe5f65..2d9eca53cb7e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1206,16 +1206,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
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
@@ -1232,10 +1229,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
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

