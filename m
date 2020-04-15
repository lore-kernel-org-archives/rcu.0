Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA00AC3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85D12076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972004;
	bh=PtPeyyrjGI0Spnjq6FpZex+gD9Q2RIckssLhCuXcW4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lOhyXLhDH8XHD5R6ls/UVrAPLlQ1t+UcznK0hn9iZam6Ufw7WuT6b/z0tFQRK0sGh
	 pkyaygIsnBgNsjbvWFwUzk2+13u5eCN2pWzgsWS+Q9e5d43moO4NVQ67+dtaNTXC2Y
	 fqTRQKmdOKJfmIrLgz8mUCbFS9ZGNnyMR4EBLH6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411305AbgDORdP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411123AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4590C208E4;
        Wed, 15 Apr 2020 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971864;
        bh=PtPeyyrjGI0Spnjq6FpZex+gD9Q2RIckssLhCuXcW4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vT817X3TzcpI0T+VqOO20tu/0aFoxEbUSdKW2vf0hzvkvyh48OTO7oUpmq7BK1Joz
         sFsjgykqSv/BkIHaR/DTdvvXwjfp9IsRxYQ9C6rbeisffD//rZwMDHBNmZv6MT8IjC
         wrED5n7D2hEF2l/vwcMENEbZBo6TEzQ+Akn5cbjc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/18] rcu: Allow rcutorture to starve grace-period kthread
Date:   Wed, 15 Apr 2020 10:30:50 -0700
Message-Id: <20200415173100.9927-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit provides an rcutorture.stall_gp_kthread module parameter
to allow rcutorture to starve the grace-period kthread.  This allows
testing the code that detects such starvation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/rcu/rcu.h                                |  2 ++
 kernel/rcu/rcutorture.c                         | 18 ++++++++++++++---
 kernel/rcu/tree.c                               | 27 +++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ad12b39..be94358a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4221,6 +4221,13 @@
 	rcutorture.stall_cpu_irqsoff= [KNL]
 			Disable interrupts while stalling if set.
 
+	rcutorture.stall_gp_kthread= [KNL]
+			Duration (s) of forced sleep within RCU
+			grace-period kthread to test RCU CPU stall
+			warnings, zero to disable.  If both stall_cpu
+			and stall_gp_kthread are specified, the
+			kthread is starved first, then the CPU.
+
 	rcutorture.stat_interval= [KNL]
 			Time (s) between statistics printk()s.
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 00ddc92..cdbc5f9 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -454,6 +454,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long secs,
 			       unsigned long c_old,
 			       unsigned long c);
+void rcu_gp_set_torture_wait(int duration);
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
@@ -471,6 +472,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 #define do_trace_rcu_torture_read(rcutorturename, rhp, secs, c_old, c) \
 	do { } while (0)
 #endif
+static inline void rcu_gp_set_torture_wait(int duration) { }
 #endif
 
 #if IS_ENABLED(CONFIG_RCU_TORTURE_TEST) || IS_MODULE(CONFIG_RCU_TORTURE_TEST)
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 60dc368..3d47dca 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -115,6 +115,8 @@ torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
+torture_param(int, stall_gp_kthread, 0,
+	      "Grace-period kthread stall duration (s).");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
@@ -1623,7 +1625,17 @@ static int rcu_torture_stall(void *args)
 		schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
 		VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
 	}
-	if (!kthread_should_stop()) {
+	if (!kthread_should_stop() && stall_gp_kthread > 0) {
+		VERBOSE_TOROUT_STRING("rcu_torture_stall begin GP stall");
+		rcu_gp_set_torture_wait(stall_gp_kthread * HZ);
+		for (idx = 0; idx < stall_gp_kthread + 2; idx++) {
+			if (kthread_should_stop())
+				break;
+			schedule_timeout_uninterruptible(HZ);
+		}
+	}
+	if (!kthread_should_stop() && stall_cpu > 0) {
+		VERBOSE_TOROUT_STRING("rcu_torture_stall begin CPU stall");
 		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
 		idx = cur_ops->readlock();
@@ -1642,8 +1654,8 @@ static int rcu_torture_stall(void *args)
 		else if (!stall_cpu_block)
 			preempt_enable();
 		cur_ops->readunlock(idx);
-		pr_alert("rcu_torture_stall end.\n");
 	}
+	pr_alert("rcu_torture_stall end.\n");
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
 		schedule_timeout_interruptible(10 * HZ);
@@ -1653,7 +1665,7 @@ static int rcu_torture_stall(void *args)
 /* Spawn CPU-stall kthread, if stall_cpu specified. */
 static int __init rcu_torture_stall_init(void)
 {
-	if (stall_cpu <= 0)
+	if (stall_cpu <= 0 && stall_gp_kthread <= 0)
 		return 0;
 	return torture_create_kthread(rcu_torture_stall, NULL, stall_task);
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f13130a..c5e0e66 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1486,6 +1486,31 @@ static void rcu_gp_slow(int delay)
 		schedule_timeout_uninterruptible(delay);
 }
 
+static unsigned long sleep_duration;
+
+/* Allow rcutorture to stall the grace-period kthread. */
+void rcu_gp_set_torture_wait(int duration)
+{
+	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST) && duration > 0)
+		WRITE_ONCE(sleep_duration, duration);
+}
+EXPORT_SYMBOL_GPL(rcu_gp_set_torture_wait);
+
+/* Actually implement the aforementioned wait. */
+static void rcu_gp_torture_wait(void)
+{
+	unsigned long duration;
+
+	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST))
+		return;
+	duration = xchg(&sleep_duration, 0UL);
+	if (duration > 0) {
+		pr_alert("%s: Waiting %lu jiffies\n", __func__, duration);
+		schedule_timeout_uninterruptible(duration);
+		pr_alert("%s: Wait complete\n", __func__);
+	}
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1686,6 +1711,7 @@ static void rcu_gp_fqs_loop(void)
 		rcu_state.gp_state = RCU_GP_WAIT_FQS;
 		ret = swait_event_idle_timeout_exclusive(
 				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
+		rcu_gp_torture_wait();
 		rcu_state.gp_state = RCU_GP_DOING_FQS;
 		/* Locking provides needed memory barriers. */
 		/* If grace period done, leave loop. */
@@ -1834,6 +1860,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 			swait_event_idle_exclusive(rcu_state.gp_wq,
 					 READ_ONCE(rcu_state.gp_flags) &
 					 RCU_GP_FLAG_INIT);
+			rcu_gp_torture_wait();
 			rcu_state.gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init())
-- 
2.9.5

