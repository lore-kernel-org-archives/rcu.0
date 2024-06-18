Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6271CAB8
	for <rcu@vger.kernel.org>; Tue, 18 Jun 2024 02:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677502; cv=none; b=kP5kJB6hF3n6Dz0ML5YhEIEV1KzrSP3fx2ANHahYn1Vxxk9WI3PnrI9ALTyn1Bwh3Z04Q770YZwsHSNjRv0CcTsBrPLGtiaurc7Mk+j+1NZHaMrH+o9VGuo5KWLwEmT56jiFoE+UwQkIfZTjLbckG4PHaUG79HIBeB2YpnF0MLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677502; c=relaxed/simple;
	bh=QIhE1kGWwX+n0yHbVu48jJA6cDu/Xao0twHbhjckYo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9vWw6cbxiFGD7E3doCXFd4uoD/HlrVD++yQM7uo9LtWaXckO5cV/tp1QRkA6qKL4ohcspSzaySI6eIOxsl1Gs3GfTlbHV9DVTbdiEkvVVmRlcOvrX7/BKY5HL1XUKpxn06rmVaXKs5M0YgCxxhXyLCMffbpja9eo1j0J4ywh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=garxojom; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="garxojom"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718677497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDIyLUaESY3bp39LeIuTzoNADtQUFfqPjle3Rjg+Fb0=;
	b=garxojom4XcPK4hMwa7F2LtDIc6eW9NaVEx/HfJS88kuZFL7wycTVAqA50tfbEEBsEQYrP
	fxr+GFBRkJoW68xPDk89Bj30T2qBzH5fzEFblq069NOWyj0Y51bAzIbHh92c+CGNIFjbum
	0VKrOSWsJcx2b/3jJtCjXaJgPXev6tc=
X-Envelope-To: rcu@vger.kernel.org
Date: Mon, 17 Jun 2024 22:24:54 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: [PATCH] bcachefs: pending_rcu_items
Message-ID: <bt4s5nvorwkx3tkcxcmftz64ygazg5dlpz2l7mfdihere2632r@2vx3ecfedarp>
References: <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
 <xharqajk2o7xkpdk7mpd3jzj2suztubbqfms5xva367pcli5ny@6gjjjdbjo7om>
 <b2d51ae1-a871-426f-8d99-892558c9c8d1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d51ae1-a871-426f-8d99-892558c9c8d1@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 17, 2024 at 05:15:29PM -0700, Paul E. McKenney wrote:
> If it ever becomes helpful to make this work for any of the RCU Tasks
> flavors, the rcutorture_type enum from kernel/rcu/rcu.h might be of help.
> Until then, NULL works just fine.

Certainly

> > - Tracks pending items in a radix tree; falls back to linked list if
> >   radix tree allocation fails
> 
> I am still having trouble seeing what a radix tree brings to the table
> in this case, but again, migtht as well dig in.

It's simpler, and (marginally) more efficient than list-of-pages.

My new implementation of kvfree_call_rcu() on top of this data structure
is now looking faster than the existing version - and I'm using smaller
nodes (512 bytes instead of full pages).

> > +static inline unsigned long __start_poll_synchronize_rcu(struct srcu_struct *ssp)
> > +{
> > +	return ssp
> > +		? start_poll_synchronize_srcu(ssp)
> > +		: start_poll_synchronize_rcu();
> > +}
> 
> I don't get why you 
> 
> > +static inline void __rcu_barrier(struct srcu_struct *ssp)
> > +{
> > +	return ssp
> > +		? srcu_barrier(ssp)
> > +		: rcu_barrier();
> > +}
> 
> You will likely need something like these:
> 
> static inline void __get_completed_synchronize_rcu(struct srcu_struct *ssp)
> {
> 	return ssp
> 		? get_completed_synchronize_srcu(ssp)
> 		: get_completed_synchronize_rcu();
> }
> 
> static inline void __same_state_synchronize_rcu(struct srcu_struct *ssp)
> {
> 	return ssp
> 		? same_state_synchronize_srcu(ssp)
> 		: same_state_synchronize_rcu();
> }
> 
> The point of these is to get around the earlier issue where three cookies
> appeared to be valid due to time delays.  But perhaps you found some
> other way around that.

