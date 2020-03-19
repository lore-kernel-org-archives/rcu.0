Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1857C4332E
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EF920773
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576663;
	bh=p1HFFa2dr+H3CbUCQb9zCoHx/PmDz1kGbO4UAmnY2Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pqMBTobYnPgYnko5yq2Cd2vcOU1hrYBv7xshmcFNCnrlj2nkKiw8Ym2k5ymrACjyt
	 zCzdM3BDlCNESOXIE4eI5zb/laNNGlcLEasvQ4gTrN3RgutUiITgksy9n7773usFvj
	 tkgxVI6wW+UpUlkx/xdJFvCrQiSokAgV0Lu0/iUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCSALD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSALD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DEC2076E;
        Thu, 19 Mar 2020 00:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576662;
        bh=p1HFFa2dr+H3CbUCQb9zCoHx/PmDz1kGbO4UAmnY2Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSlMkiqBJ/DkMyy/dxp0J7fNr06wU6ntA4dO7PUil7RwQ44b2svNOaeFMQrP5OtN2
         sjfrm5a3QEqZQbUFB2Eca9Xwxtfp6z9U83fbOKBy5ufp7o3LLRAqeeHRynOHPU58z9
         eHQ107mKCmeo4/2+J/tvAtZGlGKfFlu6SB0h4XIc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to sample state of locked-down task
Date:   Wed, 18 Mar 2020 17:10:39 -0700
Message-Id: <20200319001100.24917-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

A running task's state can be sampled in a consistent manner (for example,
for diagnostic purposes) simply by invoking smp_call_function_single()
on its CPU, which may be obtained using task_cpu(), then having the
IPI handler verify that the desired task is in fact still running.
However, if the task is not running, this sampling can in theory be done
immediately and directly.  In practice, the task might start running at
any time, including during the sampling period.  Gaining a consistent
sample of a not-running task therefore requires that something be done
to lock down the target task's state.

This commit therefore adds a try_invoke_on_locked_down_task() function
that invokes a specified function if the specified task can be locked
down, returning true if successful and if the specified function returns
true.  Otherwise this function simply returns false.  Given that the
function passed to try_invoke_on_nonrunning_task() might be invoked with
a runqueue lock held, that function had better be quite lightweight.

The function is passed the target task's task_struct pointer and the
argument passed to try_invoke_on_locked_down_task(), allowing easy access
to task state and to a location for further variables to be passed in
and out.

Note that the specified function will be called even if the specified
task is currently running.  The function can use ->on_rq and task_curr()
to quickly and easily determine the task's state, and can return false
if this state is not to the function's liking.  The caller of teh
try_invoke_on_locked_down_task() would then see the false return value,
and could take appropriate action, for example, trying again later or
sending an IPI if matters are more urgent.

It is expected that use cases such as the RCU CPU stall warning code will
simply return false if the task is currently running.  However, there are
use cases involving nohz_full CPUs where the specified function might
instead fall back to an alternative sampling scheme that relies on heavier
synchronization (such as memory barriers) in the target task.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ paulmck: Apply feedback from Peter Zijlstra and Steven Rostedt. ]
[ paulmck: Invoke if running to handle feedback from Mathieu Desnoyers. ]
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
---
 include/linux/wait.h |  2 ++
 kernel/sched/core.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 3283c8d..e2bb8ed 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1148,4 +1148,6 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
 		(wait)->flags = 0;						\
 	} while (0)
 
+bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg);
+
 #endif /* _LINUX_WAIT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc0..195eba0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2580,6 +2580,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 *
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
+	 *
+	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -2654,6 +2656,52 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 }
 
 /**
+ * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
+ * @p: Process for which the function is to be invoked.
+ * @func: Function to invoke.
+ * @arg: Argument to function.
+ *
+ * If the specified task can be quickly locked into a definite state
+ * (either sleeping or on a given runqueue), arrange to keep it in that
+ * state while invoking @func(@arg).  This function can use ->on_rq and
+ * task_curr() to work out what the state is, if required.  Given that
+ * @func can be invoked with a runqueue lock held, it had better be quite
+ * lightweight.
+ *
+ * Returns:
+ *	@false if the task slipped out from under the locks.
+ *	@true if the task was locked onto a runqueue or is sleeping.
+ *		However, @func can override this by returning @false.
+ */
+bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
+{
+	bool ret = false;
+	struct rq_flags rf;
+	struct rq *rq;
+
+	lockdep_assert_irqs_enabled();
+	raw_spin_lock_irq(&p->pi_lock);
+	if (p->on_rq) {
+		rq = __task_rq_lock(p, &rf);
+		if (task_rq(p) == rq)
+			ret = func(p, arg);
+		rq_unlock(rq, &rf);
+	} else {
+		switch (p->state) {
+		case TASK_RUNNING:
+		case TASK_WAKING:
+			break;
+		default:
+			smp_rmb();
+			if (!p->on_rq)
+				ret = func(p, arg);
+		}
+	}
+	raw_spin_unlock_irq(&p->pi_lock);
+	return ret;
+}
+
+/**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
  *
-- 
2.9.5

