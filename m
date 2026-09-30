Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39864F55B6;
	Wed, 30 Sep 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787218; cv=none; b=lSAQtXJHOmGuG7wIQERWsxyDCz43Q1aqb/ital5QPmwaA9UaghbHfpX2nFFOcL7Q61SjRF5miqW3UWkslBZSpXkq7uhUFqVdta+jTwCfxmqG4XUE8abyGBrNloalVo1YzsPuXjWeZv67fWbwWqrq1Rxp3GBSdLFP9YIGNtg/+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787218; c=relaxed/simple;
	bh=PXU4L/rhm7gTrQUiqwILtc2ZR5FLni97ze7G8bRA0k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rROvmGJtIKN9rP8g+i6GgzDUFwACvnbq2MPPNnziIJ/PBOgOcs6s1E93tiTdpcvcTFSOMVboRhhFGmUZin7kmCjVrf6ohNa4r48YAXfqOXi2jr5jpkJKNS11yOUvBc4z8uwNg0k2oDeBMjIq/B5CXymOpvqVIwBEEk1WfUrUNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXoyolM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXoyolM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AACB1F00898;
	Wed, 30 Sep 2026 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790787217;
	bh=x8atLu14VZuHnVjacMM8nUMcUY8ko2513gAda/zTqsU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=mXoyolM8I0YXURclZsKkzWgM+19QI52Y/9Y9kzKpynw/CIB2iGYkqFWt2Cvi4VmO8
	 0svbJ8csZsNn88qvbffyq/xOjYCTpiTWSPA+69jT67Ma1jhIb6JV+ogRYv/BEFOMk3
	 3HtpFuoN2m0HaJjVccsIoBZHueUZM3Esue1hbRkw4q/y8C2dX4X7B5q+9Dtg8HAKPN
	 Addo/FBZQqgqAeMmAusXwvdu7LFAHoOe1xlctNNLFtjB4Vlf9VShYwV0SNE8K7zL9V
	 iDT05A+ANSv6cMq8GmzPNJ50XdQ9NDe3D+vob6FHN/+tt7cn+Mf6V4gFfZ2TPvALPa
	 CC43Uqmkik3FQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D1D62CE097C; Wed, 30 Sep 2026 09:53:36 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:53:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <739312fc-c60b-4e80-a30d-ffdd8ce2d380@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
 <arlROwtdFs3YyUt_@MacBook-0RXW5>
 <e26f28e9-e83c-4b39-85f5-928a8097019f@efficios.com>
 <arlddI54CR7gNqCO@MacBook-0RXW5>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arlddI54CR7gNqCO@MacBook-0RXW5>

