Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661DA935;
	Wed,  9 Jul 2025 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019609; cv=none; b=T+hgqzLmdXDFPAzUoXC5/2AcpSEqwMqu7E7GinY34BkV6yTkR4HabssU07/pzm3yagnNTtz6bGIVOuQbO2yUBIlS5bIpuUQwckwZaF+ukW0H7hIPsYcOO4TL/60B+GKnmXdzH3z19fqFsOUti04azghNOnI+ATwvPLIwroDku7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019609; c=relaxed/simple;
	bh=9rNRsvhb8ONPeHvn0FHJiNgz9RSnsvZiLhAZJKaONjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha5H4rkPPJY+StgpGQDKAwWWTZwDTX+k+teNgwWf+pDXnUt1Z5pekNTeXnoeT61oW1Zt6RYG7Dvd6lkJ65Fp1pkG6Ip+WmK0vRnjvbusRAooF0DGSNiX/epw/AmeABdpoZ8ZzMpaQqQ3AHblp8p2iHG/gTFdmOo+Ikdrj8ZO5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMOOOXKS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMOOOXKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F32C4CEED;
	Wed,  9 Jul 2025 00:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752019608;
	bh=9rNRsvhb8ONPeHvn0FHJiNgz9RSnsvZiLhAZJKaONjk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mMOOOXKSxMefVaPQRHc8qGIeW5dHMnOPMeUUGdq1aNQQl4xcr8FYKCLf1gefN03kO
	 UJMmim2j+m0xG2IZbyarfL4y5MGdZL3cZMkKVdh+DrNgb5bI1E4ceQ+FP2fgzcM0RR
	 7DpP3dU4s8qxgR7W6sFUNhQUhZcvlOTgH/dlNpB2CJ0aDmupOl882pIjzArSIlnxPU
	 HgXLjIlzb3ISqzMg8VPJTCbD3oPSXHPvuPQ2sj6/QLi+/+CvUVQmN1ZbDoqbZw5w07
	 3ema9QRsp/Vv9X9FnEVWSd0uAAm5WfGKTJDpWVq+hL/yafA+KCk44hcMhgJoawshv3
	 J9YTVeNgnMHUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1E67FCE08A1; Tue,  8 Jul 2025 17:06:48 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:06:48 -0700
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
	Zqiang <qiang.zhang@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH -rcu -next 3/7] rcu: Refactor expedited handling check in
 rcu_read_unlock_special()
Message-ID: <202666b7-801c-44c7-9402-8c357abb8e5d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708142224.3940851-3-joelagnelf@nvidia.com>

On Tue, Jul 08, 2025 at 10:22:20AM -0400, Joel Fernandes wrote:
> Extract the complex expedited handling condition in rcu_read_unlock_special()
> into a separate function rcu_unlock_needs_exp_handling() with detailed
> comments explaining each condition.
> 
> This improves code readability. No functional change intended.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_plugin.h | 83 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index fa7b0d854833..e20c17163c13 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -646,6 +646,75 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  	local_irq_restore(flags);
>  }
>  
> +/*
> + * Check if expedited grace period processing during unlock is needed.
> + *
> + * This function determines whether expedited handling is required based on:
> + * 1. Task blocking an expedited grace period (based on a heuristic, could be
> + *    false-positive, see below.)
> + * 2. CPU participating in an expedited grace period
> + * 3. Strict grace period mode requiring expedited handling
> + * 4. RCU priority deboosting needs when interrupts were disabled
> + *
> + * @t: The task being checked
> + * @rdp: The per-CPU RCU data
> + * @rnp: The RCU node for this CPU
> + * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
> + *
> + * Returns true if expedited processing of the rcu_read_unlock() is needed.
> + */
> +static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
> +				      struct rcu_data *rdp,
> +				      struct rcu_node *rnp,
> +				      bool irqs_were_disabled)
> +{
> +	/*
> +	 * Check if this task is blocking an expedited grace period. If the
> +	 * task was preempted within an RCU read-side critical section and is
> +	 * on the expedited grace period blockers list (exp_tasks), we need
> +	 * expedited handling to unblock the expedited GP. This is not an exact
> +	 * check because 't' might not be on the exp_tasks list at all - its
> +	 * just a fast heuristic that can be false-positive sometimes.
> +	 */
> +	if (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks))
> +		return true;
> +
> +	/*
> +	 * Check if this CPU is participating in an expedited grace period.
> +	 * The expmask bitmap tracks which CPUs need to check in for the
> +	 * current expedited GP. If our CPU's bit is set, we need expedited
> +	 * handling to help complete the expedited GP.
> +	 */
> +	if (rdp->grpmask & READ_ONCE(rnp->expmask))
> +		return true;
> +
> +	/*
> +	 * In CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, all grace periods
> +	 * are treated as short for testing purposes even if that means
> +	 * disturbing the system more. Check if either:
> +	 * - This CPU has not yet reported a quiescent state, or
> +	 * - This task was preempted within an RCU critical section
> +	 * In either case, require expedited handling for strict GP mode.
> +	 */
> +	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> +	    ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node))
> +		return true;
> +
> +	/*
> +	 * RCU priority boosting case: If a task is subject to RCU priority
> +	 * boosting and exits an RCU read-side critical section with interrupts
> +	 * disabled, we need expedited handling to ensure timely deboosting.
> +	 * Without this, a low-priority task could incorrectly run at high
> +	 * real-time priority for an extended period degrading real-time
> +	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
> +	 * not just to PREEMPT_RT.
> +	 */
> +	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * Handle special cases during rcu_read_unlock(), such as needing to
>   * notify RCU core processing or task having blocked during the RCU
> @@ -665,18 +734,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  	local_irq_save(flags);
>  	irqs_were_disabled = irqs_disabled_flags(flags);
>  	if (preempt_bh_were_disabled || irqs_were_disabled) {
> -		bool expboost; // Expedited GP in flight or possible boosting.
> +		bool needs_exp; // Expedited handling needed.
>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  		struct rcu_node *rnp = rdp->mynode;
>  
> -		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
> -			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
> -			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> -			   ((rdp->grpmask & READ_ONCE(rnp->qsmask)) || t->rcu_blocked_node)) ||
> -			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
> -			    t->rcu_blocked_node);
> +		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
> +	
>  		// Need to defer quiescent state until everything is enabled.
> -		if (use_softirq && (in_hardirq() || (expboost && !irqs_were_disabled))) {
> +		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
>  			// Using softirq, safe to awaken, and either the
>  			// wakeup is free or there is either an expedited
>  			// GP in flight or a potential need to deboost.
> @@ -689,7 +754,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
> +			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
>  			    cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -- 
> 2.34.1
> 
