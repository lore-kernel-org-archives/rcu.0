Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701B494A10
	for <rcu@vger.kernel.org>; Mon, 28 Sep 2026 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587676; cv=none; b=JiDf0qc4B46PoFC52mJIrod2Guz9932Z9POrQaLYeTeIbjD0Xwk6VARLimX6aFH5SWIRSE6ygj9bZhryA4W+AmpHHDEE1pQy8Xdh6sExzKVUttsoauruYdAeg1g8ROmZfMQfBKjJM71LqOgcMkm+xm+XMactOpxTmKebxClc+gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587676; c=relaxed/simple;
	bh=cU7l2FxcObjimnZxenpEC6GesaHmJossHdR6O/FICG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aoqnyn28tKJtr8l9HUKA7DEEio4JuaHxdFxeLPxMxmX6j6vFU0aqNV9cW8tK4cpUF7prtCRRYLEUf5L4lDuNaSyqcPFxHiYETCzIps1WoW6e0BKsIWpRMrCMxSmjNmAPYLQCQ4GxYVDCgwWM+JXSN1xygsVd4ZBieqKKwvkS/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfyTCRqP; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfyTCRqP"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f38so11925125ad.2
        for <rcu@vger.kernel.org>; Mon, 28 Sep 2026 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790587671; x=1791192471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rlyafDsCl1IhrAGqeARNosjMhSOS/EQ/6GJ4TIEqlYs=;
        b=FfyTCRqPxA10i3427/rpvOahNiK2akEEkaYfE53pNKA4QErEmIqZi3cVp0QMq2RN0Z
         ajze5u3sL0pN//hEaNGPxtBYrcNF370W3abGRzDQUZCBgOGOeybhPvIRppblGWaLByMc
         7prM4VVKVUoZFAsxijrGOHn4qoupsSVaNIKZq+Bli73TLDb96Iyw508qwItbqCflYhDK
         OGVKZbz2VpRHtN5tXZQ2yWPXBsBGGI+CitD4v0C0YDsy2J66uGQWWGAyHZn1uySEzIyT
         GhuRZk5mnJ74pr4peHUnrPFcdAZr22KBcV34+Wo1xTfKL262OJdoIzsl7IpdhMcLgpC9
         hYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587671; x=1791192471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rlyafDsCl1IhrAGqeARNosjMhSOS/EQ/6GJ4TIEqlYs=;
        b=tffBk5Va/1fHZl6cUc1BA/6KzF/cp5o2TnA4dbPQqTyp+96lVrfhkl16R66VVmjqBV
         K18Xwm6OPpnDP/NOQFpkgcx6TgWkDpx8qX9HfniyGDsY8i1J72zSQ9HKJVtxxR7KPCuZ
         DXxKZzIYTk6pl/umtoSYgqZ8VG3B/K2fDQAxLzTl9ZChKnToNpAzP/5EQRmu4P2xWJCH
         qFiGfCNcv7guCotw9rzIRgID4GRctVn9gytOPpVTxImsdvYF2pz0A+FQ38sXZHeMrML9
         Y4AOMYc33Mo5lVtaYeIbaY5jCDs1b59MioE4LHlRLFv6kTS+MDfDj9H80MD5V5t94fX3
         su9g==
X-Forwarded-Encrypted: i=1; AKwUvBx8x03WHnJu8T3dJdD3Bhk2jRWqi1yduh9AW5zazIuyW17+0CJ4NNyeUtQ+KQY6yglzwn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL964NYudxPROQSc0GC4z9RF1jHc9rnKoAQ2yXwZmIKLUN+N7mz
	oKMu7V6QXCOdai5wff2mnxa+3gGve1HfPXG66HAeoUGJN86gpbDy4WCG
