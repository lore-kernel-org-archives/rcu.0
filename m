Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F218E02B;
	Mon, 26 Aug 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683453; cv=none; b=KY8KuXAEDov7Js930P4EgXTQHhFWF8T0qGE5TF9LtHF4poBh1XZGNiWKtfq835+DQLjs4DULdCBKKclw/QtFJc0k2Md5zpfnIy8++3pSS9u1TPCuYB7JvBnP0CiavWeZ40XOlIxnkUT9F9z3WkmRHV2/DgKL/ldcrtix/3umsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683453; c=relaxed/simple;
	bh=R24rO8QyB/mfy6Pzm5Ayl8reM44/jIqYjQkOFcfvCyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTwR3u1ZSmy+xysN3WBuBfcueEBeThkLQbjdyOFHuk/SzwksHscuXPi3hA6n53AP4xIUFSu8MwM6nCdyz7ggwidQzzz0q4lhfdlUXAHJ2kTnF5v2HQ96Lqz5Dc+USOLLTIK8l75nuK/PGtaIt4xzli3mm+Hn0veVEms0pIm6Az8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMxODaIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMxODaIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03109C52FCC;
	Mon, 26 Aug 2024 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724683453;
	bh=R24rO8QyB/mfy6Pzm5Ayl8reM44/jIqYjQkOFcfvCyI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qMxODaIW6NHnBNweZq1/T5V6cRsG7wcQXdAugEwnx/oGw5oyRdZh/jCCfmq1jmHhM
	 z0FczjHhcnJWk+eq7aSeur6vKpWKON4tP+qkfbkQDzeiRh5fOSt1X94oFKmApz7ekY
	 TTuveL0ztxJCPF9qyb31ixMNauiOkhIDGdlP8CtzHmF3JY4Eu4sYSjl6CGmEAHT/oT
	 MCx+A6qwpCsilVi+tmwhKh8ocIKGO8moNhcGpHkRziu7QlQ7/j13aJC0/9Ql5n80LG
	 dZu0WSIzkh5ittjCataMcgdJs3HXh30d5LeEKi4dHHd05ajzAVTXQ/mCeFUn0WeiOU
	 okJBxaXgCVSOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A10D0CE0B78; Mon, 26 Aug 2024 07:44:12 -0700 (PDT)
Date: Mon, 26 Aug 2024 07:44:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org, cl@linux.com, mhocko@kernel.org,
	urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
 <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>

On Mon, Aug 19, 2024 at 07:59:34PM -0400, Kent Overstreet wrote:
> On Mon, Aug 19, 2024 at 03:58:26PM GMT, Paul E. McKenney wrote:
> > I still remain quite skeptical of this one, but it has improved since
> > June's version.
> > 
> > Responses inline.
> > 
> > 							Thanx, Paul
> > 
> > In the meantime, thank you for avoiding reaching into RCU's and SRCU's
> > innards.  This makes it reasonable to have you put this file into your
> > code, at least initially.  That way, you get what you want *now* and us
> > RCU guys are not committing to maintain it before it is ready for us to
> > do so.
> 
> The RCU interfaces do force a lot of function calls for things that
> should be inlined though, and the gratuitious interface fragmentation
> between RCU and SRCU is... annoying.

I have gotten requests for a variant of SRCU that dispenses with the
read-side memory barriers, which would allow you to dispense with RCU.
Maybe an srcu_read_lock_lite() and srcu_read_unlock_lite(), similar to
the _nmisafe() variants.  There is always a price, and in this case the
price would be that srcu_read_lock_lite() and srcu_read_unlock_lite()
be restricted to code regions where RCU is watching.  But from what I
know, fs code must already abide by that restriction.

Would that help?

> > I still have strong misgivings about radix trees and cache locality.
> > Poor cache locality on the other side of the grace period can result
> > in OOMs during callback-flooding events, hence the move of kfree_rcu()
> > and friends to pages of pointers.  And, as you note below, radix trees
> > don't merge nicely.
> 
> Cache locality where?
> 
> On the enqueue side, which is the fastpath, this uses a cursor - we're
> not walking the radix tree every time.
> 
> On the processing side, where we're kfree_bulk()ing entire radix tree
> nodes, the radix tree is going to have better cache locality than a list
> of pages.

