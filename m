Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D949AC43462
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72F9616E8
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEKXI4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhEKXIz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:08:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DF8B61919;
        Tue, 11 May 2021 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774468;
        bh=JKlIzbvIU/cyHISlHCUNpKgOKDgTFohESIuAMUdNs7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eR53HZN56IwaRXE07Vs/hPxYXn7xexFHdrk+Pj1hUoLHq//GoxlWtmzOLmx3oxKzJ
         CDf9QsRIpdsv4KLevbXVcVONdna8g1sYKHTtElEqPfnV1EjqMNrvIFB14K6eG9ARR3
         q5mleMOvhg7fID+eTqF6BhGso9bWTB979OSoLQgHlLsnb9oYSBRxeluJN+NPGw0aVE
         /hChzgtgV3ntfxPF8zqbujNRMPvuA8ZlKl7sUVjRBFudPFza6XQQTb1H5I6+xKdei5
         GbK3IpfETbJ6G+fmKrrF27XsD4AZrwnR/q5WOATvNuQ28s3LJ+gqnC/NmFX7YuA3VI
         E1uE5ojMwVfEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E0D535C0B55; Tue, 11 May 2021 16:07:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/6] srcu: Initialize SRCU after timers
Date:   Tue, 11 May 2021 16:07:43 -0700
Message-Id: <20210511230745.2894650-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Once srcu_init() is called, the SRCU core will make use of delayed
workqueues, which rely on timers.  However init_timers() is called
several steps after rcu_init().  This means that a call_srcu() after
rcu_init() but before init_timers() would find itself within a dangerously
uninitialized timer core.

This commit therefore creates a separate call to srcu_init() after
init_timer() completes, which ensures that we stay in early SRCU mode
until timers are safe(r).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h  | 6 ++++++
 init/main.c           | 2 ++
 kernel/rcu/rcu.h      | 6 ------
 kernel/rcu/srcutree.c | 5 +++++
 kernel/rcu/tiny.c     | 1 -
 kernel/rcu/tree.c     | 1 -
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a0895bbf71ce..e6011a9975af 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -64,6 +64,12 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+#ifdef CONFIG_SRCU
+void srcu_init(void);
+#else /* #ifdef CONFIG_SRCU */
+static inline void srcu_init(void) { }
+#endif /* #else #ifdef CONFIG_SRCU */
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
diff --git a/init/main.c b/init/main.c
index eb01e121d2f1..7b6f49c4d388 100644
--- a/init/main.c
+++ b/init/main.c
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/kfence.h>
 #include <linux/rcupdate.h>
+#include <linux/srcu.h>
 #include <linux/moduleparam.h>
 #include <linux/kallsyms.h>
 #include <linux/writeback.h>
@@ -979,6 +980,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	tick_init();
 	rcu_init_nohz();
 	init_timers();
+	srcu_init();
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d4b659..ca3f2af32bf8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -422,12 +422,6 @@ do {									\
 
 #endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
 
-#ifdef CONFIG_SRCU
-void srcu_init(void);
-#else /* #ifdef CONFIG_SRCU */
-static inline void srcu_init(void) { }
-#endif /* #else #ifdef CONFIG_SRCU */
-
 #ifdef CONFIG_TINY_RCU
 /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
 static inline bool rcu_gp_is_normal(void) { return true; }
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f4f0cbf7a02b..9ec35c158740 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1384,6 +1384,11 @@ void __init srcu_init(void)
 {
 	struct srcu_struct *ssp;
 
+	/*
+	 * Once that is set, call_srcu() can follow the normal path and
+	 * queue delayed work. This must follow RCU workqueues creation
+	 * and timers initialization.
+	 */
 	srcu_init_done = true;
 	while (!list_empty(&srcu_boot_list)) {
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index c8a029fbb114..340b3f8b090d 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -221,5 +221,4 @@ void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 	rcu_early_boot_tests();
-	srcu_init();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b2430c16..c35b15229cff 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4735,7 +4735,6 @@ void __init rcu_init(void)
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
-	srcu_init();
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
-- 
2.31.1.189.g2e36527f23

