Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C138289A;
	Fri, 16 Aug 2024 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784235; cv=none; b=I0x/vIjmBCLpK5mpFLZoV929l0lyXVGO93Q9j97qljbI4G1/IN1kTMZG0fdRN0kcx6KgDxG2fE9L6qte4jp6N5wWQ2tC7nCh3g/pFKrYo9owEr63KAGRgZBPYNZdp4gFgNMtpQgL9EJOEp1JG0t+FWWpzjWhlkiDBm0EJrV2DCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784235; c=relaxed/simple;
	bh=muDO02Tdda7wTvcW8rb48y0S+3twU6d535cQUKEb+rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pthooCDLdWiC7Ko2NqfyEkJpWeoQ+qDezj3E09Agov5JAIJ8YpleC0HLB7GSeezY29Lfv/RBGhhXKt0+Edz20R1igah4vuchdh/Zz1KY97tPWyZvFc0j9WXhJc9mFy79p7i/602gEiAcoHAlV3jM+z+CAp9gLpJMKtQnXGpOCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcuzbSUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcuzbSUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99171C4AF14;
	Fri, 16 Aug 2024 04:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784235;
	bh=muDO02Tdda7wTvcW8rb48y0S+3twU6d535cQUKEb+rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcuzbSUkV+vo7Zb+vQ+YT4oFynN49hTv57kz+S0OWZQYgVtYpGs2J/WWJQwAb9Rwa
	 76KuMkljcAipAifgQ62oF+gJM40k1N8jedgX6lvwUd0Sojg+DBFxemRnr0a++HfwyH
	 1kRKaudajQgksJGDaxEpZZLlhU2ajk9DWmvA6Hs6cJpHoTWUMJ614+RCYXcQlgU0Jd
	 cR9VZC/UjoOV8eyd4HeEWw3Ax6WeeQ4naUjEA9i85JKDVPy54qj9rk5lcATbRt1Mu9
	 IEtEA6lSh/XySGB/7/PhU8jmlc31ZmCZ/TDhRebKA3JAVGmAdtXTpb9t6dFHWsx0yY
	 0iDZr0amL4/tw==
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
Subject: [PATCH rcu 05/11] rcu/nocb: (De-)offload callbacks on offline CPUs only
Date: Fri, 16 Aug 2024 10:26:02 +0530
Message-Id: <20240816045608.30564-6-neeraj.upadhyay@kernel.org>
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

Currently callbacks can be (de-)offloaded only on online CPUs. This
involves an overly elaborated state machine in order to make sure that
callbacks are always handled during the process while ensuring
synchronization between rcu_core and NOCB kthreads.

The only potential user of NOCB (de-)offloading appears to be a
nohz_full toggling interface through cpusets. And the general agreement
is now to work toward toggling the nohz_full state on offline CPUs to
simplify the whole picture.

Therefore, convert the (de-)offloading to only support offline CPUs.
This involves the following changes:

* Call rcu_barrier() before deoffloading. An offline offloaded CPU may
  still carry callbacks in its queue ignored by
  rcutree_migrate_callbacks(). Those callbacks must all be flushed
  before switching to a regular queue because no more kthreads will
  handle those before the CPU ever gets re-onlined.

  This means that further calls to rcu_barrier() will find an empty
  queue until the CPU goes through rcutree_report_cpu_starting(). As a
  result it is guaranteed that further rcu_barrier() won't try to lock
  the nocb_lock for that target and thus won't risk an imbalance.

  Therefore barrier_mutex doesn't need to be locked anymore upon
  deoffloading.

* Assume the queue is empty before offloading, as
  rcutree_migrate_callbacks() took care of everything.

  This means that further calls to rcu_barrier() will find an empty
  queue until the CPU goes through rcutree_report_cpu_starting(). As a
  result it is guaranteed that further rcu_barrier() won't risk a
  nocb_lock imbalance.

  Therefore barrier_mutex doesn't need to be locked anymore upon
  offloading.

* No need to flush bypass anymore.

Further simplifications will follow in upcoming patches.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_nocb.h | 82 +++++++++++-------------------------------
 1 file changed, 21 insertions(+), 61 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 16bcb8b13a5e..8e766396df3a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1049,43 +1049,26 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	return wake_gp;
 }
 
-static long rcu_nocb_rdp_deoffload(void *arg)
+static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
-	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int wake_gp;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
-	/*
-	 * rcu_nocb_rdp_deoffload() may be called directly if
-	 * rcuog/o[p] spawn failed, because at this time the rdp->cpu
-	 * is not online yet.
-	 */
-	WARN_ON_ONCE((rdp->cpu != raw_smp_processor_id()) && cpu_online(rdp->cpu));
+	/* CPU must be offline, unless it's early boot */
+	WARN_ON_ONCE(cpu_online(rdp->cpu) && rdp->cpu != raw_smp_processor_id());
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
+	/* Flush all callbacks from segcblist and bypass */
+	rcu_barrier();
+
 	rcu_nocb_lock_irqsave(rdp, flags);
