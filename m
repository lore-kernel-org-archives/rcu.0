Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8F15ECC0
	for <rcu@vger.kernel.org>; Fri, 14 Jun 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377959; cv=none; b=gLsU3zwGqtl305cgbsTt0WCD6weGFw3jyyPN5ZdtV4du5XZD7E7eFphe3nnOR7y7yMtxG5pHHgfvfCvk6t28HigB96yxbiLMymZZswYO5lqwxFS6Bbv6PEd/MwUkmkX6cGPqoINlsKpf9U9DCnw8ZtUNln53DId3qs6GX7dkybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377959; c=relaxed/simple;
	bh=NpUsp7KvzJQhSQW6WQWeg2+Ue60hROhEqiOOr/zGJd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USMA66C43VJky3S3j+loonWE25HgHrDJaILDDuibdUf0oAmtq/aKGA7EFiFQhda0gibPIegTBNTgzVDzdtuNTzl/IPavMN07eCRkzWVQKz/0jz/18YZTpgfHzsV9xucmG633q9ID9hLNskKo1AhDO90WQxxkKjIPuq7H7k5Nw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZQOMGU1W; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZQOMGU1W"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718377955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDLpgSue07O9nGnKQzyJ8WcOiJHqf2z0FUwM//R5L/Q=;
	b=ZQOMGU1WYX5oYVuAxbPh7IbtRGuJXmHTPOC+xDgg+fpo9DnjW7QMCt0LiYwG1p68Jfr3Rl
	pbjO5U34vG76YVqQiKXDYrm47eLiTl8ZdEl4R+B0O2Bdrj3AhdRIkXDun9/ZPKFos/e0BA
	SmyfgbfZa9CFRkA5oU6Z3RMEQ+BZOcw=
X-Envelope-To: rcu@vger.kernel.org
Date: Fri, 14 Jun 2024 11:12:30 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <zychjrhasgxz7gwhah6egognnqepcdyoubby6gog645mn6n4gt@zprp3rhtyfx3>
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 13, 2024 at 08:22:19PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 02:32:27PM -0400, Kent Overstreet wrote:
> > On Wed, Jun 12, 2024 at 08:48:40PM -0700, Paul E. McKenney wrote:
> > > The number two is the number of distinct values, which will not be
> > > consecutive numbers.  As you noticed, they currently are always multiples
> > > of four, but that is an accident of implementation that is subject to
> > > change.
> > 
> > I take it you're stuffing something else into the low bits and masking
> > it off, and you can't shift that off because that would break
> > comparisons. That's a tiny bit unfortunate; it would be nicer if we
> > could do array indexing based on the sequence number.
> 
> That was my initial thought as well, and so there was in fact a time
> when RCU grace periods were numbered consecutively.  The problem with
> that was that it was necessary to maintain a separate indication of
> whether or not a grace period was in progress.  It is often necessary
> to atomically determine both the grace-period number and whether that
> grace period is still in progress, which required acquiring a lock,
> which necessitated a number of contention-reduction workarounds which
> eventually became problematic.
> 
> When led to the next phase, which reserved the bottom bit to indicate
> whether a grace period was in progress and left the remaining bits to
> count the grace periods.  This greatly simplified the code and likely
> also improve performance and scalability.
> 
> Then I implemented Tree SRCU, which requires multiple grace-period phases,
> hence the current state with the two bottom bits indicating grace=-period
> phase and the remaining bits counting the grace periods.  Hence your
> seeing get_state_synchronize_srcu() always returning a multiple of
> four ("grace period N has not yet started").

I've been wondering about your tree algorithm, ever since I realized
there's an elegant algorithm for ticking a counter when every counter in
a tree of sub counters has ticked.

> > What if we added something like this?
> > 
> > #define RCU_SEQ_SKIP_SHIFT	2
> 
> Right now, get_state_synchronize_srcu() returns the grace-period sequence
> number from the root of the tree.  This has been working fine thus far,
> but it is quite possible that memory-contention issues will force me to
> get the value from the leaves of this tree.  If that happens, the value
> of NUM_ACTIVE_SRCU_POLL_OLDSTATE will change from 2 to 3.
> 
> In addition, vanilla RCU users are looking for reduced synchronize_rcu()
> latency, which in the past resulted in the addition of expedited
> grace periods, which have their own counter.  Similar pressure on SRCU
> could result in overlapping computed grace periods, which would use
> additional bits and make the cookies only partially ordered (as the RCU
> rcu_gp_oldstate structure variant of cookie already is).
> 
> And those are just a couple of changes that I can foresee.  There might
> be others.
> 
> So, annoying thought it might be, we really need for this to remain an
> opaque cookie.

Ok, I can live with that.

> > > > I could use a doubly linked list for tracking all uncompleted objects,
> > > > but I'm hoping use a darray per sequence number. Is it a max of two
> > > > sequence numbers that had objects/callbacks/were requested pulling,
> > > > or...?
> > > 
> > > Agreed, an array should work.  Each array element would need a field
> > > recording its cookie.  Right, so you likely need a few more simple
> > > functions:
> > > 
> > > 	same_state_synchronize_srcu(): Equality comparison of the
> > > 		pair of cookies passed in.
> > > 	get_completed_synchronize_srcu(): Return a special cookie
> > > 		that, when passed to poll_state_synchronize_srcu(),
> > > 		always results in a @true return value.
> > > 
> > > Or maybe not, you tell me.
> > 
> > I don't think so, but I'm not sure what your intended use is.
> 
> For same_state_synchronize_srcu(), places where you likely planned to
> instead use C-language comparisons.  For get_completed_synchronize_srcu(),
> as a way of marking an unused entry, for which it looks like you are
> currently using ->rcu_armed.

I'm definitely not following how you want that done then :)

> > dynamic array, basically a c++ vector - fs/bcachefs/darray.h
> 
> So the darray is to hold the callbacks themselves as opposed to
> the per-unexpired-cookie-value groups of callbacks?

For my intended use case, a struct pending_rcu_items is only for objects
of the same type that all have the same callback (otherwise, allocating
from pending objects would have to search for an object of a given
type).

But if we want to use this for the call_rcu()/call_srcu() mechanism,
then yes - the darray would have elements of type

struct rcu_pending_cb {
	void (*func)(struct rcu_head *);
	struct rcu_head *obj;
};

which would save us a dependent load on processing callbacks.

> > Think this would be worth factoring out and turning into something
> > generic? If RCU wanted to use this internally for tracking pending
> > callbacks, we could get rid of linked list overhead there...
> 
> For the kfree_rcu() path, we have a pages-of-pointers approach.  For the
> call_rcu() path, the callbacks almost always access the memory, so it
> is not clear that the linked-list overhead is an issue.  You get that
> cold-cache miss either way.

So kfree_rcu() is basically implementing the same thing? yes,
add_ptr_to_bulk_krc_lock().

The pages-of-pointers does avoid the realloc/memcpy() overhead - which
implies I'll want to switch mine from a darray to a generic radix tree.

I think call_rcu() would benefit from this approach as well - it's true
that we can't avoid cache misses, but linked lists are completely
serialized, so those cache misses hurt; using a vector or radix tree
means we can prefetch.
