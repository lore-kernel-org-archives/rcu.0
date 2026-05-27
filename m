Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22373546D1;
	Wed, 27 May 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923950; cv=none; b=fm3dgs/UrROOrURyri9enE63YZgCKZPGSl7VA03Q+NdHU0NKBabdT/S8qgNfoGdlA5gLX2o4wKwX7hamQZ+3bPtgwJejXOhqbOS5Bl19cBXHAkM8aVi8vcq03lXEeQMf8aBFdfS7mIdUGOnYR6B2nmwgD1E6Ka3JR/L38VOvgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923950; c=relaxed/simple;
	bh=iQWCvwPEHEv45nctaGyzPmptgnKDSKAzEjuaSXHIfoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfMeVtCwuZhnYreJzEd9ca8AC5ZLV3aub8/0Q/bfEINH6YnfE4WVoKlMPZD02JDl7LZj5ocHiSMLqHjqHamVvB9viyNzJHTOvGGJ5phTq/G8LU5ThZHPE+kkfa2rRpwEfNDdhW2evqy8m8lvIwBgp+tjW+PYSCj8Job39Dqf31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LemT2UR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LemT2UR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25081F000E9;
	Wed, 27 May 2026 23:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779923948;
	bh=L5hz5XdC6xiyO/iXpWMo0roso3fsRnu7qO5TZXdmA4g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LemT2UR6SHcHUm6wve83/V+79dYhEA/d6wLbP31fdGHIPujxdLUQ8wMXNuofkTodx
	 LZKQheresAwz150DuAbO2Uz08E0dZYnvJr0Jq9R5GiEd93XMTKysFEfvrRFsZVCurz
	 zWiQsZZT/cW4v4zVFriXkv3fqiKxk9c9TlY9VII1yGRxCdGLHjt7pG+jNnsynNd59e
	 joWv2HivMI1FAcLBPbYJjbC+QTl/gEBTOmBr1WUDDNzc1mud2Ud/tmO/FNEg6fH/fn
	 Orrs8Fu0ql7UQy5xVoKdiKjJGkcE9obpr7Rm5EM9/FxsJY91Hcjgdq4TGrcgnTDCwV
	 ermDJJs6aLxsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6FCC6CE10CD; Wed, 27 May 2026 16:19:08 -0700 (PDT)
Date: Wed, 27 May 2026 16:19:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <6e26e461-6953-4161-835d-5e4412f8ba33@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260521161636.1893894-1-yphbchou0911@gmail.com>
 <20260521161636.1893894-3-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521161636.1893894-3-yphbchou0911@gmail.com>

On Fri, May 22, 2026 at 12:16:10AM +0800, Cheng-Yang Chou wrote:
> scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
> stalled one, and the expedited grace period path had no stalled CPU to
> report at all.
> 
> Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
> to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
> full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.
> 
> Store the stall mask in scx_sched rather than scx_exit_info, keeping the
> BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
> directly and dumps all stalled CPUs first to avoid losing them to
> truncation.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Much better!  One question below.

							Thanx, Paul

> ---
>  include/linux/sched/ext.h   |  4 +-
>  kernel/rcu/tree.c           |  3 ++
>  kernel/rcu/tree_exp.h       | 10 +++--
>  kernel/rcu/tree_stall.h     | 13 +++++--
>  kernel/sched/ext.c          | 73 ++++++++++++++++++++++++++++++++-----
>  kernel/sched/ext_internal.h |  1 +
>  6 files changed, 86 insertions(+), 18 deletions(-)
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
>  
>  #else	/* !CONFIG_SCHED_CLASS_EXT */
>  
> @@ -271,7 +271,7 @@ static inline void sched_ext_dead(struct task_struct *p) {}
>  static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
>  static inline void scx_softlockup(u32 dur_s) {}
>  static inline bool scx_hardlockup(int cpu) { return false; }
> -static inline bool scx_rcu_cpu_stall(void) { return false; }
> +static inline bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask) { return false; }
>  
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 55df6d37145e..03c9651be5c0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4871,6 +4871,9 @@ static void __init rcu_dump_rcu_node_tree(void)
>  
>  struct workqueue_struct *rcu_gp_wq;
>  
> +static struct cpumask rcu_stall_cpumask;
> +static struct cpumask rcu_exp_stall_cpumask;

