Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00D4C433E7
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED3720866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897367;
	bh=eyTlLD1KRWCiaX2+cwpRdocJf4AkKSbW/G4T5Ltc994=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjKnryWyvFn0UJ99htDZAke99jOP71fD/RnqcTbcax/cI3bf5CMNLGGni7xuIHenb
	 vJ7vJbMjFSCvJvMJk+ZjQlRdJbcFcuO3sF8yx0MNLXP1Xqo/29RXj4QHFtU7nHrQVj
	 iagI9k3DAMrj67yLF/2tkVv6YQpOO8ngy+fhSQ1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgHaSJY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgHaSHw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:52 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718022151B;
        Mon, 31 Aug 2020 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897272;
        bh=eyTlLD1KRWCiaX2+cwpRdocJf4AkKSbW/G4T5Ltc994=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFqFS2cNTf2hmor+jyIuHJZGCwDXX1hv3u+rQIllJ7gSLLkAFDSMTB0Cc5zI92Z70
         DOh59ryYk3YND8DvMZAy2uPs0bx6XqVUixT1fjoCmZ1y91GuzkL2POta1oA+dZsrA7
         ycFxIiCz0SDT5bCXoTsJiwyeud2/K1Uh0VFxfkPE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/19] scftorture: Implement weighted primitive selection
Date:   Mon, 31 Aug 2020 11:07:34 -0700
Message-Id: <20200831180749.843-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit uses the scftorture.weight* kernel parameters to randomly
chooses between smp_call_function_single(), smp_call_function_many(),
and smp_call_function().  For each variant, it also randomly chooses
whether to invoke it synchronously (wait=1) or asynchronously (wait=0).
The percentage weighting for each option are dumped to the console log
(search for "scf_sel_dump").

This accumulates statistics, which a later commit will dump out at the
end of the run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 182 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 155 insertions(+), 27 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 44f1e49..5f19845 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -64,8 +64,8 @@ torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, weight_single, -1, "Testing weight for single-CPU no-wait operations.");
 torture_param(int, weight_single_wait, -1, "Testing weight for single-CPU operations.");
-torture_param(int, weight_mult, -1, "Testing weight for multi-CPU no-wait operations.");
-torture_param(int, weight_mult_wait, -1, "Testing weight for multi-CPU operations.");
+torture_param(int, weight_many, -1, "Testing weight for multi-CPU no-wait operations.");
+torture_param(int, weight_many_wait, -1, "Testing weight for multi-CPU operations.");
 torture_param(int, weight_all, -1, "Testing weight for all-CPU no-wait operations.");
 torture_param(int, weight_all_wait, -1, "Testing weight for all-CPU operations.");
 
@@ -83,9 +83,11 @@ struct scf_statistics {
 	struct task_struct *task;
 	int cpu;
 	long long n_single;
+	long long n_single_ofl;
 	long long n_single_wait;
-	long long n_multi;
-	long long n_multi_wait;
+	long long n_single_wait_ofl;
+	long long n_many;
+	long long n_many_wait;
 	long long n_all;
 	long long n_all_wait;
 };
@@ -94,6 +96,27 @@ static struct scf_statistics *scf_stats_p;
 static struct task_struct *scf_torture_stats_task;
 static DEFINE_PER_CPU(long long, scf_invoked_count);
 
+// Data for random primitive selection
+#define SCF_PRIM_SINGLE		0
+#define SCF_PRIM_MANY		1
+#define SCF_PRIM_ALL		2
+#define SCF_NPRIMS		(2 * 3) // Need wait and no-wait versions of each.
+
+static char *scf_prim_name[] = {
+	"smp_call_function_single",
+	"smp_call_function_many",
+	"smp_call_function",
+};
+
+struct scf_selector {
+	unsigned long scfs_weight;
+	int scfs_prim;
+	bool scfs_wait;
+};
+static struct scf_selector scf_sel_array[SCF_NPRIMS];
+static int scf_sel_array_len;
+static unsigned long scf_sel_totweight;
+
 // Use to wait for all threads to start.
 static atomic_t n_started;
 static atomic_t n_errs;
