Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731A3E63A8;
	Sun, 27 Sep 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527261; cv=none; b=JUffwV1XsS8mqwlCAdqMMx30FvOz5C91mYJsmMt462qe9f1VWVyWUyQhMeuJL1fhaI9aMaL4A/+f+z0cMzvle0iIUVsC5tpWtbufx2c1jC0czmlDI9VMRsWamRz+svOmo24A+HFEBBlhQosfmfbRPgL/P+kY8AnFaklQc7xi06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527261; c=relaxed/simple;
	bh=8O1VS1UgZGXNM34vtWiuCxw/R1sSxDw+i9AIt98waKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MupSTJKFYEwcBBHH1ymPS53XBizjSX7oIGKJ2cbLigIx+H7INZg++NCrwh51gL70l+xm9WgKZ3Fq3FnDa35YqrhblOVyNAtqYWj/rfbWkBVK8MqvDVNMCK7ltbcx32ozVJ2DvOllBwTbZLKpudb/k2cSincjLJLZRc1d+cUWwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K641qn2j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K641qn2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1631F00893;
	Sun, 27 Sep 2026 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790527259;
	bh=TJOII5/8pr0qJGNWhEF1sMa/bLp49Gd9Sd/YRV2YqBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K641qn2j+xOgmdRLEZARLYXBc+U0qHptSVRielS7jvpZsESEKvMJ+WpMG1vT3Nzlo
	 hDJSRji8H8eKGH0MEa6tK1t67t3Gqo1fGIuKtKhAr76GFRTU9nY5MJfjORkw7460pd
	 lIRoH3aJmNVLxGRaR2FmddIBm0SLipstLNmKPw/D8ek2xWJ3Zc6g6IUZfNSSZVXAYM
	 Q9FkCbcK68NlXD+tbT1HIXU3GpIhRdnl1tz55HYIw5oJdE4zwA1HL7iaBURk+6Snz6
	 wIeVWbjgIVeSaXTZSWQQYFeTCYxrcBb0e4JHzxxRliyzevO/FqkPXh5pEhhdanZzZH
	 g0DP7vee79a6A==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0D665F40066;
	Sun, 27 Sep 2026 12:40:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 27 Sep 2026 12:40:58 -0400
X-ME-Sender: <xms:GUe5agL4PRv9dNvUHcjILUfj7t757MjPgjB3ozB0ExQvQFUnt3ovuw>
    <xme:GUe5asJixIRTjWrpHZ2gq7BF0mPg4iKZqwo4VEHT3LCwlcyaulMnJ2oBCRiZZPViY
    u7Xf6yMATFc7YxkBoMuysVvnUVpZ9hHNLU0zD5vXqRQlPApFGzUuA>
X-ME-Received: <xmr:GUe5ai6p88HneYB5ynKu6Pztq5iY8Ttu8lF7xX3btxgjIjQXTiN8Fa4Ux9IE>
X-ME-Proxy-Cause: dmFkZTFA75LtxuIpcULepPnig51IyBRZvgriccoQjCkGSZeI71IBanurHKnQRil5tVVFBg
    d9++bn4kdiFA/+TjTRnVc5VPdhMebC97+DEZdS6gcbkCZkVq6VJPpNbydkXSzY6/nljXe6
    3V1SCjFYFhgTbKit6LIQvB421FPY/zK+/cxvU6rOqI526KGEJ1xZpFhvGMoMSF6gM/ZiyM
    h7+xgQ0Ma2VzyRdHkUAE3LvcBd7uVKpjW76aQKUS9laxbOedMdluQZR7PQchSrNdaOnYek
    ubptr63dGaURHPr1yr7N5ZIJRyAjrzF+rgfzrcy1wUCH2qRK3pzDem5sfSHMO3SiMp4oOI
    xFHpH3xOvpjC/sgTe7jgKCsazDIAEdaJ2EV4pgzbDKIF27ZdLRlmtekuKQjGVegOxmcRgo
    foj7IwFv+STneT5s9oFevUEHeyBtw2A/uNB93GLs4a4nR8RfOYcL1JQny3xjWW5iLNS4la
    fga7J9LCvYXcm+UxGI56AYZfCCGLX4GpGo9wehVJuRjaw8rSWepToaDZ4CW0eEKrBFqP6N
    kRsCzfu8OAvlloJq5nPbEOy2xFcbVdoUXVok97EgddW5u/ySPh9wGwL8cdJCJTDCyl2Upb
    1jcdR58ZY3pPuV7hWbP0rDXPsHG3tp6TUUUfpdquKCOriK3lctWRcT19NqNw
