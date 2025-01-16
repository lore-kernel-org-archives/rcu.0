Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532172442E1;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=VM4Cr8U9hFHFGtObQHDf7+e0m5c182M+JqSIBApk38fb1x0IbqsX7fEopkM4Un0DSBZTBQ1qpHmIlRikkZh6YHiCXmR2zKvk5sJrZAyoYq62sY4xkV1pzy2vWs1dtBrFaFn60iHysehrk0VdCtCnqq50vSkOxHH1w7pQ4oASIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=v8Vx57I2ULal+cNnM9rDZYU6BFWOj5CJDnMjBosdXCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KY7yHdM0qB3zj/MGent42TFfnQWbjnTQEKXWL+uvJOMpfOITbrm+P0R1Kii6WpNt26Vw9vRj82jo7GIhZGNi2fugFZyd828mCln6LmDXs5skcLa8i++WV0AtjRDqxSvHqJLXa8iAmAy1325kDOI7KWePMkP/JZ3NLinuMe3cIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rv/4Sqb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rv/4Sqb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF462C4CEDD;
	Thu, 16 Jan 2025 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=v8Vx57I2ULal+cNnM9rDZYU6BFWOj5CJDnMjBosdXCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rv/4Sqb38mfK2/vvjID2IHO4Q2tv7cvDZcGKzfB70nikBijVb3TDwQFlgBfoduuOH
	 H24v8O8qjG7hPW5UmPHmIghFccMqR6vDVmgyafRa17IePU01DpZ3s8Gmi++M1bAgv4
	 hbyUC2QtgMI1679gGhT7iSZWJmFvhV/Iim+7a6fH4IIj4ee9MJrP0siPd1vuxCXOj5
	 svhHCQRfOCoiR4O5ecaj8GTRpuR5GHp52lMt0LzF85y8Ds39kXE62iSE/dL2w+1ZJL
	 eb2fpSbNTEIWYF44jROFJU3nuyE3RiIczqnVDiTvtZONkEhMA9hjurjZkfuUU06zrP
	 jpfIoMcylWWKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A37A6CE13C5; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/11] rcutorture: Add a test_boost_holdoff module parameter
Date: Thu, 16 Jan 2025 12:24:25 -0800
Message-Id: <20250116202434.3783613-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
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
index 3152f2c1da294..d6c3f9d9d3a73 100644
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
index 1bd3eaa0b8e7a..9788933984655 100644
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

