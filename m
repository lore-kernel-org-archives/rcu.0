Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10491BF38;
	Wed, 24 Jul 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837431; cv=none; b=rOgnWSXIV1JubXJDhNgVbVbHwvsLf98K+h31wjWyA0egG11NP7L2F/6VPDGLw5vPHMHTIpauUYpyHhi5ivcE5Nh5hRnC3EZsAhHzUZfdfPMlOMFyp6p5RAxldaRjya8V8NoIgYMLRPXOpyH8L1xWBvnNgZtYl+2axrQrbZE+KmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837431; c=relaxed/simple;
	bh=FsMcoZ4BemPCMLrrdySSCIthF4dj7vNJ19BQvP/sYqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewbrr4mdSLu7O06STJlPy+IzfI3/n3G+wwjZ2XvhNv/zfPwFcV2VZGp2ouGfdp54erOjaDu9Q/cDF9ztq6+gKyOA5EtYCHmGau7gO8DiswWWDMTqtoH4P0D6vyoRC+DH1Qwgf/UVyAQSWU/QODF8Vg5eKaeOfQURkfsRi6UXRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzurkySj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzurkySj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE16C32781;
	Wed, 24 Jul 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721837431;
	bh=FsMcoZ4BemPCMLrrdySSCIthF4dj7vNJ19BQvP/sYqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzurkySjj9PD4I2WS1wqKfjRt2ri978xFaKt7mc6Pj/FFiJ6wFUtsCRvSlhDed+Qz
	 RCqjCjwZnmxSsXSprI/QG54AZVm8BayANakZm724+xopkzUrtHaDc2EId4OI8wwN7Q
	 8vy8xpMwr7Yngmd0GJ1Ix2FnJfz6/WSYeE31iCRPfiXaWYv5fzy25BFvxLRSTlEKYC
	 c6Q5U+wVokHHR0r0P/CZNqgSS1Q6f9NMaOvXIQG2iTt85JEYzYSLfpIP+1Jzp4j7HA
	 ko4aBpyg3q10za91e1cVSyckvdJouPK8hEbrXHJJK5/qWkENbhQLLCTTro3tVpEKwe
	 M6LYuigZh7yGg==
Date: Wed, 24 Jul 2024 21:40:21 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, urezki@gmail.com, boqun.feng@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
Message-ID: <20240724161021.GA787377@neeraj.linux>
References: <20240710044542.444-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710044542.444-1-qiang.zhang1211@gmail.com>

On Wed, Jul 10, 2024 at 12:45:42PM +0800, Zqiang wrote:
> For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
> defined as NR_CPUS instead of the number of possible cpus, this
> will cause the following system panic:
> 
> smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> ...
> setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:1
> ...
> BUG: unable to handle page fault for address: ffffffff9911c8c8
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W
> 6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
> RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
> RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
> CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
> Call Trace:
> <TASK>
> ? __die+0x23/0x80
> ? page_fault_oops+0xa4/0x180
> ? exc_page_fault+0x152/0x180
> ? asm_exc_page_fault+0x26/0x40
> ? rcu_tasks_need_gpcb+0x25d/0x2c0
> ? __pfx_rcu_tasks_kthread+0x40/0x40
> rcu_tasks_one_gp+0x69/0x180
> rcu_tasks_kthread+0x94/0xc0
> kthread+0xe8/0x140
> ? __pfx_kthread+0x40/0x40
> ret_from_fork+0x34/0x80
> ? __pfx_kthread+0x40/0x40
> ret_from_fork_asm+0x1b/0x80
> </TASK>
> 
> Considering that there may be holes in the CPU numbers, use the
> maximum possible cpu number, instead of nr_cpu_ids, for configuring
> enqueue and dequeue limits.
> 
> Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
> Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---

Thanks! Pulled this for further review and testing [1]


