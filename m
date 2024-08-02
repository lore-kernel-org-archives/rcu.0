Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F226AC2;
	Fri,  2 Aug 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559073; cv=none; b=qEALoHYVf2xVZ8NC7hOKffAPMJLDTWpLQhqmuciViWRgcRu5cZFUAgOEhv3iHvmsBwnV5IMEkQGGV4ZEIGceGW0YSySoHVpYp9UlrhVBP25eHtimek49tTCL7KjBEDBINNjqyrDF7OThl6YUPn8qKCb+BhjjZmbD0bLnKfTPMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559073; c=relaxed/simple;
	bh=rG1LYuhBJekOp6wqHDJn7PtOPxnpbi4tnOcI0lklMZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JN8/8S81nwnntVxZuEcQx5ghBsb2nxZl7t58hVmDQaXnfe1ec9vYNg2gcSSRtHLsxOFEqcWmKTvaoHwsrQBvxkqx0amlEnhU3OjeGW25zI9bflFfOXzu/X+UY0O7VkAJPDLeJ6SPz9nDJ3TA6u8GCyp2GEkRIoC1UJTKuK1FGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bePHb2Tc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bePHb2Tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BE4C32786;
	Fri,  2 Aug 2024 00:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559072;
	bh=rG1LYuhBJekOp6wqHDJn7PtOPxnpbi4tnOcI0lklMZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bePHb2Tc9TIE3FOnqgMyNXpOV3/HEnXWahJexwER97fWsxgCKSXVheYQeN9BlgsPx
	 LzQZsaqipxMJl9T+iW1X+uvmR8ibpuAIt6dg/KdBe9Basq+gEKhwxzgPEUql6wXqYc
	 jMif/a+OsxC1Ja+/rLy9S+2cow8fcYDxkRKBtz0LxaY1ys926cqfhmSC0AcOY4FftU
	 ax3UII4FtI9q6cQCX+tytSMw/YpvJ03zP60OT3dXWfPpcF4zUlzZ05owTMKawjRFj2
	 gPtD04/gMlstlI5DVWp3OpZVMIQn+QPoXI8O8Oj52hhDGRAT/2S/IZW4hjUuxOk2sZ
	 laAvzcaAwFfvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 690D9CE0A01; Thu,  1 Aug 2024 17:37:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH rcu 2/3] rcutorture: Add a stall_cpu_repeat module parameter
Date: Thu,  1 Aug 2024 17:37:49 -0700
Message-Id: <20240802003750.4134451-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
References: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an stall_cpu_repeat kernel, which is also the
rcutorture.stall_cpu_repeat boot parameter, to test repeated CPU stalls.
Note that only the first stall will pay attention to the stall_cpu_irqsoff
module parameter.  For the second and subsequent stalls, interrupts will
be enabled.  This is helpful when testing the interaction between RCU
CPU stall warnings and CSD-lock stall warnings.

Reported-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++-
 kernel/rcu/rcutorture.c                       | 56 +++++++++++++------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 35dd1e69b14d0..d30b81e693f9c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5388,7 +5388,13 @@
 			Time to wait (s) after boot before inducing stall.
 
 	rcutorture.stall_cpu_irqsoff= [KNL]
