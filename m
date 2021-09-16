Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA6C433FE
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E42611CA
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhIPAPP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233259AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 756BA611C7;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=Q60OUrZPedHzM9S+vxeiVOMp0bWkRf8UYAaJXcyPvp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsHCjdl2KaBvVJxJ+pqsBYfYMlDpfO7jAvm8b2+saZ3CAygJvTsBstO7fDk/PS0zw
         5tWrqG5rMQWBPwYOMqu8tofwk0CZ3SHw4/qz4X2fUAzagGNUfzXyAmMidis/R7nDy1
         aV5GEBdEx+zkLVATQIvhaTgdSpDR8YoWV2RqVVFpqiUVC8aasB6O08JKnFDsMqOeO1
         zeq9P9g4cHY/tFkpXROWN7QhuM/gkTroecwbGaeb70PCZ2R2rF417w1wtHamYNdTBL
         51kwOUYU5Zm/4XYsUOWu+gimAHAu63AHPmui2xkovpcZs1PvshbumnqcTKmxyrTmXz
         zHIeQoA2suPEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3EC525C06B9; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] rcutorture: Warn on individual rcu_torture_init() error conditions
Date:   Wed, 15 Sep 2021 17:13:47 -0700
Message-Id: <20210916001352.3909170-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When running rcutorture as a module, any rcu_torture_init() issues will be
reflected in the error code from modprobe or insmod, as the case may be.
However, these error codes are not available when running rcutorture
built-in, for example, when using the kvm.sh script.  This commit
therefore adds WARN_ON_ONCE() to allow distinguishing rcu_torture_init()
errors when running rcutorture built-in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  8 ++++++++
 kernel/rcu/rcutorture.c | 30 +++++++++++++++---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index 0910c5803f35..24f58e50a94b 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -47,6 +47,14 @@ do {										\
 } while (0)
 void verbose_torout_sleep(void);
 
+#define torture_init_error(firsterr)						\
+({										\
+	int ___firsterr = (firsterr);						\
+										\
+	WARN_ONCE(!IS_MODULE(CONFIG_RCU_TORTURE_TEST) && ___firsterr < 0, "Torture-test initialization failed with error code %d\n", ___firsterr); \
+	___firsterr < 0;								\
+})
+
 /* Definitions for online/offline exerciser. */
 #ifdef CONFIG_HOTPLUG_CPU
 int torture_num_online_cpus(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 59254fa15cc6..b90cd4d98a20 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3037,7 +3037,7 @@ rcu_torture_init(void)
 	rcu_torture_write_types();
 	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
 					  writer_task);
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	if (nfakewriters > 0) {
 		fakewriter_tasks = kcalloc(nfakewriters,
@@ -3052,7 +3052,7 @@ rcu_torture_init(void)
 	for (i = 0; i < nfakewriters; i++) {
 		firsterr = torture_create_kthread(rcu_torture_fakewriter,
 						  NULL, fakewriter_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
@@ -3068,7 +3068,7 @@ rcu_torture_init(void)
 		rcu_torture_reader_mbchk[i].rtc_chkrdr = -1;
 		firsterr = torture_create_kthread(rcu_torture_reader, (void *)i,
 						  reader_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	nrealnocbers = nocbs_nthreads;
@@ -3088,18 +3088,18 @@ rcu_torture_init(void)
 	}
 	for (i = 0; i < nrealnocbers; i++) {
 		firsterr = torture_create_kthread(rcu_nocb_toggle, NULL, nocb_tasks[i]);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(rcu_torture_stats, NULL,
 						  stats_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (test_no_idle_hz && shuffle_interval > 0) {
 		firsterr = torture_shuffle_init(shuffle_interval * HZ);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (stutter < 0)
@@ -3109,7 +3109,7 @@ rcu_torture_init(void)
 
 		t = cur_ops->stall_dur ? cur_ops->stall_dur() : stutter * HZ;
 		firsterr = torture_stutter_init(stutter * HZ, t);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (fqs_duration < 0)
@@ -3118,7 +3118,7 @@ rcu_torture_init(void)
 		/* Create the fqs thread */
 		firsterr = torture_create_kthread(rcu_torture_fqs, NULL,
 						  fqs_task);
-		if (firsterr)
+		if (torture_init_error(firsterr))
 			goto unwind;
 	}
 	if (test_boost_interval < 1)
@@ -3132,7 +3132,7 @@ rcu_torture_init(void)
 		firsterr = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "RCU_TORTURE",
 					     rcutorture_booster_init,
 					     rcutorture_booster_cleanup);
-		if (firsterr < 0)
+		if (torture_init_error(firsterr))
 			goto unwind;
 		rcutor_hp = firsterr;
 
@@ -3153,23 +3153,23 @@ rcu_torture_init(void)
 	}
 	shutdown_jiffies = jiffies + shutdown_secs * HZ;
 	firsterr = torture_shutdown_init(shutdown_secs, rcu_torture_cleanup);
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval,
 				      rcutorture_sync);
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	firsterr = rcu_torture_stall_init();
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	firsterr = rcu_torture_fwd_prog_init();
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	firsterr = rcu_torture_barrier_init();
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	firsterr = rcu_torture_read_exit_init();
-	if (firsterr)
+	if (torture_init_error(firsterr))
 		goto unwind;
 	if (object_debug)
 		rcu_test_debug_objects();
-- 
2.31.1.189.g2e36527f23

