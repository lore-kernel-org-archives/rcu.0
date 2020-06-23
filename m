Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DAFC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4346F204EC
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872244;
	bh=ZZF40ixl8IrTj04LRILWOsgj1ofY1RMjCmbTmlpZnZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JW7ywK8dW9K6zjsARn3lnYAPJsTnEF0UkTO8OOv5H2EyfPuZSTzfKUZ3ZEA83qPOm
	 Cbnn1tTVL6dWjuQMoLp6b7BXSh98X6cfpmqmdTMQA/qh/QCbfmszdJQa+8J9GvA5nk
	 mqyqDd/wdJK+si4OBu1+uBImyYlx5ICpaXbqwdnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgFWAaX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731725AbgFWAaW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17215208DB;
        Tue, 23 Jun 2020 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872221;
        bh=ZZF40ixl8IrTj04LRILWOsgj1ofY1RMjCmbTmlpZnZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+Go34NrNwATG6Yo/kxYZH+sn0HdGWPqr9RHHz0+jpBInX3+DauRTEi2XwJW6hJ1G
         MCCf9f1WImh2/ad1htrG+ReqNr1QJFB5UiQNi4ZitX1ix3POrZHGLPAvuhe04g0+pH
         Kv41GxXHx9af0K+lEmLDQAIHFaWGET6Ip8DMVFjQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 29/30] refperf: Rename refperf.c to refscale.c and change internal names
Date:   Mon, 22 Jun 2020 17:30:12 -0700
Message-Id: <20200623003013.26252-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit further avoids conflation of refperf with the kernel's perf
feature by renaming kernel/rcu/refperf.c to kernel/rcu/refscale.c,
and also by similarly renaming the functions and variables inside
this file.  This has the side effect of changing the names of the
kernel boot parameters, so kernel-parameters.txt and ver_functions.sh
are also updated.

