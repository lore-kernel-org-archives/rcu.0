Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3317AE1C;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=HAkOGT4qeApGP2jBpvBSiYHDSHPQKO+WB5IFWIwmhodwZtOYIK71PpS5eVXJZPBGjUex6c50He1wj+c2wmckAdxGTOpFWbD1PRJp/GEapromQ1ZmY2aIX0SPb5eNRxhctvGZ5Dg2zBrx05BprGnVnm6Mzr4OYQi/nC2CPawg5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=sTn+Cvzcd69ZLs70sZc7NmC/FTAyO2bIgCQX+KRrthU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3q+yzuMlV/4pLgv6ZMFrO5d2tji+WlK5xJV2Aa97B4AviIr5DuCAylTtWWT0Lz52Rz6ET7Fs57AGEU1zGSaZPYJOxERElSqEwrxI4b/pLvczkImvMtk66N/QbHDZAycpvdlhhRcBPqodAWvXz/Y4fi9G1oLDCoxFUQ8aKDlWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC4xTXtl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC4xTXtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B31C4CED0;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=sTn+Cvzcd69ZLs70sZc7NmC/FTAyO2bIgCQX+KRrthU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OC4xTXtl12KMbsuMM02zEgYU9oPasOR33xMPYJsN8jWNIVHS3Djz5GB58oH2H0QrX
	 FZwfk6L8hvp+MipuR8p2zotAcvPKbDAMt1Lnq44angYi5GkbSrlote2M5PnfOfSctz
	 VePdQbP2rU0jO5tefpCLdPU1OzVKPfxHnqeBDbkv6Rdo/W2gWeT3/V+2cwVmSDjVCk
	 sM9dLnrG5MGAYP0XHrQvk/RBkFuSnRLZ3YGIfZtpJjQ7LU8U8S8putDrJ6xYPvwdAr
	 8Aj146xCMPhmRUMORNoD7tawjAroVberm5cBZwsjbE62TJ/Ob5To4F3CQW5wkNMvWD
	 CvoT7SgtoWywg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6E37CE0F78; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/18] rcutorture: Add random real-time preemption
Date: Thu, 12 Dec 2024 10:49:41 -0800
Message-Id: <20241212184957.2127441-2-paulmck@kernel.org>
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

This commit adds the rcutorture.preempt_duration kernel module parameter,
which gives the real-time preemption duration in milliseconds (zero to
disable, which is the default) and also the rcutorture.preempt_interval
module parameter, which gives the interval between successive preemptions,
also in milliseconds, defaulting to one second.  The CPU to preempt is
chosen at random from those online at that time.  Races between preempting
a given CPU and that CPU going offline are ignored, and preemption is
forgone when this occurs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 16 +++++++
 kernel/rcu/rcutorture.c                       | 44 ++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0ca6706..65e5343b46cf9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5424,6 +5424,22 @@
 			Set time (jiffies) between CPU-hotplug operations,
 			or zero to disable CPU-hotplug testing.
 
+	rcutorture.preempt_duration= [KNL]
+			Set duration (in milliseconds) of preemptions
+			by a high-priority FIFO real-time task.  Set to
+			zero (the default) to disable.	The CPUs to
+			preempt are selected randomly from the set that
+			are online at a given point in time.  Races with
+			CPUs going offline are ignored, with that attempt
+			at preemption skipped.
+
+	rcutorture.preempt_interval= [KNL]
+			Set interval (in milliseconds, defaulting to one
+			second) between preemptions by a high-priority
+			FIFO real-time task.  This delay is mediated
+			by an hrtimer and is further fuzzed to avoid
+			inadvertent synchronizations.
+
 	rcutorture.read_exit_burst= [KNL]
 			The number of times in a given read-then-exit
 			episode that a set of read-then-exit kthreads
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 908506b68c412..99780a74da44c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -109,6 +109,8 @@ torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
 torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
 torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
+torture_param(int, preempt_duration, 0, "Preemption duration (ms), zero to disable");
+torture_param(int, preempt_interval, MSEC_PER_SEC, "Interval between preemptions (ms)");
 torture_param(int, read_exit_delay, 13, "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16, "# of read-then-exit bursts per episode, zero to disable");
 torture_param(int, reader_flavor, 0x1, "Reader flavors to use, one per bit.");
@@ -149,6 +151,7 @@ static struct task_struct **fwd_prog_tasks;
 static struct task_struct **barrier_cbs_tasks;
 static struct task_struct *barrier_task;
 static struct task_struct *read_exit_task;
+static struct task_struct *preempt_task;
 
 #define RCU_TORTURE_PIPE_LEN 10
 
@@ -2425,7 +2428,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "read_exit_delay=%d read_exit_burst=%d "
 		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
-		 "test_nmis=%d\n",
+		 "test_nmis=%d "
+		 "preempt_duration=%d preempt_interval=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -2438,7 +2442,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 read_exit_delay, read_exit_burst,
 		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
-		 test_nmis);
+		 test_nmis,
+		 preempt_duration, preempt_interval);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -3418,6 +3423,35 @@ static void rcutorture_test_nmis(int n)
 #endif // #else // #if IS_BUILTIN(CONFIG_RCU_TORTURE_TEST)
 }
 
+// Randomly preempt online CPUs.
+static int rcu_torture_preempt(void *unused)
+{
+	int cpu = -1;
+	DEFINE_TORTURE_RANDOM(rand);
+
+	schedule_timeout_idle(stall_cpu_holdoff);
+	do {
+		// Wait for preempt_interval ms with up to 100us fuzz.
+		torture_hrtimeout_ms(preempt_interval, 100, &rand);
+		// Select online CPU.
+		cpu = cpumask_next(cpu, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_next(-1, cpu_online_mask);
+		WARN_ON_ONCE(cpu >= nr_cpu_ids);
+		// Move to that CPU, if can't do so, retry later.
+		if (torture_sched_setaffinity(current->pid, cpumask_of(cpu), false))
+			continue;
+		// Preempt at high-ish priority, then reset to normal.
+		sched_set_fifo(current);
+		torture_sched_setaffinity(current->pid, cpu_present_mask, true);
+		mdelay(preempt_duration);
+		sched_set_normal(current, 0);
+		stutter_wait("rcu_torture_preempt");
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_torture_preempt");
+	return 0;
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -3446,6 +3480,7 @@ rcu_torture_cleanup(void)
 
 	if (cur_ops->gp_kthread_dbg)
 		cur_ops->gp_kthread_dbg();
+	torture_stop_kthread(rcu_torture_preempt, preempt_task);
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
 	rcu_torture_fwd_prog_cleanup();
@@ -4019,6 +4054,11 @@ rcu_torture_init(void)
 	firsterr = rcu_torture_read_exit_init();
 	if (torture_init_error(firsterr))
 		goto unwind;
+	if (preempt_duration > 0) {
+		firsterr = torture_create_kthread(rcu_torture_preempt, NULL, preempt_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 	if (object_debug)
 		rcu_test_debug_objects();
 	torture_init_end();
-- 
2.40.1

