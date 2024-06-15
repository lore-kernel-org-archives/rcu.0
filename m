Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E288173
	for <rcu@vger.kernel.org>; Sat, 15 Jun 2024 00:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718409866; cv=none; b=OZLVsDFR7P0i72Fx5QIiiCsn30daxNHOrUb4b1Lvqs9mR/07Mt2NmrDH7PDkRzPfVWlxOnX9QXWV+RYljdm3I0E64UweMyGiNLzZSCb6vPQzPH2Cn5EzNbZUHQG9dgQr009vtFxBt/JiPsJKlL3XfEe8Pk0hF8PdGh+a6TDPWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718409866; c=relaxed/simple;
	bh=u4Gkg2/uQL258fWl+T5PMgpWMIsmOZ5sCT8RcxfUAjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZoOwN7JUtginXtdwr9Y7NiRoUUVAcZvlw3Xfun2ZJVJoBLqrDbBdOur3ytQrRBMgATmADbb8HK9Aqqzk8yBLASn6Q97cYd9EoLdJIVEVHh1QzOHDWcURuSA16oWkE2f0Djg7+jLgGb9np1ckxnaOXgyTgQvDj916dlKl9lTi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDZke2EG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDZke2EG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05921C2BD10;
	Sat, 15 Jun 2024 00:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718409866;
	bh=u4Gkg2/uQL258fWl+T5PMgpWMIsmOZ5sCT8RcxfUAjk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kDZke2EG79I15DHaurI5WAwFaEnmzqdJxAHMfHlxnxIHygD6KcVJHsy1yDxiEuMfC
	 K5aNVQnE3lWH2oBj7zKJ87MScHKWekjAUtUeLdUCUx5Tykd6rShAF6h97zLqqjRGcZ
	 HGPWij8PpdDD81DlZVGu7Uaa8AO65ZH3M9OckKSovHy0GFrZjFwMfM+eMNB8iDeiDs
	 pHj/Xu6vXWly0x9V8kna8TeLr/0szRE8VOLO3mvLz9Z1AGRS9BCgtBVlC6m0WupjxN
	 NVnF1KbFkpF+XjxFhe5n/Fz+WYvAC7iBvKacZ7+QNfNgU2c+iIjb67MiDMt7CHW4ct
	 TeGw+gCEI+Pig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C844CE0738; Fri, 14 Jun 2024 17:04:25 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:04:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <e95f88a0-ce44-4274-a7a0-c5a1eb672a97@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <zychjrhasgxz7gwhah6egognnqepcdyoubby6gog645mn6n4gt@zprp3rhtyfx3>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zychjrhasgxz7gwhah6egognnqepcdyoubby6gog645mn6n4gt@zprp3rhtyfx3>

On Fri, Jun 14, 2024 at 11:12:30AM -0400, Kent Overstreet wrote:
> On Thu, Jun 13, 2024 at 08:22:19PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 13, 2024 at 02:32:27PM -0400, Kent Overstreet wrote:
> > > On Wed, Jun 12, 2024 at 08:48:40PM -0700, Paul E. McKenney wrote:
> > > > The number two is the number of distinct values, which will not be
> > > > consecutive numbers.  As you noticed, they currently are always multiples
> > > > of four, but that is an accident of implementation that is subject to
> > > > change.
> > > 
> > > I take it you're stuffing something else into the low bits and masking
> > > it off, and you can't shift that off because that would break
> > > comparisons. That's a tiny bit unfortunate; it would be nicer if we
> > > could do array indexing based on the sequence number.
> > 
> > That was my initial thought as well, and so there was in fact a time
> > when RCU grace periods were numbered consecutively.  The problem with
> > that was that it was necessary to maintain a separate indication of
> > whether or not a grace period was in progress.  It is often necessary
> > to atomically determine both the grace-period number and whether that
> > grace period is still in progress, which required acquiring a lock,
> > which necessitated a number of contention-reduction workarounds which
> > eventually became problematic.
> > 
> > When led to the next phase, which reserved the bottom bit to indicate
> > whether a grace period was in progress and left the remaining bits to
> > count the grace periods.  This greatly simplified the code and likely
> > also improve performance and scalability.
> > 
> > Then I implemented Tree SRCU, which requires multiple grace-period phases,
> > hence the current state with the two bottom bits indicating grace=-period
> > phase and the remaining bits counting the grace periods.  Hence your
> > seeing get_state_synchronize_srcu() always returning a multiple of
> > four ("grace period N has not yet started").
> 
> I've been wondering about your tree algorithm, ever since I realized
> there's an elegant algorithm for ticking a counter when every counter in
> a tree of sub counters has ticked.

One name for it is "combining tree".  If you want to dig deeper, there
are some (admittely ad hoc) design documents here:

https://docs.google.com/document/d/1GCdQC8SDbb54W1shjEXqGZ0Rq8a6kIeYutdSIajfpLA/edit?usp=sharing

