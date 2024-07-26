Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96255149E1D;
	Fri, 26 Jul 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033659; cv=none; b=eXsq4ilkmcijjwzxP4My3DmTi1XoPWU0WydUHrM22QxQYZRvzVkOQpkyy4cAhQ/b8M34qQPrhiK2GPHpp+aL+V7shMItYyv+8WooQ9YPgc1nzuFKCsp867rXSB96NG4vVOOII01FutcgFDDa+JBgzgxtPfPG2Q1v86Rx09LtwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033659; c=relaxed/simple;
	bh=TQ9lohRa2QJoVt7ObZqSokbS/JdwhTgCvCBZ8u69srs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY+JNh+UFXZmqsyhE/OqmlUJ9ld/8EiesgLmArbNeK2OuEiB1G6EjBfrd7HQyGfwR01LkHdd5q9j5raLmQHsJZuKUPTwdNh0RAH1d97ll0qPTNu3pWbVWvL/pSPvi+i9EzjFGDUs6B5pYDM02B78Nf1VFMT5G8qTv9Wcyj+SEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D26PbP65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D26PbP65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA79C32782;
	Fri, 26 Jul 2024 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722033659;
	bh=TQ9lohRa2QJoVt7ObZqSokbS/JdwhTgCvCBZ8u69srs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D26PbP65t+dxWMBZI/5/le9DTBGroSNdIPxylRvd7Aq7n4lVgA/bioXRxlO/KGYVL
	 rTowmtkmrOHER0pGrGaygj/KIaAtfdlWXOr894BftKROPzFRC21M0j8GXH0SeQd5H6
	 pg9mlAFJZ36vLthog+GNrhxeHFs/wBSaG1yM564E8dF1/Ub/5vJ5kSbZ1o7fku9ovn
	 rXxeOxF3J7Udza/fOOV0DmShyP8d0kFtIG8JTuo5gUg060YEApfxuL6UBYKMUjSKzF
	 dbR/1LOJB6mswxKmO3cuG0qVBMpzsxAgYn3rzAcdsqWXBKdv+8kONpoANvl7CvYIRF
	 v9U6ftuLGLZCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 089B7CE0B34; Fri, 26 Jul 2024 15:40:59 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:40:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 20/20] rcu: Use kthread preferred affinity for RCU
 exp kworkers
Message-ID: <7734a2b6-2cc9-4133-adbe-ac34fabebc7a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-21-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726215701.19459-21-frederic@kernel.org>

On Fri, Jul 26, 2024 at 11:56:56PM +0200, Frederic Weisbecker wrote:
> Now that kthreads have an infrastructure to handle preferred affinity
> against CPU hotplug and housekeeping cpumask, convert RCU exp workers to
> use it instead of handling all the constraints by itself.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Nice consolidation of troublesome code!

