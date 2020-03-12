Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B739C2BB1D
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FE020751
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584037030;
	bh=pDOXfsxfN37+mNdugdxp+v5OVW3DKK/hyAd2WAUGaow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZPUhZcon7/byp6XKhijJVYmNWoo8sk/KsoAHx1iJd5nlizwTX0GZyXN2CjOKw6xzm
	 veiZPQHtOhayH5FwkJV9jLpLHK31JFcZtjTWH6cvNrNKyJ7vBvADxHvTodKI5lH1WM
	 Wv8JY5c7aR3WtjUEQHjPUlLYEW5F01jWWff2vTiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCLSRK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgCLSRJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BB120746;
        Thu, 12 Mar 2020 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037029;
        bh=pDOXfsxfN37+mNdugdxp+v5OVW3DKK/hyAd2WAUGaow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FuhBV1wgPy4v5zCfXuUBorhSLUuJjY8sgi2Vsc13mlvKj9vJ5tsRnY+yOHI9QAy8S
         WjsxT/XdlCqQWQkgM/EuU9jiFMZV8YOfSN2qm4epjM7sUqKabShDed+qucPNot5Wzy
         op4zNmUnquMEdmOIE5ISLDk5c1Dw9BWgb5ZVM8X8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 13/16] rcu-tasks: Code movement to allow more Tasks RCU variants
Date:   Thu, 12 Mar 2020 11:16:59 -0700
Message-Id: <20200312181702.8443-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
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
index a19bd92..b65c45f 100644
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