Interesting.  What testing or analysis did you do in the course of
arriving at this conclusion?  In the meantime I will assume that the
analysis involves your radix-tree nodes being more than one page in size.

> > The advantage of synchronize_rcu() is that it can proceed without
> > memory allocation.  If you block on allocation, even of a 16-byte
> > rcu_head structure, you can go into OOM-induced deadlock.
> > 
> > It might well make sense to do an rcu_head allocation with GFP flags
> > that try reasonably hard, but still allow failure before falling all
> > the way back to synchronize_rcu().  (And for all I know, this might have
> > been tested and found wanting, but Uladzislau Rezki (CCed) would know.)
> > But a hard wait on that allocation is asking for trouble.
> 
> That's reasonable - as long as we're trying the 16 byte allocation
> before doing a synchronize_rcu().

It might or might not be reasonable, depending on what is going on in the
rest of the system.  The current kfree_rcu() code can run the system out
of full pages, but it won't impede other code allocating smaller blocks
of memory.  We could easily change it to allocate individual rcu_head
structures, but doing so would not necessarily be a win in OOM conditions,
again, depending on what else is going on.

We are very likely to add this, but also very likely to have a "chicken
switch" to allow the system administrator to control it.

But I freely concede that if your radix tree is using multi-page nodes,
then your code might well have greater need to allocate individual
rcu_head structures than does the current kfree_rcu() implementation.

> > There is work underway to make the current callback lists take advantage
> > of expedited grace periods, transparent to the caller.  This allows
> > the shrinker (or whatever) to speed up everything by simply invoking
> > synchronize_rcu_expedited().  This speedup includes callback processing
> > because it avoids "bubbles" in the callback processing that can occur
> > when the next grace period has not yet completed, but all callbacks from
> > earlier grace periods have been invoked.
> 
> Glad to here, that was first on my list when adding a shrinker to this
> code.

Glad you approve.

This has been on my list for quite some time, and we now have thing in
place to make it easy.  Well, easier, anyway.

> > > - RCU_PENDING_CALL_RCU_FN
> > > 
> > >   Accelerated backend for call_rcu() - pending callbacks are tracked in
> > >   a radix tree to eliminate linked list overhead.
> > 
> > But to add radix-tree overhead.  And to eliminate the ability to do O(1)
> > list merges.  Is this really a win?
> 
> As mentioned, there's a cursor so we're not adding radix-tree overhead
> to the fast path, and there's no need to merge lists for expired objects
> - that's all handled fine.

I took a quick look at __rcu_pending_enqueue() and my eyes are still
bleeding.  Concatenating linked list of pages is way simpler, way faster,
and way more robust.

> But yes, using it for call_rcu() would need more performance
> justification. I haven't seen workloads where call_rcu() performance
> particularly matters, so it's not something I'm pushing for - I included
> that because it's minimal code and other people might know of workloads
> where we do want it.

Plus, unlike kfree_rcu() post-grace-period handling, call_rcu() callback
functions usually access the memory block passed to them, which means
that they are incurring that per-element cache miss in any case.

> > > Ideally we would be getting a callback every time a grace period
> > > completes for which we have objects, but that would require multiple
> > > rcu_heads in flight, and since the number of gp sequence numbers with
> > > uncompleted callbacks is not bounded, we can't do that yet.
> > 
> > Doesn't the call from __rcu_pending_enqueue() to process_finished_items()
> > serve this purpose?  After all, the case that causes trouble is the one
> > where lots of things are being very frequently queued.
> 
> No, because that's unpredictable, and we don't process pending items in
> enqueue() unless we know we can sleep (i.e., we don't do it if the
> caller is latency sensitive).

It is possible to do this in an extremely lightweight fashion in the
common case.

							Thanx, Paul
