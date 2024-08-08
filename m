Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD92AD14;
	Thu,  8 Aug 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139987; cv=none; b=rvKs/+JfFh9W9Cqyzd7wGmwwG4cYFsjRPRRtuAyoDhxu/ywEkFK706twJyglAmWxN0652V4RWFt4hakYn6KWceQSoSzYMYWZ/7nNw7iAwxEZBpQr4r0ZWo6Rpe+XHhYrczOfRmmLo7/AQfY4LaZdk5AJBBz3SFAYi/2Dth4UWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139987; c=relaxed/simple;
	bh=QfqaT47Ndxwe54UL1Lfa3k+PH99AKFdU4WHO+cUoxFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/GpVXxNuyZGlxTjnaJqePrQ7uNE1fdn2dvncRjASH1YoZsOQw2NDYLV3VaJNfL76Wlo/BtjmRNcSsBpNrT/XM4Hre2xqPKM0XB/H65LU8lnp2y6a2wwj1+wNw39T/Vjsmokvli4wX3PCDoM7EG17QfoEsFJxEpyVlaqNWEIBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S863sxN8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S863sxN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C301C32782;
	Thu,  8 Aug 2024 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723139987;
	bh=QfqaT47Ndxwe54UL1Lfa3k+PH99AKFdU4WHO+cUoxFQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S863sxN8ourrG3DhvuUZZqSnt3jJ76xi/oCavtM81UNntBEi4ON4mcalztxeOtg90
	 Fk7MPIjrENnMRaNuV4oNZF4Y86Jx2+K5hAP9aoy/rySsvMbbHVGJE1t7U7v8+jYFQU
	 D7fd65eOh/1BFgQIn0sHJr6tx4xP0tA2on/98f3Xoew/f9/4wiEvi3Sokk733sRDvW
	 A7UWou43GBDuoCL/0nMdOkA1s0i8nCMV9NK2Zk0qUnZ3XWPdlW1IyUnGZKx9QAwb7p
	 ukO1igpiGye2WIbjAA24qtmaQ45oEaehmgp9akQz6dckfsedZjab0IktQLteQLXWmp
	 KYsHklAio0d4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA71ACE09DB; Thu,  8 Aug 2024 10:59:46 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:59:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	joel@joelfernandes.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: [PATCH 1/2] rcu-tasks: Make RCU-Tasks pay attention to idle tasks
Message-ID: <f715fa64-4ea8-4827-9acd-c6f8006e5220@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240807163506.434885-1-neeraj.upadhyay@kernel.org>
 <20240807163506.434885-2-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807163506.434885-2-neeraj.upadhyay@kernel.org>

On Wed, Aug 07, 2024 at 10:05:05PM +0530, neeraj.upadhyay@kernel.org wrote:
> From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> 
> Currently, idle tasks are ignored by Tasks RCU and idle tasks
> are in RCU-Tasks quiescent state for Tasks RCU. Change this to
> start paying attention to idle tasks except in deep-idle functions
> where RCU is not watching. With this, for architectures where
> kernel entry/exit and deep-idle functions have been properly tagged
> noinstr, Tasks Rude RCU can be disabled.
> 
> [ neeraj.upadhyay: Frederic Weisbecker and Paul E. McKenney feedback. ]
> 
> Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Looks plausible, thank you!

A few questions and comments interspersed below.

							Thanx, Paul

