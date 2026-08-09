Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FBC248F57
	for <rcu@vger.kernel.org>; Sun,  9 Aug 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289060; cv=none; b=YESOCtRkeqhPn90GuOgdKKbuDh7n2s121mOA0wON+MGf1R9rx8GAyDuuW+WKcjOp36uPDzAIjvtVqT2PxJouxuBcMh2CCWHYWJ304Hz8f12tm00RyUffouJ7nLgrPKFHaKjNcCJ7ehejUJuhxtCA6pIZqz26XNIrDTKJNVmXB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289060; c=relaxed/simple;
	bh=pd671asCPrIM7AwKWSNQA+CXH2I7Aq8i3tofN+0aBOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv4AjCiLTOMlVH+0tMM1PW+tz+AxLND/jVAtUHMTIxzLbvtSXLcA+RLCHhc1bnfILfXlF9X4DwnV0+HmcNIymoL2Kf+0ji+DuWISuFC7PShUO1C2UNeq8mCvPkjGIJxDInY0S/HLc3CErcVDjIAlZN3NiwNOwYeT5wOsVWl+wxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n37Jj/OV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n37Jj/OV"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so1106355a12.2
        for <rcu@vger.kernel.org>; Sun, 09 Aug 2026 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786289057; x=1786893857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YCSY1KdqStovoDw2x1htHfbvgdCvirPIGBme1gB4ZDg=;
        b=n37Jj/OVdo/jB52PtcaFwoonz3gUWXrnKksP8s2qHzM5k7h4WZD58pP48MIT7go0xJ
         /E+iETL037XFP8FxYCej9HTmRw0aLXk7XtyZQkjnffgrhTxANktPDSORN2L/0M3ra6dk
         Awv/eX8VFs9+smB8pvdtB0dCSrpYpcctCdAIRE7Q8cIUvTErB6FfHr+QJAPqgyhScpaa
         scMsTVV3r/MP45d0Sox8lIHG/m3w5NpLYlOJbfPKNMolnFzghaO+JYDz4yK8QJ59H2UU
         3lDjpDPdIN+RRhrW9jaoSRUk2MkxEv1fJzn45zYR7RmgTu+7ondgMysBvcEMTgjYCgvo
         /iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786289057; x=1786893857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YCSY1KdqStovoDw2x1htHfbvgdCvirPIGBme1gB4ZDg=;
        b=L+lcfYvA3c3AjsU7GYWW3CvFc2iIiBrnROT8+OdP+rKj2H5LiLivp4RnvCDfLXN4yI
         O05fWce3txGY5bsW49mIvHpFajoiPuOGOP2fRY74yLIt54JE5DRmzcYAzOQ4Rpsw5uJ3
         P9pQKsbKrWdxvJGYYoo9ldlFGrpDdac3fFrXVN0KFcewLJAvmc6lNfNsEd4iw+O8bFdi
         hgBNxf23E2jl6s0YwpFwB/tr/eqnkZZOmKw7MgIVNa9svaSAEO6Xo8osn5SQuM06OK/H
         CIqwoKK9S9VyyDXSVVbe+5ch88dMMalnbNgGWCoUctZBIIPpwBFCTiEwHrKGBHtFD19R
         oJsw==
X-Forwarded-Encrypted: i=1; AHgh+RrIKMMQcC9o7gV37uvcUDeNZiQ61Cw0vzwTsJPDqx/X6dkQ/8XRDTzpTgN0PYadLfa1cvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8T/Q9TkEGA72uTVnmCJ4FL7VmbzFls/WbTt8M2Icb+PeGO3DZ
	FK0oaZlaQhAHnFf5yRNwL5oy7cbehqcuSPMPJtv2DpGIiWPfl2qnc858
