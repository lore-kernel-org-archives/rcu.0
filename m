Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD512B95
	for <rcu@vger.kernel.org>; Tue, 18 Jun 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718341; cv=none; b=mhpTIj8dunN43MnbzdFrnx0PeY5zcKvUvV4mp00kkcFMX8XL5mC6LMBjKAnTaoXAax+Bp8+8Ud5kWzW+7lyxA8mup4gxAjltqs0mxG/L/emeRL6hFljpQL1EwrAuZR4VJiZAMHz39lZAr/Z2rapnUm8iQGWQfP19FNz60BfAp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718341; c=relaxed/simple;
	bh=lzNHQ2ayFB3+X1QeY9IH2GTDF4LQ7/on9MpmLfMWN+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7yEPK754SDhd7U1CLd9l/u3nyRFEdF20H2X7yvMkyQuDbmqLBjFp5ES/e8PUbwqRtw7DttREFuTOeIoT+nNpXjnyNjhNeztQOqehFD5r9xTwUsQ3rQCS0gUK880LqSFfwGEKQwNPQGNaoqte5tObEdrtBSpxnAHMGe5svlWrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qtsm7FNi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qtsm7FNi"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718718337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1jinp2enU89CtZ3ktwSR227adYDF3GglGByomcduZYg=;
	b=Qtsm7FNi1fqPbiaRXQQI0sKsBawRgxzoN6la3sSYBdhN+vXVSzk8/1EAYXX/xNDCtf65g2
	L0eqBf8CLiDekn1B43okc9OmAlV8uDF72MbbFilIpMxoouk5w2mzNFyt3M5DNIcqtJuTYF
	NZLZQ6pnbHFKvr+g1zCsSTbu4kiT1qU=
X-Envelope-To: rcu@vger.kernel.org
Date: Tue, 18 Jun 2024 09:45:33 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: [PATCH] bcachefs: pending_rcu_items
Message-ID: <rymtkrmhirxzu6ae4atlxedegq5octoyvjz3veuuca6ee7axmi@4qyj35l3dtuj>
References: <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
 <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>
 <b2d51ae1-a871-426f-8d99-892558c9c8d1@paulmck-laptop>
 <bt4s5nvorwkx3tkcxcmftz64ygazg5dlpz2l7mfdihere2632r@2vx3ecfedarp>
 <42c7e546-ddba-4ea3-bca4-221ba389dc15@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c7e546-ddba-4ea3-bca4-221ba389dc15@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 17, 2024 at 08:57:37PM -0700, Paul E. McKenney wrote:
> On Mon, Jun 17, 2024 at 10:24:54PM -0400, Kent Overstreet wrote:
> > On Mon, Jun 17, 2024 at 05:15:29PM -0700, Paul E. McKenney wrote:
> > > If it ever becomes helpful to make this work for any of the RCU Tasks
> > > flavors, the rcutorture_type enum from kernel/rcu/rcu.h might be of help.
> > > Until then, NULL works just fine.
> > 
> > Certainly
> > 
> > > > - Tracks pending items in a radix tree; falls back to linked list if
> > > >   radix tree allocation fails
> > > 
> > > I am still having trouble seeing what a radix tree brings to the table
> > > in this case, but again, migtht as well dig in.
> > 
> > It's simpler, and (marginally) more efficient than list-of-pages.
> > 
> > My new implementation of kvfree_call_rcu() on top of this data structure
> > is now looking faster than the existing version - and I'm using smaller
> > nodes (512 bytes instead of full pages).
> 
> OK.  We will need to look carefully at the performance comparisons.
> Lots of places for overhead to hide in both schemes.  ;-)

If you want to take a look at where I'm going now or possibly benchmark
it yourself - https://evilpiepirate.org/git/bcachefs.git/log/?h=rcu_pending

messy, wip: I still have yet to document anything, and I've ripped out
the shrinker (along with the entire prior kvfree_call_rcu()
implementation), and haven't redone that yet - and this version does
have the issue that we're processing pending frees in kvfree_call_rcu()
context.

But it does work and pass tests...

> > To be honest, I'm still not getting your intended use of the other
> > helpers; to be honest, just comparing sequence numbers with
> > ULONG_CMP_GE/LT seems simplest to my brain.
> 
> From your reply later on, I believe that we are OK.  I will see with
> your next version.  ;-)

I only just last night realized that there's really just a single
sequence number internally; exposing that simplifies things
_considerably_, many weird corner cases races go away when we're only
grabbing the current RCU sequence number once.

> The time that this matters is when someone is invoking this in a tight
> loop, in which case the branch predictor will to quite well, given that
> grace periods take some time to complete.

Code size matters - and more than that, we're moving towards RCU-ifying
a bigger and bigger fraction of total allocations in the system (e.g.
recent talk about rcu-freeing all page cache pages!).

So we really should be aiming to have this path be just as optimized as
the main slub paths.

Also, code size: rcu_pending.o, stripped, is just 5kb. I've got the main
__rcu_pending_enqueue() fastpath down to ~600 bytes.

