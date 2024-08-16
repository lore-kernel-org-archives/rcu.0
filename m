Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA0811F1;
	Fri, 16 Aug 2024 04:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784230; cv=none; b=QPLHMXd7l4MUxQrZns/8etmE8zXyITh4/ft1CD8gB0tWxER/bGWYxnXpDyGnmXgGRkCpIMur1YvBSru0KmqcgwI5tBunSHRE1vvaDa6EqCH1lL0SNbEpc88FNmgxiiTtVOrH81m4UZgLROw3THn22QsE++M/+QBNNghKTUEVl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784230; c=relaxed/simple;
	bh=TY6C94/sQ+9bIRHYOZyuRxFH7OnsfjPwSdnodO+mbk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3weMDrM4jMFanLuUCSPm1Zh2vkohkaoTr1sChs3gSXpq3dPEvHGTj6Hm7hfXtvFy9jBU3l+ry7z99RoWhTccPoS2N1c39l5uusrJ8b7vWLUGhowXY+jFp9JMP9PUHWfWdIsd50XRnGhBrfESa/plnMISPcRLQzE0dRn3aMTnDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgwJ80mr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgwJ80mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1CDC32782;
	Fri, 16 Aug 2024 04:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784229;
	bh=TY6C94/sQ+9bIRHYOZyuRxFH7OnsfjPwSdnodO+mbk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgwJ80mr/gzKVi3zQkkYugHQ/Ub7YUR+sy0uxAfGlnRACuxOGUZj4y8GLuttamntN
	 C6x+M0KjfIcHuTbhv5gTSe9ERPGunjgFaqm07hkJDy5MrKnfTV769AK1hhXweQrEqN
	 ApqX0Jv7M5N+LRxlIy6UdaDt6WOflc9L6/ciWkfbYVr4l22gtD/yPBIbeShDqnj1MM
	 q0vKfqhI5SIwQ/+einGyqGlCBBZphPBdVrIGlpZzopBonF64JI52neDhj5vaevJpbS
	 D8Z68SNo+32xqvKzNtUWJazuP8N4x89dXrRRoN25CsS/GUvX5tPjw/yLyvNZF66F0F
	 luZrn2qN71taA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 04/11] rcu/nocb: Introduce nocb mutex
Date: Fri, 16 Aug 2024 10:26:01 +0530
Message-Id: <20240816045608.30564-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c        |  3 +++
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_nocb.h   | 20 ++++++++++++--------
 kernel/rcu/tree_plugin.h |  1 +
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..2b9e713854b0 100644
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
index f752b2a1d887..c662376c8af0 100644
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
2.40.1

