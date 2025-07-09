Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E1292B2B;
	Wed,  9 Jul 2025 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057811; cv=none; b=gzOVDBNY7E8WVqDqKgENN2VKp17KC5O6vUbZVYQ3y1bNBHXmPe5/gllM4XSOrAG49+NVKzm+Y2cPnKOzWDrtWudxEE473IZmIWs2BjQ4X7i8LTkOLSxFvr10zCxQ4EJMmXpglZ5SbXyPU04RSVrFCyHBffsgkPqCYwWZuchjprM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057811; c=relaxed/simple;
	bh=g5ytatk8FR+ZKb3V98rWAdbM2uy/6s4y3Qm5Q/BRvEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZGSUwl+motH2CvER7chdg1GbzIuBqjyfk0bKDuO35U7ZAbpETuMq65noD1Hz0OYRVloIDKBRvU6D0h662Rw/F3qstmvOTrJUhpc+o1Ux5XtGEafYrBBWyu0rVzhgUv8ClK6Mzn4czjrigJc4YeK42UAD/mNEdlqVH9DzgDG8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuDkwAul; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuDkwAul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7DEC4CEEF;
	Wed,  9 Jul 2025 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057811;
	bh=g5ytatk8FR+ZKb3V98rWAdbM2uy/6s4y3Qm5Q/BRvEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuDkwAul6vv3iGcz4uiC9mmCJtmD6iac6r5sXx2HHShs64gSgHD4XKWzbiGHQEPaO
	 VUv0k3+gcnpQ7tssLZpOFzNrKLrXtARk1vfGdVMWKoXR4M/CuadnjZM0D55Uc6p3dU
	 cpgWnTYGDri0CIjJ4aUqKRsBEfR6Qkk6TvyA9jlN3se6bWKdDGr+G47784BJgIenHF
	 Jyht18xs/pNyNyGvlm83EGNxL6M7P68BS/E9yLxQZF30lLTJ4pAwpvTh2GlgleSljo
	 XxqZiabnsiVWJmsiJbFv4fk6uR9w76MZwawBIW6QgLQsbMYXO4yNpwa54UePRQ7Y8J
	 g8VbhKZvUsf7g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 10/15] rcutorture: Drop redundant "insoftirq" parameters
Date: Wed,  9 Jul 2025 16:12:10 +0530
Message-Id: <20250709104215.15562-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Given that the rcutorture_one_extend_check() function now uses
in_serving_softirq() and in_hardirq(), it is no longer necessary to pass
insoftirq flags down the function-call stack.  This commit therefore
removes those flags, and, while in the area, does a bit of whitespace
cleanup.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3f644b1f5823..470b5a117602 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1975,7 +1975,7 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 
 // Verify the specified RCUTORTURE_RDR* state.
 #define ROEC_ARGS "%s %s: Current %#x  To add %#x  To remove %#x  preempt_count() %#x\n", __func__, s, curstate, new, old, preempt_count()
-static void rcutorture_one_extend_check(char *s, int curstate, int new, int old, bool insoftirq)
+static void rcutorture_one_extend_check(char *s, int curstate, int new, int old)
 {
 	int mask;
 
@@ -2038,8 +2038,7 @@ static void rcutorture_one_extend_check(char *s, int curstate, int new, int old,
  * beginning or end of the critical section and if there was actually a
  * change, do a ->read_delay().
  */
-static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
-				  struct torture_random_state *trsp,
+static void rcutorture_one_extend(int *readstate, int newstate, struct torture_random_state *trsp,
 				  struct rt_read_seg *rtrsp)
 {
 	bool first;
@@ -2054,7 +2053,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	first = idxold1 == 0;
 	WARN_ON_ONCE(idxold2 < 0);
 	WARN_ON_ONCE(idxold2 & ~(RCUTORTURE_RDR_ALLBITS | RCUTORTURE_RDR_UPDOWN));
-	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold, insoftirq);
+	rcutorture_one_extend_check("before change", idxold1, statesnew, statesold);
 	rtrsp->rt_readstate = newstate;
 
 	/* First, put new protection in place to avoid critical-section gap. */
@@ -2074,8 +2073,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 		idxnew2 = (cur_ops->readlock() << RCUTORTURE_RDR_SHIFT_2) & RCUTORTURE_RDR_MASK_2;
 
 	// Complain unless both the old and the new protection is in place.
-	rcutorture_one_extend_check("during change",
-				    idxold1 | statesnew, statesnew, statesold, insoftirq);
+	rcutorture_one_extend_check("during change", idxold1 | statesnew, statesnew, statesold);
 
 	// Sample CPU under both sets of protections to reduce confusion.
 	if (IS_ENABLED(CONFIG_RCU_TORTURE_TEST_LOG_CPU)) {
@@ -2150,7 +2148,7 @@ static void rcutorture_one_extend(int *readstate, int newstate, bool insoftirq,
 	WARN_ON_ONCE(*readstate < 0);
 	if (WARN_ON_ONCE(*readstate & ~RCUTORTURE_RDR_ALLBITS))
 		pr_info("Unexpected readstate value of %#x\n", *readstate);
-	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold, insoftirq);
+	rcutorture_one_extend_check("after change", *readstate, statesnew, statesold);
 }
 
 /* Return the biggest extendables mask given current RCU and boot parameters. */
@@ -2217,8 +2215,7 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
  * critical section.
  */
 static struct rt_read_seg *
-rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_state *trsp,
-		       struct rt_read_seg *rtrsp)
+rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp, struct rt_read_seg *rtrsp)
 {
 	int i;
 	int j;
@@ -2233,7 +2230,7 @@ rcutorture_loop_extend(int *readstate, bool insoftirq, struct torture_random_sta
 	for (j = 0; j < i; j++) {
 		mask = rcutorture_extend_mask(*readstate, trsp);
 		WARN_ON_ONCE(mask & RCUTORTURE_RDR_UPDOWN);
-		rcutorture_one_extend(readstate, mask, insoftirq, trsp, &rtrsp[j]);
+		rcutorture_one_extend(readstate, mask, trsp, &rtrsp[j]);
 	}
 	return &rtrsp[j];
 }
@@ -2279,7 +2276,7 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
 					  (rtorsp->readstate & RCUTORTURE_RDR_UPDOWN));
 	if (rtorsp->p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
-		rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
+		rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
 		return false;
 	}
 	if (rtorsp->p->rtort_mbtest == 0)
