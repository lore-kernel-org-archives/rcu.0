Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA34F4049;
	Wed, 30 Sep 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787666; cv=none; b=fuzVO+1DztVbQJui0NcGSejFLjXOHmvwmtk3a0a37GXWNfXhieT3g7IYuM2GpZtuUwdeZzoE3sXdAs0X1aNRYXS6dMEMEiCyNN3fUKmovmEJw68GRmQOWwEBIvjxE1f0UeYucmZ/ftPhthIh8sCupPvMnV14TBci50B832Mu4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787666; c=relaxed/simple;
	bh=KWmUTN59UarQxklnjCZb6DjlBd7FgCmlBHH/9rL2yd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5eVg7Igw98xb82IPrkiUEkZtU+F4hgn2x9KvBiOPIw7CZdyJgqE2rfnBKyRBQ9yfS6i02TyXMUjSZmh6h4fJKQO5bjhVt9J3A3bur/jpwROGnt5YYxgwg1DH70OKuBbT6dNSFl5wjuVOVTkQc5zz+Nqy6+wcWxwYXx6AExHPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xua9YVpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xua9YVpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562A71F00898;
	Wed, 30 Sep 2026 17:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790787665;
	bh=f8lrA6Wq7RLoqyx88OAS/bTqhGeK9VKqSwD4O6iYg0s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Xua9YVpB0B2xNCLEHvGNvxsvq46tmc2FSJo6Usl/f/ENPH9Ntzn468ZyakJE77vHw
	 cQkobpm2MeLNY2jRU1GJw7M6qJOkYPQjwj0Op8r0EiwU4eg9rjO3JS9hXPMKu5V5jC
	 t9HFBnmE1pNDMWgtyG9zz5LDS8kdUqXq0U5Wr3lii6VnJJoLww3XekwAxweutoevkV
	 8C8lgWj4jKlnKWZb/wXwffEzMXnOcMcUcvZP8Ozn/XU1tJtYH5bX8SAtS5RciQq+Wh
	 l7KyI4ZxSTBK/3qnpIvCeyus1/4uIsO2TxQ7CsHjKXbOFGxYo3Apjz4G2LXsrSP3K/
	 F6a0fRu0mrMhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E8E0DCE097C; Wed, 30 Sep 2026 10:01:04 -0700 (PDT)
Date: Wed, 30 Sep 2026 10:01:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>, linux-kernel@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
Message-ID: <2b43062d-a699-4c6b-8aa3-251b25212a38@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <EAE9B584-7CEC-46AA-AC8F-A06F11073763@mainlining.org>
 <89cecc9c-f29b-46d1-804d-c87171a445f0@efficios.com>
 <1357947A-5850-4F73-B22E-2AE8B5CAABE2@mainlining.org>
 <5169602d-c0ac-4b5b-841c-7cc4a3c54274@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5169602d-c0ac-4b5b-841c-7cc4a3c54274@efficios.com>

