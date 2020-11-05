Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB15C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A020704
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604619591;
	bh=ixcEVuzauDiQHpBxn8MULPY+fkH3rxlTdpo6glHLYFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tXbLEvC/s7YNduWmD/1MqApYK6ElrGl9p7Pr8nGQgfPIIZ3gV4vlnYBV4H4Hah2Xh
	 pviCeTu3bFqSSBmqhk9WnqVo9TeRuMVj3Yb9a5IGBmjGtOPN4CQGgYW1iGADukkJPA
	 BffcaT3MjhTc1NFKv9/CyGwlkeO9ldr1rrHG4GSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKEXjh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:39:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbgKEXjh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:39:37 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C52D32083B;
        Thu,  5 Nov 2020 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604619575;
        bh=ixcEVuzauDiQHpBxn8MULPY+fkH3rxlTdpo6glHLYFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqpYl+bSW/PGwUaGgoRA1xL0xOhNr3hpmh/6Fp1I3xGDCj0TZIwi23O3Jm6P1/BDx
         bstHqqYVE2YNf6gmxN0N8/gDGTeJKB1czuzcoAlpSeDX2bFCih04Wyq3VeL2KLTv0M
         gk64rB8F74v+rKf+b3Zkzs6m7WsiCOM4ycQZVq+Q=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] rcutorture: Make grace-period kthread report match RCU flavor being tested
Date:   Thu,  5 Nov 2020 15:39:32 -0800
Message-Id: <20201105233933.20748-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105233900.GA20676@paulmck-ThinkPad-P72>
References: <20201105233900.GA20676@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

At the end of the test and after rcu_torture_writer() stalls, rcutorture
invokes show_rcu_gp_kthreads() in order to dump out information on the
RCU grace-period kthread.  This makes a lot of sense when testing vanilla
RCU, but not so much for the other flavors.  This commit therefore allows
per-flavor kthread-dump functions to be specified.

[ paulmck: Apply feedback from kernel test robot <lkp@intel.com>. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        | 16 ++++++++++++++++
 kernel/rcu/rcutorture.c | 11 +++++++++--
 kernel/rcu/tasks.h      | 30 ++++++++++++++----------------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e01cba5..59ef1ae 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -533,4 +533,20 @@ static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RCU)
+void show_rcu_tasks_classic_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_classic_gp_kthread(void) {}
+#endif
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
+void show_rcu_tasks_rude_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_rude_gp_kthread(void) {}
+#endif
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_TRACE_RCU)
+void show_rcu_tasks_trace_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_trace_gp_kthread(void) {}
+#endif
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 916ea4f..c811f23 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -317,6 +317,7 @@ struct rcu_torture_ops {
 	void (*cb_barrier)(void);
 	void (*fqs)(void);
 	void (*stats)(void);
+	void (*gp_kthread_dbg)(void);
 	int (*stall_dur)(void);
 	int irq_capable;
 	int can_boost;
@@ -466,6 +467,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.cb_barrier	= rcu_barrier,
 	.fqs		= rcu_force_quiescent_state,
 	.stats		= NULL,
+	.gp_kthread_dbg	= show_rcu_gp_kthreads,
 	.stall_dur	= rcu_jiffies_till_stall_check,
 	.irq_capable	= 1,
 	.can_boost	= rcu_can_boost(),
@@ -693,6 +695,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.exp_sync	= synchronize_rcu_mult_test,
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
+	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -762,6 +765,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.exp_sync	= synchronize_rcu_tasks_rude,
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
+	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -800,6 +804,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
+	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -1594,7 +1599,8 @@ rcu_torture_stats_print(void)
 			sched_show_task(wtp);
 			splatted = true;
 		}
-		show_rcu_gp_kthreads();
+		if (cur_ops->gp_kthread_dbg)
+			cur_ops->gp_kthread_dbg();
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	rtcv_snap = rcu_torture_current_version;
@@ -2472,7 +2478,8 @@ rcu_torture_cleanup(void)
 		return;
 	}
 
-	show_rcu_gp_kthreads();
+	if (cur_ops->gp_kthread_dbg)
+		cur_ops->gp_kthread_dbg();
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
 	rcu_torture_fwd_prog_cleanup();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a93271f..0b45989 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -290,7 +290,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+#endif // #ifndef CONFIG_TINY_RCU
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 
@@ -568,12 +568,13 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_classic_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_classic_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
@@ -595,7 +596,6 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
-static inline void show_rcu_tasks_classic_gp_kthread(void) { }
 void exit_tasks_rcu_start(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
@@ -696,16 +696,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_rude_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_rude_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
-
-#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
-static void show_rcu_tasks_rude_gp_kthread(void) {}
-#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -1199,8 +1197,8 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_trace_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
@@ -1210,11 +1208,11 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
-static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
-- 
2.9.5

