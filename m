Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DE293C4C;
	Sun,  6 Jul 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821696; cv=none; b=jwmpKCfExC4aRgXEcAzeihqPVHWCVyw3HLfDx84nXtXqkF/fhHRm9Ixqhu2X/tGfexRCIEJkmi3pBm5ucqM06bFrh5EmMOSq3eaj3hBLl3CpR2OrfMx/WZW1AohnGZBzvfkRSlYFw+IWWwajNhGOd0MAf9mnllu0aGf1+UI9TI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821696; c=relaxed/simple;
	bh=DtkbOqAcIMRVDjPLUKIiiom0YBSaUUIPwrAuQkbAl78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhWXCSjSgGqZQUVWJ+BF9GO2foJjk95/Ng5eKWxcUXXRyllzTlfHWBe/xnm9yFT17VUy8bcBMr/Jiq77QjidvBuPoJ2XMGDKRtYQcsMfqN9yU+Z0Fszb9uR0B8fzHuv7VUrxjJ/upqA3AzMvIElkKZ+v08BZhXxP5vz/JaYtlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTHMxSKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTHMxSKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F2EC4CEED;
	Sun,  6 Jul 2025 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751821696;
	bh=DtkbOqAcIMRVDjPLUKIiiom0YBSaUUIPwrAuQkbAl78=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uTHMxSKceEf2w2K9QxxiCmu0CHvC3BJRGaIX4tj5aX/DPm2Q7GfbL4ZZZyMglnZu8
	 HEjd0DWAKa5l8fVckXA3wzZH+IY/Z1ZJqNgCmOdtk7mO06KAafzeMntO9wCj2boRRp
	 TsCHZWbV8h1UMmZlv+bA1bRjwQX43gJPmJLzNwUrDoH4fnSKVlUV5c9qXdy+xU+T74
	 ZFd/EDy5cRooV7BPNDtbZ6jeXPTIUyvywh4Q6mrySIUKLJgSK9qHrv/42qDlLTjcLq
	 NJX+BgAFL/rDdtTX0UC+7CujLb9tK8QTlgC+EsQBBC93Vnwhth1aHTBzob2ArNjdmB
	 L8gLc9vH3Em3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA208CE09E9; Sun,  6 Jul 2025 10:08:15 -0700 (PDT)
Date: Sun, 6 Jul 2025 10:08:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] rcu: Fix rcu_read_unlock() deadloop due to IRQ
 work
Message-ID: <960035c6-c5f3-4c31-bd0f-f57d79b040f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705203918.4149863-1-joelagnelf@nvidia.com>

On Sat, Jul 05, 2025 at 04:39:15PM -0400, Joel Fernandes wrote:
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Definitely headed in the right direction, though it does need just a
little bit more detail in the commit log.  ;-)

Also a few comments and questions interspersed below.

							Thanx, Paul

> ---
>  kernel/rcu/tree.h        | 11 ++++++++++-
>  kernel/rcu/tree_plugin.h | 29 ++++++++++++++++++++++-------
>  2 files changed, 32 insertions(+), 8 deletions(-)
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
> + */
> +#define DEFER_QS_IDLE		0
> +#define DEFER_QS_PENDING	1

Having names for the states is good!

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
> index dd1c156c1759..baf57745b42f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	struct rcu_node *rnp;
>  	union rcu_special special;
>  
> +	rdp = this_cpu_ptr(&rcu_data);
> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;

Good, this is where the request actually gets serviced.

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
> @@ -623,12 +626,24 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>   */
>  static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  {
> -	unsigned long flags;
> -	struct rcu_data *rdp;
> +	volatile unsigned long flags;

I don't understand why this wants to be volatile.

Unless maybe you want to make sure that gdb can see it, in
which case, is there an existing Kconfig option for that?  Maybe
CONFIG_DEBUG_INFO_NONE=n?

> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> -	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>  	local_irq_save(flags);
> -	rdp->defer_qs_iw_pending = false;
> +
> +	/*
> +	 * Requeue the IRQ work on next unlock in following situation:
> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> +	 * 2. CPU enters new rcu_read_lock()
> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> +	 * 5. Deferred QS reporting does not happen.
> +	 */
> +	if (rcu_preempt_depth() > 0) {
> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);

Shouldn't we have just this WRITE_ONCE() in this then-clause?

> +		local_irq_restore(flags);
> +		return;
> +	}
>  	local_irq_restore(flags);
>  }
>  
> @@ -675,7 +690,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> @@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  				else
>  					init_irq_work(&rdp->defer_qs_iw,
>  						      rcu_preempt_deferred_qs_handler);
> -				rdp->defer_qs_iw_pending = true;
> +				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>  		}
> -- 
> 2.43.0
> 
