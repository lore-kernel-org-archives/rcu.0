Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023584;
	b=VI5KxRpED4wgJvLMjMhadjeztST2D7zPpDngamgAZq7gSclYVX7m44qPj7EE1VktDOya
	 9xf4YveKVfncY81h1vyqP7i5bJnw+jE5dpb0G048A+GlQvCDsdXLKZ2G+XxB0LuCBvFgK
	 ONtn5Pomb2kuaGBKsweWw/Zb7b1DiTaCbKhP/S1edgoBKSW0yK9QeFX/ZOeGPaqnQs8yz
	 kUZ6mcalOsXKfe4ULE4dlNzIyYIxz2Z4dvWjXEvrZAUlfEQIPD9u8XsyFzLun07BIb1dH
	 YlaP0O12bBY/QvwW6y1d8XWmczyBK9gc3vif5XgDes5Jht0nFzuvHDaFn9UXR0cd8hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023584;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KVOT22Bwz4LtlT/RZuYF6B93AUp538Zy+jsG2nfmmpU=;
	b=rzCVawAr6TLZdrYXrttXHYRSYqupDr0WXPPa8hrw0d/YupXFyif6/pFlcT05eWYpsNMh
	 0uoL7hV+IZizacCwsCe1cpFOVammHl/39kFVwFe04xK6+DevL2gjLMi4V0DLV2Ri4vw/q
	 3rxvNJBI7Fees3anXIIDd2Yf/zV6pKsnJ5Uqt0hKYyK+07XgaA7estyhDliAFrFivHkGm
	 kFXvh1YmVv8B7Jh3N0JfVuNXhUOwHvOCphV/f39BThYYoLsOdXE7iwDJ0wH8SYY/aU7Jv
	 e3T9RDJVoPPjChe9/jMTM016lfVdsY1u1b63Wt2EZKcQK3dt51ub9xTmVojPGhnDjEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLi4XMum;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA26606A322;
	Mon, 26 Oct 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLi4XMum
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88801F031E2;
	Mon, 26 Oct 2026 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023583;
	bh=KVOT22Bwz4LtlT/RZuYF6B93AUp538Zy+jsG2nfmmpU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=DLi4XMum9/39TU9W0qod4lbS1gGVQvAo4jmVHTLwutSS2im08ba7nt9Nd02iZnJPM
	 de8kamUHZhgNRhrD+2J1RB2Lvf5n5B97yjWlfW2UMj5guAaLT8uV+j07s22sqCI3t0
	 WU7MxUUpbKFoHug9b3+zUf2a1EbmFO1IrYN+VSMeCSDmXbMzYhYgF4DnNcSYhZpYet
	 ZrfN8e63FUGwFyrh7q4IM50gFNnTN3o0x0rg86dKKQXKRHvlxEn0Phnm2An0BDNA5f
	 jE6GRUhnOnEvvtj6lNx3WyRjjmrGmAUqMsjtCfR1j6m0EiFMpqZT0R9hNYS3V59+OX
	 ljUXjKx3W+wrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 71264CE0877; Mon, 26 Oct 2026 07:06:23 -0700 (PDT)
Date: Mon, 26 Oct 2026 07:06:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kai Ma <kai.ma1@huawei.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr v3 0/4] Hazard pointer updates
Message-ID: <e3b1c73d-8248-4644-80e7-a0640538fde6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
 <2cf703a6-7828-4735-98af-1a6fe93abd3f@paulmck-laptop>
 <87cxsw4qnl.fsf@huawei.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cxsw4qnl.fsf@huawei.com>

