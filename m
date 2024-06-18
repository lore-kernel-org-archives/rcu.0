Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7D4C6D
	for <rcu@vger.kernel.org>; Tue, 18 Jun 2024 03:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683058; cv=none; b=dtSTOTf5BdH/kbFkFwhVIuki5SUCMqcQFCC4xaBbyiZd5CAVorhLSu53PU2AySup2O04mzG5330AhULD1TEp+7A6TW1Pn7BlVDIGNMUHsJ+QAn8vRriHmAwqZ6GuW8G8pnI4Qke/3MAawkFidBaGbHotBKfurEzmD00d6+Tn5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683058; c=relaxed/simple;
	bh=U+B/CZq6MyieKDMS2EZyn6WVFxi4OxsHhkFGOhV5EU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptbq5cxw0wMJ5NSrwsHjGUVN4+qNxTSOrwOaWgPtNsyhjC0L4Mwef08LK0sP7OCMhr91RVjzg4wd2M4EQgXLalTab98WKrlXE+rcJLZ0oe1uMPIvEqBcTp1lJ9qaJqdMNxUiuh0B/aCE69vA6d0arMMQHT0Y/5fqJ22ZByK6zVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTJyzEFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTJyzEFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6F1C3277B;
	Tue, 18 Jun 2024 03:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683058;
	bh=U+B/CZq6MyieKDMS2EZyn6WVFxi4OxsHhkFGOhV5EU0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jTJyzEFGRRFFfvnjR+gBTmmM04dbW56KHNcs39lYbRhEP7cfCaAD4vFGy0xA05w2C
	 x59UxYtsKQym28IGt6MeBDk8ADgsefGKYKirQNFHhd6fUKcZ1YQ2uGJpL+VIZZnEoN
	 ENZnmexO8qgRGktndDf8EIWn5X0ezTSvC3uGv+8lXZjACXStyTpSbbmAFYdrk+JoKb
	 cztiyCYQG05Cew/5J21wHO2Y/Rz4V77VwE+l2c4/cHd+QuBb8w4CG153Lr3DMr6l3L
	 mLKspJc6rZ8vhOa5zc5gDb9oJ6rvAIiHPy6DP/6fcz1jYFiA67lSX7s2ZT5mCGHJNy
	 8QKFrFSK6miqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E19F5CE0E5A; Mon, 17 Jun 2024 20:57:37 -0700 (PDT)
Date: Mon, 17 Jun 2024 20:57:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: [PATCH] bcachefs: pending_rcu_items
Message-ID: <42c7e546-ddba-4ea3-bca4-221ba389dc15@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
 <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>
 <b2d51ae1-a871-426f-8d99-892558c9c8d1@paulmck-laptop>
 <bt4s5nvorwkx3tkcxcmftz64ygazg5dlpz2l7mfdihere2632r@2vx3ecfedarp>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bt4s5nvorwkx3tkcxcmftz64ygazg5dlpz2l7mfdihere2632r@2vx3ecfedarp>

On Mon, Jun 17, 2024 at 10:24:54PM -0400, Kent Overstreet wrote:
> On Mon, Jun 17, 2024 at 05:15:29PM -0700, Paul E. McKenney wrote:
> > If it ever becomes helpful to make this work for any of the RCU Tasks
> > flavors, the rcutorture_type enum from kernel/rcu/rcu.h might be of help.
> > Until then, NULL works just fine.
> 
> Certainly
> 
> > > - Tracks pending items in a radix tree; falls back to linked list if
> > >   radix tree allocation fails
> > 
> > I am still having trouble seeing what a radix tree brings to the table
> > in this case, but again, migtht as well dig in.
> 
> It's simpler, and (marginally) more efficient than list-of-pages.
> 
> My new implementation of kvfree_call_rcu() on top of this data structure
> is now looking faster than the existing version - and I'm using smaller
> nodes (512 bytes instead of full pages).

OK.  We will need to look carefully at the performance comparisons.
Lots of places for overhead to hide in both schemes.  ;-)

