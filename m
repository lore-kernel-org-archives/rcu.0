Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69F23770D;
	Wed,  9 Jul 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065342; cv=none; b=gX2OFcgWBYHw5gJYwWc3Oo4DBlnmmoSgAJvJ5YZurlLgzdWteLe9MJK5BPCer7Rp0YShypohEeW1cQvY1zJhWBmqGnFxyEQclse7qK5Q3rhIY72Wz/obiAksD1PpjPey7xI3JT23t3385mebSYKFct77RlrgOfWEeSpMgpQRSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065342; c=relaxed/simple;
	bh=kW9fpJeu4MuVl5tgvQBS2+J5VX7tdkjdMXBdal5v4w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcgejNbI5VBRNvgowpf7j4ZEAsqyhTfUix1Eu37aCV4tJz02Y8vAeZ+8LIczV7gQRgxzzLsYqO+wkRjGFF+CF5aO0FxSdMoQvo1upzQu/tv3zKNp0jqQeASKEdoZ0vQdllxuwJW5wnPAF9pOcvEmaX5eEcyO01AoC8zBHmWZt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJcl03i5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJcl03i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44532C4CEEF;
	Wed,  9 Jul 2025 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752065342;
	bh=kW9fpJeu4MuVl5tgvQBS2+J5VX7tdkjdMXBdal5v4w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJcl03i5hnMpETP7FsxKeXgGxG6SHJkncfnTuE+XrlN1cIbkgzM86fLVn7ieBVxEW
	 akc5WGA4bCqPOTJ+YczAeq3/sMx6PuQBfgF5tCwdIRvoQ1hIpHxX+9lXx9OniStHBv
	 EJCUSJfANt3hzi79HlNOx3F8vUedC/YmCBxmsk1xry7wCkTk4hx1+O9YIcHTbMf9+7
	 FFv4NeGV2plGn8c+uMxzEqvNgYUt7EJP2K3mogLvwB7PVneHVWYw7DSd55+09i0/Oe
	 NJG7qc33gzC1jG4wSd2TmuE+rPMZuHZey5wq+fmsII6JGMT9dt+Vn/8wcK6O0XIcer
	 Yomo/8qyve9Aw==
Date: Wed, 9 Jul 2025 14:48:59 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	joelagnelf@nvidia.com, boqun.feng@gmail.com, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com, neeraj.upadhyay@amd.com,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>
Subject: Re: [PATCH rcu 5/5] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
Message-ID: <aG5lOzY7s4GKjCOT@localhost.localdomain>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
 <20250709104118.15532-6-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709104118.15532-6-neeraj.upadhyay@kernel.org>

Le Wed, Jul 09, 2025 at 04:11:18PM +0530, neeraj.upadhyay@kernel.org a écrit :
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> During rcu_read_unlock_special(), if this happens during irq_exit(), we
> can lockup if an IPI is issued. This is because the IPI itself triggers
> the irq_exit() path causing a recursive lock up.
> 
> This is precisely what Xiongfeng found when invoking a BPF program on
> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> managing the irq_work state correctly.
> 
> irq_exit()
>   __irq_exit_rcu()
>     /* in_hardirq() returns false after this */
>     preempt_count_sub(HARDIRQ_OFFSET)
>     tick_irq_exit()
>       tick_nohz_irq_exit()
> 	    tick_nohz_stop_sched_tick()
> 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> 		   __bpf_trace_tick_stop()
> 		      bpf_trace_run2()
> 			    rcu_read_unlock_special()
>                               /* will send a IPI to itself */
> 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> 
> A simple reproducer can also be obtained by doing the following in
> tick_irq_exit(). It will hang on boot without the patch:
> 
>   static inline void tick_irq_exit(void)
>   {
>  +	rcu_read_lock();
>  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>  +	rcu_read_unlock();
>  +
> 
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> Tested-by: Qi Xi <xiqi2@huawei.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
> ---
>  kernel/rcu/tree.h        | 11 ++++++++++-
>  kernel/rcu/tree_plugin.h | 23 +++++++++++++++++++----
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 3830c19cf2f6..f8f612269e6e 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>  	unsigned long   jiffies;	/* Track jiffies value */
>  };
>  
> +/*
> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
> + * It can be in one of the following states:
> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.

Never as in "never ever" ? :-)

I'm not a native speaker, so you guys tell me, but isn't it less
ambiguous:

- DEFER_QS_IDLE: The IRQ work isn't pending
- DEFER_QS_PENDING: The IRQ work is pending but hasn't run yet

But then the name are already self-explanatory. And then keeping
it as a boolean should be enough too. Why do we need these two
states?

> + */
> +#define DEFER_QS_IDLE		0
> +#define DEFER_QS_PENDING	1
> +
>  /* Per-CPU data for read-copy update. */
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
> @@ -192,7 +201,7 @@ struct rcu_data {
>  					/*  during and after the last grace */
>  					/* period it is aware of. */
>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
> +	int defer_qs_iw_pending;	/* Scheduler attention pending? */
>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>  
>  	/* 2) batch handling */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index a91b2322a0cd..aec584812574 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	struct rcu_node *rnp;
>  	union rcu_special special;
>  
> +	rdp = this_cpu_ptr(&rcu_data);
> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> +
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
>  	 * report the fact that it has exited.  Because irqs are disabled,
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> -	rdp = this_cpu_ptr(&rcu_data);
>  	if (!special.s && !rdp->cpu_no_qs.b.exp) {
>  		local_irq_restore(flags);
>  		return;
> @@ -629,7 +632,18 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  
>  	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>  	local_irq_save(flags);
> -	rdp->defer_qs_iw_pending = false;
> +
> +	/*
> +	 * Requeue the IRQ work on next unlock in following situation:

s/in/to avoid/

> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> +	 * 2. CPU enters new rcu_read_lock()
> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> +	 * 5. Deferred QS reporting does not happen.
> +	 */
> +	if (rcu_preempt_depth() > 0)
> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);

Why WRITE_ONCE() ? Also this lacks the explanation telling why it's not
unconditionally setting back to DEFER_QS_IDLE (ie: just a few words about that
irq_work() recursion thing), because I'm sure my short memory will suggest to
make it unconditional for simplification within two years (being optimistic) :-)

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
