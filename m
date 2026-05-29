Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D23FF1D9
	for <rcu@vger.kernel.org>; Fri, 29 May 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069926; cv=none; b=rkYBMlx9TnLav6LVE8+657WhUKCiSWiC+OaQjgT7IIdeBEVpGDqJqh+lfK4/a3xCC5XDgiBA2EBu/SM1/n1SYBBD5jAAdNxdifjBBcy9FxsNI16mSmTSrumA6ccgM5l30I7JqD/Njk41z6pgEasr6kOoqHlJe1GezX5iInJy4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069926; c=relaxed/simple;
	bh=DOt/FscedNBalKmbrCX7DNYaR2v+1Xccunjq7K5Dra8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvmIwebBL0UyWfMz1i1ciyfZVe07sHwGM3FdLkiX5WWRLVL+J6KqSMS7JYtU58Qge0Oy5b7NCEOBkcFztHwnxd7i9SbfjQ/UJQgfnWq4K6INwWiv0N/pcA1ExSIZw5+Ey9zovAhHxR/flkiKozMU+jtr3Nm1HTJynpE+T/Xs+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3xtfuju; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3xtfuju"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8572350022so544061a12.1
        for <rcu@vger.kernel.org>; Fri, 29 May 2026 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780069919; x=1780674719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyvZfJ64Ok9rkT1fbSw+QwvuGZzuFxNCaqmrG+8+EWg=;
        b=Y3xtfujuzghSrL0io9II3yXxJc3CQxuK/nVbK6UlZBYdPxz+ZBU98TT5/DC6nGzHTN
         WmWZYHuabrqaTPmv7hv+5sihsi5Pl7k+HX3kF2PP9RqaxPS984uxG0rv22p7TJQSQ9xW
         LhmtJGq5CprwvVHh4it5UcsVCi31Ige4S2vjjc4DKspKbOY/UoqxI06TAPc0pMbEpo82
         RgsfVe4QTX0+ne8c3RtkRaTJAaL8nVXKci/0Up1Fg2wIRmgze9ZLnjH7muiy/06ZVk9k
         0AmbdEppZP/tjE92Wjq67Gjm20QXMOJwsM0Dr0S0yLI2uYr14+YCknGeyqdAwVW8AAQ2
         mGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780069919; x=1780674719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyvZfJ64Ok9rkT1fbSw+QwvuGZzuFxNCaqmrG+8+EWg=;
        b=byNWxmDY68h5G01qcO8uzFhvkOTug1joUPpzyR/QX2gcdADtWjVyjRDDF77R8n+UaV
         iCESiRpPqL+KfbaekxrbG0JjSsmr5aYtDVFv+YFYQPXgaDcE8j8P2caKbMsaDy8BG1cv
         6+eLmi4iAyvcU1Kpbbn8UBqfLWe8Frvj+tITXyMf4eNf3snAM7cUBFXqgZZ2LekPgNpH
         5vE0KF8rYpa+JcIL1xeQaJSUYyekOp9k1t40n+LhSN7xcV3e8noqktWZ3pqiNK24ohfl
         2rDgI7DbVpwFW+/cLS2d6Kii9IqZ5phsCkR/CIsw5JYIBet6Y6RlY4URhY6WrCf1uRJO
         SFnA==
X-Forwarded-Encrypted: i=1; AFNElJ9Bt9XyY3HFzpqybIhDuq/cpXVVGKL4PthloWIud9Bl/VkHYncdCYf3KxoS3gDz/hm1XlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoD6muiplYqEXi8M2kV4oj50a7TjwOZR88RvXjFUH9HulH9WaM
	IXRaD3W9UKdgzdRBodG/BRyav9k4fbyMRjw01buqmpDlYl4JskW49whH
