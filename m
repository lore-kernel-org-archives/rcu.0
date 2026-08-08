Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D7032E13B;
	Sat,  8 Aug 2026 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211916; cv=none; b=BjmF5gCPVMDVpUd2WfCRzcAxjg7FSyZPQriqcCrLeI9cRyNoteJvgoPht2rv+tyQhR4jhUfgY5YSfXzejCaFyorc7pfAWRvyKWjtWj3+77fZ6b6n1Hnxdg43NCWVDLKcHLwFMrxsFND1hvSXViTyDg/CIzL0coQP6QG5OFacxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211916; c=relaxed/simple;
	bh=lBAvlktH3ryQ/dQTN0CKmUscpUCLUKoLOsBTslASPqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmEiE1SNijohVDeqHnnwJZPhQXTkQSVYrnZ9Qyqpe3VVJAUYwcnTorFhs16iZEhe7pur/9jSAdF/tWNh3MCV17qwqYO8Jm/QncCg1vY8wlHennhHAVgTeskEItzw2ueqSWSt2Zdb9bFkaoa8ZT9ZcgMcpt4h0zme/eJN2phGBbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBSYxX4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBSYxX4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B9B1F000E9;
	Sat,  8 Aug 2026 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786211914;
	bh=VPo1MDHiQ1uSSwehVN71+vKqLv3kXGLDI5qliHB5zCs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=WBSYxX4Fkyv5E1wvkuydvAzTYKrFSMCwfkDKVB8R0XkFUc7RQCJ14kZxoZm3sf8Oa
	 +yzlb07Yedr8BNfxlus2yxg8WUT/mktrzYBl1a27Bc+s5pkD1JCRJUtwtNqPfGhXtW
	 XEqNnhsV2yW5emdwhacMDrFQvJKMFXCD8vxf0gJ9MLFSdKVXt5myY85t3ekth6rShX
	 /qVEaCOYQW31ZbVMLPDz10tPYqf+DXy3Z+bpdkbqGTAxgXM67HTRawIsCEOuzeGbXy
	 MoSZofIQTkDoJcm7B/Fsy8tAQnV0eVekLxT79EcFjdpOaWRQ1Cl0tjzOaxp28F5k3q
	 Q0+r67FrlAdnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6F683CE1AD0; Sat,  8 Aug 2026 10:58:34 -0700 (PDT)
Date: Sat, 8 Aug 2026 10:58:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Boqun Feng <boqun@kernel.org>,
	kvm@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Message-ID: <0d483855-4d2f-4502-858c-c88077aa0b94@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260805195528.3853473-4-dwmw@amazon.co.uk>
 <20260805203608.D3CA61F000E9@smtp.kernel.org>
 <anS8C4Cxqy6ehCo3@google.com>
 <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
 <7dbe2929b5e7be6a2b9de860649598403d52f9a9.camel@infradead.org>
 <31e9a043-7d4b-40f3-8fdb-62701b730c5d@paulmck-laptop>
 <9E3BF4F1-EB01-48DC-9DC3-6780EDE06CC2@infradead.org>
 <3da4c9d6-39ae-4cf4-8d79-9661968f7f7c@paulmck-laptop>
 <4a8c82b27972f9dda156aede0fb352d58fa66db7.camel@infradead.org>
 <ad7269a90e5215f43a024d2a332b92fdb521a0e9.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad7269a90e5215f43a024d2a332b92fdb521a0e9.camel@infradead.org>

On Sat, Aug 08, 2026 at 11:09:41AM +0100, David Woodhouse wrote:
> On Sat, 2026-08-08 at 08:09 +0100, David Woodhouse wrote:
> > 
> > As I was reading through, I was landing on "combine #4 and #1": use
> > GFP_NOWAIT unconditionally, but on failure trigger a workqueue to
> > allocate that memory in a clean environment.

By the way, good point on all the SRCU instances sharing a common
set of workqueues.  More ways to deadlock!  But I don't see having
per-srcu_struct sets of dedicated kthreads.  ;-)

> In fact, why even do that as a fallback? This allocation is *literally*
> one size fits all, isn't it? The size depends on rcu_num_nodes which is
> a boot-time constant.
> 
> Just allocate it in *advance* from a safe context, and have
> init_srcu_struct_nodes() consume the preallocated one. And if a second
> init_srcu_struct_nodes() runs before it can be replenished, *then* fall
> back to a direct GFP_NOWAIT allocation.
> 
> We'd probably want to take a look at the early boot path, but
> GFP_KERNEL is effectively GFP_NOWAIT at that point anyway —
> gfp_allowed_mask strips __GFP_RECLAIM until well after srcu_init() has
> run.
> 
> Something like this, perhaps...

This does look like a reasonable approach, though the thought of having
something like this surrounding many memory allocations throughout the
kernel is not a happy one.

Nevertheless, given the current state, it is not at all bad.

A few questions and comments below...

							Thanx, Paul

> From: David Woodhouse <dwmw@amazon.co.uk>
> Date: Sat, 8 Aug 2026 11:01:52 +0100
> Subject: [PATCH] srcu: Keep a spare node array so srcu_gp_end() need not allocate
> 
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
> lazy (contention-triggered) sizing is in effect, and have
> init_srcu_struct_nodes() consume it with xchg(). The consumer kicks a
> replenish worker on system_wq (a clean context where GFP_KERNEL is
> safe); if a second transition races ahead of the replenish, the
> GFP_NOWAIT fallback keeps today's benign fail-and-retry behaviour,
> now with no possibility of blocking the grace-period workqueue in
> reclaim.
> 
> The init-time paths (init_srcu_struct_fields() and boot) also flow
> through srcu_alloc_nodes() and may consume the spare; that is
> harmless, as the replenish worker refills it.

