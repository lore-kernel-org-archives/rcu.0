Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5914B95E;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540107; cv=none; b=JOZ542J5+jY3K4InUv38ze0yO/4uy/OEyeb9gHfO8DKHehhgvSJOr2aEaIELjHVVm12UGeh3rf1ndXIKdNNfCmnOetRf5akkIZ6nThSbWhn8AvKG7O9+rbcrv0ziSRa4VtN1bDx/qir3LhNu64KLjIWD6ZRdCUWIdpbc0CgTaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540107; c=relaxed/simple;
	bh=S5r11hWMMb3bhioaf+RARqPwFaq69Pt+JjuYSAcNtyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CP/Kv5UCEbyWxs+1SnW4Ds6Cf1CdMj32AF5v8yYZ1+uGCwiMfmD09BCEu0sxopdVOiHlc22Lq1v8Ku2W9vv+/B0cZA/N+O00Yl7KOVauOxP9IoN+7lhZbNqciKXU/Hc2loA/6MJFVFVwBesDlcxb8+58OYfEOeKKjXC7JjwjrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmffyjHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmffyjHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B784C4AF08;
	Tue,  4 Jun 2024 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540107;
	bh=S5r11hWMMb3bhioaf+RARqPwFaq69Pt+JjuYSAcNtyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmffyjHAU4Ic+EQWdSW3OWTvCQ18c4vt+3iNvUW3YmmfS/FaiFu6FjHt7fN5JnFq9
	 ahq+/K1t0SARPTJJHbClNFCp9ig1kGmgTU4ny8ex2+Qozchr6y+GYCbDeVSu1LKa4o
	 rfmdbEZgKLTYjJC+KBRRAWRgg0GH3IttB5VTrKycG3JmdJPsTah3I+Man7+TdSizHC
	 CJ2EGASLMWjpjF48dqM0IreRHdXi2wjoIMdb2IKFBy7qu+Y4ZoQiX08kKAWYdauIhx
	 yBhJ3YpbuY82XOaVVzabYIqmdU8SQPzG3kHxqqfeY36KOr6p+aqMw6TZr9SDHLsKJD
	 TXI4x2yuD7P+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C905BCE3F27; Tue,  4 Jun 2024 15:28:26 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/4] rcu/nocb: Remove buggy bypass lock contention mitigation
Date: Tue,  4 Jun 2024 15:28:25 -0700
Message-Id: <20240604222825.2371133-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
References: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

The bypass lock contention mitigation assumes there can be at most
2 contenders on the bypass lock, following this scheme:

1) One kthread takes the bypass lock
2) Another one spins on it and increment the contended counter
3) A third one (a bypass enqueuer) sees the contended counter on and
  busy loops waiting on it to decrement.

However this assumption is wrong. There can be only one CPU to find the
lock contended because call_rcu() (the bypass enqueuer) is the only
bypass lock acquire site that may not already hold the NOCB lock
beforehand, all the other sites must first contend on the NOCB lock.
Therefore step 2) is impossible.

The other problem is that the mitigation assumes that contenders all
belong to the same rdp CPU, which is also impossible for a raw spinlock.
In theory the warning could trigger if the enqueuer holds the bypass
lock and another CPU flushes the bypass queue concurrently but this is
prevented from all flush users:

1) NOCB kthreads only flush if they successfully _tried_ to lock the
   bypass lock. So no contention management here.

2) Flush on callbacks migration happen remotely when the CPU is offline.
   No concurrency against bypass enqueue.

3) Flush on deoffloading happen either locally with IRQs disabled or
   remotely when the CPU is not yet online. No concurrency against
   bypass enqueue.

4) Flush on barrier entrain happen either locally with IRQs disabled or
   remotely when the CPU is offline. No concurrency against
   bypass enqueue.

For those reasons, the bypass lock contention mitigation isn't needed
and is even wrong. Remove it but keep the warning reporting a contended
bypass lock on a remote CPU, to keep unexpected contention awareness.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 32 ++++++--------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bae7925c497fe..179f60ca03130 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -223,7 +223,6 @@ struct rcu_data {
 	struct swait_queue_head nocb_state_wq; /* For offloading state changes */
 	struct task_struct *nocb_gp_kthread;
 	raw_spinlock_t nocb_lock;	/* Guard following pair of fields. */
-	atomic_t nocb_lock_contended;	/* Contention experienced. */
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 	unsigned long nocb_gp_adv_time;	/* Last call_rcu() CB adv (jiffies). */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 808c9a19fe1d0..3ce30841119ad 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -91,8 +91,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
  * Acquire the specified rcu_data structure's ->nocb_bypass_lock.  If the
- * lock isn't immediately available, increment ->nocb_lock_contended to
- * flag the contention.
+ * lock isn't immediately available, perform minimal sanity check.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	__acquires(&rdp->nocb_bypass_lock)
@@ -100,29 +99,12 @@ static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
 		return;
-	atomic_inc(&rdp->nocb_lock_contended);
+	/*
+	 * Contention expected only when local enqueue collide with
+	 * remote flush from kthreads.
+	 */
 	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	smp_mb__after_atomic(); /* atomic_inc() before lock. */
 	raw_spin_lock(&rdp->nocb_bypass_lock);
-	smp_mb__before_atomic(); /* atomic_dec() after lock. */
-	atomic_dec(&rdp->nocb_lock_contended);
-}
-
-/*
- * Spinwait until the specified rcu_data structure's ->nocb_lock is
- * not contended.  Please note that this is extremely special-purpose,
- * relying on the fact that at most two kthreads and one CPU contend for
- * this lock, and also that the two kthreads are guaranteed to have frequent
- * grace-period-duration time intervals between successive acquisitions
- * of the lock.  This allows us to use an extremely simple throttling
- * mechanism, and further to apply it only to the CPU doing floods of
- * call_rcu() invocations.  Don't try this at home!
- */
-static void rcu_nocb_wait_contended(struct rcu_data *rdp)
-{
-	WARN_ON_ONCE(smp_processor_id() != rdp->cpu);
-	while (WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended)))
-		cpu_relax();
 }
 
 /*
@@ -510,7 +492,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	}
 
 	// We need to use the bypass.
-	rcu_nocb_wait_contended(rdp);
 	rcu_nocb_bypass_lock(rdp);
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
@@ -1631,12 +1612,11 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 
 	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
 	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
-		"cC"[!!atomic_read(&rdp->nocb_lock_contended)],
 		"lL"[raw_spin_is_locked(&rdp->nocb_lock)],
 		"sS"[!!rdp->nocb_cb_sleep],
 		".W"[swait_active(&rdp->nocb_cb_wq)],
-- 
2.40.1