Yes, that comes from a race between poll_state_synchronize() and
start_poll_synchronize(), easily handled with a loop.

To be honest, I'm still not getting your intended use of the other
helpers; to be honest, just comparing sequence numbers with
ULONG_CMP_GE/LT seems simplest to my brain.

> OK, this does appear like each group of objs gets its own return value from
> either __start_poll_synchronize_rcu() or __get_state_synchronize_rcu().  If
> so, much improved!

To be honest I still prefer the old way.

This scheme requires multiple loops over the array, which leads to the
kvfree_call_rcu() based on this being quite branchy; the generated code
could be a fair bit slimmer with the old scheme.

> The purpose of this rcu_head is as before, to flag good times to invoke
> poll_state_synchronize_rcu()?

Correct

> I need to check what the caller does with it, of course.  And one caller
> appears to invokes it from a workqueue handler, the other from unknown
> context.  But you said earlier that all were from process context,
> so that should be fine.  Having the submitters do processing does have
> nice overload-handling characteristics, though it might be more prone
> to deadlock.  (As in you cannot acquire a mutex in the callback that is
> held across a call to the bch2_pending_rcu_item_enqueue() function.)

That's true for my use in bcachefs, but thanks for pointing that out,
that does look like a real problem for using this for a
kvfree_call_rcu() replacement.

kvfree_call_rcu() can't necessarily process completions in the caller,
since it can be called from interrupt context; that means unbounded
grace periods with uncompleted callbacks build up unbounded work.

And, with these data structures that would be really painful.

Which leads me to wonder, how conceivable would it be to put a limit on
the number of grace periods with uncompleted callbacks? Use of that
interface would have to be limited to trusted code (because it could
stall the system!), but I wonder if it might have positive effects on
overload behaviour.

Hmm.

> What provides synchronization for this function?  It looks like it can
> be invoked from multiple contexts.  Ah, the pending_rcu_items_pcpu
> structure's ->lock, which is dropped after invoking this but before
> processing the objects.

Yes, and in my latest version that's stricter about avoiding preemption,
the lock is only necessary for dequeue_from_all() - all other options
are careful to only work on the CPU local version now.

> If both elements are ready to process, it looks like you only process
> the first one that you come to.  Why not look at both and return both
> if both are ready?
> 
> A linked list of pages of pointers would make this possible by simply
> concatenating the lists, right?
> 
> Or am I missing something that forces the second element of the array
> to be checked?

The elements of the array aren't ordered now (per your scheme). But
perhaps they still could be.

> I might be missing something, but it looks like a linked list of pages of
> pointers would do better here, especially if there are a lot of callbacks.
> So what am I missing?

I'll be improving the genradix iterator code to avoid the radix tree
walk except when crossing nodes.

I _much_ prefer using a standard data structure instead of hand rolling,
and this code is both cleaner and more compact - and faster.

> Also, I am not seeing a ->pending() field in the pending_rcu_items_seq
> structure.  Again, what am I missing?

Not necessary, since it's pending iff it has items - except you indicate
a callback, so perhas you're thinking of something else?

> OK, processing this with interrupts enabled is a great improvement!
> 
> Also doing it in workqueue context is a good thing.  I don't yet have
> an opinion about how this code handles overload conditions.

> > +void bch2_pending_rcu_item_enqueue(struct pending_rcu_items *pending, struct rcu_head *obj)
> 
> As noted earlier, I am assuming that this is invoked from task context
> with preemption enabled.

In my usage, yes. I would prefer to not require that.

It's a bit unfortunate that we still don't have a way of checking
(outside of debug code) "are we in sleepable process context?" - that'll
have to be passed in.

> It might be worth a comment stating that the ->process() function cannot
> acquire any mutex held across a call to bch2_pending_rcu_item_enqueue().

Yes, and a note about it being called from enqueue()

