Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA22222C5;
	Sat, 19 Sep 2026 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824499; cv=none; b=dAjLE57U/IW8pmI4XPu+KKUdjFMF6wdkUFgatei5fnDcEFpYQVqynnij1Ejpzg0YkQscbMlA1V64yOplsMtXPgfhOb61UMkLcyt1ico8BYesQw9XtliX+WsBDEvc/uc/EeVqwcb/Xsz5iJX8hnggfI9Oaz5ayL6N9bNRezwvrRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824499; c=relaxed/simple;
	bh=yi/uyDqnMf7vPrW8Y1LeSAszJ436wW2K+uCqioAo92M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWVWSfRr8cfRexm2BTmM5eD2FjBF3wLkr04/VfyoKmPUc2VKUtaoCb+KwEBg4M3yB1NZawHdev4VSkgBIxJa4Q4SjlS6qRTYxsQqOr51E9S1bbm/tiIfLTRtIhfMc6Qmxx8qA//r5wlZvEHxk7WMGK7m6TBakxjxuzPPjRoXbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjpubD47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjpubD47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB0C1F00898;
	Sat, 19 Sep 2026 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789824496;
	bh=AQHg99E+8dOvSM8NXcxtRZsb2gy6paNcjnRWVwZ9gQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NjpubD47rSVhX/gc2kc265EWdq7MNYQ6E65LEL7g2Qrz4ea1TWN3agZXkmOvY2Sb3
	 IYse46dllcT3w+GKkfX3ldhPD51B3u4Cg+RKl/yA4Sa+gazpxiDZVgN1O3dYv68IKF
	 CgnmS52XsaFzRPNSwftU8G6fuRIcy8Fu9IAkmR5+/tip6ZayYHW8W5d+W3pV2Z3+C8
	 f2VJ3E5KPersTY3+ggKIMhrtfHrk44n4HtRAZ6B/T5zGT7uyFY4NKNO+JXcdHiXmK6
	 QtN8SHgpQZJ4r8h3DWoizWEoOUytfBG+o5fT/bhUIX5ZzO29vgt0m8jteb7+6lSnMv
	 b919DeV/vYPuA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5C6EBF40068;
	Sat, 19 Sep 2026 09:28:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 19 Sep 2026 09:28:15 -0400
X-ME-Sender: <xms:742uaql6ZZrvR5OnG7Y2VEqakF2w38Eg9Y4-tIoK61fyAXp_5Tcb3w>
    <xme:742uauhb35j-9JGDlG-qkuzXwxr_tqPAs1ZYI1mxlwByEY3JX6751arjLVHVUaFF5
    jfaPy7CZqW4x1ZsLHwNm2dPaugSw2DeX9aNwJeDRT8niOSc6IMFuyc>
X-ME-Received: <xmr:742uash0eicy4aIED2lobR42hQzmprJkOBYq_RL69H2R_qM-uV26n8VageqN>
X-ME-Proxy-Cause: dmFkZTGRzlvJrPa5+Ku2JtClXoI6S86PC++7kWONH2CljNIDdkQAy8fi7ng5ycMln4ZTBI
    pUd5jMoafTIQNxQ4DURmZMtln7reVzndcj9dr9YTFGMznGdzsu+vfRGg+4+3Obadv5WGvm
    /602xlBC3vyjkTCow9DB9i4VL1etobs0eXu9KHCjmCEhWI8HocVTHhG72RB7oMSyvdKjrZ
    FljZs2hHedoKnWRIwiJtavlX+fDVO7zmk9ZHnlyHtDqEeRUjn+dvoBa25wS8DvFvanxTlN
    ZzlNcn4RzN3NlKqvuXQxvBJMrWTN/gSpMdeHJ8EnA6sVXTxo6pziVrDSlUAI9TF3abT0rQ
    BGSF6u0xufPzCRMBcXTbxPAz0ooTJYfjsrvdrYWd4ssDKybt6xTzI8rKtxmJgo/sN5HoXs
    WidvCL7AXeb3QQlL6JxidJYRpe5ls3g6x2Yv+Pvug0yWswqveYKItySaR9wlrRVvhGvRmN
    iTcj3RAvVZ2PvWZ84bXhdwuKxgiZ+QHMX0/ok1QO3ZLyQjxIsrBTELaknfiNKeWjbY6NzP
    s/WJ9Rl8R3cbLYmkvey8YSz6X5MOQTRdpkoz5vWQtbG97SKGfMsmUJ2POT7/KMF+1vzZXd
    XkND1o3885gPvPUoQLGvC+W70wiNpkD9Lo30+RD+08MZJQmfTUach6P9ZDcw