X-Gm-Gg: AR+sD115g2/Cy2aKVupat6hWjwFMchnk47Ik4FHT6U5cJZwsFKJQGcrhnVKxCaxWPIb
	2ACiFasGAhCUIFx9u+FO6IjLZnofMN/apIDjwwl/6EtEW5aWhlLEMMEOHUzhWpzlKo+BuK52MFM
	PQnuju7FlCbRgdFRqbsSFDI0jqgcIHfPdXgr0vKBhfwUr+oJlhoQQLCOt7KbDDKsXLCi5Elull+
	ceCqvKF7m+3GhnZe3b63XofV6yO9P3OplgmTpzj/uOIZW1ifTHIvU0ynwVk4mMw4xbhxozRC/Tc
	YbGVdhpXXLq1sV81MboXGrYZxbQN+atseSNGClBsl7oCO8M8ahbQmDaQcZZc5/QJhITeUEaa04v
	TkKX7Stxn2lN4lal4/LIVrb1wI67Snk57cKaROvcZBNVY5dfvExWNnyRDCU62pZPu1HQpOWxLpy
	jY4C59ZXJQ0FsjkNWggWPSxkaRwQ==
X-Received: by 2002:a05:6402:278c:b0:6a1:23f3:26b7 with SMTP id 4fb4d7f45d1cf-6a14f13b783mr17145196a12.14.1786289056697;
        Sun, 09 Aug 2026 08:24:16 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d5aacesm3112416a12.21.2026.08.09.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:24:15 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Sun, 9 Aug 2026 17:24:14 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: paulmck@kernel.org, Sean Christopherson <seanjc@google.com>,
	Boqun Feng <boqun@kernel.org>, kvm@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Message-ID: <anibnhTYdwdn51FF@milan>
References: <0d483855-4d2f-4502-858c-c88077aa0b94@paulmck-laptop>
 <d0fdf8aa4faa4e349cdc0e051b6e211cddd566b0.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0fdf8aa4faa4e349cdc0e051b6e211cddd566b0.camel@infradead.org>

