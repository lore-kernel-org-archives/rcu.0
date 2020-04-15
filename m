Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C616C3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0BE2076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974950;
	bh=CREK/4xWAPDKdSLrKVT8dF+892shUYFesqjOLk/8TFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rD6ass5zoTk3EPVFvcxsVinwh1LEbr7kaTvCNJNDgxK/UnpfGGY1bR2XfD2IAyVKq
	 RWelHVpADvTgY8XZ9Xtk04MP5JzxegK7HsIBLHvg2InLPQwfS5s4k+7KI1oHLCqvaS
	 /hN76jTOx9/6hjJO0OBtuo65lH7OKIkFhPZLqcwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416606AbgDOSWZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441377AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58827217D8;
        Wed, 15 Apr 2020 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974789;
        bh=CREK/4xWAPDKdSLrKVT8dF+892shUYFesqjOLk/8TFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhyQqdppzs/U4E6afk9NgA5IVkkY7wfiiOmEcdeZnagGFgepXFVJZjEJxSIU6sice
         08Oy9bSXVwqWHp3Arc7k/OCKWPInvm7hAXDKbeW+b/jXDMUeGWYA21Vfg70vQntxhh
         Io2Es+XQg6p0n1HKrnnFa7bWB60H4Qf3i+JW+8qE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 17/38] rcu-tasks: Add stall warnings for RCU Tasks Trace
Date:   Wed, 15 Apr 2020 11:19:20 -0700
Message-Id: <20200415181941.11653-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds RCU CPU stall warnings for RCU Tasks Trace.  These
dump out any tasks blocking the current grace period, as well as any
CPUs that have not responded to an IPI request.  This happens in two
phases, when initially extracting state from the tasks and later when
waiting for any holdout tasks to check in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a5ed7e2..1484e8c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -794,9 +794,41 @@ static void rcu_tasks_trace_postscan(void)
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
 
+/* Show the state of a task stalling the current RCU tasks trace GP. */
+static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
+{
+	int cpu;
+
+	if (*firstreport) {
+		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
+		*firstreport = false;
+	}
+	// FIXME: This should attempt to use try_invoke_on_nonrunning_task().
+	cpu = task_cpu(t);
+	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
+		 t->pid,
+		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
+		 ".i"[is_idle_task(t)],
+		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
+		 t->trc_reader_nesting,
+		 " N"[!!t->trc_reader_need_end],
+		 cpu);
+	sched_show_task(t);
+}
+
+/* List stalled IPIs for RCU tasks trace. */
+static void show_stalled_ipi_trace(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (per_cpu(trc_ipi_to_cpu, cpu))
+			pr_alert("\tIPI outstanding to CPU %d\n", cpu);
+}
+
 /* Do one scan of the holdout list. */
 static void check_all_holdout_tasks_trace(struct list_head *hop,
-					  bool ndrpt, bool *frptp)
+					  bool needreport, bool *firstreport)
 {
 	struct task_struct *g, *t;
 
@@ -809,21 +841,51 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 		// If check succeeded, remove this task from the list.
 		if (READ_ONCE(t->trc_reader_checked))
 			trc_del_holdout(t);
+		else if (needreport)
+			show_stalled_task_trace(t, firstreport);
+	}
+	if (needreport) {
+		if (firstreport)
+			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
+		show_stalled_ipi_trace();
 	}
 }
 
 /* Wait for grace period to complete and provide ordering. */
 static void rcu_tasks_trace_postgp(void)
 {
+	bool firstreport;
+	struct task_struct *g, *t;
+	LIST_HEAD(holdouts);
+	long ret;
+
 	// Remove the safety count.
 	smp_mb__before_atomic();  // Order vs. earlier atomics
 	atomic_dec(&trc_n_readers_need_end);
 	smp_mb__after_atomic();  // Order vs. later atomics
 
 	// Wait for readers.
-	wait_event_idle_exclusive(trc_wait,
-				  atomic_read(&trc_n_readers_need_end) == 0);
-
+	for (;;) {
+		ret = wait_event_idle_exclusive_timeout(
+				trc_wait,
+				atomic_read(&trc_n_readers_need_end) == 0,
+				READ_ONCE(rcu_task_stall_timeout));
+		if (ret)
+			break;  // Count reached zero.
+		for_each_process_thread(g, t)
+			if (READ_ONCE(t->trc_reader_need_end))
+				trc_add_holdout(t, &holdouts);
+		firstreport = true;
+		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list)
+			if (READ_ONCE(t->trc_reader_need_end)) {
+				show_stalled_task_trace(t, &firstreport);
+				trc_del_holdout(t);
+			}
+		if (firstreport)
+			pr_err("INFO: rcu_tasks_trace detected stalls? (Counter/taskslist mismatch?)\n");
+		show_stalled_ipi_trace();
+		pr_err("\t%d holdouts\n", atomic_read(&trc_n_readers_need_end));
+	}
 	smp_mb(); // Caller's code must be ordered after wakeup.
 }
 
-- 
2.9.5