@@ -2293,7 +2290,7 @@ static bool rcu_torture_one_read_start(struct rcu_torture_one_read_state *rtorsp
  * critical sections and check for errors.
  */
 static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
-				     struct torture_random_state *trsp, long myid)
+				     struct torture_random_state *trsp)
 {
 	int i;
 	unsigned long completed;
@@ -2340,7 +2337,7 @@ static void rcu_torture_one_read_end(struct rcu_torture_one_read_state *rtorsp,
 	}
 	if (cur_ops->reader_blocked)
 		preempted = cur_ops->reader_blocked();
-	rcutorture_one_extend(&rtorsp->readstate, 0, myid < 0, trsp, rtorsp->rtrsp);
+	rcutorture_one_extend(&rtorsp->readstate, 0, trsp, rtorsp->rtrsp);
 	WARN_ON_ONCE(rtorsp->readstate);
 	// This next splat is expected behavior if leakpointer, especially
 	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
@@ -2370,13 +2367,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	init_rcu_torture_one_read_state(&rtors, trsp);
 	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
 	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
-	rcutorture_one_extend(&rtors.readstate, newstate, myid < 0, trsp, rtors.rtrsp++);
+	rcutorture_one_extend(&rtors.readstate, newstate, trsp, rtors.rtrsp++);
 	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
-		rcutorture_one_extend(&rtors.readstate, 0, myid < 0, trsp, rtors.rtrsp);
+		rcutorture_one_extend(&rtors.readstate, 0, trsp, rtors.rtrsp);
 		return false;
 	}
-	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, myid < 0, trsp, rtors.rtrsp);
-	rcu_torture_one_read_end(&rtors, trsp, myid);
+	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
+	rcu_torture_one_read_end(&rtors, trsp);
 	return true;
 }
 
@@ -2469,7 +2466,7 @@ static enum hrtimer_restart rcu_torture_updown_hrt(struct hrtimer *hrtp)
 	struct rcu_torture_one_read_state_updown *rtorsup;
 
 	rtorsup = container_of(hrtp, struct rcu_torture_one_read_state_updown, rtorsu_hrt);
-	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+	rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 	WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
 	WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
 	WRITE_ONCE(rtorsup->rtorsu_nmigrates,
@@ -2519,7 +2516,7 @@ static void rcu_torture_updown_cleanup(void)
 		if (!smp_load_acquire(&rtorsup->rtorsu_inuse))
 			continue;
 		if (hrtimer_cancel(&rtorsup->rtorsu_hrt) || WARN_ON_ONCE(rtorsup->rtorsu_inuse)) {
-			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs, -1);
+			rcu_torture_one_read_end(&rtorsup->rtorsu_rtors, &rtorsup->rtorsu_trs);
 			WARN_ONCE(rtorsup->rtorsu_nups >= rtorsup->rtorsu_ndowns, "%s: Up without matching down #%zu.\n", __func__, rtorsup - updownreaders);
 			WRITE_ONCE(rtorsup->rtorsu_nups, rtorsup->rtorsu_nups + 1);
 			smp_store_release(&rtorsup->rtorsu_inuse, false);
-- 
2.40.1

