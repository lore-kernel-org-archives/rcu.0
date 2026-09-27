Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C2356757;
	Sun, 27 Sep 2026 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532985; cv=none; b=Yb/ZRm4oE1dGRgaTwcz+KA1AkQMjdWPuqnuc6uPnkGwX8VZd1wEWw7HpugZiHQryyld9kbpyb1z/5O/QDAdWHfIYTo73JsfP2MkbmMaWj5MoHpadrV0d6qlWWbvSKfryvVxIc647E04NDe3AoxEdC3bNDpAv7ZVQAwwK45mEJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532985; c=relaxed/simple;
	bh=KX03MZouX/58JMXJgVQEQjmPyANc7CuZ4CwUNfDNnEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aj4ils0WRuSJxGyT0oNv2KEf0dPSSllL/q4ZvIuuuw+xMloCaGnQp6uGzJj/copUrB3xzXwoPRDfvb/txfE8aqBnnIj34wtSdzN3ylpjAay+yenrRijRYVz9NKB0Ed441aIp8PeSFVSCPa9fvk2ZToldvRiT39hdGoElwzE7A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kleZlVwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kleZlVwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044561F00898;
	Sun, 27 Sep 2026 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790532983;
	bh=LkvL+n0hidIeUwvFKfjJo1KASEBqWMZwEn4GwOa9B5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kleZlVwpOsWZ4Z9o6H8bTsEnvWq4mUKn3nj3d+2nwCo6HDhtw8Fm2UlCE0PMvo0Nh
	 WIGSpXPYptMQAOPgiF14YSD7i7YqwgYaaZJjsCVIpM3UWrrLJXsM6lg2Coui/+18V1
	 IeyS1Et0xy9/BYt6fnk1WuYWfM6P3evf/YjHL6DlJz5BFdIURWn/yp8SfUU6rpab4y
	 ejgeTEV015ZZoP4BaVHha1ezn8QV00sMLppIpEPYB+Fs0vKda7BKyik7haVAUisJEO
	 1/jtbOBo9P+BHBKA1d7q7W4zFup0/heWzPae6CcszolQUWUMsWKxFP2K2llZwsKsX4
	 mhNlBg+sEV2Tg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 054A0F40066;
	Sun, 27 Sep 2026 14:16:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 27 Sep 2026 14:16:22 -0400
X-ME-Sender: <xms:dV25agrcXoLve5QwSrZQcu6EKzqHbE4F7cRZmCUGw8RIIbgHZXpiHA>
    <xme:dV25asojTxpEW04E2xe0a3PeFDVnYL5noNX7dtz-9JLHVDuED1iok_OYbgaHCyLaF
    9-fIhBaVnXxcozyIW-s8-c7cM3YwLIQzzewSA0tsWdKEifFZzZAqOY>
X-ME-Received: <xmr:dV25agAi0guSYiWNQJG_zKgk2JXYJP0Vvy2wB7ku03cIIKSY95V4w3-XkJaX>
X-ME-Proxy-Cause: dmFkZTEd3dAmnS+BTXSGiWcC9oa/nuVjVBYY0juwULTvkawoBsMtAnCLWBLp32YVUrxNpz
    o2rRydFqJUM/hxT/BmMAHrWxheKZgY0oqtWELVgVicUK0FKaLtF+r2h3C3gT0VmkNSmk5O
    Aw4h9366LY6iOKjCBeqzgDpteGf941w6e9mHZjy5qO5jihLlOO6bk9ZL6ZxjUZOOclGxNF
    RHpPngc8L45XfEbtPWAJnd4QLf+Q/S/cVMR4Bm48m2bpQB7VA/C2J9YZuByMiLz6NXbZGF
    RUcQ9IHfSrlj5LdBX/3qhX/HDc35fZFGvwP4bam7O8FSfwTQU4tnyEwLdHm1OHZx9jUvd8
    trElORbhaWCU4AgZkrOK8VR1Clv4GArM3qKOSbdqJCOOdtXIIo7FcU3UIa2+zzP4dWf6oC
    rjoyzhSqidO8KZbcW+dVt8e5JppsuOAmmWh5kGZUocg4bCStqbvqIifR1SaZrxT+hjVnrB
    8y83XM1BtYqTg9PPZX4o74/Q8S6/uAV8Tf5wiQ2zHLRE8MPkmvqcR34jMYBSKlVlxvpHPe
    X6CZwDwghUSqW/OhJK55IWOhJQEFW41FBlTyGvEPJhB6iQMkrI//0w1VkkhGwClcUvUJzV
    Qe0aOAwOUJFVeMxHVWHwmFsVEOkERfRS7xeUsJvAkQJWX9EX1PbjOF+WAhoQ
X-ME-Proxy: <xmx:dV25aquKdu2eIO0W9E2xOKHFibNe8jDKiExpylbxUsX2Lw5UndAa1Q>
    <xmx:dV25avJuLUU1KgAkIIGD5W8cOro2sfIDG6t6t7tMdT7qirlgedSJ1A>
    <xmx:dV25ahYvlsvc672bCbDouFAM4PVZ6p44p4p5nIRl7wBy639ZLd0uFg>
    <xmx:dV25ahAU1hB5iA-SvQpM3eNvidDvLn2xhg5V489httlGKC6NNlS2cg>
    <xmx:dV25ara90daPKhmh6154aDvU2AksHqwRs6knaNLpMHV2T8DldBgdYFl0>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Sep 2026 14:16:21 -0400 (EDT)
