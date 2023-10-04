Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C0E7C4E3
	for <rcu@archiver.kernel.org>; Wed,  4 Oct 2023 16:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbjJDQ5n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Oct 2023 12:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJDQ5m (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Oct 2023 12:57:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204E95;
        Wed,  4 Oct 2023 09:57:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D6BC433C7;
        Wed,  4 Oct 2023 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696438659;
        bh=oSZDjvqYhDHr1ipQjmGHoEablNA8bA4SA3srh9BeWao=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vlg4ukKHeFrorl1scPAtQX7kMo3D1kQenxM3SX5wDvnT9sGBOoUl/CjU7XrL1mc7j
         8LGFhN41LIeVKDVcMNR82YYk82OSi2x1iobevO/suKpJfjRBhDcWan0qQZt/I50GHL
         kDnmRd4eESqlMr9l4EAnNNxTbfLlZGEPjn90kecnGnC7y3yERvokIssgS6EA9ifVXy
         W2MzMJM0ijB5TGpQwEUbde+x/ptlaw9c52K4j2iwguQ91wJ2YIwpnvF+6QKsg1EssJ
         P4l5y69Wa3T5ugdj6io9y39RhKaOFI6SALDAP89hDAhQj3WhLQ4C812r3MDzLwwfqs
         uyrPccPLI7ySQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 845F7CE0B71; Wed,  4 Oct 2023 09:57:38 -0700 (PDT)
Date:   Wed, 4 Oct 2023 09:57:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 07/10] rcu: Conditionally build CPU-hotplug teardown
 callbacks
