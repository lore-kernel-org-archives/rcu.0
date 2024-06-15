Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12A1361
	for <rcu@vger.kernel.org>; Sat, 15 Jun 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718411223; cv=none; b=kZrUG45VUEIk7chj/rZ2rlKUxwgBqsiJs9fxV2ynzB6CBJM3Y8EYN7qrIc7WmnCyUkDa9aCkHik1107hLtJPO0cBUdw15mYBVkVpAbed3S1d8Ybebd7V0ah+GBvAJSRVp3oiuOPiV2+ag/2CRevL9/4uunUbkz/60a9T03W9OCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718411223; c=relaxed/simple;
	bh=X8Lpzj4zrEXVnr0Hm00durDw3dNX1jMnb6YhEpBk320=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoI/tV/MTGuXPllD7qaWw0k5QdFgxT3itS0Antwu7jELrbFrThoh2uAZuMNs/vW2bA3eN3NToEVknNeXbay7NHU/LKrKP1V8wDjRv5toCQg7KM3qwchuyhCXBBYMhF59HLttWsaGqTPCe5a0Z9pttuJBsr5cOEasLMA9ZEkMmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D87m0JpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D87m0JpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6CBC2BD10;
	Sat, 15 Jun 2024 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718411222;
	bh=X8Lpzj4zrEXVnr0Hm00durDw3dNX1jMnb6YhEpBk320=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D87m0JpW1ZVKVRm1HxtXniDy/bpS6YEjv3xRlcDGBQHzmYrPLCMcWftDV7O4MR/A9
	 T8YWEjpKNiso/T+TwnPZRyKGYlPrswGzLY/mYr6CUWiSIk2YtI/FzvynKo9dF5SRTL
	 6Am+9oP/Y1fMBBK60bTLW3joP1Y6p4ARpscXtMufRvgt1bmze5WlosClOvUqre2QGW
	 8D8ieE9uz4XZd5ENqj0MPyzaS0gUMUHRT10QkTxaq+V6+curC0qHVnI/bLfljyal2x
	 PSUG/1Zx9PWs+iqs/U8TuN+WYXxn24xn/PymlNMUvqIfIAw9CwYQD09I7MIiPHhOkH
	 lIeWFTAn8RrsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7E43CE0738; Fri, 14 Jun 2024 17:27:01 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:27:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <6e7c822f-f03c-4586-80b4-ff6444b35be9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
 <mbdjlkg74rgxvyb3mv5yl3hrmdiy3kpu3u3qgky7gvw5o445l2@f6uqrfgpcmfy>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mbdjlkg74rgxvyb3mv5yl3hrmdiy3kpu3u3qgky7gvw5o445l2@f6uqrfgpcmfy>

On Fri, Jun 14, 2024 at 04:14:29PM -0400, Kent Overstreet wrote:
> On Fri, Jun 14, 2024 at 07:11:50AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 13, 2024 at 08:22:19PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 13, 2024 at 02:32:27PM -0400, Kent Overstreet wrote:
> > 
> > [ . . . ]
> > 
> > After sleeping on it, backing up a level of abstraction, and thus perhaps
> > responding a bit more constructively...
> > 
> > And also, thank you very much for looking into this!
> > 
> > > > commit 3bb5d34d6d6e2d5433cce5d248fd81211afedec0
> > > > Author: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Date:   Mon Jun 10 20:47:03 2024 -0400
> > > > 
> > > >     bcachefs: pending_rcu_items
> > > >     
> > > >     Generic (?) data structure for explicitly tracking pending SRCU items
> > > >     
> > > >     - Can we make this generic across other RCU flavors?
> > 
> > It should be possible, at least for current RCU and SRCU.  I think I owe
> > you SRCU variants of a couple of existing RCU functions.  Later today!
> 
> I was wondering how much commonality there is between the core data
> structures of RCU and SRCU. If RCU internally has something analagous to
> srcu_struct, and we could refer to that object without caring if it's
> for RCU or SRCU, that would be cool... otherwise, we can just do it a
> level up with switch statements.