The rcutorture --torture type remains refperf, and this will be
addressed in a separate commit.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt    |  17 +-
 kernel/rcu/Makefile                                |   2 +-
 kernel/rcu/{refperf.c => refscale.c}               | 182 ++++++++++-----------
 .../rcutorture/configs/refperf/ver_functions.sh    |   4 +-
 4 files changed, 104 insertions(+), 101 deletions(-)
 rename kernel/rcu/{refperf.c => refscale.c} (74%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 20cd00b..a4e4e0f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4407,13 +4407,13 @@
 			      reboot_cpu is s[mp]#### with #### being the processor
 					to be used for rebooting.
 
-	refperf.holdoff= [KNL]
+	refscale.holdoff= [KNL]
 			Set test-start holdoff period.  The purpose of
 			this parameter is to delay the start of the
 			test until boot completes in order to avoid
 			interference.
 
-	refperf.loops= [KNL]
+	refscale.loops= [KNL]
 			Set the number of loops over the synchronization
 			primitive under test.  Increasing this number
 			reduces noise due to loop start/end overhead,
@@ -4421,26 +4421,29 @@
 			noise to a handful of picoseconds on ca. 2020
 			x86 laptops.
 
-	refperf.nreaders= [KNL]
+	refscale.nreaders= [KNL]
 			Set number of readers.  The default value of -1
 			selects N, where N is roughly 75% of the number
 			of CPUs.  A value of zero is an interesting choice.
 
-	refperf.nruns= [KNL]
+	refscale.nruns= [KNL]
 			Set number of runs, each of which is dumped onto
 			the console log.
 
-	refperf.readdelay= [KNL]
+	refscale.readdelay= [KNL]
 			Set the read-side critical-section duration,
 			measured in microseconds.
 
-	refperf.shutdown= [KNL]
+	refscale.scale_type= [KNL]
+			Specify the read-protection implementation to test.
+
+	refscale.shutdown= [KNL]
 			Shut down the system at the end of the performance
 			test.  This defaults to 1 (shut it down) when
 			rcuperf is built into the kernel and to 0 (leave
 			it running) when rcuperf is built as a module.
 
-	refperf.verbose= [KNL]
+	refscale.verbose= [KNL]
 			Enable additional printk() statements.
 
 	relax_domain_level=
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 45d562d..95f5117 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
-obj-$(CONFIG_RCU_REF_SCALE_TEST) += refperf.o
+obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refscale.c
similarity index 74%
rename from kernel/rcu/refperf.c
rename to kernel/rcu/refscale.c
index 7c98057..d9291f8 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refscale.c
@@ -38,23 +38,23 @@
 
 #include "rcu.h"
 
-#define PERF_FLAG "-ref-perf: "
+#define SCALE_FLAG "-ref-scale: "
 
-#define PERFOUT(s, x...) \
-	pr_alert("%s" PERF_FLAG s, perf_type, ## x)
+#define SCALEOUT(s, x...) \
+	pr_alert("%s" SCALE_FLAG s, scale_type, ## x)
 
-#define VERBOSE_PERFOUT(s, x...) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG s, perf_type, ## x); } while (0)
+#define VERBOSE_SCALEOUT(s, x...) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG s, scale_type, ## x); } while (0)
 
-#define VERBOSE_PERFOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG "!!! " s, perf_type, ## x); } while (0)
+#define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
 
-static char *perf_type = "rcu";
-module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
+static char *scale_type = "rcu";
+module_param(scale_type, charp, 0444);
+MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 
@@ -71,13 +71,13 @@ torture_param(int, nruns, 30, "Number of experiments to run.");
 torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
 
 #ifdef MODULE
-# define REFPERF_SHUTDOWN 0
+# define REFSCALE_SHUTDOWN 0
 #else
-# define REFPERF_SHUTDOWN 1
+# define REFSCALE_SHUTDOWN 1
 #endif
 
-torture_param(bool, shutdown, REFPERF_SHUTDOWN,
-	      "Shutdown at end of performance tests.");
+torture_param(bool, shutdown, REFSCALE_SHUTDOWN,
+	      "Shutdown at end of scalability tests.");
 
 struct reader_task {
 	struct task_struct *task;
@@ -108,7 +108,7 @@ static atomic_t n_cooleddown;
 static int exp_idx;
 
 // Operations vector for selecting different types of tests.
-struct ref_perf_ops {
+struct ref_scale_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
@@ -116,7 +116,7 @@ struct ref_perf_ops {
 	const char *name;
 };
 
-static struct ref_perf_ops *cur_ops;
+static struct ref_scale_ops *cur_ops;
 
 static void un_delay(const int udl, const int ndl)
 {
@@ -147,22 +147,22 @@ static void ref_rcu_delay_section(const int nloops, const int udl, const int ndl
 	}
 }
 
-static void rcu_sync_perf_init(void)
+static void rcu_sync_scale_init(void)
 {
 }
 
-static struct ref_perf_ops rcu_ops = {
-	.init		= rcu_sync_perf_init,
+static struct ref_scale_ops rcu_ops = {
+	.init		= rcu_sync_scale_init,
 	.readsection	= ref_rcu_read_section,
 	.delaysection	= ref_rcu_delay_section,
 	.name		= "rcu"
 };
 
-// Definitions for SRCU ref perf testing.
-DEFINE_STATIC_SRCU(srcu_refctl_perf);
-static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
+// Definitions for SRCU ref scale testing.
+DEFINE_STATIC_SRCU(srcu_refctl_scale);
+static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
 
-static void srcu_ref_perf_read_section(const int nloops)
+static void srcu_ref_scale_read_section(const int nloops)
 {
 	int i;
 	int idx;
@@ -173,7 +173,7 @@ static void srcu_ref_perf_read_section(const int nloops)
 	}
 }
 
-static void srcu_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+static void srcu_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 	int idx;
@@ -185,16 +185,16 @@ static void srcu_ref_perf_delay_section(const int nloops, const int udl, const i
 	}
 }
 
-static struct ref_perf_ops srcu_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= srcu_ref_perf_read_section,
-	.delaysection	= srcu_ref_perf_delay_section,
+static struct ref_scale_ops srcu_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_ref_scale_read_section,
+	.delaysection	= srcu_ref_scale_delay_section,
 	.name		= "srcu"
 };
 
-// Definitions for RCU Tasks ref perf testing: Empty read markers.
+// Definitions for RCU Tasks ref scale testing: Empty read markers.
 // These definitions also work for RCU Rude readers.
-static void rcu_tasks_ref_perf_read_section(const int nloops)
+static void rcu_tasks_ref_scale_read_section(const int nloops)
 {
 	int i;
 
@@ -202,7 +202,7 @@ static void rcu_tasks_ref_perf_read_section(const int nloops)
 		continue;
 }
 
-static void rcu_tasks_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+static void rcu_tasks_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
@@ -210,15 +210,15 @@ static void rcu_tasks_ref_perf_delay_section(const int nloops, const int udl, co
 		un_delay(udl, ndl);
 }
 
-static struct ref_perf_ops rcu_tasks_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= rcu_tasks_ref_perf_read_section,
-	.delaysection	= rcu_tasks_ref_perf_delay_section,
+static struct ref_scale_ops rcu_tasks_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= rcu_tasks_ref_scale_read_section,
+	.delaysection	= rcu_tasks_ref_scale_delay_section,
 	.name		= "rcu-tasks"
 };
 
-// Definitions for RCU Tasks Trace ref perf testing.
-static void rcu_trace_ref_perf_read_section(const int nloops)
+// Definitions for RCU Tasks Trace ref scale testing.
+static void rcu_trace_ref_scale_read_section(const int nloops)
 {
 	int i;
 
@@ -228,7 +228,7 @@ static void rcu_trace_ref_perf_read_section(const int nloops)
 	}
 }
 
-static void rcu_trace_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+static void rcu_trace_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
@@ -239,10 +239,10 @@ static void rcu_trace_ref_perf_delay_section(const int nloops, const int udl, co
 	}
 }
 