X-Gm-Gg: AYBFou1IArFscdQ+Rczs6kRF8nsp/S1yTjo0W9P2q4GZ9Ajp1/dTCYRF7ZUvf+v+VM3
	yig+OkScMWBHssBTFSk0IfLIl16MMJWWpeISWXcQsYAZ4xFkmPKqyzem12GVKuOKBUEsfS+l84s
	9axoz8pJJYTPWQuD4lAKKEdbEDfGIyjrOzeYaVUUV0Iisu5XvVhJyfNay2o1k2TkYMYhRJAxxJC
	xa4qUOF8sLp7NnRGBuE3HFNvuElrYzADhMXJfKTWdtYr5zbOfnnIz4TM6BzveELKAep2drjjRPF
	Ozsg8bfryzpJclYsBUtJ6+2/3qNAwivN0tSEjRro5DxlorOcrTXHBafVYEarypcdBCl974JcOoj
	2s/xs8w9uEUuRzLykhF9ITSXlAqkb376zQ3T3dVCpEp0L3ics4R9F5aAgwqnkvKaXcj/NSWPRmC
	3D2aLPic+vLxUkFGYPOA4ZBpdU6Ps4m9ibBfs8QRktGNsboCHOG2wPfku4Pf/irdez/4kUag==
X-Received: by 2002:a17:902:fd8e:b0:2df:84e0:9034 with SMTP id d9443c01a7336-2df84e09909mr98438105ad.7.1790587670824;
        Mon, 28 Sep 2026 02:27:50 -0700 (PDT)
Received: from gmail.com ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913e0ad0sm38657125ad.21.2026.09.28.02.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:50 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Kunwu Chan <kunwu.chan@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path, fallback to overflow list
Date: Mon, 28 Sep 2026 17:27:40 +0800
Message-ID: <20260928092741.604366-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arlHFVT5EzcX4d1-@MacBook-0RXW5>
References: 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 18:40:53 +0200 Boqun Feng <boqun@kernel.org> wrote:

