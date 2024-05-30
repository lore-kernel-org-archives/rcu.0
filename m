Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB518629C;
	Thu, 30 May 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076799; cv=none; b=OWjryyreVGAJhyFhvSvOViv+HogRXUUVX4c49syXoLmO1IkQT8FQIx5NIEHwlIUn+a0cUmjE3gMwvHzlxr26Fsjv1XKIb3TrvLiKbbSnBe0ipdpCIK+fjB8KfL2oUWkHBZTOb1G+I6qcqBXhV+eAZOw9oxMgr4NtSbcO4aJ/pCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076799; c=relaxed/simple;
	bh=5Eg4GaLBOxL8naL2rLPqjFnUy4IeU93CYyjutOJ74xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcyNDkGHeX5ujsKFwCxMnUoYZrUPAmDXhXqbj388xlc5UlmTDvQef6lCrJ/bJL6P45A/nRV4LofsVSjHn+rl2URsYYormMP75hA+8LeD1DW1eRz0DQNU5Iub3AoKGDKWRVxW+zUs5oFhn3LfQWWtDk5CplQiwDcKIlekSWuFo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqO9QMD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqO9QMD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1B4C32786;
	Thu, 30 May 2024 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076798;
	bh=5Eg4GaLBOxL8naL2rLPqjFnUy4IeU93CYyjutOJ74xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqO9QMD8iUVfaAcQq+oeajOCCmPeaGSEvPzFxDSqVRPsoF9X/kFYrzwwPUKxIjuxi
	 8UlNw8Z134d0H/rm16Z7HiHzEX7oWCFdxMC2fg5hiREV9WP8Z5EuLm8XMG0p+JrDUA
	 e5t0xAYZa/1l5NeNUzIpu4T40MNihhDSEdRVMOW2cPU5mfDf8YqHDTtGjvukrvGK1j
	 h/Kkv5EY8ezyD6xRXuUPKAf/d2NyKDUc/BJ7XuxUJ9zn9emYE7oWEInUhGkCmfZEyX
	 8Kmw+Cc69QvVaHaCJsPanWbmiaEw+okd7cTi0Qq0KIg1PxiQ0SUhKad/3PomNZPW15
	 heGyHIHGTbYqg==
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
Subject: [PATCH 11/11] rcu/nocb: Simplify (de-)offloading state machine
Date: Thu, 30 May 2024 15:45:52 +0200
Message-ID: <20240530134552.5467-12-frederic@kernel.org>
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

Now that the (de-)offloading process can only apply to offline CPUs,
there is no more concurrency between rcu_core and nocb kthreads. Also
the mutation now happens on empty queues.

Therefore the state machine can be reduced to a single bit called
SEGCBLIST_OFFLOADED. Simplify the transition as follows:

* Upon offloading: queue the rdp to be added to the rcuog list and
  wait for the rcuog kthread to set the SEGCBLIST_OFFLOADED bit. Unpark
  rcuo kthread.

* Upon de-offloading: Park rcuo kthread. Queue the rdp to be removed
  from the rcuog list and wait for the rcuog kthread to clear the
  SEGCBLIST_OFFLOADED bit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcu_segcblist.h |   4 +-
 kernel/rcu/rcu_segcblist.c    |  11 ---
 kernel/rcu/rcu_segcblist.h    |   2 +-
 kernel/rcu/tree_nocb.h        | 129 ++++++++++++++++------------------
 4 files changed, 61 insertions(+), 85 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 1ef1bb54853d..2fdc2208f1ca 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -185,9 +185,7 @@ struct rcu_cblist {
  *  ----------------------------------------------------------------------------
  */
 #define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_LOCKING	BIT(1)
-#define SEGCBLIST_KTHREAD_GP	BIT(2)
-#define SEGCBLIST_OFFLOADED	BIT(3)
+#define SEGCBLIST_OFFLOADED	BIT(1)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 1693ea22ef1b..298a2c573f02 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -260,17 +260,6 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
-/*
- * Mark the specified rcu_segcblist structure as offloaded (or not)
- */
-void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
-{
-	if (offload)
-		rcu_segcblist_set_flags(rsclp, SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED);
-	else
-		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
-}
-
 /*
  * Does the specified rcu_segcblist structure contain callbacks that
  * are ready to be invoked?
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 7a0962dfee86..259904075636 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -89,7 +89,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
 	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_LOCKING))
+	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED))
 		return true;
 
 	return false;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 24daf606de0c..72a2990d2087 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -604,37 +604,33 @@ static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
 	}
 }
 
-static int nocb_gp_toggle_rdp(struct rcu_data *rdp)
+static void nocb_gp_toggle_rdp(struct rcu_data *rdp_gp, struct rcu_data *rdp)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
-	int ret;
 
-	rcu_nocb_lock_irqsave(rdp, flags);
-	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED) &&
-	    !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
+	/*
+	 * Locking orders future de-offloaded callbacks enqueue against previous
+	 * handling of this rdp. Ie: Make sure rcuog is done with this rdp before
+	 * deoffloaded callbacks can be enqueued.
+	 */
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
 		/*
 		 * Offloading. Set our flag and notify the offload worker.
 		 * We will handle this rdp until it ever gets de-offloaded.
 		 */
-		rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_GP);
-		ret = 1;
-	} else if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED) &&
-		   rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
+		list_add_tail(&rdp->nocb_entry_rdp, &rdp_gp->nocb_head_rdp);
+		rcu_segcblist_set_flags(cblist, SEGCBLIST_OFFLOADED);
+	} else {
 		/*
 		 * De-offloading. Clear our flag and notify the de-offload worker.
 		 * We will ignore this rdp until it ever gets re-offloaded.
 		 */
-		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
-		ret = 0;
-	} else {
-		WARN_ON_ONCE(1);
-		ret = -1;
+		list_del(&rdp->nocb_entry_rdp);
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_OFFLOADED);
 	}
