Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B3143C4C;
	Tue, 10 Sep 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982977; cv=none; b=llMfEudBRbI/fAMjgB7h1aPxxqoH9MiNsc19uHt5AoSmaAIMCHFP8w6szwcNaI1P4Ft9V1qg52O0457l5RVLiFYaJHYdCOaXfbNQp0FYPseXnEtwG/cS7meTlnyVaZVNkxARqu9NkGyzqAuTP9B8UFPyA8Acte0MFIkGuiXcH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982977; c=relaxed/simple;
	bh=F2jD/aq4O+fKOQIFiKw6rTaEHPdF59QOy1JHPUqettI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chozIKRmY2ZK85vtKLPj/XCQ8CDAjABzRW72xIDo7bKjsYR3DX/wYpviieuvzhzFQoNNyVHiOtQw4SCaJhgfa2NkZwyYKVqwq41EVp4cXfLbk1UCrkExyCyq/xnExsx+dotGm91sTbuI4W32qynIaR1E2HX26LJF3l7i5Mwcl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0S8baMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0S8baMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A672C4CEC3;
	Tue, 10 Sep 2024 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982976;
	bh=F2jD/aq4O+fKOQIFiKw6rTaEHPdF59QOy1JHPUqettI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F0S8baMJdYwz3aCr0jm3BZ3N4gv9Ma394t9al21f7PIPpZSCfYWnB8IHkBn7oa9f1
	 WCsZR3vb/rBb8maesPf17L+SDWV7Yz5gJ7i3St1XgmvUdJJBd3HJrj/SCuNNfTQlkr
	 8csRopfm6SGE+HXvrefs1eqORbRFAvTXZVNNtTsgdL0UuLGeFg5s1Dd7AK1GDiQaC4
	 s92C2pjBCGjq3PI7VyKR5sFbVDnAsQh4URUnI8gj3NTpvpEleSCYPBgu/n4LN9wPal
	 i2tqTZmQAttbY+CrHrgZlyo87lUL9NXdjSRKSw42Zu4vMjf4vtiJtC9Z9z5ZOUORf4
	 cl+3Dm8ZN4CVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D6BBCE13D4; Tue, 10 Sep 2024 08:42:54 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:42:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <34ec01ee-a015-45bb-90ce-2c2af4ac9dbf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240820155935.1167988-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820155935.1167988-1-urezki@gmail.com>

On Tue, Aug 20, 2024 at 05:59:35PM +0200, Uladzislau Rezki (Sony) wrote:
> Add a kvfree_rcu_barrier() function. It waits until all
> in-flight pointers are freed over RCU machinery. It does
> not wait any GP completion and it is within its right to
> return immediately if there are no outstanding pointers.
> 
> This function is useful when there is a need to guarantee
> that a memory is fully freed before destroying memory caches.
> For example, during unloading a kernel module.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

As a follow-on patch, once kvfree_rcu_barrier() is accepted into
mainline, should we add a call to kvfree_rcu_barrier() to the
rcu_barrier_throttled() function in kernel/rcu/tree.c?

This would allow the do_rcu_barrier module parameter to be used to clear
out kfree_rcu() as well as call_rcu() work.  This would be useful to
people running userspace benchmarks that cause the kernel to do a lot
of kfree_rcu() calls.  Always good to avoid messing up the results from
the current run due to deferred work from the previous run.  Even better
would be to actually account for the deferred work, but do_rcu_barrier
can help with that as well.  ;-)

Thoughts?

							Thanx, Paul

