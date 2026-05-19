Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503835203C;
	Tue, 19 May 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234483; cv=none; b=tq3R+feObZCWP2x8Nhebk29Mqnzv1YmsOtFSqzlPtzowwJzoO1AyITzS0tOaGU54UGxJHfoVItLdnI0OBDREwAazG8Y3uhXPGy2viX0uCzvVSmoV9v3xCdMTc8/m3pKTegWnZlDHGJvc3SA2DHMfaBWwg3ozK+6YVoR0HhX46Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234483; c=relaxed/simple;
	bh=1gjUiSPlfgIagmAicIJ0pcz1CgcwSgXGP5ZiTgJcDY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kghe66Q3LhX7MkE5jTdHnGnRhArGQDKOcor6QaOcWMBie5xH/POeSafj6FB14360oPXpEZtwBarK0400nYc0Vyr3AkAmpmEvbJAfcFUjWUnSaaiO6c8VG/uhWuCUQoGbYLUBM0BBImrBUa/CZk6KF9DUM/VomS7al7Zjy9S7nxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDTYrm2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDTYrm2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC5D1F000E9;
	Tue, 19 May 2026 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779234482;
	bh=B+XeH3IC9mRJ1A8g1U3cuAiivZ9MXxak7ba4JktxHv4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=kDTYrm2fc4KiRij1Q5day4rS8AwdVAy6zvuLuoeVZ2rj2da5QiC/j/6dFXWbxOnPM
	 UcHtJ1MBFNjNNadhNNtNKYrd5CnoKbKGR5cvHFjoNJ7Th4Sv5m76Ta0YzlvD7Rl0MS
	 v2gwbHd1iG/HXGSP6XfZMF1HdsEHIWqa+HB+UkTyUMUBt3sXtVcOkp5l1wu59bUMVp
	 NWP+pI1cwEvKqZ+Ui8d/GVD1A8Ecu+DWdKWR9fw2K2CWr2wHn0+mowTC51jD6iiFjo
	 jFmtQ6YmCI3d51835aX7oJ78GzwjzktJzZZv5GtXbr+FkZBzs2Am/zagDNW9g4PMYI
	 nf9RIykxWzI1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB85ACE0FF2; Tue, 19 May 2026 16:48:01 -0700 (PDT)
Date: Tue, 19 May 2026 16:48:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <e17e4c18-33a3-47dd-a866-e1e381b0c496@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260519171745.1551340-1-yphbchou0911@gmail.com>
 <20260519171745.1551340-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519171745.1551340-3-yphbchou0911@gmail.com>

On Wed, May 20, 2026 at 01:17:31AM +0800, Cheng-Yang Chou wrote:
> scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
> stalled one, and the expedited grace period path had no stalled CPU to
> report at all.
> 
> Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
> to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
> full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.
> Falls back to cpu_none_mask on allocation failure.
> 
> Store the stall mask in scx_sched rather than scx_exit_info, keeping the
> BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
> directly and dumps all stalled CPUs first to avoid losing them to
> truncation.
> 
> Use __GFP_NOWARN for the cpumask allocations in print_other_cpu_stall()
> and synchronize_rcu_expedited_wait(). Both allocate before calling
> nbcon_cpu_emergency_enter(). A warn_alloc() failure printout would use
> the normal printk path and risk deadlock if a stalled CPU holds a
> console lock.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

More comments below, mostly about care and feeding of cpumasks.

> ---
>  include/linux/sched/ext.h   |  4 +-
>  kernel/rcu/tree_exp.h       | 14 +++++--
>  kernel/rcu/tree_stall.h     | 15 ++++++--
>  kernel/sched/ext.c          | 76 ++++++++++++++++++++++++++++++++-----
>  kernel/sched/ext_internal.h |  1 +
>  5 files changed, 91 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 20b2343aa344..75cb8b119fb7 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -263,7 +263,7 @@ void sched_ext_dead(struct task_struct *p);
>  void print_scx_info(const char *log_lvl, struct task_struct *p);
>  void scx_softlockup(u32 dur_s);
>  bool scx_hardlockup(int cpu);
> -bool scx_rcu_cpu_stall(void);
> +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask);

See below for cpumask_var_t discussion.

>  #else	/* !CONFIG_SCHED_CLASS_EXT */
>  
> @@ -271,7 +271,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
>  static inline bool scx_hardlockup(int cpu) { return false; }
> -static inline bool scx_rcu_cpu_stall(void) { return false; }
> +static inline bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask) { return false; }

Ditto.

>  #endif	/* CONFIG_SCHED_CLASS_EXT */
>  
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d..b8f4ca984c1c 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -555,7 +555,8 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
>  /*
>   * Print out an expedited RCU CPU stall warning message.
>   */
> -static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j)
> +static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j,
> +					    struct cpumask *stalled_mask)

