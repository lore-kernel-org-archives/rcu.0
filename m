Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF001940BC;
	Mon, 26 Aug 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688115; cv=none; b=DQKxghIiNLPkEpAaSQX32APDmZfbry5Erq92wDE2fLwdcEPPOHNiuRhkVSIJn2IvysB4U4m4Wh87wEWdkg8p7O2fFWYTDfdE2zIB1d2Kv+J6CmgkLkLz98qRguI7M0af9t7VKsvRKixCDL7rjltGsSOplKMQRw74heIMIKYPog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688115; c=relaxed/simple;
	bh=A5xnlPqwMK691sFGJdZoiAcotUbdPn6XxzAE/ZmYNpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VE3JAEJYwA37J0hfJQGPwJmGQHJX3T/ihAF8MlFuJCCiKoIGdyOuSg9emg7/OzyB+ILhm44Sua0Utu/l/PCz/Ku3aRBfVsGfv8yW0elSpr/oV5EORM0PGDy71zo6ucZXFx+3lkOYd4yDmn4A1gyZ4robCoVYrVCYZ0nsG9frQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl0GwMn1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl0GwMn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07718C4E696;
	Mon, 26 Aug 2024 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688115;
	bh=A5xnlPqwMK691sFGJdZoiAcotUbdPn6XxzAE/ZmYNpM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zl0GwMn1KkYdvI+3WDMZYizU4Prqdgo7an2ZtAbQj3aEGu3RzBv68eWc/jhBzyvAz
	 iujq6NYOPU+QpKPp2+ECtTapQEpJD338cz5tIHc1BxvmhLs8BtFxpcB+XKByCGFBl2
	 D7wiXcDlD1JEJzZDuvHNgWzeWGoxpPNiJplzma8Ip/WJTLtR7T8Jpe4hhQNTMt41zO
	 SaEaMUgz8S83V9co+RidAcFYO9mQMKE6eA+Fk6O3gD70op7RX3C2++Azao2kCa3mcI
	 Q4RPVkFD7/IwzuXrRGnZf24BvFWdb0Oz3WCTpcB7pFI3p4I/vWaGl/aKBZu2nw7Bnu
	 SoVboJ25SJ7iQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E29DCE0B78; Mon, 26 Aug 2024 09:01:54 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:01:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
	akpm@linux-foundation.org, cl@linux.com, mhocko@kernel.org,
	urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <4e4a5c89-e9ec-421e-8245-f076044866c9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
 <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
 <f7266ab4-aa29-4cbc-a63e-fa582e266864@paulmck-laptop>
 <4zkfyn2shwot2zxiahn7zt7k2gpnoavyrldzzwo23qqxr6fvfh@xqlz4vehkln5>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4zkfyn2shwot2zxiahn7zt7k2gpnoavyrldzzwo23qqxr6fvfh@xqlz4vehkln5>

On Mon, Aug 26, 2024 at 11:17:29AM -0400, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 07:44:12AM GMT, Paul E. McKenney wrote:
> > I have gotten requests for a variant of SRCU that dispenses with the
> > read-side memory barriers, which would allow you to dispense with RCU.
> > Maybe an srcu_read_lock_lite() and srcu_read_unlock_lite(), similar to
> > the _nmisafe() variants.  There is always a price, and in this case the
> > price would be that srcu_read_lock_lite() and srcu_read_unlock_lite()
> > be restricted to code regions where RCU is watching.  But from what I
> > know, fs code must already abide by that restriction.
> > 
> > Would that help?
> 
> I don't think that helps here, but that is something I'd be interested
> in.
> 
> What I would like for this is:
>  - a single #define for RCU_NR_OLDSTATES for both RCU and SRCU
> 
>  - a way of getting the current RCU gp sequence number without a
>    function call, since we hit that on every single enqueue(). One of my
>    development versions added a function to RCU and SRCU for getting a
>    pointer to the internal sequence number, which we'd call at init
>    time; this lets us skip the function call and a branch. 
> 
> Another thing that might make the code a bit easier to reason about is
> if rcu_read_lock() also worked as an srcu_read_lock() - is something the
> SRCU variant you're talking about previously would provide?

Yes, srcu_read_lock_lite() would return an value that you later pass
to the corresponding srcu_read_unlock_lite(), just as srcu_read_lock()
and srcu_read_unlock() do now.

And they would have the same grace-period algorithm, and thus the same
value for NUM_ACTIVE_SRCU_POLL_OLDSTATE, as requested above.

But get_state_synchronize_srcu() is still a function call.  But the
offer of a function that checks multiple grace-period-state cookies in
one call still stands.

> In my current version of the code, we call __get_state_synchronize_rcu()
> after we've disabled interrupts; we know the rcu gp seq isn't going to
> tick while we're in the critical path. But this doesn't apply if it's
> for SRCU, and I don't want to add if (src) srcu_read_lock() branches to
> it.

Actually, disabling interrupts does *not* prevent RCU's grace-period 
sequence number from changing.  For example, the following really can
happen:

o	RCU notices that the current grace period can end.

o	A CPU disables interrupts here.

o	A call to get_state_synchronize_rcu() returns a cookie
	corresponding to the end of the grace period following the
	current one.