-
-	rcu_nocb_unlock_irqrestore(rdp, flags);
-
-	return ret;
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 }
 
 static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
@@ -841,14 +837,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	}
 
 	if (rdp_toggling) {
-		int ret;
-
-		ret = nocb_gp_toggle_rdp(rdp_toggling);
-		if (ret == 1)
-			list_add_tail(&rdp_toggling->nocb_entry_rdp, &my_rdp->nocb_head_rdp);
-		else if (ret == 0)
-			list_del(&rdp_toggling->nocb_entry_rdp);
-
+		nocb_gp_toggle_rdp(my_rdp, rdp_toggling);
 		swake_up_one(&rdp_toggling->nocb_state_wq);
 	}
 
@@ -1018,16 +1007,11 @@ void rcu_nocb_flush_deferred_wakeup(void)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_flush_deferred_wakeup);
 
-static int rdp_offload_toggle(struct rcu_data *rdp,
-			       bool offload, unsigned long flags)
-	__releases(rdp->nocb_lock)
+static int rcu_nocb_queue_toggle_rdp(struct rcu_data *rdp)
 {
-	struct rcu_segcblist *cblist = &rdp->cblist;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	bool wake_gp = false;
-
-	rcu_segcblist_offload(cblist, offload);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	unsigned long flags;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 	// Queue this rdp for add/del to/from the list to iterate on rcuog
@@ -1041,9 +1025,25 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	return wake_gp;
 }
 
+static bool rcu_nocb_rdp_deoffload_wait_cond(struct rcu_data *rdp)
+{
+	unsigned long flags;
+	bool ret;
+
+	/*
+	 * Locking makes sure rcuog is done handling this rdp before deoffloaded
+	 * enqueue can happen. Also it keeps the SEGCBLIST_OFFLOADED flag stable
+	 * while the ->nocb_lock is held.
+	 */
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	ret = !rcu_segcblist_test_flags(&rdp->cblist, SEGCBLIST_OFFLOADED);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+
+	return ret;
+}
+
 static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 {
-	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int wake_gp;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
@@ -1059,19 +1059,20 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
+	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	wake_gp = rdp_offload_toggle(rdp, false, flags);
+	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
 	if (rdp_gp->nocb_gp_kthread) {
 		if (wake_gp)
 			wake_up_process(rdp_gp->nocb_gp_kthread);
 
-		swait_event_exclusive(rdp->nocb_state_wq,
-				      !rcu_segcblist_test_flags(cblist,
-								SEGCBLIST_KTHREAD_GP));
 		if (rdp->nocb_cb_kthread)
 			kthread_park(rdp->nocb_cb_kthread);
+
+		swait_event_exclusive(rdp->nocb_state_wq,
+				      rcu_nocb_rdp_deoffload_wait_cond(rdp));
 	} else {
 		/*
 		 * No kthread to clear the flags for us or remove the rdp from the nocb list
@@ -1079,29 +1080,14 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 		 * but we stick to paranoia in this rare path.
 		 */
 		rcu_nocb_lock_irqsave(rdp, flags);
-		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
-		rcu_nocb_unlock_irqrestore(rdp, flags);
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_OFFLOADED);
+		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
 		list_del(&rdp->nocb_entry_rdp);
 	}
+
 	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 
-	/*
-	 * Lock one last time to acquire latest callback updates from kthreads
-	 * so we can later handle callbacks locally without locking.
-	 */
-	rcu_nocb_lock_irqsave(rdp, flags);
-	/*
-	 * Theoretically we could clear SEGCBLIST_LOCKING after the nocb
-	 * lock is released but how about being paranoid for once?
-	 */
-	rcu_segcblist_clear_flags(cblist, SEGCBLIST_LOCKING);
-	/*
-	 * Without SEGCBLIST_LOCKING, we can't use
-	 * rcu_nocb_unlock_irqrestore() anymore.
-	 */
-	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-
 	return 0;
 }
 
@@ -1129,10 +1115,20 @@ int rcu_nocb_cpu_deoffload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
+static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
+{
+	unsigned long flags;
+	bool ret;
+
+	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
+	ret = rcu_segcblist_test_flags(&rdp->cblist, SEGCBLIST_OFFLOADED);
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
+
+	return ret;
+}
+
 static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 {
-	struct rcu_segcblist *cblist = &rdp->cblist;
-	unsigned long flags;
 	int wake_gp;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
@@ -1152,20 +1148,14 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
 
-	/*
-	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
-	 * is set.
-	 */
-	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
-
-	wake_gp = rdp_offload_toggle(rdp, true, flags);
+	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
 	if (wake_gp)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
 
-	kthread_unpark(rdp->nocb_cb_kthread);
-
 	swait_event_exclusive(rdp->nocb_state_wq,
-			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
+			      rcu_nocb_rdp_offload_wait_cond(rdp));
+
+	kthread_unpark(rdp->nocb_cb_kthread);
 
 	return 0;
 }
@@ -1340,8 +1330,7 @@ void __init rcu_init_nohz(void)
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_segcblist_empty(&rdp->cblist))
 			rcu_segcblist_init(&rdp->cblist);
-		rcu_segcblist_offload(&rdp->cblist, true);
-		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_KTHREAD_GP);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_OFFLOADED);
 	}
 	rcu_organize_nocb_kthreads();
 }
-- 
2.45.1

