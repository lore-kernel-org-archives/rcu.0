Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8601C695
	for <rcu@vger.kernel.org>; Mon, 26 Aug 2024 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685463; cv=none; b=cxAgs7+7pP9xF5UeCD7nTdEExzXficALkICWBE/vZ8HXdWiR10kdMJg5ZTbM9MOpV0ZtXZs7ppcqMGqxsRhPoRmKhKqCiJW2KcySsiSvRwae/Ssmj4YsjgMJBvjieYjwPqkgLp89dwYQAZ6ux1FiFPjlLshlIELqjSQpqQd4Gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685463; c=relaxed/simple;
	bh=nRauhVKh45/vq/mv/wqGX61q2RWDnVLGljVmUAqW3II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM3sJYpAARE6fGz89MypfUzk3xFbXAdaC5nsW757fqd+uOUQ9Gqi0y0q/n7IgR0w6ZFY0/LLdb9Rn+T2i5vwtxDbMvIKV6iuX4SPHgcJ1GoR7/r0XcYYaTqIcrZPUHZ/zc7S4DuvpnXydq29MrW+xjoC3PbB7RkhVX9tEp8qz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUZ8Tqge; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUZ8Tqge"
Date: Mon, 26 Aug 2024 11:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724685458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YtD32tFififGdoGftpJ5ellvDbDlP+SOcGXRnKQFoI=;
	b=nUZ8TqgeJeLGU+shP/s8yVL3SrjMKx6dW0A3ARprfHlC3JM2Um5d0RkixW/Z0Do1xhrl09
	7VuqqrgnmRi0CNY6OEij11WdEJah5fEMgcArlw9hGkEssdbMMJVo5JWpMD8oMtY50aQOim
	nwEvZZASJGsQLWHUUaSJpwdXhwgB9+k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	mhocko@kernel.org, urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <4zkfyn2shwot2zxiahn7zt7k2gpnoavyrldzzwo23qqxr6fvfh@xqlz4vehkln5>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
 <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
 <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 07:44:12AM GMT, Paul E. McKenney wrote:
> I have gotten requests for a variant of SRCU that dispenses with the
> read-side memory barriers, which would allow you to dispense with RCU.
> Maybe an srcu_read_lock_lite() and srcu_read_unlock_lite(), similar to
> the _nmisafe() variants.  There is always a price, and in this case the
> price would be that srcu_read_lock_lite() and srcu_read_unlock_lite()
> be restricted to code regions where RCU is watching.  But from what I
> know, fs code must already abide by that restriction.
> 
> Would that help?

I don't think that helps here, but that is something I'd be interested
in.

What I would like for this is:
 - a single #define for RCU_NR_OLDSTATES for both RCU and SRCU

 - a way of getting the current RCU gp sequence number without a
   function call, since we hit that on every single enqueue(). One of my
   development versions added a function to RCU and SRCU for getting a
   pointer to the internal sequence number, which we'd call at init
   time; this lets us skip the function call and a branch. 

Another thing that might make the code a bit easier to reason about is
if rcu_read_lock() also worked as an srcu_read_lock() - is something the
SRCU variant you're talking about previously would provide?

In my current version of the code, we call __get_state_synchronize_rcu()
after we've disabled interrupts; we know the rcu gp seq isn't going to
tick while we're in the critical path. But this doesn't apply if it's
for SRCU, and I don't want to add if (src) srcu_read_lock() branches to
it.

Not at all essential, the races that result from this are harmless, but
if we e.g. decide it's worthwhile to only kick off a gp if it hasn't
ticked (i.e. only kick rcu if we're still on seq of the object being
enqueued) it'd be nice.

> > On the enqueue side, which is the fastpath, this uses a cursor - we're
> > not walking the radix tree every time.
> > 
> > On the processing side, where we're kfree_bulk()ing entire radix tree
> > nodes, the radix tree is going to have better cache locality than a list
> > of pages.
> 
> Interesting.  What testing or analysis did you do in the course of
> arriving at this conclusion?  In the meantime I will assume that the
> analysis involves your radix-tree nodes being more than one page in size.

No, the radix tree nodes are 512 bytes; that's been sufficient in my
testing.

(also, please don't refer to PAGE_SIZE outside of mm/ code without a
_good_ reason; that's something we've been trying to clean up.)

I'll try to post some performance numbers when I have some time.

> It might or might not be reasonable, depending on what is going on in the
> rest of the system.  The current kfree_rcu() code can run the system out
> of full pages, but it won't impede other code allocating smaller blocks
> of memory.  We could easily change it to allocate individual rcu_head
> structures, but doing so would not necessarily be a win in OOM conditions,
> again, depending on what else is going on.

As long as the thread calling kvfree_rcu_mightsleep() can block without
blocking memory reclaim it'll be safe. We might want to tweak the GFP
flags so to tell the allocator "don't try too hard, bail out so we can
check if the gp has expired".

> I took a quick look at __rcu_pending_enqueue() and my eyes are still
> bleeding.  Concatenating linked list of pages is way simpler, way faster,
> and way more robust.

Funny, I had the same thoughts trying to read your code... :)

But, most of __rcu_pending_enqueue() is slowpaths; the fastpath is just

	objs = get_object_radix(p, seq); /* lookup seq in p->objs */

        *objs->cursor++ = ptr ?: head;                                                                                                       
        /* zero cursor if we hit the end of a radix tree node: */                                                                            
        if (!(((ulong) objs->cursor) & (GENRADIX_NODE_SIZE - 1)))                                                                            
                objs->cursor = NULL;                                                                                                         
        start_gp = !objs->nr;                                                                                                                
        objs->nr++;

So I think the performance concerns are moot, and for robustness -
memory allocation failure always turns into "use the linked lists of
objects", which works similarly to the old code.

> > But yes, using it for call_rcu() would need more performance
> > justification. I haven't seen workloads where call_rcu() performance
> > particularly matters, so it's not something I'm pushing for - I included
> > that because it's minimal code and other people might know of workloads
> > where we do want it.
> 
> Plus, unlike kfree_rcu() post-grace-period handling, call_rcu() callback
> functions usually access the memory block passed to them, which means
> that they are incurring that per-element cache miss in any case.

True. But this would allow us to prefetch those objects (several
iterations in advance).

> > > > Ideally we would be getting a callback every time a grace period
> > > > completes for which we have objects, but that would require multiple
> > > > rcu_heads in flight, and since the number of gp sequence numbers with
> > > > uncompleted callbacks is not bounded, we can't do that yet.
> > > 
> > > Doesn't the call from __rcu_pending_enqueue() to process_finished_items()
> > > serve this purpose?  After all, the case that causes trouble is the one
> > > where lots of things are being very frequently queued.
> > 
> > No, because that's unpredictable, and we don't process pending items in
> > enqueue() unless we know we can sleep (i.e., we don't do it if the
> > caller is latency sensitive).
> 
> It is possible to do this in an extremely lightweight fashion in the
> common case.

Just processing a few items? hmm, would we want to though, when
otherwise we'd be calling kfree_bulk()? I think icache locality means
we'd generally prefer not to.