> > > +static inline unsigned long __start_poll_synchronize_rcu(struct srcu_struct *ssp)
> > > +{
> > > +	return ssp
> > > +		? start_poll_synchronize_srcu(ssp)
> > > +		: start_poll_synchronize_rcu();
> > > +}
> > 
> > I don't get why you 
> > 
> > > +static inline void __rcu_barrier(struct srcu_struct *ssp)
> > > +{
> > > +	return ssp
> > > +		? srcu_barrier(ssp)
> > > +		: rcu_barrier();
> > > +}
> > 
> > You will likely need something like these:
> > 
> > static inline void __get_completed_synchronize_rcu(struct srcu_struct *ssp)
> > {
> > 	return ssp
> > 		? get_completed_synchronize_srcu(ssp)
> > 		: get_completed_synchronize_rcu();
> > }
> > 
> > static inline void __same_state_synchronize_rcu(struct srcu_struct *ssp)
> > {
> > 	return ssp
> > 		? same_state_synchronize_srcu(ssp)
> > 		: same_state_synchronize_rcu();
> > }
> > 
> > The point of these is to get around the earlier issue where three cookies
> > appeared to be valid due to time delays.  But perhaps you found some
> > other way around that.
> 
> Yes, that comes from a race between poll_state_synchronize() and
> start_poll_synchronize(), easily handled with a loop.

Plus call_srcu() can also get its oar in.  But more later.

> To be honest, I'm still not getting your intended use of the other
> helpers; to be honest, just comparing sequence numbers with
> ULONG_CMP_GE/LT seems simplest to my brain.

From your reply later on, I believe that we are OK.  I will see with
your next version.  ;-)

> > OK, this does appear like each group of objs gets its own return value from
> > either __start_poll_synchronize_rcu() or __get_state_synchronize_rcu().  If
> > so, much improved!
> 
> To be honest I still prefer the old way.
> 
> This scheme requires multiple loops over the array, which leads to the
> kvfree_call_rcu() based on this being quite branchy; the generated code
> could be a fair bit slimmer with the old scheme.

The time that this matters is when someone is invoking this in a tight
loop, in which case the branch predictor will to quite well, given that
grace periods take some time to complete.

> > The purpose of this rcu_head is as before, to flag good times to invoke
> > poll_state_synchronize_rcu()?
> 
> Correct
> 
> > I need to check what the caller does with it, of course.  And one caller
> > appears to invokes it from a workqueue handler, the other from unknown
> > context.  But you said earlier that all were from process context,
> > so that should be fine.  Having the submitters do processing does have
> > nice overload-handling characteristics, though it might be more prone
> > to deadlock.  (As in you cannot acquire a mutex in the callback that is
> > held across a call to the bch2_pending_rcu_item_enqueue() function.)
> 
> That's true for my use in bcachefs, but thanks for pointing that out,
> that does look like a real problem for using this for a
> kvfree_call_rcu() replacement.
> 
> kvfree_call_rcu() can't necessarily process completions in the caller,
> since it can be called from interrupt context; that means unbounded
> grace periods with uncompleted callbacks build up unbounded work.
> 
> And, with these data structures that would be really painful.

Agreed, if you can keep your object queueing in preempt-enabled task
context, life is much easier.  But yes, kfree_rcu() doesn't get that
luxury, nor does call_rcu().

> Which leads me to wonder, how conceivable would it be to put a limit on
> the number of grace periods with uncompleted callbacks? Use of that
> interface would have to be limited to trusted code (because it could
> stall the system!), but I wonder if it might have positive effects on
> overload behaviour.
> 
> Hmm.

