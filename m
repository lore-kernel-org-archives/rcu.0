Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED62C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5E761925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEKXNk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhEKXNc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B00E6194D;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=Jbgv9DhTH/13qRuqxINc3sDszutPuOHshQOWFibpZhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAUkw6Rbb3lnTVoE8v57ea0GQOAi/mGETqt6PCpRqCxYBRfUPe8FLrafALfR+oOGh
         tupwJarHiktHdT/+ejjJCxRgyapF8yKRBYl0zk2lmsPu9WiJVyUzVIYtLtjsjfUX69
         BpxvOyLgWUVz+R026LAHKjnPBhdp/wRD0k1yiYbdziEfywVZ99etJi9H6Nw28JdhJx
         gJAPf/dfhm7I6iARGk5lXiaCZV6//Bo8K9H+EutJwri8JDAGXjSVAigqPwgIHwc8Qs
         Bidg+YAwDjI3/5mdWvuo6lE13h7YkzmITtSNtdIAon1RIVffn5FgHI3MDRvrn6fUMk
         RvLfZpiYIQNPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82D0A5C0E09; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/26] rcutorture: Judge RCU priority boosting on grace periods, not callbacks
Date:   Tue, 11 May 2021 16:12:11 -0700
Message-Id: <20210511231223.2895398-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, rcutorture's testing of RCU priority boosting insists not
only that grace periods complete, but also that callbacks be invoked.
Although this is in fact what the user would want, ensuring that there
is sufficient CPU bandwidth devoted to callback execution is in fact
the user's responsibility.  One could argue that rcutorture can take on
that responsibility, which is true in theory.  But in practice, ensuring
sufficient CPU bandwidth to ksoftirqd, any rcuc kthreads, and any rcuo
kthreads is not particularly consistent with rcutorture's main job,
that of stress-testing RCU.  In addition, if the system administrator
(say) makes very poor choices when pinning rcuo kthreads and then runs
rcutorture, there really isn't much rcutorture can do.

Besides, RCU priority boosting only boosts lagging readers, not all the
machinery required to invoke callbacks in a timely fashion.

This commit therefore switches rcutorture's evaluation of RCU priority
boosting from callback execution to grace-period completion by using
the new start_poll_synchronize_rcu() and poll_state_synchronize_rcu()
functions.  When rcutorture is built in (as in when there is no innocent
workload to inconvenience), the ksoftirqd ktheads are boosted to real-time
priority 2 in order to allow timeouts to work properly in the face of
rcutorture's testing of RCU priority boosting.

Indeed, it is not as easy as it looks to create a reliable test of RCU
priority boosting without destroying the rest of the kernel!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 111 ++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index bf488f957948..06d08f4f3e52 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -245,12 +245,6 @@ static const char *rcu_torture_writer_state_getname(void)
 	return rcu_torture_writer_state_names[i];
 }
 
-#if defined(CONFIG_RCU_BOOST) && defined(CONFIG_PREEMPT_RT)
-# define rcu_can_boost() 1
-#else
-# define rcu_can_boost() 0
-#endif
-
 #ifdef CONFIG_RCU_TRACE
 static u64 notrace rcu_trace_clock_local(void)
 {
@@ -511,7 +505,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.gp_kthread_dbg	= show_rcu_gp_kthreads,
 	.stall_dur	= rcu_jiffies_till_stall_check,
 	.irq_capable	= 1,
-	.can_boost	= rcu_can_boost(),
+	.can_boost	= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables	= RCUTORTURE_MAX_EXTEND,
 	.name		= "rcu"
 };
@@ -891,25 +885,11 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 
 /*
  * RCU torture priority-boost testing.  Runs one real-time thread per
- * CPU for moderate bursts, repeatedly registering RCU callbacks and
- * spinning waiting for them to be invoked.  If a given callback takes
- * too long to be invoked, we assume that priority inversion has occurred.
+ * CPU for moderate bursts, repeatedly starting grace periods and waiting
+ * for them to complete.  If a given grace period takes too long, we assume
+ * that priority inversion has occurred.
  */
 
-struct rcu_boost_inflight {
-	struct rcu_head rcu;
-	int inflight;
-};
-
-static void rcu_torture_boost_cb(struct rcu_head *head)
-{
-	struct rcu_boost_inflight *rbip =
-		container_of(head, struct rcu_boost_inflight, rcu);
-
-	/* Ensure RCU-core accesses precede clearing ->inflight */
-	smp_store_release(&rbip->inflight, 0);
-}
-
 static int old_rt_runtime = -1;
 
 static void rcu_torture_disable_rt_throttle(void)
@@ -936,15 +916,18 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
-static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
+static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
 {
 	static int dbg_done;
 
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
-		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg)
+		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
+			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
+				current->rt_priority, gp_state, end - start);
 			cur_ops->gp_kthread_dbg();
+		}
 
 		return true; /* failed */
 	}
