Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900CEC2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6524121D91
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974802;
	bh=3fdVTnSi8comzUB1gb25PxrIATOeQNlocOtrX8eRTQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yfor+NL9Zku4lAh8zBOXdlUhGECnpMFR9HGe3gFU7quISUgXgO2SLegU78UhOUZ1L
	 nV0zQbg1F+KgufEh0Zs7tnkc6BFfeswpM0/DVYvOlzP0d62BPqi5MNsXsCCywMfU2O
	 KZ0sj1aDZcrrgS7NhdtnGdlcvdhM+QfXcwsnhi9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441405AbgDOSUA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441379AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F2521841;
        Wed, 15 Apr 2020 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974790;
        bh=3fdVTnSi8comzUB1gb25PxrIATOeQNlocOtrX8eRTQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROcFl8/t1yRIkNW8wNgiVnV2fxDeMY/pYPbOUjw+jqQTzymfTRN+DOs0DtpUnr5rl
         COKoxkA2FLgMQo0U/mMXaLrr3DM8KLGiMZeKQA+NeBmVv/RgapV6wMY/vyRyrfxL2p
         P3Z7jCDpJHBfAnfCMN4QFDUKPvnPqKxwWOiHU+Qo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 19/38] rcu-tasks: Add RCU tasks to rcutorture writer stall output
Date:   Wed, 15 Apr 2020 11:19:22 -0700
Message-Id: <20200415181941.11653-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds state for each RCU-tasks flavor to the rcutorture
writer stall output.  The initial state is minimal, but you have to
start somewhere.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Fixes based on feedback from kbuild test robot. ]
---
 kernel/rcu/rcu.h        |  1 +
 kernel/rcu/tasks.h      | 45 +++++++++++++++++++++++++++++++++++++++++++--
 kernel/rcu/tree_stall.h |  2 +-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 72903867..e1089fd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -431,6 +431,7 @@ bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+void show_rcu_tasks_gp_kthreads(void);
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d65a97f..cd220a4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -219,6 +219,16 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+/* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
+static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
+{
+	pr_info("%s %c%c %s\n",
+		rtp->kname,
+		".k"[!!data_race(rtp->kthread_ptr)],
+		".C"[!!data_race(rtp->cbs_head)],
+		s);
+}
+
 #ifdef CONFIG_TASKS_RCU
 
 ////////////////////////////////////////////////////////////////////////
@@ -482,7 +492,14 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-#endif /* #ifdef CONFIG_TASKS_RCU */
+static void show_rcu_tasks_classic_gp_kthread(void)
+{
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
+}
+
+#else /* #ifdef CONFIG_TASKS_RCU */
+static void show_rcu_tasks_classic_gp_kthread(void) { }
+#endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 
@@ -578,7 +595,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
-#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
+static void show_rcu_tasks_rude_gp_kthread(void)
+{
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
+}
+
+#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
+static void show_rcu_tasks_rude_gp_kthread(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -978,10 +1002,27 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
+static void show_rcu_tasks_trace_gp_kthread(void)
+{
+	char buf[32];
+
+	sprintf(buf, "N%d", atomic_read(&trc_n_readers_need_end));
+	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
+}
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
+static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
+void show_rcu_tasks_gp_kthreads(void)
+{
+	show_rcu_tasks_classic_gp_kthread();
+	show_rcu_tasks_rude_gp_kthread();
+	show_rcu_tasks_trace_gp_kthread();
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
+void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c65c975..e1c68a7 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -649,7 +649,7 @@ void show_rcu_gp_kthreads(void)
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
-	/* sched_show_task(rcu_state.gp_kthread); */
+	show_rcu_tasks_gp_kthreads();
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
-- 
2.9.5

