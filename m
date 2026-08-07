Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3D23D2B1;
	Fri,  7 Aug 2026 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139702; cv=none; b=BfpeYU8oAuS4WRKaRk0FZqZqWLNVLpVgCwDjN0edIvzIumJPzorcT8h1IUU//DuoSQlt9rH9PovDUQFO/p2kG5MuotY7r/RtfFejDLBUhCiqtg7DY3r+Mx3yaHPKZMFvnjTYceWjZWCjOE1tVLaLJjKJ0RaRa7yPu8xSYvnumxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139702; c=relaxed/simple;
	bh=Y33mHOIQ085EvUfTJKJp0B19lIi5CrasLucQPtRz3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLGbePzBFKBL19VX12C30T0LO/npNdxpp0cvn3W4puyFaMK7e+wxppOoF9wRr2hZeZgT1wKeJX7rq2E4mzHdb01j0HoNmiAMMQZr4ieVtUv/WsaViIkaRizT2rOAb8i2mj1LX/wvy+FZGRhoHhkqpHv2jpYFY8q9bxXYsYmJyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPA6FxSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPA6FxSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB421F000E9;
	Fri,  7 Aug 2026 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786139701;
	bh=lyFanFMdsWE5ZX+rL1ysyiHxbSTOAmIfVpER+7zjtA4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lPA6FxSVIzU471TjB1HzTES21heymVwLqir0rJMrEVyaDUV1uXTEOk6fjjW5lRLT4
	 T9YapaJfhNMc+UJsNXmHKQWX+ADQiCkV+0TSOD8AfkHMw6jRTiOiyhF2Z0RYs1J8+u
	 Xxx9ZZmHvt8XCdIxI/gpuvmUFV8vbq3x/x1i0HC9HvBQihGvf5GzaQPxyXgPAO1+bk
	 zrfkfcoHOmHQLfaVP0MpUUZt46wkNiI2+T4CStYp5BhfXNFm2SqMF9/KrBV1lOgMrh
	 KkoZGbLT0o4kPane6H41v2NRqaAclvM1icG3Ux9Vhi8+LOb47T4ynWt2fbn8KZvUjo
	 hiiUPSCtnMVCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BDAECCE1A04; Fri,  7 Aug 2026 14:55:00 -0700 (PDT)
Date: Fri, 7 Aug 2026 14:55:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Boqun Feng <boqun@kernel.org>,
	kvm@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Message-ID: <3da4c9d6-39ae-4cf4-8d79-9661968f7f7c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
 <20260805195528.3853473-4-dwmw@amazon.co.uk>
 <20260805203608.D3CA61F000E9@smtp.kernel.org>
 <anS8C4Cxqy6ehCo3@google.com>
 <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk>
 <7dbe2929b5e7be6a2b9de860649598403d52f9a9.camel@infradead.org>
 <31e9a043-7d4b-40f3-8fdb-62701b730c5d@paulmck-laptop>
 <9E3BF4F1-EB01-48DC-9DC3-6780EDE06CC2@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E3BF4F1-EB01-48DC-9DC3-6780EDE06CC2@infradead.org>

