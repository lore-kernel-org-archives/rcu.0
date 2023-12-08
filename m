Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876947A5E
	for <rcu@vger.kernel.org>; Fri,  8 Dec 2023 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9mX3ajP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9066C433CA;
	Fri,  8 Dec 2023 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702073167;
	bh=yWebujIG4HSorgdJi4M3lUUuBe+hsvsBv+UYBWpi03o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9mX3ajPq8YULvimHUvR6KN5ezjGUnX5P3BFYLS3YyCehL1VtWGV705VErfOiqhdj
	 83TJ5wXcahka4lu7FykluPIc2eMRrgnuA4nfuXuam3jdhKyXOcg4PO7LYNtJF2N0hG
	 84uR1qF51GWYppty8R1UFYywgyxgWON2AnUWu5HjdqI96nMlCsrBZn5REKeriurL2p
	 84Rhf5qVjgnnIiynDaMaM6kAiE5hQlHumfu7vaYRKcgu04PV+USxKeWNemMDRCBhpz
	 8L12JkJGnXg/O9cPQTedeJFC8ymzxvtPSDWPCO8LEUTn0v+409vJFdc/9SVj298Czh
	 ac7QIUKTOUMpg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria.behnsen@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/8] rcu: s/boost_kthread_mutex/kthread_mutex
Date: Fri,  8 Dec 2023 23:05:42 +0100
Message-ID: <20231208220545.7452-6-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231208220545.7452-1-frederic@kernel.org>
References: <20231208220545.7452-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mutex currently protecting per node boost kthreads creation and
affinity setting across CPU hotplug operations will soon be used also
for expedited kworkers.

Generalize its name to prepare for that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 39679cf66c3a..996efaded5bf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4892,7 +4892,7 @@ static void __init rcu_init_one(void)
 			init_waitqueue_head(&rnp->exp_wq[2]);
 			init_waitqueue_head(&rnp->exp_wq[3]);
 			spin_lock_init(&rnp->exp_lock);
-			mutex_init(&rnp->boost_kthread_mutex);
+			mutex_init(&rnp->kthread_mutex);
 			raw_spin_lock_init(&rnp->exp_poll_lock);
 			rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
 			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e0e70b663cbf..f98a245e5f32 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -113,7 +113,7 @@ struct rcu_node {
 				/*  side effect, not as a lock. */
 	unsigned long boost_time;
 				/* When to start boosting (jiffies). */
-	struct mutex boost_kthread_mutex;
+	struct mutex kthread_mutex;
 				/* Exclusion for thread spawning and affinity */
 				/*  manipulation. */
 	struct task_struct *boost_kthread_task;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..0d307674915c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1195,7 +1195,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		goto out;
 
@@ -1212,7 +1212,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 
  out:
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 }
 
 /*
@@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * no outgoing CPU.  If there are no CPUs left in the affinity set,
  * this function allows the kthread to execute on any CPU.
  *
- * Any future concurrent calls are serialized via ->boost_kthread_mutex.
+ * Any future concurrent calls are serialized via ->kthread_mutex.
  */
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
@@ -1237,7 +1237,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		return;
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
@@ -1250,7 +1250,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 			cpumask_clear_cpu(outgoingcpu, cm);
 	}
 	set_cpus_allowed_ptr(t, cm);
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 	free_cpumask_var(cm);
 }
 
-- 
2.42.1