For a sufficiently constrained system (and your bcachefs use case might
qualify for all I know), this might work very well.  The problem is that
"trusted" would need to include "not running on a hypervisor" and "not
running with firmware having longer-than-average SMIs.  :-(

> > What provides synchronization for this function?  It looks like it can
> > be invoked from multiple contexts.  Ah, the pending_rcu_items_pcpu
> > structure's ->lock, which is dropped after invoking this but before
> > processing the objects.
> 
> Yes, and in my latest version that's stricter about avoiding preemption,
> the lock is only necessary for dequeue_from_all() - all other options
> are careful to only work on the CPU local version now.

Using migration_disable() or similar?

> > If both elements are ready to process, it looks like you only process
> > the first one that you come to.  Why not look at both and return both
> > if both are ready?
> > 
> > A linked list of pages of pointers would make this possible by simply
> > concatenating the lists, right?
> > 
> > Or am I missing something that forces the second element of the array
> > to be checked?
> 
> The elements of the array aren't ordered now (per your scheme). But
> perhaps they still could be.

Well, they are, not in terms of the ->seq value, but in terms of the
index.

Suppose that there has been a huge pile of objects queued up over the past
while, so that both ->objs[] elements are quite full.  Suppose that,
just by chance, the ->obj[0] ->seq is the first to have its grace
period complete.  Suppose further that just at that point in time, the
object-queuing rate suddenly decreases.  So much so, that at least one
full grace period elapses between queuing of individual objects.

Ah, the loop in pending_rcu_items_work() should take care of things
here, maybe.

> > I might be missing something, but it looks like a linked list of pages of
> > pointers would do better here, especially if there are a lot of callbacks.
> > So what am I missing?
> 
> I'll be improving the genradix iterator code to avoid the radix tree
> walk except when crossing nodes.
> 
> I _much_ prefer using a standard data structure instead of hand rolling,
> and this code is both cleaner and more compact - and faster.

Perhaps there are things we could do to make the pages of pointers better.
Or maybe we should adopt radix tree, though it still seems like a very
strange fit.  Some careful performance analysis will need to drive this
choice.  Avoiding ever forgetting the "status quo" option.

> > Also, I am not seeing a ->pending() field in the pending_rcu_items_seq
> > structure.  Again, what am I missing?
> 
> Not necessary, since it's pending iff it has items - except you indicate
> a callback, so perhas you're thinking of something else?

My typo, ->process(), not ->pending().  Apologies for my confusion!

> > OK, processing this with interrupts enabled is a great improvement!
> > 
> > Also doing it in workqueue context is a good thing.  I don't yet have
> > an opinion about how this code handles overload conditions.
> 
> > > +void bch2_pending_rcu_item_enqueue(struct pending_rcu_items *pending, struct rcu_head *obj)
> > 
> > As noted earlier, I am assuming that this is invoked from task context
> > with preemption enabled.
> 
> In my usage, yes. I would prefer to not require that.
> 
> It's a bit unfortunate that we still don't have a way of checking
> (outside of debug code) "are we in sleepable process context?" - that'll
> have to be passed in.

That might arrive with lazy preemption.  It would untangle quite a few
knots in many parts of RCU, that is for sure.

> > It might be worth a comment stating that the ->process() function cannot
> > acquire any mutex held across a call to bch2_pending_rcu_item_enqueue().
> 
> Yes, and a note about it being called from enqueue()

Very good!

> > > +	struct pending_rcu_items_seq finished;
> > > +	while (get_finished_items(pending, p, &finished)) {
> > > +		spin_unlock_irqrestore(&p->lock, flags);
> > > +		process_finished_items(pending, &finished);
> > > +		goto retry;
> > 
> > This loop could be avoided by passing obj in to get_finished_items(),
> > and having that function enqueue obj just after emptying things.  Yes,
> > an infinite loop requires an improbably repeated sequence of preemptions
> > and migrations, but why not eliminate the possibility?
> 
> I've reworked this code somewhat to inline fastpaths and move slowpath
> to separate functions, have a look at the latest when I post it.

Looking forward to it.

> > > +	struct pending_rcu_items_seq *objs;
> > > +
> > > +	unsigned long seq = __get_state_synchronize_rcu(pending->srcu);
> > 
> > Invoking __get_state_synchronize_rcu() before the call to get_finished_items()
> > could save you some latency.
> 
> ??

It is always the same object, and it has the same history being
reader-visible.  So get the cookie as early as possible and keep that
cookie.  Just because you took time out to process some objects does
not mean you need a newer cookie, after all.

My advice is as follows:

1.	Pick up the cookie, whether from get_synchronize_srcu() or
	poll_state_synchronize_rcu().

2.	If that cookie matches one of the ->objs[]->seq, add it to
	that ->objs[].  Null the pointer or whatever to record that
	it is already taken care of.  Or just take an early exit.

	If under heavy load, this will be the common-case code path.

3.	Only then try processing the ->objs[] elements.

4.	Yes, then you need to queue the thing, but you can make
	#2 above be an inline function to avoid duplicating code.
	And you can check to see if the cookie already expired,
	in which case you can just process it immediately.

	You only need to retry in case of memory-allocation failure.

Does that make sense?

> > > +	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> > > +		if (objs->nr && objs->seq == seq)
> > 
> > OK, the purpose of same_state_synchronize_srcu() is to make that
> > equality comparison work no matter what debugging information we might
> > need to put in the cookie returned from get_state_synchronize_srcu().
> > Or, for that matter, poll_state_synchronize_srcu().
> > 
> > So please use same_state_synchronize_srcu(objs->seq,seq) here.
> 
> Done

Thank you!

> > I wasn't kidding.  That call to __start_poll_synchronize_rcu() absolutely
> > must precede that call to get_finished_items().  ;-)
> 
> Except start_poll_synchronize_rcu() is higher overhead than
> get_state_synchronize_rcu() - the idea is to avoid calling it when we
> know it's not necessary because we already have items for that sequence
> number.

You can probably instead call get_state_synchronize_srcu() to begin
with, and let the later call_srcu() start the grace period if needed.
The only exception I can imagine to this right off-hand is under heavy
load, where you might need to start the grace period sooner rather than
later.  But that is easy -- if you have too many objects piled up, call
poll_state_synchronize_srcu() instead of get_state_synchronize_srcu().

And there are ways of avoiding even that get_state_synchronize_srcu()
in the common case, but at the cost of additional complexity.  So later,
when and if.

> But I think there must be a better way to do this, and we shouldn't be
> calling start_poll() multiple times when we're looping, yeah.

Whew!!!  ;-)