-	/*
-	 * Flush once and for all now. This suffices because we are
-	 * running on the target CPU holding ->nocb_lock (thus having
-	 * interrupts disabled), and because rdp_offload_toggle()
-	 * invokes rcu_segcblist_offload(), which clears SEGCBLIST_OFFLOADED.
-	 * Thus future calls to rcu_segcblist_completely_offloaded() will
-	 * return false, which means that future calls to rcu_nocb_try_bypass()
-	 * will refuse to put anything into the bypass.
-	 */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
-	/*
-	 * Start with invoking rcu_core() early. This way if the current thread
-	 * happens to preempt an ongoing call to rcu_core() in the middle,
-	 * leaving some work dismissed because rcu_core() still thinks the rdp is
-	 * completely offloaded, we are guaranteed a nearby future instance of
-	 * rcu_core() to catch up.
-	 */
+	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
-	invoke_rcu_core();
 	wake_gp = rdp_offload_toggle(rdp, false, flags);
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
@@ -1128,10 +1111,6 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 */
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
-	/* Sanity check */
-	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
-
-
 	return 0;
 }
 
@@ -1142,18 +1121,16 @@ int rcu_nocb_cpu_deoffload(int cpu)
 
 	cpus_read_lock();
 	mutex_lock(&rcu_state.nocb_mutex);
-	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu)) {
-			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
+		if (!cpu_online(cpu)) {
+			ret = rcu_nocb_rdp_deoffload(rdp);
 			if (!ret)
 				cpumask_clear_cpu(cpu, rcu_nocb_mask);
 		} else {
-			pr_info("NOCB: Cannot CB-deoffload offline CPU %d\n", rdp->cpu);
+			pr_info("NOCB: Cannot CB-deoffload online CPU %d\n", rdp->cpu);
 			ret = -EINVAL;
 		}
 	}
-	mutex_unlock(&rcu_state.barrier_mutex);
 	mutex_unlock(&rcu_state.nocb_mutex);
 	cpus_read_unlock();
 
@@ -1161,15 +1138,14 @@ int rcu_nocb_cpu_deoffload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
-static long rcu_nocb_rdp_offload(void *arg)
+static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 {
-	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int wake_gp;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	WARN_ON_ONCE(cpu_online(rdp->cpu));
 	/*
 	 * For now we only support re-offload, ie: the rdp must have been
 	 * offloaded on boot first.
@@ -1182,28 +1158,15 @@ static long rcu_nocb_rdp_offload(void *arg)
 
 	pr_info("Offloading %d\n", rdp->cpu);
 
+	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
+	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+
 	/*
 	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
 	 * is set.
 	 */
 	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 
-	/*
-	 * We didn't take the nocb lock while working on the
-	 * rdp->cblist with SEGCBLIST_LOCKING cleared (pure softirq/rcuc mode).
-	 * Every modifications that have been done previously on
-	 * rdp->cblist must be visible remotely by the nocb kthreads
-	 * upon wake up after reading the cblist flags.
-	 *
-	 * The layout against nocb_lock enforces that ordering:
-	 *
-	 *  __rcu_nocb_rdp_offload()   nocb_cb_wait()/nocb_gp_wait()
-	 * -------------------------   ----------------------------
-	 *      WRITE callbacks           rcu_nocb_lock()
-	 *      rcu_nocb_lock()           READ flags
-	 *      WRITE flags               READ callbacks
-	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
-	 */
 	wake_gp = rdp_offload_toggle(rdp, true, flags);
 	if (wake_gp)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
@@ -1214,8 +1177,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
 
 	/*
-	 * All kthreads are ready to work, we can finally relieve rcu_core() and
-	 * enable nocb bypass.
+	 * All kthreads are ready to work, we can finally enable nocb bypass.
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
@@ -1231,18 +1193,16 @@ int rcu_nocb_cpu_offload(int cpu)
 
 	cpus_read_lock();
 	mutex_lock(&rcu_state.nocb_mutex);
-	mutex_lock(&rcu_state.barrier_mutex);
 	if (!rcu_rdp_is_offloaded(rdp)) {
-		if (cpu_online(cpu)) {
-			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
+		if (!cpu_online(cpu)) {
+			ret = rcu_nocb_rdp_offload(rdp);
 			if (!ret)
 				cpumask_set_cpu(cpu, rcu_nocb_mask);
 		} else {
-			pr_info("NOCB: Cannot CB-offload offline CPU %d\n", rdp->cpu);
+			pr_info("NOCB: Cannot CB-offload online CPU %d\n", rdp->cpu);
 			ret = -EINVAL;
 		}
 	}
-	mutex_unlock(&rcu_state.barrier_mutex);
 	mutex_unlock(&rcu_state.nocb_mutex);
 	cpus_read_unlock();
 
-- 
2.40.1

