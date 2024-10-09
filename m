Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803861E25E5;
	Wed,  9 Oct 2024 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478342; cv=none; b=T64z/vE6xyca2K8zJBSMjnkq75Rsui5MewutdWMYbK4RljFzw4DNshDjoRyXk5IAI6LdDqxl4N9HY+PwABUIWUelOWs3+e4LyMlWyKqQstrfenvj6lJTzOhgPvgjU5LnIEye8Fy0uNfLu6L/36H1xSOKMbJMVghaiLCYkXtL/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478342; c=relaxed/simple;
	bh=5GHN3TQydO4+DYblsifPfmO2C1JXUc1tJrJ11vf8hJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IsSfT9vRz8dv1H83dt29pvVRj59b54PvUaiemPSi+Fz1MCbswkuM9gdxnBKNWbAvgmtzbVtzpKWhJSIWPL97qFEe3C7wCn65FahPdQRz2JKEB3NE0z7sOTNbJV+Kpm9NFwZQHXt4XNLZyiCsKqNNC5eF8PsA07b8H1TymbybBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaGKqEeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaGKqEeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB86DC4CED1;
	Wed,  9 Oct 2024 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478342;
	bh=5GHN3TQydO4+DYblsifPfmO2C1JXUc1tJrJ11vf8hJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaGKqEeFN0PwyFg/+8hX9ylsmGNk289GmEKjA1KNrlB6ZRKGO+vWPuHHyqzJmaCf0
	 OrxeZjwjhLoEibjLP0JKyTanXAxNvbMadz6cd6FVH5eNkqDdxrqdNF5Gw56qsvHDkO
	 k3fVN0xnaNdBJ24a5+GDLuiu0n6ItV8ayBKcae7GJNilks2W1xlIgXPSTfWbRedF7C
	 lWxoxSkTL0EpXubTWHdVhqBUWoNn8G82jEY4Yi/RbZa1F9qnvreNuasqZzUFLalvU2
	 vSYOVrWgyY/Oj2lHQ62EKMwaKroSQcN/5cHMNbPj9b75Q2vn4NeoF58k11QiASISe9
	 RPjK9XhHmVfxQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joel@joelfernandes.org,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	peterz@infradead.org,
	neeraj.upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH v2 08/10] rcu/tasks: Make RCU-tasks pay attention to idle tasks
Date: Wed,  9 Oct 2024 18:21:25 +0530
Message-Id: <20241009125127.18902-9-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
References: <20241009125127.18902-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Currently, idle tasks are ignored by RCU-tasks. Change this to
start paying attention to idle tasks except in deep-idle functions
where RCU is not watching. With this, for architectures where
kernel entry/exit and deep-idle functions have been properly tagged
noinstr, Tasks Rude RCU can be disabled.

[ neeraj.upadhyay: Frederic Weisbecker and Paul E. McKenney feedback. ]

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 12 +++---
 kernel/rcu/tasks.h                            | 41 ++++++++-----------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 6125e7068d2c..5016b85d53d7 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2611,8 +2611,8 @@ critical sections that are delimited by voluntary context switches, that
 is, calls to schedule(), cond_resched(), and
 synchronize_rcu_tasks(). In addition, transitions to and from
 userspace execution also delimit tasks-RCU read-side critical sections.
-Idle tasks are ignored by Tasks RCU, and Tasks Rude RCU may be used to
-interact with them.
+Idle tasks which are idle from RCU's perspective are ignored by Tasks RCU,
+and Tasks Rude RCU may be used to interact with them.
 
 Note well that involuntary context switches are *not* Tasks-RCU quiescent
 states.  After all, in preemptible kernels, a task executing code in a
@@ -2643,10 +2643,10 @@ moniker.  And this operation is considered to be quite rude by real-time
 workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
 by battery-powered systems that don't want their idle CPUs to be awakened.
 
-Once kernel entry/exit and deep-idle functions have been properly tagged
-``noinstr``, Tasks RCU can start paying attention to idle tasks (except
-those that are idle from RCU's perspective) and then Tasks Rude RCU can
-be removed from the kernel.
+As Tasks RCU now pays attention to idle tasks (except those that are idle
+from RCU's perspective), once kernel entry/exit and deep-idle functions have
+been properly tagged ``noinstr``, Tasks Rude RCU can be removed from the
+kernel.
 
 The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
 consisting solely of synchronize_rcu_tasks_rude().
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1947f9b6346d..72dc0d0a4a8f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -912,14 +912,15 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 ////////////////////////////////////////////////////////////////////////
 //
 // Simple variant of RCU whose quiescent states are voluntary context
-// switch, cond_resched_tasks_rcu_qs(), user-space execution, and idle.
-// As such, grace periods can take one good long time.  There are no
-// read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
-// because this implementation is intended to get the system into a safe
-// state for some of the manipulations involved in tracing and the like.
-// Finally, this implementation does not support high call_rcu_tasks()
-// rates from multiple CPUs.  If this is required, per-CPU callback lists
-// will be needed.
+// switch, cond_resched_tasks_rcu_qs(), user-space execution, and idle
+// tasks which are in RCU-idle context. As such, grace periods can take
+// one good long time.  There are no read-side primitives similar to
+// rcu_read_lock() and rcu_read_unlock() because this implementation is
+// intended to get the system into a safe state for some of the
+// manipulations involved in tracing and the like. Finally, this
+// implementation does not support high call_rcu_tasks() rates from
+// multiple CPUs.  If this is required, per-CPU callback lists will be
+// needed.
 //
 // The implementation uses rcu_tasks_wait_gp(), which relies on function
 // pointers in the rcu_tasks structure.  The rcu_spawn_tasks_kthread()
@@ -1079,14 +1080,6 @@ static bool rcu_tasks_is_holdout(struct task_struct *t)
 	if (!READ_ONCE(t->on_rq))
 		return false;
 
-	/*
-	 * Idle tasks (or idle injection) within the idle loop are RCU-tasks
-	 * quiescent states. But CPU boot code performed by the idle task
-	 * isn't a quiescent state.
-	 */
-	if (is_idle_task(t))
-		return false;
-
 	cpu = task_cpu(t);
 
 	if (t == idle_task(cpu))
@@ -1265,11 +1258,12 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into idle,
- * or transition to usermode execution.  As such, there are no read-side
- * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
- * this primitive is intended to determine that all tasks have passed
- * through a safe state, not so much for data-structure synchronization.
+ * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into
+ * RCU-idle context or transition to usermode execution. As such, there
+ * are no read-side primitives analogous to rcu_read_lock() and
+ * rcu_read_unlock() because this primitive is intended to determine
+ * that all tasks have passed through a safe state, not so much for
+ * data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1287,8 +1281,9 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks);
  * grace period has elapsed, in other words after all currently
  * executing rcu-tasks read-side critical sections have elapsed.  These
  * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
- * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
+ * cond_resched_tasks_rcu_qs(), idle execution within RCU-idle context,
+ * userspace execution, calls to synchronize_rcu_tasks(), and (in theory,
+ * anyway) cond_resched().
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function
-- 
2.40.1