Message-ID: <85b0010f-8166-4439-b038-22b634a3b8cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-8-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-8-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 08, 2023 at 10:36:00PM +0200, Frederic Weisbecker wrote:
> Among the three CPU-hotplug teardown RCU callbacks, two of them early
> exit if CONFIG_HOTPLUG_CPU=n, and one is left unchanged. In any case
> all of them have an implementation when CONFIG_HOTPLUG_CPU=n.
> 
> Align instead with the common way to deal with CPU-hotplug teardown
> callbacks and provide a proper stub when they are not supported.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Good eyes!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcutree.h |  11 +++-
>  kernel/rcu/tree.c       | 114 +++++++++++++++++++---------------------
>  2 files changed, 63 insertions(+), 62 deletions(-)
> 
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index af6ddbd291eb..7d75066c72aa 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -109,9 +109,16 @@ void rcu_all_qs(void);
>  /* RCUtree hotplug events */
>  int rcutree_prepare_cpu(unsigned int cpu);
>  int rcutree_online_cpu(unsigned int cpu);
> -int rcutree_offline_cpu(unsigned int cpu);
> +void rcu_cpu_starting(unsigned int cpu);
> +
> +#ifdef CONFIG_HOTPLUG_CPU
>  int rcutree_dead_cpu(unsigned int cpu);
>  int rcutree_dying_cpu(unsigned int cpu);
> -void rcu_cpu_starting(unsigned int cpu);
> +int rcutree_offline_cpu(unsigned int cpu);
> +#else
> +#define rcutree_dead_cpu NULL
> +#define rcutree_dying_cpu NULL
> +#define rcutree_offline_cpu NULL
> +#endif
>  
>  #endif /* __LINUX_RCUTREE_H */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 289c51417cbc..875f241db508 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4228,25 +4228,6 @@ static bool rcu_init_invoked(void)
>  	return !!rcu_state.n_online_cpus;
>  }
>  
> -/*
> - * Near the end of the offline process.  Trace the fact that this CPU
> - * is going offline.
> - */
> -int rcutree_dying_cpu(unsigned int cpu)
> -{
> -	bool blkd;
> -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> -	struct rcu_node *rnp = rdp->mynode;
> -
> -	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> -		return 0;
> -
> -	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
> -	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> -			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
> -	return 0;
> -}
> -
>  /*
>   * All CPUs for the specified rcu_node structure have gone offline,
>   * and all tasks that were preempted within an RCU read-side critical
> @@ -4292,23 +4273,6 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
>  	}
>  }
>  
> -/*
> - * The CPU has been completely removed, and some other CPU is reporting
> - * this fact from process context.  Do the remainder of the cleanup.
> - * There can only be one CPU hotplug operation at a time, so no need for
> - * explicit locking.
> - */
> -int rcutree_dead_cpu(unsigned int cpu)
> -{
> -	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> -		return 0;
> -
> -	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> -	// Stop-machine done, so allow nohz_full to disable tick.
> -	tick_dep_clear(TICK_DEP_BIT_RCU);
> -	return 0;
> -}
> -
>  /*
>   * Propagate ->qsinitmask bits up the rcu_node tree to account for the
>   * first CPU in a given leaf rcu_node structure coming online.  The caller
> @@ -4461,29 +4425,6 @@ int rcutree_online_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -/*
> - * Near the beginning of the process.  The CPU is still very much alive
> - * with pretty much all services enabled.
> - */
> -int rcutree_offline_cpu(unsigned int cpu)
> -{
> -	unsigned long flags;
> -	struct rcu_data *rdp;
> -	struct rcu_node *rnp;
> -
> -	rdp = per_cpu_ptr(&rcu_data, cpu);
> -	rnp = rdp->mynode;
> -	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -	rnp->ffmask &= ~rdp->grpmask;
> -	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> -
> -	rcutree_affinity_setting(cpu, cpu);
> -
> -	// nohz_full CPUs need the tick for stop-machine to work quickly
> -	tick_dep_set(TICK_DEP_BIT_RCU);
> -	return 0;
> -}
> -
>  /*
>   * Mark the specified CPU as being online so that subsequent grace periods
>   * (both expedited and normal) will wait on it.  Note that this means that
> @@ -4637,7 +4578,60 @@ void rcutree_migrate_callbacks(int cpu)
>  		  cpu, rcu_segcblist_n_cbs(&rdp->cblist),
>  		  rcu_segcblist_first_cb(&rdp->cblist));
>  }
> -#endif
> +
> +/*
> + * The CPU has been completely removed, and some other CPU is reporting
> + * this fact from process context.  Do the remainder of the cleanup.
> + * There can only be one CPU hotplug operation at a time, so no need for
> + * explicit locking.
> + */
> +int rcutree_dead_cpu(unsigned int cpu)
> +{
> +	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> +	// Stop-machine done, so allow nohz_full to disable tick.
> +	tick_dep_clear(TICK_DEP_BIT_RCU);
> +	return 0;
> +}
> +
> +/*
> + * Near the end of the offline process.  Trace the fact that this CPU
> + * is going offline.
> + */
> +int rcutree_dying_cpu(unsigned int cpu)
> +{
> +	bool blkd;
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +	struct rcu_node *rnp = rdp->mynode;
> +
> +	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
> +	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> +			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
> +	return 0;
> +}
> +
> +/*
> + * Near the beginning of the process.  The CPU is still very much alive
> + * with pretty much all services enabled.
> + */
> +int rcutree_offline_cpu(unsigned int cpu)
> +{
> +	unsigned long flags;
> +	struct rcu_data *rdp;
> +	struct rcu_node *rnp;
> +
> +	rdp = per_cpu_ptr(&rcu_data, cpu);
> +	rnp = rdp->mynode;
> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	rnp->ffmask &= ~rdp->grpmask;
> +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +
> +	rcutree_affinity_setting(cpu, cpu);
> +
> +	// nohz_full CPUs need the tick for stop-machine to work quickly
> +	tick_dep_set(TICK_DEP_BIT_RCU);
> +	return 0;
> +}
> +#endif /* #ifdef CONFIG_HOTPLUG_CPU */
>  
>  /*
>   * On non-huge systems, use expedited RCU grace periods to make suspend
> -- 
> 2.41.0
> 
