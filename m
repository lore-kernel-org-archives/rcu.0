Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF633E348;
	Sun, 20 Sep 2026 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789919742; cv=none; b=H8vJI49ZbqTuh019F0ch1zywVSPMPdOwUSAHGBcijCItV+08+yF7l0Rs+ItZHcY/3Lexv8QZoZU99Is/ls5iRjXeSWP6ucN+cCBvPdCNJ4cNq6o2c4A75h+mq/untvsu54vtsXWMurPYk2Sr34HvT5ed6PORAt3l5zgpOIqWOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789919742; c=relaxed/simple;
	bh=euvFIYFpqG1K7r8gYFtGOrvbjHg/LXlHlmoz5FeHaPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB2nXDvh2BI5hj8tSjwShSduLF5uPZCelNo2OB6OqR4RKFPRLgFedhZDmbUwmsUhyHBYCeEULDFLOdBeQ3f00WRiIL5/PYOptKCG/wzT64yq1TtQqcw6bL7e9b7R7OVhUhLsdPqYBZE81+SwS3/VZDabbfeq4EL5CMYOu+CHSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuk7fibe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuk7fibe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E411F000FF;
	Sun, 20 Sep 2026 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789919740;
	bh=w59ymiPC1yUN+j+9xPw6aVbrFgtd1D/fW04M22dbE6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nuk7fibewNsuyz/VJpuOlxQk1L8U3qHMrkYE0zu4wSGAuw3CcZ1mA/1LleF9MAkeR
	 8ctoVLeB+87qzUILfpgnkoTCqZqK8rm4UiYxMW1uyRHvZi5L9QPmYXxO8LPQ2NZEcT
	 L7hHyWmTTXp/Ybo49YqN4iqO5XHwf9UrWhDYuWgCCq6DGk+ISkStEMq8R5fsRR7VnH
	 1PQUTiQ2KqnVn6GsWI0ayzyNZdTcc8P8Qk2MZPGXphfrP68aVPYy81U5YUZisTwugT
	 HvpFJX3/mKmG2EknY8i8yIODftBz0YFGsQk3UM5ukd/3zPg5hxa3S3LXrvnUae4QHc
	 kvl2HLkrxFuLg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id A76F8F40068;
	Sun, 20 Sep 2026 11:55:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 20 Sep 2026 11:55:38 -0400
X-ME-Sender: <xms:-gGwaqSKEssXpXOx_Csb22_tXfj5-53PI3bNYJuXGcJIWJimq1e6wA>
    <xme:-gGwaserTjS3K38X9qQ3UbnwEpsRkMoaW4Kg0x3lR4doi2bSbVgKxRHh0yexBtGTz
    Da9KYxTsoLRDahkykSipKtKWXHWdLGzmsPvWNCur_deZUJ0oIJinYI>
X-ME-Received: <xmr:-gGwarvQNVth_Etk_BWCxUlenMDlk5BE8gz3j_ENF0rYz7ypCsaxVh3WWNo3>
X-ME-Proxy-Cause: dmFkZTEMREKcZMoroVczdXN5gUDELDOf6blu0UpWMZwP8u5oSx9/6Ho71fkSTfuTKsCm6S
    aRxEewnreWe0OcbT7ZwUNZ5sC8rcLEFni18Won41Pc/G3HSDbLUUtOANkx9tj5MLUSWqos
    +Zo8/kssNQe5PCjPQe1fdgII4t0tR5Y91+NE1PIo4EtmSH7LF+hdLW2iAQqjIibXREsynH
    6pjM0LOMxV4/0Y7/A+CSDs2r26FJ11d4I36QHz8SeegwS8okqdanPfPuO6GumiMqK2ctKl
    vBGlFGkVN+vYcdqo+oIfpZPCARm5RG28pAAoi8AuenEY6TTLEoPjGe7j7HvP4EQlB6lcRl
    tezNA4WGZvp/XmDagGI4/MVH0GQc2TP9aW/Srvwx70YxG0Qw59/T+oU8R2vUb1VOQnyuOt
    XWm4eGK572gFF3oW1jewsTbPanmwLy/B+AS53gwfFrdq/cPu5DoKYdaUEgTbUUXANdkIUs
    bFSO8rM2balgkoamYyYrPNl9UtE3sr8HbFpMcToZvVZIMFapPxpK7HJDrQhnO0UtUDC6xg
    ZQUXKW53NpO+esZ7VLe+DNFOFfprmovJ4EsgTMfDvLxximmOlwal2ztmbAwaDiAQnR/xwY
    4YbDtAUIml2qJUSM+cCM1B2XExxidI0v0+DXMkNY/smnDmAUL7rh0G7mBT1g