On Sun, Sep 27, 2026 at 12:45:10PM -0400, Mathieu Desnoyers wrote:
> On 2026-09-27 12:33, Bradley Morgan wrote:
> > On 27 September 2026 17:27:33 BST, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > > On 2026-09-27 12:07, Bradley Morgan wrote:
> > > > On 27 September 2026 16:51:27 BST, Mathieu Desnoyers
> > > > <mathieu.desnoyers@efficios.com> wrote:
> > > > > Hi Paul,
> > > > > 
> > > > > This series applies on top of "hazptr: handle NULL address in
> > > > > hazptr_detach" you have in your rcu dev tree.
> > > > > 
> > > > > This first patch addresses a race identified by Boqun Feng in the
> > > > > two-phase wildcard scheme.
> > > > > 
> > > > > Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
> > > > > Those were discussed at length in a prior version of hazard pointer
> > > > > patches.
> > > > > 
> > > > > Patch 4 introduces a "try acquire" helper to allow the fast path
> > > > > to not rely on wildcards, while keeping the wildcard forward
> > > > > progress guarantees in the acquire slow path, used on fast path
> > > > > failure.
> > > > 
> > > > Hi, here is a hazptr perf test on powerpc
> > > > 
> > > > REAL kill_fasync(), ns per call, best of 3, 100k calls:
> > > > (stock = rwlock walk, conv = hazptr walk, same v3 tree ± the conversion)
> > > > 
> > > >     shape          stock    conv     delta
> > > >     1 node,  1 walker     59      59     +0.0%   (singleton: identical)
> > > >     16 nodes, 1 walker   539     539     +0.0%   (uncontended: identical)
> > > >     16 nodes, 4 walkers  509     134    -73.7%   ← rwlock readers contend
> > > >     16 nodes, 8 walkers  313     113    -63.9%   ← same list, 8 cpus
> > > >     64 nodes, 1 walker  1979    2039     +3.0%   (pure walk: hazptr tax)
> > > >     64 nodes, 4 walkers 1914     509    -73.4%
> > > >     64 nodes, 8 walkers 1015     382    -62.4%
> > > > 
> > > > Its SLOWER than rcu, but beats rwlock
> > > 
> > > Two feedback points:
> > > 
> > > 1) The comparison I think Boqun cares mostly about is with expedited
> > >    RCU grace periods, this is where we suspect there is a significant
> > >    benefit to using hazptr rather than RCU to eliminate those IPIs
> > >    on synchronize.
> > > 
> > >    It's good to know that it performs better than rwlock (albeit it's
> > >    not surprising).
> > > 
> > > 2) I'm concerned about what looks like a use of hazptr to protect linked
> > >    lists elements in your benchmark (did I miss anything ?).
> > > 
> > >    RCU read-side critical sections protect all elements of a linked list
> > >    naturally, but hazptr requires more care. See this comment above
> > >    hazptr_acquire:
> > > 
> > > * This protection is unconditional, and has limitations similar to
> > > * that of unconditional reference-counter acquisition.  In particular,
> > > * although holding a hazard pointer prevents a hazard-pointer-protected
> > > * object from being freed, it does not prevent that object from being
> > > * removed from a linked data structure, and does not prevent other
> > > * hazard-pointer-protected objects referenced by this object from being
> > > * both removed and freed.  At which point, invoking hazptr_acquire()
> > > * on these dangling pointers would be a bug.  On the other hand, use of
> > > * hazptr_acquire() is safe for immortal pointers to objects that do not
> > > * themselves contain pointers to hazard-pointer-protected objects.
> > > * Other (more complex) use cases are also possible.
> > > 
> > > Does the pointer you protect qualify as an "immortal" pointer, or it's
> > > a linked list "next" pointer ?
> > 
> > Hmm. Do you have a idea on what you could metaphorically convert, with a
> > core subsystem?
> > 
> > I'll give anything you want me to do a try
> At a high level, I suspect it would be good to start by digging into
> users of synchronize_rcu_expedited(), to see if a few of those may be
> good candidates.
> 
> I would also favor scenarios where RCU (or locking) are used to protect
> the existence of an object reachable from a global pointer, and use
> hazptr to protect that object. Note that initially this precludes
> a hazptr-protected list, because the next pointers would sit in
> prior objects which are themselves hazptr-protected, which is not
> sufficient to guarantee existence against a hand in hand traversal.
> 
> However, if you have a pointer to an object "side-car" structure
> (e.g. optional extra metadata), and the object containing the pointer
> is guaranteed to exist by another mechanism (e.g. RCU, locking), then
> that pointer-to-side-car-object field would be a good candidate for
> hazptr (AFAIU).
> 
> I'm not saying the linked lists could not be done, but it would require
> more care.

Other candidates include users of per-CPU reference counters, along with
any try-acquire reference counters that have seen memory contention.

							Thanx, Paul