@@ -954,21 +937,20 @@ static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
 
 static int rcu_torture_boost(void *arg)
 {
-	unsigned long call_rcu_time;
 	unsigned long endtime;
+	unsigned long gp_state;
+	unsigned long gp_state_time;
 	unsigned long oldstarttime;
-	struct rcu_boost_inflight rbi = { .inflight = 0 };
 
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
 	sched_set_fifo_low(current);
 
-	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
 		bool failed = false; // Test failed already in this test interval
-		bool firsttime = true;
+		bool gp_initiated = false;
 
 		/* Increment n_rcu_torture_boosts once per boost-test */
 		while (!kthread_should_stop()) {
@@ -992,33 +974,33 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
-		/* Do one boost-test interval. */
+		// Do one boost-test interval.
 		endtime = oldstarttime + test_boost_duration * HZ;
 		while (time_before(jiffies, endtime)) {
-			/* If we don't have a callback in flight, post one. */
-			if (!smp_load_acquire(&rbi.inflight)) {
-				/* RCU core before ->inflight = 1. */
-				smp_store_release(&rbi.inflight, 1);
-				cur_ops->call(&rbi.rcu, rcu_torture_boost_cb);
-				/* Check if the boost test failed */
-				if (!firsttime && !failed)
-					failed = rcu_torture_boost_failed(call_rcu_time, jiffies);
-				call_rcu_time = jiffies;
-				firsttime = false;
+			// Has current GP gone too long?
+			if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
+				failed = rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
+			// If we don't have a grace period in flight, start one.
+			if (!gp_initiated || cur_ops->poll_gp_state(gp_state)) {
+				gp_state = cur_ops->start_gp_poll();
+				gp_initiated = true;
+				gp_state_time = jiffies;
 			}
-			if (stutter_wait("rcu_torture_boost"))
+			if (stutter_wait("rcu_torture_boost")) {
 				sched_set_fifo_low(current);
+				// If the grace period already ended,
+				// we don't know when that happened, so
+				// start over.
+				if (cur_ops->poll_gp_state(gp_state))
+					gp_initiated = false;
+			}
 			if (torture_must_stop())
 				goto checkwait;
 		}
 
-		/*
-		 * If boost never happened, then inflight will always be 1, in
-		 * this case the boost check would never happen in the above
-		 * loop so do another one here.
-		 */
-		if (!firsttime && !failed && smp_load_acquire(&rbi.inflight))
-			rcu_torture_boost_failed(call_rcu_time, jiffies);
+		// In case the grace period extended beyond the end of the loop.
+		if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
+			rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
 
 		/*
 		 * Set the start time of the next test interval.
@@ -1027,11 +1009,9 @@ static int rcu_torture_boost(void *arg)
 		 * interval.  Besides, we are running at RT priority,
 		 * so delays should be relatively rare.
 		 */
-		while (oldstarttime == boost_starttime &&
-		       !kthread_should_stop()) {
+		while (oldstarttime == boost_starttime && !kthread_should_stop()) {
 			if (mutex_trylock(&boost_mutex)) {
-				boost_starttime = jiffies +
-						  test_boost_interval * HZ;
+				boost_starttime = jiffies + test_boost_interval * HZ;
 				mutex_unlock(&boost_mutex);
 				break;
 			}
@@ -1043,15 +1023,11 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
-	while (smp_load_acquire(&rbi.inflight))
-		schedule_timeout_uninterruptible(1); // rcu_barrier() deadlocks.
-
 	/* Clean up and exit. */
-	while (!kthread_should_stop() || smp_load_acquire(&rbi.inflight)) {
+	while (!kthread_should_stop()) {
 		torture_shutdown_absorb("rcu_torture_boost");
 		schedule_timeout_uninterruptible(1);
 	}
-	destroy_rcu_head_on_stack(&rbi.rcu);
 	torture_kthread_stopping("rcu_torture_boost");
 	return 0;
 }
@@ -2643,7 +2619,7 @@ static bool rcu_torture_can_boost(void)
 
 	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
 		return false;
-	if (!cur_ops->call)
+	if (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)
 		return false;
 
 	prio = rcu_get_gp_kthreads_prio();
@@ -2651,7 +2627,7 @@ static bool rcu_torture_can_boost(void)
 		return false;
 
 	if (prio < 2) {
-		if (boost_warn_once  == 1)
+		if (boost_warn_once == 1)
 			return false;
 
 		pr_alert("%s: WARN: RCU kthread priority too low to test boosting.  Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 on the kernel command line.\n", KBUILD_MODNAME);
@@ -3129,6 +3105,21 @@ rcu_torture_init(void)
 		if (firsterr < 0)
 			goto unwind;
 		rcutor_hp = firsterr;
+
+		// Testing RCU priority boosting requires rcutorture do
+		// some serious abuse.  Counter this by running ksoftirqd
+		// at higher priority.
+		if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)) {
+			for_each_online_cpu(cpu) {
+				struct sched_param sp;
+				struct task_struct *t;
+
+				t = per_cpu(ksoftirqd, cpu);
+				WARN_ON_ONCE(!t);
+				sp.sched_priority = 2;
+				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+			}
+		}
 	}
 	shutdown_jiffies = jiffies + shutdown_secs * HZ;
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
-- 
2.31.1.189.g2e36527f23

