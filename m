Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185038289E;
	Fri, 16 Aug 2024 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791059; cv=none; b=XMVuOiUPm5Q5GTE5SjfX0AuVDgMmkYy23kIRFwsexy+YXgVpAS8IRYxWE3JDtvyUE2dgPlw+rjxAlygBBGPzv15mUsLBMkQjd5aXNE1r8JXdpldB3Hckxr57PUX0tUXFmfmbA/03pKqDqsA4oa3JjvgwXANUL0n3Ez1TFpQkQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791059; c=relaxed/simple;
	bh=xAwbzpZYpYKzUiAmmYCU4rpEXtgjT8ZJynKD/3ssZUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EILgde0v2b5NVyqcPFAztLjkF/eet8MmB2PPG78oyrvUPZMA6AgHbifJKFfeVP69qPYOitxjj+CKesnO9C4z3Lg7DeYGcYDPwLIr3jj5L62p7PdX1Ooj00Bl8gKRShWqwtrxNsu550RbHnSr1XSS+Eg4ewQbDuAT37+GoCu33co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBhcCB1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBhcCB1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193CDC4AF0E;
	Fri, 16 Aug 2024 06:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791059;
	bh=xAwbzpZYpYKzUiAmmYCU4rpEXtgjT8ZJynKD/3ssZUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fBhcCB1DFVgb5yH8k6D/q3EkEbZXj8iFGp7pkb1NeL/Q8+Z9XymHjGyu0HZZOkFDJ
	 V/a432xNrlacJ66dp9VeHOgqvLTd/J/Nksz/+UhRsx+3D8on6JUlcs7Vd4nYlP0EMp
	 EwkkhVHwR+8PaJW/CbGGSc9enfgnY2+4gB9oeAcdnXC0AAXAsqfPbkCJHDT1eYtUiL
	 hxUr73/sX0Pxr2OfHalUIvzygzirFlYGOtXzFA5/ZHa1wrEin5rjwPwBIw2pb7gSxm
	 UPi8Yq5RUyQxlSsZyMsRS/GyMj95wJTL7KbkpaA+tJWZX9AHVCvqSwcnIp4xLOsOaT
	 lqRBGMK5ssJ/Q==
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
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH rcu 05/12] rcu-tasks: Remove RCU Tasks Rude asynchronous APIs
Date: Fri, 16 Aug 2024 12:19:14 +0530
Message-Id: <20240816064921.57645-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The call_rcu_tasks_rude() and rcu_barrier_tasks_rude() APIs are currently
unused.  This commit therefore removes their definitions and boot-time
self-tests.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/rcupdate.h |  2 --
 kernel/rcu/tasks.h       | 55 +++++++++++++---------------------------
 2 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 13f6f00aecf9..31e679c7110e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -37,7 +37,6 @@
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
-void rcu_barrier_tasks_rude(void);
 void synchronize_rcu(void);
 
 struct rcu_gp_oldstate;
@@ -202,7 +201,6 @@ do {									\
 } while (0)
 
 # ifdef CONFIG_TASKS_RUDE_RCU
-void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks_rude(void);
 # endif
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba3440a45b6d..4bc038bcc016 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -396,7 +396,7 @@ static void rcu_barrier_tasks_generic_cb(struct rcu_head *rhp)
 
 // Wait for all in-flight callbacks for the specified RCU Tasks flavor.
 // Operates in a manner similar to rcu_barrier().
-static void rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
+static void __maybe_unused rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 {
 	int cpu;
 	unsigned long flags;
@@ -1244,13 +1244,12 @@ void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 
 ////////////////////////////////////////////////////////////////////////
 //
-// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
-// passing an empty function to schedule_on_each_cpu().  This approach
-// provides an asynchronous call_rcu_tasks_rude() API and batching of
-// concurrent calls to the synchronous synchronize_rcu_tasks_rude() API.
-// This invokes schedule_on_each_cpu() in order to send IPIs far and wide
-// and induces otherwise unnecessary context switches on all online CPUs,
-// whether idle or not.
+// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's
+// trick of passing an empty function to schedule_on_each_cpu().
+// This approach provides batching of concurrent calls to the synchronous
+// synchronize_rcu_tasks_rude() API.  This invokes schedule_on_each_cpu()
+// in order to send IPIs far and wide and induces otherwise unnecessary
+// context switches on all online CPUs, whether idle or not.
 //
 // Callback handling is provided by the rcu_tasks_kthread() function.
 //
@@ -1268,11 +1267,11 @@ static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
 
-void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
+static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
 		 "RCU Tasks Rude");
 
-/**
+/*
  * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
  * @func: actual callback function to be invoked after the grace period
@@ -1289,12 +1288,14 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
+ *
+ * This is no longer exported, and is instead reserved for use by
+ * synchronize_rcu_tasks_rude().
  */
-void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
+static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
 {
 	call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
 }
-EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
 
 /**
  * synchronize_rcu_tasks_rude - wait for a rude rcu-tasks grace period
@@ -1320,26 +1321,9 @@ void synchronize_rcu_tasks_rude(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
 
-/**
- * rcu_barrier_tasks_rude - Wait for in-flight call_rcu_tasks_rude() callbacks.
- *
- * Although the current implementation is guaranteed to wait, it is not
- * obligated to, for example, if there are no pending callbacks.
- */
-void rcu_barrier_tasks_rude(void)
-{
-	rcu_barrier_tasks_generic(&rcu_tasks_rude);
-}
-EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
-
-int rcu_tasks_rude_lazy_ms = -1;
-module_param(rcu_tasks_rude_lazy_ms, int, 0444);
-
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
 	rcu_tasks_rude.gp_sleep = HZ / 10;
-	if (rcu_tasks_rude_lazy_ms >= 0)
-		rcu_tasks_rude.lazy_jiffies = msecs_to_jiffies(rcu_tasks_rude_lazy_ms);
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
 }
@@ -2069,11 +2053,6 @@ static struct rcu_tasks_test_desc tests[] = {
 		/* If not defined, the test is skipped. */
 		.notrun = IS_ENABLED(CONFIG_TASKS_RCU),
 	},
-	{
-		.name = "call_rcu_tasks_rude()",
-		/* If not defined, the test is skipped. */
-		.notrun = IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
-	},
 	{
 		.name = "call_rcu_tasks_trace()",
 		/* If not defined, the test is skipped. */
@@ -2081,6 +2060,7 @@ static struct rcu_tasks_test_desc tests[] = {
 	}
 };
 
+#if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
 static void test_rcu_tasks_callback(struct rcu_head *rhp)
 {
 	struct rcu_tasks_test_desc *rttd =
@@ -2090,6 +2070,7 @@ static void test_rcu_tasks_callback(struct rcu_head *rhp)
 
 	rttd->notrun = false;
 }
+#endif // #if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
 
 static void rcu_tasks_initiate_self_tests(void)
 {
@@ -2102,16 +2083,14 @@ static void rcu_tasks_initiate_self_tests(void)
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 	pr_info("Running RCU Tasks Rude wait API self tests\n");
-	tests[1].runstart = jiffies;
 	synchronize_rcu_tasks_rude();
-	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 	pr_info("Running RCU Tasks Trace wait API self tests\n");
-	tests[2].runstart = jiffies;
+	tests[1].runstart = jiffies;
 	synchronize_rcu_tasks_trace();
-	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
+	call_rcu_tasks_trace(&tests[1].rh, test_rcu_tasks_callback);
 #endif
 }
 
-- 
2.40.1