> > > +	struct rcu_head **entry;
> > > +add:
> > > +	entry = genradix_ptr_alloc(&objs->objs, objs->nr, GFP_ATOMIC|__GFP_NOWARN);
> > > +	if (likely(entry)) {
> > > +		*entry = obj;
> > > +		objs->nr++;
> > > +	} else if (likely(!alloc_failed)) {
> > > +		spin_unlock_irqrestore(&p->lock, flags);
> > > +		alloc_failed = !genradix_ptr_alloc(&objs->objs, objs->nr, GFP_KERNEL);
> > 
> > Just so you know, the corresponding part of kfree_rcu() was the subject
> > of much churn as the mm system evolved.  But you can only go through this
> > retry loop twice, so I am OK, with it.
> > 
> > But you really want to keep this structure, you also really want to call
> > __start_poll_synchronize_rcu() before the retry: label.
> > 
> > If nothing else, you can check the cookie on allocation failure, and if it
> > has expired, just immediately free the object.
> 
> Yeah, that's a good thought.
> 
> > > +	if (!p->rcu_armed) {
> > > +		call_srcu(pending->srcu, &p->rcu, pending_rcu_items_rcu_cb);
> > > +		p->rcu_armed = true;
> > 
> > In the other order, please!
> > 
> > Yes, you have interrupts disabled here, but you are not in an SRCU
> > read-side critical section, and a hypervisor isn't necessarily going to
> > know or care about your interrupt-disabled state.  So the way that the
> > code is written, you really can have the SRCU callback invoked before
> > setting ->rcu_armed to true, which might not be a good thing.
> > 
> > Especially given that it won't happen very often.  Except on large
> > fleets.  ;-)
> 
> Noted :)
> 
> > > +struct rcu_head *bch2_pending_rcu_item_dequeue_from_all(struct pending_rcu_items *pending)
> > > +{
> > > +	struct rcu_head *ret = NULL;
> > > +	int cpu;
> > > +	for_each_possible_cpu(cpu) {
> > > +		ret = pending_rcu_item_pcpu_dequeue(per_cpu_ptr(pending->p, cpu));
> > > +		if (ret)
> > > +			break;
> > > +	}
> > > +	return ret;
> > > +}
> > 
> > I assume that the point of these guys is to recycle objects that are
> > waiting for their RCU grace period, similar to SLAB_TYPESAFE_BY_RCU.
> > Readers would of course need the same sort of checks as used by readers
> > traversing memory from SLAB_TYPESAFE_BY_RCU slabs.
> > 
> > If my assumption is correct, handing out the oldest items minimizes the
> > amount of retrying these readers need to do.
> 
> I hand out the newest to minize stranding - if we're trying to return
> memory to the rest of the system, we don't want to reuse the objects
> we're about to be able to free.

Fair enough, and I agree that it is not a trivial tradeoff.

							Thanx, Paul