-static struct ref_perf_ops rcu_trace_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= rcu_trace_ref_perf_read_section,
-	.delaysection	= rcu_trace_ref_perf_delay_section,
+static struct ref_scale_ops rcu_trace_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= rcu_trace_ref_scale_read_section,
+	.delaysection	= rcu_trace_ref_scale_delay_section,
 	.name		= "rcu-trace"
 };
 
@@ -270,8 +270,8 @@ static void ref_refcnt_delay_section(const int nloops, const int udl, const int
 	}
 }
 
-static struct ref_perf_ops refcnt_ops = {
-	.init		= rcu_sync_perf_init,
+static struct ref_scale_ops refcnt_ops = {
+	.init		= rcu_sync_scale_init,
 	.readsection	= ref_refcnt_section,
 	.delaysection	= ref_refcnt_delay_section,
 	.name		= "refcnt"
@@ -306,7 +306,7 @@ static void ref_rwlock_delay_section(const int nloops, const int udl, const int
 	}
 }
 
-static struct ref_perf_ops rwlock_ops = {
+static struct ref_scale_ops rwlock_ops = {
 	.init		= ref_rwlock_init,
 	.readsection	= ref_rwlock_section,
 	.delaysection	= ref_rwlock_delay_section,
@@ -342,14 +342,14 @@ static void ref_rwsem_delay_section(const int nloops, const int udl, const int n
 	}
 }
 
-static struct ref_perf_ops rwsem_ops = {
+static struct ref_scale_ops rwsem_ops = {
 	.init		= ref_rwsem_init,
 	.readsection	= ref_rwsem_section,
 	.delaysection	= ref_rwsem_delay_section,
 	.name		= "rwsem"
 };
 
-static void rcu_perf_one_reader(void)
+static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
 		cur_ops->readsection(loops);
@@ -360,7 +360,7 @@ static void rcu_perf_one_reader(void)
 // Reader kthread.  Repeatedly does empty RCU read-side
 // critical section, minimizing update-side interference.
 static int
-ref_perf_reader(void *arg)
+ref_scale_reader(void *arg)
 {
 	unsigned long flags;
 	long me = (long)arg;
@@ -368,14 +368,14 @@ ref_perf_reader(void *arg)
 	u64 start;
 	s64 duration;
 
-	VERBOSE_PERFOUT("ref_perf_reader %ld: task started", me);
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: task started", me);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_init);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 repeat:
-	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
 	// Wait for signal that this reader can start.
 	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
@@ -392,21 +392,21 @@ ref_perf_reader(void *arg)
 		while (atomic_read_acquire(&n_started))
 			cpu_relax();
 
-	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d started", me, exp_idx);
 
 
 	// To reduce noise, do an initial cache-warming invocation, check
 	// in, and then keep warming until everyone has checked in.
-	rcu_perf_one_reader();
+	rcu_scale_one_reader();
 	if (!atomic_dec_return(&n_warmedup))
 		while (atomic_read_acquire(&n_warmedup))
-			rcu_perf_one_reader();
+			rcu_scale_one_reader();
 	// Also keep interrupts disabled.  This also has the effect
 	// of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
-	rcu_perf_one_reader();
+	rcu_scale_one_reader();
 
 	duration = ktime_get_mono_fast_ns() - start;
 	local_irq_restore(flags);
@@ -416,18 +416,18 @@ ref_perf_reader(void *arg)
 	// everyone is done.
 	if (!atomic_dec_return(&n_cooleddown))
 		while (atomic_read_acquire(&n_cooleddown))
-			rcu_perf_one_reader();
+			rcu_scale_one_reader();
 
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
 
-	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d ended, (readers remaining=%d)",
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d ended, (readers remaining=%d)",
 			me, exp_idx, atomic_read(&nreaders_exp));
 
 	if (!torture_must_stop())
 		goto repeat;
 end:
-	torture_kthread_stopping("ref_perf_reader");
+	torture_kthread_stopping("ref_scale_reader");
 	return 0;
 }
 
@@ -471,7 +471,7 @@ static u64 process_durations(int n)
 	}
 	strcat(buf, "\n");
 
-	PERFOUT("%s\n", buf);
+	SCALEOUT("%s\n", buf);
 
 	kfree(buf);
 	return sum;
@@ -494,11 +494,11 @@ static int main_func(void *arg)
 	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 
-	VERBOSE_PERFOUT("main_func task started");
+	VERBOSE_SCALEOUT("main_func task started");
 	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
 	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
 	if (!result_avg || !buf) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		errexit = true;
 	}
 	if (holdoff)