See below for cpumask_var_t discussion.

>  {
>  	int cpu;
>  	unsigned long mask;
> @@ -578,6 +579,8 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
>  			if (!(READ_ONCE(rnp->expmask) & mask))
>  				continue;
>  			ndetected++;
> +			if (stalled_mask)

To his should instead be:

			if (cpumask_available(stalled_mask))

Otherwise, this breaks in kernels built with CONFIG_CPUMASK_OFFSTACK=n.

> +				cpumask_set_cpu(cpu, stalled_mask);
>  			rdp = per_cpu_ptr(&rcu_data, cpu);
>  			pr_cont(" %d-%c%c%c%c", cpu,
>  				"O."[!!cpu_online(cpu)],
> @@ -659,23 +662,28 @@ static void synchronize_rcu_expedited_wait(void)
>  
>  	for (;;) {
>  		unsigned long j;
> +		cpumask_var_t stalled_mask;
> +		bool have_mask;
>  
>  		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
>  			return;
>  		if (rcu_stall_is_suppressed())
>  			continue;
>  
> +		have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWARN);
> +
>  		nbcon_cpu_emergency_enter();
>  
>  		j = jiffies;
>  		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
>  		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> -		synchronize_rcu_expedited_stall(jiffies_start, j);
> +		synchronize_rcu_expedited_stall(jiffies_start, j, have_mask ? stalled_mask : NULL);

An alternative to the ?: is to just pass the mask in and have
synchronize_rcu_expedited_stall(), or whatever it calls, invoke
cpumask_available() on it.

>  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
>  
>  		nbcon_cpu_emergency_exit();
>  
> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(have_mask ? stalled_mask : cpu_none_mask);

And the same here, but for panic_on_rcu_stall().

> +		free_cpumask_var(stalled_mask);

And free_cpumask_var() is happy to ignore a NULL pointer, so it is OK to
invoke it on the pointer passed to a failing call to zalloc_cpumask_var().

>  	}
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..90d6eaf1b841 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
>  early_initcall(check_cpu_stall_init);
>  
>  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> -static void panic_on_rcu_stall(void)
> +static void panic_on_rcu_stall(const struct cpumask *stalled_mask)

I suggest "cpumask_var_t" instead of "struct cpumask *", because
cpumask_var_t better handles on-stack vs. offstack cpumasks.

>  {
>  	static int cpu_stall;
>  
> @@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
>  	 * Attempt to kick out the BPF scheduler if it's installed and defer
>  	 * the panic to give the system a chance to recover.
>  	 */
> -	if (scx_rcu_cpu_stall())
> +	if (scx_rcu_cpu_stall(stalled_mask))
>  		return;
>  
>  	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> @@ -631,6 +631,8 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
>  static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  {
>  	int cpu;
> +	cpumask_var_t stalled_mask;
> +	bool have_mask;

Use of cpumask_available() should allow you to drop have_mask.

>  	unsigned long flags;
>  	unsigned long gpa;
>  	unsigned long j;
> @@ -645,6 +647,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	have_mask = zalloc_cpumask_var(&stalled_mask, GFP_ATOMIC | __GFP_NOWARN);
> +
>  	nbcon_cpu_emergency_enter();
>  
>  	/*
> @@ -660,6 +664,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  			for_each_leaf_node_possible_cpu(rnp, cpu)
>  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
>  					print_cpu_stall_info(cpu);
> +					if (have_mask)
> +						cpumask_set_cpu(cpu, stalled_mask);
>  					ndetected++;
>  				}
>  		}
> @@ -701,7 +707,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	panic_on_rcu_stall(have_mask ? stalled_mask : cpu_none_mask);
> +	free_cpumask_var(stalled_mask);
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
>  }
> @@ -754,7 +761,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	panic_on_rcu_stall(cpumask_of(smp_processor_id()));
>  
>  	/*
>  	 * Attempt to revive the RCU machinery by forcing a context switch.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 22b1356aa4eb..28797467f82a 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4948,6 +4948,8 @@ static const struct attribute_group scx_global_attr_group = {
>  
>  static void free_pnode(struct scx_sched_pnode *pnode);
>  static void free_exit_info(struct scx_exit_info *ei);
> +static const char *scx_exit_reason(enum scx_exit_kind kind);
> +static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
>  
>  static void scx_sched_free_rcu_work(struct work_struct *work)
>  {
> @@ -4962,6 +4964,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
>  	timer_shutdown_sync(&sch->bypass_lb_timer);
>  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
>  	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> +	free_cpumask_var(sch->stall_cpus);
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	kfree(sch->cgrp_path);
> @@ -5187,9 +5190,46 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
>   * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
>   * else already initiated abort.
>   */
> -bool scx_rcu_cpu_stall(void)
> +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)

And cpumask_var_t here as well.

>  {
> -	return handle_lockup(-1, "RCU CPU stall detected!");
> +	struct scx_sched *sch;
> +	struct scx_exit_info *ei;
> +	int exit_cpu;
> +
> +	guard(rcu)();
> +
> +	sch = rcu_dereference(scx_root);
> +	if (unlikely(!sch))
> +		return false;
> +
> +	switch (scx_enable_state()) {
> +	case SCX_ENABLING:
> +	case SCX_ENABLED:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);

And here you need a cpumask_available().  Please note that cpumask_empty()
does not play nicely with NULL pointers.

So maybe something like this:

	exit_cpu = (!cpumask_available(stalled_mask) || cpumask_empty(stalled_mask)) ? -1 : (int)cpumask_first(stalled_mask);

Or maybe the same thing, but with an "if" statement.

> +	ei = sch->exit_info;
> +
> +	guard(preempt)();
> +
> +	if (!scx_claim_exit(sch, SCX_EXIT_ERROR))
> +		return false;
> +
> +#ifdef CONFIG_STACKTRACE
> +	ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
> +#endif
> +	scnprintf(ei->msg, SCX_EXIT_MSG_LEN, "RCU CPU stall on CPUs (%*pbl)",
> +		  cpumask_pr_args(stalled_mask));
> +	ei->kind = SCX_EXIT_ERROR;
> +	ei->reason = scx_exit_reason(SCX_EXIT_ERROR);
> +	ei->exit_cpu = exit_cpu;
> +	cpumask_copy(sch->stall_cpus, stalled_mask);
> +
> +	irq_work_queue(&sch->disable_irq_work);
> +	return true;
>  }
>  
>  /**
> @@ -5204,7 +5244,8 @@ bool scx_rcu_cpu_stall(void)
>   */
>  void scx_softlockup(u32 dur_s)
>  {
> -	if (!handle_lockup(smp_processor_id(), "soft lockup - CPU %d stuck for %us",
> +	if (!handle_lockup(smp_processor_id(),
> +			   "soft lockup - CPU %d stuck for %us",
>  			   smp_processor_id(), dur_s))
>  		return;
>  
> @@ -6608,14 +6649,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
>  	dump_line(&s, "----------");
>  
>  	/*
> -	 * Dump the exit CPU first so it isn't lost to dump truncation, then
> -	 * walk the rest in order, skipping the one already dumped.
> +	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
> +	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
>  	 */
> -	if (ei->exit_cpu >= 0)
> -		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> -	for_each_possible_cpu(cpu) {
> -		if (cpu != ei->exit_cpu)
> +	if (!cpumask_empty(sch->stall_cpus)) {
> +		for_each_cpu(cpu, sch->stall_cpus)
>  			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		for_each_possible_cpu(cpu) {
> +			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
> +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		}
> +	} else {
> +		if (ei->exit_cpu >= 0)
> +			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> +		for_each_possible_cpu(cpu) {
> +			if (cpu != ei->exit_cpu)
> +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> +		}
>  	}
>  
>  	dump_newline(&s);
> @@ -6851,6 +6901,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  		ret = -ENOMEM;
>  		goto err_free_lb_cpumask;
>  	}
> +	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto err_free_lb_resched_cpumask;

This is sufficient to make sure that sch->stall_cpus is never used,
correct?

Otherwise, there needs to be a bunch of cpumask_available() checks
guarding this uses of ->stall_cpus.

							Thanx, Paul

> +	}
>  	/*
>  	 * Copy ops through the right union view. For cid-form the source is
>  	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
> @@ -6920,8 +6974,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  #ifdef CONFIG_EXT_SUB_SCHED
>  err_free_lb_resched:
>  	RCU_INIT_POINTER(ops->priv, NULL);
> -	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> +	free_cpumask_var(sch->stall_cpus);
>  #endif
> +err_free_lb_resched_cpumask:
> +	free_cpumask_var(sch->bypass_lb_resched_cpumask);
>  err_free_lb_cpumask:
>  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
>  err_stop_helper:
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 3ccfea06cba0..f51f03868ff7 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1178,6 +1178,7 @@ struct scx_sched {
>  	struct timer_list	bypass_lb_timer;
>  	cpumask_var_t		bypass_lb_donee_cpumask;
>  	cpumask_var_t		bypass_lb_resched_cpumask;
> +	cpumask_var_t		stall_cpus;
>  	struct rcu_work		rcu_work;
>  
>  	/* all ancestors including self */
> -- 
> 2.48.1
> 