Perhaps most relevant, my 2016 LCA presentation covers this for expedited
grace periods:

http://www2.rdrop.com/~paulmck/RCU/4096CPU.2016.02.03i.pdf
https://www.youtube.com/watch?v=1nfpjHTWaUc

> > > What if we added something like this?
> > > 
> > > #define RCU_SEQ_SKIP_SHIFT	2
> > 
> > Right now, get_state_synchronize_srcu() returns the grace-period sequence
> > number from the root of the tree.  This has been working fine thus far,
> > but it is quite possible that memory-contention issues will force me to
> > get the value from the leaves of this tree.  If that happens, the value
> > of NUM_ACTIVE_SRCU_POLL_OLDSTATE will change from 2 to 3.
> > 
> > In addition, vanilla RCU users are looking for reduced synchronize_rcu()
> > latency, which in the past resulted in the addition of expedited
> > grace periods, which have their own counter.  Similar pressure on SRCU
> > could result in overlapping computed grace periods, which would use
> > additional bits and make the cookies only partially ordered (as the RCU
> > rcu_gp_oldstate structure variant of cookie already is).
> > 
> > And those are just a couple of changes that I can foresee.  There might
> > be others.
> > 
> > So, annoying thought it might be, we really need for this to remain an
> > opaque cookie.
> 
> Ok, I can live with that.
> 
> > > > > I could use a doubly linked list for tracking all uncompleted objects,
> > > > > but I'm hoping use a darray per sequence number. Is it a max of two
> > > > > sequence numbers that had objects/callbacks/were requested pulling,
> > > > > or...?
> > > > 
> > > > Agreed, an array should work.  Each array element would need a field
> > > > recording its cookie.  Right, so you likely need a few more simple
> > > > functions:
> > > > 
> > > > 	same_state_synchronize_srcu(): Equality comparison of the
> > > > 		pair of cookies passed in.
> > > > 	get_completed_synchronize_srcu(): Return a special cookie
> > > > 		that, when passed to poll_state_synchronize_srcu(),
> > > > 		always results in a @true return value.
> > > > 
> > > > Or maybe not, you tell me.
> > > 
> > > I don't think so, but I'm not sure what your intended use is.
> > 
> > For same_state_synchronize_srcu(), places where you likely planned to
> > instead use C-language comparisons.  For get_completed_synchronize_srcu(),
> > as a way of marking an unused entry, for which it looks like you are
> > currently using ->rcu_armed.
> 
> I'm definitely not following how you want that done then :)

I need to adapt this (if needed) to your latest code.

> > > dynamic array, basically a c++ vector - fs/bcachefs/darray.h
> > 
> > So the darray is to hold the callbacks themselves as opposed to
> > the per-unexpired-cookie-value groups of callbacks?
> 
> For my intended use case, a struct pending_rcu_items is only for objects
> of the same type that all have the same callback (otherwise, allocating
> from pending objects would have to search for an object of a given
> type).
> 
> But if we want to use this for the call_rcu()/call_srcu() mechanism,
> then yes - the darray would have elements of type
> 
> struct rcu_pending_cb {
> 	void (*func)(struct rcu_head *);
> 	struct rcu_head *obj;
> };
> 
> which would save us a dependent load on processing callbacks.

OK.  But please see my comments about sets, O(1) union operations,
and soforth.

> > > Think this would be worth factoring out and turning into something
> > > generic? If RCU wanted to use this internally for tracking pending
> > > callbacks, we could get rid of linked list overhead there...
> > 
> > For the kfree_rcu() path, we have a pages-of-pointers approach.  For the
> > call_rcu() path, the callbacks almost always access the memory, so it
> > is not clear that the linked-list overhead is an issue.  You get that
> > cold-cache miss either way.
> 
> So kfree_rcu() is basically implementing the same thing? yes,
> add_ptr_to_bulk_krc_lock().
> 
> The pages-of-pointers does avoid the realloc/memcpy() overhead - which
> implies I'll want to switch mine from a darray to a generic radix tree.
> 
> I think call_rcu() would benefit from this approach as well - it's true
> that we can't avoid cache misses, but linked lists are completely
> serialized, so those cache misses hurt; using a vector or radix tree
> means we can prefetch.

I would need to see evidence.  I agree that a CPU could prefetch in this
situation, but do they really?  If so, do they really prefetch often
enough to justify the added complexity?

Why the worry about complexity?  The RCU callback processing has lots
of moving parts, and will soon be getting more as we make it so that
RCU callbacks can take advantage of expedited grace period.  (I have
been wanting to make this work for more than ten years to better handle
callback floods and OOM conditions, and we finally have the tools in
place to make it at least semi-feasible!)

But if it really does provide significant benefit, then yes, it is
clearly on the list.

						Thanx, Paul
