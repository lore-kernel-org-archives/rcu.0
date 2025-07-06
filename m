Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1451B4231;
	Sun,  6 Jul 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751822292; cv=none; b=FYAJ0r8gPufvltciRdQvUu8uHj8qbxjRLdxJuDT7MKY6I4NGlJGs4jnGXYoRjTuEstAMnBw1vd+zu4tUkxBdZdRJUwO2F9ar3A0ZAOfubhaCaFAf1usol9By4o1sWPgTJ3javjvmPBmKqhRwYhjXqviWZ6TjZNqY04KhbnE1okY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751822292; c=relaxed/simple;
	bh=1HwVVHxxxISmQTQVPhbtfc0NLL6jhJqkabzJ9Zx/MXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ij09g3VW87t8rpw+JrGxxf82ROtfzETuwM3tyKQGmzTGn6m37wug/kUddrpVieGtNoLrUzzrKvOiGdIrtzhRDJg6wiKgFG0p2Q0O/UWtBl12n/tSV5cs6EnD9pTlteECARtFmMNv3vwaTp9NbxneHO0tOpM5pehQc6ATO1GRopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6zZC+cX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6zZC+cX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE571C4CEED;
	Sun,  6 Jul 2025 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751822292;
	bh=1HwVVHxxxISmQTQVPhbtfc0NLL6jhJqkabzJ9Zx/MXc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=h6zZC+cXzgOaO5+IwP3AoTQ/wfAVpkWM5NT12r97TvTSbmJBt+Ynu2/eWQLiEjzrI
	 jv83F50/pu/8OLaBniXWZkGZI64hS3OqJjcTkIwbdndHqTN+avWsVA3KuP2UL0cmnL
	 H9Riby+dsJCHfgxpA4CHq7xy1YZRZXTyaV/gcf5pN+eC8s/gncuhgbP3Y6vdDkLMsf
	 6Btcu5mpCy2emxwAxurdwHXMG9Lr+evx2snFpcnpSOsqp4zv1R/4tP8rPUKlkk116n
	 zl0LaOsJZEQjTqJyWMWCqNOtIVkfhXDd+5PrhkH6/2UTbhKnoZKvtdyuWIJfbmbave
	 nuUBaMQgCDALg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96106CE09E9; Sun,  6 Jul 2025 10:18:11 -0700 (PDT)
Date: Sun, 6 Jul 2025 10:18:11 -0700
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
Subject: Re: [PATCH RFC 2/3] rcu: Refactor expedited handling check in
 rcu_read_unlock_special()
Message-ID: <941d82f3-1c09-4db2-ae22-a80d04227673@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250705203918.4149863-1-joelagnelf@nvidia.com>
 <20250705203918.4149863-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705203918.4149863-2-joelagnelf@nvidia.com>

On Sat, Jul 05, 2025 at 04:39:16PM -0400, Joel Fernandes wrote:
> Extract the complex expedited handling condition in rcu_read_unlock_special()
> into a separate function rcu_unlock_needs_exp_handling() with detailed
> comments explaining each condition.
> 
> This improves code readability. No functional change intended.

Very nice!!!

Some questions and comments interspersed below.

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 80 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index baf57745b42f..8504d95bb35b 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -647,6 +647,72 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  	local_irq_restore(flags);
>  }
>  
> +/*
> + * Check if expedited grace period processing during unlock is needed.
> + *
> + * This function determines whether expedited handling is required based on:
> + * 1. Task blocking an expedited grace period

This is a heuristic.  What we are actually checking is whether the task
is blocking *some* grace period and whether at least one task (maybe
this one, maybe not) is blocking an expedited grace period.

Why not an exact check?  Because that would mean traversing the list
starting at ->exp_tasks, and that list could potentially contain every
task in the system.  And I have received bug reports encountered on
systems with hundreds of thousands of tasks.

I could imagine a more complex data structure that semi-efficiently
tracked exact information, but I could also imagine this not being worth
the effort.

> + * 2. CPU participating in an expedited grace period
> + * 3. Strict grace period mode requiring expedited handling
> + * 4. RCU priority boosting needs when interrupts were disabled

s/boosting/deboosting/

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
> +	 * Check if this task is blocking an expedited grace period.
> +	 * If the task was preempted within an RCU read-side critical section
> +	 * and is on the expedited grace period blockers list (exp_tasks),
> +	 * we need expedited handling to unblock the expedited GP.

Please see above for the heuristic nature of this check.

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
> +	 * In either case, requird expedited handling for strict GP mode.

s/requird/required/  ;-)

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
> +	 * real-time priority for an extended period effecting real-time

s/effecting/degrading/ to be more precise.

> +	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
> +	 * not just PREEMPT_RT.
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
> @@ -666,18 +732,14 @@ static void rcu_read_unlock_special(struct task_struct *t)
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
> @@ -690,7 +752,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
> +			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> -- 
> 2.43.0
> 