X-ME-Proxy: <xmx:-gGwagLVm2O6b1gbCpDqqBdmkNogEH5MN3Su5BDItySnjXrFfWAIMg>
    <xmx:-gGwanbLCEyBZDqdt7GhFYbW5QYaMJMdEDcIvlMN0ICWhEE5LKRIhg>
    <xmx:-gGwarns0lvLApVU0d4ffc9_W6yVjzvskZ1FTRwReV0UlmukVVVg7w>
    <xmx:-gGwatWIc2HX7T3D8Zy4w2Z3tCENtQskL-0jD65NKzf-d4UeyCXeRw>
    <xmx:-gGwatLfmsOxCtV9y4ot23YCfYGXxZ2gRNi-JE-5n_qW4kG2zY4EJRu5>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 11:55:37 -0400 (EDT)
Date: Sun, 20 Sep 2026 16:55:35 +0100
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	Bradley Morgan <include@grrlz.net>
Subject: Re: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
Message-ID: <arAB94gx8kFpU4rx@MacBook-0RXW5>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-26-paulmck@kernel.org>
 <aq6N7BPWJ2jl8y-1@MacBook-0RXW5>
 <b6887389-6683-4cef-b612-5bee7faad1f3@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6887389-6683-4cef-b612-5bee7faad1f3@efficios.com>