For this one and 17/20:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c | 105 +++++++++-------------------------------------
>  1 file changed, 19 insertions(+), 86 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e038f4abb872..f3e40a1dea65 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4777,6 +4777,22 @@ rcu_boot_init_percpu_data(int cpu)
>  	rcu_boot_init_nocb_percpu_data(rdp);
>  }
>  
> +static void rcu_thread_affine_rnp(struct task_struct *t, struct rcu_node *rnp)
> +{
> +	cpumask_var_t affinity;
> +	int cpu;
> +
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> +		return;
> +
> +	for_each_leaf_node_possible_cpu(rnp, cpu)
> +		cpumask_set_cpu(cpu, affinity);
> +
> +	kthread_affine_preferred(t, affinity);
> +
> +	free_cpumask_var(affinity);
> +}
> +
>  struct kthread_worker *rcu_exp_gp_kworker;
>  
>  static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
> @@ -4789,7 +4805,7 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
>  	if (rnp->exp_kworker)
>  		return;
>  
> -	kworker = kthread_run_worker(0, name, rnp_index);
> +	kworker = kthread_create_worker(0, name, rnp_index);
>  	if (IS_ERR_OR_NULL(kworker)) {
>  		pr_err("Failed to create par gp kworker on %d/%d\n",
>  		       rnp->grplo, rnp->grphi);
> @@ -4799,16 +4815,9 @@ static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
>  
>  	if (IS_ENABLED(CONFIG_RCU_EXP_KTHREAD))
>  		sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
> -}
>  
> -static struct task_struct *rcu_exp_par_gp_task(struct rcu_node *rnp)
> -{
> -	struct kthread_worker *kworker = READ_ONCE(rnp->exp_kworker);
> -
> -	if (!kworker)
> -		return NULL;
> -
> -	return kworker->task;
> +	rcu_thread_affine_rnp(kworker->task, rnp);
> +	wake_up_process(kworker->task);
>  }
>  
>  static void __init rcu_start_exp_gp_kworker(void)
> @@ -4893,79 +4902,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void rcu_thread_affine_rnp(struct task_struct *t, struct rcu_node *rnp)
> -{
> -	cpumask_var_t affinity;
> -	int cpu;
> -
> -	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> -		return;
> -
> -	for_each_leaf_node_possible_cpu(rnp, cpu)
> -		cpumask_set_cpu(cpu, affinity);
> -
> -	kthread_affine_preferred(t, affinity);
> -
> -	free_cpumask_var(affinity);
> -}
> -
> -/*
> - * Update kthreads affinity during CPU-hotplug changes.
> - *
> - * Set the per-rcu_node kthread's affinity to cover all CPUs that are
> - * served by the rcu_node in question.  The CPU hotplug lock is still
> - * held, so the value of rnp->qsmaskinit will be stable.
> - *
> - * We don't include outgoingcpu in the affinity set, use -1 if there is
> - * no outgoing CPU.  If there are no CPUs left in the affinity set,
> - * this function allows the kthread to execute on any CPU.
> - *
> - * Any future concurrent calls are serialized via ->kthread_mutex.
> - */
> -static void rcutree_affinity_setting(unsigned int cpu, int outgoingcpu)
> -{
> -	cpumask_var_t cm;
> -	unsigned long mask;
> -	struct rcu_data *rdp;
> -	struct rcu_node *rnp;
> -	struct task_struct *task_exp;
> -
> -	rdp = per_cpu_ptr(&rcu_data, cpu);
> -	rnp = rdp->mynode;
> -
> -	task_exp = rcu_exp_par_gp_task(rnp);
> -
> -	/*
> -	 * If CPU is the boot one, this task is created later from early
> -	 * initcall since kthreadd must be created first.
> -	 */
> -	if (!task_exp)
> -		return;
> -
> -	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> -		return;
> -
> -	mutex_lock(&rnp->kthread_mutex);
> -	mask = rcu_rnp_online_cpus(rnp);
> -	for_each_leaf_node_possible_cpu(rnp, cpu)
> -		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
> -		    cpu != outgoingcpu)
> -			cpumask_set_cpu(cpu, cm);
> -	cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
> -	if (cpumask_empty(cm)) {
> -		cpumask_copy(cm, housekeeping_cpumask(HK_TYPE_RCU));
> -		if (outgoingcpu >= 0)
> -			cpumask_clear_cpu(outgoingcpu, cm);
> -	}
> -
> -	if (task_exp)
> -		set_cpus_allowed_ptr(task_exp, cm);
> -
> -	mutex_unlock(&rnp->kthread_mutex);
> -
> -	free_cpumask_var(cm);
> -}
> -
>  /*
>   * Has the specified (known valid) CPU ever been fully online?
>   */
> @@ -4994,7 +4930,6 @@ int rcutree_online_cpu(unsigned int cpu)
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return 0; /* Too early in boot for scheduler work. */
>  	sync_sched_exp_online_cleanup(cpu);
> -	rcutree_affinity_setting(cpu, -1);
>  
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
> @@ -5207,8 +5142,6 @@ int rcutree_offline_cpu(unsigned int cpu)
>  	rnp->ffmask &= ~rdp->grpmask;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  
> -	rcutree_affinity_setting(cpu, cpu);
> -
>  	// nohz_full CPUs need the tick for stop-machine to work quickly
>  	tick_dep_set(TICK_DEP_BIT_RCU);
>  	return 0;
> -- 
> 2.45.2
> 