On Sun, Sep 27, 2026 at 08:16:20PM +0200, Boqun Feng wrote:
> On Sun, Sep 27, 2026 at 01:36:54PM -0400, Mathieu Desnoyers wrote:
> > On 2026-09-27 13:24, Boqun Feng wrote:
> > > On Sun, Sep 27, 2026 at 01:15:39PM -0400, Mathieu Desnoyers wrote:
> > > [...]
> > > > > > @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> > > > > >    	for_each_possible_cpu(cpu) {
> > > > > >    		/*
> > > > > >    		 * Scan CPU slots.
> > > > > > -		 * Forward progress against recurring wildcards is guaranteed
> > > > > > -		 * by scanning for one wildcard while new elements use the
> > > > > > -		 * other wildcard value (1UL vs 2UL).
> > > > > >    		 * Forward progress against recurring single hazard pointer
> > > > > >    		 * values is guaranteed by the fact that a hazard pointer
> > > > > >    		 * is not reclaimed nor reused until the scan for that hazard
> > > > > >    		 * pointer completes, which prevents a steady flow of readers
> > > > > >    		 * to acquire that same hazard pointer value.
> > > > > 
> > > > > (Not a comment to this patch, but I think it's worth bringing up)
> > > > > 
> > > > > I want to point out this is not true for the lockdep use case, because
> > > > > the we need to protect a hash list deletion there, and we use the
> > > > > address of the hash bucket there. It's proven fine in practice because
> > > > > the readers are rare (we only call the reader is_dynamic_key() in
> > > > > register_lock_class(), that is every time you have a new lock class to
> > > > > register).
> > > > > 
> > > > > Maybe what we want to say here is that "if the users guarantee no steady
> > > > > flow of the same hazard pointer value, we guarantee forward progress".
> > > > > Thoughts?
> > > > 
> > > > AFAIU, your approach to protect lockdep linked lists is to use the
> > > > address of the hash bucket to protect the traversal. As this address is
> > > > invariant (global array item address), that address should be fine
> > > > to fulfill hazptr requirements, but it has downsides: rather than
> > > > protecting the specific nodes being retired, the whole hash chain is
> > > > protected. This means that, as you point out, many readers retiring
> > > > nodes from a given bucket (except the first node) could end up holding a
> > > > continuous stream of hazptr for a given hazptr value, preventing
> > > > progress of hazptr synchronize.
> > > > 
> > > > It's also coarser: per-bucket rather than per-node.
> > > > 
> > > > Am I missing something here ?
> > > > 
> > > 
> > > No, you got it right, but as I said, we can use it in lockdep since the
> > > readers are relatively rare, so not an issue here.

This sort of tradeoff is made in hazard-pointer use cases in other
projects, with use of explicit counts of the incoming links to a given
node being one such trick.  The explicit count counts the links, and
hazard pointers counts the readers.  This approach usually ends up
also restricting the order in which nodes can be removed.

Just like SRCU partitions the readers coming from the RCU end.  ;-)

> > > > One honest question: is this pattern something we expect to
> > > > see often ? If so, then we may want to introduce a notion of
> > > 
> > > I honestly don't know. But in my opinion, we'd better focus on finding
> > > more typical usage of hazptr (i.e. protecting actual object). So ...
> > > 
> > > > hazptr protection "period" flip (similar to some RCU implementations),
> > > > where we tag the low bit of the slot pointer (0 vs 1), and alternate
> > > > between the two periods in synchronize. This would prevent a steady-flow
> > > > of same-value readers from preventing synchronize forward progress.
> > > > 
> > > > Thoughts ?
> > > > 
> > > 
> > > ... I will say let's add it only if we have more users of this pattern.
> > > 
> > 
> > I am concerned about this because many uses of RCU in the Linux
> > kernel protects linked list traversals. Turning a RCU-protected list
> > traversal into a hazptr protected traversal is not as simple as
> > acquiring each hazptr hand in hand.
> 
> I actually don't think converting RCU usage into hazptr would be a good
> starting point for finding good hazptr usage. RCU readers are faster,
> and a lot of existing RCU users do want the reader side to be as fast as
> possible. So even though this is a problem, but I don't think that's an
> urgent problem to resolve. Of course, if one can find a faster hazptr
> reader implemenation, then it may be a different story.

The usual hazard-pointers linked-list traversal includes a retry check
at each node.  So yes, we should first be looking for hazard-pointer
use cases where RCU doesn't have such a great advantage.  ;-)

> > Your own use-case for lockdep is indeed a linked list traversal,
> > and you need to use a work-around: protect the address of the
> > hash bucket head.
> 
> So the lockdep usage is IMO a very special case, but it does show the
> advantages of hazptr.
> 
> > I'm just wondering if this work-around will end up being the
> > "blessed" way for protecting linked list traversals with hazptr,
> > or whether we should consider alternatives ?
> 
> It depends on how many uses of the linked list traversals really care
> about the reader side performance. I'm not sure we can easily find
> another one like lockdep. Hence I think we should only add the
> optimization when we find more of such a usage. Make sense?
> 
> Personally, I also want to see a refcount-like usage for hazptr, that'll
> be very exciting for me :D

Me too!  The easiest cases will be those having a try-acquire rather
than an unconditional acquisition.

							Thanx, Paul

> Regards,
> Boqun
> 
> > This ties into finding additional usage for hazptr, because linked
> > lists are so prevalent in the kernel.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > > Regards,
> > > Boqun
> > > 
> > > > Thanks,
> > > > 
> > > > Mathieu
> > > > 
> > > > > 
> > > > > The rest looks good to me.
> > > > > 
> > > > > Regards,
> > > > > Boqun
> > > > > 
> > > > 
> > > > 
> > > > -- 
> > > > Mathieu Desnoyers
> > > > EfficiOS Inc.
> > > > https://www.efficios.com
> > 
> > 
> > -- 
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
