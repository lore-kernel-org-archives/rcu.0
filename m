Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371C17C
	for <rcu@vger.kernel.org>; Sun,  1 Sep 2024 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725149001; cv=none; b=BFcPXtfTVy3jIpeuPl3dF1x3iL2Po1ax/vOs/3+dg7bV8K7G/ljU3guk2OHRbqxjIue8oOnqEIgv+t/4K71f/KMbNGpERfcPQekZOOJCg4m/z2vdr5Pmr3yukRQ+mFmhTeHuC/FdDmKPVk45+AGLQciVAW8N+FkraTLFiOzSeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725149001; c=relaxed/simple;
	bh=dNKXlRAEjymfcRPiUi6w8ZFIPtRarfdUEMOedHK0dZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcqNwo5sxQ0jccx1XRyZDVa5KRv5/zEwwcIeK5wcip8FSZ5ZY0cyTRk0od8PZgiO/n5WOub9W4DU0QWkjmr8piwb6lwCV3vstu6X5ulYl+MSwggLQizoBvAA9XWvv9wTZ7ItQUuXxvzt1P5s75cXIr30vNdCotv2bmMu4VabzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ML4GenEg; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ML4GenEg"
Date: Sat, 31 Aug 2024 20:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725148996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzDk2pbGPxHIjwfl9C2zQJMLBhDT9t9m05nWw254FGc=;
	b=ML4GenEgIppn2TVCB9XTwBmLgsABpUoVqJ798vdhhZa00UgcYiICPES89qOHcCMlulDzxs
	PwKxIk5WcmtLAB9K4LFOqZfhTpsevOygfDUCaLwzEyOFRxSHPRQLxr+q/YIhZEpanATRT0
	yXCKhbzoSeej0uaJMJoW22pfZJYVEgE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	mhocko@kernel.org, urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <uk3syrtlyn5pl3ap5333ujbl7h65fbpsmxqjy6sn2sxm4elshx@w34tu4jksdhu>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
 <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
 <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
 <4zkfyn2shwot2zxiahn7zt7k2gpnoavyrldzzwo23qqxr6fvfh@xqlz4vehkln5>
 <4e4a5c89-e9ec-421e-8245-f076044866c9@paulmck-laptop>
 <gqgocomsljkn5sw2jvm432peesjuclfjwd2sasec3kg6tofk5t@ry7rkoo2auek>
 <ab35ac12-23ac-40a1-b98b-5b4d91ec44b9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab35ac12-23ac-40a1-b98b-5b4d91ec44b9@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 30, 2024 at 12:01:26PM GMT, Paul E. McKenney wrote:
> On Mon, Aug 26, 2024 at 01:09:15PM -0400, Kent Overstreet wrote:
> > On Mon, Aug 26, 2024 at 09:01:54AM GMT, Paul E. McKenney wrote:
> > > But get_state_synchronize_srcu() is still a function call.  But the
> > > offer of a function that checks multiple grace-period-state cookies in
> > > one call still stands.
> > 
> > It shouldn't be though, it's just reading a sequence number - I'd much
> > prefer if it could be at least a static inline.
> > 
> > Which you won't want to do, because it would mean exposing RCU private
> > data structures; hence my approach of exposing an RCU-only api for
> > getting a pointer to the sequence number.
> 
> True enough.
> 
> In addition, I have not yet been able to come up with any safe use of
> this sequence number that does not require memory ordering.  And -that-
> I most emphatically won't want to export to the caller.
> 
> Hence my offer of a function taking multiple grace-period-state cookies
> in one go, allowing the memory-ordering overhead to be amortized over
> the set of cookies.

I'd have to have an idea of what that would look like to comment.

> > We don't want to falsely think the object expires later than it actually
> > does, and have more accumulated work than we need to.
> 
> Yes, that can happen, but grace periods are long and that race window
> will normally be very short.  It will not matter in actual practice.

True, it's not much of a practical consideration.

Part of the reason I bring this up is I'm coming to this with experience
with the bcachefs journal flushing API, which feels quite similar in a
lot of ways - we have items associated with sequence numbers, and we may
later need to flush and wait for a given sequence number to be
persistent.

That code just feels easier to reason about when we're being explicit
about which sequence number we're talking about whenever possible.
Granted it's not as necessary with RCU - but who knows, maybe someday?
Just wanted to share the thought.

> > I would have much preferred if your existing code worked with SRCU. You
> > think I'm doing this for fun?
> 
> To be fair, the "for fun" reason seemed to me to be one of the more
> positive explanations for your providing an unsolicited rip-and-replace
> patch for kfree_rcu() without prior consultation. ;-)

