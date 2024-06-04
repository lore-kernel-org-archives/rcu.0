Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE728DC7;
	Tue,  4 Jun 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540505; cv=none; b=NChVKq3f5M/6jV3iIpq640GoIKUEM92U7sv1Xh6pGKCFvMNzfSVYtzWtxxtxTekxgV8SOwnELXxWE2nZO/Zn38wqzpOPjtmEKbawvcY0Ma1WKMrLqaSiMCTVcAUP+dNLAmlOZ2v5sN0qj4/lH9WyJaRzdyrSoqRr+tWfDu99doI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540505; c=relaxed/simple;
	bh=0w+XFX5iP9DXuqSOmVXw0toJFkUbkGvi/AYanwDFLfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oavoRRsXGqJqRKBHH9eLGBElDIxv0dpe8Sqq/DjPtMUHS7gcu9C9UkvhVSg10cp6gnAtofZICdvzko/StDC9h0syppcgqoDHZE5VLw7jmkgjLWZf6anmS+R2B+lLJI+FbF6ZS/tTL1C3/yEu/nG1An4cvkYQOY5ZOxY9PcZUGVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE2lu9Bh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE2lu9Bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E20C2BBFC;
	Tue,  4 Jun 2024 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540504;
	bh=0w+XFX5iP9DXuqSOmVXw0toJFkUbkGvi/AYanwDFLfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qE2lu9Bhp5hJb5Q8VM0hfWAKUjJ7VZ0sY2Qw4n+yA11MBaV+9s8Zg7JyvLTeUhlDs
	 1g6JbLQjHvWGNMY1BIC4QMMhQzTjv099sGIMLwF2ztQL88K1xeD8CBoEL/W1cgeY6A
	 cxZuceYSljhZAvzRBFHWOwARrdb20+EGrs1RnQOr4xC39PEfg8Py+HJsoizIJ1kIwT
	 rq5UtzuFAYXv8tc3QvW11NlFTUFZaW8eXE4tUuXFpvSzTLMp2dJSGCn10Jze1Cgt7K
	 FYhTYZMl+6CWtenK46B1YqJIvhaDiBtG2zOe+ZawiOVHSLH11DzGWTkCPsWdvl12lJ
	 sKU9Qkt5jTZKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48DF3CE3ED6; Tue,  4 Jun 2024 15:35:04 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/2] Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()"
Date: Tue,  4 Jun 2024 15:35:01 -0700
Message-Id: <20240604223502.2371550-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e3f5a71d-09ca-4882-a7f1-5680ad28c8c0@paulmck-laptop>
References: <e3f5a71d-09ca-4882-a7f1-5680ad28c8c0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

This reverts commit 28319d6dc5e2ffefa452c2377dd0f71621b5bff0. The race
it fixed was subject to conditions that don't exist anymore since:

	1612160b9127 ("rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks")

This latter commit removes the use of SRCU that used to cover the
RCU-tasks blind spot on exit between the tasklist's removal and the
final preemption disabling. The task is now placed instead into a
temporary list inside which voluntary sleeps are accounted as RCU-tasks
quiescent states. This would disarm the deadlock initially reported
against PID namespace exit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  2 --
 kernel/pid_namespace.c   | 17 -----------------
 kernel/rcu/tasks.h       | 16 +++-------------
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dfd2399f2cde0..61cb3de236af1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -209,7 +209,6 @@ void synchronize_rcu_tasks_rude(void);
 
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
 void exit_tasks_rcu_start(void);
-void exit_tasks_rcu_stop(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
@@ -218,7 +217,6 @@ void exit_tasks_rcu_finish(void);
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
-static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index dc48fecfa1dce..b566ae827cfcc 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -248,24 +248,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
-		/*
-		 * Release tasks_rcu_exit_srcu to avoid following deadlock:
-		 *
-		 * 1) TASK A unshare(CLONE_NEWPID)
-		 * 2) TASK A fork() twice -> TASK B (child reaper for new ns)
-		 *    and TASK C
-		 * 3) TASK B exits, kills TASK C, waits for TASK A to reap it
-		 * 4) TASK A calls synchronize_rcu_tasks()
-		 *                   -> synchronize_srcu(tasks_rcu_exit_srcu)
-		 * 5) *DEADLOCK*
-		 *
-		 * It is considered safe to release tasks_rcu_exit_srcu here
-		 * because we assume the current task can not be concurrently
-		 * reaped at this point.
-		 */
-		exit_tasks_rcu_stop();
 		schedule();
-		exit_tasks_rcu_start();
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e1bf33018e6d5..4dc56b6e27c04 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -858,7 +858,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	not know to synchronize with this RCU Tasks grace period) have
 //	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
 //	will take care of any tasks stuck in the non-preemptible region
-//	of do_exit() following its call to exit_tasks_rcu_stop().
+//	of do_exit() following its call to exit_tasks_rcu_finish().
 // check_all_holdout_tasks(), repeatedly until holdout list is empty:
 //	Scans the holdout list, attempting to identify a quiescent state
 //	for each task on the list.  If there is a quiescent state, the
@@ -1220,7 +1220,7 @@ void exit_tasks_rcu_start(void)
  * Remove the task from the "yet another list" because do_exit() is now
  * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void)
+void exit_tasks_rcu_finish(void)
 {
 	unsigned long flags;
 	struct rcu_tasks_percpu *rtpcp;
@@ -1231,22 +1231,12 @@ void exit_tasks_rcu_stop(void)
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	list_del_init(&t->rcu_tasks_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-}
 
-/*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
- */
-void exit_tasks_rcu_finish(void)
-{
-	exit_tasks_rcu_stop();
-	exit_tasks_rcu_finish_trace(current);
+	exit_tasks_rcu_finish_trace(t);
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
-void exit_tasks_rcu_stop(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
-- 
2.40.1