On Mon, Oct 26, 2026 at 01:01:18PM +0100, Kai Ma wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Sun, Oct 11, 2026 at 03:48:46PM -0400, Mathieu Desnoyers wrote:
> >> Hi Paul,
> >> 
> >> This series applies on top of "hazptr: handle NULL address in
> >> hazptr_detach" you have in your rcu dev tree.
> >> 
> >> This first patch addresses a race identified by Boqun Feng in the
> >> two-phase wildcard scheme. (no change since the last series)
> >> 
> >> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
> >> Those were discussed at length in a prior version of hazard pointer
> >> patches.
> >> 
> >> Since the last series, I have renamed ptreq.h to ptr_eq.h, addressing
> >> the feedback received from Boqun and Gary.
> >> 
> >> Patch 4 introduces a "try acquire" helper to allow the fast path
> >> to not rely on wildcards, while keeping the wildcard forward
> >> progress guarantees in the acquire slow path, used on fast path
> >> failure.
> >
> > I have pulled this in for additional review and testing, thank you!
> > (With Bradley's Reviewed-by on 4/4.)  Still subject to rebase, which means
> > that I can easily replace it with an updated series from you, if you
> > wish.
> 
> Hi Paul, Mathieu, and everyone,
> 
> I've been following the hazard pointer work and have done some testing
> on earlier versions. I'd be interested in getting more involved,
> particularly in concurrency correctness testing.
> 
> If there are WIP patches or early design discussions where additional
> review or testing would be useful, could you please CC me? I'd
> appreciate the opportunity to get involved earlier and help identify
> potential concurrency issues.

The current stack is in my -rcu tree [1] at v7.3-rc1..c3aea7747975,
with these patches on top:

5df49d76ff3a3 hazptr: Fix two-phase hazptr_synchronize race with detach
b41c6c2d4a33f ptr_eq.h: Introduce ptr_eq() to preserve address dependency
97ff14db1c381 Documentation: RCU: Refer to ptr_eq()
451174c765179 hazptr: Introduce "try acquire" fast path, fallback to overflow list
633f91e3408cc hazptr: Record per-CPU slot owner after claiming the slot

The biggest need is use cases, with the most likely ones being cases
where per-CPU reference counts consume too much memory or a reference
count is suffering from memory contention.  However, we are still finding
critical bugs both in the mechanism and the torture tests, so as you say,
review or testing is also very important.

These patches CC the rcu@vger.kernel.org list, so the best way to get
involved in the discussions is to join that list.

And welcome aboard!!!

							Thanx, Paul

[1] git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

> Thanks,
> Kai
> 
> > But in the meantime, some additional testing.  ;-)
> >
> > 							Thanx, Paul
> >
> >> Thanks,
> >> 
> >> Mathieu
> >> 
> >> Mathieu Desnoyers (4):
> >>   hazptr: Fix two-phase hazptr_synchronize race with detach
> >>   ptr_eq.h: Introduce ptr_eq() to preserve address dependency
> >>   Documentation: RCU: Refer to ptr_eq()
> >>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
> >> 
> >> Cc: Paul E. McKenney <paulmck@kernel.org>
> >> Cc: Boqun Feng <boqun@kernel.org>
> >> Cc: Bradley Morgan <brads@mainlining.org>
> >> Cc: Gary Guo <gary@garyguo.net>
> >> Cc: <rcu@vger.kernel.org>
> >> Cc: <lkmm@lists.linux.dev>
> >> Cc: Lian Wang <lianux.mm@gmail.com>
> >> Cc: Kunwu Chan <kunwu.chan@gmail.com>
> >> 
> >>  Documentation/RCU/rcu_dereference.rst |  38 +++++++-
> >>  arch/x86/include/asm/ptr_eq.h         |  16 +++
> >>  include/asm-generic/Kbuild            |   1 +
> >>  include/asm-generic/ptr_eq.h          |  16 +++
> >>  include/linux/hazptr.h                |  48 +++++----
> >>  include/linux/ptr_eq.h                |  63 ++++++++++++
> >>  kernel/hazptr.c                       | 135 +++++++++++++++-----------
> >>  7 files changed, 237 insertions(+), 80 deletions(-)
> >>  create mode 100644 arch/x86/include/asm/ptr_eq.h
> >>  create mode 100644 include/asm-generic/ptr_eq.h
> >>  create mode 100644 include/linux/ptr_eq.h
> >> 
> >> -- 
> >> 2.43.0
> >> 
> 
> -- 
> Kai Ma
