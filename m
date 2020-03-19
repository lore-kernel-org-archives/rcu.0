Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CCC4332E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8813D2076E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576702;
	bh=6PDa3XNPXriHi9UAkJzOREHqMAxi01bjS7XS4H73QPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wcv1FUT22bcfGSmt+XqUeNtvaiYLf/ZSNK8mQr/HT0J+m5l017Cjq78qrLfVioarq
	 iynKKVL2PbyTmFlmFltP53hIvNS7CYbZwrBEQ1JYhJUaNTeuPfwlausd+W6Q0AGG6T
	 zB8HLtm0oA/jiGO/dtVGwq0NhlqoZXgw9Afzqagw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgCSALc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgCSALI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F138121473;
        Thu, 19 Mar 2020 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576668;
        bh=6PDa3XNPXriHi9UAkJzOREHqMAxi01bjS7XS4H73QPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8J9U+RVqBznyc+e/Y7SkiQqH08Ehw/RJosGkg6EDJP0JTFvQ3RajGq9+iY8EZIt7
         5Ih9B3hSQI1KsqWV3s91PQhxuV2uymqp8rZU+wedJ/liacph7Q/jkGOYNtBsPEvwJX
         K9Dyk0fWFDYurE58m20GHMHi1JsOWNYHNv3VhYm0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 18/22] rcu-tasks: Add RCU tasks to rcutorture writer stall output
Date:   Wed, 18 Mar 2020 17:10:56 -0700
Message-Id: <20200319001100.24917-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
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
index 220f264..1583e45 100644
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
@@ -974,10 +998,27 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
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
index e19487d..ec8e985 100644
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

