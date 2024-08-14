Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756013B58D;
	Wed, 14 Aug 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647671; cv=none; b=tGLGkNhLol0rVAIHaI5zkHpnmhu4jFU7x501Zo44EVVzemNMTf95bui8UI1wBKcnrfHuUUHEtSyu/r//oOqh3WsfXzrKHvZ8UU49V6MVd7d5OJog+oiz6PktkIsHqGiZg6WQXm5EWabCfp3AnypWCNC6xmMt10FIcCyJ8/BFRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647671; c=relaxed/simple;
	bh=0naP4d2jIbVgrqq/61tEl2rK5XSBXAem76bYpv/b7Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI/3jHi7MbGqXmazGrWbfXaN6J9D6M3d+kSv/4/AKz+q4FzciLSkWi1yHw+QqZoShz58XojU3MTVPUi2ARqHkLCJUFpf2FFW06W7iboLeHTPly6GhOpq9twQ8aBC0NBKG+xoQ9ku8A8V4VNkyBDcuHa3muESZiUwPOSzngaXfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLfK5EG+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLfK5EG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D3C4AF09;
	Wed, 14 Aug 2024 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723647669;
	bh=0naP4d2jIbVgrqq/61tEl2rK5XSBXAem76bYpv/b7Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLfK5EG+g7yTymgAMZAK00WmKehoLhqTPO35Qg1p16yAJYVAJhjkpgVdLPSqUU/02
	 NUPR1Xgb28Kkt8OPK3KXZhnHzSqy6wdtXNKeHgL5fb73ty366NKAQQE7bI6D9VBbY8
	 fyu7hcuavVZBNsmHvuVl8drCtijjNNV89KxotvdWuu57l0uNRa25Knd2xwzmNF095k
	 1pOZ2wW8LnLN0kaGQ8cHnNRzy7tejipE7J19jZuNrfqqatAHgLdGRc59QtWc6EecWJ
	 ieM/ND5yTwHYpJeFivDmllTKixhGe2513ojw+xQqD5oLOKC27FYL5rWT+Qz0sWlMEd
	 w6aiR4nl+sVVw==
Date: Wed, 14 Aug 2024 17:01:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joel@joelfernandes.org, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com
Subject: Re: [PATCH 1/2] rcu-tasks: Make RCU-Tasks pay attention to idle tasks
Message-ID: <ZrzGsiJvhXcndTXm@localhost.localdomain>
References: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
 <20240807163506.434885-2-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807163506.434885-2-neeraj.upadhyay@kernel.org>

