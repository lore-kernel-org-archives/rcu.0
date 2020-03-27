Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C80C43331
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B522074A
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347978;
	bh=Xkh1no5YKGIbTvpLniv6B5Dam6nMeos4ZGt5eFKSZGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=apu4jK0JgLgl4p7iAbEkgenQQHMmIPbUZuQRbky/8fi8RQCCKNmrrdovV77gzTzFw
	 rpG3mSisKvrvYqiKb8nDkLzJBqPVD4bYsaHOxLPalXqanwgF5OBlvbJevVMJZzWQop
	 rF28BnzFGdDyVI1pkxXESky72gHn24ZiY6OzkVcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgC0W0N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:26:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgC0WZD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B656A2166E;
        Fri, 27 Mar 2020 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347902;
        bh=Xkh1no5YKGIbTvpLniv6B5Dam6nMeos4ZGt5eFKSZGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCiMx+8OHafKKul2pb7vTX1x/f5hRoKztIGKNb88LdV2rpTN5sG7RiG8iumrSa2AH
         iDBQ6bWsVZPd02UEMHQ/eN8pWqDcTt3MZUNQ1TvIcD4j2NIi0SujpSrXRlZzvE7CBw
         T92QYTwEJaLuqdL3oF71Tt/KcLW1KxGTWHeIupB8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 11/34] rcu-tasks: Use unique names for RCU-Tasks kthreads and messages
Date:   Fri, 27 Mar 2020 15:24:33 -0700
Message-Id: <20200327222456.12470-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit causes the flavors of RCU Tasks to use different names
for their kthreads and in their console messages.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7f9ed20..9ca83c6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -22,6 +22,8 @@ typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @call_func: This flavor's call_rcu()-equivalent function.
+ * @name: This flavor's textual name.
+ * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
 	struct rcu_head *cbs_head;
@@ -31,16 +33,20 @@ struct rcu_tasks {
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	call_rcu_func_t call_func;
+	char *name;
+	char *kname;
 };
 
-#define DEFINE_RCU_TASKS(name, gp, call)				\
-static struct rcu_tasks name =						\
+#define DEFINE_RCU_TASKS(rt_name, gp, call, n)				\
+static struct rcu_tasks rt_name =					\
 {									\
-	.cbs_tail = &name.cbs_head,					\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(name.cbs_wq),		\
-	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(name.cbs_lock),		\
+	.cbs_tail = &rt_name.cbs_head,					\
+	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),	\
+	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_lock),		\
 	.gp_func = gp,							\
 	.call_func = call,						\
+	.name = n,							\
+	.kname = #rt_name,						\
 }
 
 /* Track exiting tasks in order to allow them to be waited for. */
@@ -145,8 +151,8 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, rtp, "rcu_tasks_kthread");
-	if (WARN_ONCE(IS_ERR(t), "%s: Could not start Tasks-RCU grace-period kthread, OOM is now expected behavior\n", __func__))
+	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
+	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
 	smp_mb(); /* Ensure others see full kthread. */
 }
@@ -342,7 +348,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 }
 
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
 /**
  * call_rcu_tasks() - Queue an RCU for invocation task-based grace period
@@ -437,7 +443,8 @@ static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 }
 
 void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude);
+DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
+		 "RCU Tasks Rude");
 
 /**
  * call_rcu_tasks_rude() - Queue a callback rude task-based grace period
-- 
2.9.5

