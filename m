Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BD8C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB8A2076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974913;
	bh=xQQ5D9d5N12lUAswqMibvXSEwoQfdAIYn85iLDZ9dzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tnv/G2q3XCdTPzRVTnKM0dnzfquNn/6GR5AjClf8MFbrDAb7Nqda9vT5Dycv8h+Jt
	 WCcpDUKywvWZzPxYGYAjBb7N+P3vSp7YsZFDKsMBOu4507Ie/gfdDycE4HqvSdaarQ
	 RddT/EMY2YjpUjuGQhbBRo+e2pYqjIw1IVZQBUqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441484AbgDOSVv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441385AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB2D21927;
        Wed, 15 Apr 2020 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974791;
        bh=xQQ5D9d5N12lUAswqMibvXSEwoQfdAIYn85iLDZ9dzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kN/rPDifhOCIivsjkWD+S2MdMPt1wa7bJhtQ0xnRnHXaFiWFpEh/FctlXosl1EvWa
         YQtV2wkDF5509kdx8cKOkd/iFvH/fFNEvzNveLqe0UW2MvgCgI8TDK5d73hG/RDdfS
         5HWqFIZxJRhBQJZpGn7qZyCL9RHsTotTygwYPvTg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 23/38] rcu-tasks: Provide boot parameter to delay IPIs until late in grace period
Date:   Wed, 15 Apr 2020 11:19:26 -0700
Message-Id: <20200415181941.11653-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
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
index f2a93c8..aaa8678 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4286,6 +4286,13 @@
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
index 199f87a..6f4e8b1 100644
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
 
@@ -994,10 +1003,6 @@ void exit_tasks_rcu_finish_trace(struct task_struct *t)
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