X-ME-Proxy: <xmx:742uaotcNYpkDj1Vq5zDCs7fBAZqLr9lgq3M1GNycLGVI3KdniK1ew>
    <xmx:742uasuWeGuKfKUZHgPGFrnhg0h6f2vxuL1MCwld5O3CJjze694kTA>
    <xmx:742uaurddldiFEpoPAuxKpXIQzrmoXmyM2N2gSm_nD25_1BapAEkmw>
    <xmx:742uarJAH6jyEW8rY9VWNwztpvwg3lSRE7wluCLGOaHMB1C_8HIBfA>
    <xmx:742uauu2pEd1NxmwDCcogOkElt9zL5CdZfKDMZoT--xl_eKb-4DulTxO>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Sep 2026 09:28:14 -0400 (EDT)
Date: Sat, 19 Sep 2026 14:28:12 +0100
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Bradley Morgan <include@grrlz.net>
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
Message-ID: <aq6N7BPWJ2jl8y-1@MacBook-0RXW5>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919000056.3132131-26-paulmck@kernel.org>

On Fri, Sep 18, 2026 at 05:00:54PM -0700, Paul E. McKenney wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Implement a two-phase wildcard scan to guarantee forward progress of
> synchronize_hazptr() even if there is a steady stream of ill-timed
> readers which populate wildcards into per-CPU slots.
> 
> This is performed by flipping between two wildcard values (1UL and 2UL),
> and alternatively scanning for the opposite wildcard while newcoming
> readers use the other one.
> 
> There is no possibility to miss a reader because all slots for all
> wildcards are accounted for during a synchronize.
> 
> As a simplification, use this period flip to drive the hazptr overflow
> list selection as well, since there is really no point is making the
> overflow list flip use a different state.
> 
> Protect the wildcard flip with a mutex.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
>  include/linux/hazptr.h |  6 ++-
>  kernel/hazptr.c        | 98 ++++++++++++++++++++++++++++++------------
>  2 files changed, 74 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> index 43998bf43de4..43122c5673bd 100644
> --- a/include/linux/hazptr.h
> +++ b/include/linux/hazptr.h
> @@ -28,7 +28,9 @@
>  
>  /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
>  #define NR_HAZPTR_PERCPU_SLOTS	4
> -#define HAZPTR_WILDCARD		((void *) 0x1UL)
> +
> +/* The current hazard pointer wildcard. */
> +extern void *hazptr_wildcard;
>  
>  /*
>   * Hazard pointer slot.
> @@ -243,7 +245,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>  #endif
>  	if (unlikely(slot->addr))
>  		return __hazptr_acquire(ctx, addr_p);
> -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>  
>  	/* Memory ordering: Store B before Load A. */
>  	smp_mb();
> diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> index a9d3d68a1525..d3d1050d92cf 100644
> --- a/kernel/hazptr.c
> +++ b/kernel/hazptr.c
> @@ -13,6 +13,17 @@
>  #include <linux/list.h>
>  #include <linux/export.h>
>  
> +/*
> + * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
> + * hazptr_synchronize forward progress even with a steady stream of readers.
> + * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
> + * This also affects the overflow list selection: the current list used by
> + * readers is array[(unsigned long) hazptr_wildcard - 1].
> + */
> +static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
> +void *hazptr_wildcard = (void *) 1UL;
> +EXPORT_SYMBOL_GPL(hazptr_wildcard);
> +
>  struct hazptr_overflow_list {
>  	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
>  	struct hlist_head head;		/* Overflow list head. */
> @@ -28,8 +39,6 @@ struct hazptr_overflow_list {
>   * limited to the number of list elements.
>   */
>  struct hazptr_overflow_list_flip {
> -	struct mutex lock;		/* Mutex protecting add_idx from concurrent updates. */
> -	unsigned int add_idx;		/* Index of current flip-list to add to. */
>  	struct hazptr_overflow_list array[2];
>  };
>  
> @@ -38,6 +47,20 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
>  DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
>  EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
>  
> +static
> +void *flip_wildcard(void *wildcard)
> +{
> +	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
> +}
> +
> +static
> +bool is_wildcard(void *addr)
> +{
> +	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
> +		return true;
> +	return false;
> +}
> +
>  static
>  struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>  {
> @@ -72,7 +95,7 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
>  	 */
>  	if (unlikely(!slot))
>  		slot = hazptr_chain_backup_slot(ctx);
> -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>  
>  	/* Memory ordering: Store B before Load A. */
>  	smp_mb();
> @@ -118,7 +141,9 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>  		for (;;) {
>  			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
>  
> -			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
> +			/* We don't expect wildcards in overflow list. */
> +			WARN_ON_ONCE(is_wildcard(load_addr));
> +			if (load_addr != addr)
>  				break;
>  			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
>  			cpu_relax();
> @@ -139,7 +164,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
>  }
>  
>  static
> -void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> +void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>  {
>  	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
>  	unsigned int idx;
> @@ -148,7 +173,39 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>  		struct hazptr_slot_item *item = &percpu_slots->items[idx];
>  
>  		/* Busy-wait if node is found. */
> -		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != HAZPTR_WILDCARD); /* Load B */
> +		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
> +	}
> +}
> +
> +static
> +void hazptr_scan_period(void *addr, void *scan_wildcard)
> +{
> +	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
> +	int cpu;
> +
> +	/* Scan all CPUs slots. */
> +	for_each_possible_cpu(cpu) {
> +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> +
> +		/*
> +		 * Scan CPU slots.
> +		 * Forward progress against recurring wildcards is guaranteed
> +		 * by scanning for one wildcard while new elements use the
> +		 * other wildcard value (1UL vs 2UL).
> +		 * Forward progress against recurring single hazard pointer
> +		 * values is guaranteed by the fact that a hazard pointer
> +		 * is not reclaimed nor reused until the scan for that hazard
> +		 * pointer completes, which prevents a steady flow of readers
> +		 * to acquire that same hazard pointer value.
> +		 */
> +		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> +
> +		/*
> +		 * Scan backup slots in percpu overflow lists.
> +		 * Forward progress is guaranteed by scanning one list
> +		 * while new elements are added into the other list.
> +		 */
> +		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
>  	}
>  }
>  
> @@ -161,7 +218,7 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
>   */
>  void hazptr_synchronize(void *addr)
>  {
> -	int cpu;
> +	void *scan_wildcard;
>  
>  	/*
>  	 * Busy-wait should only be done from preemptible context.
> @@ -177,33 +234,19 @@ void hazptr_synchronize(void *addr)
>  		return;
>  	/* Memory ordering: Store A before Load B. */
>  	smp_mb();
> -	/* Scan all CPUs slots. */
> -	for_each_possible_cpu(cpu) {
> -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> -		unsigned int scan_idx;
> -
> -		/* Scan CPU slots. */
> -		hazptr_synchronize_cpu_slots(cpu, addr);
>  
> -		/*
> -		 * Scan backup slots in percpu overflow lists.
> -		 * Forward progress is guaranteed by scanning one list
> -		 * while new elements are added into the other list.
> -		 */
> -		guard(mutex)(&overflow_list_flip->lock);
> -		scan_idx = overflow_list_flip->add_idx ^ 1;
> -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
> -		/* Flip current list. */
> -		WRITE_ONCE(overflow_list_flip->add_idx, scan_idx);
> -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx ^ 1], addr);
> -	}
> +	guard(mutex)(&hazptr_wildcard_lock);
> +	scan_wildcard = flip_wildcard(hazptr_wildcard);
> +	hazptr_scan_period(addr, scan_wildcard);
> +	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
> +	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
>  }
>  EXPORT_SYMBOL_GPL(hazptr_synchronize);
>  
>  struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
>  {
>  	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
> -	unsigned int list_idx = READ_ONCE(overflow_list_flip->add_idx);
> +	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;


What if this happens?

	{ <hazptr_wildcard == 2UL> }

	CPU 0				CPU 1
	=====				=====
	hazptr_acquire(ctx, &gp):
	  WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
	  // slot->addr == 2
	  smp_mb();

	  addr = READ_ONCE(*addr_p);      /* Load A */
	  // ^ addr == gp == old, i.e not NULL

	  				/* unpublish and wait for reader */
	  				old = gp;
	  				WRITE_ONCE(gp, NULL);
					hazptr_synchronize(old):
					  smp_mb();
					  guard(mutex)(&hazptr_wildcard_lock);
					  scan_wildcard = flip_wildcard(hazptr_wildcard);
					  // ^ scan_wildcard == 1;

					  hazptr_scan_period(addr, scan_wildcard);
					  // ^ will miss reader on CPU 0
					  // because its slot->addr == 2
                                          WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */

	{ <hazptr_wildcard == 1UL> }

	  WRITE_ONCE(slot->addr, addr);

	hazptr_detach():
	  hazptr_chain_backup_slot():
	    list_idx = READ_ONCE(hazptr_wildcard) - 1;
	    // ^ list_idx == 0

	  smp_store_release(&slot->addr, NULL);
          // ^ clear the per-CPU slot
	    				  // flip_wildcard(scan_wildcard) == 2
                                          hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
					  // ^ will miss reader on CPU 0
					  // because it only scans list
					  // 1.

If I'm not missing anything, then it means a reader can dodge the
hazptr_synchronize() scan, because its per-CPU slot can appear on
wildchard=1 but its backup slot can be on wildcard=2.

Thoughts?

Regards,
Boqun

>  	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
>  	struct hazptr_slot *slot = &ctx->backup_slot.slot;
>  
> @@ -233,7 +276,6 @@ void __init hazptr_init(void)
>  	for_each_possible_cpu(cpu) {
>  		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
>  
> -		mutex_init(&overflow_list_flip->lock);
>  		for (int i = 0; i < 2; i++) {
>  			raw_spin_lock_init(&overflow_list_flip->array[i].lock);
>  			INIT_HLIST_HEAD(&overflow_list_flip->array[i].head);
> -- 
> 2.40.1
> 