Le Wed, Aug 07, 2024 at 10:05:05PM +0530, neeraj.upadhyay@kernel.org a écrit :
> @@ -1082,10 +1115,13 @@ static void rcu_tasks_postscan(struct list_head *hop)
>  static void check_holdout_task(struct task_struct *t,
>  			       bool needreport, bool *firstreport)
>  {
> -	int cpu;
> +	int cpu = task_cpu(t);
> +	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
>  
>  	if (!READ_ONCE(t->rcu_tasks_holdout) ||
>  	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
> +	    ((t == idle_task(cpu)) &&
> +	     rcu_watching_snap_stopped_since(cpu, rtpcp->rcu_watching_snap)) ||
>  	    !rcu_tasks_is_holdout(t) ||

There is a potential issue, though unlikely but still RCU-TASKS can be used on
early boot. Related kthreads are even initialized before pre-smp initcalls:

// init/1 running
do_pre_smp_initcall()
    random_initcall()
        schedule_work(random_work)

smp_init()
    // create idle task for CPU 1
    fork_idle()
        // create idle task, add to tasklist
        copy_process()

// sched_switch init/1 ===> kworker
random_work()
     synchronize_rcu_tasks()
// sched_switch kworker ===> rcu_tasks
     ...
     rcu_tasks_wait_gp()
         for_each_process_thread()
             rcu_tasks_per_task()
                 // sees idle_task for CPU 1
                 // but is not idle_task(CPU 1) yet
                 // because init_idle() hasn't been called
                 list_add(&t->rcu_tasks_holdout_list, hop);
          ...
// sched_switch rcu_tasks ===> init/1
          init_idle()
             rq->idle = idle task of CPU 1
// sched_switch init/1 ===> rcu_tasks
          check_all_holdout_tasks()
              check_holdout_task()
                  // now it verifies idle_task() but there is no snapshot
                  // so rcu_watching_snap_stopped_since() should righfully warn
                  if (t == idle_task(cpu) && rcu_watching_snap_stopped_since(cpu, rtpcp->rcu_watching_snap))
                      ...
                  
Would something like this work? (beware, untested!)

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
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 2909662c805f..ef5f391924f6 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -609,6 +609,8 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 
 #ifdef CONFIG_TINY_RCU
 static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
+static inline bool rcu_watching_snap_in_eqs(int snap) { return false; }
+static inline bool rcu_watching_snap_stopped_since(int cpu, int snap) { return false; }
 static inline unsigned long rcu_get_gp_seq(void) { return 0; }
 static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
@@ -620,6 +622,8 @@ static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_watching_zero_in_eqs(int cpu, int *vp);
+bool rcu_watching_snap_in_eqs(int snap);
+bool rcu_watching_snap_stopped_since(int cpu, int snap);
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4e913e5ca737..adc86624c92b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -35,6 +35,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
+ * @rcu_watching_snap: Per-GP rcu watching tracking for idle tasks.
  */
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
@@ -51,6 +52,8 @@ struct rcu_tasks_percpu {
 	int cpu;
 	int index;
 	struct rcu_tasks *rtpp;
+	int rcu_watching_snap;
+	int rcu_watching_snap_rec;
 };
 
 /**
@@ -902,14 +905,15 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
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
@@ -920,11 +924,13 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	Invokes synchronize_rcu() in order to wait for all in-flight
 //	t->on_rq and t->nvcsw transitions to complete.	This works because
 //	all such transitions are carried out with interrupts disabled.
-// rcu_tasks_pertask(), invoked on every non-idle task:
-//	For every runnable non-idle task other than the current one, use
-//	get_task_struct() to pin down that task, snapshot that task's
-//	number of voluntary context switches, and add that task to the
-//	holdout list.
+// rcu_tasks_pertask(), invoked on every task:
+//	For idle task, snapshot the task's CPU's dynticks counter. If
+//	the CPU is in RCU-idle context, do not add it to the holdout list.
+//	For every runnable non-idle task other than the current one and
+//	idle tasks which are not in RCU-idle context, use get_task_struct()
+//	to pin down that task, snapshot that task's number of voluntary
+//	context switches, and add that task to the holdout list.
 // rcu_tasks_postscan():
 //	Gather per-CPU lists of tasks in do_exit() to ensure that all
 //	tasks that were in the process of exiting (and which thus might
@@ -974,30 +980,65 @@ static void rcu_tasks_pregp_step(struct list_head *hop)
 	synchronize_rcu();
 }
 
-/* Check for quiescent states since the pregp's synchronize_rcu() */
-static bool rcu_tasks_is_holdout(struct task_struct *t)
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
+
+#ifndef CONFIG_TINY_RCU
+static bool rcu_idle_task_is_holdout(struct task_struct *t)
 {
-	int cpu;
+	int cpu = task_cpu(t);
 
-	/* Has the task been seen voluntarily sleeping? */
-	if (!READ_ONCE(t->on_rq))
-		return false;
+	if (t == idle_task(cpu)) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
 
-	/*
-	 * Idle tasks (or idle injection) within the idle loop are RCU-tasks
-	 * quiescent states. But CPU boot code performed by the idle task
-	 * isn't a quiescent state.
-	 */
-	if (is_idle_task(t))
-		return false;
+		/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
+		if (!rcu_cpu_online(cpu))
+			return false;
+#ifdef CONFIG_SMP
+		/*
+		 * As idle tasks cannot be involuntary preempted, non-running idle tasks
+		 * are not in RCU-tasks critical section.
+		 * synchronize_rcu() calls in rcu_tasks_pregp_step() and rcu_tasks_postgp()
+		 * ensure that all ->on_cpu transitions are complete.
+		 */
+		if (!t->on_cpu)
+			return false;
+#endif
+		if (!rtpcp->rcu_watching_snap_rec) {
+			/*
+			 * Do plain access. Ordering between remote CPU's pre idle accesses
+			 * and post rcu-tasks grace period is provided by synchronize_rcu()
+			 * in rcu_tasks_postgp().
+			 */
+			rtpcp->rcu_watching_snap = ct_rcu_watching_cpu(cpu);
+			/* RCU-idle contexts are RCU-tasks quiescent state for idle tasks. */
+			if (!rcu_watching_snap_in_eqs(rtpcp->rcu_watching_snap)) {
+				rtpcp->rcu_watching_snap_rec = 1;
+				return false;
+			}
+		} else if (rcu_watching_snap_stopped_since(cpu, rtpcp->rcu_watching_snap)) {
+			return false;
+		}
+	}
 
-	cpu = task_cpu(t);
+	return true;
+}
+
+#else /* #ifndef CONFIG_TINY_RCU */
+static inline bool rcu_idle_task_is_holdout(struct task_struct *t)
+{
+	return true;
+}
+#endif
 
-	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
-	if (t == idle_task(cpu) && !rcu_cpu_online(cpu))
+/* Check for quiescent states since the pregp's synchronize_rcu() */
+static bool rcu_tasks_is_holdout(struct task_struct *t)
+{
+	/* Has the task been seen voluntarily sleeping? */
+	if (!READ_ONCE(t->on_rq))
 		return false;
 
-	return true;
+	return rcu_idle_task_is_holdout(t);
 }
 
 /* Per-task initial processing. */
@@ -1011,9 +1052,6 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 	}
 }
 
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
-
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
@@ -1125,6 +1162,14 @@ static void check_all_holdout_tasks(struct list_head *hop,
 /* Finish off the Tasks-RCU grace period. */
 static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 {
+	int cpu;
+
+	/* Cleanup watching snapshots for next runs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+		rtpcp->rcu_watching_snap_rec = 0;
+	}
+
 	/*
 	 * Because ->on_rq and ->nvcsw are not guaranteed to have a full
 	 * memory barriers prior to them in the schedule() path, memory
@@ -1171,11 +1216,12 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
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
@@ -1193,8 +1239,9 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks);
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
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 910d316dc27b..00cf65fbae7a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -303,7 +303,7 @@ static void rcu_watching_online(void)
  * Return true if the snapshot returned from ct_rcu_watching()
  * indicates that RCU is in an extended quiescent state.
  */
-static bool rcu_watching_snap_in_eqs(int snap)
+bool rcu_watching_snap_in_eqs(int snap)
 {
 	return !(snap & CT_RCU_WATCHING);
 }
@@ -312,16 +312,16 @@ static bool rcu_watching_snap_in_eqs(int snap)
  * rcu_watching_snap_stopped_since() - Has RCU stopped watching a given CPU
  * since the specified @snap?
  *
- * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
+ * @cpu: The CPU for which to check EQS.
  * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
  *
- * Returns true if the CPU corresponding to @rdp has spent some time in an
+ * Returns true if the CPU corresponding has spent some time in an
  * extended quiescent state since @snap. Note that this doesn't check if it
  * /still/ is in an EQS, just that it went through one since @snap.
  *
  * This is meant to be used in a loop waiting for a CPU to go through an EQS.
  */
-static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
+bool rcu_watching_snap_stopped_since(int cpu, int snap)
 {
 	/*
 	 * The first failing snapshot is already ordered against the accesses
@@ -334,7 +334,7 @@ static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
 	if (WARN_ON_ONCE(rcu_watching_snap_in_eqs(snap)))
 		return true;
 
-	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
+	return snap != ct_rcu_watching_cpu_acquire(cpu);
 }
 
 /*
@@ -826,7 +826,7 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 	 * read-side critical section that started before the beginning
 	 * of the current RCU grace period.
 	 */
-	if (rcu_watching_snap_stopped_since(rdp, rdp->watching_snap)) {
+	if (rcu_watching_snap_stopped_since(rdp->cpu, rdp->watching_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index c3266bf709d5..6202d321b2bb 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -400,7 +400,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
 		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
-		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
+		if (rcu_watching_snap_stopped_since(rdp->cpu, rdp->exp_watching_snap)) {
 			mask_ofl_test |= mask;
 			continue;
 		}

