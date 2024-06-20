Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C53D575
	for <rcu@vger.kernel.org>; Thu, 20 Jun 2024 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718913502; cv=none; b=gR2kryuLil9XL6nOFihcs95g8/qPGjX6KPIOtZ87rV5M29NR1MS7rRW9KgWmYRDiN2+LAWyCCw9YwUhTL1ElFjfNXNafBPHsZxWDvqhlkBQu+P8OfU0z/D1qYuSbOzZCa3PthzAS080QwEwQ6kXszgHbmMy2na8TuKZFv4uSnJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718913502; c=relaxed/simple;
	bh=o/wxckrXZkChQe11j6ri0bzzck3Th1FyBZv2ODSla7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMNf4/Z84qTCYIwLyqIDlBOZePxQCTjM50gbXVSXyNRANK43SAEB6/uKAw52PE7H9iTiunfcv/gPebpKpE2N7Wb1/tWMbuKG5VBTv7hqtv35ikKasViJkHUjoP7NIF4PxDIiQNvliKy26ST+UwOEDxrjESz5kzAAcdUsSDVvouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXLPjGKJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXLPjGKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4871CC2BD10;
	Thu, 20 Jun 2024 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718913502;
	bh=o/wxckrXZkChQe11j6ri0bzzck3Th1FyBZv2ODSla7s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pXLPjGKJV/flKDXDSyEeRTbAgtkdA6eXTrpfElZSgXyps0dja74WeJDcpxvAw8GV1
	 b7rB4ncdCjTRCZtHlxhFRruobVCeS7Xj4aJTwqYdx46PmMTbE1GxeVClksm4Qvg8WX
	 fYl9a24xwBY3dRbnuGHiTWkR8o3njSpgppd35JLDzSAecqC7NUFCzX+ylDJkehhs4p
	 6HviPVD+OOsMHHEpneyZw4RTA/xmdauDaFxtcpUzqyZpwz1NGNuScM8T7e57+6VcMI
	 6ZieARskZLnqPKuPwRrjaukz9bp+UQcNOonoRh6VieL37/vJVefEzkzKosaJ1iUd4N
	 YFFklHxAsPgBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ECCF8CE0B67; Thu, 20 Jun 2024 12:58:21 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:58:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: [PATCH] bcachefs: pending_rcu_items
Message-ID: <76949f69-f7d4-4685-9b0b-e2d4053fb048@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
 <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>
 <b2d51ae1-a871-426f-8d99-892558c9c8d1@paulmck-laptop>
 <bt4s5nvorwkx3tkcxcmftz64ygazg5dlpz2l7mfdihere2632r@2vx3ecfedarp>
 <42c7e546-ddba-4ea3-bca4-221ba389dc15@paulmck-laptop>
 <rymtkrmhirxzu6ae4atlxedegq5octoyvjz3veuuca6ee7axmi@4qyj35l3dtuj>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rymtkrmhirxzu6ae4atlxedegq5octoyvjz3veuuca6ee7axmi@4qyj35l3dtuj>

On Tue, Jun 18, 2024 at 09:45:33AM -0400, Kent Overstreet wrote:
> On Mon, Jun 17, 2024 at 08:57:37PM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 17, 2024 at 10:24:54PM -0400, Kent Overstreet wrote:
> > > On Mon, Jun 17, 2024 at 05:15:29PM -0700, Paul E. McKenney wrote:
> > > > If it ever becomes helpful to make this work for any of the RCU Tasks
> > > > flavors, the rcutorture_type enum from kernel/rcu/rcu.h might be of help.
> > > > Until then, NULL works just fine.
> > > 
> > > Certainly
> > > 
> > > > > - Tracks pending items in a radix tree; falls back to linked list if
> > > > >   radix tree allocation fails
> > > > 
> > > > I am still having trouble seeing what a radix tree brings to the table
> > > > in this case, but again, migtht as well dig in.
> > > 
> > > It's simpler, and (marginally) more efficient than list-of-pages.
> > > 
> > > My new implementation of kvfree_call_rcu() on top of this data structure
> > > is now looking faster than the existing version - and I'm using smaller
> > > nodes (512 bytes instead of full pages).
> > 
> > OK.  We will need to look carefully at the performance comparisons.
> > Lots of places for overhead to hide in both schemes.  ;-)
> 
> If you want to take a look at where I'm going now or possibly benchmark
> it yourself - https://evilpiepirate.org/git/bcachefs.git/log/?h=rcu_pending

