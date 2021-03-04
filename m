Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D945AC433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD8E64F9D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbhCDBBS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355337AbhCDAd1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:33:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D561D64EE4;
        Thu,  4 Mar 2021 00:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817966;
        bh=kTKBnDf6S5oQSLVubizC3D3zva8T+YonBRP+hWWdGXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgrxnXhgchztLRPFUzBr0yyTNHw3Xs+Q8Vi7IQKinIyRbCtyB4oIFPcAQ1Tt3tIXE
         JMKt1OytcF5xZQjgbIwwSulLaw37chNb1zR2ClbjBRqYJcdkBaGHV+uo4m4EcNAtoG
         SM5zbgFfTFyeq+TM3zsNiTWzaTUrWjuk3hZtiy8OXujwwJymJNXuMbFSqotr1LY4p/
         mhQYiB4vngDFSKFeuWa+pn7vvOfNGRNGz/4Ubgzk6t71sqvDT+noMeoDTXsMCsi1dq
         A1rDtqlwOUucaIQPL+c8UCuEoPigoZz3OqOudf60a1iTwCFhqTqJNz1S787XiUIF1l
         Lx4/ye310oAvQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/2] rcu-tasks: Add block comment laying out RCU Tasks Trace design
Date:   Wed,  3 Mar 2021 16:32:45 -0800
Message-Id: <20210304003245.24327-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003226.GA24261@paulmck-ThinkPad-P72>
References: <20210304003226.GA24261@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a block comment that gives a high-level overview of
how RCU tasks trace grace periods progress.  It also adds a note about
how exiting tasks are handled, plus it gives an overview of the memory
ordering.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
[ paulmck: Fix commit log per Mathieu Desnoyers feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 17c8ebe..f818357 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -726,6 +726,42 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 // flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
 // readers can operate from idle, offline, and exception entry/exit in no
 // way allows rcu_preempt and rcu_sched readers to also do so.
+//
+// The implementation uses rcu_tasks_wait_gp(), which relies on function
+// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_trace_kthread()
+// function sets these function pointers up so that rcu_tasks_wait_gp()
+// invokes these functions in this order:
+//
+// rcu_tasks_trace_pregp_step():
+//	Initialize the count of readers and block CPU-hotplug operations.
+// rcu_tasks_trace_pertask(), invoked on every non-idle task:
+//	Initialize per-task state and attempt to identify an immediate
+//	quiescent state for that task, or, failing that, attempt to set
+//	that task's .need_qs flag so that that task's next outermost
+//	rcu_read_unlock_trace() will report the quiescent state (in which
+//	case the count of readers is incremented).  If both attempts fail,
+//	the task is added to a "holdout" list.
+// rcu_tasks_trace_postscan():
+//	Initialize state and attempt to identify an immediate quiescent
+//	state as above (but only for idle tasks), unblock CPU-hotplug
+//	operations, and wait for an RCU grace period to avoid races with
+//	tasks that are in the process of exiting.
+// check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
+//	Scans the holdout list, attempting to identify a quiescent state
+//	for each task on the list.  If there is a quiescent state, the
+//	corresponding task is removed from the holdout list.
+// rcu_tasks_trace_postgp():
+//	Wait for the count of readers do drop to zero, reporting any stalls.
+//	Also execute full memory barriers to maintain ordering with code
+//	executing after the grace period.
+//
+// The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
+//
+// Pre-grace-period update-side code is ordered before the grace
+// period via the ->cbs_lock and barriers in rcu_tasks_kthread().
+// Pre-grace-period read-side code is ordered before the grace period by
+// atomic_dec_and_test() of the count of readers (for IPIed readers) and by
+// scheduler context-switch ordering (for locked-down non-running readers).
 
 // The lockdep state must be outside of #ifdef to be useful.
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-- 
2.9.5

