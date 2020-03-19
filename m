Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE20C4332E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C402076F
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576718;
	bh=VX0fhkTHGpTTVQNLQ6YVf7+3W71egg1ysRdaAxsTytc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBiEiI/wjJNaNphmk1l4XG3fLDbFDVTlEBbuwpe94GecnRq635AcOE3UmHia2iyIr
	 o0WrSjCBrdbvAW/obnqBiorFKICNF1/TY9G+7qDWnc+Cspt4HFJKymrMJrJQ2AR64A
	 SVwzxDgI58BcRlaPKUCe+uRGphNa6r5rJ7yf/0Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgCSAL6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727416AbgCSALF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6DC120774;
        Thu, 19 Mar 2020 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576665;
        bh=VX0fhkTHGpTTVQNLQ6YVf7+3W71egg1ysRdaAxsTytc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3EMpWtJIPydev6f5k2ETgxwSq/SO67Sh8H/7FSOwNok38Uq/J1mE9n9/zrih8zkd
         5SrgMtJ/mQK969m01lSMuKYoH+kEMTe7lXcP8lYChRS4YJALhoFgQmxCTGfDcvB7qI
         x0ZruyXHT3wcSNBhmWCkgt6kPYPo4ZnMZtLIIIw4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 09/22] rcu-tasks: Add an RCU-tasks rude variant
Date:   Wed, 18 Mar 2020 17:10:47 -0700
Message-Id: <20200319001100.24917-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a "rude" variant of RCU-tasks that has as quiescent
states schedule(), cond_resched_tasks_rcu_qs(), userspace execution,
and (in theory, anyway) cond_resched().  In other words, RCU-tasks rude
readers are regions of code with preemption disabled, but excluding code
early in the CPU-online sequence and late in the CPU-offline sequence.
Updates make use of IPIs and force an IPI and a context switch on each
online CPU.  This variant is useful in some situations in tracing.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
[ paulmck: Apply EXPORT_SYMBOL_GPL() feedback from Qiujun Huang. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  3 ++
 kernel/rcu/Kconfig       | 12 +++++-
 kernel/rcu/tasks.h       | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5523145..2be97a8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -37,6 +37,7 @@
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
+void rcu_barrier_tasks_rude(void);
 void synchronize_rcu(void);
 
 #ifdef CONFIG_PREEMPT_RCU
@@ -138,6 +139,8 @@ static inline void rcu_init_nohz(void) { }
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
 void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
 void synchronize_rcu_tasks(void);
+void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
+void synchronize_rcu_tasks_rude(void);
 void exit_tasks_rcu_start(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 38475d0..0d43ec1 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -71,7 +71,7 @@ config TREE_SRCU
 	  This option selects the full-fledged version of SRCU.
 
 config TASKS_RCU_GENERIC
-	def_bool TASKS_RCU
+	def_bool TASKS_RCU || TASKS_RUDE_RCU
 	select SRCU
 	help
 	  This option enables generic infrastructure code supporting
@@ -84,6 +84,16 @@ config TASKS_RCU
 	  only voluntary context switch (not preemption!), idle, and
 	  user-mode execution as quiescent states.  Not for manual selection.
 
+config TASKS_RUDE_RCU
+	def_bool 0
+	default n
+	help
+	  This option enables a task-based RCU implementation that uses
+	  only context switch (including preemption) and user-mode
+	  execution as quiescent states.  It forces IPIs and context
+	  switches on all online CPUs, including idle ones, so use
+	  with caution.  Not for manual selection.
+
 config RCU_STALL_COMMON
 	def_bool TREE_RCU
 	help
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d77921e..7ba1730 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -180,6 +180,9 @@ static void __init rcu_tasks_bootup_oddness(void)
 	else
 		pr_info("\tTasks RCU enabled.\n");
 #endif /* #ifdef CONFIG_TASKS_RCU */
+#ifdef CONFIG_TASKS_RUDE_RCU
+	pr_info("\tRude variant of Tasks RCU enabled.\n");
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 }
 
 #endif /* #ifndef CONFIG_TINY_RCU */
@@ -410,3 +413,98 @@ static int __init rcu_spawn_tasks_kthread(void)
 core_initcall(rcu_spawn_tasks_kthread);
 
 #endif /* #ifdef CONFIG_TASKS_RCU */
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+
+////////////////////////////////////////////////////////////////////////
+//
+// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
+// passing an empty function to schedule_on_each_cpu().  This approach
+// provides an asynchronous call_rcu_rude() API and batching of concurrent
+// calls to the synchronous synchronize_rcu_rude() API.  This sends IPIs
+// far and wide and induces otherwise unnecessary context switches on all
+// online CPUs, whether online or not.
+
+// Empty function to allow workqueues to force a context switch.
+static void rcu_tasks_be_rude(struct work_struct *work)
+{
+}
+
+// Wait for one rude RCU-tasks grace period.
+static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
+{
+	schedule_on_each_cpu(rcu_tasks_be_rude);
+}
+
+void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
+
+/**
+ * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_tasks_rude()
+ * assumes that the read-side critical sections end at context switch,
+ * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
+ * there are no read-side primitives analogous to rcu_read_lock() and
+ * rcu_read_unlock() because this primitive is intended to determine
+ * that all tasks have passed through a safe state, not so much for
+ * data-strcuture synchronization.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func)
+{
+	call_rcu_tasks_generic(rhp, func, &rcu_tasks_rude);
+}
+EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
+
+/**
+ * synchronize_rcu_tasks_rude - wait for a rude rcu-tasks grace period
+ *
+ * Control will return to the caller some time after a rude rcu-tasks
+ * grace period has elapsed, in other words after all currently
+ * executing rcu-tasks read-side critical sections have elapsed.  These
+ * read-side critical sections are delimited by calls to schedule(),
+ * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
+ * anyway) cond_resched().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function preambles
+ * and profiling hooks.  The synchronize_rcu_tasks_rude() function is not
+ * (yet) intended for heavy use from multiple CPUs.
+ *
+ * See the description of synchronize_rcu() for more detailed information
+ * on memory ordering guarantees.
+ */
+void synchronize_rcu_tasks_rude(void)
+{
+	synchronize_rcu_tasks_generic(&rcu_tasks_rude);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
+
+/**
+ * rcu_barrier_tasks_rude - Wait for in-flight call_rcu_tasks_rude() callbacks.
+ *
+ * Although the current implementation is guaranteed to wait, it is not
+ * obligated to, for example, if there are no pending callbacks.
+ */
+void rcu_barrier_tasks_rude(void)
+{
+	/* There is only one callback queue, so this is easy.  ;-) */
+	synchronize_rcu_tasks_rude();
+}
+EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
+
+static int __init rcu_spawn_tasks_rude_kthread(void)
+{
+	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
+	return 0;
+}
+core_initcall(rcu_spawn_tasks_rude_kthread);
+
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
-- 
2.9.5