@@ -131,6 +154,57 @@ scf_torture_stats(void *arg)
 	return 0;
 }
 
+// Add a primitive to the scf_sel_array[].
+static void scf_sel_add(unsigned long weight, int prim, bool wait)
+{
+	struct scf_selector *scfsp = &scf_sel_array[scf_sel_array_len];
+
+	// If no weight, if array would overflow, if computing three-place
+	// percentages would overflow, or if the scf_prim_name[] array would
+	// overflow, don't bother.  In the last three two cases, complain.
+	if (!weight ||
+	    WARN_ON_ONCE(scf_sel_array_len >= ARRAY_SIZE(scf_sel_array)) ||
+	    WARN_ON_ONCE(0 - 100000 * weight <= 100000 * scf_sel_totweight) ||
+	    WARN_ON_ONCE(prim >= ARRAY_SIZE(scf_prim_name)))
+		return;
+	scf_sel_totweight += weight;
+	scfsp->scfs_weight = scf_sel_totweight;
+	scfsp->scfs_prim = prim;
+	scfsp->scfs_wait = wait;
+	scf_sel_array_len++;
+}
+
+// Dump out weighting percentages for scf_prim_name[] array.
+static void scf_sel_dump(void)
+{
+	int i;
+	unsigned long oldw = 0;
+	struct scf_selector *scfsp;
+	unsigned long w;
+
+	for (i = 0; i < scf_sel_array_len; i++) {
+		scfsp = &scf_sel_array[i];
+		w = (scfsp->scfs_weight - oldw) * 100000 / scf_sel_totweight;
+		pr_info("%s: %3lu.%03lu %s(%s)\n", __func__, w / 1000, w % 1000,
+			scf_prim_name[scfsp->scfs_prim],
+			scfsp->scfs_wait ? "wait" : "nowait");
+		oldw = scfsp->scfs_weight;
+	}
+}
+
+// Randomly pick a primitive and wait/nowait, based on weightings.
+static struct scf_selector *scf_sel_rand(struct torture_random_state *trsp)
+{
+	int i;
+	unsigned long w = torture_random(trsp) % (scf_sel_totweight + 1);
+
+	for (i = 0; i < scf_sel_array_len; i++)
+		if (scf_sel_array[i].scfs_weight >= w)
+			return &scf_sel_array[i];
+	WARN_ON_ONCE(1);
+	return &scf_sel_array[0];
+}
+
 // Update statistics and occasionally burn up mass quantities of CPU time,
 // if told to do so via scftorture.longwait.  Otherwise, occasionally burn
 // a little bit.
@@ -162,15 +236,55 @@ static void scf_handler(void *unused)
 	}
 }
 
+// As above, but check for correct CPU.
+static void scf_handler_1(void *me)
+{
+	if (WARN_ON_ONCE(smp_processor_id() != (uintptr_t)me))
+		atomic_inc(&n_errs);
+	scf_handler(NULL);
+}
+
 // Randomly do an smp_call_function*() invocation.
