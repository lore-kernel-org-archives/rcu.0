Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C8BC4332E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7219823120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbhAFRSh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbhAFRSg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:18:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B833B23159;
        Wed,  6 Jan 2021 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953434;
        bh=7I/YkDWVc6pIzLNw5c8DbbJsczboUueIol9h6z0JFJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Am1zOcNBea//VEFHZF189rj2nHZ9j2ZRI6McUA+khq6d94DqqNk5sw//Rwb9QUg2u
         7OUpPCullA8a0W0gb6FQPDW8nIYnyKh3qrReS+1EKVCbG0m8osbjmjEzK+htGT6Mpv
         pipo9XfLdjVXYQAMs2fXbuJhyANqxM+g96VSlQo+GePtzdZMYKg9bOMqGyPCM95faY
         fykkGVYIIjdkeHKwgi+nc+kHHJ4uFNv1RzOB2QQA8j/X3dVeqvTGMo4GTcGgpgp13m
         P/wFF15DKIO/gOdz69H2FZMkcS0vU1bx3c7GwyM8rgXGhuKmsWlmjhKCiyDyhG/81i
         NxRFx2atcULqg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/17] torture: Maintain torture-specific set of CPUs-online books
Date:   Wed,  6 Jan 2021 09:17:08 -0800
Message-Id: <20210106171710.22239-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The TREE01 rcutorture scenario intentionally creates confusion as to the
number of available CPUs by specifying the "maxcpus=8 nr_cpus=43" kernel
boot parameters.  This can disable rcutorture's load shedding, which
currently uses num_online_cpus(), which would count the extra 35 CPUs.
However, the rcutorture guest OS will be provisioned with only 8 CPUs,
which means that rcutorture will present full load even when all but one
of the original 8 CPUs are offline.  This can result in spurious errors
due to extreme overloading of that single remaining CPU.

This commit therefore keeps a separate set of books on the number of
usable online CPUs, so that torture_num_online_cpus() is used for load
shedding instead of num_online_cpus().  Note that initial sizing must
use num_online_cpus() because torture_num_online_cpus() will return
NR_CPUS until shortly after torture_onoff_init() is invoked.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
[ paulmck: Apply feedback from kernel test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  5 +++++
 kernel/rcu/rcutorture.c |  4 ++--
 kernel/torture.c        | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index d62d13c..0910c58 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -48,6 +48,11 @@ do {										\
 void verbose_torout_sleep(void);
 
 /* Definitions for online/offline exerciser. */
+#ifdef CONFIG_HOTPLUG_CPU
+int torture_num_online_cpus(void);
+#else /* #ifdef CONFIG_HOTPLUG_CPU */
+static inline int torture_num_online_cpus(void) { return 1; }
+#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
 typedef void torture_ofl_func(void);
 bool torture_offline(int cpu, long *n_onl_attempts, long *n_onl_successes,
 		     unsigned long *sum_offl, int *min_onl, int *max_onl);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 72fd6bb..a9c2ee7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1338,7 +1338,7 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 					struct torture_random_state *trsp)
 {
 	unsigned long loops;
-	int noc = num_online_cpus();
+	int noc = torture_num_online_cpus();
 	int rdrchked;
 	int rdrchker;
 	struct rcu_torture_reader_check *rtrcp; // Me.
@@ -1658,7 +1658,7 @@ rcu_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		while (num_online_cpus() < mynumonline && !torture_must_stop())
+		while (torture_num_online_cpus() < mynumonline && !torture_must_stop())
 			schedule_timeout_interruptible(HZ / 5);
 		stutter_wait("rcu_torture_reader");
 	} while (!torture_must_stop());
diff --git a/kernel/torture.c b/kernel/torture.c
index 507a20b..01e336f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -175,6 +175,19 @@ static unsigned long sum_online;
 static int min_online = -1;
 static int max_online;
 
+static int torture_online_cpus = NR_CPUS;
+
+/*
+ * Some torture testing leverages confusion as to the number of online
+ * CPUs.  This function returns the torture-testing view of this number,
+ * which allows torture tests to load-balance appropriately.
+ */
+int torture_num_online_cpus(void)
+{
+	return READ_ONCE(torture_online_cpus);
+}
+EXPORT_SYMBOL_GPL(torture_num_online_cpus);
+
 /*
  * Attempt to take a CPU offline.  Return false if the CPU is already
  * offline or if it is not subject to CPU-hotplug operations.  The
@@ -229,6 +242,8 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			*min_offl = delta;
 		if (*max_offl < delta)
 			*max_offl = delta;
+		WRITE_ONCE(torture_online_cpus, torture_online_cpus - 1);
+		WARN_ON_ONCE(torture_online_cpus <= 0);
 	}
 
 	return true;
@@ -285,6 +300,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 			*min_onl = delta;
 		if (*max_onl < delta)
 			*max_onl = delta;
+		WRITE_ONCE(torture_online_cpus, torture_online_cpus + 1);
 	}
 
 	return true;
-- 
2.9.5

