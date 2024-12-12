Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F11925AB;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=SGQwpc38HSGIe16GEIVR0a0irvRxVIDw+2aHjus91qvaJ3ZpsJdlTz3HL4OlUrhTeczRf0jcrRY54g6SSdCR07o8SVQF4neuRApqHh1M/rBnQ7hIL93wzOMoIH6I8GJIJFQ3gOJl4wcMcMx6w90hxH6Uhvfhl4V+082fyB3NrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=6487paCoManNb8ly3xlMS3RMItR5+ODJKRr6Ag7r8P8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeP6iThXxvolo0IAfh311WfpC3ahCooG5CCpiPZ0AFDuSuLM4DRObCEZ/DDoBwckmaMRzsSdaJ702tNBqxYwhTkttUFaF0O9e7elQ7d+DXLMQA0QA3zamjjytadZJXy7B0UrEETxkmKng1aVAHpC9zpb2Nq8Hl6LuMPaBkyv6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYXrA0Mt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYXrA0Mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A06C4CEDD;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=6487paCoManNb8ly3xlMS3RMItR5+ODJKRr6Ag7r8P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYXrA0MtcS2eIbNsTcBY2468D14mCUVKOCEs4SPhQ+Lt+4lptdAzP+zGeXizbqD6M
	 TQyWKb/E01IOjHydNwlBCJQEIqYVK1kI76VVo7KPiG8UV3bANgsZiZTUWgI28NW3Tf
	 k+hKnFVXIAKLRs91fCm1NTp1PQYMR3ug8FdooDhTCXsjC4zmQEQIf/MqDNSniy3+VT
	 zdN14hGiM4xir3EJKYB+3d1ekzchKe2xnWfgOn8W4ktWQEBQf9mDHxfX+hFJ/PBpGl
	 1290Y0XZukcXCEfgWDRAdlz44NflnkfvIXO5p8EkHMbY+udcX0FLP511zxf0WuuSN0
	 zZkVqUcfUp2bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0247CE1116; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 11/18] rcutorture: Make rcutorture_one_extend() check reader state
Date: Thu, 12 Dec 2024 10:49:50 -0800
Message-Id: <20241212184957.2127441-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds reader-state debugging checks to a new function named
rcutorture_one_extend_check(), which is invoked before and after setting
new reader states by the existing rcutorture_one_extend() function.
These checks have proven to be rather heavyweight, reducing reproduction
rate of some failures by a factor of two.  They are therefore hidden
behind a new RCU_TORTURE_TEST_CHK_RDR_STATE Kconfig option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
---
 kernel/rcu/Kconfig.debug | 16 +++++++++
 kernel/rcu/rcutorture.c  | 71 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index b3ac000004bfe..6af90510a1ca7 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -53,6 +53,22 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
+config RCU_TORTURE_TEST_CHK_RDR_STATE
+	tristate "Check rcutorture reader state"
+	depends on RCU_TORTURE_TEST
+	default n
+	help
+	  This option causes rcutorture to check the desired rcutorture
+	  reader state for each segment against the actual context.
+	  Note that PREEMPT_COUNT must be enabled if the preempt-disabled
+	  and bh-disabled checks are to take effect, and that PREEMPT_RCU
+	  must be enabled for the RCU-nesting checks to take effect.
+	  These checks add overhead, and this Kconfig options is therefore
+	  disabled by default.
+
+	  Say Y here if you want rcutorture reader contexts checked.
+	  Say N if you are unsure.
+
 config RCU_TORTURE_TEST_LOG_CPU
 	tristate "Log CPU for rcutorture failures"
 	depends on RCU_TORTURE_TEST
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c875e7239ae7d..8c7820a00f3c3 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -359,7 +359,8 @@ struct rcu_torture_ops {
 	void (*read_delay)(struct torture_random_state *rrsp,
 			   struct rt_read_seg *rtrsp);
 	void (*readunlock)(int idx);
-	int (*readlock_held)(void);
+	int (*readlock_held)(void);   // lockdep.
+	int (*readlock_nesting)(void); // actual nesting, if available, -1 if not.
 	unsigned long (*get_gp_seq)(void);
 	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
 	void (*deferred_free)(struct rcu_torture *p);
@@ -466,6 +467,15 @@ static void rcu_torture_read_unlock(int idx)
 	rcu_read_unlock();
 }
 
+static int rcu_torture_readlock_nesting(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		return rcu_preempt_depth();
+	if (IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return (preempt_count() & PREEMPT_MASK);
+	return -1;
+}
+
 /*
  * Update callback in the pipe.  This should be invoked after a grace period.
  */
@@ -555,6 +565,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.read_delay		= rcu_read_delay,
 	.readunlock		= rcu_torture_read_unlock,
 	.readlock_held		= torture_readlock_not_held,
+	.readlock_nesting	= rcu_torture_readlock_nesting,
 	.get_gp_seq		= rcu_get_gp_seq,
 	.gp_diff		= rcu_seq_diff,
 	.deferred_free		= rcu_torture_deferred_free,
@@ -1847,6 +1858,44 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 	smp_store_release(&rtrcp_assigner->rtc_chkrdr, -1); // Assigner can again assign.
 }
 