> > +	struct pending_rcu_items_seq finished;
> > +	while (get_finished_items(pending, p, &finished)) {
> > +		spin_unlock_irqrestore(&p->lock, flags);
> > +		process_finished_items(pending, &finished);
> > +		goto retry;
> 
> This loop could be avoided by passing obj in to get_finished_items(),
> and having that function enqueue obj just after emptying things.  Yes,
> an infinite loop requires an improbably repeated sequence of preemptions
> and migrations, but why not eliminate the possibility?

I've reworked this code somewhat to inline fastpaths and move slowpath
to separate functions, have a look at the latest when I post it.

> > +	struct pending_rcu_items_seq *objs;
> > +
> > +	unsigned long seq = __get_state_synchronize_rcu(pending->srcu);
> 
> Invoking __get_state_synchronize_rcu() before the call to get_finished_items()
> could save you some latency.

??

> > +	for (objs = p->objs; objs < p->objs + ARRAY_SIZE(p->objs); objs++)
> > +		if (objs->nr && objs->seq == seq)
> 
> OK, the purpose of same_state_synchronize_srcu() is to make that
> equality comparison work no matter what debugging information we might
> need to put in the cookie returned from get_state_synchronize_srcu().
> Or, for that matter, poll_state_synchronize_srcu().
> 
> So please use same_state_synchronize_srcu(objs->seq,seq) here.

Done

> I wasn't kidding.  That call to __start_poll_synchronize_rcu() absolutely
> must precede that call to get_finished_items().  ;-)

Except start_poll_synchronize_rcu() is higher overhead than
get_state_synchronize_rcu() - the idea is to avoid calling it when we
know it's not necessary because we already have items for that sequence
number.

But I think there must be a better way to do this, and we shouldn't be
calling start_poll() multiple times when we're looping, yeah.

> > +	struct rcu_head **entry;
> > +add:
> > +	entry = genradix_ptr_alloc(&objs->objs, objs->nr, GFP_ATOMIC|__GFP_NOWARN);
> > +	if (likely(entry)) {
> > +		*entry = obj;
> > +		objs->nr++;
> > +	} else if (likely(!alloc_failed)) {
> > +		spin_unlock_irqrestore(&p->lock, flags);
> > +		alloc_failed = !genradix_ptr_alloc(&objs->objs, objs->nr, GFP_KERNEL);
> 
> Just so you know, the corresponding part of kfree_rcu() was the subject
> of much churn as the mm system evolved.  But you can only go through this
> retry loop twice, so I am OK, with it.
> 
> But you really want to keep this structure, you also really want to call
> __start_poll_synchronize_rcu() before the retry: label.
> 
> If nothing else, you can check the cookie on allocation failure, and if it
> has expired, just immediately free the object.

Yeah, that's a good thought.

> 
> > +	if (!p->rcu_armed) {
> > +		call_srcu(pending->srcu, &p->rcu, pending_rcu_items_rcu_cb);
> > +		p->rcu_armed = true;
> 
> In the other order, please!
> 
> Yes, you have interrupts disabled here, but you are not in an SRCU
> read-side critical section, and a hypervisor isn't necessarily going to
> know or care about your interrupt-disabled state.  So the way that the
> code is written, you really can have the SRCU callback invoked before
> setting ->rcu_armed to true, which might not be a good thing.
> 
> Especially given that it won't happen very often.  Except on large
> fleets.  ;-)

Noted :)

> > +struct rcu_head *bch2_pending_rcu_item_dequeue_from_all(struct pending_rcu_items *pending)
> > +{
> > +	struct rcu_head *ret = NULL;
> > +	int cpu;
> > +	for_each_possible_cpu(cpu) {
> > +		ret = pending_rcu_item_pcpu_dequeue(per_cpu_ptr(pending->p, cpu));
> > +		if (ret)
> > +			break;
> > +	}
> > +	return ret;
> > +}
> 
> I assume that the point of these guys is to recycle objects that are
> waiting for their RCU grace period, similar to SLAB_TYPESAFE_BY_RCU.
> Readers would of course need the same sort of checks as used by readers
> traversing memory from SLAB_TYPESAFE_BY_RCU slabs.
> 
> If my assumption is correct, handing out the oldest items minimizes the
> amount of retrying these readers need to do.

I hand out the newest to minize stranding - if we're trying to return
memory to the rest of the system, we don't want to reuse the objects
we're about to be able to free.
