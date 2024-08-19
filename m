Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978101607B0
	for <rcu@vger.kernel.org>; Mon, 19 Aug 2024 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724111981; cv=none; b=iazXufutando1/K3roBABqEhWg1tHZwivtutu0tqgi6GZ4JH6wSLuKUmAfYsVi/JNHfzipNTBz67ZFRnKL4C5pqyT4Y6F+7WMQqwhG4mznwhjc4bsnYyycTjn1uS+K1sLSSAf75VXVA+dtJaCLnZiVlIMdYfm6o5vtbt3sW1cXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724111981; c=relaxed/simple;
	bh=39lrZO76fyoyULLnTRX8P9BelTx0anjvSnzPre3cURI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWaDngmeZN0+wAqgKrtSdbt/xAmzO7NlNCaUSYnMOvzhCMGI0b8me+U9weNWXibGb/sA71qvO0AtrEjNn1b00lr7Dhfu1x174LamUXC0J5RIx+V9I19SfYyuV69D7wcXKaYY01AyXpi+O/qAuOggi8rD0Idhw/0W4kqkAPfPCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e3MXV3lp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e3MXV3lp"
Date: Mon, 19 Aug 2024 19:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724111977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGUz676PVcW/jPPuJusx7TiVPH5zchYLNmjYC7an/U4=;
	b=e3MXV3lpmky8ygLRZ7HO2NL/3T7+1bp7kgfoYBl+e9ic5gbxH9MoI64Lh9O+4dfkSo2cEz
	Y3hSxsqBusgEtk1ES5RE0SbV5N22qmh7WmjKQetxWADquFQ6VpfbLoQ9gcDjcgYzpoW3ai
	FSLiTJtUQSuLFI/tvCIUVaBcHf4FHDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	mhocko@kernel.org, urezki@gmail.com, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH 6/9] rcu: rcu_pending
Message-ID: <yfhctftdn4itupt735u7dnu2zt2aarm3lzvmyf6bs7hkv4radc@ndw4nsinxhqx>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-7-kent.overstreet@linux.dev>
 <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc8b09e-5f66-44de-845b-e615069c2e20@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 03:58:26PM GMT, Paul E. McKenney wrote:
> I still remain quite skeptical of this one, but it has improved since
> June's version.
> 
> Responses inline.
> 
> 							Thanx, Paul
> 
> In the meantime, thank you for avoiding reaching into RCU's and SRCU's
> innards.  This makes it reasonable to have you put this file into your
> code, at least initially.  That way, you get what you want *now* and us
> RCU guys are not committing to maintain it before it is ready for us to
> do so.

The RCU interfaces do force a lot of function calls for things that
should be inlined though, and the gratuitious interface fragmentation
between RCU and SRCU is... annoying.

> I still have strong misgivings about radix trees and cache locality.
> Poor cache locality on the other side of the grace period can result
> in OOMs during callback-flooding events, hence the move of kfree_rcu()
> and friends to pages of pointers.  And, as you note below, radix trees
> don't merge nicely.

Cache locality where?

On the enqueue side, which is the fastpath, this uses a cursor - we're
not walking the radix tree every time.

On the processing side, where we're kfree_bulk()ing entire radix tree
nodes, the radix tree is going to have better cache locality than a list
of pages.

> The advantage of synchronize_rcu() is that it can proceed without
> memory allocation.  If you block on allocation, even of a 16-byte
> rcu_head structure, you can go into OOM-induced deadlock.
> 
> It might well make sense to do an rcu_head allocation with GFP flags
> that try reasonably hard, but still allow failure before falling all
> the way back to synchronize_rcu().  (And for all I know, this might have
> been tested and found wanting, but Uladzislau Rezki (CCed) would know.)
> But a hard wait on that allocation is asking for trouble.

That's reasonable - as long as we're trying the 16 byte allocation
before doing a synchronize_rcu().

> There is work underway to make the current callback lists take advantage
> of expedited grace periods, transparent to the caller.  This allows
> the shrinker (or whatever) to speed up everything by simply invoking
> synchronize_rcu_expedited().  This speedup includes callback processing
> because it avoids "bubbles" in the callback processing that can occur
> when the next grace period has not yet completed, but all callbacks from
> earlier grace periods have been invoked.

Glad to here, that was first on my list when adding a shrinker to this
code.

> > - RCU_PENDING_CALL_RCU_FN
> > 
> >   Accelerated backend for call_rcu() - pending callbacks are tracked in
> >   a radix tree to eliminate linked list overhead.
> 
> But to add radix-tree overhead.  And to eliminate the ability to do O(1)
> list merges.  Is this really a win?

As mentioned, there's a cursor so we're not adding radix-tree overhead
to the fast path, and there's no need to merge lists for expired objects
- that's all handled fine.

But yes, using it for call_rcu() would need more performance
justification. I haven't seen workloads where call_rcu() performance
particularly matters, so it's not something I'm pushing for - I included
that because it's minimal code and other people might know of workloads
where we do want it.

> > Ideally we would be getting a callback every time a grace period
> > completes for which we have objects, but that would require multiple
> > rcu_heads in flight, and since the number of gp sequence numbers with
> > uncompleted callbacks is not bounded, we can't do that yet.
> 
> Doesn't the call from __rcu_pending_enqueue() to process_finished_items()
> serve this purpose?  After all, the case that causes trouble is the one
> where lots of things are being very frequently queued.

No, because that's unpredictable, and we don't process pending items in
enqueue() unless we know we can sleep (i.e., we don't do it if the
caller is latency sensitive).