True, but shouldn't we take as much pressure off of the spare as we can
so that it will be there for us when we really need it.

> Not-yet-tested-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Assisted-by: Claude:claude-mythos-5
> ---
>  kernel/rcu/srcutree.c | 64 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7c2f7cc131f7..914a0574dce2 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -123,6 +123,51 @@ static inline bool srcu_invl_snp_seq(unsigned long s)
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
> + * queued behind this allocation. Consuming a preallocated array instead
> + * keeps the grace-period path allocation-free; the spare is replenished
> + * from a clean context on system_wq, and a direct GFP_NOWAIT attempt
> + * remains as the fallback if a second transition wins the race for the
> + * spare before it can be replenished.
> + */
> +static struct srcu_node *srcu_spare_nodes;
> +
> +static void srcu_spare_replenish_wq(struct work_struct *work)
> +{
> +	struct srcu_node *spare;
> +
> +	spare = kzalloc_objs(*spare, rcu_num_nodes, GFP_KERNEL);
> +	if (!spare)
> +		return;
> +	if (cmpxchg(&srcu_spare_nodes, NULL, spare))

Mightn't !try_cmpxchg() be a better fit here?  You are using the returned
pointer as a boolean anyway.  (One could also argue for xchg(), but why
unnecessarily write to that poor cache line?)

Of course, we get here only if two different SRCU workqueue handlers
both see a NULL srcu_spare_nodes, and one of the is delayed so that its
schedule_work() call follows the other's completion of its workqueue
handler.  So low probability, right?  (Otherwise, I would suggest a
check of srcu_spare_nodes before doign the initial kzalloc_objs().)

> +		kfree(spare);	/* Someone else refilled it first. */
> +}
> +static DECLARE_WORK(srcu_spare_replenish_work, srcu_spare_replenish_wq);
> +
> +static struct srcu_node *srcu_alloc_nodes(gfp_t gfp_flags)
> +{
> +	struct srcu_node *node;
> +

Why not do a "GFP_NOWAIT | __GFP_NOWARN" attempt before raiding
srcu_spare_nodes?  Wouldn't that increase the probability that there
would be an srcu_node array available when someone really needed it?

Yes, I do see that schedule_work(), but that can involve significant
delays if the system is under any sort of pressure, right?

> +	node = xchg(&srcu_spare_nodes, NULL);
> +	if (node) {
> +		schedule_work(&srcu_spare_replenish_work);
> +		return node;
> +	}
> +
> +	/* Spare already taken and not yet replenished. */
> +	return kzalloc_objs(*node, rcu_num_nodes, gfp_flags);

And the across-SRCU shared-workqueue deadlock that you pointed out is
avoided because the only way that gfp_flags is set to GFP_KERNEL is when
the caller is supplying its own task, correct?

> +}
> +
>  /*
>   * Allocated and initialize SRCU combining tree.  Returns @true if
>   * allocation succeeded and @false otherwise.
> @@ -139,8 +184,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
>  
>  	/* Initialize geometry if it has not already been initialized. */
>  	rcu_init_geometry();
> -	ssp->srcu_sup->node = kzalloc_objs(*ssp->srcu_sup->node, rcu_num_nodes,
> -					   gfp_flags);
> +	ssp->srcu_sup->node = srcu_alloc_nodes(gfp_flags);
>  	if (!ssp->srcu_sup->node)
>  		return false;
>  
> @@ -1004,7 +1048,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>  	/* Transition to big if needed. */
>  	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
>  		if (ss_state == SRCU_SIZE_ALLOC)
> -			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> +			init_srcu_struct_nodes(ssp, GFP_NOWAIT | __GFP_NOWARN);
>  		else
>  			smp_store_release(&sup->srcu_size_state, ss_state + 1);
>  	}
> @@ -2111,6 +2155,20 @@ void __init srcu_init(void)
>  		}
>  	}
>  
> +	/*
> +	 * Prime the spare node array if lazy (contention-triggered) size
> +	 * transitions are possible, so that srcu_gp_end() never needs to
> +	 * allocate. Early-boot GFP_KERNEL is implicitly non-blocking
> +	 * (gfp_allowed_mask strips __GFP_RECLAIM until much later), and
> +	 * failure here is harmless: the GFP_NOWAIT fallback and replenish
> +	 * worker remain.
> +	 */
> +	if (SRCU_SIZING_IS_CONTEND() || SRCU_SIZING_IS_TORTURE()) {
> +		rcu_init_geometry();

And this is early boot, which means that there is only one CPU with
interrupts off, thus rcu_init_geometry() is idempotent, so OK.

> +		srcu_spare_nodes = kzalloc_objs(*srcu_spare_nodes,
> +						rcu_num_nodes, GFP_KERNEL);
> +	}
> +
>  	/*
>  	 * Once that is set, call_srcu() can follow the normal path and
>  	 * queue delayed work. This must follow RCU workqueues creation
> -- 
> 2.43.0
> 