X-ME-Proxy: <xmx:GUe5auc82ot7SHBmrPlGnYbIjYQIy6B5YUvmtAsiVUCaIWX3uVcnhg>
    <xmx:Gke5alFNtZyE_h-ocI2pDeH-5ELsBVbLGuNHnvNi8KF3JpjdSps0WA>
    <xmx:Gke5avRm4S7K3Ubw1DZS4r61BFjodiYfq1dSyRbj0gXGJIsTu57Skw>
    <xmx:Gke5arY96Ho_izu8BTTCuuroCeD8KbipD4pvsWabetCfacmPP1RIWg>
    <xmx:Gke5aq2AvcULAGLSTt6i5fy-lcxhVaFBfgH2OL6toZznxlrqY1cOPVf7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 12:40:57 -0400 (EDT)
Date: Sun, 27 Sep 2026 18:40:53 +0200
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <arlHFVT5EzcX4d1-@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927155134.4740-5-mathieu.desnoyers@efficios.com>

On Sun, Sep 27, 2026 at 11:51:31AM -0400, Mathieu Desnoyers wrote:
> Introduce a "try acquire" hazard pointer fast path, which performs an
> early load of the address to store it into the hazard pointer slot, and
> then re-loads that address after a barrier to check whether it has
> changed meanwhile.
> 
> On comparison failure, rather than re-try, guarantee forward progress by
> falling back to the __hazptr_acquire slow path on failure.
> 
> The acquire slow path attempts a try-acquire for any available per-CPU
> slot. If that fails, it chains the backup slot into the overflow list,
> therefore guaranteeing forward progress for both hazard pointer
> read-side and synchronize:
> 
> - Readers set the wildcard, and then proceed to set the more
>   specific address to replace the wildcard.
> 
> - One synchronize alternates between two overflow list periods,
>   scanning each one while readers are added to the other period,
>   thus preventing a steady flow of readers from preventing
>   synchronize forward progress.
> 
> With this change, the scan on per-CPU slots don't need to expect a
> wildcard anymore, because none can be produced by readers. Wildcards are
> only expected within overflow lists.
> 

Ok, I was missing something, but I think it's better to call it out.
Wildcards can only exist in the overflow lists when the context is not
preemptible. In other words, there won't be a preempted readers blocking
the synchronize_hazptr() with a wilcard in the overflow list.

So no more design trade-off question from me :)

