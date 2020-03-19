Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F04BC4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460FA2076E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576703;
	bh=CW0LY2uFVZoMzRslEsbQr0QZhSuVsd7+1u2mkTq+h7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgCHEF1UOyCYecob3DtkESCcLJtZBsQJ+Ixa+n6BCZwCOqMwgvL/p9U8QVYLLBH+R
	 f+fl1T7kTk1bO1U/gvioXju7u/wBDA0BBxd7CJrjUyOpMxeJFyErImMbrl/JZpPqed
	 FXlKcHAHD4Juq85RHUneVBflmIxqXJDJDXO+j6b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCSALc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgCSALI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D64320B80;
        Thu, 19 Mar 2020 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576667;
        bh=CW0LY2uFVZoMzRslEsbQr0QZhSuVsd7+1u2mkTq+h7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEnMYhFwxrnYPOWokPEc92n89IoOmvM6nwWd+zjilH6KTvJunPt3f/vsdhhKJZHAt
         OGPRmMMut5iXbgeH5j82gFcGedp9Wm6bI0/f9deQjx6V+61l6toWzRaVib3GLSHaU8
         7iuyERu/e6vIluvR0oymcArAcpZLQbyzPDCP1Ems=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 16/22] rcu-tasks: Add stall warnings for RCU Tasks Trace
Date:   Wed, 18 Mar 2020 17:10:54 -0700
Message-Id: <20200319001100.24917-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
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
 kernel/rcu/tasks.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 24f41ec..e6ef98e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -788,9 +788,41 @@ static void rcu_tasks_trace_postscan(void)
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
 
@@ -803,21 +835,53 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 		// If check succeeded, remove this task from the list.
 		if (READ_ONCE(t->trc_reader_checked))
 			trc_del_holdout(t);
+		else if (needreport)
+			show_stalled_task_trace(t, firstreport);
+	}
+	if (needreport) {
+		if (firstreport)
+			pr_err("INFO: rcu_tasks_trace detected stalls?\n");
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
+		for_each_process_thread(g, t) {
+			if (READ_ONCE(t->trc_reader_need_end)) {
+				trc_add_holdout(t, &holdouts);
+			}
+		}
+		firstreport = true;
+		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list)
+			if (READ_ONCE(t->trc_reader_need_end)) {
+				show_stalled_task_trace(t, &firstreport);
+				trc_del_holdout(t);
+			}
+		if (firstreport)
+			pr_err("INFO: rcu_tasks_trace detected stalls?\n");
+		show_stalled_ipi_trace();
+		pr_err("\t%d holdouts\n", atomic_read(&trc_n_readers_need_end));
+	}
 	smp_mb(); // Caller's code must be ordered after wakeup.
 }
 
-- 
2.9.5

