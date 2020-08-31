Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA610C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0F72083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897387;
	bh=0m6LQHb9e+Dt06c4PMG96RC7SkXXFksL6e5cysjbOlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0izfXagcRICCNJykrUFlzd3SMIn2yQScJssmN6zL2kqvSbmDnYeh7LqeVX6yNkABD
	 Jj4kMzYbI+RdDZvDP8HUrzj5fXodRGXAMkPkPxTezJUfRqT3DLTnZc3nkQp9V6s3xe
	 udzSGwAuIIp5TLHecQ6UhDDhjB+Tym0zvBYBfKBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgHaSJY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbgHaSHx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:07:53 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF17620E65;
        Mon, 31 Aug 2020 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897273;
        bh=0m6LQHb9e+Dt06c4PMG96RC7SkXXFksL6e5cysjbOlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mkaFcE/9S0LnjyzUWqYcRdGMVN6FQ4zmH1+JruHtxhpi80i5ssnTLMgoGXl4YXaN2
         FoKojGhNY5ZPTWnvnIQM497FtKCiTZbTQajwGj/oAARLZFFkjpq4rMFK80iiUo4Evj
         eRGyNjhw+rzWbyR7aysBI48Ax/yYJieLjHvFhvTQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/19] scftorture: Summarize per-thread statistics
Date:   Mon, 31 Aug 2020 11:07:36 -0700
Message-Id: <20200831180749.843-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit summarizes the per-thread statistics, providing counts of
the number of single, many, and all calls, both no-wait and wait, and,
for the single case, the number where the target CPU was offline.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 5f19845..09a6242 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -128,13 +128,27 @@ DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 static void scf_torture_stats_print(void)
 {
 	int cpu;
+	int i;
 	long long invoked_count = 0;
 	bool isdone = READ_ONCE(scfdone);
+	struct scf_statistics scfs = {};
 
 	for_each_possible_cpu(cpu)
 		invoked_count += data_race(per_cpu(scf_invoked_count, cpu));
-	pr_alert("%s scf_invoked_count %s: %lld ",
-		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count);
+	for (i = 0; i < nthreads; i++) {
+		scfs.n_single += scf_stats_p[i].n_single;
+		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
+		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
+		scfs.n_single_wait_ofl += scf_stats_p[i].n_single_wait_ofl;
+		scfs.n_many += scf_stats_p[i].n_many;
+		scfs.n_many_wait += scf_stats_p[i].n_many_wait;
+		scfs.n_all += scf_stats_p[i].n_all;
+		scfs.n_all_wait += scf_stats_p[i].n_all_wait;
+	}
+	pr_alert("%s scf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count,
+		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
+		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
 	pr_cont("\n");
 }
@@ -357,11 +371,11 @@ static void scf_torture_cleanup(void)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
 		goto end;
-	kfree(scf_stats_p);
-	scf_stats_p = NULL;
 	smp_call_function(scf_cleanup_handler, NULL, 0);
 	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
 	scf_torture_stats_print();  // -After- the stats thread is stopped!
+	kfree(scf_stats_p);  // -After- the last stats print has completed!
+	scf_stats_p = NULL;
 
 	if (atomic_read(&n_errs))
 		scftorture_print_module_parms("End of test: FAILURE");
-- 
2.9.5

