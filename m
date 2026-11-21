Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275360;
	b=yWDo+SGn7B02ys+SQDcnMEVZ/kvJVvO2HGd21ta2BlkudovEvAsHdehAK49d+sYkAm57
	 GXBUq4eR7EptOLXwMGWdd0fpDbIlpjXYTRrcBcncK6Ea2dY+sO6vkH3FfCOfrXSNDorZY
	 DPzJnqIDmq0DRux9VZiB7vTRfpV/vF1w9Zcd1aUXs2IU4yrE6Fm9BV24/KbLsO8vm+F0f
	 df3rymfuVvSpS6YfLd+iDGmpXFbJDi5nmNUgxCWmqHx9ZupcVI2+II7w2YhtlqrI3xm20
	 1IvhzEipsy/AD6xZBHUjKvRQI4fZPvOqh6cyUWWd/fqIdS+u/dB3RsXVaufR8H6OtPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MKVZ0DHFX0TdJ61dqZcktyeB26YK/W90vSUn/sRoUrg=;
	b=g3OJNGaIKU+7HB/6amHIzVy1U6208NbK34BXjm+hvXOYbfLo6MBjq6e7XmWmVYnUAcdo
	 MRJHENefrlm3j5OyWxlk7u0n+u/SZFZghay/PaublZE2Aw3s1C+0Zpc9eXDCb62B0IdVx
	 aRmx6tROr48gAnZd1BIzG11kdA64aJrMVsf1ppbQ0XDxofWanQxwQgFk90/NeOI4CYd2e
	 GyAGpDeHsIAnnAxy7h76GQyMQ4Frk/bMXhFn12B+qOP27WmrEkq12Im621NNf2hp8R1q/
	 +j6Q/GH1cSkotGTKkzf1eEDo/BbHAjWmObTamsh8nKSwRE25e47R6foLZfeLTGDFGeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHK2ASIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C24F0606A338;
	Sat, 21 Nov 2026 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHK2ASIn
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 327341F000D2;
	Sat, 21 Nov 2026 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275360;
	bh=MKVZ0DHFX0TdJ61dqZcktyeB26YK/W90vSUn/sRoUrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kHK2ASInjG/z3kABgWjGa7jfFsQ9qkvUHVrhzp093QSSd8nfAALBWffAcWhsWJGN8
	 PESWR3T3TDJmpET0tuSwRfKWVKcvAGtG9ASmyFTvt+ogqWBAyyvW/Ev/CGXT1+a/Sf
	 CWhLm/auK80aZLftRC7yYMd0mlucsea59WOPRXWgerGjBH/tbPbnvweQVbtf33Jntz
	 7fFIbGFvdBY+aNBNWG/3F/XHKXVmw5lJd5RU0aAF4eyYojtOig6ztQWNpwG1Xte3Nn
	 oZoMdRYPiXp+oe3FULO7oYQgqanzwtTGbhe3LVjvlmXqZiekt1UIE+ix7y6XNJP6uY
	 yCPl7z7YuqupA==
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
Subject: [PATCH v3 3/6] rcutorture: Remove unused check_boost_failed hook
Date: Sat, 21 Nov 2026 10:35:49 -0500
Message-ID: <20261121153552.68941-4-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121153552.68941-1-jfern@kernel.org>
References: <20261121153552.68941-1-jfern@kernel.org>
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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
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

