Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7633C43332
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3872421775
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576685;
	bh=kEtCd2H6wviAt60Qgr+GCKjJ9897aT8RrWZrPSPTuno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aGHeyEMmofshyVr9Y5K3nS5aUfJ0Nw27dZUO/dobF3ObN4gbyrPUrlFgn+jY45MGT
	 +4j5sQ+0JHGkCvK+nHuHEC84wcKch+Hw8UsGRCDjkGECp9tjmiIIN1tWLXm0Wta+6+
	 Ba51FXCcnkakV4M0En73T4OYfEKs5NTGWTODOPVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCSALL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbgCSALK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FB71215A4;
        Thu, 19 Mar 2020 00:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576669;
        bh=kEtCd2H6wviAt60Qgr+GCKjJ9897aT8RrWZrPSPTuno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fN3AsaH+W8GANy4Xx1Fors3pbU8sMU0SCJQwGp3hApC6lt/hTU4mBwQ05tz4IXGIO
         tw+aAF7FPH29DoqeZ0FUPu4VPRQ6X/sO0cpxhFTWpZuYLQhR/ug1dM2+2rHoVSN2HS
         XCMUghLt8TByC44aCnTN0xd0VMfVZNP2sDkuR/oY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 22/22] rcu-tasks: Provide boot parameter to delay IPIs until late in grace period
Date:   Wed, 18 Mar 2020 17:11:00 -0700
Message-Id: <20200319001100.24917-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit provides a rcupdate.rcu_task_ipi_delay kernel boot parameter
that specifies how old the RCU tasks trace grace period must be before
the grace-period kthread starts sending IPIs.  This delay allows more
tasks to pass through rcu_tasks_qs() quiescent states, thus reducing
(or even eliminating) the number of IPIs that must be sent.

On a short rcutorture test setting this kernel boot parameter to HZ/2
resulted in zero IPIs for all 877 RCU-tasks trace grace periods that
elapsed during that test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/rcu/tasks.h                              | 15 ++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 17eff15..2865767 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4242,6 +4242,13 @@
 			only normal grace-period primitives.  No effect
 			on CONFIG_TINY_RCU kernels.
 
+	rcupdate.rcu_task_ipi_delay= [KNL]
+			Set time in jiffies during which RCU tasks will
+			avoid sending IPIs, starting with the beginning
+			of a given grace period.  Setting a large
+			number avoids disturbing real-time workloads,
+			but lengthens grace periods.
+
 	rcupdate.rcu_task_stall_timeout= [KNL]
 			Set timeout in jiffies for RCU task stall warning
 			messages.  Disable with a value less than or equal
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6d237c4..d166797 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -74,6 +74,11 @@ static struct rcu_tasks rt_name =					\
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
+/* Avoid IPIing CPUs early in the grace period. */
+#define RCU_TASK_IPI_DELAY (HZ / 2)
+static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
+module_param(rcu_task_ipi_delay, int, 0644);
+
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
@@ -713,6 +718,10 @@ DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
+void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
+		 "RCU Tasks Trace");
+
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t)
 {
@@ -825,7 +834,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// If currently running, send an IPI, either way, add to list.
 	trc_add_holdout(t, bhp);
-	if (task_curr(t)) {
+	if (task_curr(t) && time_after(jiffies, rcu_tasks_trace.gp_start + rcu_task_ipi_delay)) {
 		// The task is currently running, so try IPIing it.
 		cpu = task_cpu(t);
 
@@ -990,10 +999,6 @@ void exit_tasks_rcu_finish_trace(struct task_struct *t)
 		rcu_read_unlock_trace_special(t);
 }
 
-void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
-		 "RCU Tasks Trace");
-
 /**
  * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
-- 
2.9.5

