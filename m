Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4AC433E0
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5141520720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872328;
	bh=Gz9z6ir3rGrxGlwUj+lXRqUdYYT2OYGIBdhVPWGhuRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zwT7qvTWAVgeyAiITPenUhLvjeqPnJ5YeUcF4BgKBWSdtl20ZkDEA8lStMCtnFSyy
	 lIVjgKvTOFWzL5ohKauqZMWswiafmnT3ezgBVZ1Baw/9off0gU9UtY8VfHsQl85uZA
	 E/yJdEBLGqCNWgtOsudd7VUtsg9q1ibf5cckfVHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgFWAaR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbgFWAaQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D98207DD;
        Tue, 23 Jun 2020 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872216;
        bh=Gz9z6ir3rGrxGlwUj+lXRqUdYYT2OYGIBdhVPWGhuRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKRhy4OY97BG1yUTxZ7C+e0OJM0FylYcsQ6btG6bDDawdLEiL6nCxkjFCcn99OocO
         HuSjBaBPhvtye3ZEJwEOKWVR/vseLjJ2s8YkkyK7tL6mUZR1sW6Hf2rF2MsQxmG7vC
         B+4nzKiVxtn6btyTDRHa/5TZPks/UYqe4kcxmPkI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/30] refperf: Add holdoff parameter to allow CPUs to come online
Date:   Mon, 22 Jun 2020 17:29:48 -0700
Message-Id: <20200623003013.26252-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds an rcuperf module parameter named "holdoff" that
defaults to 10 seconds if refperf is built in and to zero otherwise.
The assumption is that all the CPUs are online by the time that the
modprobe and insmod commands are going to do anything, and that normal
systems will have all the CPUs online within ten seconds.

Larger systems may take many tens of seconds or even minutes to get
to this point, hence this being a module parameter instead of being a
hard-coded constant.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 6116153..4d686fd 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -57,7 +57,10 @@ MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 
-// Number of loops per experiment, all readers execute an operation concurrently
+// Wait until there are multiple CPUs before starting test.
+torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
+	      "Holdoff time before test start (s)");
+// Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000000, "Number of loops per experiment.");
 
 #ifdef MODULE
@@ -248,6 +251,8 @@ ref_perf_reader(void *arg)
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_init);
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
 repeat:
 	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
@@ -357,6 +362,8 @@ static int main_func(void *arg)
 
 	// Wait for all threads to start.
 	wait_event(main_wq, atomic_read(&n_init) == (nreaders + 1));
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
 
 	// Start exp readers up per experiment
 	for (exp = 0; exp < nreaders && !torture_must_stop(); exp++) {
@@ -420,8 +427,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d loops=%ld\n", perf_type, tag,
-		 verbose, shutdown, loops);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops);
 }
 
 static void
-- 
2.9.5

