Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606FC43470
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF79861925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhEKXNp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 793956195B;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=1QyUomA17oQXhgGPMIkRWnhiIw4oeqNqvSDrQTrADT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WU7oQW5MRiA3fQt/WfBm8EGI/B+aAN716o3d5wU4uChFvX8TnqDGRO8Geg/JMarj3
         xeNH9xpfxe4+5kjJfHIRJDQ6rz2AyPv9yMwQTaUur4X8pTQXBlX6F2nPGCUjG0jPbs
         Wl/GvhksvXxKl3s5sXzqbIDtAbUjsgfeuCHQE8tSzOp0FicvAgjxqnof7drHpcPnDi
         uBVPb5SbBeLuFd+DrReb/Kk4pumYXwy8P9cQgqMlTxx4DnoyFXQSfKktE3EiM1ot9i
         YMgdSAvbDjGOAedXxQQe4Jo/dEQvomQzvMMXaFgzXzBU2qpUEQnU0tO4y0LCZsW8WR
         eMg7BAcWoW0+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8FE065C0E5E; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 21/26] rcutorture: Forgive RCU boost failures when CPUs don't pass through QS
Date:   Tue, 11 May 2021 16:12:18 -0700
Message-Id: <20210511231223.2895398-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcu_torture_boost() runs CPU-bound at real-time priority
to force RCU priority inversions.  It then checks that grace periods
progress during this CPU-bound time.  If grace periods fail to progress,
it reports and RCU priority boosting failure.

However, it is possible (and sometimes does happen) that the grace period
fails to progress due to a CPU failing to pass through a quiescent state
for an extended time period (3.5 seconds by default).  This can happen
due to vCPU preemption, long-running interrupts, and much else besides.
There is nothing that RCU priority boosting can do about these situations,
and so they should not be counted as RCU priority boosting failures.

This commit therefore checks for CPUs (as opposed to preempted tasks)
holding up a grace period, and flags the resulting RCU priority boosting
failures, but does not splat nor count them as errors.  It does rate-limit
them to avoid flooding the console log.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        |  2 ++
 kernel/rcu/rcutorture.c | 67 +++++++++++++++++++++++++----------------
 kernel/rcu/tree_stall.h | 36 ++++++++++++++++++++++
 3 files changed, 79 insertions(+), 26 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d4b659..daf0cd3f2926 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -519,6 +519,7 @@ static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline unsigned long
 srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
