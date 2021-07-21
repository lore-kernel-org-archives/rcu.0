Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D75C6377C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC21613CF
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 21:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhGUUYK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 16:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhGUUYH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 16:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CE5C613F9;
        Wed, 21 Jul 2021 21:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626901483;
        bh=P6H4/q8Jcku/r9cqoAqpvUci1dTZhmdzV4BQu+y+VuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjvRqCQmVIUXg2TUj8f6+rvcgHYRTY2ndmCX8W6X1qdwvwR7kjyAtmu/+Usi4J8o4
         gG0KJyOgu6GbsYmO0hecIiyyByKO7P7KDbx1lqX3zmuFoPQtcsDWA28b4p+I8AvIS0
         6uH1BKVZARiU0kRhejU6/x8QpgnP8KZQJv7reDIXficxpLqb17D1WSsPlKLwOf6Pjk
         0qNMeFrdDYM+NCHv75IN1W3hgTnxhYjenXKfYsa2w9RaAZajlYWTeQTk5JVGkuJm4O
         GhD91fm+YNZjAWMED9Uw/nc/jzdbcsQS4pE68JiNalXxFy/pRuMsz/DOQoPQErAd6K
         vVQs0Mt523f8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 31EEA5C0C70; Wed, 21 Jul 2021 14:04:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/7] scftorture: Add RPC-like IPI tests
Date:   Wed, 21 Jul 2021 14:04:40 -0700
Message-Id: <20210721210441.796995-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
References: <20210721210421.GA788053@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds the single_weight_rpc module parameter, which causes the
IPI handler to awaken the IPI sender.  In many scheduler configurations,
this will result in an IPI back to the sender that is likely to be
received at a time when the sender CPU is idle.  The intent is to stress
IPI reception during CPU busy-to-idle transitions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 76 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 29e8fc5d91a7b..5cf40e4383191 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -64,6 +64,7 @@ torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, weight_resched, -1, "Testing weight for resched_cpu() operations.");
 torture_param(int, weight_single, -1, "Testing weight for single-CPU no-wait operations.");
+torture_param(int, weight_single_rpc, -1, "Testing weight for single-CPU RPC operations.");
 torture_param(int, weight_single_wait, -1, "Testing weight for single-CPU operations.");
 torture_param(int, weight_many, -1, "Testing weight for multi-CPU no-wait operations.");
 torture_param(int, weight_many_wait, -1, "Testing weight for multi-CPU operations.");
@@ -86,6 +87,8 @@ struct scf_statistics {
 	long long n_resched;
 	long long n_single;
 	long long n_single_ofl;
+	long long n_single_rpc;
+	long long n_single_rpc_ofl;
 	long long n_single_wait;
 	long long n_single_wait_ofl;
 	long long n_many;
@@ -101,14 +104,17 @@ static DEFINE_PER_CPU(long long, scf_invoked_count);
 // Data for random primitive selection
 #define SCF_PRIM_RESCHED	0
 #define SCF_PRIM_SINGLE		1
-#define SCF_PRIM_MANY		2
-#define SCF_PRIM_ALL		3
-#define SCF_NPRIMS		7 // Need wait and no-wait versions of each,
-				  //  except for SCF_PRIM_RESCHED.
+#define SCF_PRIM_SINGLE_RPC	2
+#define SCF_PRIM_MANY		3
+#define SCF_PRIM_ALL		4
+#define SCF_NPRIMS		8 // Need wait and no-wait versions of each,
+				  //  except for SCF_PRIM_RESCHED and
+				  //  SCF_PRIM_SINGLE_RPC.
 
 static char *scf_prim_name[] = {
 	"resched_cpu",
 	"smp_call_function_single",
+	"smp_call_function_single_rpc",
 	"smp_call_function_many",
 	"smp_call_function",
 };
@@ -128,6 +134,8 @@ struct scf_check {
 	bool scfc_out;
 	int scfc_cpu; // -1 for not _single().
 	bool scfc_wait;
+	bool scfc_rpc;
+	struct completion scfc_completion;
 };
 
 // Use to wait for all threads to start.
@@ -158,6 +166,7 @@ static void scf_torture_stats_print(void)
 		scfs.n_resched += scf_stats_p[i].n_resched;
 		scfs.n_single += scf_stats_p[i].n_single;
 		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
+		scfs.n_single_rpc += scf_stats_p[i].n_single_rpc;
 		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
 		scfs.n_single_wait_ofl += scf_stats_p[i].n_single_wait_ofl;
 		scfs.n_many += scf_stats_p[i].n_many;
@@ -168,9 +177,10 @@ static void scf_torture_stats_print(void)
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
 	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
 		bangstr = "!!! ";
-	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld single_rpc: %lld single_rpc_ofl: %lld many: %lld/%lld all: %lld/%lld ",
 		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
 		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
+		 scfs.n_single_rpc, scfs.n_single_rpc_ofl,
 		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
 	pr_cont("ste: %d stnmie: %d stnmoe: %d staf: %d\n", atomic_read(&n_errs),
@@ -282,10 +292,13 @@ static void scf_handler(void *scfc_in)
 out:
 	if (unlikely(!scfcp))
 		return;
-	if (scfcp->scfc_wait)
+	if (scfcp->scfc_wait) {
 		WRITE_ONCE(scfcp->scfc_out, true);
-	else
+		if (scfcp->scfc_rpc)
+			complete(&scfcp->scfc_completion);
+	} else {
 		kfree(scfcp);
+	}
 }
 
 // As above, but check for correct CPU.
@@ -319,6 +332,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp->scfc_cpu = -1;
 			scfcp->scfc_wait = scfsp->scfs_wait;
 			scfcp->scfc_out = false;
+			scfcp->scfc_rpc = false;
 		}
 	}
 	switch (scfsp->scfs_prim) {
@@ -350,6 +364,34 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 			scfcp = NULL;
 		}
 		break;
