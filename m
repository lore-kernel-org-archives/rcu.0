Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FFC433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A8920720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871903;
	bh=Q8NLZEd45N4ehcx4EwFJ37PD+DyIfid8oypDRZIwt+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bLTNLtS2wlOXnE3PPxkf+BvfxfGkHJ0amY84EPc/rLkC3m6dyXHCUlRCg83eqrufp
	 wsWFsEDTEzIgXsap3kqavs+cfJChXn43QyYk0VVfzalWCmsFJ1Y81v3jumONYvhYYN
	 iOpX+h9mMe1r0MEwHrNj6d9D9gtxkVl4/kYdH0gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgFWAYy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731580AbgFWAYq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:24:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BBF32082F;
        Tue, 23 Jun 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871885;
        bh=Q8NLZEd45N4ehcx4EwFJ37PD+DyIfid8oypDRZIwt+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhL+ge0VkHo7hrWcC2LMNrfZNIBO3sIPCWu/OOHY5xjB3ijve26LZ6DwRg4Zlie1f
         hxzfvip9DisBYH4wrCpn2xM4cHicAXjfkpbapPv9RUz/lW8s+I7IcS9+mYDcxTX9Ty
         9C6aANKL9SeLYVtbCJtZz61WnRbmC1eGKPNtLC9Q=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/5] rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()
Date:   Mon, 22 Jun 2020 17:24:42 -0700
Message-Id: <20200623002443.25954-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002423.GA25869@paulmck-ThinkPad-P72>
References: <20200623002423.GA25869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The show_rcu_tasks_gp_kthreads() function is not invoked by Tiny RCU,
but is nevertheless defined in Tiny RCU builds that enable Tasks Trace
RCU.  This commit therefore conditionally compiles this function so
that it is defined only in builds that actually use it.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index da200e5..d5c003c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -103,6 +103,7 @@ module_param(rcu_task_stall_timeout, int, 0644);
 #define RTGS_WAIT_READERS	 9
 #define RTGS_INVOKE_CBS		10
 #define RTGS_WAIT_CBS		11
+#ifndef CONFIG_TINY_RCU
 static const char * const rcu_tasks_gp_state_names[] = {
 	"RTGS_INIT",
 	"RTGS_WAIT_WAIT_CBS",
@@ -117,6 +118,7 @@ static const char * const rcu_tasks_gp_state_names[] = {
 	"RTGS_INVOKE_CBS",
 	"RTGS_WAIT_CBS",
 };
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -129,6 +131,7 @@ static void set_tasks_gp_state(struct rcu_tasks *rtp, int newstate)
 	rtp->gp_jiffies = jiffies;
 }
 
+#ifndef CONFIG_TINY_RCU
 /* Return state name. */
 static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 {
@@ -139,6 +142,7 @@ static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 		return "???";
 	return rcu_tasks_gp_state_names[j];
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
@@ -268,6 +272,7 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+#ifndef CONFIG_TINY_RCU
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
@@ -281,6 +286,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 
@@ -557,10 +563,12 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_classic_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
@@ -682,10 +690,12 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_rude_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_RUDE_RCU */
 static void show_rcu_tasks_rude_gp_kthread(void) {}
@@ -1164,6 +1174,7 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
@@ -1174,18 +1185,21 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
+#ifndef CONFIG_TINY_RCU
 void show_rcu_tasks_gp_kthreads(void)
 {
 	show_rcu_tasks_classic_gp_kthread();
 	show_rcu_tasks_rude_gp_kthread();
 	show_rcu_tasks_trace_gp_kthread();
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-- 
2.9.5

