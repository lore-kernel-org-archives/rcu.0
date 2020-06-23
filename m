Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8CBC433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2B52053B
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872329;
	bh=l+pOIyYggzjNshzyGc05k+ujOGvhTY4fPpmjwkalyqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnPf1aXzbYo1PXO9El2dnLnJ7CH2+o8yVkIsPYsfakcUX/8mq3dNUiJNGhdVSUSaM
	 UNTGFd0TMufVX7pGYkQkMdzuYObZiK1IAhFzUNYTvwfMJtmapAwOxCnKExWSAVtVVP
	 ngaH/CH/epBMBErUqWAkqKrgVnhSxHLv4ODX3vy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbgFWAcI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731644AbgFWAaR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AA2206C1;
        Tue, 23 Jun 2020 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872216;
        bh=l+pOIyYggzjNshzyGc05k+ujOGvhTY4fPpmjwkalyqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBJ6yCi0QfxxSLnIADn12EBnaLr+xW+an+S8mk61BbEsLlli4tchro3iv75eQWVYP
         g2h7k0g4V2AyJGIQvKx1uuOAARSpS/HhEX4iouzglgYPB683fBkHgrqVzv117JLP1f
         yCfBnoS2lhx9qXTiQcY2yuqqBSln6/0OWv8nKtIU=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/30] refperf: Convert nreaders to a module parameter
Date:   Mon, 22 Jun 2020 17:29:51 -0700
Message-Id: <20200623003013.26252-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts nreaders to a module parameter, with the default
of -1 specifying the old behavior of using 75% of the readers.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index e991d48..020e55a 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -62,6 +62,12 @@ torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
 // Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000000, "Number of loops per experiment.");
+// Number of readers, with -1 defaulting to about 75% of the CPUs.
+torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
+// Number of runs.
+torture_param(int, nruns, 30, "Number of experiments to run.");
+// Reader delay in nanoseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
 
 #ifdef MODULE
 # define REFPERF_SHUTDOWN 0
@@ -93,7 +99,6 @@ static wait_queue_head_t main_wq;
 static int shutdown_start;
 
 static struct reader_task *reader_tasks;
-static int nreaders;
 
 // Number of readers that are part of the current experiment.
 static atomic_t nreaders_exp;
@@ -411,8 +416,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders);
 }
 
 static void
@@ -501,8 +506,9 @@ ref_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
-	// Reader tasks (~75% of online CPUs).
-	nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	// Reader tasks (default to ~75% of online CPUs).
+	if (nreaders < 0)
+		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
-- 
2.9.5