@@ -529,13 +529,13 @@ static int main_func(void *arg)
 			wake_up(&reader_tasks[r].wq);
 		}
 
-		VERBOSE_PERFOUT("main_func: experiment started, waiting for %d readers",
+		VERBOSE_SCALEOUT("main_func: experiment started, waiting for %d readers",
 				nreaders);
 
 		wait_event(main_wq,
 			   !atomic_read(&nreaders_exp) || torture_must_stop());
 
-		VERBOSE_PERFOUT("main_func: experiment ended");
+		VERBOSE_SCALEOUT("main_func: experiment ended");
 
 		if (torture_must_stop())
 			goto end;
@@ -544,7 +544,7 @@ static int main_func(void *arg)
 	}
 
 	// Print the average of all experiments
-	PERFOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
+	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
 
 	buf[0] = 0;
 	strcat(buf, "\n");
@@ -562,7 +562,7 @@ static int main_func(void *arg)
 	}
 
 	if (!errexit)
-		PERFOUT("%s", buf);
+		SCALEOUT("%s", buf);
 
 	// This will shutdown everything including us.
 	if (shutdown) {
@@ -582,15 +582,15 @@ static int main_func(void *arg)
 }
 
 static void
-ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
+ref_scale_print_module_parms(struct ref_scale_ops *cur_ops, const char *tag)
 {
-	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", perf_type, tag,
+	pr_alert("%s" SCALE_FLAG
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
 		 verbose, shutdown, holdoff, loops, nreaders, nruns, readdelay);
 }
 
 static void