+	case SCF_PRIM_SINGLE_RPC:
+		if (!scfcp)
+			break;
+		cpu = torture_random(trsp) % nr_cpu_ids;
+		scfp->n_single_rpc++;
+		scfcp->scfc_cpu = cpu;
+		scfcp->scfc_wait = true;
+		init_completion(&scfcp->scfc_completion);
+		scfcp->scfc_rpc = true;
+		barrier(); // Prevent race-reduction compiler optimizations.
+		scfcp->scfc_in = true;
+		ret = smp_call_function_single(cpu, scf_handler_1, (void *)scfcp, 0);
+		if (!ret) {
+			if (use_cpus_read_lock)
+				cpus_read_unlock();
+			else
+				preempt_enable();
+			wait_for_completion(&scfcp->scfc_completion);
+			if (use_cpus_read_lock)
+				cpus_read_lock();
+			else
+				preempt_disable();
+		} else {
+			scfp->n_single_rpc_ofl++;
+			kfree(scfcp);
+			scfcp = NULL;
+		}
+		break;
 	case SCF_PRIM_MANY:
 		if (scfsp->scfs_wait)
 			scfp->n_many_wait++;
@@ -379,10 +421,12 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 	}
 	if (scfcp && scfsp->scfs_wait) {
 		if (WARN_ON_ONCE((num_online_cpus() > 1 || scfsp->scfs_prim == SCF_PRIM_SINGLE) &&
-				 !scfcp->scfc_out))
+				 !scfcp->scfc_out)) {
+			pr_warn("%s: Memory-ordering failure, scfs_prim: %d.\n", __func__, scfsp->scfs_prim);
 			atomic_inc(&n_mb_out_errs); // Leak rather than trash!
-		else
+		} else {
 			kfree(scfcp);
+		}
 		barrier(); // Prevent race-reduction compiler optimizations.
 	}
 	if (use_cpus_read_lock)
@@ -453,8 +497,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_rpc=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter, use_cpus_read_lock, weight_resched, weight_single, weight_single_rpc, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -497,6 +541,7 @@ static int __init scf_torture_init(void)
 	int firsterr = 0;
 	unsigned long weight_resched1 = weight_resched;
 	unsigned long weight_single1 = weight_single;
+	unsigned long weight_single_rpc1 = weight_single_rpc;
 	unsigned long weight_single_wait1 = weight_single_wait;
 	unsigned long weight_many1 = weight_many;
 	unsigned long weight_many_wait1 = weight_many_wait;
@@ -508,11 +553,13 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
-	if (weight_resched == -1 && weight_single == -1 && weight_single_wait == -1 &&
+	if (weight_resched == -1 &&
+	    weight_single == -1 && weight_single_rpc == -1 && weight_single_wait == -1 &&
 	    weight_many == -1 && weight_many_wait == -1 &&
 	    weight_all == -1 && weight_all_wait == -1) {
 		weight_resched1 = 2 * nr_cpu_ids;
 		weight_single1 = 2 * nr_cpu_ids;
+		weight_single_rpc1 = 2 * nr_cpu_ids;
 		weight_single_wait1 = 2 * nr_cpu_ids;
 		weight_many1 = 2;
 		weight_many_wait1 = 2;
@@ -523,6 +570,8 @@ static int __init scf_torture_init(void)
 			weight_resched1 = 0;
 		if (weight_single == -1)
 			weight_single1 = 0;
+		if (weight_single_rpc == -1)
+			weight_single_rpc1 = 0;
 		if (weight_single_wait == -1)
 			weight_single_wait1 = 0;
 		if (weight_many == -1)
@@ -534,7 +583,7 @@ static int __init scf_torture_init(void)
 		if (weight_all_wait == -1)
 			weight_all_wait1 = 0;
 	}
-	if (weight_single1 == 0 && weight_single_wait1 == 0 &&
+	if (weight_single1 == 0 && weight_single_rpc1 == 0 && weight_single_wait1 == 0 &&
 	    weight_many1 == 0 && weight_many_wait1 == 0 &&
 	    weight_all1 == 0 && weight_all_wait1 == 0) {
 		VERBOSE_SCFTORTOUT_ERRSTRING("all zero weights makes no sense");
@@ -546,6 +595,7 @@ static int __init scf_torture_init(void)
 	else if (weight_resched1)
 		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
 	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
+	scf_sel_add(weight_single_rpc1, SCF_PRIM_SINGLE_RPC, true);
 	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
 	scf_sel_add(weight_many1, SCF_PRIM_MANY, false);
 	scf_sel_add(weight_many_wait1, SCF_PRIM_MANY, true);
-- 
2.31.1.189.g2e36527f23