There is a lot of commonality at the conceptual level, but lots of
differences due to radically different design tradeoffs.  And don't
forget about the Tiny variants of both RCU and SRCU.  (With the current
API, you shouldn't need to care.)  Things will get more fun if any of
the three RCU Tasks variants need polling interfaces.  Not a big deal,
though, either a pointer for SRCU or a small-integer enum for the others.

And I haven't heard any hint of a need for polled interfaces for any of
the Tasks RCU variants.

> > > >     - Do we need to add a fallback to linked lists when darray allocation
> > > >       fails?
> > 
> > In general, as in kfree_rcu(), yes.  In your specific case here, maybe not.
> > 
> > > >     - We wish to avoid the overhead of start_poll_synchronize_srcu() if we
> > > >       already have items for a given sequence number, but it appears
> > > >       get_poll_synchronize_srcu(); start_poll_synchronize_srcu() can
> > > >       actually return differert sequence numbers within the same read-side
> > > >       critical section. Is this the correct way of doing this?
> > 
> > You can always buffer up items that have not yet been assigned a sequence
> > number, then after you have enough or after enough time has passed, do a
> > single get_poll_synchronize_srcu() for the group.
> 
> I don't think we'd want to do that, since that would be delaying the
> point at which objects get reclaimed. Have a look at my latest version
> and tell me if you think that works? It seems to work in my testing.

Ah, it did arrive.  I will take a look by the end of Monday (maybe
sooner, depending).

If a grace period is currently in progress, there is no penalty for
batching.  Huh.  If the overhead of that get_poll_synchronize_srcu()
becomes a problem, there are some tricks we can play.  But let's get
the basics working well first.

> > > >     - Do we need to ensure the rearming RCU callback is correctly flushed
> > > >       when exiting? (Probably)
> > 
> > I believe so, and setting a flag then doing an srcu_barrier() should suffice.
> 
> Is the only difference between srcu_barrier() and synchronize_srcu()
> that srcu_barrier() is a noop if callbacks weren't enqueued?

They are orthogonal.  Keep in mind that synchronize_srcu() does not
necessarily wait on any callbacks, just like srcu_barrier() does not
necessarily wait on any grace period.

Now, as you might have noticed, as an accident of implementation on
systems with fewer than 128 CPUs, if a given srcu_struct never has
had significant grace-period activity, there will be a single list
of callbacks, so synchronize_srcu() will wait for all pre-existing
callbacks.  But if there are more CPUs or if there is heavy update-side
load, then there will be one callback queue per CPU, and in that case
synchronize_srcu() will wait only for pre-existing callbacks on its CPU.

And recent work means that synchronize_rcu() does not necessarily ever
wait on callbacks, and perhaps some day that same optimization will be
applied to SRCU.

> > > > +static void pending_rcu_items_process(struct pending_rcu_items *pending)
> > > >  {
> > > > -	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
> > > > +	while (pending_rcu_has_items(pending) &&
> > > > +	       poll_state_synchronize_srcu(pending->srcu, pending->seq)) {
> > > > +		darray_for_each(pending->objs[0], i)
> > > > +			pending->process(pending, *i);
> > 
> > Given that you have interrupts and/or bh disabled, there needs to be a
> > third set of callbacks, those whose grace periods are already elapsed.
> 
> Not following? The pending->process() is exactly that callback.
> 
> Also, the new version does processing in proccess context, without the
> lock.

OK, I will look at the new version.

In the meantime, I am guessing that there is some delay between the end
of a grace period and the processing of that grace period's callbacks,
and if that delay is perceptible, those callbacks will need to be gotten
out of the way of new callbacks.

> > Unioning one of the ->objs[] sets onto this third set, leaving the source
> > ->objs[] set empty, should strongly be O(1) without the need for memory
> > allocation.  I might be missing something, but at first glance darray
> > does not support this.
> > 
> > The pages-of-pointers structure named kvfree_rcu_bulk_data, along with
> > the associated structures in kernel/rcu/tree.c does this work, but (1)
> > is open-coded and (2) has to deal with the full range of what the kernel
> > can throw at it.  It falls back to an embedded rcu_head structure, in
> > response to your second question in the commit log.
> > 
> > But perhaps this code could be generalized?  Or maybe darray can be
> > appropriately extended?
> 
> Not sure what you mean by "unioning onto a third set"?

Huge piles of objects are coming into this system.  As grace periods a
goodly chunk of them need to be processed.  This processing would take
significant time, quite possible multiple SRCU grace periods worth
of time.  Unless the arrival of new callbacks can be blocked while
these callbacks are being processed, you need a place to accumulate the
callbacks as their grace periods expire.

> > And one thing that I missed the first time around is that you are using
> > a single ->seq for two sets of objects (->objs[0] and ->objs[1]).
> > Each set needs its own sequence number.
> 
> I've got this changed in my latest version, but - I did see one BUG_ON()
> where we seem to have three sequence numbers in flight. Any idea what
> might be up with that?

Although at any given time, there will be at most two unexpired cookie
values, time delays can make it appear as if there are more.  If you
have three, one of them has expired, but the problem is that you might
have already checked it, but before it got around to expiring.

That explanation might or might not make sense, but I will look at your
new code and see what is up.

							Thanx, Paul