> ---
>  include/linux/rcutiny.h |   5 ++
>  include/linux/rcutree.h |   1 +
>  kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 107 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index d9ac7b136aea..522123050ff8 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -111,6 +111,11 @@ static inline void __kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  	kvfree(ptr);
>  }
>  
> +static inline void kvfree_rcu_barrier(void)
> +{
> +	rcu_barrier();
> +}
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
>  #else
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 254244202ea9..58e7db80f3a8 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -35,6 +35,7 @@ static inline void rcu_virt_note_context_switch(void)
>  
>  void synchronize_rcu_expedited(void);
>  void kvfree_call_rcu(struct rcu_head *head, void *ptr);
> +void kvfree_rcu_barrier(void);
>  
>  void rcu_barrier(void);
>  void rcu_momentary_dyntick_idle(void);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..be00aac5f4e7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3584,18 +3584,15 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
>  }
>  
>  /*
> - * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> + * Return: %true if a work is queued, %false otherwise.
>   */
> -static void kfree_rcu_monitor(struct work_struct *work)
> +static bool
> +kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
>  {
> -	struct kfree_rcu_cpu *krcp = container_of(work,
> -		struct kfree_rcu_cpu, monitor_work.work);
>  	unsigned long flags;
> +	bool queued = false;
>  	int i, j;
>  
> -	// Drain ready for reclaim.
> -	kvfree_rcu_drain_ready(krcp);
> -
>  	raw_spin_lock_irqsave(&krcp->lock, flags);
>  
>  	// Attempt to start a new batch.
> @@ -3634,11 +3631,27 @@ static void kfree_rcu_monitor(struct work_struct *work)
>  			// be that the work is in the pending state when
>  			// channels have been detached following by each
>  			// other.
> -			queue_rcu_work(system_wq, &krwp->rcu_work);
> +			queued = queue_rcu_work(system_wq, &krwp->rcu_work);
>  		}
>  	}
>  
>  	raw_spin_unlock_irqrestore(&krcp->lock, flags);
> +	return queued;
> +}
> +
> +/*
> + * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
> + */
> +static void kfree_rcu_monitor(struct work_struct *work)
> +{
> +	struct kfree_rcu_cpu *krcp = container_of(work,
> +		struct kfree_rcu_cpu, monitor_work.work);
> +
> +	// Drain ready for reclaim.
> +	kvfree_rcu_drain_ready(krcp);
> +
> +	// Queue a batch for a rest.
> +	kvfree_rcu_queue_batch(krcp);
>  
>  	// If there is nothing to detach, it means that our job is
>  	// successfully done here. In case of having at least one
> @@ -3859,6 +3872,86 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> +/**
> + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> + *
> + * Note that a single argument of kvfree_rcu() call has a slow path that
> + * triggers synchronize_rcu() following by freeing a pointer. It is done
> + * before the return from the function. Therefore for any single-argument
> + * call that will result in a kfree() to a cache that is to be destroyed
> + * during module exit, it is developer's responsibility to ensure that all
> + * such calls have returned before the call to kmem_cache_destroy().
> + */
> +void kvfree_rcu_barrier(void)
> +{
> +	struct kfree_rcu_cpu_work *krwp;
> +	struct kfree_rcu_cpu *krcp;
> +	bool queued;
> +	int i, cpu;
> +
> +	/*
> +	 * Firstly we detach objects and queue them over an RCU-batch
> +	 * for all CPUs. Finally queued works are flushed for each CPU.
> +	 *
> +	 * Please note. If there are outstanding batches for a particular
> +	 * CPU, those have to be finished first following by queuing a new.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		krcp = per_cpu_ptr(&krc, cpu);
> +
> +		/*
> +		 * Check if this CPU has any objects which have been queued for a
> +		 * new GP completion. If not(means nothing to detach), we are done
> +		 * with it. If any batch is pending/running for this "krcp", below
> +		 * per-cpu flush_rcu_work() waits its completion(see last step).
> +		 */
> +		if (!need_offload_krc(krcp))
> +			continue;
> +
> +		while (1) {
> +			/*
> +			 * If we are not able to queue a new RCU work it means:
> +			 * - batches for this CPU are still in flight which should
> +			 *   be flushed first and then repeat;
> +			 * - no objects to detach, because of concurrency.
> +			 */
> +			queued = kvfree_rcu_queue_batch(krcp);
> +
> +			/*
> +			 * Bail out, if there is no need to offload this "krcp"
> +			 * anymore. As noted earlier it can run concurrently.
> +			 */
> +			if (queued || !need_offload_krc(krcp))
> +				break;
> +
> +			/* There are ongoing batches. */
> +			for (i = 0; i < KFREE_N_BATCHES; i++) {
> +				krwp = &(krcp->krw_arr[i]);
> +				flush_rcu_work(&krwp->rcu_work);
> +			}
> +		}
> +	}
> +
> +	/*
> +	 * Now we guarantee that all objects are flushed.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		krcp = per_cpu_ptr(&krc, cpu);
> +
> +		/*
> +		 * A monitor work can drain ready to reclaim objects
> +		 * directly. Wait its completion if running or pending.
> +		 */
> +		cancel_delayed_work_sync(&krcp->monitor_work);
> +
> +		for (i = 0; i < KFREE_N_BATCHES; i++) {
> +			krwp = &(krcp->krw_arr[i]);
> +			flush_rcu_work(&krwp->rcu_work);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> -- 
> 2.39.2
> 
