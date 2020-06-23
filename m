Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3623FC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1149120809
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872734;
	bh=LTL6gFngrf0yDTNa24k1S8HjgfRsiHghAnI6r0BI06c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/fiPwPyCIfbyVBOn2u4L7SjAez1rgvqMFTNtYLjzb7EvxzaS6AqMp2Wb1+VEBXR4
	 0egU9dNBIuwr8/QgWqB+B9Mki1OTE8XS4rNVMP2oesOW62XI7e9ubOORC40jP4CEHE
	 5yBcgEUcCZRIq5o8RVjo+u/fEyDfX56Sd4NF3zZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbgFWAiv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731664AbgFWAh4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:56 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FF1208B8;
        Tue, 23 Jun 2020 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872674;
        bh=LTL6gFngrf0yDTNa24k1S8HjgfRsiHghAnI6r0BI06c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyZb3dhHnFoJDkaGeLs3q4ByXjOLfgwtF8O4NJMvC4+iNvEiDmDIXFaoDcqupLh1Q
         QejxNSw7JI7q+CMyQ++n1VCEbRbblxdhM+/A32SR7x1nmPPBMw5Dixx4ncX/H39TPe
         O/+1tgtH6St84DelvCINXIIGMYGY+Br1JYxd7TgQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/23] rcutorture: Add races with task-exit processing
Date:   Mon, 22 Jun 2020 17:37:33 -0700
Message-Id: <20200623003752.26872-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Several variants of Linux-kernel RCU interact with task-exit processing,
including preemptible RCU, Tasks RCU, and Tasks Trace RCU.  This commit
therefore adds testing of this interaction to rcutorture by adding
rcutorture.read_exit_burst and rcutorture.read_exit_delay kernel-boot
parameters.  These kernel parameters control the frequency and spacing
of special read-then-exit kthreads that are spawned.