> ---
>  .../RCU/Design/Requirements/Requirements.rst  |  12 +-
>  kernel/rcu/rcu.h                              |   4 +
>  kernel/rcu/tasks.h                            | 107 ++++++++++++------
>  kernel/rcu/tree.c                             |  12 +-
>  kernel/rcu/tree_exp.h                         |   2 +-
>  5 files changed, 89 insertions(+), 48 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 6125e7068d2c..5016b85d53d7 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -2611,8 +2611,8 @@ critical sections that are delimited by voluntary context switches, that
>  is, calls to schedule(), cond_resched(), and
>  synchronize_rcu_tasks(). In addition, transitions to and from
>  userspace execution also delimit tasks-RCU read-side critical sections.
> -Idle tasks are ignored by Tasks RCU, and Tasks Rude RCU may be used to
> -interact with them.
> +Idle tasks which are idle from RCU's perspective are ignored by Tasks RCU,
> +and Tasks Rude RCU may be used to interact with them.
>  
>  Note well that involuntary context switches are *not* Tasks-RCU quiescent
>  states.  After all, in preemptible kernels, a task executing code in a
> @@ -2643,10 +2643,10 @@ moniker.  And this operation is considered to be quite rude by real-time
>  workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
>  by battery-powered systems that don't want their idle CPUs to be awakened.
>  
> -Once kernel entry/exit and deep-idle functions have been properly tagged
> -``noinstr``, Tasks RCU can start paying attention to idle tasks (except
> -those that are idle from RCU's perspective) and then Tasks Rude RCU can
> -be removed from the kernel.
> +As Tasks RCU now pays attention to idle tasks (except those that are idle
> +from RCU's perspective), once kernel entry/exit and deep-idle functions have
> +been properly tagged ``noinstr``, Tasks Rude RCU can be removed from the
> +kernel.
>  
>  The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
>  consisting solely of synchronize_rcu_tasks_rude().
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index feb3ac1dc5d5..5fec1b52039c 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -609,6 +609,8 @@ void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
>  
>  #ifdef CONFIG_TINY_RCU
>  static inline bool rcu_watching_zero_in_eqs(int cpu, int *vp) { return false; }
> +static inline bool rcu_watching_snap_in_eqs(int snap) { return false; }
> +static inline bool rcu_watching_snap_stopped_since(int cpu, int snap) { return false; }
>  static inline unsigned long rcu_get_gp_seq(void) { return 0; }
>  static inline unsigned long rcu_exp_batches_completed(void) { return 0; }
>  static inline unsigned long
> @@ -622,6 +624,8 @@ static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
>  static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
>  #else /* #ifdef CONFIG_TINY_RCU */
>  bool rcu_watching_zero_in_eqs(int cpu, int *vp);
> +bool rcu_watching_snap_in_eqs(int snap);
> +bool rcu_watching_snap_stopped_since(int cpu, int snap);
>  unsigned long rcu_get_gp_seq(void);
>  unsigned long rcu_exp_batches_completed(void);
>  unsigned long srcu_batches_completed(struct srcu_struct *sp);
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 2f8d6c8e3c4c..0c0367c8f5c8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -35,6 +35,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>   * @rtp_exit_list: List of tasks in the latter portion of do_exit().
>   * @cpu: CPU number corresponding to this entry.
>   * @rtpp: Pointer to the rcu_tasks structure.
> + * @rcu_watching_snap: Per-GP rcu watching tracking for idle tasks.
>   */
>  struct rcu_tasks_percpu {
>  	struct rcu_segcblist cblist;
> @@ -51,6 +52,7 @@ struct rcu_tasks_percpu {
>  	int cpu;
>  	int index;
>  	struct rcu_tasks *rtpp;
> +	int rcu_watching_snap;
>  };
>  
>  /**
> @@ -902,14 +904,15 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>  ////////////////////////////////////////////////////////////////////////
>  //
>  // Simple variant of RCU whose quiescent states are voluntary context
> -// switch, cond_resched_tasks_rcu_qs(), user-space execution, and idle.
> -// As such, grace periods can take one good long time.  There are no
> -// read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
> -// because this implementation is intended to get the system into a safe
> -// state for some of the manipulations involved in tracing and the like.
> -// Finally, this implementation does not support high call_rcu_tasks()
> -// rates from multiple CPUs.  If this is required, per-CPU callback lists
> -// will be needed.
> +// switch, cond_resched_tasks_rcu_qs(), user-space execution, and idle
> +// tasks which are in RCU-idle context. As such, grace periods can take
> +// one good long time.  There are no read-side primitives similar to
> +// rcu_read_lock() and rcu_read_unlock() because this implementation is
> +// intended to get the system into a safe state for some of the
> +// manipulations involved in tracing and the like. Finally, this
> +// implementation does not support high call_rcu_tasks() rates from
> +// multiple CPUs.  If this is required, per-CPU callback lists will be
> +// needed.
>  //
>  // The implementation uses rcu_tasks_wait_gp(), which relies on function
>  // pointers in the rcu_tasks structure.  The rcu_spawn_tasks_kthread()
> @@ -920,11 +923,13 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>  //	Invokes synchronize_rcu() in order to wait for all in-flight
>  //	t->on_rq and t->nvcsw transitions to complete.	This works because
>  //	all such transitions are carried out with interrupts disabled.
> -// rcu_tasks_pertask(), invoked on every non-idle task:
> -//	For every runnable non-idle task other than the current one, use
> -//	get_task_struct() to pin down that task, snapshot that task's
> -//	number of voluntary context switches, and add that task to the
> -//	holdout list.
> +// rcu_tasks_pertask(), invoked on every task:
> +//	For idle task, snapshot the task's CPU's dynticks counter. If
> +//	the CPU is in RCU-idle context, do not add it to the holdout list.
> +//	For every runnable non-idle task other than the current one and
> +//	idle tasks which are not in RCU-idle context, use get_task_struct()
> +//	to pin down that task, snapshot that task's number of voluntary
> +//	context switches, and add that task to the holdout list.
>  // rcu_tasks_postscan():
>  //	Gather per-CPU lists of tasks in do_exit() to ensure that all
>  //	tasks that were in the process of exiting (and which thus might
> @@ -983,27 +988,58 @@ static bool rcu_tasks_is_holdout(struct task_struct *t)
>  	if (!READ_ONCE(t->on_rq))
>  		return false;
>  
> -	/*
> -	 * Idle tasks (or idle injection) within the idle loop are RCU-tasks
> -	 * quiescent states. But CPU boot code performed by the idle task
> -	 * isn't a quiescent state.
> -	 */
> -	if (is_idle_task(t))
> -		return false;
> -
>  	cpu = task_cpu(t);
>  
> -	/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
> -	if (t == idle_task(cpu) && !rcu_cpu_online(cpu))
> +
> +	if (t == idle_task(cpu)) {
> +		/* Idle tasks on offline CPUs are RCU-tasks quiescent states. */
> +		if (!rcu_cpu_online(cpu))
> +			return false;
> +#ifdef CONFIG_SMP
> +		/*
> +		 * As idle tasks cannot be involuntary preempted, non-running idle tasks
> +		 * are not in RCU-tasks critical section.
> +		 * synchronize_rcu() calls in rcu_tasks_pregp_step() and rcu_tasks_postgp()
> +		 * ensure that all ->on_cpu transitions are complete.
> +		 */
> +		if (!t->on_cpu)

Could we do "if (IS_ENABLED(CONFIG_SMP))" here and the drop the #ifdef
and its #else clause?

> +			return false;
> +#else
> +		/*
> +		 * We are in rcu_tasks_kthread() context. Idle thread would
> +		 * have done a voluntary context switch.
> +		 */
>  		return false;
> +#endif
> +	}
>  
>  	return true;
>  }
>  
> +void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
> +DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
> +
>  /* Per-task initial processing. */
>  static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
>  {
>  	if (t != current && rcu_tasks_is_holdout(t)) {
> +#ifndef CONFIG_TINY_RCU
> +		int cpu = task_cpu(t);
> +
> +		if (t == idle_task(cpu)) {
> +			struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> +
> +			/*
> +			 * Do plain access. Ordering between remote CPU's pre idle accesses
> +			 * and post rcu-tasks grace period is provided by synchronize_rcu()
> +			 * in rcu_tasks_postgp().
> +			 */
> +			rtpcp->rcu_watching_snap = ct_rcu_watching_cpu(cpu);

This depends on Valentin's commit:

a9fde9d1a5dd ("context_tracking, rcu: Rename ct_dynticks_cpu() into ct_rcu_watching_cpu()")

Which is not a problem, it instead just constrains what order things go
into mainline.

> +			/* RCU-idle contexts are RCU-tasks quiescent state for idle tasks. */
> +			if (rcu_watching_snap_in_eqs(rtpcp->rcu_watching_snap))
> +				return;
> +		}
> +#endif // #ifndef CONFIG_TINY_RCU
>  		get_task_struct(t);
>  		t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
>  		WRITE_ONCE(t->rcu_tasks_holdout, true);
> @@ -1011,9 +1047,6 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
>  	}
>  }
>  
> -void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
> -DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
> -
>  /* Processing between scanning taskslist and draining the holdout list. */
>  static void rcu_tasks_postscan(struct list_head *hop)
>  {
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
>  	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
>  	     !is_idle_task(t) && READ_ONCE(t->rcu_tasks_idle_cpu) >= 0)) {
> @@ -1101,7 +1137,6 @@ static void check_holdout_task(struct task_struct *t,
>  		pr_err("INFO: rcu_tasks detected stalls on tasks:\n");
>  		*firstreport = false;
>  	}
> -	cpu = task_cpu(t);
>  	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
>  		 t, ".I"[is_idle_task(t)],
>  		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
> @@ -1171,11 +1206,12 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
>   * period elapses, in other words after all currently executing RCU
>   * read-side critical sections have completed. call_rcu_tasks() assumes
>   * that the read-side critical sections end at a voluntary context
> - * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into idle,
> - * or transition to usermode execution.  As such, there are no read-side
> - * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
> - * this primitive is intended to determine that all tasks have passed
> - * through a safe state, not so much for data-structure synchronization.
> + * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into
> + * RCU-idle context or transition to usermode execution. As such, there
> + * are no read-side primitives analogous to rcu_read_lock() and
> + * rcu_read_unlock() because this primitive is intended to determine
> + * that all tasks have passed through a safe state, not so much for
> + * data-structure synchronization.
>   *
>   * See the description of call_rcu() for more detailed information on
>   * memory ordering guarantees.
> @@ -1193,8 +1229,9 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks);
>   * grace period has elapsed, in other words after all currently
>   * executing rcu-tasks read-side critical sections have elapsed.  These
>   * read-side critical sections are delimited by calls to schedule(),
> - * cond_resched_tasks_rcu_qs(), idle execution, userspace execution, calls
> - * to synchronize_rcu_tasks(), and (in theory, anyway) cond_resched().
> + * cond_resched_tasks_rcu_qs(), idle execution within RCU-idle context,
> + * userspace execution, calls to synchronize_rcu_tasks(), and (in theory,
> + * anyway) cond_resched().
>   *
>   * This is a very specialized primitive, intended only for a few uses in
>   * tracing and other situations requiring manipulation of function
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 930846f06bee..1f1574200bea 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -303,7 +303,7 @@ static void rcu_watching_online(void)
>   * Return true if the snapshot returned from ct_rcu_watching()
>   * indicates that RCU is in an extended quiescent state.
>   */

I suggest breaking this commit up.  One commit could just be the below
change in rcu_watching_snap_in_eqs().  Another could be the addition on
->rcu_watching_snap.  And a third would be the actual change in Tasks
RCU semantics.  This would make it a bit easier to review, less stuff
to track on each commit.

> -static bool rcu_watching_snap_in_eqs(int snap)
> +bool rcu_watching_snap_in_eqs(int snap)
>  {
>  	return !(snap & CT_RCU_WATCHING);
>  }
> @@ -312,16 +312,16 @@ static bool rcu_watching_snap_in_eqs(int snap)
>   * rcu_watching_snap_stopped_since() - Has RCU stopped watching a given CPU
>   * since the specified @snap?
>   *
> - * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
> + * @cpu: The CPU for which to check EQS.
>   * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
>   *
> - * Returns true if the CPU corresponding to @rdp has spent some time in an
> + * Returns true if the CPU corresponding has spent some time in an
>   * extended quiescent state since @snap. Note that this doesn't check if it
>   * /still/ is in an EQS, just that it went through one since @snap.
>   *
>   * This is meant to be used in a loop waiting for a CPU to go through an EQS.
>   */
> -static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
> +bool rcu_watching_snap_stopped_since(int cpu, int snap)
>  {
>  	/*
>  	 * The first failing snapshot is already ordered against the accesses
> @@ -334,7 +334,7 @@ static bool rcu_watching_snap_stopped_since(struct rcu_data *rdp, int snap)
>  	if (WARN_ON_ONCE(rcu_watching_snap_in_eqs(snap)))
>  		return true;
>  
> -	return snap != ct_rcu_watching_cpu_acquire(rdp->cpu);
> +	return snap != ct_rcu_watching_cpu_acquire(cpu);
>  }
>  
>  /*
> @@ -826,7 +826,7 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
>  	 * read-side critical section that started before the beginning
>  	 * of the current RCU grace period.
>  	 */
> -	if (rcu_watching_snap_stopped_since(rdp, rdp->watching_snap)) {
> +	if (rcu_watching_snap_stopped_since(rdp->cpu, rdp->watching_snap)) {
>  		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
>  		rcu_gpnum_ovf(rnp, rdp);
>  		return 1;
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index c3266bf709d5..6202d321b2bb 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -400,7 +400,7 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>  		unsigned long mask = rdp->grpmask;
>  
>  retry_ipi:
> -		if (rcu_watching_snap_stopped_since(rdp, rdp->exp_watching_snap)) {
> +		if (rcu_watching_snap_stopped_since(rdp->cpu, rdp->exp_watching_snap)) {
>  			mask_ofl_test |= mask;
>  			continue;
>  		}
> -- 
> 2.40.1
> 
