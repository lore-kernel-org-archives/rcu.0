Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0681736;
	Mon,  3 Jun 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717458326; cv=none; b=RTy8khruhE8nA1Zo9PtZKsYpFhuedRmhD5k2b8Ybqi9TtjA/GXDLTbKc4SwU9fyYyNOv/3CanJDX3yDoWUhSONTeStUsYt8hAT+t4LVryXObuwAO/G75JC9mHeEKCxzq/hWairr/95x7F3O7IbVgsJ4crd0M9ToSvXQqiwyWie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717458326; c=relaxed/simple;
	bh=DbU+XQ/XkYtbTmKjV5hcCfjQrOxiNIptXpeRmytd4Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI1ioK2NFRPCXTdgpgWcNTzLD7JbYtl6jhODFIc1FAU4plKnhn02BF6KdhbsdVUkY7m815vkT6Iqt5GcYTSYFomf7jiZJbA7Vi/Yre05uRUBH6HtwIKisV3aepka8f68fx+rSOo75gXZUt51ClWc4bmfuOh+YLBMf4jXoE6kwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWUBDTTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWUBDTTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A1CC2BD10;
	Mon,  3 Jun 2024 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717458325;
	bh=DbU+XQ/XkYtbTmKjV5hcCfjQrOxiNIptXpeRmytd4Aw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PWUBDTTBIowKAZchLW/zgOSAEjSpS5hSZw7PsHFb3HC+2vGzJfK5/SebdPTdlhBMe
	 H8600XOkzf6cx8AG88BqfaTPfX7Xw96PD/FHlryBvlM4vxucDuacW6/w9/gacie0qh
	 GHSaonHawrO6ZbyagS4yddUAEN5RHdWBeMNY4IzdgICiBN5vTAX08qPyRa3pMUb9xA
	 oQ7HtudS8lEYyTGlGGFB56p6F8pBK5LiJMGhxjgNHnYW8yhQqRJJ/MxqpBHblzKobh
	 VLw1LsL7xWNHETsVpdV1HHuCkPaE1+h4SKYrf7XzMnyZNQSNz3/O18EKDch6a+6a9L
	 hvNY3CElk2cZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E038CE0886; Mon,  3 Jun 2024 16:45:25 -0700 (PDT)
Date: Mon, 3 Jun 2024 16:45:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Fix access non-existent percpu rtpcp variable
 in rcu_tasks_need_gpcb()
Message-ID: <aa68fcdf-10c8-45bc-bd63-2c38a0b94d16@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240603055229.23601-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603055229.23601-1-qiang.zhang1211@gmail.com>

On Mon, Jun 03, 2024 at 01:52:29PM +0800, Zqiang wrote:
> For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
> defined as NR_CPUS instead of the number of possible cpus, this
> will cause the following system panic:

Nice change, thank you!

There is one issue with it on large systems.  Please see the comments
near the end of this patch.

							Thanx, Paul

