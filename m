Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52B3515C5;
	Fri, 11 Sep 2026 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147398; cv=none; b=H/g7EWNPVhQQ/RMpPuPd6KfTPIbBfbw+nE6V43z86+cdbcjd0plmbNi8B+oFWs0aUC4Jg337Q26JMT2MtlDaVKo5nUkpt4zga5sXB/jW/NHW4CuYeLNwKGuNSP4v5Sn8lrXEvW/LS8YXi7AIqXEP/VSTjPeZ5cufygHDpit/1oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147398; c=relaxed/simple;
	bh=D1to0PZKc/KA50LSwHQ80T7kQBF1FvK+a9r6MqytDzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP5d70b9cec5ODsHii7jDnJCM2s8JeJP7PpTfxtoN5AMk2ByCA9cm2kigkkrBKs1pudXyW+/0xuBCenjSZU6mwcofJYcKfDqqxwsxTTE70SXkk15Duw2KdLDxindVuRErEBDCWSOL6SXCL1RhWu+X+TD0T8/sa2q6M3s8yGm/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIZ7yScn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIZ7yScn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6981F00893;
	Fri, 11 Sep 2026 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789147396;
	bh=OJP8Kr91re/1TLbUGmF1tDEabRFooEc7DLwpbkUU1SE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=HIZ7yScn+Y/fJxVNeSGNMIluX+kW3qXFuO1J42ABZc2Lyzd4l390tPeIoz72ca9zZ
	 xSMOd5mDJ9gPxF1vih4YdipWkGCmMX83+qhriXF0pGjSdAJ78J+BcCTDRhqZ1ZPHz7
	 xwlRqpD4V42PB00qiY52yy9/bmaSCE8EkR1DRGP8DZD5cYZMwSC4bSUjzABOA39olo
	 T9dHHVXgcLFoDm6fTUEmqpgpEgsNQkaDiiIKCvN2KVaVANuEFlOrbv0Zwg94T0wdoV
	 L/4VpbQZgXxnSfXLkj2JRzRNuZbw+jeSgaG4gqFT/akeeog9pLPeb4xdWJTmUlyv+Q
	 WWdU9cKD1lpDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E68DCE1902; Fri, 11 Sep 2026 10:23:16 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:23:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v2 01/15] rcu-tasks: Add per-task trampoline nesting
 count
Message-ID: <90c2dfbe-e796-4125-b178-e854b40f68cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-1-eaaa61ed2da4@toxicpanda.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-1-eaaa61ed2da4@toxicpanda.com>

On Fri, Sep 11, 2026 at 02:08:39PM +0000, Josef Bacik wrote:
> Tasks RCU exists so that ftrace, BPF and kprobes can free trampoline
> text once no task can still be executing in it.  Today the only way a
> task tells Tasks RCU "I am not in a trampoline" is a voluntary context
> switch, so a preempted task is always assumed to be inside one.
> 
> Add task_struct::rcu_tramp_nesting so that trampolines can say so
> directly: a trampoline increments it before calling out and decrements
> it before returning, and while it is non-zero the task must not be
> treated as Tasks-RCU quiescent.  Provide rcu_tasks_trampoline_enter()
> and rcu_tasks_trampoline_exit() for C users, report the count in the
> Tasks RCU stall output, and, under CONFIG_PROVE_RCU, assert that it is
> zero on every return to userspace since no task can legitimately reach
> userspace with a trampoline on its stack.
> 
> Only current ever writes the count and every nested user (interrupts
> running their own trampolines) is balanced, so plain accesses suffice.
> 
> The callbacks reached from static trampolines (return_to_handler, the
> rethook and kretprobe trampolines) are covered by the preempt_disable()
> in the ftrace recursion protection rather than by the count; note that
> dependency in trace_recursion.h so it is not lost if the
> preempt_disable() is ever removed from there.
> 
> Nothing increments the count and nothing consults it for quiescent-state
> decisions yet; both come in later patches.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Please see below for a line-saving nit.

							Thanx, Paul

> ---
>  include/linux/irq-entry-common.h |  2 ++
>  include/linux/rcupdate.h         | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/sched.h            |  1 +
>  include/linux/trace_recursion.h  | 11 +++++++++++
>  kernel/fork.c                    |  1 +
>  kernel/rcu/tasks.h               |  3 ++-
>  6 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index 0bb6c03481fa..8da571622000 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -5,6 +5,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/hrtimer_rearm.h>
>  #include <linux/kmsan.h>
> +#include <linux/rcupdate.h>
>  #include <linux/rseq_entry.h>
>  #include <linux/static_call_types.h>
>  #include <linux/syscalls.h>
> @@ -214,6 +215,7 @@ static __always_inline void __exit_to_user_mode_validate(void)
>  {
>  	/* Ensure that kernel state is sane for a return to userspace */
>  	kmap_assert_nomap();
> +	rcu_tasks_trampoline_assert_none();
>  	lockdep_assert_irqs_disabled();
>  	lockdep_sys_exit();
>  }
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 44c07a66edff..b5c666c82479 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -180,6 +180,37 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
>  #ifdef CONFIG_TASKS_RCU_GENERIC
>  
>  # ifdef CONFIG_TASKS_RCU
> +
> +/*
> + * Trampoline nesting: dynamically allocated text (ftrace trampolines, BPF
> + * trampoline images, kprobe optinsn slots) that relies on Tasks RCU for its
> + * lifetime brackets itself with an increment/decrement of
> + * current->rcu_tramp_nesting.  While the count is non-zero the task is inside,
> + * or was called from, such text and an involuntary context switch must not be
> + * treated as a Tasks RCU quiescent state.
> + *
> + * Only current writes the count and only current (or an interrupt on the same
> + * CPU) reads it, so plain accesses suffice.
> + */
> +static __always_inline void rcu_tasks_trampoline_enter(void)
> +{
> +	current->rcu_tramp_nesting++;
> +	barrier();
> +}
> +
> +static __always_inline void rcu_tasks_trampoline_exit(void)
> +{
> +	barrier();
> +	current->rcu_tramp_nesting--;
> +}
> +
> +/* A task must never reach userspace with a trampoline on its stack. */
> +static __always_inline void rcu_tasks_trampoline_assert_none(void)
> +{
> +	if (IS_ENABLED(CONFIG_PROVE_RCU))
> +		WARN_ON_ONCE(current->rcu_tramp_nesting);

Save a line as follows?

	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && current->rcu_tramp_nesting);

