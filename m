Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F4C55178
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6202222228
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620047;
	bh=y/nQUu7DftXrkz9/3qhWkgwN3KtlVyLbRYefFO0/Wwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SOfqRDe+C0hE180OLaez5HsNtjzKdVxaFRhgDkSsjLkZoEyUxoo7TAdJ/nv5YR/P5
	 pBP+9zXWMXLmynX7zYvBtqdWC7BlOV21pIJBWPgDSJQM96dHF1EGSMsvkIG4mRso7O
	 GF0bsR6tdPeYheMOue8ELZLUEZnp8U7040KDtJlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgKEXr0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732625AbgKEXrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1380C2083B;
        Thu,  5 Nov 2020 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620044;
        bh=y/nQUu7DftXrkz9/3qhWkgwN3KtlVyLbRYefFO0/Wwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6xLovhunqDOPYx3+fRcU2Em2PPStLlAZu899D98hGrTQH3dEAraeErs9fhQUj884
         nIWqgtl8Rx+6bgtFV+AIQ+GLNj3uCLrYlS8oSvrgNazzvwBCdMkdHn6+T08x1zxazm
         kysg1jGYFTMiK+nsB6WjOpN38FjUE6gNKpvUdpvs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/28] scftorture: Add an alternative IPI vector
Date:   Thu,  5 Nov 2020 15:46:57 -0800
Message-Id: <20201105234719.23307-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The scftorture tests currently use only smp_call_function() and
friends, which means that these tests cannot locate bugs caused by
interactions between different IPI vectors.  This commit therefore adds
the rescheduling IPI to the mix.

Note that this commit permits resched_cpus() only when scftorture is
built in.  This is a workaround.  Longer term, this will use real wakeups
rather than resched_cpu().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 554a521..3fbb7a7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -62,6 +62,7 @@ torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s
 torture_param(int, stutter_cpus, 5, "Number of jiffies to change CPUs under test, 0=disable");
 torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU hotplug.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+torture_param(int, weight_resched, -1, "Testing weight for resched_cpu() operations.");
 torture_param(int, weight_single, -1, "Testing weight for single-CPU no-wait operations.");
 torture_param(int, weight_single_wait, -1, "Testing weight for single-CPU operations.");
 torture_param(int, weight_many, -1, "Testing weight for multi-CPU no-wait operations.");
@@ -82,6 +83,7 @@ torture_param(bool, shutdown, SCFTORT_SHUTDOWN, "Shutdown at end of torture test
 struct scf_statistics {
 	struct task_struct *task;
 	int cpu;
+	long long n_resched;
 	long long n_single;
 	long long n_single_ofl;
 	long long n_single_wait;
@@ -97,12 +99,15 @@ static struct task_struct *scf_torture_stats_task;
 static DEFINE_PER_CPU(long long, scf_invoked_count);
 
 // Data for random primitive selection
-#define SCF_PRIM_SINGLE		0
-#define SCF_PRIM_MANY		1
-#define SCF_PRIM_ALL		2
-#define SCF_NPRIMS		(2 * 3) // Need wait and no-wait versions of each.
+#define SCF_PRIM_RESCHED	0
+#define SCF_PRIM_SINGLE		1
+#define SCF_PRIM_MANY		2
+#define SCF_PRIM_ALL		3
+#define SCF_NPRIMS		7 // Need wait and no-wait versions of each,
+				  //  except for SCF_PRIM_RESCHED.
 
 static char *scf_prim_name[] = {
+	"resched_cpu",
 	"smp_call_function_single",
 	"smp_call_function_many",
 	"smp_call_function",
@@ -136,6 +141,8 @@ static char *bangstr = "";
 
 static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
+extern void resched_cpu(int cpu); // An alternative IPI vector.
+
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
 {
@@ -148,6 +155,7 @@ static void scf_torture_stats_print(void)
 	for_each_possible_cpu(cpu)
 		invoked_count += data_race(per_cpu(scf_invoked_count, cpu));
 	for (i = 0; i < nthreads; i++) {
+		scfs.n_resched += scf_stats_p[i].n_resched;
 		scfs.n_single += scf_stats_p[i].n_single;
 		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
 		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
@@ -160,8 +168,8 @@ static void scf_torture_stats_print(void)
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
 	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
 		bangstr = "!!! ";
-	pr_alert("%s %sscf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
-		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count,
+	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
 		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
 		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
@@ -314,6 +322,13 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 	}
 	switch (scfsp->scfs_prim) {
+	case SCF_PRIM_RESCHED:
+		if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST)) {
+			cpu = torture_random(trsp) % nr_cpu_ids;
+			scfp->n_resched++;
+			resched_cpu(cpu);
+		}
+		break;
 	case SCF_PRIM_SINGLE:
 		cpu = torture_random(trsp) % nr_cpu_ids;
 		if (scfsp->scfs_wait)
@@ -433,8 +448,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -475,6 +490,7 @@ static int __init scf_torture_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long weight_resched1 = weight_resched;
 	unsigned long weight_single1 = weight_single;
 	unsigned long weight_single_wait1 = weight_single_wait;
 	unsigned long weight_many1 = weight_many;
@@ -487,9 +503,10 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
-	if (weight_single == -1 && weight_single_wait == -1 &&
+	if (weight_resched == -1 && weight_single == -1 && weight_single_wait == -1 &&
 	    weight_many == -1 && weight_many_wait == -1 &&
 	    weight_all == -1 && weight_all_wait == -1) {
+		weight_resched1 = 2 * nr_cpu_ids;
 		weight_single1 = 2 * nr_cpu_ids;
 		weight_single_wait1 = 2 * nr_cpu_ids;
 		weight_many1 = 2;
@@ -497,6 +514,8 @@ static int __init scf_torture_init(void)
 		weight_all1 = 1;
 		weight_all_wait1 = 1;
 	} else {
+		if (weight_resched == -1)
+			weight_resched1 = 0;
 		if (weight_single == -1)
 			weight_single1 = 0;
 		if (weight_single_wait == -1)
@@ -517,6 +536,10 @@ static int __init scf_torture_init(void)
 		firsterr = -EINVAL;
 		goto unwind;
 	}
+	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
+		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
+	else if (weight_resched1)
+		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
 	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
 	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
 	scf_sel_add(weight_many1, SCF_PRIM_MANY, false);
-- 
2.9.5

