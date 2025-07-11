Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C1307AF9;
	Fri, 11 Jul 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192008; cv=none; b=Mhpk+qLzf0QR6aDPF9Tc2/SDq5OMaPsOWfhsojINjALWqaxwZzAAje/v0Gg1v9fp9mQ4sZp6mL7VlPme2ikLgh78KGTRckir+bV+4zofX+DcSnJcm9jsYfvkOcYVENXWr6JrtKMtk8zKzKY+R2jvo1LUBAyoAVIobgmTwA+lyPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192008; c=relaxed/simple;
	bh=XaFdDQC2V9S/MAm02wtGXhVWBtimJWvL/pi5KsGnuwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzbiNRY/h0nzNIqnBnrVmbKrR1I1eswUu8zVl+R0K+LpB+j9JeRZ9laKmEZulwBrr8pbMjcpZYya053TncPF17lD4QjKYpuw8yPk8OnAXQIncwuNMHRz7Zm8WBqFkax6iubzHOgQl4k3oro95RxwoZupMjku17HkQ9FAyQmrpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj0feOKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj0feOKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99134C4CEE3;
	Fri, 11 Jul 2025 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752192007;
	bh=XaFdDQC2V9S/MAm02wtGXhVWBtimJWvL/pi5KsGnuwc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yj0feOKZuSwjKUTtagTtzTQu+t5KZdzmkQ6qoNDNx935bGsqUZt++Lp9vVbtQG7Bj
	 mWXmsFvrWeDxxnNYxoofwOYYarbUOlnmtUDDmA3IFHvvcXYRXfOCXmxsIWx5dD+GTm
	 Qz72hjIW+1ysWlzoqhDR2MTLdZaTizawMSyAbJ2jBgEaCEPPEGL6oH7Qnjk9Q2/Vry
	 c6jKIWvBh1WsMLbKqWlPe4N/ZckmmrOc5kW9PYyv7ew+nzlTGbPU9GKuYo6KmTTMWY
	 xe0MFIGK7SsyUQrYJ4asH87CRt25b0aKCaFrZhxPdgzwRonOQo+bwKTVIECh2mkmMG
	 U/2tfUYfk2jDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3902ACE0A44; Thu, 10 Jul 2025 17:00:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:00:06 -0700
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
Subject: Re: [PATCH -rcu -next 4/7] rcu: Remove redundant check for irq state
 during unlock
Message-ID: <9b67bbca-dfdc-470e-9a32-486300efa586@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708142224.3940851-4-joelagnelf@nvidia.com>

On Tue, Jul 08, 2025 at 10:22:21AM -0400, Joel Fernandes wrote:
> The check for irqs_were_disabled is redundant in
> rcu_unlock_needs_exp_handling() as the caller already checks for this.
> This includes the boost case as well. Just remove the redundant check.

But in the very last "if" statement in the context of the last hunk of
this patch, isn't it instead checking for !irqs_were_disabled?

Or is there something that I am missing that makes this work out OK?

							Thanx, Paul

> This is a first win for the refactor of the needs_exp (formerly
> expboost) condition into a new rcu_unlock_needs_exp_handling() function,
> as the conditions became more easier to read.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index e20c17163c13..7d03d81e45f6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -659,14 +659,12 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>   * @t: The task being checked
>   * @rdp: The per-CPU RCU data
>   * @rnp: The RCU node for this CPU
> - * @irqs_were_disabled: Whether interrupts were disabled before rcu_read_unlock()
>   *
>   * Returns true if expedited processing of the rcu_read_unlock() is needed.
>   */
>  static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>  				      struct rcu_data *rdp,
> -				      struct rcu_node *rnp,
> -				      bool irqs_were_disabled)
> +				      struct rcu_node *rnp)
>  {
>  	/*
>  	 * Check if this task is blocking an expedited grace period. If the
> @@ -702,14 +700,14 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>  
>  	/*
>  	 * RCU priority boosting case: If a task is subject to RCU priority
> -	 * boosting and exits an RCU read-side critical section with interrupts
> -	 * disabled, we need expedited handling to ensure timely deboosting.
> -	 * Without this, a low-priority task could incorrectly run at high
> -	 * real-time priority for an extended period degrading real-time
> +	 * boosting and exits an RCU read-side critical section, we need
> +	 * expedited handling to ensure timely deboosting. Without this,
> +	 * a low-priority task could incorrectly run at high real-time
> +	 * priority for an extended period degrading real-time
>  	 * responsiveness. This applies to all CONFIG_RCU_BOOST=y kernels,
>  	 * not just to PREEMPT_RT.
>  	 */
> -	if (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled && t->rcu_blocked_node)
> +	if (IS_ENABLED(CONFIG_RCU_BOOST) && t->rcu_blocked_node)
>  		return true;
>  
>  	return false;
> @@ -738,7 +736,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  		struct rcu_node *rnp = rdp->mynode;
>  
> -		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp, irqs_were_disabled);
> +		needs_exp = rcu_unlock_needs_exp_handling(t, rdp, rnp);
>  	
>  		// Need to defer quiescent state until everything is enabled.
>  		if (use_softirq && (in_hardirq() || (needs_exp && !irqs_were_disabled))) {
> -- 
> 2.34.1
> 