-ref_perf_cleanup(void)
+ref_scale_cleanup(void)
 {
 	int i;
 
@@ -604,7 +604,7 @@ ref_perf_cleanup(void)
 
 	if (reader_tasks) {
 		for (i = 0; i < nreaders; i++)
-			torture_stop_kthread("ref_perf_reader",
+			torture_stop_kthread("ref_scale_reader",
 					     reader_tasks[i].task);
 	}
 	kfree(reader_tasks);
@@ -612,7 +612,7 @@ ref_perf_cleanup(void)
 	torture_stop_kthread("main_task", main_task);
 	kfree(main_task);
 
-	// Do perf-type-specific cleanup operations.
+	// Do scale-type-specific cleanup operations.
 	if (cur_ops->cleanup != NULL)
 		cur_ops->cleanup();
 
@@ -621,40 +621,40 @@ ref_perf_cleanup(void)
 
 // Shutdown kthread.  Just waits to be awakened, then shuts down system.
 static int
-ref_perf_shutdown(void *arg)
+ref_scale_shutdown(void *arg)
 {
 	wait_event(shutdown_wq, shutdown_start);
 
 	smp_mb(); // Wake before output.
-	ref_perf_cleanup();
+	ref_scale_cleanup();
 	kernel_power_off();
 
 	return -EINVAL;
 }
 
 static int __init
-ref_perf_init(void)
+ref_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
-	static struct ref_perf_ops *perf_ops[] = {
+	static struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
 		&refcnt_ops, &rwlock_ops, &rwsem_ops,
 	};
 
-	if (!torture_init_begin(perf_type, verbose))
+	if (!torture_init_begin(scale_type, verbose))
 		return -EBUSY;
 
-	for (i = 0; i < ARRAY_SIZE(perf_ops); i++) {
-		cur_ops = perf_ops[i];
-		if (strcmp(perf_type, cur_ops->name) == 0)
+	for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
+		cur_ops = scale_ops[i];
+		if (strcmp(scale_type, cur_ops->name) == 0)
 			break;
 	}
-	if (i == ARRAY_SIZE(perf_ops)) {
-		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
-		pr_alert("rcu-perf types:");
-		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
-			pr_cont(" %s", perf_ops[i]->name);
+	if (i == ARRAY_SIZE(scale_ops)) {
+		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
+		pr_alert("rcu-scale types:");
+		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
+			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
 		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		firsterr = -EINVAL;
@@ -664,12 +664,12 @@ ref_perf_init(void)
 	if (cur_ops->init)
 		cur_ops->init();
 
-	ref_perf_print_module_parms(cur_ops, "Start of test");
+	ref_scale_print_module_parms(cur_ops, "Start of test");
 
 	// Shutdown task
 	if (shutdown) {
 		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(ref_perf_shutdown, NULL,
+		firsterr = torture_create_kthread(ref_scale_shutdown, NULL,
 						  shutdown_task);
 		if (firsterr)
 			goto unwind;
@@ -682,15 +682,15 @@ ref_perf_init(void)
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
 
-	VERBOSE_PERFOUT("Starting %d reader threads\n", nreaders);
+	VERBOSE_SCALEOUT("Starting %d reader threads\n", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
-		firsterr = torture_create_kthread(ref_perf_reader, (void *)i,
+		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
 		if (firsterr)
 			goto unwind;
@@ -709,9 +709,9 @@ ref_perf_init(void)
 
 unwind:
 	torture_init_end();
-	ref_perf_cleanup();
+	ref_scale_cleanup();
 	return firsterr;
 }
 
-module_init(ref_perf_init);
-module_exit(ref_perf_cleanup);
+module_init(ref_scale_init);
+module_exit(ref_scale_cleanup);
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
index 489f05d..321e826 100644
--- a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
@@ -11,6 +11,6 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 refperf.shutdown=1 \
-		refperf.verbose=1
+	echo $1 refscale.shutdown=1 \
+		refscale.verbose=1
 }
-- 
2.9.5