I do see the swap of the __call_rcu() and the p->rcu_armed assignment,
so that is good.

I am unlikely to get to benchmarking during the next week or two.

I rebased the SRCU polled-API commits on top of v6.10-rc1 and am looking
to send them into the v6.11 merge window:

	395e73bd8d35f srcu: Add NUM_ACTIVE_SRCU_POLL_OLDSTATE
	d7b0615cb8d24 srcu: Update cleanup_srcu_struct() comment
	e206f33e2c077 srcu: Fill out polled grace-period APIs

Or if you would prefer the email versions:

https://lore.kernel.org/all/8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop/

This provides the NUM_ACTIVE_SRCU_POLL_OLDSTATE number and the
same_state_synchronize_srcu() function.  Currently, your code is assuming
that NUM_ACTIVE_RCU_POLL_OLDSTATE and NUM_ACTIVE_SRCU_POLL_OLDSTATE are
the same, and as noted earlier, there could be changes to SRCU expedited
grace periods that changed that current lucky coincidence.

> messy, wip: I still have yet to document anything, and I've ripped out
> the shrinker (along with the entire prior kvfree_call_rcu()
> implementation), and haven't redone that yet - and this version does
> have the issue that we're processing pending frees in kvfree_call_rcu()
> context.

One thing is that although processing pending frees in caller context
does have the locking restriction, it also has the benefit of pushing
overhead from the deferred-free context back to the caller context.
This has system-stability benefits by reducing the ability of the
calling context to overload the context doing the actual freeing.

Tradeoffs, tradeoffs...

> But it does work and pass tests...

Very good!

> > > To be honest, I'm still not getting your intended use of the other
> > > helpers; to be honest, just comparing sequence numbers with
> > > ULONG_CMP_GE/LT seems simplest to my brain.
> > 
> > From your reply later on, I believe that we are OK.  I will see with
> > your next version.  ;-)
> 
> I only just last night realized that there's really just a single
> sequence number internally; exposing that simplifies things
> _considerably_, many weird corner cases races go away when we're only
> grabbing the current RCU sequence number once.

OK, I will bite...  Why can't you get that same effect by calling
get_state_synchronize_srcu() at that same place?

And that sequence number is not guaranteed to continue acting like a
simple sequence number, again should expedited SRCU grace periods need
optimizing.

> > The time that this matters is when someone is invoking this in a tight
> > loop, in which case the branch predictor will to quite well, given that
> > grace periods take some time to complete.
> 
> Code size matters - and more than that, we're moving towards RCU-ifying
> a bigger and bigger fraction of total allocations in the system (e.g.
> recent talk about rcu-freeing all page cache pages!).
> 
> So we really should be aiming to have this path be just as optimized as
> the main slub paths.

???

The main slub paths are used on fastpaths featuring frees and allocations
in quick sequence.  In constrast, this should not be a fastpath, instead
your fastpath is code paths doing srcu_read_lock(), correct?

> Also, code size: rcu_pending.o, stripped, is just 5kb. I've got the main
> __rcu_pending_enqueue() fastpath down to ~600 bytes.

Very nice, but this is not a fastpath.  The fast paths are the read-side
primitives, srcu_read_lock() and friends.