This works!  ;-)

>  void __init rcu_init(void)
>  {
>  	int cpu = smp_processor_id();
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 82cada459e5d..0a9a509c8c91 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -555,7 +555,8 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
>  /*
>   * Print out an expedited RCU CPU stall warning message.
>   */
> -static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j)
> +static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j,
> +					    struct cpumask *stalled_mask)
>  {
>  	int cpu;
>  	unsigned long mask;
> @@ -578,6 +579,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
>  			if (!(READ_ONCE(rnp->expmask) & mask))
>  				continue;
>  			ndetected++;
> +			cpumask_set_cpu(cpu, stalled_mask);
>  			rdp = per_cpu_ptr(&rcu_data, cpu);
>  			pr_cont(" %d-%c%c%c%c", cpu,
>  				"O."[!!cpu_online(cpu)],
> @@ -665,17 +667,19 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (rcu_stall_is_suppressed())
>  			continue;
>  
> +		cpumask_clear(&rcu_exp_stall_cpumask);
> +
>  		nbcon_cpu_emergency_enter();
>  
>  		j = jiffies;
>  		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
>  		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> -		synchronize_rcu_expedited_stall(jiffies_start, j);
> +		synchronize_rcu_expedited_stall(jiffies_start, j, &rcu_exp_stall_cpumask);

Are we ever going to pass some other cpumask to this function?

I would not expect that the rcu_stall_cpumask would ever be passed in
here, for example.  And the two definitions in tree.c are visible to
the synchronize_rcu_expedited_stall() function.

Or am I missing something here?

>  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
>  
>  		nbcon_cpu_emergency_exit();
>  
> -		panic_on_rcu_stall();
> +		panic_on_rcu_stall(&rcu_exp_stall_cpumask);

Now this one I get: This function is called from both normal and expedited
RCU CPU stall code.

>  	}
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b67532cb8770..d0c4f193f17e 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
>  early_initcall(check_cpu_stall_init);
>  
>  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> -static void panic_on_rcu_stall(void)
> +static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
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
> @@ -645,6 +645,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	cpumask_clear(&rcu_stall_cpumask);
> +
>  	nbcon_cpu_emergency_enter();
>  
>  	/*
> @@ -660,6 +662,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  			for_each_leaf_node_possible_cpu(rnp, cpu)
>  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
>  					print_cpu_stall_info(cpu);
> +					cpumask_set_cpu(cpu, &rcu_stall_cpumask);
>  					ndetected++;
>  				}
>  		}
> @@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	panic_on_rcu_stall(&rcu_stall_cpumask);
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
>  }
> @@ -754,7 +757,9 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  
>  	nbcon_cpu_emergency_exit();
>  
> -	panic_on_rcu_stall();
> +	cpumask_clear(&rcu_stall_cpumask);
> +	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
> +	panic_on_rcu_stall(&rcu_stall_cpumask);
>  
>  	/*
>  	 * Attempt to revive the RCU machinery by forcing a context switch.
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 22b1356aa4eb..7bf3c22d573e 100644
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
> @@ -6608,14 +6648,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
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
> @@ -6851,6 +6900,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  		ret = -ENOMEM;
>  		goto err_free_lb_cpumask;
>  	}
> +	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
> +		ret = -ENOMEM;
> +		goto err_free_lb_resched_cpumask;
> +	}
>  	/*
>  	 * Copy ops through the right union view. For cid-form the source is
>  	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
> @@ -6920,8 +6973,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
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
