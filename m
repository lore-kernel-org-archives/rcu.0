Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FC17D89C;
	Thu, 30 May 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076764; cv=none; b=bT2UwxTI63fLef9KXcPaRW/e34ZykJ6ZZyyGaQ2ApFCh801N/0L3mUNEvJ/bQhv9ayq9u9pNLHiD/woqakaI+0pT8T+Fmkuo0xqrHu+I5EyPb3XBeET9i1juIsbFKmTVfS1KZQu1ewd0bNxLETHUC0J2hRAE+XVrDeMONUt7ZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076764; c=relaxed/simple;
	bh=QUqTf47U5266+G1RAYGGur6TId4oP4I8Z4uT9fa4U8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmxe9od22Nyv0fvXneEypbDNNBIucseEsUUnlflS5LEfupu2s+uxj0EhFRUVc3wQwFlzOImANQFjIwbCLG0F67F1vZR7MP0XMvBbRGEMhKTpyuz50EkK75ahmMcXf6RQN/d498WjqLhvsigf56PUGW1EwXh47HADeMGTW/SBltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV6lIgdq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV6lIgdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D6C32786;
	Thu, 30 May 2024 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076763;
	bh=QUqTf47U5266+G1RAYGGur6TId4oP4I8Z4uT9fa4U8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RV6lIgdqok+I3N32iQOTjFIewW7ShzbN5c8IEDw/xUl3IqeA7neBXsufFpkIleUht
	 PA2oWdhohOGwViCjISPag8qAV5T+9yug+yumsdqh5Q8RRt2/FoBwllY7ovT14dObSy
	 llfrTtfuncXmPPJp7jtGzVb+TuCcHg9T9z5XO08whx281ciU/Ia3c57Y9xyUHp1LRy
	 3ol14uzlG1ST66rKawwHQiRNtHVMzls9Iufrhwc/0tdqJFnlGp7/LvUoB9EIQiRVA8
	 CUtu95MQzYqDTCwwWk3Y3KonzRbvi5MubD6rLwyMTFszdIu6Dzq2FN/RekwOL9kPIE
	 cniS3ZZGrABUg==
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
Subject: [PATCH 01/11] rcu/nocb: Introduce RCU_NOCB_LOCKDEP_WARN()
Date: Thu, 30 May 2024 15:45:42 +0200
Message-ID: <20240530134552.5467-2-frederic@kernel.org>
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

Checking for races against concurrent (de-)offloading implies the
creation of !CONFIG_RCU_NOCB_CPU stubs to check if each relevant lock
is held. For now this only implies the nocb_lock but more are to be
expected.

Create instead a NOCB specific version of RCU_LOCKDEP_WARN() to avoid
the proliferation of stubs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcupdate.h |  7 +++++++
 kernel/rcu/tree_nocb.h   | 14 --------------
 kernel/rcu/tree_plugin.h |  4 ++--
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index be450a3477be..9161e00a0cf4 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -145,11 +145,18 @@ void rcu_init_nohz(void);
 int rcu_nocb_cpu_offload(int cpu);
 int rcu_nocb_cpu_deoffload(int cpu);
 void rcu_nocb_flush_deferred_wakeup(void);
+
+#define RCU_NOCB_LOCKDEP_WARN(c, s) RCU_LOCKDEP_WARN(c, s)
+
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
+
 static inline void rcu_init_nohz(void) { }
 static inline int rcu_nocb_cpu_offload(int cpu) { return -EINVAL; }
 static inline int rcu_nocb_cpu_deoffload(int cpu) { return 0; }
 static inline void rcu_nocb_flush_deferred_wakeup(void) { }
+
+#define RCU_NOCB_LOCKDEP_WARN(c, s)
+
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
 /*
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 3ce30841119a..f4112fc663a7 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -16,10 +16,6 @@
 #ifdef CONFIG_RCU_NOCB_CPU
 static cpumask_var_t rcu_nocb_mask; /* CPUs to have callbacks offloaded. */
 static bool __read_mostly rcu_nocb_poll;    /* Offload kthread are to poll. */
-static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
-{
-	return lockdep_is_held(&rdp->nocb_lock);
-}
 
 static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
 {
@@ -1653,16 +1649,6 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 
 #else /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-static inline int rcu_lockdep_is_held_nocb(struct rcu_data *rdp)
-{
-	return 0;
-}
-
-static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
-{
-	return false;
-}
-
 /* No ->nocb_lock to acquire.  */
 static void rcu_nocb_lock(struct rcu_data *rdp)
 {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 51125f4130fd..0d6b152a9a17 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -24,10 +24,10 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 	 * timers have their own means of synchronization against the
 	 * offloaded state updaters.
 	 */
-	RCU_LOCKDEP_WARN(
+	RCU_NOCB_LOCKDEP_WARN(
 		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
 		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
-		  rcu_lockdep_is_held_nocb(rdp) ||
+		  lockdep_is_held(&rdp->nocb_lock) ||
 		  (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) &&
 		   rdp == this_cpu_ptr(&rcu_data)) ||
 		  rcu_current_is_nocb_kthread(rdp)),
-- 
2.45.1