Well, partly yes; one of the things that I derive the most satisfaction
from is clean modular solutions to interesting problems with nice
simple APIs, where I get to slim down the original chunk of code and cut
out something grotty :)

There hit a point when working on the btree key cache lock contention
issues where I realized I was onto something nice, and thought - "this
might be worth doing right".

And I still feel that way. Slimming down rcu/tree.c seems like a nice
win, and if we could slim down the slab code by pulling out
SLAB_TYPESAFE_BY_RCU too, that'd be a nice win.

I really like codebases that are nicely organized, where individual
components aren't too big and have a clear purpose, where I can still
find my way around them years later :)

> But, to your point, why haven't we already implemented kfree_srcu()?
> 
> Because in v6.10, there are six use cases for it, and they appear to have
> infrequent updates.  Thus, kfree_srcu() is not yet not worth its weight.

Only if you leave out bcachefs.

> > We would of course want benchmarks to show that this was worthwhile
> > before switching call_rcu(), since absent a performance improvement we'd
> > want to stick with the approach that doesn't allocate memory.
> 
> Agreed.
> 
> Furthermore, any approach that does allocate memory needs a non-allocating
> fallback.  Out-of-memory deadlocks are not fun.

Try telling that to the filesystem people who are currently obsessed
with __GFP_NOFAIL...

But the fallbacks are already there - if you didn't get that far through
reading the code, the -ENOMEM fallback works pretty much exactly like
how call_rcu() works currently, with three lists of pending objects (one
for each outstanding grace period, and a list for expired objects).

> > > > Just processing a few items? hmm, would we want to though, when
> > > > otherwise we'd be calling kfree_bulk()? I think icache locality means
> > > > we'd generally prefer not to.
> > > 
> > > You might not want to yet, but you eventually would want this.
> > 
> > Because?
> 
> TL;DR:  Lessons learned from bitter experience.
> 
> For more detail, please read on.
> 
> Because certain inconvenient laws of physics (and I am looking at *you*,
> finite speed of light and atomic nature of matter!) mean that global
> agreement across a computer system is expensive.  This is especially
> a problem if synchronous global agreement is required, which is one
> reason why reader-writer locking is so slow, one way or another.
> (You can either make readers slow or you can make updaters *really* slow.)
> 
> RCU does not completely avoid the cost of global agreement.  After all,
> at the end of a grace period, there must be global agreement that all
> pre-existing readers have completed.  But the computation of that global
> agreement can be (and is) spread over time.  This spreading has two
> good effects: First, it permits CPUs and tasks to use lighter-weight
> operations for high-frequency operations such as rcu_read_lock(), and
> second, the grace-period requests that arrived during one grace-period
> computation can all be satisfied by the next grace-period computation,
> in turn permitting the overhead of that next computation to be amortized
> over all those requests.  Which is one reason why grace periods are not
> unconditionally expedited.

*nod* There's a fun algorithm for ticking the global RCU sequence
number, is there not? I assume it's where tree-RCU gets its name, but I
wasn't able to find documented or in the code.

My version goes like: construct a binary tree, where every CPU is a leaf
node. When a CPU hits a quiescent point, it compares its node's sequence
number to the root; if they're the same, increment its node.

On increment, check sibling node; if they're now identical, tick parent
node; recurse up to the root.

Do I have that right?

> But it is all high-amortization fun and games only until there is risk
> of exhausting memory.  At that point, RCU takes steps to expedite
> the current grace period, albeit in a light-weight fashion compared
> to synchronize_rcu_expedited().  It has proven unwise to wait for mm
> to complain to RCU (for example, via a shrinker), so RCU does this
> lightweight expediting using heuristics based on the number and rate of
> callbacks on each CPU.  And yes, RCU also uses shrinkers, just not as
> the first line of defense.

So that's interesting. I think it would be really valuable to get those
heuristics better documented (and perhaps better factored out; if we got
them in rcu_pending we might make it easier for mm people to find and
understand that code, vs. having to dig through rcu/tree.c).

Speaking from painful personal experience, memory reclaim issues are one
of the most frustrating things to debug - they never crop up in a
controlled environment, it's always users hitting them at the worst time
and I always have very little to go on, and there's _so many_ things
that can go wrong.

Hence my current work to improve shrinker debugging and add it to the
show_mem.c oom report, and my recent ask for actual byte counters on
amount of memory stranded by RCU - it would be lovely if we could have
that included in the show_mem.c report (perhaps when heuristics tell us
they're likely to be relevant), along with anything else we might want
when debugging (are we waiting on an unusually long grace period?).
