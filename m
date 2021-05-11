Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A735BC2B9F2
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A9661931
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhEKXNq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B65C6195F;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=ZISU9GnMcTdlqU0QtK98c9RS17RDKlC8gFyxQoC9LHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFlDOBC73ih0iNtxjUaIPkjVQ8sQQcrCUHKvAmYBRzgSGZWb2E78Hg1IxRNT2K3d1
         hRiuzntQX/1XEspLdnCVDdlyXE54DglXXK8LQj/yurJPxp8GKQy0RD2f0gAdUPnxbF
         8SyiN/716NsISqWvY88ntPZcvW2d39IojE2uI3uCYdl0Vzr31J+9duDB3D7zWb3llO
         0CSS1eXQnh3/+g0ITIm9Ywqnc31wNSGopLdBAHKeToiMvcDNBS8W+dpUb8dpKnP2GP
         fxOxC+GzXrG8D4kNJ7FZjG3fqeC/bNI2NMtVD5hMwYCf7Uj2vhBxvk9zm7JBzlKqft
         lVRKfbFRuUaqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 91B4F5C0E5F; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/26] rcutorture: Don't count CPU-stalled time against priority boosting
Date:   Tue, 11 May 2021 16:12:19 -0700
Message-Id: <20210511231223.2895398-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It will frequently be the case that rcu_torture_boost() will get a
->start_gp_poll() cookie that needs almost all of the current grace period
plus an additional grace period to elapse before ->poll_gp_state() will
return true.  It is quite possible that the current grace period will have
(say) two seconds of stall by a CPU failing to pass through a quiescent
state, followed by 300 milliseconds of delay due to a preempted reader.
The next grace period might suffer only one second of stall by a CPU,
followed by another 300 milliseconds of delay due to a preempted reader.
This is an example of RCU priority boosting doing its job, but the full
elapsed time of 3.6 seconds exceeds the 3.5-second limit.  In addition,
there is no CPU stall in force at the 3.5-second mark, so this would
nevertheless currently be counted as an RCU priority boosting failure.

This commit therefore avoids this sort of false positive by resetting
the gp_state_time timestamp any time that the current grace period is
being blocked by a CPU.  This results in extremely frequent calls to
the ->check_boost_failed() function, so this commit provides a lockless
fastpath that is selected by supplying a NULL CPU-number pointer.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 ++++++++-----
 kernel/rcu/tree_stall.h | 10 ++++++++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5ae4dcc6ba27..8b347b9659aa 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -918,17 +918,18 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
-static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start, unsigned long end)
+static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
 {
 	int cpu;
 	static int dbg_done;
+	unsigned long end = jiffies;
 	bool gp_done;
 	unsigned long j;
 	static unsigned long last_persist;
 	unsigned long lp;
 	unsigned long mininterval = test_boost_duration * HZ - HZ / 2;
 
-	if (end - start > mininterval) {
+	if (end - *start > mininterval) {
 		// Recheck after checking time to avoid false positives.
 		smp_mb(); // Time check before grace-period check.
 		if (cur_ops->poll_gp_state(gp_state))
@@ -945,7 +946,7 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 		n_rcu_torture_boost_failure++;
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
 			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
-				current->rt_priority, gp_state, end - start);
+				current->rt_priority, gp_state, end - *start);
 			cur_ops->gp_kthread_dbg();
 			// Recheck after print to flag grace period ending during splat.
 			gp_done = cur_ops->poll_gp_state(gp_state);
@@ -955,6 +956,8 @@ static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long start
 		}
 
 		return true; // failed
+	} else if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, NULL)) {
+		*start = jiffies;
 	}
 
 	return false; // passed
@@ -995,7 +998,7 @@ static int rcu_torture_boost(void *arg)
 		while (time_before(jiffies, endtime)) {
 			// Has current GP gone too long?
 			if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-				failed = rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
+				failed = rcu_torture_boost_failed(gp_state, &gp_state_time);
 			// If we don't have a grace period in flight, start one.
 			if (!gp_initiated || cur_ops->poll_gp_state(gp_state)) {
 				gp_state = cur_ops->start_gp_poll();
@@ -1016,7 +1019,7 @@ static int rcu_torture_boost(void *arg)
 
 		// In case the grace period extended beyond the end of the loop.
 		if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-			rcu_torture_boost_failed(gp_state, gp_state_time, jiffies);
+			rcu_torture_boost_failed(gp_state, &gp_state_time);
 
 		/*
 		 * Set the start time of the next test interval.
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index af92d9fee0d4..8bde1b53b0c9 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -723,6 +723,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
  * count this as an RCU priority boosting failure.  A return of true says
  * RCU priority boosting is to blame, and false says otherwise.  If false
  * is returned, the first of the CPUs to blame is stored through cpup.
+ *
+ * If cpup is NULL, then a lockless quick check is carried out, suitable
+ * for high-rate usage.  On the other hand, if cpup is non-NULL, each
+ * rcu_node structure's ->lock is acquired, ruling out high-rate usage.
  */
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 {
@@ -731,6 +735,12 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
+		if (!cpup) {
+			if (READ_ONCE(rnp->qsmask))
+				return false;
+			else
+				continue;
+		}
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (!rnp->qsmask) {
 			// No CPUs without quiescent states for this rnp.
-- 
2.31.1.189.g2e36527f23