+// Verify the specified RCUTORTURE_RDR* state.
+#define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x\n", __func__, s, curstate, new, old
+static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
+{
+	if (!IS_ENABLED(CONFIG_RCU_TORTURE_TEST_CHK_RDR_STATE))
+		return;
+
+	WARN_ONCE(!(curstate & RCUTORTURE_RDR_IRQ) && irqs_disabled(), ROEC_ARGS);
+	WARN_ONCE((curstate & RCUTORTURE_RDR_IRQ) && !irqs_disabled(), ROEC_ARGS);
+
+	// If CONFIG_PREEMPT_COUNT=n, further checks are unreliable.
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return;
+
+	WARN_ONCE((curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
+		  !(preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
+	WARN_ONCE((curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
+		  !(preempt_count() & PREEMPT_MASK), ROEC_ARGS);
+	WARN_ONCE(cur_ops->readlock_nesting &&
+		  (curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
+		  cur_ops->readlock_nesting() == 0, ROEC_ARGS);
+
+	// Timer handlers have all sorts of stuff disabled, so ignore
+	// unintended disabling.
+	if (insoftirq)
+		return;
+
+	WARN_ONCE(cur_ops->extendables &&
+		  !(curstate & (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH)) &&
+		  (preempt_count() & SOFTIRQ_MASK), ROEC_ARGS);
+	WARN_ONCE(cur_ops->extendables &&
+		  !(curstate & (RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED)) &&
+		  (preempt_count() & PREEMPT_MASK), ROEC_ARGS);
+	WARN_ONCE(cur_ops->readlock_nesting &&
+		  !(curstate & (RCUTORTURE_RDR_RCU_1 | RCUTORTURE_RDR_RCU_2)) &&
+		  cur_ops->readlock_nesting() > 0, ROEC_ARGS);
+}
+
 /*
  * Do one extension of an RCU read-side critical section using the
  * current reader state in readstate (set to zero for initial entry
@@ -1856,7 +1905,7 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
  * beginning or end of the critical section and if there was actually a
  * change, do a ->read_delay().
  */
-static void rcutorture_one_extend(int *readstate, int newstate,
+static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 				  struct torture_random_state *trsp,
 				  struct rt_read_seg *rtrsp)
 {
@@ -1870,6 +1919,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 
 	WARN_ON_ONCE(idxold2 < 0);
 	WARN_ON_ONCE(idxold2 & ~RCUTORTURE_RDR_ALLBITS);
+	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
 	rtrsp->rt_readstate = newstate;
 	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
 		rtrsp->rt_cpu = raw_smp_processor_id();
@@ -1890,6 +1940,10 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	if (statesnew & RCUTORTURE_RDR_RCU_2)
 		idxnew2 = (cur_ops->readlock() << RCUTORTURE_RDR_SHIFT_2) & RCUTORTURE_RDR_MASK_2;
 
+	// Complain unless both the old and the new protection is in place.
+	rcutorture_one_extend_check("during change",
+				    idxold1 | statesnew, statesnew, statesold, insoftirq);
+
 	/*
 	 * Next, remove old protection, in decreasing order of strength
 	 * to avoid unlock paths that aren't safe in the stronger
@@ -1940,6 +1994,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	WARN_ON_ONCE(*readstate < 0);
 	if (WARN_ON_ONCE(*readstate & ~RCUTORTURE_RDR_ALLBITS))
 		pr_info("Unexpected readstate value of %#x\n", *readstate);
+	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold, insoftirq);
 }
 
 /* Return the biggest extendables mask given current RCU and boot parameters. */
@@ -2006,7 +2061,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
  * critical section.
  */
 static struct rt_read_seg *
-rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
+rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_state *trsp,
 		       struct rt_read_seg *rtrsp)
 {
 	int i;
@@ -2021,7 +2076,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
 	i = ((i | (i >> 3)) & RCUTORTURE_RDR_MAX_LOOPS) + 1;
 	for (j = 0; j < i; j++) {
 		mask = rcutorture_extend_mask(*readstate, trsp);
-		rcutorture_one_extend(readstate, mask, trsp, &rtrsp[j]);
+		rcutorture_one_extend(readstate, mask, insoftirq, trsp, &rtrsp[j]);
 	}
 	return &rtrsp[j];
 }
@@ -2051,7 +2106,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 
 	WARN_ON_ONCE(!rcu_is_watching());
 	newstate = rcutorture_extend_mask(readstate, trsp);
-	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
+	rcutorture_one_extend(&readstate, newstate, myid < 0, trsp, rtrsp++);
 	if (checkpolling) {
 		if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
 			cookie = cur_ops->get_gp_state();
@@ -2064,13 +2119,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 				  !cur_ops->readlock_held || cur_ops->readlock_held());
 	if (p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
-		rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
+		rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
 		return false;
 	}
 	if (p->rtort_mbtest == 0)
 		atomic_inc(&n_rcu_torture_mberror);
 	rcu_torture_reader_do_mbchk(myid, p, trsp);
-	rtrsp = rcutorture_loop_extend(&readstate, trsp, rtrsp);
+	rtrsp = rcutorture_loop_extend(&readstate, myid < 0, trsp, rtrsp);
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
@@ -2112,7 +2167,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 		preempted = cur_ops->reader_blocked();
 	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU))
 		rt_last_cpu = raw_smp_processor_id();
-	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
+	rcutorture_one_extend(&readstate, 0, myid < 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate);
 	// This next splat is expected behavior if leakpointer, especially
 	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
-- 
2.40.1

