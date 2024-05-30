Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E33DAC03;
	Thu, 30 May 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076777; cv=none; b=GQUtwE+oqF+RYyB7j4MIkPJgRqEI1s0yOW0XOYoR7fpSYkeDFyC4D0PbG0iYe5ffs56tKVePAbPUhCKyughnzLloUqmKHPCc7hM3vaPIK9zkL76ig9NlaFKt9cz2c72Ip5A3UnndCbI36UFJwI0Si7CCWyFFkgjIT/E5I2pS9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076777; c=relaxed/simple;
	bh=v/OAf2kjzQwHjqDLPSZ5h+nrrmz5IBPql2zqPPm7U4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4FZc+rpKVMZMeVwa9L+p4S5U0pEtDMM04iBO7sxXeYHnZLPCkiYx0l7daigWzdmpwWi7tH1c/jDxiOKlGowYJJHpmaeH2+l1H0AcTPp56YhFuFPh1NF+XBvFI1b4XUuViKZDlmoW8JgXmX2U1z6PNk5I1cCyfTQiamx6qfB0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF8Svygs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF8Svygs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF68C2BBFC;
	Thu, 30 May 2024 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076777;
	bh=v/OAf2kjzQwHjqDLPSZ5h+nrrmz5IBPql2zqPPm7U4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CF8SvygsyanYWKOiJQZrXr3ZFIfbRa5qZ8xDhQAeDCwNBcSylvE+IdDMdvzWWpXio
	 1zMFZcTWh1Um/rKCnRtLAHj9sHsJslzh3PXuFB3srZIw5+I1MZOSajVxHlwJFALTyj
	 BB5Fd0IqYKKXtH0pYiEdtE+xvQdpNL6jeDFPKa4HzDM0NMkQULuXBsk3ROEHkzFddk
	 Y0NKgZGYdgi6b3PxDvBBH8KNm76cAQctk+W1d8pfj4heLm9ZLx6RQ+nIP5PPV6qwzj
	 ZqVXMIkcG7bbuLZ3YLXl8/FQG7TY8sUaUYj4IIfcVMihAo9avw+CdSSW1bukBBB3LY
	 JhFSty8s7sKTQ==
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
Subject: [PATCH 05/11] rcu/nocb: (De-)offload callbacks on offline CPUs only
Date: Thu, 30 May 2024 15:45:46 +0200
Message-ID: <20240530134552.5467-6-frederic@kernel.org>
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
2.45.1