+static inline bool rcu_check_boost_fail(unsigned long gp_state, int *cpup) { return true; }
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
@@ -527,6 +528,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
+bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 02a14dfcae67..5ae4dcc6ba27 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -340,6 +340,7 @@ struct rcu_torture_ops {
 	void (*fqs)(void);
 	void (*stats)(void);
 	void (*gp_kthread_dbg)(void);
+	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
 	int irq_capable;
 	int can_boost;
@@ -483,31 +484,32 @@ static void rcu_sync_torture_init(void)
 }
 
 static struct rcu_torture_ops rcu_ops = {
-	.ttype		= RCU_FLAVOR,
-	.init		= rcu_sync_torture_init,
-	.readlock	= rcu_torture_read_lock,
-	.read_delay	= rcu_read_delay,
-	.readunlock	= rcu_torture_read_unlock,
-	.readlock_held	= torture_readlock_not_held,
-	.get_gp_seq	= rcu_get_gp_seq,
-	.gp_diff	= rcu_seq_diff,
-	.deferred_free	= rcu_torture_deferred_free,
-	.sync		= synchronize_rcu,
-	.exp_sync	= synchronize_rcu_expedited,
-	.get_gp_state	= get_state_synchronize_rcu,
-	.start_gp_poll	= start_poll_synchronize_rcu,
-	.poll_gp_state	= poll_state_synchronize_rcu,
-	.cond_sync	= cond_synchronize_rcu,
-	.call		= call_rcu,
-	.cb_barrier	= rcu_barrier,
-	.fqs		= rcu_force_quiescent_state,
-	.stats		= NULL,
-	.gp_kthread_dbg	= show_rcu_gp_kthreads,
-	.stall_dur	= rcu_jiffies_till_stall_check,
-	.irq_capable	= 1,
-	.can_boost	= IS_ENABLED(CONFIG_RCU_BOOST),
-	.extendables	= RCUTORTURE_MAX_EXTEND,
-	.name		= "rcu"
+	.ttype			= RCU_FLAVOR,
+	.init			= rcu_sync_torture_init,
+	.readlock		= rcu_torture_read_lock,
+	.read_delay		= rcu_read_delay,
+	.readunlock		= rcu_torture_read_unlock,
+	.readlock_held		= torture_readlock_not_held,
+	.get_gp_seq		= rcu_get_gp_seq,
+	.gp_diff		= rcu_seq_diff,
+	.deferred_free		= rcu_torture_deferred_free,
+	.sync			= synchronize_rcu,
+	.exp_sync		= synchronize_rcu_expedited,
+	.get_gp_state		= get_state_synchronize_rcu,
+	.start_gp_poll		= start_poll_synchronize_rcu,
+	.poll_gp_state		= poll_state_synchronize_rcu,
+	.cond_sync		= cond_synchronize_rcu,
+	.call			= call_rcu,
+	.cb_barrier		= rcu_barrier,
+	.fqs			= rcu_force_quiescent_state,
+	.stats			= NULL,
+	.gp_kthread_dbg		= show_rcu_gp_kthreads,
+	.check_boost_failed	= rcu_check_boost_fail,
+	.stall_dur		= rcu_jiffies_till_stall_check,
+	.irq_capable		= 1,
+	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
+	.extendables		= RCUTORTURE_MAX_EXTEND,
+	.name			= "rcu"
 };
 
 /*
@@ -918,14 +920,27 @@ static void rcu_torture_enable_rt_throttle(void)
 
 static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
 {
+	int cpu;
 	static int dbg_done;
 	bool gp_done;
+	unsigned long j;
+	static unsigned long last_persist;
+	unsigned long lp;
+	unsigned long mininterval = test_boost_duration * HZ - HZ / 2;
 
-	if (end - start > test_boost_duration * HZ - HZ / 2) {
+	if (end - start > mininterval) {
 		// Recheck after checking time to avoid false positives.
 		smp_mb(); // Time check before grace-period check.
 		if (cur_ops->poll_gp_state(gp_state))
 			return false; // passed, though perhaps just barely
+		if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, &cpu)) {
+			// At most one persisted message per boost test.
+			j = jiffies;
+			lp = READ_ONCE(last_persist);
+			if (time_after(j, lp + mininterval) && cmpxchg(&last_persist, lp, j) == lp)
+				pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
+			return false; // passed on a technicality
+		}
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc5cbdf..af92d9fee0d4 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -716,6 +716,42 @@ static void check_cpu_stall(struct rcu_data *rdp)
 // RCU forward-progress mechanisms, including of callback invocation.
 
 
+/*
+ * Check to see if a failure to end RCU priority inversion was due to
+ * a CPU not passing through a quiescent state.  When this happens, there
+ * is nothing that RCU priority boosting can do to help, so we shouldn't
+ * count this as an RCU priority boosting failure.  A return of true says
+ * RCU priority boosting is to blame, and false says otherwise.  If false
+ * is returned, the first of the CPUs to blame is stored through cpup.
+ */
+bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
+{
+	int cpu;
+	unsigned long flags;
+	struct rcu_node *rnp;
+
+	rcu_for_each_leaf_node(rnp) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		if (!rnp->qsmask) {
+			// No CPUs without quiescent states for this rnp.
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			continue;
+		}
+		// Find the first holdout CPU.
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			if (rnp->qsmask & (1UL << (cpu - rnp->grplo))) {
+				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+				*cpup = cpu;
+				return false;
+			}
+		}
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+	// Can't blame CPUs, so must blame RCU priority boosting.
+	return true;
+}
+EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
+
 /*
  * Show the state of the grace-period kthreads.
  */
-- 
2.31.1.189.g2e36527f23

