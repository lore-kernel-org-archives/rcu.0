Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357E3672B0;
	Thu,  6 Aug 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053129; cv=none; b=cAwzJKPaBBIeyAkmec56K8T1FmMKCcKoAY2ISvd4fOVbWq++v2X3wWoSqGuLDnoxkrbejJO+5BOJkW5LzJu/I4FXg45bzAEoynciNeTmRe2CyrRJJRFOM/xbzRf7qBD2MAsQRVQTMOwc0bWuMdotY+rcjrLrAEYOsY5CwxF7jxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053129; c=relaxed/simple;
	bh=bHm7tPqqbCBEQHY3/tdCUmPG3EBvM5ITb/n6WdWjFBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPP6xk2t8rHm5ZWWavYBXtlko8iXzZV25e2WIzc0L3k2VvJY0KlJupxzjiDkzSekZweip/Wz50r9+VmtVfO2bIdf1FWHqcV1VLCEUIYkaSOGsZf7Adwnl2lfViskuI5wqGAnETKPqK5CauSuupF9NSmlaMTihDD7pE38u7D7jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itAbg8iN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itAbg8iN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E7F1F000E9;
	Thu,  6 Aug 2026 21:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786053127;
	bh=ZlGSKNo0J5TFuA1dSwO6QbUwOgWanrO/2tMeNn7pmYo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=itAbg8iN1Tv8CZ5kX+4yDW98dbPZCAtVLcVq62yQaVyPIeMmVsxZpn7CI8Ju6ls8A
	 f5IlgQE7toyDoeHPatWyciJUbtU2htnPjiQIBxXa0wkCHIwJAnBsYWUj8/qOhjcBIn
	 1UeP8JnzkSxfUZ7JF9A3Bxsaj1d94T5qRdP94b+YnRl/j4mDxlG9LUlGThBY7LAdpe
	 +MQ/AxbFeWa7kfNAyjxzYdlkiaozQ/DuhSMhNDeRLZMYAfJ8ejKo9C0qFz5bMEOgxF
	 FyHCcscmQV28jTdLu9JJZKrMRq9pEMnhpjS0213FWqEciPpoZpmkxGKLHh5Fz8VdAR
	 WxBPb3bvRuEfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCC40CE19F3; Thu,  6 Aug 2026 14:52:06 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:52:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Boqun Feng <boqun@kernel.org>,
	kvm@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Message-ID: <31e9a043-7d4b-40f3-8fdb-62701b730c5d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
 <20260805195528.3853473-4-dwmw@amazon.co.uk>
 <20260805203608.D3CA61F000E9@smtp.kernel.org>
 <anS8C4Cxqy6ehCo3@google.com>
 <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
 <7dbe2929b5e7be6a2b9de860649598403d52f9a9.camel@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dbe2929b5e7be6a2b9de860649598403d52f9a9.camel@infradead.org>

On Thu, Aug 06, 2026 at 10:38:56PM +0200, David Woodhouse wrote:
> On Thu, 2026-08-06 at 19:59 +0200, Woodhouse, David wrote:
> > On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
> > > On Wed, Aug 05, 2026, sashiko-bot@kernel.org wrote:
> > > > Replace the per-cache rwlock with RCU for the read side.
> > > 
> > > I don't hate the idea, but I am very against using RCU.  Unless it's "impossible",
> > > e.g. because synchronize_srcu() allocates memory and breaks OOM kill, I would
> > > strongly prefer to use SRCU, probably with a dedicated kvm->gpc_srcu, so that
> > > synchronization doesn't need to wait on all CPUs in the system.  The tail latencies
> > > for synchronize_rcu() are horrendous, especially for many-CPU systems.  If it
> > > were only mmu_notifiers that got hit, it miiiight be acceptable, but since this
> > > will affect vCPU tasks in the refresh() path as well, normal RCU is pretty much
> > > a non-starter.
> > 
> > Yeah, the refresh() path got pretty slow in my first attempt, before
> > optimising that *not* to have a grace period if the memslot generation
> > changed but the actual GPA→uHVA (and memslot) don't *change*.
> > 
> > > Even SRCU could be problematic: if synchronize_srcu_expedited() is forced to wait,
> > > the wait time can easily get to 20+ milliseconds, which again is a non-starter for
> > > things like steal-time updates and nVMX pages.
> > 
> > But we don't have to synchronize from the read side. The code path
> > which will do so most often is gfn_to_pfn_cache_invalidate_start(). And
> > the refresh() path which is already the fallback slow path which can
> > sleep. Although in my tree I've optimised that *not* to incur a grace
> > period when it's avoidable, as noted above.
> > 
> > I'm more concerned by the fact that srcu_gp_end() might have to
> > *allocate*, while the OOM reaper path waits for it. I'll see how we can
> > deal with that...
> 
> I think I need to invoke Paul et al for that one...
> 
> Paul, Boqun, please could I trouble you to look at the top commit in
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/xen-rcu-srcu
> 
> The "gfn_to_pfn_cache" (GPC) here is for all extents and purposes a
> TLB. It's caching the full two-stage translation through KVM memslots
> which map a guest physical address to a userspace virtual address, and
> then through the standard process page tables to a host physical
> address.
> 
> It is the second stage we are interested in here. Invalidation happens
> through an MMU notifier, which (after I obey Sean's request to switch
> to SRCU) calls synchronize_srcu_expedited().
> 
> My problem:
> 
>  1. The MMU notifier invalidation can be called from the OOM reaper
>     path. In this case it MUST NOT sleep to allocate memory, or block
>     on anything which does so. cf.
>     https://lore.kernel.org/all/787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org/
> 
>  2. srcu_gp_end() does so, through init_srcu_struct_nodes(), while
>     synchronize_srcu_expedited() effectively waits for it — precisely
>     the thing we must not do. (Strictly, the waiter's completion is
>     queued to the same workqueue on which process_srcu() could be
>     blocked in init_srcu_struct_nodes(…, GFP_KERNEL)).
> 
> On a system with >= 128 CPUs it's actually OK because that allocation
> path never happens; everything's allocated in advance ("rcu: srcu_init:
> Setting srcu_struct sizes to big"). But on smaller systems I don't see
> that we have a way to ensure that things are safe. (I don't count
> setting big_cpu_lim to zero!)
> 
> Could we change that init_srcu_struct_nodes(…, GFP_KERNEL) to a non-
> sleeping allocation? If the allocation fails, that isn't fatal, is it?
> Or some other way to trigger the transition to big under controlled
> circumstances in advance...? 

We could easily provide such an interface.  However, is there some
check that would allow us to determine when it is OK to use GFP_KERNEL?
If there was, we could replace that GFP_KERNEL with something like this:

	sleeping_alloc_ok() ? GFP_KERNEL : GPF_HEY_YOU_TELL_ME

My best guess for GPF_HEY_YOU_TELL_ME is GFP_NOWAIT.

That way, you don't need another SRCU API to transition to big, and
everything "just works".

What say you?

							Thanx, Paul