> > For a sufficiently constrained system (and your bcachefs use case might
> > qualify for all I know), this might work very well.  The problem is that
> > "trusted" would need to include "not running on a hypervisor" and "not
> > running with firmware having longer-than-average SMIs.  :-(
> 
> But in those cases RCU is also going to be blocked from ending existing
> grace periods, and since we have a hard limit on the number of
> outstanding grace periods that means we can't start new ones either.

For RCU, mostly agreed.  For SRCU, vCPU preemption usually does not
block grace periods.

> This feels like something we can solve with some finesse, not a real
> blocker.
> 
> Now - where to shove the processing is a real question. Ideally process
> context, but can't (in general) be in the calling context.

Especially in cases where the calling context is under srcu_read_lock().

> Actually, process context feels wrong for this (at least kvfree_rcu())
> completions), given that the completions need to run with essentially
> realtime priority - that's really a job for softirq context, so maybe we
> just want to ditch the workqueues.

Sometimes you do want to run the object processing at real-time priority,
hence the rcutree.kthread_prio kernel-boot parameter.  But most of the
time you really do not want that stuff running at real-time priority.
Trust me, you really do not want to process a million object objects
while running at real-time priority if the application has any sort of
latency constraint, and most do these days.

> But running completions in call_rcu() context (not existing call_rcu(),
> since we need to annotate paths where this is ok, but the moral
> equivalent) does seem to be a lovely tool for avoiding use of softirq
> context while ensuring they still get done :)

There are always the rcuc and rcuo kthreads, but they still run the
callbacks in BH-disabled context.  In your case, you aren't needing to
deal with deferrals from irq-disabled contexts, so workqueues should be
a better bet.

> > > Yes, and in my latest version that's stricter about avoiding preemption,
> > > the lock is only necessary for dequeue_from_all() - all other options
> > > are careful to only work on the CPU local version now.
> > 
> > Using migration_disable() or similar?
> 
> Nope, just local_irq_save(). Gotta disable preemption anyways :)

As long as you don't disable preemption across object processing.  ;-)

> > Suppose that there has been a huge pile of objects queued up over the past
> > while, so that both ->objs[] elements are quite full.  Suppose that,
> > just by chance, the ->obj[0] ->seq is the first to have its grace
> > period complete.  Suppose further that just at that point in time, the
> > object-queuing rate suddenly decreases.  So much so, that at least one
> > full grace period elapses between queuing of individual objects.
> 
> Not sure what you mean by full? This seems like a rather vague thought
> experiment :)

A sharp sudden change in load is an important validation techinque for
RCU.  And not just RCU, but also throughout engineering.  For example,
in mechanical engineering, they often use hammers of various sizes for
this purpose.

> Anyways, I've now got things ordered so objs[0] is always newer, objs[1]
> (if nonempty) completes first, and we can pick the one we need with
> simple array indexing.
> 
> Very nice improvement on code size (balances out all the inlining I've
> added).

Again, as noted in earlier discussion, the return values from
get_state_synchronize_rcu() are not guaranteed to be fully ordered.
Yes, they happen to be fully ordered now, but...

Module boundaries are an important maintainability tool, even within
the confines of a given source directory.  ;-)

> > Perhaps there are things we could do to make the pages of pointers better.
> > Or maybe we should adopt radix tree, though it still seems like a very
> > strange fit.  Some careful performance analysis will need to drive this
> > choice.  Avoiding ever forgetting the "status quo" option.
> 
> To my eyes, the kernel tendency to always reach for linked lists first
> seems strange, to me :)
> 
> I just don't use linked lists that much in my own code.

OK, but they still have their strengths and their uses.

> > > > Also, I am not seeing a ->pending() field in the pending_rcu_items_seq
> > > > structure.  Again, what am I missing?
> > > 
> > > Not necessary, since it's pending iff it has items - except you indicate
> > > a callback, so perhas you're thinking of something else?
> > 
> > My typo, ->process(), not ->pending().  Apologies for my confusion!
> 
> It's in the parent, non-percpu struct :)