[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=next

>  kernel/rcu/tasks.h | 80 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 2b1d6abf3ba3..12d63ce84cc9 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -49,6 +49,7 @@ struct rcu_tasks_percpu {
>  	struct list_head rtp_blkd_tasks;
>  	struct list_head rtp_exit_list;
>  	int cpu;
> +	int index;
>  	struct rcu_tasks *rtpp;
>  };
>  
> @@ -110,6 +111,7 @@ struct rcu_tasks {
>  	call_rcu_func_t call_func;
>  	unsigned int wait_state;
>  	struct rcu_tasks_percpu __percpu *rtpcpu;
> +	struct rcu_tasks_percpu **rtpcp_array;
>  	int percpu_enqueue_shift;
>  	int percpu_enqueue_lim;
>  	int percpu_dequeue_lim;
> @@ -182,6 +184,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
>  static int rcu_task_lazy_lim __read_mostly = 32;
>  module_param(rcu_task_lazy_lim, int, 0444);
>  
> +static int rcu_task_cpu_ids;
> +
>  /* RCU tasks grace-period state for debugging. */
>  #define RTGS_INIT		 0
>  #define RTGS_WAIT_WAIT_CBS	 1
> @@ -245,6 +249,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	int cpu;
>  	int lim;
>  	int shift;
> +	int maxcpu;
> +	int index = 0;
>  
>  	if (rcu_task_enqueue_lim < 0) {
>  		rcu_task_enqueue_lim = 1;
> @@ -254,14 +260,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	}
>  	lim = rcu_task_enqueue_lim;
>  
> -	if (lim > nr_cpu_ids)
> -		lim = nr_cpu_ids;
> -	shift = ilog2(nr_cpu_ids / lim);
> -	if (((nr_cpu_ids - 1) >> shift) >= lim)
> -		shift++;
> -	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> -	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> -	smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +	rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
> +	BUG_ON(!rtp->rtpcp_array);
> +
>  	for_each_possible_cpu(cpu) {
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>  
> @@ -273,14 +274,29 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
>  		rtpcp->cpu = cpu;
>  		rtpcp->rtpp = rtp;
> +		rtpcp->index = index;
> +		rtp->rtpcp_array[index] = rtpcp;
> +		index++;
>  		if (!rtpcp->rtp_blkd_tasks.next)
>  			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
>  		if (!rtpcp->rtp_exit_list.next)
>  			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> +		maxcpu = cpu;
>  	}
>  
> -	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
> -			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
> +	rcu_task_cpu_ids = maxcpu + 1;
> +	if (lim > rcu_task_cpu_ids)
> +		lim = rcu_task_cpu_ids;
> +	shift = ilog2(rcu_task_cpu_ids / lim);
> +	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
> +		shift++;
> +	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
> +	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
> +	smp_store_release(&rtp->percpu_enqueue_lim, lim);
> +
> +	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
> +			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
> +			rcu_task_cb_adjust, rcu_task_cpu_ids);
>  }
>  
>  // Compute wakeup time for lazy callback timer.
> @@ -348,7 +364,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  			rtpcp->rtp_n_lock_retries = 0;
>  		}
>  		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
> -		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
> +		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
>  			needadjust = true;  // Defer adjustment to avoid deadlock.
>  	}
>  	// Queuing callbacks before initialization not yet supported.
> @@ -368,10 +384,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>  	if (unlikely(needadjust)) {
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> -		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
> +		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
>  			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
> -			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
> -			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
> +			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
> +			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
>  			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
>  		}
>  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> @@ -444,6 +460,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  
>  	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
>  	for (cpu = 0; cpu < dequeue_limit; cpu++) {
> +		if (!cpu_possible(cpu))
> +			continue;
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>  
>  		/* Advance and accelerate any new callbacks. */
> @@ -481,7 +499,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>  		if (rtp->percpu_enqueue_lim > 1) {
> -			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
> +			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
>  			smp_store_release(&rtp->percpu_enqueue_lim, 1);
>  			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
>  			gpdone = false;
> @@ -496,7 +514,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
>  		}
>  		if (rtp->percpu_dequeue_lim == 1) {
> -			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
> +			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
> +				if (!cpu_possible(cpu))
> +					continue;
>  				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>  
>  				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
> @@ -511,30 +531,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  // Advance callbacks and invoke any that are ready.
>  static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
>  {
> -	int cpu;
> -	int cpunext;
>  	int cpuwq;
>  	unsigned long flags;
>  	int len;
> +	int index;
>  	struct rcu_head *rhp;
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	struct rcu_tasks_percpu *rtpcp_next;
>  
> -	cpu = rtpcp->cpu;
> -	cpunext = cpu * 2 + 1;
> -	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> -		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> -		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> -		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> -		cpunext++;
> -		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> -			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> -			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> +	index = rtpcp->index * 2 + 1;
> +	if (index < num_possible_cpus()) {
> +		rtpcp_next = rtp->rtpcp_array[index];
> +		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> +			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
>  			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> +			index++;
> +			if (index < num_possible_cpus()) {
> +				rtpcp_next = rtp->rtpcp_array[index];
> +				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> +					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
> +					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> +				}
> +			}
>  		}
>  	}
>  
> -	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
> +	if (rcu_segcblist_empty(&rtpcp->cblist))
>  		return;
>  	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>  	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
> -- 
> 2.17.1
> 