On Sun, Sep 20, 2026 at 08:46:55AM -0400, Mathieu Desnoyers wrote:
> On 2026-09-19 09:28, Boqun Feng wrote:
> > On Fri, Sep 18, 2026 at 05:00:54PM -0700, Paul E. McKenney wrote:
> > > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > 
> > > Implement a two-phase wildcard scan to guarantee forward progress of
> > > synchronize_hazptr() even if there is a steady stream of ill-timed
> > > readers which populate wildcards into per-CPU slots.
> > > 
> > > This is performed by flipping between two wildcard values (1UL and 2UL),
> > > and alternatively scanning for the opposite wildcard while newcoming
> > > readers use the other one.
> > > 
> > > There is no possibility to miss a reader because all slots for all
> > > wildcards are accounted for during a synchronize.
> > > 
> > > As a simplification, use this period flip to drive the hazptr overflow
> > > list selection as well, since there is really no point is making the
> > > overflow list flip use a different state.
> > > 
> > > Protect the wildcard flip with a mutex.
> > > 
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Boqun Feng <boqun@kernel.org>
> > > Reviewed-by: Bradley Morgan <include@grrlz.net>
> > > ---
> > >   include/linux/hazptr.h |  6 ++-
> > >   kernel/hazptr.c        | 98 ++++++++++++++++++++++++++++++------------
> > >   2 files changed, 74 insertions(+), 30 deletions(-)
> > > 
> > > diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> > > index 43998bf43de4..43122c5673bd 100644
> > > --- a/include/linux/hazptr.h
> > > +++ b/include/linux/hazptr.h
> > > @@ -28,7 +28,9 @@
> > >   /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
> > >   #define NR_HAZPTR_PERCPU_SLOTS	4
> > > -#define HAZPTR_WILDCARD		((void *) 0x1UL)
> > > +
> > > +/* The current hazard pointer wildcard. */
> > > +extern void *hazptr_wildcard;
> > >   /*
> > >    * Hazard pointer slot.
> > > @@ -243,7 +245,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> > >   #endif
> > >   	if (unlikely(slot->addr))
> > >   		return __hazptr_acquire(ctx, addr_p);
> > > -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> > > +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> > >   	/* Memory ordering: Store B before Load A. */
> > >   	smp_mb();
> > > diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> > > index a9d3d68a1525..d3d1050d92cf 100644
> > > --- a/kernel/hazptr.c
> > > +++ b/kernel/hazptr.c
> > > @@ -13,6 +13,17 @@
> > >   #include <linux/list.h>
> > >   #include <linux/export.h>
> > > +/*
> > > + * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
> > > + * hazptr_synchronize forward progress even with a steady stream of readers.
> > > + * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
> > > + * This also affects the overflow list selection: the current list used by
> > > + * readers is array[(unsigned long) hazptr_wildcard - 1].
> > > + */
> > > +static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
> > > +void *hazptr_wildcard = (void *) 1UL;
> > > +EXPORT_SYMBOL_GPL(hazptr_wildcard);
> > > +
> > >   struct hazptr_overflow_list {
> > >   	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
> > >   	struct hlist_head head;		/* Overflow list head. */
> > > @@ -28,8 +39,6 @@ struct hazptr_overflow_list {
> > >    * limited to the number of list elements.
> > >    */
> > >   struct hazptr_overflow_list_flip {
> > > -	struct mutex lock;		/* Mutex protecting add_idx from concurrent updates. */
> > > -	unsigned int add_idx;		/* Index of current flip-list to add to. */
> > >   	struct hazptr_overflow_list array[2];
> > >   };
> > > @@ -38,6 +47,20 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
> > >   DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
> > >   EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
> > > +static
> > > +void *flip_wildcard(void *wildcard)
> > > +{
> > > +	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
> > > +}
> > > +
> > > +static
> > > +bool is_wildcard(void *addr)
> > > +{
> > > +	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
> > > +		return true;
> > > +	return false;
> > > +}
> > > +
> > >   static
> > >   struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> > >   {
> > > @@ -72,7 +95,7 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> > >   	 */
> > >   	if (unlikely(!slot))
> > >   		slot = hazptr_chain_backup_slot(ctx);
> > > -	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> > > +	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> > >   	/* Memory ordering: Store B before Load A. */
> > >   	smp_mb();
> > > @@ -118,7 +141,9 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
> > >   		for (;;) {
> > >   			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
> > > -			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
> > > +			/* We don't expect wildcards in overflow list. */
> > > +			WARN_ON_ONCE(is_wildcard(load_addr));
> > > +			if (load_addr != addr)
> > >   				break;
> > >   			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
> > >   			cpu_relax();
> > > @@ -139,7 +164,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
> > >   }
> > >   static
> > > -void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> > > +void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
> > >   {
> > >   	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
> > >   	unsigned int idx;
> > > @@ -148,7 +173,39 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> > >   		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> > >   		/* Busy-wait if node is found. */
> > > -		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != HAZPTR_WILDCARD); /* Load B */
> > > +		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
> > > +	}
> > > +}
> > > +
> > > +static
> > > +void hazptr_scan_period(void *addr, void *scan_wildcard)
> > > +{
> > > +	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
> > > +	int cpu;
> > > +
> > > +	/* Scan all CPUs slots. */
> > > +	for_each_possible_cpu(cpu) {
> > > +		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> > > +
> > > +		/*
> > > +		 * Scan CPU slots.
> > > +		 * Forward progress against recurring wildcards is guaranteed
> > > +		 * by scanning for one wildcard while new elements use the
> > > +		 * other wildcard value (1UL vs 2UL).
> > > +		 * Forward progress against recurring single hazard pointer
> > > +		 * values is guaranteed by the fact that a hazard pointer
> > > +		 * is not reclaimed nor reused until the scan for that hazard
> > > +		 * pointer completes, which prevents a steady flow of readers
> > > +		 * to acquire that same hazard pointer value.
> > > +		 */
> > > +		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> > > +
> > > +		/*
> > > +		 * Scan backup slots in percpu overflow lists.
> > > +		 * Forward progress is guaranteed by scanning one list
> > > +		 * while new elements are added into the other list.
> > > +		 */
> > > +		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
> > >   	}
> > >   }
> > > @@ -161,7 +218,7 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> > >    */
> > >   void hazptr_synchronize(void *addr)
> > >   {
> > > -	int cpu;
> > > +	void *scan_wildcard;
> > >   	/*
> > >   	 * Busy-wait should only be done from preemptible context.
> > > @@ -177,33 +234,19 @@ void hazptr_synchronize(void *addr)
> > >   		return;
> > >   	/* Memory ordering: Store A before Load B. */
> > >   	smp_mb();
> > > -	/* Scan all CPUs slots. */
> > > -	for_each_possible_cpu(cpu) {
> > > -		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> > > -		unsigned int scan_idx;
> > > -
> > > -		/* Scan CPU slots. */
> > > -		hazptr_synchronize_cpu_slots(cpu, addr);
> > > -		/*
> > > -		 * Scan backup slots in percpu overflow lists.
> > > -		 * Forward progress is guaranteed by scanning one list
> > > -		 * while new elements are added into the other list.
> > > -		 */
> > > -		guard(mutex)(&overflow_list_flip->lock);
> > > -		scan_idx = overflow_list_flip->add_idx ^ 1;
> > > -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
> > > -		/* Flip current list. */
> > > -		WRITE_ONCE(overflow_list_flip->add_idx, scan_idx);
> > > -		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx ^ 1], addr);
> > > -	}
> > > +	guard(mutex)(&hazptr_wildcard_lock);
> > > +	scan_wildcard = flip_wildcard(hazptr_wildcard);
> > > +	hazptr_scan_period(addr, scan_wildcard);
> > > +	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
> > > +	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
> > >   }
> > >   EXPORT_SYMBOL_GPL(hazptr_synchronize);
> > >   struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
> > >   {
> > >   	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
> > > -	unsigned int list_idx = READ_ONCE(overflow_list_flip->add_idx);
> > > +	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;
> > 
> > 
> > What if this happens?
> > 
> > 	{ <hazptr_wildcard == 2UL> }
> > 
> > 	CPU 0				CPU 1
> > 	=====				=====
> > 	hazptr_acquire(ctx, &gp):
> > 	  WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> > 	  // slot->addr == 2
> > 	  smp_mb();
> > 
> > 	  addr = READ_ONCE(*addr_p);      /* Load A */
> > 	  // ^ addr == gp == old, i.e not NULL
> > 
> > 	  				/* unpublish and wait for reader */
> > 	  				old = gp;
> > 	  				WRITE_ONCE(gp, NULL);
> > 					hazptr_synchronize(old):
> > 					  smp_mb();
> > 					  guard(mutex)(&hazptr_wildcard_lock);
> > 					  scan_wildcard = flip_wildcard(hazptr_wildcard);
> > 					  // ^ scan_wildcard == 1;
> > 
> > 					  hazptr_scan_period(addr, scan_wildcard);
> > 					  // ^ will miss reader on CPU 0
> > 					  // because its slot->addr == 2
> >                                            WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
> > 
> > 	{ <hazptr_wildcard == 1UL> }
> > 
> > 	  WRITE_ONCE(slot->addr, addr);
> > 
> > 	hazptr_detach():
> > 	  hazptr_chain_backup_slot():
> > 	    list_idx = READ_ONCE(hazptr_wildcard) - 1;
> > 	    // ^ list_idx == 0
> > 
> > 	  smp_store_release(&slot->addr, NULL);
> >            // ^ clear the per-CPU slot
> > 	    				  // flip_wildcard(scan_wildcard) == 2
> >                                            hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
> > 					  // ^ will miss reader on CPU 0
> > 					  // because it only scans list
> > 					  // 1.
> > 
> > If I'm not missing anything, then it means a reader can dodge the
> > hazptr_synchronize() scan, because its per-CPU slot can appear on
> > wildchard=1 but its backup slot can be on wildcard=2.
> 
> The scenario presented here includes a call to hazptr_detach,
> which moves the slot to the backup list, which is handled by

But the slot move happens between the two scans in one
hazptr_synchronize(), so it's moved to the scan list 0 instead of 1,
after we already finished the the scan of list 0, no? That's why the
scan can miss it.

> hazptr_synchronize() _after_ scanning the per-cpu slots
> for address and both wildcard values. So the synchronize
> algorithm on the right column should be completed to show the
> role of the backup slot handling as well.
> 

I don't think I see the enough explanantion here, maybe you can
elaborate more? Especially when the hazptr_detach() happens in-between
these two hazptr_scan_period()?

Regards,
BOqun

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > Thoughts?
> > 
> > Regards,
> > Boqun
> > 
> > >   	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
> > >   	struct hazptr_slot *slot = &ctx->backup_slot.slot;
> > > @@ -233,7 +276,6 @@ void __init hazptr_init(void)
> > >   	for_each_possible_cpu(cpu) {
> > >   		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> > > -		mutex_init(&overflow_list_flip->lock);
> > >   		for (int i = 0; i < 2; i++) {
> > >   			raw_spin_lock_init(&overflow_list_flip->array[i].lock);
> > >   			INIT_HLIST_HEAD(&overflow_list_flip->array[i].head);
> > > -- 
> > > 2.40.1
> > > 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