> For a sufficiently constrained system (and your bcachefs use case might
> qualify for all I know), this might work very well.  The problem is that
> "trusted" would need to include "not running on a hypervisor" and "not
> running with firmware having longer-than-average SMIs.  :-(

But in those cases RCU is also going to be blocked from ending existing
grace periods, and since we have a hard limit on the number of
outstanding grace periods that means we can't start new ones either.

This feels like something we can solve with some finesse, not a real
blocker.

Now - where to shove the processing is a real question. Ideally process
context, but can't (in general) be in the calling context.

Actually, process context feels wrong for this (at least kvfree_rcu())
completions), given that the completions need to run with essentially
realtime priority - that's really a job for softirq context, so maybe we
just want to ditch the workqueues.

But running completions in call_rcu() context (not existing call_rcu(),
since we need to annotate paths where this is ok, but the moral
equivalent) does seem to be a lovely tool for avoiding use of softirq
context while ensuring they still get done :)

> > Yes, and in my latest version that's stricter about avoiding preemption,
> > the lock is only necessary for dequeue_from_all() - all other options
> > are careful to only work on the CPU local version now.
> 
> Using migration_disable() or similar?

Nope, just local_irq_save(). Gotta disable preemption anyways :)

> Suppose that there has been a huge pile of objects queued up over the past
> while, so that both ->objs[] elements are quite full.  Suppose that,
> just by chance, the ->obj[0] ->seq is the first to have its grace
> period complete.  Suppose further that just at that point in time, the
> object-queuing rate suddenly decreases.  So much so, that at least one
> full grace period elapses between queuing of individual objects.

Not sure what you mean by full? This seems like a rather vague thought
experiment :)

Anyways, I've now got things ordered so objs[0] is always newer, objs[1]
(if nonempty) completes first, and we can pick the one we need with
simple array indexing.

Very nice improvement on code size (balances out all the inlining I've
added).

> Perhaps there are things we could do to make the pages of pointers better.
> Or maybe we should adopt radix tree, though it still seems like a very
> strange fit.  Some careful performance analysis will need to drive this
> choice.  Avoiding ever forgetting the "status quo" option.

To my eyes, the kernel tendency to always reach for linked lists first
seems strange, to me :)

I just don't use linked lists that much in my own code.

> > > Also, I am not seeing a ->pending() field in the pending_rcu_items_seq
> > > structure.  Again, what am I missing?
> > 
> > Not necessary, since it's pending iff it has items - except you indicate
> > a callback, so perhas you're thinking of something else?
> 
> My typo, ->process(), not ->pending().  Apologies for my confusion!

It's in the parent, non-percpu struct :)

> > It's a bit unfortunate that we still don't have a way of checking
> > (outside of debug code) "are we in sleepable process context?" - that'll
> > have to be passed in.
> 
> That might arrive with lazy preemption.  It would untangle quite a few
> knots in many parts of RCU, that is for sure.

yeah, trouble is it would make spinlocks/local_irq_save() a good deal
more expensive :/

> My advice is as follows:
> 
> 1.	Pick up the cookie, whether from get_synchronize_srcu() or
> 	poll_state_synchronize_rcu().

Ok, so it sounds like we're thinking along the same lines then. That's
the approach I came up with last night as well.

> 
> 2.	If that cookie matches one of the ->objs[]->seq, add it to
> 	that ->objs[].  Null the pointer or whatever to record that
> 	it is already taken care of.  Or just take an early exit.
> 
> 	If under heavy load, this will be the common-case code path.
> 
> 3.	Only then try processing the ->objs[] elements.
> 
> 4.	Yes, then you need to queue the thing, but you can make
> 	#2 above be an inline function to avoid duplicating code.
> 	And you can check to see if the cookie already expired,
> 	in which case you can just process it immediately.
> 
> 	You only need to retry in case of memory-allocation failure.
> 
> Does that make sense?

That's roughly what the code is doing now (as of last night), with the
exception that it's still always checking for elements to process first.

Will have to make that configurable for kvfree_call_rcu()/call_rcu().

> > > > +	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> > > > +		if (objs->nr && objs->seq == seq)
> > > 
> > > OK, the purpose of same_state_synchronize_srcu() is to make that
> > > equality comparison work no matter what debugging information we might
> > > need to put in the cookie returned from get_state_synchronize_srcu().
> > > Or, for that matter, poll_state_synchronize_srcu().
> > > 
> > > So please use same_state_synchronize_srcu(objs->seq,seq) here.
> > 
> > Done
> 
> Thank you!

heh, and then deleted, because I switched to grabbing the raw counter
(and doing the masking myself).

But I'm now masking off the debug bits first thing, so - tell me what
you think :)

> You can probably instead call get_state_synchronize_srcu() to begin
> with, and let the later call_srcu() start the grace period if needed.
> The only exception I can imagine to this right off-hand is under heavy
> load, where you might need to start the grace period sooner rather than
> later.  But that is easy -- if you have too many objects piled up, call
> poll_state_synchronize_srcu() instead of get_state_synchronize_srcu().

I think there's another issue, where we may have items for two different
grace periods when we need to arm the callback - and then we want it to
fire when the _older_ grace period completes.

Do you have a call_rcu() for a specific grace period seq? :)
