Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D3C433E6
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EDD2313F
	for <rcu@archiver.kernel.org>; Wed, 20 Jan 2021 04:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbhATEd2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbhATEdU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Jan 2021 23:33:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40F6B23330;
        Wed, 20 Jan 2021 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611117159;
        bh=Ja9jpSEMWVE5yNp+pIWbf7b46ICRtIrvQScqhMlb/F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ow/IbNxBJTM3raHnRdSla6iaCQxV8enTlavRM/nvmA5yZO1XCx6qmK+o9yCPXCdjF
         N0UleZHJS1sVg8Y+8BY9XWerI6JDwt8002AgIo9EbBD1GyWgqyXvw757cWO+2x5bC5
         bBGESu6CGm0o/ICZ1TiDHf8sfUrleN5a4E3Z+0NMK2lNInEMHCl9fQnmDyWghLL53k
         21Pp6DWl1TLgAqYU3c9kJz8vT0Xib/IfD4Quy6zgZ17H+EvJ3rMFZL1mr+RcGXlug9
         /vxicVhmSQwvLeM17AzZjxb3z5jpnif8PTa4ZedRf42KW8boP1bjDqToyNMbUcMLGU
         mG9UxdKoN9pCA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH tip/core/rcu 4/4] rcutorture: Fix testing of RCU priority boosting
Date:   Tue, 19 Jan 2021 20:32:36 -0800
Message-Id: <20210120043236.7254-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210120043144.GA7045@paulmck-ThinkPad-P72>
References: <20210120043144.GA7045@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, rcutorture refuses to test RCU priority boosting in
CONFIG_HOTPLUG_CPU=y kernels, which are the only kind normally built on
x86 these days.  This commit therefore updates rcutorture's tests of RCU
priority boosting to make them safe for CPU hotplug.  However, these tests
will fail unless TIMER_SOFTIRQ runs at realtime priority, which does not
happen in current mainline.  This commit therefore also refuses to test
RCU priority boosting except in kernels built with CONFIG_PREEMPT_RT=y.

While in the area, this commt adds some debug output at boost-fail time
that helps diagnose the cause of the failure, for example, failing to
run TIMER_SOFTIRQ at realtime priority.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8e93f2e..2440f89 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -245,11 +245,11 @@ static const char *rcu_torture_writer_state_getname(void)
 	return rcu_torture_writer_state_names[i];
 }
 
-#if defined(CONFIG_RCU_BOOST) && !defined(CONFIG_HOTPLUG_CPU)
-#define rcu_can_boost() 1
-#else /* #if defined(CONFIG_RCU_BOOST) && !defined(CONFIG_HOTPLUG_CPU) */
-#define rcu_can_boost() 0
-#endif /* #else #if defined(CONFIG_RCU_BOOST) && !defined(CONFIG_HOTPLUG_CPU) */
+#if defined(CONFIG_RCU_BOOST) && defined(CONFIG_PREEMPT_RT)
+# define rcu_can_boost() 1
+#else
+# define rcu_can_boost() 0
+#endif
 
 #ifdef CONFIG_RCU_TRACE
 static u64 notrace rcu_trace_clock_local(void)
@@ -923,9 +923,13 @@ static void rcu_torture_enable_rt_throttle(void)
 
 static bool rcu_torture_boost_failed(unsigned long start, unsigned long end)
 {
+	static int dbg_done;
+
 	if (end - start > test_boost_duration * HZ - HZ / 2) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
+		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg)
+			cur_ops->gp_kthread_dbg();
 
 		return true; /* failed */
 	}
@@ -948,8 +952,8 @@ static int rcu_torture_boost(void *arg)
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
-		/* Track if the test failed already in this test interval? */
-		bool failed = false;
+		bool failed = false; // Test failed already in this test interval
+		bool firsttime = true;
 
 		/* Increment n_rcu_torture_boosts once per boost-test */
 		while (!kthread_should_stop()) {
@@ -975,18 +979,17 @@ static int rcu_torture_boost(void *arg)
 
 		/* Do one boost-test interval. */
 		endtime = oldstarttime + test_boost_duration * HZ;
-		call_rcu_time = jiffies;
 		while (time_before(jiffies, endtime)) {
 			/* If we don't have a callback in flight, post one. */
 			if (!smp_load_acquire(&rbi.inflight)) {
 				/* RCU core before ->inflight = 1. */
 				smp_store_release(&rbi.inflight, 1);
-				call_rcu(&rbi.rcu, rcu_torture_boost_cb);
+				cur_ops->call(&rbi.rcu, rcu_torture_boost_cb);
 				/* Check if the boost test failed */
-				failed = failed ||
-					 rcu_torture_boost_failed(call_rcu_time,
-								 jiffies);
+				if (!firsttime && !failed)
+					failed = rcu_torture_boost_failed(call_rcu_time, jiffies);
 				call_rcu_time = jiffies;
+				firsttime = false;
 			}
 			if (stutter_wait("rcu_torture_boost"))
 				sched_set_fifo_low(current);
@@ -999,7 +1002,7 @@ static int rcu_torture_boost(void *arg)
 		 * this case the boost check would never happen in the above
 		 * loop so do another one here.
 		 */
-		if (!failed && smp_load_acquire(&rbi.inflight))
+		if (!firsttime && !failed && smp_load_acquire(&rbi.inflight))
 			rcu_torture_boost_failed(call_rcu_time, jiffies);
 
 		/*
@@ -1025,6 +1028,9 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
+	while (smp_load_acquire(&rbi.inflight))
+		schedule_timeout_uninterruptible(1); // rcu_barrier() deadlocks.
+
 	/* Clean up and exit. */
 	while (!kthread_should_stop() || smp_load_acquire(&rbi.inflight)) {
 		torture_shutdown_absorb("rcu_torture_boost");
@@ -1797,7 +1803,7 @@ rcu_torture_stats_print(void)
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
 		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
-		WARN_ON_ONCE(n_rcu_torture_boost_failure); // RCU boost failed
+		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
 		WARN_ON_ONCE(i > 1); // Too-short grace period
 	}
 	pr_cont("Reader Pipe: ");
@@ -2634,6 +2640,8 @@ static bool rcu_torture_can_boost(void)
 
 	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
 		return false;
+	if (!cur_ops->call)
+		return false;
 
 	prio = rcu_get_gp_kthreads_prio();
 	if (!prio)
-- 
2.9.5