On Fri, Aug 07, 2026 at 12:02:57AM +0200, David Woodhouse wrote:
> On 6 August 2026 23:52:06 CEST, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >On Thu, Aug 06, 2026 at 10:38:56PM +0200, David Woodhouse wrote:
> >> On Thu, 2026-08-06 at 19:59 +0200, Woodhouse, David wrote:
> >> > On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
> >> > > On Wed, Aug 05, 2026, sashiko-bot@kernel.org wrote:
> >> > > > Replace the per-cache rwlock with RCU for the read side.
> >> > > 
> >> > > I don't hate the idea, but I am very against using RCU.  Unless it's "impossible",
> >> > > e.g. because synchronize_srcu() allocates memory and breaks OOM kill, I would
> >> > > strongly prefer to use SRCU, probably with a dedicated kvm->gpc_srcu, so that
> >> > > synchronization doesn't need to wait on all CPUs in the system.  The tail latencies
> >> > > for synchronize_rcu() are horrendous, especially for many-CPU systems.  If it
> >> > > were only mmu_notifiers that got hit, it miiiight be acceptable, but since this
> >> > > will affect vCPU tasks in the refresh() path as well, normal RCU is pretty much
> >> > > a non-starter.
> >> > 
> >> > Yeah, the refresh() path got pretty slow in my first attempt, before
> >> > optimising that *not* to have a grace period if the memslot generation
> >> > changed but the actual GPA→uHVA (and memslot) don't *change*.
> >> > 
> >> > > Even SRCU could be problematic: if synchronize_srcu_expedited() is forced to wait,
> >> > > the wait time can easily get to 20+ milliseconds, which again is a non-starter for
> >> > > things like steal-time updates and nVMX pages.
> >> > 
> >> > But we don't have to synchronize from the read side. The code path
> >> > which will do so most often is gfn_to_pfn_cache_invalidate_start(). And
> >> > the refresh() path which is already the fallback slow path which can
> >> > sleep. Although in my tree I've optimised that *not* to incur a grace
> >> > period when it's avoidable, as noted above.
> >> > 
> >> > I'm more concerned by the fact that srcu_gp_end() might have to
> >> > *allocate*, while the OOM reaper path waits for it. I'll see how we can
> >> > deal with that...
> >> 
> >> I think I need to invoke Paul et al for that one...
> >> 
> >> Paul, Boqun, please could I trouble you to look at the top commit in
> >> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/xen-rcu-srcu
> >> 
> >> The "gfn_to_pfn_cache" (GPC) here is for all extents and purposes a
> >> TLB. It's caching the full two-stage translation through KVM memslots
> >> which map a guest physical address to a userspace virtual address, and
> >> then through the standard process page tables to a host physical
> >> address.
> >> 
> >> It is the second stage we are interested in here. Invalidation happens
> >> through an MMU notifier, which (after I obey Sean's request to switch
> >> to SRCU) calls synchronize_srcu_expedited().
> >> 
> >> My problem:
> >> 
> >>  1. The MMU notifier invalidation can be called from the OOM reaper
> >>     path. In this case it MUST NOT sleep to allocate memory, or block
> >>     on anything which does so. cf.
> >>     https://lore.kernel.org/all/787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org/
> >> 
> >>  2. srcu_gp_end() does so, through init_srcu_struct_nodes(), while
> >>     synchronize_srcu_expedited() effectively waits for it — precisely
> >>     the thing we must not do. (Strictly, the waiter's completion is
> >>     queued to the same workqueue on which process_srcu() could be
> >>     blocked in init_srcu_struct_nodes(…, GFP_KERNEL)).
> >> 
> >> On a system with >= 128 CPUs it's actually OK because that allocation
> >> path never happens; everything's allocated in advance ("rcu: srcu_init:
> >> Setting srcu_struct sizes to big"). But on smaller systems I don't see
> >> that we have a way to ensure that things are safe. (I don't count
> >> setting big_cpu_lim to zero!)
> >> 
> >> Could we change that init_srcu_struct_nodes(…, GFP_KERNEL) to a non-
> >> sleeping allocation? If the allocation fails, that isn't fatal, is it?
> >> Or some other way to trigger the transition to big under controlled
> >> circumstances in advance...? 
> >
> >We could easily provide such an interface.  However, is there some
> >check that would allow us to determine when it is OK to use GFP_KERNEL?
> >If there was, we could replace that GFP_KERNEL with something like this:
> >
> >	sleeping_alloc_ok() ? GFP_KERNEL : GPF_HEY_YOU_TELL_ME
> >
> >My best guess for GPF_HEY_YOU_TELL_ME is GFP_NOWAIT.
> >
> >That way, you don't need another SRCU API to transition to big, and
> >everything "just works".
> >
> >What say you?
> 
> Thanks for the prompt answer!
> 
> It's a nice idea, but I'm not sure what we'd trigger on. In an earlier patch in this same series I already ripped *out* the non_block_start() for this OOM reaper path, because that would make it sad even about the non-allocating sleep for the (S)RCU wait. The actual criterion is more subtle than that.

