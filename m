Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F61178CE2
	for <rcu@vger.kernel.org>; Fri, 14 Jun 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396078; cv=none; b=bZDbfHFW2e/j693lp8H5NrHaDDL8uZ/0QuMyVfd/Wcv60H0KT9P2hrN7BxLVbO5fIv3+u4NsAu3D0qu2Yehx3ww+D+4FYwYUwAsMYdAdegj4TTEkGawNwKUgu7xy1zXt5GbSJtsUybrA3n/C1fAFlK4DlHdqbYM9t16p/ZdxSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396078; c=relaxed/simple;
	bh=4FL4RwLnAA7fMGpvozCMxu4+8gY9nv4ErsvLi8P9S/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3qtfI+yqBEH95RB3z6VzxZ8LaCSr2DKmuLN4wtY/8iPLsgqCBs3Ulk0sQk2uqXcmOISKX2hHR9lorAhN71kJ8Ymrq2i2w3x0xcIRNcscnPUPNuICas1fkJ4lfCL6pqlPz0Ghvgm0nCJ9ByK7ecPxSdohZfr7A8j6AhDQbRB/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HTFjNfSi; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HTFjNfSi"
X-Envelope-To: paulmck@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718396074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svI/1QUvtdNI+kxxrg+LAfwazaI15rMTnDqrPHCQnUY=;
	b=HTFjNfSiPKzWJ8DWHtG9JjXFZQFLXMPTeCyTS2v0ebKjpU50avqu+pqZjubRSMYdrTAsLw
	i45vCHFhD/aCGb2qpRmQ6FmyM5MdRsJDJh7+XFure92cl6IZvc+/j+Vj1vBLZKmBTNJjYh
	IsNAiJniyKvr4OcUCXyD/5k+4F1F6bk=
X-Envelope-To: rcu@vger.kernel.org
Date: Fri, 14 Jun 2024 16:14:29 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <mbdjlkg74rgxvyb3mv5yl3hrmdiy3kpu3u3qgky7gvw5o445l2@f6uqrfgpcmfy>
References: <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
 <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
 <clrfcpickuk7mss7tbwdhy2krjlxic7ivcczq7vkmqtte2xrp4@rfjd57exzx2k>
 <dbc11a6a-175d-42ca-b962-8ad0062d6ba8@paulmck-laptop>
 <cvxzve5m6xlttd2peimzfkh7bklxakjm4cjbx5xohbfl3uwyks@jhbstfvkhcm5>
 <07c43946-7e63-42ed-8d56-67f3146a6dbb@paulmck-laptop>
 <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7321411a-b19e-49e5-a56f-563e688de395@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 14, 2024 at 07:11:50AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 08:22:19PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 13, 2024 at 02:32:27PM -0400, Kent Overstreet wrote:
> 
> [ . . . ]
> 
> After sleeping on it, backing up a level of abstraction, and thus perhaps
> responding a bit more constructively...
> 
> And also, thank you very much for looking into this!
> 
> > > commit 3bb5d34d6d6e2d5433cce5d248fd81211afedec0
> > > Author: Kent Overstreet <kent.overstreet@linux.dev>
> > > Date:   Mon Jun 10 20:47:03 2024 -0400
> > > 
> > >     bcachefs: pending_rcu_items
> > >     
> > >     Generic (?) data structure for explicitly tracking pending SRCU items
> > >     
> > >     - Can we make this generic across other RCU flavors?
> 
> It should be possible, at least for current RCU and SRCU.  I think I owe
> you SRCU variants of a couple of existing RCU functions.  Later today!

I was wondering how much commonality there is between the core data
structures of RCU and SRCU. If RCU internally has something analagous to
srcu_struct, and we could refer to that object without caring if it's
for RCU or SRCU, that would be cool... otherwise, we can just do it a
level up with switch statements.

> > >     - Do we need to add a fallback to linked lists when darray allocation
> > >       fails?
> 
> In general, as in kfree_rcu(), yes.  In your specific case here, maybe not.
> 
> > >     - We wish to avoid the overhead of start_poll_synchronize_srcu() if we
> > >       already have items for a given sequence number, but it appears
> > >       get_poll_synchronize_srcu(); start_poll_synchronize_srcu() can
> > >       actually return differert sequence numbers within the same read-side
> > >       critical section. Is this the correct way of doing this?
> 
> You can always buffer up items that have not yet been assigned a sequence
> number, then after you have enough or after enough time has passed, do a
> single get_poll_synchronize_srcu() for the group.

I don't think we'd want to do that, since that would be delaying the
point at which objects get reclaimed. Have a look at my latest version
and tell me if you think that works? It seems to work in my testing.

> > >     - Do we need to ensure the rearming RCU callback is correctly flushed
> > >       when exiting? (Probably)
> 
> I believe so, and setting a flag then doing an srcu_barrier() should suffice.

Is the only difference between srcu_barrier() and synchronize_srcu()
that srcu_barrier() is a noop if callbacks weren't enqueued?

> > > +static void pending_rcu_items_process(struct pending_rcu_items *pending)
> > >  {
> > > -	struct bkey_cached *ck = container_of(rcu, struct bkey_cached, rcu);
> > > +	while (pending_rcu_has_items(pending) &&
> > > +	       poll_state_synchronize_srcu(pending->srcu, pending->seq)) {
> > > +		darray_for_each(pending->objs[0], i)
> > > +			pending->process(pending, *i);
> 
> Given that you have interrupts and/or bh disabled, there needs to be a
> third set of callbacks, those whose grace periods are already elapsed.

Not following? The pending->process() is exactly that callback.

Also, the new version does processing in proccess context, without the
lock.

> Unioning one of the ->objs[] sets onto this third set, leaving the source
> ->objs[] set empty, should strongly be O(1) without the need for memory
> allocation.  I might be missing something, but at first glance darray
> does not support this.
> 
> The pages-of-pointers structure named kvfree_rcu_bulk_data, along with
> the associated structures in kernel/rcu/tree.c does this work, but (1)
> is open-coded and (2) has to deal with the full range of what the kernel
> can throw at it.  It falls back to an embedded rcu_head structure, in
> response to your second question in the commit log.
> 
> But perhaps this code could be generalized?  Or maybe darray can be
> appropriately extended?

Not sure what you mean by "unioning onto a third set"?

> And one thing that I missed the first time around is that you are using
> a single ->seq for two sets of objects (->objs[0] and ->objs[1]).
> Each set needs its own sequence number.

I've got this changed in my latest version, but - I did see one BUG_ON()
where we seem to have three sequence numbers in flight. Any idea what
might be up with that?