X-Gm-Gg: Acq92OE1NmxJl03KUBu2oJEKH1W93LcMqZkiU3lO3xFYqOSLH2WMkIyzQ7zCR0fkbtv
	B0KRbgy0b9un/0vAzNEy6cY9eFga1Rw/uZqYAj5k+TVAueGrEC+IgNRVfJxthmDRwXt1nE1pwqb
	MRJnqjMAusrrisvU70XWEH6A3ATg8v3ro5bVJJ/O2y+FSoFO6Z5fxjipPt+kQx2eCHfxiU0xWZV
	6VKkiU6r6xZzt7gOIMg9Zw/D7EnDHINzzBtPNnBUvDPP1xvc3TKa4YprgpmtquwgWkCgGPcxd+A
	NYVwD8wE3zHBbBTr/drLHBKIypiLIrFJMTBkfUUzJBfeuVjB/IM6ryYnr+Ha9ccpJXp228Anp78
	jIAkAOzKiowohhGgp7PyZieiNd6HSaFiirls9GSw8pm42iSDu0GmqMMPdI5gCDbeq7LKInMzhhJ
	jsrqmueswy8rJtW7MqHNzPVn0mfZEWLClqoa13nD/RqYMnx+fNpqrCEcaCqBHUFH/89dg6jNfLe
	+qi1rIhStnqfFfo
