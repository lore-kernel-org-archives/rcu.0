Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF51FC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9562C2076A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872219;
	bh=kkf7hBk38m11H7Jm7Ph9zeN1X/tTO+yi+kRJcVzc834=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQ19x00We397J98yEvj6YcttmLaE+g9Jm3nPoGFQUQZCCEkjfrmTOupPJZ/zH4wPb
	 Fd0qUDxcu/LV6UUk5qSpk7b+BCOeJjp1gvXUKg2QsqTSWCtKOfgx9rCZDWevVsrDIm
	 ZdKZYDpKPkgQzk2QE2+qxz2hP0kQckD+Mg9rs3r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgFWAaT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731646AbgFWAaR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01EED20809;
        Tue, 23 Jun 2020 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872217;
        bh=kkf7hBk38m11H7Jm7Ph9zeN1X/tTO+yi+kRJcVzc834=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoaxKCHF4sSDSwE5wfFChHO9H0qsVHQtxDyZlhsd39ipFv9sm1L+afiQ4T6z5oRGS
         xyT5bCfSlN8oCSmNARiEROTCkV/xkZKjTm4DYoCcXpOjjkwC97ZADnNHrYdxRGdmc7
         9Z3gyQxFdTU9fBDQSsDlVabYQ/6pk7ot+nkCyX+k=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/30] refperf: Provide module parameter to specify number of experiments
Date:   Mon, 22 Jun 2020 17:29:52 -0700
Message-Id: <20200623003013.26252-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The current code uses the number of threads both to limit the number
of threads and to specify the number of experiments, but also varies
the number of threads as the experiments progress.  This commit takes
a different approach by adding an refperf.nruns module parameter that
specifies the number of experiments, and furthermore uses the same
number of threads for each experiment.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 020e55a..6324449 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -83,12 +83,6 @@ struct reader_task {
 	atomic_t start;
 	wait_queue_head_t wq;
 	u64 last_duration_ns;
-
-	// The average latency When 1..<this reader> are concurrently
-	// running an experiment. For example, if this reader_task is
-	// of index 5 in the reader_tasks array, then result is for
-	// 6 cores.
-	u64 result_avg;
 };
 
 static struct task_struct *shutdown_task;
@@ -289,12 +283,12 @@ ref_perf_reader(void *arg)
 	return 0;
 }
 
-void reset_readers(int n)
+void reset_readers(void)
 {
 	int i;
 	struct reader_task *rt;
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < nreaders; i++) {
 		rt = &(reader_tasks[i]);
 
 		rt->last_duration_ns = 0;
@@ -314,7 +308,7 @@ u64 process_durations(int n)
 	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
 		exp_idx);
 
-	for (i = 0; i <= n && !torture_must_stop(); i++) {
+	for (i = 0; i < n && !torture_must_stop(); i++) {
 		rt = &(reader_tasks[i]);
 		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
 
@@ -342,11 +336,15 @@ static int main_func(void *arg)
 	int exp, r;
 	char buf1[64];
 	char buf[512];
+	u64 *result_avg;
 
 	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 
 	VERBOSE_PERFOUT("main_func task started");
+	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
+	if (!result_avg)
+		VERBOSE_PERFOUT_ERRSTRING("out of memory");
 	atomic_inc(&n_init);
 
 	// Wait for all threads to start.
@@ -355,22 +353,24 @@ static int main_func(void *arg)
 		schedule_timeout_interruptible(holdoff * HZ);
 
 	// Start exp readers up per experiment
-	for (exp = 0; exp < nreaders && !torture_must_stop(); exp++) {
+	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
+		if (!result_avg)
+			break;
 		if (torture_must_stop())
 			goto end;
 
-		reset_readers(exp);
-		atomic_set(&nreaders_exp, exp + 1);
+		reset_readers();
+		atomic_set(&nreaders_exp, nreaders);
 
 		exp_idx = exp;
 
-		for (r = 0; r <= exp; r++) {
+		for (r = 0; r < nreaders; r++) {
 			atomic_set(&reader_tasks[r].start, 1);
 			wake_up(&reader_tasks[r].wq);
 		}
 
 		VERBOSE_PERFOUT("main_func: experiment started, waiting for %d readers",
-				exp);
+				nreaders);
 
 		wait_event(main_wq,
 			   !atomic_read(&nreaders_exp) || torture_must_stop());
@@ -380,7 +380,7 @@ static int main_func(void *arg)
 		if (torture_must_stop())
 			goto end;
 
-		reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
+		result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);
 	}
 
 	// Print the average of all experiments
@@ -390,12 +390,15 @@ static int main_func(void *arg)
 	strcat(buf, "\n");
 	strcat(buf, "Threads\tTime(ns)\n");
 
-	for (exp = 0; exp < nreaders; exp++) {
-		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, reader_tasks[exp].result_avg / 1000, (int)(reader_tasks[exp].result_avg % 1000));
+	for (exp = 0; exp < nruns; exp++) {
+		if (!result_avg)
+			break;
+		sprintf(buf1, "%d\t%llu.%03d\n", exp + 1, result_avg[exp] / 1000, (int)(result_avg[exp] % 1000));
 		strcat(buf, buf1);
 	}
 
-	PERFOUT("%s", buf);
+	if (result_avg)
+		PERFOUT("%s", buf);
 
 	// This will shutdown everything including us.
 	if (shutdown) {
@@ -416,8 +419,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops, nreaders);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders, nruns);
 }
 
 static void
-- 
2.9.5

