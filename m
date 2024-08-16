Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DF8489;
	Fri, 16 Aug 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784214; cv=none; b=Ye3ADH/+Tq27LenrK/s1nw8Urd8fMVY+7yvEZHXEDi1Zi745bHRUh8PRNziAWfk6iR2zC65grqgbqUY7Vqb4QpnK7I1HDvGypOHW1X9/7xc7Cd3hQV4NwuZOiYZateA2C93dIHBZryHhNLdLNJG77NqRD0sl0CwGv1o8P1mxoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784214; c=relaxed/simple;
	bh=GD54REaocEa+voN2IWMZ41x1crqL2Eq/6+CMI99Tjlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QF6WSwMhttOpaDIPE++r3MWZuJFdrl1k469izqsfl5g1q8Ip8Zq2YRJo490895Nb1RQpDrXaqgdDJhj+gSCzd+pzd9tCibk72PDsdZgYiuEPdCj9FdA9WRmD5VOkc/0kWhjnnYA/p+vU3fCZigFZP6PeeXMb6S1zDRzoRvLMF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Uo08DW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Uo08DW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF5CC4AF11;
	Fri, 16 Aug 2024 04:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784214;
	bh=GD54REaocEa+voN2IWMZ41x1crqL2Eq/6+CMI99Tjlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1Uo08DW48ILJi+vzKrAFG/3gwb99muWmTGFkNHZgAf0qakm1URbwCKB4NamacTDP
	 QMSR6HkWktPE/NVK1YLlzytWJ3SjP8ViU0S1oyxdI1qv1/ZPDxh6np21pNtDqs2p/s
	 RYNFYGV0jtHW4QiAIw0HuRf3Qz4vCFE1xAoHYpNDzZ9tOG9pkJU+b+4I89VPURp+rL
	 0D28RwVELGQeyh61MZBFvSZzFeY899uHxtRMMyjYLR+ZU3dyqgiHqvzzA2P32CVo6h
	 M2e3TWJM/XFJacV4dMzREx/SI2IrtwZaZKHy4Ydi1L6RKGWwvxD/ti6J2SI0Z0u9qm
	 dFu8V3cERO3Qg==
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
Subject: [PATCH rcu 01/11] rcu/nocb: Introduce RCU_NOCB_LOCKDEP_WARN()
Date: Fri, 16 Aug 2024 10:25:58 +0530
Message-Id: <20240816045608.30564-2-neeraj.upadhyay@kernel.org>
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

Checking for races against concurrent (de-)offloading implies the
creation of !CONFIG_RCU_NOCB_CPU stubs to check if each relevant lock
is held. For now this only implies the nocb_lock but more are to be
expected.

Create instead a NOCB specific version of RCU_LOCKDEP_WARN() to avoid
the proliferation of stubs.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcupdate.h |  7 +++++++
 kernel/rcu/tree_nocb.h   | 14 --------------
 kernel/rcu/tree_plugin.h |  4 ++--
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 13f6f00aecf9..d48d3c237305 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -144,11 +144,18 @@ void rcu_init_nohz(void);
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
index c569da65b421..f752b2a1d887 100644
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
2.40.1