Regards,
Boqun

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Bradley Morgan <brads@mainlining.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: <rcu@vger.kernel.org>
> Cc: <lkmm@lists.linux.dev>
> ---
>  include/linux/hazptr.h |  47 +++++++++++--------
>  kernel/hazptr.c        | 103 ++++++++++++++++++++---------------------
>  2 files changed, 76 insertions(+), 74 deletions(-)
> 
> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> index d1670121947a..fcf017ca2255 100644
> --- a/include/linux/hazptr.h
> +++ b/include/linux/hazptr.h
> @@ -29,9 +29,6 @@
>  /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
>  #define NR_HAZPTR_PERCPU_SLOTS	4
>  
> -/* The current hazard pointer wildcard. */
> -extern void *hazptr_wildcard;
> -
>  /*
>   * Hazard pointer slot.
>   */
> @@ -190,6 +187,31 @@ void hazptr_note_context_switch(void)
>  	}
>  }
>  
> +/* Try hazard pointer protection. */
> +static inline
> +void *__hazptr_try_acquire(struct hazptr_ctx *ctx, void * const *addr_p, struct hazptr_slot *slot)
> +{
> +	void *early_addr, *addr;
> +
> +	if (unlikely(slot->addr))
> +		return NULL;
> +	early_addr = READ_ONCE(*addr_p);	/* Early load. */
> +	WRITE_ONCE(slot->addr, early_addr);	/* Store B */
> +	/* Memory ordering: Store B before Load A. */
> +	smp_mb();
> +	addr = READ_ONCE(*addr_p);		/* Load A */
> +	/*
> +	 * Validate that address did not change between Early load and Load A.
> +	 * Use ptr_eq() to make sure that result from Load A is returned to the
> +	 * caller to preserve address dependency.
> +	 */
> +	if (unlikely(!ptr_eq(addr, early_addr))) {
> +		WRITE_ONCE(slot->addr, NULL);
> +		return NULL;
> +	}
> +	return addr;
> +}
> +
>  /**
>   * hazptr_acquire - Load pointer at address and protect with hazard pointer.
>   *
> @@ -245,24 +267,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>  	ctx->acquire_cpu = smp_processor_id();
>  	ctx->acquire_caller = _THIS_IP_;
>  #endif
> -	if (unlikely(slot->addr))
> +	addr = __hazptr_try_acquire(ctx, addr_p, slot);
> +	if (unlikely(!addr))
>  		return __hazptr_acquire(ctx, addr_p);
> -	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> -
> -	/* Memory ordering: Store B before Load A. */
> -	smp_mb();
> -
> -	/*
> -	 * Load @addr_p after storing wildcard to the hazard pointer slot.
> -	 */
> -	addr = READ_ONCE(*addr_p);	/* Load A */
> -
> -	/*
> -	 * We don't care about ordering of Store C. It will simply
> -	 * replace the wildcard by a more specific address. If addr is
> -	 * NULL, we simply store NULL into the slot.
> -	 */
> -	WRITE_ONCE(slot->addr, addr);	/* Store C */
>  	slot_item->ctx.ctx = ctx;
>  	ctx->slot = slot;
>  	return addr;
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index 13faa5ba7677..3ca73b56a5c2 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -13,17 +13,9 @@
>  #include <linux/list.h>
>  #include <linux/export.h>
>  
> -static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the wildcard and list phase flip. */
> +#define HAZPTR_WILDCARD	((void *) 1UL)
>  
> -/*
> - * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
> - * hazptr_synchronize forward progress even with a steady stream of readers.
> - * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
> - * This also affects the overflow list selection: the current list used by
> - * readers is array[(unsigned long) hazptr_wildcard - 1].
> - */
> -void *hazptr_wildcard = (void *) 1UL;
> -EXPORT_SYMBOL_GPL(hazptr_wildcard);
> +static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the list phase flip. */
>  
>  /* The current overflow list phase. */
>  static unsigned int hazptr_overflow_list_phase;
> @@ -41,6 +33,10 @@ struct hazptr_overflow_list {
>   * successively iterates on both lists. Therefore, only list removals
>   * can cause the iteration to retry, and the number of removals is
>   * limited to the number of list elements.
> + *
> + * Due to the overflow list raw spin lock, the hazard pointer readers are
> + * blocking, starvation-free with bounded waiting, assuming bounded critical
> + * sections and no NMI or virtualization-induced holder preemption.
>   */
>  struct hazptr_overflow_list_flip {
>  	struct hazptr_overflow_list array[2];
> @@ -51,26 +47,12 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
>  DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
>  EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
>  
> -static
> -void *flip_wildcard(void *wildcard)
> -{
> -	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
> -}
> -
>  static
>  unsigned int flip_list_phase(unsigned int phase)
>  {
>  	return 1 - phase;
>  }
>  
> -static
> -bool is_wildcard(void *addr)
> -{
> -	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
> -		return true;
> -	return false;
> -}
> -
>  static
>  struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>  {
> @@ -96,16 +78,36 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>   */
>  void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>  {
> -	struct hazptr_slot *slot = hazptr_get_free_percpu_slot(ctx);
> +	struct hazptr_slot *slot;
>  	void *addr;
>  
>  	/*
> -	 * If all the per-CPU slots are already in use, fallback
> -	 * to the backup slot.
> +	 * In case we are called due to nested use of hazard pointers,
> +	 * try a slot protection with per-CPU slots.
>  	 */
> -	if (unlikely(!slot))
> -		slot = hazptr_chain_backup_slot(ctx);
> -	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> +	slot = hazptr_get_free_percpu_slot(ctx);
> +	if (likely(slot)) {
> +		addr = __hazptr_try_acquire(ctx, addr_p, slot);
> +		if (addr) {
> +			ctx->slot = slot;
> +			return addr;
> +		}
> +	}
> +
> +	/*
> +	 * The backup slot overflow list guarantees forward progress of both
> +	 * hazard pointer readers and synchronize:
> +	 *
> +	 * - Readers set the wildcard, and then proceed to set the more
> +	 *   specific address to replace the wildcard.
> +	 *
> +	 * - One synchronize alternates between two overflow list periods,
> +	 *   scanning each one while readers are added to the other period,
> +	 *   thus preventing a steady flow of readers from preventing
> +	 *   synchronize forward progress.
> +	 */
> +	slot = hazptr_chain_backup_slot(ctx);
> +	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
>  
>  	/* Memory ordering: Store B before Load A. */
>  	smp_mb();
> @@ -121,20 +123,21 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>  	 * NULL, we simply store NULL into the slot.
>  	 */
>  	WRITE_ONCE(slot->addr, addr);	/* Store C */
> +
>  	ctx->slot = slot;
> -	if (!addr && hazptr_slot_is_backup(ctx, slot))
> +	if (!addr)
>  		hazptr_unchain_backup_slot(ctx);
>  	return addr;
>  }
>  EXPORT_SYMBOL_GPL(__hazptr_acquire);
>  
>  /*
> - * Perform piecewise iteration on overflow list waiting until "addr" is
> - * not present. Raw spinlock is released and taken between each list
> - * item and busy loop iteration. The overflow list generation is checked
> - * each time the lock is taken to validate that the list has not changed
> - * before resuming iteration or busy wait. If the generation has
> - * changed, retry the entire list traversal.
> + * Perform piecewise iteration on overflow list waiting until "addr" and
> + * wildcard are not present. Raw spinlock is released and taken between each
> + * list item and busy loop iteration. The overflow list generation is checked
> + * each time the lock is taken to validate that the list has not changed before
> + * resuming iteration or busy wait. If the generation has changed, retry the
> + * entire list traversal.
>   */
>  static
>  void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list, void *addr)
> @@ -147,13 +150,11 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>  retry:
>  	snapshot_gen = overflow_list->gen;
>  	hlist_for_each_entry(backup_slot, &overflow_list->head, overflow_node) {
> -		/* Busy-wait if node is found. */
> +		/* Busy-wait if addr or wildcard are found. */
>  		for (;;) {
>  			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
>  
> -			/* We don't expect wildcards in overflow list. */
> -			WARN_ON_ONCE(is_wildcard(load_addr));
> -			if (load_addr != addr)
> +			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
>  				break;
>  			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
>  			cpu_relax();
> @@ -174,7 +175,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>  }
>  
>  static
> -void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
> +void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>  {
>  	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
>  	unsigned int idx;
> @@ -182,13 +183,13 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>  	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
>  		struct hazptr_slot_item *item = &percpu_slots->items[idx];
>  
> -		/* Busy-wait if node is found. */
> -		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
> +		/* Busy-wait if addr is found. */
> +		smp_cond_load_acquire(&item->slot.addr, VAL != addr); /* Load B */
>  	}
>  }
>  
>  static
> -void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> +void hazptr_scan_cpu_slots(void *addr)
>  {
>  	int cpu;
>  
> @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>  	for_each_possible_cpu(cpu) {
>  		/*
>  		 * Scan CPU slots.
> -		 * Forward progress against recurring wildcards is guaranteed
> -		 * by scanning for one wildcard while new elements use the
> -		 * other wildcard value (1UL vs 2UL).
>  		 * Forward progress against recurring single hazard pointer
>  		 * values is guaranteed by the fact that a hazard pointer
>  		 * is not reclaimed nor reused until the scan for that hazard
>  		 * pointer completes, which prevents a steady flow of readers
>  		 * to acquire that same hazard pointer value.

(Not a comment to this patch, but I think it's worth bringing up)

I want to point out this is not true for the lockdep use case, because
the we need to protect a hash list deletion there, and we use the
address of the hash bucket there. It's proven fine in practice because
the readers are rare (we only call the reader is_dynamic_key() in
register_lock_class(), that is every time you have a new lock class to
register).

Maybe what we want to say here is that "if the users guarantee no steady
flow of the same hazard pointer value, we guarantee forward progress".
Thoughts?

The rest looks good to me.

Regards,
Boqun

>  		 */
> -		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> +		hazptr_synchronize_cpu_slots(cpu, addr);
>  	}
>  }
>  
> @@ -237,7 +235,6 @@ void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
>  void hazptr_synchronize(void *addr)
>  {
>  	unsigned int scan_list_phase;
> -	void *scan_wildcard;
>  
>  	/*
>  	 * Busy-wait should only be done from preemptible context.
> @@ -251,16 +248,14 @@ void hazptr_synchronize(void *addr)
>  	 */
>  	if (!addr)
>  		return;
> +
>  	/* Memory ordering: Store A before Load B. */
>  	smp_mb();
>  
>  	guard(mutex)(&hazptr_phase_lock);
>  
>  	/* Scan per-CPU slots. */
> -	scan_wildcard = flip_wildcard(hazptr_wildcard);
> -	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
> -	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
> -	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
> +	hazptr_scan_cpu_slots(addr);
>  
>  	/*
>  	 * Scan overflow lists *after* scanning per-CPU slots. See
> -- 
> 2.43.0
> 