-static void scftorture_invoke_one(struct scf_statistics *scfp,struct torture_random_state *trsp)
+static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_random_state *trsp)
 {
+	uintptr_t cpu;
+	int ret;
+	struct scf_selector *scfsp = scf_sel_rand(trsp);
+
 	if (use_cpus_read_lock)
 		cpus_read_lock();
 	else
 		preempt_disable();
-	scfp->n_all++;
-	smp_call_function(scf_handler, NULL, 0);
+	switch (scfsp->scfs_prim) {
+	case SCF_PRIM_SINGLE:
+		cpu = torture_random(trsp) % nr_cpu_ids;
+		if (scfsp->scfs_wait)
+			scfp->n_single_wait++;
+		else
+			scfp->n_single++;
+		ret = smp_call_function_single(cpu, scf_handler_1, (void *)cpu, scfsp->scfs_wait);
+		if (ret) {
+			if (scfsp->scfs_wait)
+				scfp->n_single_wait_ofl++;
+			else
+				scfp->n_single_ofl++;
+		}
+		break;
+	case SCF_PRIM_MANY:
+		if (scfsp->scfs_wait)
+			scfp->n_many_wait++;
+		else
+			scfp->n_many++;
+		smp_call_function_many(cpu_online_mask, scf_handler, NULL, scfsp->scfs_wait);
+		break;
+	case SCF_PRIM_ALL:
+		if (scfsp->scfs_wait)
+			scfp->n_all_wait++;
+		else
+			scfp->n_all++;
+		smp_call_function(scf_handler, NULL, scfsp->scfs_wait);
+		break;
+	}
 	if (use_cpus_read_lock)
 		cpus_read_unlock();
 	else
@@ -222,8 +336,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_single=%d, weight_single_wait=%d, weight_mult=%d, weight_mult_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_single, weight_single_wait, weight_mult, weight_mult_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -264,6 +378,12 @@ static int __init scf_torture_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long weight_single1 = weight_single;
+	unsigned long weight_single_wait1 = weight_single_wait;
+	unsigned long weight_many1 = weight_many;
+	unsigned long weight_many_wait1 = weight_many_wait;
+	unsigned long weight_all1 = weight_all;
+	unsigned long weight_all_wait1 = weight_all_wait;
 
 	if (!torture_init_begin(SCFTORT_STRING, verbose))
 		return -EBUSY;
@@ -271,34 +391,42 @@ static int __init scf_torture_init(void)
 	scftorture_print_module_parms("Start of test");
 
 	if (weight_single == -1 && weight_single_wait == -1 &&
-	    weight_mult == -1 && weight_mult_wait == -1 &&
+	    weight_many == -1 && weight_many_wait == -1 &&
 	    weight_all == -1 && weight_all_wait == -1) {
-		weight_single = 1;
-		weight_single_wait = 1;
-		weight_mult = 1;
-		weight_mult_wait = 1;
-		weight_all = 1;
-		weight_all_wait = 1;
+		weight_single1 = 2 * nr_cpu_ids;
+		weight_single_wait1 = 2 * nr_cpu_ids;
+		weight_many1 = 2;
+		weight_many_wait1 = 2;
+		weight_all1 = 1;
+		weight_all_wait1 = 1;
 	} else {
 		if (weight_single == -1)
-			weight_single = 0;
+			weight_single1 = 0;
 		if (weight_single_wait == -1)
-			weight_single_wait = 0;
-		if (weight_mult == -1)
-			weight_mult = 0;
-		if (weight_mult_wait == -1)
-			weight_mult_wait = 0;
+			weight_single_wait1 = 0;
+		if (weight_many == -1)
+			weight_many1 = 0;
+		if (weight_many_wait == -1)
+			weight_many_wait1 = 0;
 		if (weight_all == -1)
-			weight_all = 0;
+			weight_all1 = 0;
 		if (weight_all_wait == -1)
-			weight_all_wait = 0;
+			weight_all_wait1 = 0;
 	}
-	if (weight_single == 0 && weight_single_wait == 0 &&
-	    weight_mult == 0 && weight_mult_wait == 0 &&
-	    weight_all == 0 && weight_all_wait == 0) {
+	if (weight_single1 == 0 && weight_single_wait1 == 0 &&
+	    weight_many1 == 0 && weight_many_wait1 == 0 &&
+	    weight_all1 == 0 && weight_all_wait1 == 0) {
+		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
+	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
+	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
+	scf_sel_add(weight_many1, SCF_PRIM_MANY, false);
+	scf_sel_add(weight_many_wait1, SCF_PRIM_MANY, true);
+	scf_sel_add(weight_all1, SCF_PRIM_ALL, false);
+	scf_sel_add(weight_all_wait1, SCF_PRIM_ALL, true);
+	scf_sel_dump();
 
 	if (onoff_interval > 0) {
 		firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval, NULL);
-- 
2.9.5

