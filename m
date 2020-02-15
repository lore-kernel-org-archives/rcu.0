Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9605C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8819A217F4
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581727055;
	bh=3v3RBgQ+X/7OKM2+sRdYehsB6ohrN13jJdVtxUlawn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/VITPWBcSUM1358iIXX3VSyRnhiTaSzl2VHsLN54gaugIkU1H42YY214ua2XB0ZR
	 xxA2VbCLuWWq2Jm61y3fNqeEdCvfi1Oe9TBc4JQG6t7wMmEgwu8zWcRRIZtE7PMYWK
	 ZidH/qQLcykwlfei+G85h6y5J8B9SPcLoLGdDfmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBOAhe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBOAhd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:33 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08437207FF;
        Sat, 15 Feb 2020 00:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581727052;
        bh=3v3RBgQ+X/7OKM2+sRdYehsB6ohrN13jJdVtxUlawn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X49JVMREIC1XJoJLDJU8Vf9SP3fVpkBEBbTmJmWusNlwTt9xESnU4eXCcxTHoS0FW
         tSBsjRh34ktduAe/ojYbvOKnxdENDG2UX1HORLdbI/ubLVuFVWKBIqCGWX6S6CwIJT
         w3Gi+9jWjCQSdE3Ta3Wjk8DjFzU4h42bQ9kFteYk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/18] rcutorture: Allow boottime stall warnings to be suppressed
Date:   Fri, 14 Feb 2020 16:36:58 -0800
Message-Id: <20200215003711.16463-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215003634.GA16227@paulmck-ThinkPad-P72>
References: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In normal production, an RCU CPU stall warning at boottime is often
just as bad as at any other time.  In fact, given the desire for fast
boot, any sort of long-term stall at boot is a bad idea.  However,
heavy rcutorture testing on large hyperthreaded systems can generate
boottime RCU CPU stalls as a matter of course.  This commit therefore
provides a kernel boot parameter that suppresses reporting of boottime
RCU CPU stall warnings and similarly of rcutorture writer stalls.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 kernel/rcu/rcu.h                                | 17 +++++++++++++++++
 kernel/rcu/rcutorture.c                         |  2 +-
 kernel/rcu/tree_exp.h                           |  2 +-
 kernel/rcu/tree_stall.h                         |  6 +++---
 kernel/rcu/update.c                             |  8 +++++++-
 6 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dbc22d6..ee007b5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4195,6 +4195,12 @@
 	rcupdate.rcu_cpu_stall_suppress= [KNL]
 			Suppress RCU CPU stall warning messages.
 
+	rcupdate.rcu_cpu_stall_suppress_at_boot= [KNL]
+			Suppress RCU CPU stall warning messages and
+			rcutorture writer stall warnings that occur
+			during early boot, that is, during the time
+			before the init task is spawned.
+
 	rcupdate.rcu_cpu_stall_timeout= [KNL]
 			Set timeout for RCU CPU stall warning messages.
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 05f936e..1779cbf 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -198,6 +198,13 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
+extern int rcu_cpu_stall_suppress_at_boot;
+
+static inline bool rcu_stall_is_suppressed_at_boot(void)
+{
+	return rcu_cpu_stall_suppress_at_boot && !rcu_inkernel_boot_has_ended();
+}
+
 #ifdef CONFIG_RCU_STALL_COMMON
 
 extern int rcu_cpu_stall_ftrace_dump;
@@ -205,6 +212,11 @@ extern int rcu_cpu_stall_suppress;
 extern int rcu_cpu_stall_timeout;
 int rcu_jiffies_till_stall_check(void);
 
+static inline bool rcu_stall_is_suppressed(void)
+{
+	return rcu_stall_is_suppressed_at_boot() || rcu_cpu_stall_suppress;
+}
+
 #define rcu_ftrace_dump_stall_suppress() \
 do { \
 	if (!rcu_cpu_stall_suppress) \
@@ -218,6 +230,11 @@ do { \
 } while (0)
 
 #else /* #endif #ifdef CONFIG_RCU_STALL_COMMON */
+
+static inline bool rcu_stall_is_suppressed(void)
+{
+	return rcu_stall_is_suppressed_at_boot();
+}
 #define rcu_ftrace_dump_stall_suppress()
 #define rcu_ftrace_dump_stall_unsuppress()
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08fa4ef..16c84ec 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1479,7 +1479,7 @@ rcu_torture_stats_print(void)
 	if (cur_ops->stats)
 		cur_ops->stats();
 	if (rtcv_snap == rcu_torture_current_version &&
-	    rcu_torture_current != NULL) {
+	    rcu_torture_current != NULL && !rcu_stall_is_suppressed()) {
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index a72d16e..c28d9f0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -518,7 +518,7 @@ static void synchronize_rcu_expedited_wait(void)
 	for (;;) {
 		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
 			return;
-		if (rcu_cpu_stall_suppress)
+		if (rcu_stall_is_suppressed())
 			continue;
 		panic_on_rcu_stall();
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 55f9b84..7ee8a1c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -383,7 +383,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
-	if (rcu_cpu_stall_suppress)
+	if (rcu_stall_is_suppressed())
 		return;
 
 	/*
@@ -452,7 +452,7 @@ static void print_cpu_stall(void)
 
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
-	if (rcu_cpu_stall_suppress)
+	if (rcu_stall_is_suppressed())
 		return;
 
 	/*
@@ -504,7 +504,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
-	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
+	if ((rcu_stall_is_suppressed() && !rcu_kick_kthreads) ||
 	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads();
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index feaaec5..085f08a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -476,13 +476,19 @@ EXPORT_SYMBOL_GPL(rcutorture_sched_setaffinity);
 #ifdef CONFIG_RCU_STALL_COMMON
 int rcu_cpu_stall_ftrace_dump __read_mostly;
 module_param(rcu_cpu_stall_ftrace_dump, int, 0644);
-int rcu_cpu_stall_suppress __read_mostly; /* 1 = suppress stall warnings. */
+int rcu_cpu_stall_suppress __read_mostly; // !0 = suppress stall warnings.
 EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
 module_param(rcu_cpu_stall_suppress, int, 0644);
 int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
 module_param(rcu_cpu_stall_timeout, int, 0644);
 #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
 
+// Suppress boot-time RCU CPU stall warnings and rcutorture writer stall
+// warnings.  Also used by rcutorture even if stall warnings are excluded.
+int rcu_cpu_stall_suppress_at_boot __read_mostly; // !0 = suppress boot stalls.
+EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress_at_boot);
+module_param(rcu_cpu_stall_suppress_at_boot, int, 0444);
+
 #ifdef CONFIG_TASKS_RCU
 
 /*
-- 
2.9.5