X-Received: by 2002:a05:6a20:cf8d:b0:3b3:26aa:5453 with SMTP id adf61e73a8af0-3b4122c8ec2mr3974845637.29.1780069918806;
        Fri, 29 May 2026 08:51:58 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-227-39.dynamic-ip.hinet.net. [36.226.227.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8580efbad6sm579028a12.13.2026.05.29.08.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:51:58 -0700 (PDT)
Date: Fri, 29 May 2026 23:51:54 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260529234948.G96b5@cchengyang.duckdns.org>
References: <20260521161636.1893894-1-yphbchou0911@gmail.com>
 <20260521161636.1893894-3-yphbchou0911@gmail.com>
 <6e26e461-6953-4161-835d-5e4412f8ba33@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e26e461-6953-4161-835d-5e4412f8ba33@paulmck-laptop>

Hi Paul,

On Wed, May 27, 2026 at 04:19:08PM -0700, Paul E. McKenney wrote:
[...]
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 82cada459e5d..0a9a509c8c91 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -555,7 +555,8 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
> >  /*
> >   * Print out an expedited RCU CPU stall warning message.
> >   */
> > -static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j)
> > +static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigned long j,
> > +					    struct cpumask *stalled_mask)
> >  {
> >  	int cpu;
> >  	unsigned long mask;
> > @@ -578,6 +579,7 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
> >  			if (!(READ_ONCE(rnp->expmask) & mask))
> >  				continue;
> >  			ndetected++;
> > +			cpumask_set_cpu(cpu, stalled_mask);
> >  			rdp = per_cpu_ptr(&rcu_data, cpu);
> >  			pr_cont(" %d-%c%c%c%c", cpu,
> >  				"O."[!!cpu_online(cpu)],
> > @@ -665,17 +667,19 @@ static void synchronize_rcu_expedited_wait(void)
> >  		if (rcu_stall_is_suppressed())
> >  			continue;
> >  
> > +		cpumask_clear(&rcu_exp_stall_cpumask);
> > +
> >  		nbcon_cpu_emergency_enter();
> >  
> >  		j = jiffies;
> >  		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
> >  		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
> > -		synchronize_rcu_expedited_stall(jiffies_start, j);
> > +		synchronize_rcu_expedited_stall(jiffies_start, j, &rcu_exp_stall_cpumask);
> 
> Are we ever going to pass some other cpumask to this function?
> 
> I would not expect that the rcu_stall_cpumask would ever be passed in
> here, for example.  And the two definitions in tree.c are visible to
> the synchronize_rcu_expedited_stall() function.

Agree, drop in v6, thanks!

> 
> Or am I missing something here?
> 
> >  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
> >  
> >  		nbcon_cpu_emergency_exit();
> >  
> > -		panic_on_rcu_stall();
> > +		panic_on_rcu_stall(&rcu_exp_stall_cpumask);
> 
> Now this one I get: This function is called from both normal and expedited
> RCU CPU stall code.
> 
> >  	}
> >  }
> >  
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index b67532cb8770..d0c4f193f17e 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -159,7 +159,7 @@ static int __init check_cpu_stall_init(void)
> >  early_initcall(check_cpu_stall_init);
> >  
> >  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> > -static void panic_on_rcu_stall(void)
> > +static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> >  {
> >  	static int cpu_stall;
> >  
> > @@ -167,7 +167,7 @@ static void panic_on_rcu_stall(void)
> >  	 * Attempt to kick out the BPF scheduler if it's installed and defer
> >  	 * the panic to give the system a chance to recover.
> >  	 */
> > -	if (scx_rcu_cpu_stall())
> > +	if (scx_rcu_cpu_stall(stalled_mask))
> >  		return;
> >  
> >  	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> > @@ -645,6 +645,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  	if (rcu_stall_is_suppressed())
> >  		return;
> >  
> > +	cpumask_clear(&rcu_stall_cpumask);
> > +
> >  	nbcon_cpu_emergency_enter();
> >  
> >  	/*
> > @@ -660,6 +662,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  			for_each_leaf_node_possible_cpu(rnp, cpu)
> >  				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
> >  					print_cpu_stall_info(cpu);
> > +					cpumask_set_cpu(cpu, &rcu_stall_cpumask);
> >  					ndetected++;
> >  				}
> >  		}
> > @@ -701,7 +704,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  
> >  	nbcon_cpu_emergency_exit();
> >  
> > -	panic_on_rcu_stall();
> > +	panic_on_rcu_stall(&rcu_stall_cpumask);
> >  
> >  	rcu_force_quiescent_state();  /* Kick them all. */
> >  }
> > @@ -754,7 +757,9 @@ static void print_cpu_stall(unsigned long gp_seq, unsigned long gps)
> >  
> >  	nbcon_cpu_emergency_exit();
> >  
> > -	panic_on_rcu_stall();
> > +	cpumask_clear(&rcu_stall_cpumask);
> > +	cpumask_set_cpu(smp_processor_id(), &rcu_stall_cpumask);
> > +	panic_on_rcu_stall(&rcu_stall_cpumask);
> >  
> >  	/*
> >  	 * Attempt to revive the RCU machinery by forcing a context switch.
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 22b1356aa4eb..7bf3c22d573e 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -4948,6 +4948,8 @@ static const struct attribute_group scx_global_attr_group = {
> >  
> >  static void free_pnode(struct scx_sched_pnode *pnode);
> >  static void free_exit_info(struct scx_exit_info *ei);
> > +static const char *scx_exit_reason(enum scx_exit_kind kind);
> > +static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind);
> >  
> >  static void scx_sched_free_rcu_work(struct work_struct *work)
> >  {
> > @@ -4962,6 +4964,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
> >  	timer_shutdown_sync(&sch->bypass_lb_timer);
> >  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
> >  	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> > +	free_cpumask_var(sch->stall_cpus);
> >  
> >  #ifdef CONFIG_EXT_SUB_SCHED
> >  	kfree(sch->cgrp_path);
> > @@ -5187,9 +5190,46 @@ static __printf(2, 3) bool handle_lockup(int exit_cpu, const char *fmt, ...)
> >   * resolve the reported RCU stall. %false if sched_ext is not enabled or someone
> >   * else already initiated abort.
> >   */
> > -bool scx_rcu_cpu_stall(void)
> > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> >  {
> > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > +	struct scx_sched *sch;
> > +	struct scx_exit_info *ei;
> > +	int exit_cpu;
> > +
> > +	guard(rcu)();
> > +
> > +	sch = rcu_dereference(scx_root);
> > +	if (unlikely(!sch))
> > +		return false;
> > +
> > +	switch (scx_enable_state()) {
> > +	case SCX_ENABLING:
> > +	case SCX_ENABLED:
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> > +
> > +	exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > +	ei = sch->exit_info;
> > +
> > +	guard(preempt)();
> > +
> > +	if (!scx_claim_exit(sch, SCX_EXIT_ERROR))
> > +		return false;
> > +
> > +#ifdef CONFIG_STACKTRACE
> > +	ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
> > +#endif
> > +	scnprintf(ei->msg, SCX_EXIT_MSG_LEN, "RCU CPU stall on CPUs (%*pbl)",
> > +		  cpumask_pr_args(stalled_mask));
> > +	ei->kind = SCX_EXIT_ERROR;
> > +	ei->reason = scx_exit_reason(SCX_EXIT_ERROR);
> > +	ei->exit_cpu = exit_cpu;
> > +	cpumask_copy(sch->stall_cpus, stalled_mask);
> > +
> > +	irq_work_queue(&sch->disable_irq_work);
> > +	return true;
> >  }
> >  
> >  /**
> > @@ -6608,14 +6648,23 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
> >  	dump_line(&s, "----------");
> >  
> >  	/*
> > -	 * Dump the exit CPU first so it isn't lost to dump truncation, then
> > -	 * walk the rest in order, skipping the one already dumped.
> > +	 * Dump stalled CPUs first so they aren't lost to dump truncation, then
> > +	 * walk the rest in order. Fall back to exit_cpu if no stall mask set.
> >  	 */
> > -	if (ei->exit_cpu >= 0)
> > -		scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> > -	for_each_possible_cpu(cpu) {
> > -		if (cpu != ei->exit_cpu)
> > +	if (!cpumask_empty(sch->stall_cpus)) {
> > +		for_each_cpu(cpu, sch->stall_cpus)
> >  			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> > +		for_each_possible_cpu(cpu) {
> > +			if (!cpumask_test_cpu(cpu, sch->stall_cpus))
> > +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> > +		}
> > +	} else {
> > +		if (ei->exit_cpu >= 0)
> > +			scx_dump_cpu(sch, &s, &dctx, ei->exit_cpu, dump_all_tasks);
> > +		for_each_possible_cpu(cpu) {
> > +			if (cpu != ei->exit_cpu)
> > +				scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
> > +		}
> >  	}
> >  
> >  	dump_newline(&s);
> > @@ -6851,6 +6900,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
> >  		ret = -ENOMEM;
> >  		goto err_free_lb_cpumask;
> >  	}
> > +	if (!zalloc_cpumask_var(&sch->stall_cpus, GFP_KERNEL)) {
> > +		ret = -ENOMEM;
> > +		goto err_free_lb_resched_cpumask;
> > +	}
> >  	/*
> >  	 * Copy ops through the right union view. For cid-form the source is
> >  	 * struct sched_ext_ops_cid which lacks the trailing cpu_acquire/
> > @@ -6920,8 +6973,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
> >  #ifdef CONFIG_EXT_SUB_SCHED
> >  err_free_lb_resched:
> >  	RCU_INIT_POINTER(ops->priv, NULL);
> > -	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> > +	free_cpumask_var(sch->stall_cpus);
> >  #endif
> > +err_free_lb_resched_cpumask:
> > +	free_cpumask_var(sch->bypass_lb_resched_cpumask);
> >  err_free_lb_cpumask:
> >  	free_cpumask_var(sch->bypass_lb_donee_cpumask);
> >  err_stop_helper:
> > diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> > index 3ccfea06cba0..f51f03868ff7 100644
> > --- a/kernel/sched/ext_internal.h
> > +++ b/kernel/sched/ext_internal.h
> > @@ -1178,6 +1178,7 @@ struct scx_sched {
> >  	struct timer_list	bypass_lb_timer;
> >  	cpumask_var_t		bypass_lb_donee_cpumask;
> >  	cpumask_var_t		bypass_lb_resched_cpumask;
> > +	cpumask_var_t		stall_cpus;
> >  	struct rcu_work		rcu_work;
> >  
> >  	/* all ancestors including self */
> > -- 
> > 2.48.1
> > 

-- 
Cheers,
Cheng-Yang
