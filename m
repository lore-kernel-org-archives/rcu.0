Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355241F1907;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=Q6v2zfQgxxE3Oowf+Lxi8xo5e6wnScENwoOm1N/bY4LWZlqcTFfi26RTo5zXIT29GfFcFnSoRsUf0tQ5DpTRL7fRSnEJ0j7UrPesFL/hp8C3dya43dLDMhPjDzBhldy/B/kLVWQluIBG+lqmKP4aD0zY3gxC16xbtlkEwH1ZJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=2ug2Bc1NnkMzl6Ow5ECKPgqvzN8GdN1k9XaP7ueuDqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fPqRG2E/CSaQJbTgt38GH91Xts+gYCnLX8cqdS+KZtk4OTjyPTq+2I81ZgCGpX8SXMgZd/4Js19d1ktENQIhrGGM2fCO4TvRArtGtP6XlSvVupTdBij93eIJDbC3rcriIgm8jTVoUmXos2VRmoE0SekvjRXnNFa+XFih/U/pwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0kbboyD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0kbboyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B647FC4AF0B;
	Thu, 30 Jan 2025 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263885;
	bh=2ug2Bc1NnkMzl6Ow5ECKPgqvzN8GdN1k9XaP7ueuDqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0kbboyD/6w1DPK4iGGbdPmsRSMbdBw14Tbq7UbgQ3/7R2k7QcFErBD92pgJJaVE0
	 UpwHJnDRIlRc/jITRGaGRjsOgLaRZI6p18FKFXldlO5gvU+jLvYe6UDuMbIMXKtleo
	 +kS6oQSxLlkwyb28sUf8DGSB7oh65gR9MFPUnPpdE7PwaKvef4NWLXLSDc8abItzri
	 Yo9tmwn715q8p1vwtiCBs/ZYFv7NIJZOms83ewmlNzFILQSxsfFdB4Zo91UG42MpMZ
	 UiVIX6Eg4Wea5vxVUhoB8y6POCQbmvhVEcLB4K/uvd3QDwsLmV8ZgWYd7zpcFPSRFL
	 fy1Xb3oNlvFug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 794D1CE37DA; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 02/11] rcutorture: Add a test_boost_holdoff module parameter
Date: Thu, 30 Jan 2025 11:04:35 -0800
Message-Id: <20250130190444.1652700-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a test_boost_holdoff module parameter that tells the RCU
priority-boosting tests to wait for the specified number of seconds past
the start of the rcutorture test.  This can be useful when rcutorture
is built into the kernel (as opposed to being modprobed), especially on
large systems where early start of RCU priority boosting can delay the
boot sequence, which adds a full CPU's worth of load onto the system.
This can in turn result in pointless stall warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++++
 kernel/rcu/rcutorture.c                       | 19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3152f2c1da29..d6c3f9d9d3a7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5592,6 +5592,11 @@
 	rcutorture.test_boost_duration= [KNL]
 			Duration (s) of each individual boost test.
 
+	rcutorture.test_boost_holdoff= [KNL]
+			Holdoff time (s) from start of test to the start
+			of RCU priority-boost testing.	Defaults to zero,
+			that is, no holdoff.
+
 	rcutorture.test_boost_interval= [KNL]
 			Interval (s) between each boost test.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1bd3eaa0b8e7..978893398465 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -135,6 +135,7 @@ torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
+torture_param(int, test_boost_holdoff, 0, "Holdoff time from rcutorture start, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
 torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
@@ -1159,8 +1160,19 @@ static int rcu_torture_boost(void *arg)
 	unsigned long gp_state;
 	unsigned long gp_state_time;
 	unsigned long oldstarttime;
+	unsigned long booststarttime = get_torture_init_jiffies() + test_boost_holdoff * HZ;
 
-	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
+	if (test_boost_holdoff <= 0 || time_after(jiffies, booststarttime)) {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost started");
+	} else {
+		VERBOSE_TOROUT_STRING("rcu_torture_boost started holdoff period");
+		while (time_before(jiffies, booststarttime)) {
+			schedule_timeout_idle(HZ);
+			if (kthread_should_stop())
+				goto cleanup;
+		}
+		VERBOSE_TOROUT_STRING("rcu_torture_boost finished holdoff period");
+	}
 
 	/* Set real-time priority. */
 	sched_set_fifo_low(current);
@@ -1236,6 +1248,7 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
+cleanup:
 	/* Clean up and exit. */
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb("rcu_torture_boost");
@@ -2523,7 +2536,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "shuffle_interval=%d stutter=%d irqreader=%d "
 		 "fqs_duration=%d fqs_holdoff=%d fqs_stutter=%d "
 		 "test_boost=%d/%d test_boost_interval=%d "
-		 "test_boost_duration=%d shutdown_secs=%d "
+		 "test_boost_duration=%d test_boost_holdoff=%d shutdown_secs=%d "
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
 		 "stall_cpu_block=%d stall_cpu_repeat=%d "
 		 "n_barrier_cbs=%d "
@@ -2537,7 +2550,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
 		 test_boost, cur_ops->can_boost,
-		 test_boost_interval, test_boost_duration, shutdown_secs,
+		 test_boost_interval, test_boost_duration, test_boost_holdoff, shutdown_secs,
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
 		 stall_cpu_block, stall_cpu_repeat,
 		 n_barrier_cbs,
-- 
2.40.1