> On Sun, Sep 27, 2026 at 11:51:31AM -0400, Mathieu Desnoyers wrote:
> > Introduce a "try acquire" hazard pointer fast path, which performs an
> > early load of the address to store it into the hazard pointer slot, and
> > then re-loads that address after a barrier to check whether it has
> > changed meanwhile.
> > 
> > On comparison failure, rather than re-try, guarantee forward progress by
> > falling back to the __hazptr_acquire slow path on failure.
> > 
> > The acquire slow path attempts a try-acquire for any available per-CPU
> > slot. If that fails, it chains the backup slot into the overflow list,
> > therefore guaranteeing forward progress for both hazard pointer
> > read-side and synchronize:
> > 
> > - Readers set the wildcard, and then proceed to set the more
> >   specific address to replace the wildcard.
> > 
> > - One synchronize alternates between two overflow list periods,
> >   scanning each one while readers are added to the other period,
> >   thus preventing a steady flow of readers from preventing
> >   synchronize forward progress.
> > 
> > With this change, the scan on per-CPU slots don't need to expect a
> > wildcard anymore, because none can be produced by readers. Wildcards are
> > only expected within overflow lists.
> > 
> 
> Ok, I was missing something, but I think it's better to call it out.
> Wildcards can only exist in the overflow lists when the context is not
> preemptible. In other words, there won't be a preempted readers blocking
> the synchronize_hazptr() with a wilcard in the overflow list.
> 
> So no more design trade-off question from me :)
> 
> Regards,
> Boqun
> 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun@kernel.org>
> > Cc: Bradley Morgan <brads@mainlining.org>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: <rcu@vger.kernel.org>
> > Cc: <lkmm@lists.linux.dev>
> > ---
> >  include/linux/hazptr.h |  47 +++++++++++--------
> >  kernel/hazptr.c        | 103 ++++++++++++++++++++---------------------
> >  2 files changed, 76 insertions(+), 74 deletions(-)
> > 
> > diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> > index d1670121947a..fcf017ca2255 100644
> > --- a/include/linux/hazptr.h
> > +++ b/include/linux/hazptr.h
> > @@ -29,9 +29,6 @@
> >  /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
> >  #define NR_HAZPTR_PERCPU_SLOTS	4
> >  
> > -/* The current hazard pointer wildcard. */
> > -extern void *hazptr_wildcard;
> > -
> >  /*
> >   * Hazard pointer slot.
> >   */
> > @@ -190,6 +187,31 @@ void hazptr_note_context_switch(void)
> >  	}
> >  }
> >  
> > +/* Try hazard pointer protection. */
> > +static inline
> > +void *__hazptr_try_acquire(struct hazptr_ctx *ctx, void * const *addr_p, struct hazptr_slot *slot)
> > +{
> > +	void *early_addr, *addr;
> > +
> > +	if (unlikely(slot->addr))
> > +		return NULL;
> > +	early_addr = READ_ONCE(*addr_p);	/* Early load. */
> > +	WRITE_ONCE(slot->addr, early_addr);	/* Store B */
> > +	/* Memory ordering: Store B before Load A. */
> > +	smp_mb();
> > +	addr = READ_ONCE(*addr_p);		/* Load A */
> > +	/*
> > +	 * Validate that address did not change between Early load and Load A.
> > +	 * Use ptr_eq() to make sure that result from Load A is returned to the
> > +	 * caller to preserve address dependency.
> > +	 */
> > +	if (unlikely(!ptr_eq(addr, early_addr))) {
> > +		WRITE_ONCE(slot->addr, NULL);
> > +		return NULL;
> > +	}
> > +	return addr;
> > +}
> > +
> >  /**
> >   * hazptr_acquire - Load pointer at address and protect with hazard pointer.
> >   *
> > @@ -245,24 +267,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> >  	ctx->acquire_cpu = smp_processor_id();
> >  	ctx->acquire_caller = _THIS_IP_;
> >  #endif
> > -	if (unlikely(slot->addr))
> > +	addr = __hazptr_try_acquire(ctx, addr_p, slot);
> > +	if (unlikely(!addr))
> >  		return __hazptr_acquire(ctx, addr_p);
> > -	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> > -
> > -	/* Memory ordering: Store B before Load A. */
> > -	smp_mb();
> > -
> > -	/*
> > -	 * Load @addr_p after storing wildcard to the hazard pointer slot.
> > -	 */
> > -	addr = READ_ONCE(*addr_p);	/* Load A */
> > -
> > -	/*
> > -	 * We don't care about ordering of Store C. It will simply
> > -	 * replace the wildcard by a more specific address. If addr is
> > -	 * NULL, we simply store NULL into the slot.
> > -	 */
> > -	WRITE_ONCE(slot->addr, addr);	/* Store C */
> >  	slot_item->ctx.ctx = ctx;
> >  	ctx->slot = slot;
> >  	return addr;
> > diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> > index 13faa5ba7677..3ca73b56a5c2 100644
> > --- a/kernel/hazptr.c
> > +++ b/kernel/hazptr.c
> > @@ -13,17 +13,9 @@
> >  #include <linux/list.h>
> >  #include <linux/export.h>
> >  
> > -static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the wildcard and list phase flip. */
> > +#define HAZPTR_WILDCARD	((void *) 1UL)
> >  
> > -/*
> > - * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
> > - * hazptr_synchronize forward progress even with a steady stream of readers.
> > - * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
> > - * This also affects the overflow list selection: the current list used by
> > - * readers is array[(unsigned long) hazptr_wildcard - 1].
> > - */
> > -void *hazptr_wildcard = (void *) 1UL;
> > -EXPORT_SYMBOL_GPL(hazptr_wildcard);
> > +static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the list phase flip. */
> >  
> >  /* The current overflow list phase. */
> >  static unsigned int hazptr_overflow_list_phase;
> > @@ -41,6 +33,10 @@ struct hazptr_overflow_list {
> >   * successively iterates on both lists. Therefore, only list removals
> >   * can cause the iteration to retry, and the number of removals is
> >   * limited to the number of list elements.
> > + *
> > + * Due to the overflow list raw spin lock, the hazard pointer readers are
> > + * blocking, starvation-free with bounded waiting, assuming bounded critical
> > + * sections and no NMI or virtualization-induced holder preemption.
> >   */
> >  struct hazptr_overflow_list_flip {
> >  	struct hazptr_overflow_list array[2];
> > @@ -51,26 +47,12 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
> >  DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
> >  EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
> >  
> > -static
> > -void *flip_wildcard(void *wildcard)
> > -{
> > -	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
> > -}
> > -
> >  static
> >  unsigned int flip_list_phase(unsigned int phase)
> >  {
> >  	return 1 - phase;
> >  }
> >  
> > -static
> > -bool is_wildcard(void *addr)
> > -{
> > -	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
> > -		return true;
> > -	return false;
> > -}
> > -
> >  static
> >  struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> >  {
> > @@ -96,16 +78,36 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> >   */
> >  void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> >  {
> > -	struct hazptr_slot *slot = hazptr_get_free_percpu_slot(ctx);
> > +	struct hazptr_slot *slot;
> >  	void *addr;
> >  
> >  	/*
> > -	 * If all the per-CPU slots are already in use, fallback
> > -	 * to the backup slot.
> > +	 * In case we are called due to nested use of hazard pointers,
> > +	 * try a slot protection with per-CPU slots.
> >  	 */
> > -	if (unlikely(!slot))
> > -		slot = hazptr_chain_backup_slot(ctx);
> > -	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
> > +	slot = hazptr_get_free_percpu_slot(ctx);
> > +	if (likely(slot)) {
> > +		addr = __hazptr_try_acquire(ctx, addr_p, slot);
> > +		if (addr) {
> > +			ctx->slot = slot;
> > +			return addr;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * The backup slot overflow list guarantees forward progress of both
> > +	 * hazard pointer readers and synchronize:
> > +	 *
> > +	 * - Readers set the wildcard, and then proceed to set the more
> > +	 *   specific address to replace the wildcard.
> > +	 *
> > +	 * - One synchronize alternates between two overflow list periods,
> > +	 *   scanning each one while readers are added to the other period,
> > +	 *   thus preventing a steady flow of readers from preventing
> > +	 *   synchronize forward progress.
> > +	 */
> > +	slot = hazptr_chain_backup_slot(ctx);
> > +	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> >  
> >  	/* Memory ordering: Store B before Load A. */
> >  	smp_mb();
> > @@ -121,20 +123,21 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> >  	 * NULL, we simply store NULL into the slot.
> >  	 */
> >  	WRITE_ONCE(slot->addr, addr);	/* Store C */
> > +
> >  	ctx->slot = slot;
> > -	if (!addr && hazptr_slot_is_backup(ctx, slot))
> > +	if (!addr)
> >  		hazptr_unchain_backup_slot(ctx);
> >  	return addr;
> >  }
> >  EXPORT_SYMBOL_GPL(__hazptr_acquire);
> >  
> >  /*
> > - * Perform piecewise iteration on overflow list waiting until "addr" is
> > - * not present. Raw spinlock is released and taken between each list
> > - * item and busy loop iteration. The overflow list generation is checked
> > - * each time the lock is taken to validate that the list has not changed
> > - * before resuming iteration or busy wait. If the generation has
> > - * changed, retry the entire list traversal.
> > + * Perform piecewise iteration on overflow list waiting until "addr" and
> > + * wildcard are not present. Raw spinlock is released and taken between each
> > + * list item and busy loop iteration. The overflow list generation is checked
> > + * each time the lock is taken to validate that the list has not changed before
> > + * resuming iteration or busy wait. If the generation has changed, retry the
> > + * entire list traversal.
> >   */
> >  static
> >  void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list, void *addr)
> > @@ -147,13 +150,11 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
> >  retry:
> >  	snapshot_gen = overflow_list->gen;
> >  	hlist_for_each_entry(backup_slot, &overflow_list->head, overflow_node) {
> > -		/* Busy-wait if node is found. */
> > +		/* Busy-wait if addr or wildcard are found. */
> >  		for (;;) {
> >  			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
> >  
> > -			/* We don't expect wildcards in overflow list. */
> > -			WARN_ON_ONCE(is_wildcard(load_addr));
> > -			if (load_addr != addr)
> > +			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
> >  				break;
> >  			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
> >  			cpu_relax();
> > @@ -174,7 +175,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
> >  }
> >  
> >  static
> > -void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
> > +void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> >  {
> >  	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
> >  	unsigned int idx;
> > @@ -182,13 +183,13 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
> >  	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> >  		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> >  
> > -		/* Busy-wait if node is found. */
> > -		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
> > +		/* Busy-wait if addr is found. */
> > +		smp_cond_load_acquire(&item->slot.addr, VAL != addr); /* Load B */
> >  	}
> >  }
> >  
> >  static
> > -void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> > +void hazptr_scan_cpu_slots(void *addr)
> >  {
> >  	int cpu;
> >  
> > @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> >  	for_each_possible_cpu(cpu) {
> >  		/*
> >  		 * Scan CPU slots.
> > -		 * Forward progress against recurring wildcards is guaranteed
> > -		 * by scanning for one wildcard while new elements use the
> > -		 * other wildcard value (1UL vs 2UL).
> >  		 * Forward progress against recurring single hazard pointer
> >  		 * values is guaranteed by the fact that a hazard pointer
> >  		 * is not reclaimed nor reused until the scan for that hazard
> >  		 * pointer completes, which prevents a steady flow of readers
> >  		 * to acquire that same hazard pointer value.
> 
> (Not a comment to this patch, but I think it's worth bringing up)
> 
> I want to point out this is not true for the lockdep use case, because
> the we need to protect a hash list deletion there, and we use the
> address of the hash bucket there. It's proven fine in practice because
> the readers are rare (we only call the reader is_dynamic_key() in
> register_lock_class(), that is every time you have a new lock class to
> register).
> 
> Maybe what we want to say here is that "if the users guarantee no steady
> flow of the same hazard pointer value, we guarantee forward progress".
> Thoughts?

Thanks Mathieu, and thanks Boqun for the review.

I hit the same ordering requirement in the shared-scan
implementation I'm working on. hazptr_promote_to_backup_slot()
links the backup slot into the overflow list before clearing the
per-CPU slot, so the scan has to cover all per-CPU slots before
the overflow lists. My series carries the same ordering fix in
the scan-kthread path.

For the lockdep case, I've tested the conversion with the
wq_churn/LOCKDEP torture scenario and PROVE_LOCKING enabled.
The hazard pointer is the hash bucket address there, so I agree
that the forward-progress guarantee should be stated conditional
on there being no steady flow of the same hazard pointer value.

I'm also working on the scan-thread side, where concurrent
hazptr_synchronize() callers share one scan cycle, based on 
the scan-kthread approach from your shazptr series [1].                                                 
[1] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/

The v2 series is testing, I'll include the rcuscale results 
in the cover letter.

Thanks,
Kunwu

> 
> The rest looks good to me.
> 
> Regards,
> Boqun
> 
> >  		 */
> > -		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
> > +		hazptr_synchronize_cpu_slots(cpu, addr);
> >  	}
> >  }
> >  
> > @@ -237,7 +235,6 @@ void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
> >  void hazptr_synchronize(void *addr)
> >  {
> >  	unsigned int scan_list_phase;
> > -	void *scan_wildcard;
> >  
> >  	/*
> >  	 * Busy-wait should only be done from preemptible context.
> > @@ -251,16 +248,14 @@ void hazptr_synchronize(void *addr)
> >  	 */
> >  	if (!addr)
> >  		return;
> > +
> >  	/* Memory ordering: Store A before Load B. */
> >  	smp_mb();
> >  
> >  	guard(mutex)(&hazptr_phase_lock);
> >  
> >  	/* Scan per-CPU slots. */
> > -	scan_wildcard = flip_wildcard(hazptr_wildcard);
> > -	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
> > -	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
> > -	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
> > +	hazptr_scan_cpu_slots(addr);
> >  
> >  	/*
> >  	 * Scan overflow lists *after* scanning per-CPU slots. See
> > -- 
> > 2.43.0
> > 
> 

