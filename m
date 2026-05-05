Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04C224AF1;
	Tue,  5 May 2026 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777952689; cv=none; b=I41B3SS1v8vi0zwnJYHjEIFjSxafNlSdP/q9VYiG8ejqFcZi7vjywj3Nv1BhjifW5SRm5/WbvnzUWRRT7mwvG+D4IgJs+4BJ3xp/EUf/JjY3kxRIoLuqiwEpEmwQUslHoNhpSnAQuiFj+vRLjDhoMUU1yScN9o4vqm1rhZJ00Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777952689; c=relaxed/simple;
	bh=ytOC1MScjGGetGoJr1GI0LgLj526YWtNXH13y/59YlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2EShY5klF1O1mvJfvXQl+khNBQxRru/44zhtt1thq2B/DKdri9WVG3iYIMU6M4d0qAqIkS8aNMwDiZIXX0km6xXQes+oAefPi8d5rjRgPOE6BuwiPglNHMoFvTDhxuCoXPmEjhhzpXn6hQU5sJkjRv+UmA/4HtUM6aikZXSH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnTHsTW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnTHsTW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D9DC2BCB4;
	Tue,  5 May 2026 03:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777952689;
	bh=ytOC1MScjGGetGoJr1GI0LgLj526YWtNXH13y/59YlE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tnTHsTW0CQwH3SqFO5ZU1OhRzDo9x73q5qsKge5poEguOpzryXk3lzAPrp2+Z83e+
	 FFYVokZ7umWtWaDa0HY5z4J8QQtzSPAdyV3bAO1tPiPxC40IgshujaeZ/HL1BgSw5W
	 hBAYWZCjB+zLCvPCiw/lzFLMeGXQzh+YqfrK9iHLU8GufArefpVqO6CKk4VLSzXwuB
	 fuZNtOmLhh8E7B8ITndb4gF3i6v2USF8Q7B6LwaT8UG1gN1xINFDFoYWRQVhQFEgyu
	 ipQNbZHpIKvfWru1BnZ9oCm0aJNoQ+c7X1BTxOb/bzREuNkJsR3uwIntMBDMpO6CZy
	 d4oSBmEMzQPTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0324ECE09DC; Mon,  4 May 2026 20:44:49 -0700 (PDT)
Date: Mon, 4 May 2026 20:44:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 2/2] sched_ext: Fix exit_cpu accuracy for lockup paths
Message-ID: <c402160a-dbc6-4292-a684-395a80d677d4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
 <20260504161543.674488-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504161543.674488-3-yphbchou0911@gmail.com>

On Tue, May 05, 2026 at 12:08:20AM +0800, Cheng-Yang Chou wrote:
> handle_lockup() uses raw_smp_processor_id() for exit_cpu, which is wrong
> for two paths:
> 
> - scx_hardlockup_irq_workfn() has the hung CPU in a local variable but
>   irq_work may run elsewhere; pass the local cpu explicitly.
> - scx_rcu_cpu_stall() takes no CPU, recording the detector rather than
>   the stalled one; add stalled_cpu to its signature and
>   panic_on_rcu_stall(), threading it from print_cpu_stall() (current
>   CPU) and print_other_cpu_stall() (first detected stalled CPU).
> 
> Add an exit_cpu parameter to handle_lockup() so callers pass the correct
> CPU directly. Remove the now-unused scx_verror() macro.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  include/linux/sched/ext.h   |  4 ++--
>  kernel/rcu/tree_exp.h       |  2 +-
>  kernel/rcu/tree_stall.h     | 11 +++++++----
>  kernel/sched/ext.c          | 14 ++++++++------
>  kernel/sched/ext_internal.h |  2 --
>  5 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index d05efcac794d..16bbf24089ca 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -259,7 +259,7 @@ void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
>  bool scx_hardlockup(int cpu);
> -bool scx_rcu_cpu_stall(void);
> +bool scx_rcu_cpu_stall(int stalled_cpu);
>  
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
>  
> @@ -267,7 +267,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
>  static inline bool scx_hardlockup(int cpu) { return false; }
> -static inline bool scx_rcu_cpu_stall(void) { return false; }
> +static inline bool scx_rcu_cpu_stall(int stalled_cpu) { return false; }

There might be more than one stalled CPU.  You could pass in a cpumask_t
or similar to print all of them, or take the first or the last or
some such.

>  
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
>  
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d..fa83e273a648 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -675,7 +675,7 @@ static void synchronize_rcu_expedited_wait(void)
>  
>  		nbcon_cpu_emergency_exit();
>  
> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(raw_smp_processor_id());

As Tejun pointed out, this gets you whatever random CPU was running
RCU's expedited grace-period processing, which is almost certainly not
the stalled CPU.

In addition, in preemptible kernels, it is possible to stall not on a CPU,
but on a task that was preempted within an RCU read-side critical section.
(It is also possible to stall on some CPUs and on some tasks.)

So suppose that the expedited grace period is stalled not on a CPU, but
instead on a task.  What do you want to do in that case?

If you only care about CPUs, then synchronize_rcu_expedited_stall()
could return the number of the first stalled CPU that it encountered,
or -1 if there were no CPUs doing any stalling.  If you wanted the first
CPU, you could capture it within the first rcu_for_each_leaf_node()
loop in that function.  Or you could pass in a cpumask_t and have
synchronize_rcu_expedited_stall() fill it in, getting all the CPUs.
And you could pass in an array (along with its size) to capture the PIDs
of any stalled tasks, which synchronize_rcu_expedited_stall() would in
turn pass down to rcu_print_task_exp_stall(), which could fill in the
PIDs of the first stalled tasks in the ->blkd_tasks lists.

