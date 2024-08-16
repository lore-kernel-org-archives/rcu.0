Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12D84D0F;
	Fri, 16 Aug 2024 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787632; cv=none; b=Ds650poeKkuRo2IYLX8h9ms6pW0bxqRM9xQylVEhxXmd46Yh8M+E/Mh7mXS7EjYkw3qha7tpwhDIfq+015umC771LbTDJpYFnwD+Aw/4CbXkIklAP26uAoeU78gAWfpR2RF5uCuYGtEs2GBoSVsRBVeJqpya9+h48Mt6NVAg5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787632; c=relaxed/simple;
	bh=/V6Zp3Pbe4Lw9dRmBFWtCuRjxqPkV0EQUS4Nu1xjMJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nvl4iaDvvqofi6Lt5xQqLx97BEbmSVEB5FMIRYnk7PvgmqaxHS7Kq5ZsXZDLVepiUgwJdFBxN05/rFbXWhJCJnQHQ4aokA+gkmN25Q5pDpgVUQIljyl/JU0FpJjWLPYyHwndVntBxNzm8cNS7R4NCNED1V9f71E5jMQpN4wWYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZw7L+FI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZw7L+FI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F011C4AF10;
	Fri, 16 Aug 2024 05:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787632;
	bh=/V6Zp3Pbe4Lw9dRmBFWtCuRjxqPkV0EQUS4Nu1xjMJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZw7L+FIXLb/bBCc8JMs2B/LyOP4PfFOtBKmFlofZg4107XF0h6DXNJOjIZVRH0s5
	 HfpOUpWVWFD56Y+4KWcccJEKR9z+xEZG9YYvYjIJ/RvbJN+m2A+a47bVAR08PSjsYa
	 BNos2HksIner4ULRj+mEqKWhhlsqduH4aaL3OCG3Vb+49teTti/ECK4mUT6g1fYYF2
	 x/IsoOkGLlhN8spiBcW4sI3A74zKBdEUBSX0SKXr98sY2l6yDnLIdBZC8e8XwGs4fq
	 oM3N2FCYLxp6i4DNNCa3KEGMI2xsG/Cxd6rzqck1gEqKhMt5MEXxOwyaeh8qLlhZLK
	 4wjbvtbF7JvwQ==
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
	frederic@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH rcu 7/8] rcutorture: Add a stall_cpu_repeat module parameter
Date: Fri, 16 Aug 2024 11:22:02 +0530
Message-Id: <20240816055203.43784-8-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds an stall_cpu_repeat kernel, which is also the
rcutorture.stall_cpu_repeat boot parameter, to test repeated CPU stalls.
Note that only the first stall will pay attention to the stall_cpu_irqsoff
module parameter.  For the second and subsequent stalls, interrupts will
be enabled.  This is helpful when testing the interaction between RCU
CPU stall warnings and CSD-lock stall warnings.

Reported-by: Rik van Riel <riel@surriel.com>
Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++-
 kernel/rcu/rcutorture.c                       | 56 +++++++++++++------
 2 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..db1be767c91a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5384,7 +5384,13 @@
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
index 9a2ecb8b88ec..4fd23cae0e9e 100644
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
@@ -1393,7 +1394,8 @@ rcu_torture_writer(void *arg)
 
 	// If a new stall test is added, this must be adjusted.
 	if (stall_cpu_holdoff + stall_gp_kthread + stall_cpu)
-		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) * HZ;
+		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) *
+			      HZ * (stall_cpu_repeat + 1);
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
@@ -2391,7 +2393,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "test_boost=%d/%d test_boost_interval=%d "
 		 "test_boost_duration=%d shutdown_secs=%d "
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
-		 "stall_cpu_block=%d "
+		 "stall_cpu_block=%d stall_cpu_repeat=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "read_exit_delay=%d read_exit_burst=%d "
@@ -2403,7 +2405,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 test_boost, cur_ops->can_boost,
 		 test_boost_interval, test_boost_duration, shutdown_secs,
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
-		 stall_cpu_block,
+		 stall_cpu_block, stall_cpu_repeat,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
 		 read_exit_delay, read_exit_burst,
@@ -2481,19 +2483,11 @@ static struct notifier_block rcu_torture_stall_block = {
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
@@ -2513,12 +2507,12 @@ static int rcu_torture_stall(void *args)
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
@@ -2530,12 +2524,42 @@ static int rcu_torture_stall(void *args)
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
+ * CPU-stall kthread.  Invokes rcu_torture_stall_one() once, and then as many
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

