Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC42C2D0F0
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064FA20857
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347979;
	bh=rbRByjaGsuOpTa9qP5IJ2JcoNu5IZVQh0K93MG0arIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dIityGN0F1M1kRQQhfEFpGwPo08qD2aPdxo0kDCBl49loZr5zTgsBTNDNplS/Wr3U
	 +w4LV0F25pBQu1A7fwe1+TI+5mkNm07bz2vXsi4VkeD4a0xxMTS7A8HuSJN9ztA7vx
	 SU9L6kT0iqkAcXn5QkCbBl8Cxx+etPsUxwLeM4V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgC0W0S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgC0WZD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C591214D8;
        Fri, 27 Mar 2020 22:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347902;
        bh=rbRByjaGsuOpTa9qP5IJ2JcoNu5IZVQh0K93MG0arIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVF7gNZNlpJXF/7KQSWGAGt2Hcy/XSGmFXwvUdffb+3d+4vTUnhtm2DARJPpKlBFn
         sceMyoM8kChVoWv5QdJTdm7Np1k8inkn+mwReQIbr8NRrvS93kIuidW3TCaoox41fW
         SRH12uhCE4ghlcfpMWtU3eE2k6HoeA9GwTjT/AAw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 13/34] rcu-tasks: Code movement to allow more Tasks RCU variants
Date:   Fri, 27 Mar 2020 15:24:35 -0700
Message-Id: <20200327222456.12470-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit does nothing but move rcu_tasks_wait_gp() up to a new section
for common code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 122 +++++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 59 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 344426e..d8b09d5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -213,6 +213,69 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 ////////////////////////////////////////////////////////////////////////
 //
+// Shared code between task-list-scanning variants of Tasks RCU.
+
+/* Wait for one RCU-tasks grace period. */
+static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
+{
+	struct task_struct *g, *t;
+	unsigned long lastreport;
+	LIST_HEAD(holdouts);
+	int fract;
+
+	rtp->pregp_func();
+
+	/*
+	 * There were callbacks, so we need to wait for an RCU-tasks
+	 * grace period.  Start off by scanning the task list for tasks
+	 * that are not already voluntarily blocked.  Mark these tasks
+	 * and make a list of them in holdouts.
+	 */
+	rcu_read_lock();
+	for_each_process_thread(g, t)
+		rtp->pertask_func(t, &holdouts);
+	rcu_read_unlock();
+
+	rtp->postscan_func();
+
+	/*
+	 * Each pass through the following loop scans the list of holdout
+	 * tasks, removing any that are no longer holdouts.  When the list
+	 * is empty, we are done.
+	 */
+	lastreport = jiffies;
+
+	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
+	fract = 10;
+
+	for (;;) {
+		bool firstreport;
+		bool needreport;
+		int rtst;
+
+		if (list_empty(&holdouts))
+			break;
+
+		/* Slowly back off waiting for holdouts */
+		schedule_timeout_interruptible(HZ/fract);
+
+		if (fract > 1)
+			fract--;
+
+		rtst = READ_ONCE(rcu_task_stall_timeout);
+		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
+		if (needreport)
+			lastreport = jiffies;
+		firstreport = true;
+		WARN_ON(signal_pending(current));
+		rtp->holdouts_func(&holdouts, needreport, &firstreport);
+	}
+
+	rtp->postgp_func();
+}
+
+////////////////////////////////////////////////////////////////////////
+//
 // Simple variant of RCU whose quiescent states are voluntary context
 // switch, cond_resched_rcu_qs(), user-space execution, and idle.
 // As such, grace periods can take one good long time.  There are no
@@ -333,65 +396,6 @@ static void rcu_tasks_postgp(void)
 	synchronize_rcu();
 }
 
-/* Wait for one RCU-tasks grace period. */
-static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
-{
-	struct task_struct *g, *t;
-	unsigned long lastreport;
-	LIST_HEAD(holdouts);
-	int fract;
-
-	rtp->pregp_func();
-
-	/*
-	 * There were callbacks, so we need to wait for an RCU-tasks
-	 * grace period.  Start off by scanning the task list for tasks
-	 * that are not already voluntarily blocked.  Mark these tasks
-	 * and make a list of them in holdouts.
-	 */
-	rcu_read_lock();
-	for_each_process_thread(g, t)
-		rtp->pertask_func(t, &holdouts);
-	rcu_read_unlock();
-
-	rtp->postscan_func();
-
-	/*
-	 * Each pass through the following loop scans the list of holdout
-	 * tasks, removing any that are no longer holdouts.  When the list
-	 * is empty, we are done.
-	 */
-	lastreport = jiffies;
-
-	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
-	fract = 10;
-
-	for (;;) {
-		bool firstreport;
-		bool needreport;
-		int rtst;
-
-		if (list_empty(&holdouts))
-			break;
-
-		/* Slowly back off waiting for holdouts */
-		schedule_timeout_interruptible(HZ/fract);
-
-		if (fract > 1)
-			fract--;
-
-		rtst = READ_ONCE(rcu_task_stall_timeout);
-		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
-		if (needreport)
-			lastreport = jiffies;
-		firstreport = true;
-		WARN_ON(signal_pending(current));
-		rtp->holdouts_func(&holdouts, needreport, &firstreport);
-	}
-
-	rtp->postgp_func();
-}
-
 void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
 
-- 
2.9.5

