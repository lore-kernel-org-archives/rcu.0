Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF515C2D0EE
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60692073E
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347952;
	bh=xmpPXkhiLbhrjsXBBcsPOaQA+awYMXNedi+3mo3OqIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1EOzs6D/6k+ceV7X+4FTowmiMY1UfF+R+WHCPnpjoM59qNJJTtWQPgofzmmXqu6GJ
	 CRXSO5RvhNDWbF0OM7xWT2SE8UmBzpLoroBsjjvhJNv+BLD7fHThYyvEepTpMVFVFx
	 G3PiFu/WgQt7xjwO1MCHpcD91UAKqVvGanGRf1IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgC0WZn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgC0WZJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E3C2218AC;
        Fri, 27 Mar 2020 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347908;
        bh=xmpPXkhiLbhrjsXBBcsPOaQA+awYMXNedi+3mo3OqIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Izf6c6yzMF5k6BVic5e/zHcV5IiG70GX0wOmt+KZsUGY2kChc2ETv/MZZBmu+7V2Z
         fgcMiQ8n96g2bGvlraeczf58BfkDNkvytwSVdnDsPijEps28Wujf4746BE7g+EYJze
         7lIp8BkLoElmSebwUUKxtp+1to5ykqf+O66OLKmw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 30/34] rcu-tasks: Make RCU tasks trace also wait for idle tasks
Date:   Fri, 27 Mar 2020 15:24:52 -0700
Message-Id: <20200327222456.12470-30-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit scans the CPUs, adding each CPU's idle task to the list of
tasks that need quiescent states.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d1fa7715..27d2458 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -15,7 +15,7 @@ struct rcu_tasks;
 typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
 typedef void (*pregp_func_t)(void);
 typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
-typedef void (*postscan_func_t)(void);
+typedef void (*postscan_func_t)(struct list_head *hop);
 typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
@@ -331,7 +331,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rcu_read_unlock();
 
 	set_tasks_gp_state(rtp, RTGS_POST_SCAN_TASKLIST);
-	rtp->postscan_func();
+	rtp->postscan_func(&holdouts);
 
 	/*
 	 * Each pass through the following loop scans the list of holdout
@@ -415,7 +415,7 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 }
 
 /* Processing between scanning taskslist and draining the holdout list. */
-void rcu_tasks_postscan(void)
+void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
 	 * Wait for tasks that are in the process of exiting.  This
@@ -932,9 +932,17 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 	trc_wait_for_one_reader(t, hop);
 }
 
-/* Do intermediate processing between task and holdout scans. */
-static void rcu_tasks_trace_postscan(void)
+/*
+ * Do intermediate processing between task and holdout scans and
+ * pick up the idle tasks.
+ */
+static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		rcu_tasks_trace_pertask(idle_task(cpu), hop);
+
 	// Re-enable CPU hotplug now that the tasklist scan has completed.
 	cpus_read_unlock();
 
-- 
2.9.5