> [    0.015349][    T0] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> ...
> [    0.021342][    T0] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:1
> ...
> [    3.681252][   T15] BUG: unable to handle page fault for address: ffffffff9911c8c8
> [    3.689415][   T45] ehci-pci 0000:00:1a.0: debug port 2
> [    3.697008][   T15] #PF: supervisor read access in kernel mode
> [    3.697009][   T15] #PF: error_code(0x0000) - not-present page
> [    3.706233][   T45] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7e3c000
> [    3.708152][   T15] PGD 40fa24067 P4D 40fa24067 PUD 40fa25063 PMD 410bff063
> [    3.720380][   T45] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    3.720430][   T15] PTE 800ffffbefee3062
> [    3.720431][   T15] Oops: 0000 [#1] PREEMPT SMP PTI
> [    3.727873][   T45] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.06
> [    3.734009][   T15] CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W          6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
> [    3.734011][   T15] Hardware name: Dell Inc. OptiPlex 9020/005T15, BIOS A14 09/14/2015
> [    3.734012][   T15] RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
> [    3.737962][   T45] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    3.742877][   T15] RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
> [    3.751891][   T45] usb usb2: Product: EHCI Host Controller
> [    3.764495][   T15]
> [    3.764496][   T15] RAX: ffffffff98929ca0 RBX: ffffffff98b3b328 RCX: 0000000000021880
> [    3.764497][   T15] RDX: ffffffff9911c880 RSI: 0000000000000000 RDI: 0000000000000000
> [    3.772461][   T45] usb usb2: Manufacturer: Linux 6.6.21 ehci_hcd
> [    3.778248][   T15] RBP: 0000000000000202 R08: 0000000000000000 R09: 0000000000000000
> [    3.778249][   T15] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
> [    3.778249][   T15] R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff98b3b320
> [    3.786216][   T45] usb usb2: SerialNumber: 0000:00:1a.0
> [    3.805811][   T15] FS:  0000000000000000(0000) GS:ffff8c781ea00000(0000) knlGS:0000000000000000
> [    3.805813][   T15] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.811993][   T45] hub 2-0:1.0: USB hub found
> [    3.817383][   T15] CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
> [    3.817385][   T15] Call Trace:
> [    3.817386][   T15]  <TASK>
> [    3.817388][   T15]  ? __die+0x23/0x80
> [    3.819643][   T45] hub 2-0:1.0: 2 ports detected
> [    3.827481][   T15]  ? page_fault_oops+0xa4/0x180
> [    3.827485][   T15]  ? exc_page_fault+0x152/0x180
> [    3.922376][   T15]  ? asm_exc_page_fault+0x26/0x40
> [    3.927289][   T15]  ? rcu_tasks_need_gpcb+0x25d/0x2c0
> [    3.932459][   T15]  ? __pfx_rcu_tasks_kthread+0x40/0x40
> [    3.937806][   T15]  rcu_tasks_one_gp+0x69/0x180
> [    3.942451][   T15]  rcu_tasks_kthread+0x94/0xc0
> [    3.947096][   T15]  kthread+0xe8/0x140
> [    3.950956][   T15]  ? __pfx_kthread+0x40/0x40
> [    3.955425][   T15]  ret_from_fork+0x34/0x80
> [    3.959721][   T15]  ? __pfx_kthread+0x40/0x40
> [    3.964192][   T15]  ret_from_fork_asm+0x1b/0x80
> [    3.968841][   T15]  </TASK>
> 
> Consider that there may be holes in the CPU numbers, this commit
> use the maxcpu variable to store the CPU numbers after traversing
> possible cpu, and generate the rcu_task_cpu_ids variable and assign
> it to (maxcpu +1) instead of nr_cpu_ids.
> 
> Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
> Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tasks.h | 54 ++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index e362f72bb65d..8428440e0fa4 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -182,6 +182,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
>  static int rcu_task_lazy_lim __read_mostly = 32;
>  module_param(rcu_task_lazy_lim, int, 0444);
>  
> +static int rcu_task_cpu_ids;
> +
>  /* RCU tasks grace-period state for debugging. */
>  #define RTGS_INIT		 0
>  #define RTGS_WAIT_WAIT_CBS	 1
> @@ -245,6 +247,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	int cpu;
>  	int lim;
>  	int shift;
> +	int maxcpu;
>  
>  	if (rcu_task_enqueue_lim < 0) {
>  		rcu_task_enqueue_lim = 1;
> @@ -254,14 +257,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
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
>  	for_each_possible_cpu(cpu) {
>  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>  
> @@ -277,10 +272,21 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
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
> +	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
> +			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
> +			rcu_task_cb_adjust, rcu_task_cpu_ids);
>  }
>  
>  // Compute wakeup time for lazy callback timer.
> @@ -348,7 +354,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>  			rtpcp->rtp_n_lock_retries = 0;
>  		}
>  		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
> -		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
> +		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
>  			needadjust = true;  // Defer adjustment to avoid deadlock.
>  	}
>  	// Queuing callbacks before initialization not yet supported.
> @@ -368,10 +374,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
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
> @@ -481,7 +487,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
>  	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
>  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>  		if (rtp->percpu_enqueue_lim > 1) {
> -			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
> +			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
>  			smp_store_release(&rtp->percpu_enqueue_lim, 1);
>  			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
>  			gpdone = false;
> @@ -496,7 +502,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
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
> @@ -520,21 +528,15 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	struct rcu_tasks_percpu *rtpcp_next;
>  
> -	cpu = rtpcp->cpu;
> -	cpunext = cpu * 2 + 1;
> -	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {

The purpose here is to parallelize the callback invocation, which looks to
me to be lost given the change below.  This parallelization is important
given that the Linux kernel runs on systems with thousands of CPUs.
Admittedly not often, but we nevertheless do need to make Linux run well
on such systems.

But you are right that the parallelization assumed that per-CPU data
existed for all CPUs from zero to the maximum-numbered CPU.  Perhaps a
good fix would be to make cblist_init_generic() construct a dense array
containing the numbers of the possible CPUs, then index into that array
to fan out the parallization.

> +	cpu = rtpcp->cpu + 1;
> +	if (cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> +		cpunext = cpumask_next(cpu - 1, cpu_possible_mask);
>  		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
>  		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
>  		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> -		cpunext++;
> -		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> -			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> -			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> -			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
> -		}
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