-			Disable interrupts while stalling if set.
+			Disable interrupts while stalling if set, but only
+			on the first stall in the set.
+
+	rcutorture.stall_cpu_repeat= [KNL]
+			Number of times to repeat the stall sequence,
+			so that rcutorture.stall_cpu_repeat=3 will result
+			in four stall sequences.
 
 	rcutorture.stall_gp_kthread= [KNL]
 			Duration (s) of forced sleep within RCU
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3dc7ef4af0eca..9dd6764e25f3d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -115,6 +115,7 @@ torture_param(int, stall_cpu_holdoff, 10, "Time to wait before starting stall (s
 torture_param(bool, stall_no_softlockup, false, "Avoid softlockup warning during cpu stall.");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
+torture_param(int, stall_cpu_repeat, 0, "Number of additional stalls after the first one.");
 torture_param(int, stall_gp_kthread, 0, "Grace-period kthread stall duration (s).");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
@@ -1385,7 +1386,8 @@ rcu_torture_writer(void *arg)
 
 	// If a new stall test is added, this must be adjusted.
 	if (stall_cpu_holdoff + stall_gp_kthread + stall_cpu)
-		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) * HZ;
+		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
+			      HZ * (stall_cpu_repeat + 1);
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
@@ -2383,7 +2385,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "test_boost=%d/%d test_boost_interval=%d "
 		 "test_boost_duration=%d shutdown_secs=%d "
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
-		 "stall_cpu_block=%d "
+		 "stall_cpu_block=%d stall_cpu_repeat=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
@@ -2395,7 +2397,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 test_boost, cur_ops->can_boost,
 		 test_boost_interval, test_boost_duration, shutdown_secs,
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
-		 stall_cpu_block,
+		 stall_cpu_block, stall_cpu_repeat,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
@@ -2473,19 +2475,11 @@ static struct notifier_block rcu_torture_stall_block = {
  * induces a CPU stall for the time specified by stall_cpu.  If a new
  * stall test is added, stallsdone in rcu_torture_writer() must be adjusted.
  */
-static int rcu_torture_stall(void *args)
+static void rcu_torture_stall_one(int rep, int irqsoff)
 {
 	int idx;
-	int ret;
 	unsigned long stop_at;
 
-	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
-	if (rcu_cpu_stall_notifiers) {
-		ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
-		if (ret)
-			pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
-				__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
-	}
 	if (stall_cpu_holdoff > 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_stall begin holdoff");
 		schedule_timeout_interruptible(stall_cpu_holdoff * HZ);
@@ -2505,12 +2499,12 @@ static int rcu_torture_stall(void *args)
 		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
 		idx = cur_ops->readlock();
-		if (stall_cpu_irqsoff)
+		if (irqsoff)
 			local_irq_disable();
 		else if (!stall_cpu_block)
 			preempt_disable();
-		pr_alert("%s start on CPU %d.\n",
-			  __func__, raw_smp_processor_id());
+		pr_alert("%s start stall episode %d on CPU %d.\n",
+			  __func__, rep + 1, raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(), stop_at) &&
 		       !kthread_should_stop())
 			if (stall_cpu_block) {
@@ -2522,12 +2516,42 @@ static int rcu_torture_stall(void *args)
 			} else if (stall_no_softlockup) {
 				touch_softlockup_watchdog();
 			}
-		if (stall_cpu_irqsoff)
+		if (irqsoff)
 			local_irq_enable();
 		else if (!stall_cpu_block)
 			preempt_enable();
 		cur_ops->readunlock(idx);
 	}
+}
+
+/*
+ * CPU-stall kthread.  Invokes rcu_torture_stall() once, and then as many
+ * additional times as specified by the stall_cpu_repeat module parameter.
+ * Note that stall_cpu_irqsoff is ignored on the second and subsequent
+ * stall.
+ */
+static int rcu_torture_stall(void *args)
+{
+	int i;
+	int repeat = stall_cpu_repeat;
+	int ret;
+
+	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
+	if (repeat < 0) {
+		repeat = 0;
+		WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
+	}
+	if (rcu_cpu_stall_notifiers) {
+		ret = rcu_stall_chain_notifier_register(&rcu_torture_stall_block);
+		if (ret)
+			pr_info("%s: rcu_stall_chain_notifier_register() returned %d, %sexpected.\n",
+				__func__, ret, !IS_ENABLED(CONFIG_RCU_STALL_COMMON) ? "un" : "");
+	}
+	for (i = 0; i <= repeat; i++) {
+		if (kthread_should_stop())
+			break;
+		rcu_torture_stall_one(i, i == 0 ? stall_cpu_irqsoff : 0);
+	}
 	pr_alert("%s end.\n", __func__);
 	if (rcu_cpu_stall_notifiers && !ret) {
 		ret = rcu_stall_chain_notifier_unregister(&rcu_torture_stall_block);
-- 
2.40.1