[ paulmck: Apply feedback from Dan Carpenter's static checker. ]
[ paulmck: Reduce latency to avoid false-positive shutdown hangs. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  14 +++
 include/linux/torture.h                         |   5 ++
 kernel/rcu/rcutorture.c                         | 112 +++++++++++++++++++++++-
 3 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..a0dcc92 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4258,6 +4258,20 @@
 			Set time (jiffies) between CPU-hotplug operations,
 			or zero to disable CPU-hotplug testing.
 
+	rcutorture.read_exit= [KNL]
+			Set the number of read-then-exit kthreads used
+			to test the interaction of RCU updaters and
+			task-exit processing.
+
+	rcutorture.read_exit_burst= [KNL]
+			The number of times in a given read-then-exit
+			episode that a set of read-then-exit kthreads
+			is spawned.
+
+	rcutorture.read_exit_delay= [KNL]
+			The delay, in seconds, between successive
+			read-then-exit testing episodes.
+
 	rcutorture.shuffle_interval= [KNL]
 			Set task-shuffle interval (s).  Shuffling tasks
 			allows some CPUs to go into dyntick-idle mode
diff --git a/include/linux/torture.h b/include/linux/torture.h
index 629b66e..7f65bd1 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -55,6 +55,11 @@ struct torture_random_state {
 #define DEFINE_TORTURE_RANDOM_PERCPU(name) \
 	DEFINE_PER_CPU(struct torture_random_state, name)
 unsigned long torture_random(struct torture_random_state *trsp);
+static inline void torture_random_init(struct torture_random_state *trsp)
+{
+	trsp->trs_state = 0;
+	trsp->trs_count = 0;
+}
 
 /* Task shuffler, which causes CPUs to occasionally go idle. */
 void torture_shuffle_task_register(struct task_struct *tp);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efb792e..2621a33 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -109,6 +109,10 @@ torture_param(int, object_debug, 0,
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
 	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, read_exit_delay, 13,
+	      "Delay between read-then-exit episodes (s)");
+torture_param(int, read_exit_burst, 16,
+	      "# of read-then-exit bursts per episode, zero to disable");
 torture_param(int, shuffle_interval, 3, "Number of seconds between shuffles");
 torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
@@ -146,6 +150,7 @@ static struct task_struct *stall_task;
 static struct task_struct *fwd_prog_task;
 static struct task_struct **barrier_cbs_tasks;
 static struct task_struct *barrier_task;
+static struct task_struct *read_exit_task;
 
 #define RCU_TORTURE_PIPE_LEN 10
 
@@ -177,6 +182,7 @@ static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
+static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
 
@@ -1539,10 +1545,11 @@ rcu_torture_stats_print(void)
 		n_rcu_torture_boosts,
 		atomic_long_read(&n_rcu_torture_timers));
 	torture_onoff_stats();
-	pr_cont("barrier: %ld/%ld:%ld\n",
+	pr_cont("barrier: %ld/%ld:%ld ",
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
+	pr_cont("read-exits: %ld\n", data_race(n_read_exits));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -1634,7 +1641,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "stall_cpu=%d stall_cpu_holdoff=%d stall_cpu_irqsoff=%d "
 		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
-		 "onoff_interval=%d onoff_holdoff=%d\n",
+		 "onoff_interval=%d onoff_holdoff=%d "
+		 "read_exit_delay=%d read_exit_burst=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -1643,7 +1651,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stall_cpu, stall_cpu_holdoff, stall_cpu_irqsoff,
 		 stall_cpu_block,
 		 n_barrier_cbs,
-		 onoff_interval, onoff_holdoff);
+		 onoff_interval, onoff_holdoff,
+		 read_exit_delay, read_exit_burst);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -2338,6 +2347,99 @@ static bool rcu_torture_can_boost(void)
 	return true;
 }
 
+static bool read_exit_child_stop;
+static bool read_exit_child_stopped;
+static wait_queue_head_t read_exit_wq;
+
+// Child kthread which just does an rcutorture reader and exits.
+static int rcu_torture_read_exit_child(void *trsp_in)
+{
+	struct torture_random_state *trsp = trsp_in;
+
+	set_user_nice(current, MAX_NICE);
+	// Minimize time between reading and exiting.
+	while (!kthread_should_stop())
+		schedule_timeout_uninterruptible(1);
+	(void)rcu_torture_one_read(trsp);
+	return 0;
+}
+
+// Parent kthread which creates and destroys read-exit child kthreads.
+static int rcu_torture_read_exit(void *unused)
+{
+	int count = 0;
+	bool errexit = false;
+	int i;
+	struct task_struct *tsp;
+	DEFINE_TORTURE_RANDOM(trs);
+
+	// Allocate and initialize.
+	set_user_nice(current, MAX_NICE);
+	VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of test");
+
+	// Each pass through this loop does one read-exit episode.
+	do {
+		if (++count > read_exit_burst) {
+			VERBOSE_TOROUT_STRING("rcu_torture_read_exit: End of episode");
+			rcu_barrier(); // Wait for task_struct free, avoid OOM.
+			for (i = 0; i < read_exit_delay; i++) {
+				schedule_timeout_uninterruptible(HZ);
+				if (READ_ONCE(read_exit_child_stop))
+					break;
+			}
+			if (!READ_ONCE(read_exit_child_stop))
+				VERBOSE_TOROUT_STRING("rcu_torture_read_exit: Start of episode");
+			count = 0;
+		}
+		if (READ_ONCE(read_exit_child_stop))
+			break;
+		// Spawn child.
+		tsp = kthread_run(rcu_torture_read_exit_child,
+				     &trs, "%s",
+				     "rcu_torture_read_exit_child");
+		if (IS_ERR(tsp)) {
+			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			errexit = true;
+			tsp = NULL;
+			break;
+		}
+		cond_resched();
+		kthread_stop(tsp);
+		n_read_exits ++;
+		stutter_wait("rcu_torture_read_exit");
+	} while (!errexit && !READ_ONCE(read_exit_child_stop));
+
+	// Clean up and exit.
+	smp_store_release(&read_exit_child_stopped, true); // After reaping.
+	smp_mb(); // Store before wakeup.
+	wake_up(&read_exit_wq);
+	while (!torture_must_stop())
+		schedule_timeout_uninterruptible(1);
+	torture_kthread_stopping("rcu_torture_read_exit");
+	return 0;
+}
+
+static int rcu_torture_read_exit_init(void)
+{
+	if (read_exit_burst <= 0)
+		return -EINVAL;
+	init_waitqueue_head(&read_exit_wq);
+	read_exit_child_stop = false;
+	read_exit_child_stopped = false;
+	return torture_create_kthread(rcu_torture_read_exit, NULL,
+				      read_exit_task);
+}
+
+static void rcu_torture_read_exit_cleanup(void)
+{
+	if (!read_exit_task)
+		return;
+	WRITE_ONCE(read_exit_child_stop, true);
+	smp_mb(); // Above write before wait.
+	wait_event(read_exit_wq, smp_load_acquire(&read_exit_child_stopped));
+	torture_stop_kthread(rcutorture_read_exit, read_exit_task);
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -2359,6 +2461,7 @@ rcu_torture_cleanup(void)
 	}
 
 	show_rcu_gp_kthreads();
+	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
 	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
 	torture_stop_kthread(rcu_torture_stall, stall_task);
@@ -2682,6 +2785,9 @@ rcu_torture_init(void)
 	firsterr = rcu_torture_barrier_init();
 	if (firsterr)
 		goto unwind;
+	firsterr = rcu_torture_read_exit_init();
+	if (firsterr)
+		goto unwind;
 	if (object_debug)
 		rcu_test_debug_objects();
 	torture_init_end();
-- 
2.9.5