> +}
> +
>  # define rcu_tasks_classic_qs(t, preempt)				\
>  	do {								\
>  		if (!(preempt) && READ_ONCE((t)->rcu_tasks_holdout))	\
> @@ -192,6 +223,9 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
>  # define rcu_tasks_classic_qs(t, preempt) do { } while (0)
>  # define call_rcu_tasks call_rcu
>  # define synchronize_rcu_tasks synchronize_rcu
> +static inline void rcu_tasks_trampoline_enter(void) { }
> +static inline void rcu_tasks_trampoline_exit(void) { }
> +static inline void rcu_tasks_trampoline_assert_none(void) { }
>  # endif
>  
>  #define rcu_tasks_qs(t, preempt) rcu_tasks_classic_qs((t), (preempt))
> @@ -208,6 +242,9 @@ void exit_tasks_rcu_finish(void);
>  #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
>  #define rcu_tasks_qs(t, preempt) do { } while (0)
>  #define rcu_note_voluntary_context_switch(t) do { } while (0)
> +static inline void rcu_tasks_trampoline_enter(void) { }
> +static inline void rcu_tasks_trampoline_exit(void) { }
> +static inline void rcu_tasks_trampoline_assert_none(void) { }
>  #define call_rcu_tasks call_rcu
>  #define synchronize_rcu_tasks synchronize_rcu
>  static inline void exit_tasks_rcu_start(void) { }
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8b3d47a325cc..d2e7b1b3c9d2 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -956,6 +956,7 @@ struct task_struct {
>  	unsigned long			rcu_tasks_nvcsw;
>  	u8				rcu_tasks_holdout;
>  	u8				rcu_tasks_idx;
> +	int				rcu_tramp_nesting;
>  	int				rcu_tasks_idle_cpu;
>  	struct list_head		rcu_tasks_holdout_list;
>  	int				rcu_tasks_exit_cpu;
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index e6ca052b2a85..2da23a52ca4a 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -153,6 +153,17 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
>  	current->trace_recursion = val;
>  	barrier();
>  
> +	/*
> +	 * Callbacks reached from static trampoline text (return_to_handler,
> +	 * the rethook and kretprobe trampolines) do not maintain
> +	 * current->rcu_tramp_nesting themselves; they rely on this
> +	 * preempt_disable() to keep the task from being preempted, and thus
> +	 * from reporting a Tasks RCU quiescent state, while an ftrace_ops or
> +	 * its data is in use.  If the preempt_disable() is ever removed from
> +	 * the recursion protection, this must rcu_tasks_trampoline_enter()
> +	 * here and rcu_tasks_trampoline_exit() in trace_clear_recursion()
> +	 * instead.  See CONFIG_RCU_TASKS_PREEMPT_QS.
> +	 */
>  	preempt_disable_notrace();
>  
>  	return bit;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 416758c8a3d4..cfe3a8e53fbd 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1869,6 +1869,7 @@ static inline void rcu_copy_process(struct task_struct *p)
>  #endif /* #ifdef CONFIG_PREEMPT_RCU */
>  #ifdef CONFIG_TASKS_RCU
>  	p->rcu_tasks_holdout = false;
> +	p->rcu_tramp_nesting = 0;
>  	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
>  	p->rcu_tasks_idle_cpu = -1;
>  	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 627295396cd9..1662ba18bf34 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1113,10 +1113,11 @@ static void check_holdout_task(struct task_struct *t,
>  		*firstreport = false;
>  	}
>  	cpu = task_cpu(t);
> -	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d idle_cpu: %d/%d\n",
> +	pr_alert("%p: %c%c nvcsw: %lu/%lu holdout: %d tramp_nesting: %d idle_cpu: %d/%d\n",
>  		 t, ".I"[is_idle_task(t)],
>  		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
>  		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
> +		 data_race(t->rcu_tramp_nesting),
>  		 data_race(t->rcu_tasks_idle_cpu), cpu);
>  	sched_show_task(t);
>  }
> 
> -- 
> 2.55.0
> 