On Sun, Aug 09, 2026 at 10:59:59AM +0100, David Woodhouse wrote:
> On Sat, 2026-08-08 at 10:58 -0700, Paul E. McKenney wrote:
> > By the way, good point on all the SRCU instances sharing a common
> > set of workqueues.  More ways to deadlock!  But I don't see having
> > per-srcu_struct sets of dedicated kthreads.  ;-)
> 
> Indeed. Although I did briefly go down the rabbit hole of whether a
> *reader* sleeping in an allocation could compose into the same kind of
> cycle.
> 
> Conclusion: only if something on the reclaim path synchronizes the
> *same* srcu_struct that the reader holds — cross-domain it's only
> latency, since the GP state machine polls and requeues rather than
> capturing a worker. Which becomes a design rule for GPC usage:
> never allocate under srcu_read_lock(&kvm->gpc_srcu), because our
> invalidator *is* on the reaper path. But that's OK because allocating
> inside the existing GPC rwlock is already verboten.
> 
> > True, but shouldn't we take as much pressure off of the spare as we can
> > so that it will be there for us when we really need it.
> [...]
> > Why not do a "GFP_NOWAIT | __GFP_NOWARN" attempt before raiding
> > srcu_spare_nodes?  Wouldn't that increase the probability that there
> > would be an srcu_node array available when someone really needed it?
> 
> Makes sense. Done that way below: the GFP_NOWAIT attempt comes first,
> so in the common no-pressure case the spare is never touched and is
> guaranteed present under the memory pressure it exists for. That also
> makes the replenish latency mostly moot — it only matters after an
> allocation has already failed under pressure, and nothing ever waits on
> it.
> 
> > Mightn't !try_cmpxchg() be a better fit here?  You are using the returned
> > pointer as a boolean anyway.  (One could also argue for xchg(), but why
> > unnecessarily write to that poor cache line?)
> 
> Also done, plus a check of srcu_spare_nodes before the kzalloc as you
> suggested — the collision is indeed low-probability, but the check is
> free.
> 
> > And the across-SRCU shared-workqueue deadlock that you pointed out is
> > avoided because the only way that gfp_flags is set to GFP_KERNEL is when
> > the caller is supplying its own task, correct?
> 
> Right. After this patch the only GFP_KERNEL caller of
> init_srcu_struct_nodes() is init_srcu_struct() in the caller's own
> task, where blocking is permitted. srcu_gp_end() passes GFP_NOWAIT, so
> nothing on the grace-period workqueue can ever block in reclaim.
> 
> In the meantime, testing found some issues in my original conversion of
> the GPC code to RCU — dropping gpc->lock broke the atomicity of the
> final invalidation check against the publish, and the teardown paths
> could skip the grace period when an invalidation had already cleared
> the valid flag — re-breaking the syzbot thing I only just fixed, but
> for which thankfully I had a repro case right there ready to catch it
> :)
> 
> Both reworked: the valid/becoming-valid state now lives in a single
> atomic word, so the publish is a cmpxchg which an invalidation can
> veto. (My old needs_invalidation flag back again!). That's now ~30
> hours into a 48-hour KASAN+lockdep soak with no complaints, and syzbot
> is chewing on it too.
> 
> Tree with all of that plus this SRCU preallocation patch on top:
> 
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/xen-rcu-srcu-prealloc
> 
> Patch below. Still only compile-tested — my metal test hosts are
> over the big_cpu_lim threshold, so the lazy transition path this
> changes never executes there; testing it properly wants a small guest
> or big_cpu_lim= tweaking, which is on the list. But also it's a PITA to
> actually *trigger* the OOM reaper path anyway, and I've not actually
> managed it without hacking the kernel to introduce delays.
> 
> From: David Woodhouse <dwmw@amazon.co.uk>
> Subject: [PATCH] srcu: Keep a spare node array so srcu_gp_end() need not block
>  in reclaim
> 
> The one-time transition of an srcu_struct from SRCU_SIZE_SMALL to
> SRCU_SIZE_BIG allocates the srcu_node combining tree with GFP_KERNEL
> from srcu_gp_end(). That runs on the same workqueue which processes
> grace periods for every srcu_struct in the system — including grace
> periods awaited from OOM/reclaim contexts such as the OOM reaper
> calling synchronize_srcu() via an mmu_notifier. If the allocation
> blocks in direct reclaim, it can be waiting on the very OOM reaper
> whose grace period is queued behind it: a deadlock.
> 
> The allocation is literally one size fits all: it depends only on
> rcu_num_nodes, which is fixed once rcu_init_geometry() has run. So
> keep a single preallocated spare array, primed in srcu_init() when
> lazy (contention-triggered) sizing is in effect.
> 
> Allocation tries GFP_NOWAIT first, which in the common no-pressure
> case succeeds and leaves the spare untouched, so that it is still
> there when there really is pressure. Only when that fails is the
> spare consumed (with xchg(), so double-consumption is impossible),
> and the consumer kicks a replenish worker on system_wq — a clean
> context where GFP_KERNEL is safe and nothing waits on the result.
> The final fallback uses the caller's own flags: GFP_KERNEL only ever
> from init_srcu_struct() in the caller's own task, where blocking is
> permitted; srcu_gp_end() passes GFP_NOWAIT, preserving the guarantee
> that the grace-period workqueue never blocks in reclaim.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Assisted-by: Claude:claude-mythos-5
> ---
>  kernel/rcu/srcutree.c | 84 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7c2f7cc131f7..23911fa71c64 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -123,6 +123,71 @@ static inline bool srcu_invl_snp_seq(unsigned long s)
>  	return s == SRCU_SNP_INIT_SEQ;
>  }
>  
> +/*
> + * A standing spare srcu_node array. The size of the allocation depends
> + * only on rcu_num_nodes, which is fixed once rcu_init_geometry() has run,
> + * so one preallocated array fits every srcu_struct in the system.
> + *
> + * This exists because srcu_gp_end() may need to allocate the array when
> + * a size transition is triggered by contention, and srcu_gp_end() runs
> + * on the same workqueue for every srcu_struct — including grace periods
> + * awaited from OOM/reclaim contexts (e.g. the OOM reaper via an
> + * mmu_notifier). Blocking there in GFP_KERNEL reclaim can deadlock: the
> + * reclaim may be waiting on the very OOM reaper whose grace period is
> + * queued behind this allocation.
> + *
> + * The allocation therefore tries GFP_NOWAIT first — which in the common
> + * no-pressure case succeeds and leaves the spare untouched — and raids
> + * the spare only when that fails, i.e. under the memory pressure the
> + * spare exists for. The spare is replenished from a clean context on
> + * system_wq. Nothing on the grace-period path ever blocks in reclaim.
> + */
> +static struct srcu_node *srcu_spare_nodes;
> +
> +static void srcu_spare_replenish_wq(struct work_struct *work)
> +{
> +	struct srcu_node *spare, *expect = NULL;
> +
> +	if (READ_ONCE(srcu_spare_nodes))
> +		return;		/* Already refilled. */
> +
> +	spare = kzalloc_objs(*spare, rcu_num_nodes, GFP_KERNEL);
> +	if (!spare)
> +		return;
> +	if (!try_cmpxchg(&srcu_spare_nodes, &expect, spare))
> +		kfree(spare);	/* Someone else refilled it first. */
> +}
> +static DECLARE_WORK(srcu_spare_replenish_work, srcu_spare_replenish_wq);
> +
> +static struct srcu_node *srcu_alloc_nodes(gfp_t gfp_flags)
> +{
> +	struct srcu_node *node;
> +
> +	/*
> +	 * Try a non-blocking allocation first, leaving the spare untouched
> +	 * in the common no-pressure case so that it is still there when
> +	 * there really is pressure.
> +	 */
> +	node = kzalloc_objs(*node, rcu_num_nodes, GFP_NOWAIT | __GFP_NOWARN);
>
GFP_NOWAIT already contains __GFP_NOWARN. It is odd.

> +	if (node)
> +		return node;
> +
> +	node = xchg(&srcu_spare_nodes, NULL);
> +	if (node) {
> +		schedule_work(&srcu_spare_replenish_work);
>
I am not sure but if there is a need in doing progress forward, probably
separate wq with WQ_MEM_RECLAIM | WQ_UNBOUND flags is better. It has an
extra rescue kthread to do the progress if no memory or high mem-pressure.

> +		return node;
> +	}
> +
> +	/*
> +	 * Spare already taken and not yet replenished. Fall back to the
> +	 * caller's own flags: for init_srcu_struct() this is GFP_KERNEL in
> +	 * the caller's own task, where blocking is permitted; from
> +	 * srcu_gp_end() it is GFP_NOWAIT again, preserving the guarantee
> +	 * that the grace-period workqueue never blocks in reclaim.
> +	 */
> +	return kzalloc_objs(*node, rcu_num_nodes, gfp_flags);
> +}
> +
>  /*
>   * Allocated and initialize SRCU combining tree.  Returns @true if
>   * allocation succeeded and @false otherwise.
> @@ -139,8 +204,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>  
>  	/* Initialize geometry if it has not already been initialized. */
>  	rcu_init_geometry();
> -	ssp->srcu_sup->node = kzalloc_objs(*ssp->srcu_sup->node, rcu_num_nodes,
> -					   gfp_flags);
> +	ssp->srcu_sup->node = srcu_alloc_nodes(gfp_flags);
>  	if (!ssp->srcu_sup->node)
>  		return false;
>  
> @@ -1004,7 +1068,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>  	/* Transition to big if needed. */
>  	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
>  		if (ss_state == SRCU_SIZE_ALLOC)
> -			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> +			init_srcu_struct_nodes(ssp, GFP_NOWAIT | __GFP_NOWARN);
>
Same here.

--
Uladzislau Rezki