Date: Sun, 27 Sep 2026 20:16:20 +0200
From: Boqun Feng <boqun@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr 4/4] hazptr: Introduce "try acquire" fast path,
 fallback to overflow list
Message-ID: <arlddI54CR7gNqCO@MacBook-0RXW5>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com>
 <20260927155134.4740-5-mathieu.desnoyers@efficios.com>
 <arlHFVT5EzcX4d1-@MacBook-0RXW5>
 <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com>
 <arlROwtdFs3YyUt_@MacBook-0RXW5>
 <e26f28e9-e83c-4b39-85f5-928a8097019f@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26f28e9-e83c-4b39-85f5-928a8097019f@efficios.com>

On Sun, Sep 27, 2026 at 01:36:54PM -0400, Mathieu Desnoyers wrote:
> On 2026-09-27 13:24, Boqun Feng wrote:
> > On Sun, Sep 27, 2026 at 01:15:39PM -0400, Mathieu Desnoyers wrote:
> > [...]
> > > > > @@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> > > > >    	for_each_possible_cpu(cpu) {
> > > > >    		/*
> > > > >    		 * Scan CPU slots.
> > > > > -		 * Forward progress against recurring wildcards is guaranteed
> > > > > -		 * by scanning for one wildcard while new elements use the
> > > > > -		 * other wildcard value (1UL vs 2UL).
> > > > >    		 * Forward progress against recurring single hazard pointer
> > > > >    		 * values is guaranteed by the fact that a hazard pointer
> > > > >    		 * is not reclaimed nor reused until the scan for that hazard
> > > > >    		 * pointer completes, which prevents a steady flow of readers
> > > > >    		 * to acquire that same hazard pointer value.
> > > > 
> > > > (Not a comment to this patch, but I think it's worth bringing up)
> > > > 
> > > > I want to point out this is not true for the lockdep use case, because
> > > > the we need to protect a hash list deletion there, and we use the
> > > > address of the hash bucket there. It's proven fine in practice because
> > > > the readers are rare (we only call the reader is_dynamic_key() in
> > > > register_lock_class(), that is every time you have a new lock class to
> > > > register).
> > > > 
> > > > Maybe what we want to say here is that "if the users guarantee no steady
> > > > flow of the same hazard pointer value, we guarantee forward progress".
> > > > Thoughts?
> > > 
> > > AFAIU, your approach to protect lockdep linked lists is to use the
> > > address of the hash bucket to protect the traversal. As this address is
> > > invariant (global array item address), that address should be fine
> > > to fulfill hazptr requirements, but it has downsides: rather than
> > > protecting the specific nodes being retired, the whole hash chain is
> > > protected. This means that, as you point out, many readers retiring
> > > nodes from a given bucket (except the first node) could end up holding a
> > > continuous stream of hazptr for a given hazptr value, preventing
> > > progress of hazptr synchronize.
> > > 
> > > It's also coarser: per-bucket rather than per-node.
> > > 
> > > Am I missing something here ?
> > > 
> > 
> > No, you got it right, but as I said, we can use it in lockdep since the
> > readers are relatively rare, so not an issue here.
> > 
> > > One honest question: is this pattern something we expect to
> > > see often ? If so, then we may want to introduce a notion of
> > 
> > I honestly don't know. But in my opinion, we'd better focus on finding
> > more typical usage of hazptr (i.e. protecting actual object). So ...
> > 
> > > hazptr protection "period" flip (similar to some RCU implementations),
> > > where we tag the low bit of the slot pointer (0 vs 1), and alternate
> > > between the two periods in synchronize. This would prevent a steady-flow
> > > of same-value readers from preventing synchronize forward progress.
> > > 
> > > Thoughts ?
> > > 
> > 
> > ... I will say let's add it only if we have more users of this pattern.
> > 
> 
> I am concerned about this because many uses of RCU in the Linux
> kernel protects linked list traversals. Turning a RCU-protected list
> traversal into a hazptr protected traversal is not as simple as
> acquiring each hazptr hand in hand.
> 

I actually don't think converting RCU usage into hazptr would be a good
starting point for finding good hazptr usage. RCU readers are faster,
and a lot of existing RCU users do want the reader side to be as fast as
possible. So even though this is a problem, but I don't think that's an
urgent problem to resolve. Of course, if one can find a faster hazptr
reader implemenation, then it may be a different story.

> Your own use-case for lockdep is indeed a linked list traversal,
> and you need to use a work-around: protect the address of the
> hash bucket head.
> 

So the lockdep usage is IMO a very special case, but it does show the
advantages of hazptr.

> I'm just wondering if this work-around will end up being the
> "blessed" way for protecting linked list traversals with hazptr,
> or whether we should consider alternatives ?
> 

It depends on how many uses of the linked list traversals really care
about the reader side performance. I'm not sure we can easily find
another one like lockdep. Hence I think we should only add the
optimization when we find more of such a usage. Make sense?

Personally, I also want to see a refcount-like usage for hazptr, that'll
be very exciting for me :D

Regards,
Boqun

> This ties into finding additional usage for hazptr, because linked
> lists are so prevalent in the kernel.
> 
> Thanks,
> 
> Mathieu
> 
> > Regards,
> > Boqun
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > > 
> > > > The rest looks good to me.
> > > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > 
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
