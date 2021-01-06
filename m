Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C4C43331
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8751C22D01
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbhAFEuc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbhAFEuc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3091E23104;
        Wed,  6 Jan 2021 04:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908538;
        bh=JCumiKo0x66I5ro59jMaZuZv4O21IyP8y4xd+BwcqfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jM3wFQJuq4yPmkmJjgSl8x1mRwKCm0/9EoV5HCo8TCEVvqCse/mLeIt0PdhCNoUW2
         zHiR9GKCH2O0h5BJWXN+E6PXE9W5YFGDRtEaAS4VIpCV06MNBjdu8apX0uw9FVRKiK
         EEjBtqqvqNlOpB23clIHeKyq4WdXZM6zevdWEttk7eEUcXKnBxaa2aCZAAZNyzPNRZ
         lht6qrd+Aul7/LIy7t3JbdzoELroHxpjrjJAMeRXGeRcGdXbDql/VqSJln4fVilHD6
         pn/r7gWVRoeXhfX3dqH/RD+GntVNdXEvMGjiX3FVYtYGFHI/c5eyQ7R2xLW6nJLFBS
         x21Zydgk0A3Mw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH tip/core/rcu 16/21] rcutorture: Test runtime toggling of CPUs' callback offloading
Date:   Tue,  5 Jan 2021 20:48:48 -0800
Message-Id: <20210106044853.20812-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Frederic Weisbecker is adding the ability to change the rcu_nocbs state
of CPUs at runtime, that is, to offload and deoffload their RCU callback
processing without the need to reboot.  As the old saying goes, "if it
ain't tested, it don't work", so this commit therefore adds prototype
rcutorture testing for this capability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++
 kernel/rcu/rcutorture.c                         | 90 ++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..9f8ac77 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4338,6 +4338,14 @@
 			stress RCU, they don't participate in the actual
 			test, hence the "fake".
 
+	rcutorture.nocbs_nthreads= [KNL]
+			Set number of RCU callback-offload togglers.
+			Zero (the default) disables toggling.
+
+	rcutorture.nocbs_toggle= [KNL]
+			Set the delay in milliseconds between successive
+			callback-offload toggling attempts.
+
 	rcutorture.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N-1, where N is the number of CPUs.  A value
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 528ed10..22735bc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -97,6 +97,8 @@ torture_param(int, object_debug, 0,
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
 	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
+torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, read_exit_delay, 13,
 	      "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16,
@@ -127,10 +129,12 @@ static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
+static int nrealnocbers;
 static int nrealreaders;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
 static struct task_struct *boost_tasks[NR_CPUS];
@@ -174,6 +178,8 @@ static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
 static unsigned long start_gp_seq;
+static atomic_long_t n_nocb_offload;
+static atomic_long_t n_nocb_deoffload;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -1499,6 +1505,53 @@ rcu_torture_reader(void *arg)
 }
 
 /*
+ * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
+ * increase race probabilities and fuzzes the interval between toggling.
+ */
+static int rcu_nocb_toggle(void *arg)
+{
+	int cpu;
+	int maxcpu = -1;
+	int oldnice = task_nice(current);
+	long r;
+	DEFINE_TORTURE_RANDOM(rand);
+	ktime_t toggle_delay;
+	unsigned long toggle_fuzz;
+	ktime_t toggle_interval = ms_to_ktime(nocbs_toggle);
+
+	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
+	for_each_online_cpu(cpu)
+		maxcpu = cpu;
+	WARN_ON(maxcpu < 0);
+	if (toggle_interval > ULONG_MAX)
+		toggle_fuzz = ULONG_MAX >> 3;
+	else
+		toggle_fuzz = toggle_interval >> 3;
+	if (toggle_fuzz <= 0)
+		toggle_fuzz = NSEC_PER_USEC;
+	do {
+		r = torture_random(&rand);
+		cpu = (r >> 4) % (maxcpu + 1);
+		if (r & 0x1) {
+			rcu_nocb_cpu_offload(cpu);
+			atomic_long_inc(&n_nocb_offload);
+		} else {
+			rcu_nocb_cpu_deoffload(cpu);
+			atomic_long_inc(&n_nocb_deoffload);
+		}
+		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
+		if (stutter_wait("rcu_nocb_toggle"))
+			sched_set_normal(current, oldnice);
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_nocb_toggle");
+	return 0;
+}
+
+/*
  * Print torture statistics.  Caller must ensure that there is only
  * one call to this function at a given time!!!  This is normally
  * accomplished by relying on the module system to only have one copy
@@ -1553,7 +1606,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
-	pr_cont("read-exits: %ld\n", data_race(n_read_exits));
+	pr_cont("read-exits: %ld ", data_race(n_read_exits));
+	pr_cont("nocb-toggles: %ld:%ld\n",
+		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -1647,7 +1702,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
-		 "read_exit_delay=%d read_exit_burst=%d\n",
+		 "read_exit_delay=%d read_exit_burst=%d "
+		 "nocbs_nthreads=%d nocbs_toggle=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -1657,7 +1713,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stall_cpu_block,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
-		 read_exit_delay, read_exit_burst);
+		 read_exit_delay, read_exit_burst,
+		 nocbs_nthreads, nocbs_toggle);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -2500,6 +2557,13 @@ rcu_torture_cleanup(void)
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
+	if (nocb_tasks) {
+		for (i = 0; i < nrealnocbers; i++)
+			torture_stop_kthread(rcu_nocb_toggle, nocb_tasks[i]);
+		kfree(nocb_tasks);
+		nocb_tasks = NULL;
+	}
+
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -2762,6 +2826,26 @@ rcu_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	nrealnocbers = nocbs_nthreads;
+	if (WARN_ON(nrealnocbers < 0))
+		nrealnocbers = 1;
+	if (WARN_ON(nocbs_toggle < 0))
+		nocbs_toggle = HZ;
+	if (nrealnocbers > 0) {
+		nocb_tasks = kcalloc(nrealnocbers, sizeof(nocb_tasks[0]), GFP_KERNEL);
+		if (nocb_tasks == NULL) {
+			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
+	} else {
+		nocb_tasks = NULL;
+	}
+	for (i = 0; i < nrealnocbers; i++) {
+		firsterr = torture_create_kthread(rcu_nocb_toggle, NULL, nocb_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(rcu_torture_stats, NULL,
 						  stats_task);
-- 
2.9.5

