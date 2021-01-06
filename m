Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257A1C433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CEC23329
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbhAFRSh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbhAFRSg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BD2323120;
        Wed,  6 Jan 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953434;
        bh=kDCFnFdi9Qo0epQtanow2bF5FVZNrOFpXLtL2rA1Y58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y01j6MW9DSTSmssxp+kw+3+d3/MN96RmCtUeSXp4VvEjOSRmlee3dn2tqNPK4Z32p
         izL+910G5ofShbVJXQKExsZus+9MpJ2+AnHbrRAlnALIQHxrxg+2Bvf54kyccq1MFE
         OUOkHom5okWbtOvTXzB5ATUcKzS80chEb2M0i0/Bl3K4LMfeB/rhWFxA8jty4CAdfN
         +PQgDGnRLbbmsXvcjiriluEgKOZ8kWPFR1Qg6dJKVP7Mo0I/0M0+l1Wm1QKbNkKKI3
         OreDUReuoaOZMdzXy5oA6CFJNbueLufydFiGbpO9CDQ1cx+M7sergHLVWI6PBjVK25
         ZhcMllqglJTXg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/17] torture: Clean up after torture-test CPU hotplugging
Date:   Wed,  6 Jan 2021 09:17:07 -0800
Message-Id: <20210106171710.22239-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit puts all CPUs back online at the end of a torture test,
and also unconditionally puts them online at the beginning of the test,
rather than just in the case of built-in tests.  This allows torture tests
to behave in a predictable manner, whether built-in or based on modules.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 93eeeb2..507a20b 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -292,6 +292,26 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 EXPORT_SYMBOL_GPL(torture_online);
 
 /*
+ * Get everything online at the beginning and ends of tests.
+ */
+static void torture_online_all(char *phase)
+{
+	int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_online(cpu))
+			continue;
+		ret = add_cpu(cpu);
+		if (ret && verbose) {
+			pr_alert("%s" TORTURE_FLAG
+				 "%s: %s online %d: errno %d\n",
+				 __func__, phase, torture_type, cpu, ret);
+		}
+	}
+}
+
+/*
  * Execute random CPU-hotplug operations at the interval specified
  * by the onoff_interval.
  */
@@ -301,25 +321,12 @@ torture_onoff(void *arg)
 	int cpu;
 	int maxcpu = -1;
 	DEFINE_TORTURE_RANDOM(rand);
-	int ret;
 
 	VERBOSE_TOROUT_STRING("torture_onoff task started");
 	for_each_online_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
-	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
-		for_each_possible_cpu(cpu) {
-			if (cpu_online(cpu))
-				continue;
-			ret = add_cpu(cpu);
-			if (ret && verbose) {
-				pr_alert("%s" TORTURE_FLAG
-					 "%s: Initial online %d: errno %d\n",
-					 __func__, torture_type, cpu, ret);
-			}
-		}
-	}
-
+	torture_online_all("Initial");
 	if (maxcpu == 0) {
 		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
 		goto stop;
@@ -347,6 +354,7 @@ torture_onoff(void *arg)
 
 stop:
 	torture_kthread_stopping("torture_onoff");
+	torture_online_all("Final");
 	return 0;
 }
 
-- 
2.9.5

