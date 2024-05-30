Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF93183097;
	Thu, 30 May 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076774; cv=none; b=g82u042oxetI1/C0sa9Rzaz/EzSRgg+YHdzJRBzTTZmo+T5Z8+1QxjXHg7+6GQxn2kyH35f8rxj6H6vxxJD6R+HqjccWHDaoEpqrZJzqEg8tnQTobLzZFtweZAlByz7JTKn2QeBTkKjqLHpgTwSfLyRzi0TuWpZduRvv+0xMOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076774; c=relaxed/simple;
	bh=1x1ZVvoyd/scItjNHmQqJ4F98y6ofZVQkFFX62fDv8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2ZeVxX873U+IK+elYNvPuXB1A7s8S0zvnPR6xtR9MG0FaouX5nJxZh2kVuTdJidI9XknFi6FOrv9JJBBZt/QSUXZpKQmQZvp7CE0ANnNkenmnIZsKdAkXPUCDBzPsVnvtBUS79xmryBJ9All3Z82tHm/S7tEU6cqgtv53hXs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+Dp4oti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+Dp4oti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6553DC3277B;
	Thu, 30 May 2024 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076774;
	bh=1x1ZVvoyd/scItjNHmQqJ4F98y6ofZVQkFFX62fDv8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+Dp4otiz13s3D9mmrv1NMF6JR15JpCaztJ+OxGyanZkeONy/xGoQLCC8EfW4Hk90
	 /Ockty4XmudJ5Lz5BDN70tYiaND2BUTaxbHwkCbfOfFf5W1JssvLMAw+7ni0YxnoAZ
	 aMnUlpNNVPt1ksuEfWLecVJ8qTqcEi5zLx6PkS83cwxWdOSkwThZ0sr5AEZYLmhYQz
	 btHODWYs/YIpqRPsP/lRtc6HJNjDCTU8z93oTmsyf6vMLumJU23sfRBZjar11ctiQC
	 /EBdp5ZtFW3i8iDdaRf3FdaDgpQSrRs58qxUEonEMuiIxA0sSLM04jBNGjjT37GmoW
	 ZbYhIRe8FAQBg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 04/11] rcu/nocb: Introduce nocb mutex
Date: Thu, 30 May 2024 15:45:45 +0200
Message-ID: <20240530134552.5467-5-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The barrier_mutex is used currently to protect (de-)offloading
operations and prevent from nocb_lock locking imbalance in rcu_barrier()
and shrinker, and also from misordered RCU barrier invocation.

Now since RCU (de-)offloading is going to happen on offline CPUs, an RCU
barrier will have to be executed while transitionning from offloaded to
de-offloaded state. And this can't happen while holding the
barrier_mutex.

Introduce a NOCB mutex to protect (de-)offloading transitions. The
barrier_mutex is still held for now when necessary to avoid barrier
callbacks reordering and nocb_lock imbalance.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c        |  3 +++
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_nocb.h   | 20 ++++++++++++--------
 kernel/rcu/tree_plugin.h |  1 +
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4cbc4e78a8c5..e904c187c281 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -97,6 +97,9 @@ static struct rcu_state rcu_state = {
 	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
 		rcu_sr_normal_gp_cleanup_work),
 	.srs_cleanups_pending = ATOMIC_INIT(0),
+#ifdef CONFIG_RCU_NOCB_CPU
+	.nocb_mutex = __MUTEX_INITIALIZER(rcu_state.nocb_mutex),
+#endif
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a297dc89a09c..16e6fe63d93c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -421,6 +421,7 @@ struct rcu_state {
 	atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
 
 #ifdef CONFIG_RCU_NOCB_CPU
+	struct mutex nocb_mutex;		/* Guards (de-)offloading */
 	int nocb_is_setup;			/* nocb is setup from boot */
 #endif
 };
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fdd0616f2fd1..16bcb8b13a5e 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1141,6 +1141,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	int ret = 0;
 
 	cpus_read_lock();
+	mutex_lock(&rcu_state.nocb_mutex);
 	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
@@ -1153,6 +1154,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 		}
 	}
 	mutex_unlock(&rcu_state.barrier_mutex);
+	mutex_unlock(&rcu_state.nocb_mutex);
 	cpus_read_unlock();
 
 	return ret;
@@ -1228,6 +1230,7 @@ int rcu_nocb_cpu_offload(int cpu)
 	int ret = 0;
 
 	cpus_read_lock();
+	mutex_lock(&rcu_state.nocb_mutex);
 	mutex_lock(&rcu_state.barrier_mutex);
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
@@ -1240,6 +1243,7 @@ int rcu_nocb_cpu_offload(int cpu)
 		}
 	}
 	mutex_unlock(&rcu_state.barrier_mutex);
+	mutex_unlock(&rcu_state.nocb_mutex);
 	cpus_read_unlock();
 
 	return ret;
@@ -1257,7 +1261,7 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 		return 0;
 
 	/*  Protect rcu_nocb_mask against concurrent (de-)offloading. */
-	if (!mutex_trylock(&rcu_state.barrier_mutex))
+	if (!mutex_trylock(&rcu_state.nocb_mutex))
 		return 0;
 
 	/* Snapshot count of all CPUs */
@@ -1267,7 +1271,7 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 		count +=  READ_ONCE(rdp->lazy_len);
 	}
 
-	mutex_unlock(&rcu_state.barrier_mutex);
+	mutex_unlock(&rcu_state.nocb_mutex);
 
 	return count ? count : SHRINK_EMPTY;
 }
@@ -1285,9 +1289,9 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
 	 * may be ignored or imbalanced.
 	 */
-	if (!mutex_trylock(&rcu_state.barrier_mutex)) {
+	if (!mutex_trylock(&rcu_state.nocb_mutex)) {
 		/*
-		 * But really don't insist if barrier_mutex is contended since we
+		 * But really don't insist if nocb_mutex is contended since we
 		 * can't guarantee that it will never engage in a dependency
 		 * chain involving memory allocation. The lock is seldom contended
 		 * anyway.
@@ -1326,7 +1330,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			break;
 	}
 
-	mutex_unlock(&rcu_state.barrier_mutex);
+	mutex_unlock(&rcu_state.nocb_mutex);
 
 	return count ? count : SHRINK_STOP;
 }
@@ -1473,15 +1477,15 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	 * No need to protect against concurrent rcu_barrier()
 	 * because the number of callbacks should be 0 for a non-boot CPU,
 	 * therefore rcu_barrier() shouldn't even try to grab the nocb_lock.
-	 * But hold barrier_mutex to avoid nocb_lock imbalance from shrinker.
+	 * But hold nocb_mutex to avoid nocb_lock imbalance from shrinker.
 	 */
 	WARN_ON_ONCE(system_state > SYSTEM_BOOTING && rcu_segcblist_n_cbs(&rdp->cblist));
-	mutex_lock(&rcu_state.barrier_mutex);
+	mutex_lock(&rcu_state.nocb_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		rcu_nocb_rdp_deoffload(rdp);
 		cpumask_clear_cpu(cpu, rcu_nocb_mask);
 	}
-	mutex_unlock(&rcu_state.barrier_mutex);
+	mutex_unlock(&rcu_state.nocb_mutex);
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0d6b152a9a17..05239042a08b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -28,6 +28,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
 		  lockdep_is_held(&rdp->nocb_lock) ||
+		  lockdep_is_held(&rcu_state.nocb_mutex) ||
 		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
 		   rdp == this_cpu_ptr(&rcu_data)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
-- 
2.45.1

