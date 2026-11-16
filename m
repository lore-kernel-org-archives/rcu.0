Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858285;
	b=OWuCltbTa36v6LKDyyLhGlEFrPKcb7pZ+hUIDtMP2rjRGbcQDqfqyQ7dvmvD9GlO8PNG
	 fHJzh5Lg0c9iZbsnO1U3BsMEwlvWW8yZxgD6T22I4lJ4biCa3f7eA9zzH3npvx84VlAfJ
	 9N41LVIVcVzH5o1xYTbaT93L/AAKvY5JXBIXaxCSXR9j0P1lMgu/IggOskCK9SwG/z+CI
	 ssiUhAjNQfh0GajVHL7ZAkk3NiCKeYg6JQVwcTXBI1M8h/kx7L0Bw1fsygbypctTbUqmk
	 a9w0+uuLANP2/sS1DVWKPJwVetyY5ppQP3/ph7CmsX1nXIzfuPprroIP7zWUQr9ddZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UWA/Jsu+k73ITgJepefnSOQSX9ddpUAy3TlmAkbH9x0=;
	b=sjXNypJBSITMOf3HItieemzSRnpf0/Wc7LVKPuX+vdOYuKw79Cu8znxpZhX/reiSJVt1
	 ezJCCI7DKsGKXwBct6jvqIhQBOGl7iuOH5nRxZBYUk+zE55kNqq16WVoczCYxwf2hbXIz
	 X1igK2h1dfEIwQLda+eMAeTxnegp0CCZw1AJPe7a8rxhoNcljTLVCHKRVezK6A8CLKmfU
	 s5eH2cNRXP56wQiC2myWN+WmBcR2C8ITqK5xE7dyoAp9b7Lj+f8cOaMlpcKFwPXskAxTq
	 ekPIBJ6yWRJU40rm7SwVUGcr7lxQusnjVLAPm04c25NNesD31nFpeNqCspRFO87JEVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHjSD5RL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C4879606A337;
	Mon, 16 Nov 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QHjSD5RL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 54C281F000CA;
	Mon, 16 Nov 2026 19:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858285;
	bh=UWA/Jsu+k73ITgJepefnSOQSX9ddpUAy3TlmAkbH9x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QHjSD5RLHDC/qr4i5taWIPjOOoMwu2B/cthcKSCxFftUYZ0ZSXpnr55F1pBMvdAJE
	 z8yg9PeHLu052PbySinuhRhWrVmImRtnJepqqtu0TdXSyVZL9iCBYzw/lLRASGRjfn
	 BG1uaeYebSRXJi4zu/JVDzokEIMpozHO4F2hJQgVkVi9Tz3YMk0yD5mEyYjoin1L2v
	 xCQqIDNSG5RG4k2RhaqIrL/KsdO4SMnNdcO/Bv0YGuNF1Tnqmt2ltPibe2r8lU65X4
	 mYzX5k3MjORo87Zo6cr0LTY79G67uhhxxAk+vKZA5HdTA48SScxOn94tZ2JwSDISdV
	 ZnrzWtGOgbbTw==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/7] rcutorture: Remove unused check_boost_failed hook
Date: Mon, 16 Nov 2026 14:44:34 -0500
Message-ID: <20261116194438.306618-4-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116194438.306618-1-jfern@kernel.org>
References: <20261116194438.306618-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing in rcutorture calls ->check_boost_failed() now that boost
failure is decided by whether the reader finished, so drop the hook
from struct rcu_torture_ops and its initializer.

That also leaves rcu_check_boost_fail() without any callers, so remove
it as well, along with its prototype and its CONFIG_TINY_RCU stub.

[ jfern: Apply feedback from Sebastian to drop stray sysctl.h include ]
[ jfern: Apply feedback from Sebastian to remove rcu_check_boost_fail() ]

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcu.h        |  2 --
 kernel/rcu/rcutorture.c |  2 --
 kernel/rcu/tree_stall.h | 57 -----------------------------------------
 3 files changed, 61 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9f7e60e69275..93542e30b7f4 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -652,7 +652,6 @@ static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
-static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { return true; }
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
@@ -662,7 +661,6 @@ static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 bool rcu_watching_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
-bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4ec2c6e1d3ba..ff674ace50a6 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -425,7 +425,6 @@ struct rcu_torture_ops {
 	void (*fqs)(void);
 	void (*stats)(void);
 	void (*gp_kthread_dbg)(void);
-	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
 	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
 	void (*gp_slow_register)(atomic_t *rgssp);
@@ -637,7 +636,6 @@ static struct rcu_torture_ops rcu_ops = {
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
-	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
 	.get_gp_data		= rcutorture_get_gp_data,
 	.gp_slow_register	= rcu_gp_slow_register,
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 08699652f51c..e0607f423564 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -922,63 +922,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 // RCU forward-progress mechanisms, including for callback invocation.
 
 
-/*
- * Check to see if a failure to end RCU priority inversion was due to
- * a CPU not passing through a quiescent state.  When this happens, there
- * is nothing that RCU priority boosting can do to help, so we shouldn't
- * count this as an RCU priority boosting failure.  A return of true says
- * RCU priority boosting is to blame, and false says otherwise.  If false
- * is returned, the first of the CPUs to blame is stored through cpup.
- * If there was no CPU blocking the current grace period, but also nothing
- * in need of being boosted, *cpup is set to -1.  This can happen in case
- * of vCPU preemption while the last CPU is reporting its quiscent state,
- * for example.
- *
- * If cpup is NULL, then a lockless quick check is carried out, suitable
- * for high-rate usage.  On the other hand, if cpup is non-NULL, each
- * rcu_node structure's ->lock is acquired, ruling out high-rate usage.
- */
-bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
-{
-	bool atb = false;
-	int cpu;
-	unsigned long flags;
-	struct rcu_node *rnp;
-
-	rcu_for_each_leaf_node(rnp) {
-		if (!cpup) {
-			if (data_race(READ_ONCE(rnp->qsmask))) {
-				return false;
-			} else {
-				if (READ_ONCE(rnp->gp_tasks))
-					atb = true;
-				continue;
-			}
-		}
-		*cpup = -1;
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		if (rnp->gp_tasks)
-			atb = true;
-		if (!rnp->qsmask) {
-			// No CPUs without quiescent states for this rnp.
-			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-			continue;
-		}
-		// Find the first holdout CPU.
-		for_each_leaf_node_possible_cpu(rnp, cpu) {
-			if (rnp->qsmask & (1UL << (cpu - rnp->grplo))) {
-				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-				*cpup = cpu;
-				return false;
-			}
-		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	}
-	// Can't blame CPUs, so must blame RCU priority boosting.
-	return atb;
-}
-EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
-
 static noinline_for_stack void show_rcu_state(void)
 {
 	unsigned long j;
-- 
2.54.0