o	RCU ends the current grace period, therefore updating the
	grace-period sequence number.

o	RCU starts a new grace period, therefore updating the
	grace-period sequence number once again.

o	RCU cannot complete this new grace period until that CPU
	re-enables interrupts, but it has already updated its grace-period
	sequence number not once, but twice.

So if your code knows that RCU's grace-period sequence number cannot
change while a given CPU has interrupts disabled, that code has a bug.
A low-probability bug, perhaps, but if your code is running on enough
systems, it will make its presence known.

> Not at all essential, the races that result from this are harmless, but
> if we e.g. decide it's worthwhile to only kick off a gp if it hasn't
> ticked (i.e. only kick rcu if we're still on seq of the object being
> enqueued) it'd be nice.

Why not call get_state_synchronize_rcu(), and ask for a new grace period
if the value returned is different than that from the previous call?

> > > On the enqueue side, which is the fastpath, this uses a cursor - we're
> > > not walking the radix tree every time.
> > > 
> > > On the processing side, where we're kfree_bulk()ing entire radix tree
> > > nodes, the radix tree is going to have better cache locality than a list
> > > of pages.
> > 
> > Interesting.  What testing or analysis did you do in the course of
> > arriving at this conclusion?  In the meantime I will assume that the
> > analysis involves your radix-tree nodes being more than one page in size.
> 
> No, the radix tree nodes are 512 bytes; that's been sufficient in my
> testing.
> 
> (also, please don't refer to PAGE_SIZE outside of mm/ code without a
> _good_ reason; that's something we've been trying to clean up.)

Moving kfree_rcu() into mm/ will fix that problem.  Plus we did discuss
this with the mm folks back in the day, especially about the GFP flags,
so apparently there was a sufficiently good reason.  Maybe still is.

> I'll try to post some performance numbers when I have some time.

I look forward to seeing what you come up with.

> > It might or might not be reasonable, depending on what is going on in the
> > rest of the system.  The current kfree_rcu() code can run the system out
> > of full pages, but it won't impede other code allocating smaller blocks
> > of memory.  We could easily change it to allocate individual rcu_head
> > structures, but doing so would not necessarily be a win in OOM conditions,
> > again, depending on what else is going on.
> 
> As long as the thread calling kvfree_rcu_mightsleep() can block without
> blocking memory reclaim it'll be safe. We might want to tweak the GFP
> flags so to tell the allocator "don't try too hard, bail out so we can
> check if the gp has expired".

There can be quite a difference between "safe" and "does well in actual
workloads".

> > I took a quick look at __rcu_pending_enqueue() and my eyes are still
> > bleeding.  Concatenating linked list of pages is way simpler, way faster,
> > and way more robust.
> 
> Funny, I had the same thoughts trying to read your code... :)

Amazing how much easier it is to generate new code than to understand
existing code, isn't it?  ;-)

> But, most of __rcu_pending_enqueue() is slowpaths; the fastpath is just
> 
> 	objs = get_object_radix(p, seq); /* lookup seq in p->objs */
> 
>         *objs->cursor++ = ptr ?: head;                                                                                                       
>         /* zero cursor if we hit the end of a radix tree node: */                                                                            
>         if (!(((ulong) objs->cursor) & (GENRADIX_NODE_SIZE - 1)))                                                                            
>                 objs->cursor = NULL;                                                                                                         
>         start_gp = !objs->nr;                                                                                                                
>         objs->nr++;
> 
> So I think the performance concerns are moot, and for robustness -
> memory allocation failure always turns into "use the linked lists of
> objects", which works similarly to the old code.

Bugs live on slowpaths as well as on fastpaths.  In fact, they tend to
accumulate there.

> > > But yes, using it for call_rcu() would need more performance
> > > justification. I haven't seen workloads where call_rcu() performance
> > > particularly matters, so it's not something I'm pushing for - I included
> > > that because it's minimal code and other people might know of workloads
> > > where we do want it.
> > 
> > Plus, unlike kfree_rcu() post-grace-period handling, call_rcu() callback
> > functions usually access the memory block passed to them, which means
> > that they are incurring that per-element cache miss in any case.
> 
> True. But this would allow us to prefetch those objects (several
> iterations in advance).

I need to see a CPU on which this actually make a significant difference
before adding this sort of complexity.

> > > > > Ideally we would be getting a callback every time a grace period
> > > > > completes for which we have objects, but that would require multiple
> > > > > rcu_heads in flight, and since the number of gp sequence numbers with
> > > > > uncompleted callbacks is not bounded, we can't do that yet.
> > > > 
> > > > Doesn't the call from __rcu_pending_enqueue() to process_finished_items()
> > > > serve this purpose?  After all, the case that causes trouble is the one
> > > > where lots of things are being very frequently queued.
> > > 
> > > No, because that's unpredictable, and we don't process pending items in
> > > enqueue() unless we know we can sleep (i.e., we don't do it if the
> > > caller is latency sensitive).
> > 
> > It is possible to do this in an extremely lightweight fashion in the
> > common case.
> 
> Just processing a few items? hmm, would we want to though, when
> otherwise we'd be calling kfree_bulk()? I think icache locality means
> we'd generally prefer not to.

You might not want to yet, but you eventually would want this.

							Thanx, Paul