Whatever you collect would then be passed down to panic_on_rcu_stall()
and from there to scx_rcu_cpu_stall().

Much depends on exactly what you are trying to accomplish with the
additional information.

More inline below.

						Thanx, Paul

>  	}
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..172ac08e673d 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
>  early_initcall(check_cpu_stall_init);
>  
>  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> -static void panic_on_rcu_stall(void)
> +static void panic_on_rcu_stall(int stalled_cpu)
>  {
>  	static int cpu_stall;
>  
> @@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
>  	 * Attempt to kick out the BPF scheduler if it's installed and defer
>  	 * the panic to give the system a chance to recover.
>  	 */
> -	if (scx_rcu_cpu_stall())
> +	if (scx_rcu_cpu_stall(stalled_cpu))
>  		return;
>  
>  	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> @@ -631,6 +631,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
>  static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  {
>  	int cpu;
> +	int first_stalled_cpu = -1;
>  	unsigned long flags;
>  	unsigned long gpa;
>  	unsigned long j;
> @@ -660,6 +661,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  			for_each_leaf_node_possible_cpu(rnp, cpu)
>  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
>  					print_cpu_stall_info(cpu);
> +					if (first_stalled_cpu < 0)
> +						first_stalled_cpu = cpu;

This gets the first stalled CPU.  Maybe that is also what you want for
the expedited stalls?

Again, there might not be any stalled CPUs, but only stalled tasks...

>  					ndetected++;
>  				}
>  		}
> @@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	panic_on_rcu_stall(first_stalled_cpu);

...in which case panic_on_rcu_stall() gets a -1.  Which might not be what
the user wants to see.

>  	rcu_force_quiescent_state();  /* Kick them all. */
>  }
> @@ -754,7 +757,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	panic_on_rcu_stall(smp_processor_id());

In this case, we do just have the current CPU doing the stall, so this
does work fine.  (If there are more CPUs and tasks involved, there
could be additional RCU CPU stall warning messages.)

>  	/*
>  	 * Attempt to revive the RCU machinery by forcing a context switch.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 48c65ac8e230..8a0b1662a75a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5069,6 +5069,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>  
>  /**
>   * handle_lockup - sched_ext common lockup handler
> + * @exit_cpu: CPU to record in exit_info; pass the stalled/hung CPU, not current
>   * @fmt: format string
>   *
>   * Called on system stall or lockup condition and initiates abort of sched_ext
> @@ -5078,7 +5079,7 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
>   * resolve the lockup. %false if sched_ext is not enabled or abort was already
>   * initiated by someone else.
>   */
> -static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
> +static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
>  {
>  	struct scx_sched *sch;
>  	va_list args;
> @@ -5094,7 +5095,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>  	case SCX_ENABLING:
>  	case SCX_ENABLED:
>  		va_start(args, fmt);
> -		ret = scx_verror(sch, fmt, args);
> +		ret = scx_vexit(sch, SCX_EXIT_ERROR, 0, exit_cpu, fmt, args);
>  		va_end(args);
>  		return ret;
>  	default:
> @@ -5114,9 +5115,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
>   * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
>   * else already initiated abort.
>   */
> -bool scx_rcu_cpu_stall(void)
> +bool scx_rcu_cpu_stall(int stalled_cpu)
>  {
> -	return handle_lockup("RCU CPU stall detected!");
> +	return handle_lockup(stalled_cpu, "RCU CPU stall detected!");
>  }
>  
>  /**
> @@ -5131,7 +5132,8 @@ bool scx_rcu_cpu_stall(void)
>   */
>  void scx_softlockup(u32 dur_s)
>  {
> -	if (!handle_lockup("soft lockup - CPU %d stuck for %us", smp_processor_id(), dur_s))
> +	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
> +			   smp_processor_id(), dur_s))

Repeating "smp_processor_id()" in the argument list seems a bit redundant?

>  		return;
>  
>  	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU %d stuck for %us, disabling BPF scheduler\n",
> @@ -5150,7 +5152,7 @@ static void scx_hardlockup_irq_workfn(struct irq_work *work)
>  {
>  	int cpu = atomic_xchg(&scx_hardlockup_cpu, -1);
>  
> -	if (cpu >= 0 && handle_lockup("hard lockup - CPU %d", cpu))
> +	if (cpu >= 0 && handle_lockup(cpu, "hard lockup - CPU %d", cpu))

Repeating "cpu" in the argument list seems a bit redundant?

>  		printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabling BPF scheduler\n",
>  				cpu);
>  }
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index b4f5dd28855e..2d04f27cf7c5 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1486,8 +1486,6 @@ __printf(5, 6) bool __scx_exit(struct scx_sched *sch, enum scx_exit_kind kind,
>  	__scx_exit(sch, kind, exit_code, raw_smp_processor_id(), fmt, ##args)
>  #define scx_error(sch, fmt, args...)						\
>  	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
> -#define scx_verror(sch, fmt, args)						\
> -	scx_vexit((sch), SCX_EXIT_ERROR, 0, raw_smp_processor_id(), fmt, args)
>  
>  /*
>   * Return the rq currently locked from an scx callback, or NULL if no rq is
> -- 
> 2.48.1
> 
> 