Yeah, you can be blocked waiting for memory "just because" from one
call to synchronize_srcu() and then when you invoke synchronize_srcu()
from the OOM reaper, you still block because your OOM-reaper-induced
synchronize_srcu() can't start its grace period until the earlier
synchronize_srcu()'s grace period completes.

And there probably are a *lot* of similarly fatal scenarios.  :-/

> And anyway, the allocation isn't even running from that thread; it's on the workqueue.

Maybe we need a GFP_SHORT_WAIT that gives up if more than (say) ten
jiffies elapse.  Then the needed NULL return shows up and everything
goes forward.  Plus if someone starts their first SRCU grace period from
a safe MM state, it does what is needed to get the memory, thus reducing
contention on the srcu_struct-related synchronization mechanisms.
Which is why I am uncomfortable with unconditional use of GFP_NOWAIT
or similar.

What we have now is at best exceedingly non-ergonomic for the surprisingly
large fraction of the kernel that can be invoked from OOM/reclaim.

> I think it has to be an API which lets us upgrade in advance. Or just make it GFP_NOWAIT unconditionally? What's the failure mode if the allocation fails? My unreliable AI friend told me it was harmless enough... but I don't trust it much, which is why I reached out to my meat friend...

So your setup is has the default srcutree.convert_to_big=3
(SRCU_SIZING_AUTO) and more than 128 CPUs, correct?  Does this need to
work with old-school CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY,
or is new-age CONFIG_PREEMPT_LAZY in place?

Here are the options I can see at this point:

1.	As you and your AI friend suggest, change the GFP_KERNEL
	to GFP_NOWAIT.	As noted above, I am not so happy about the
	possibility of eternal contention due to eternal failure.

2.	As above, change the GFP_KERNEL to GFP_NOWAIT.	But then, upon
	failure, also invoke something in MM that greatly increases the
	probability of success on the next attempt.  I have no idea
	that that "something" might be.

3.	Use a GFP_SOMETHING that can return NULL, but dynamically
	figures out how far it can go, possibly bounded by a timeout.
	Then we replace SRCU's GFP_KERNEL with that GFP_SOMETHING.

4.	Implement GFP_SOMETHING by hand by using GFP_NOWAIT, and on
	failure spawning a workqueue to do the allocation asynchronously
	in a clean environment, not blocking any grace period.
	This is complicated by the fact that it introduces concurrency
	into the allocation.

5.	Give you an init_srcu_struct_big() that is init_srcu_struct() if
	srcutree.convert_to_big is SRCU_SIZING_NONE or SRCU_SIZING_INIT,
	but immediately does the allocation otherwise.

	Of course, this allocation can fail, and if it does, you are
	right back where you started.

6.	As above, but if the allocation does fail, do a self-propagating
	call_srcu() that keeps running until the allocation within
	srcu_gp_end() succeeds.  Something that I am sure that the
	battery-powered-embedded guys will just love.	And so will you
	if that from-OOM/reclaim call gets there before the successful
	allocation.  ;-)

7.	Combine #6 and #1, so that if init_srcu_struct_big() was used,
	srcu_gp_end() uses GFP_NOWAIT, but otherwise sticks with the
	current GFP_KERNEL.  This at least restricts the blast radius
	of GFP_NOWAIT fallout.

I don't know about you, but none of these are sparking joy at this end.
Other than the mythical GFP_SOMETHING, of course, but for that there is
the small issue of it currently being mythical.

If this must be fixed in SRCU, pragmatism says that I would hold my nose
and take door #7.

But first, is this *really* the best that we can do?

							Thanx, Paul