Thank you, and once I started searching for the correct string, I did
find it.

> > > It's a bit unfortunate that we still don't have a way of checking
> > > (outside of debug code) "are we in sleepable process context?" - that'll
> > > have to be passed in.
> > 
> > That might arrive with lazy preemption.  It would untangle quite a few
> > knots in many parts of RCU, that is for sure.
> 
> yeah, trouble is it would make spinlocks/local_irq_save() a good deal
> more expensive :/

There appears to be some PowerPC heartburn with it, but yes, making that
information explicit is not free.

> > My advice is as follows:
> > 
> > 1.	Pick up the cookie, whether from get_synchronize_srcu() or
> > 	poll_state_synchronize_rcu().
> 
> Ok, so it sounds like we're thinking along the same lines then. That's
> the approach I came up with last night as well.
> 
> > 
> > 2.	If that cookie matches one of the ->objs[]->seq, add it to
> > 	that ->objs[].  Null the pointer or whatever to record that
> > 	it is already taken care of.  Or just take an early exit.
> > 
> > 	If under heavy load, this will be the common-case code path.
> > 
> > 3.	Only then try processing the ->objs[] elements.
> > 
> > 4.	Yes, then you need to queue the thing, but you can make
> > 	#2 above be an inline function to avoid duplicating code.
> > 	And you can check to see if the cookie already expired,
> > 	in which case you can just process it immediately.
> > 
> > 	You only need to retry in case of memory-allocation failure.
> > 
> > Does that make sense?
> 
> That's roughly what the code is doing now (as of last night), with the
> exception that it's still always checking for elements to process first.

OK, I am good with that being configurable, at least unless or until
one option proves uniformly better than the other.

> Will have to make that configurable for kvfree_call_rcu()/call_rcu().
> 
> > > > > +	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> > > > > +		if (objs->nr && objs->seq == seq)
> > > > 
> > > > OK, the purpose of same_state_synchronize_srcu() is to make that
> > > > equality comparison work no matter what debugging information we might
> > > > need to put in the cookie returned from get_state_synchronize_srcu().
> > > > Or, for that matter, poll_state_synchronize_srcu().
> > > > 
> > > > So please use same_state_synchronize_srcu(objs->seq,seq) here.
> > > 
> > > Done
> > 
> > Thank you!
> 
> heh, and then deleted, because I switched to grabbing the raw counter
> (and doing the masking myself).
> 
> But I'm now masking off the debug bits first thing, so - tell me what
> you think :)

I am sorry, but we really need to maintain some modularity here, especially
given that this is not a fastpath.

> > You can probably instead call get_state_synchronize_srcu() to begin
> > with, and let the later call_srcu() start the grace period if needed.
> > The only exception I can imagine to this right off-hand is under heavy
> > load, where you might need to start the grace period sooner rather than
> > later.  But that is easy -- if you have too many objects piled up, call
> > poll_state_synchronize_srcu() instead of get_state_synchronize_srcu().
> 
> I think there's another issue, where we may have items for two different
> grace periods when we need to arm the callback - and then we want it to
> fire when the _older_ grace period completes.
> 
> Do you have a call_rcu() for a specific grace period seq? :)

I do not see why you would need that in this case.

If you use get_state_synchronize_srcu() to pick up the initial cookie,
you have that cookie.  If !rcu_armed, you invoke call_srcu(), which
will respond to exactly the grace period that you need it to.  You only
ever have the one SRCU callback, so the delays from the end of that
grace period to the invocation of that callback is down in the noise.
Within that callback, you check whether there are additional objects
in need of another grace period, and if so, another call_srcu() will do
exactly the additional grace period you need.

Yes, there is a race condition where objects arrive between the grace
period ending and the callback being invoked, but those will be taken
care of at the end of the next grace period.

What am I missing here?

							Thanx, Paul
