Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD2D1B808;
	Tue, 21 Jan 2025 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491556; cv=none; b=CHGFoiWQrzhE706A7aDDnig7+T2b+BGkji2faV8rawtf6Zx4pAnuw5lSSqCGH//hzQZZaN04DoVZkDVcwWwN6R/bTCJA+o5afkuwNv1cf+Q8Qi/WQgfWxESADbrkXFT9n++XQsjqVyeJqbjU9aFdiSQDSnaE810G6SH+h2do8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491556; c=relaxed/simple;
	bh=wammBvIw3dJ8RgfpkognKu1INahaT5JaO/KOGAL5arA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8kJt+7b+UQl1Y13x9KSx1sIPc/kQ5CWmGaiVslRyWsWgsoXZ/cmXYQ4lF2o50BFAXhM4OG07pnlTpzq37EKUvwxAE0TRm6jCvuio1v08gI0+4LJLKXc9KYEmdP9z+VQ2Ew+ey23SozXxzqWoeSpfKO41/yk4aO2X6Y8u8ms94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPBB6QHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPBB6QHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E200C4CEDF;
	Tue, 21 Jan 2025 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737491554;
	bh=wammBvIw3dJ8RgfpkognKu1INahaT5JaO/KOGAL5arA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MPBB6QHFQWXZBw8uF2X7cihvWvZfi+xX+Nz3gBW6fUw8NjotUXjLAhVSnH2E8aKjj
	 cI0T1R7CFq8jqnHkJvfeG07qlbXEUWsGjY2N9tWiSgky5RLLyE4lrBXiKD+mdmAlSw
	 wHQG2ynq4Bdqp0I8UXfNoRGM8tKrTf0/q0JLWT1Fr9fWYgY2X2gj6EA+nvZoBctYu/
	 18J366zgxuJawIZK9cMrlEISanW4X3hB5WSu1y/cZQRVkTw2aIez8d9Qz17EZ4Qs7Q
	 FQtx1+KksZlXV0wuH2fFYHVLLHs+/FgmLjipMLmMZBtwYhr9ER90Om0GBnsFxrQu0s
	 DABNQwB49tmCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2CF4DCE10F9; Tue, 21 Jan 2025 12:32:34 -0800 (PST)
Date: Tue, 21 Jan 2025 12:32:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Message-ID: <7b7b92a3-780e-4db0-a5cf-3e78d79587a2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z2AJCI3cIR9ETFFu@pc636>
 <d352db4f-4bb8-4300-b235-bbd1bdb3aa21@suse.cz>
 <Z2BKLzOGv_Ki_7fj@pc636>
 <6fb206de-0185-4026-a6f5-1d150752d8d0@suse.cz>
 <Z2BNWpkruY6rJv6A@pc636>
 <5bb80786-220d-45d2-bd35-51876df4203c@paulmck-laptop>
 <55931fdd-1d5f-4ffd-8496-fe436171dee2@suse.cz>
 <Z4-iDAONPyf7ljBU@pc636>
 <970317a9-0283-4eec-94ae-63056659d7de@suse.cz>
 <Z4-ruJ3KVD3PieZi@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4-ruJ3KVD3PieZi@pc636>

On Tue, Jan 21, 2025 at 03:14:16PM +0100, Uladzislau Rezki wrote:
> On Tue, Jan 21, 2025 at 02:49:13PM +0100, Vlastimil Babka wrote:
> > On 1/21/25 2:33 PM, Uladzislau Rezki wrote:
> > > On Mon, Jan 20, 2025 at 11:06:13PM +0100, Vlastimil Babka wrote:
> > >> On 12/16/24 17:46, Paul E. McKenney wrote:
> > >>> On Mon, Dec 16, 2024 at 04:55:06PM +0100, Uladzislau Rezki wrote:
> > >>>> On Mon, Dec 16, 2024 at 04:44:41PM +0100, Vlastimil Babka wrote:
> > >>>>> On 12/16/24 16:41, Uladzislau Rezki wrote:
> > >>>>>> On Mon, Dec 16, 2024 at 03:20:44PM +0100, Vlastimil Babka wrote:
> > >>>>>>> On 12/16/24 12:03, Uladzislau Rezki wrote:
> > >>>>>>>> On Sun, Dec 15, 2024 at 06:30:02PM +0100, Vlastimil Babka wrote:
> > >>>>>>>>
> > >>>>>>>>> Also how about a followup patch moving the rcu-tiny implementation of
> > >>>>>>>>> kvfree_call_rcu()?
> > >>>>>>>>>
> > >>>>>>>> As, Paul already noted, it would make sense. Or just remove a tiny
> > >>>>>>>> implementation.
> > >>>>>>>
> > >>>>>>> AFAICS tiny rcu is for !SMP systems. Do they benefit from the "full"
> > >>>>>>> implementation with all the batching etc or would that be unnecessary overhead?
> > >>>>>>>
> > >>>>>> Yes, it is for a really small systems with low amount of memory. I see
> > >>>>>> only one overhead it is about driving objects in pages. For a small
> > >>>>>> system it can be critical because we allocate.
> > >>>>>>
> > >>>>>> From the other hand, for a tiny variant we can modify the normal variant
> > >>>>>> by bypassing batching logic, thus do not consume memory(for Tiny case)
> > >>>>>> i.e. merge it to a normal kvfree_rcu() path.
> > >>>>>
> > >>>>> Maybe we could change it to use CONFIG_SLUB_TINY as that has similar use
> > >>>>> case (less memory usage on low memory system, tradeoff for worse performance).
> > >>>>>
> > >>>> Yep, i also was thinking about that without saying it :)
> > >>>
> > >>> Works for me as well!
> > >>
> > >> Hi, so I tried looking at this. First I just moved the code to slab as seen
> > >> in the top-most commit here [1]. Hope the non-inlined __kvfree_call_rcu() is
> > >> not a show-stopper here.
> > >>
> > >> Then I wanted to switch the #ifdefs from CONFIG_TINY_RCU to CONFIG_SLUB_TINY
> > >> to control whether we use the full blown batching implementation or the
> > >> simple call_rcu() implmentation, and realized it's not straightforward and
> > >> reveals there are still some subtle dependencies of kvfree_rcu() on RCU
> > >> internals :)
> > >>
> > >> Problem 1: !CONFIG_SLUB_TINY with CONFIG_TINY_RCU
> > >>
> > >> AFAICS the batching implementation includes kfree_rcu_scheduler_running()
> > >> which is called from rcu_set_runtime_mode() but only on TREE_RCU. Perhaps
> > >> there are other facilities the batching implementation needs that only
> > >> exists in the TREE_RCU implementation
> > >>
> > >> Possible solution: batching implementation depends on both !CONFIG_SLUB_TINY
> > >> and !CONFIG_TINY_RCU. I think it makes sense as both !SMP systems and small
> > >> memory systems are fine with the simple implementation.
> > >>
> > >> Problem 2: CONFIG_TREE_RCU with !CONFIG_SLUB_TINY
> > >>
> > >> AFAICS I can't just make the simple implementation do call_rcu() on
> > >> CONFIG_TREE_RCU, because call_rcu() no longer knows how to handle the fake
> > >> callback (__is_kvfree_rcu_offset()) - I see how rcu_reclaim_tiny() does that
> > >> but no such equivalent exists in TREE_RCU. Am I right?
> > >>
> > >> Possible solution: teach TREE_RCU callback invocation to handle
> > >> __is_kvfree_rcu_offset() again, perhaps hide that branch behind #ifndef
> > >> CONFIG_SLUB_TINY to avoid overhead if the batching implementation is used.
> > >> Downside: we visibly demonstrate how kvfree_rcu() is not purely a slab thing
> > >> but RCU has to special case it still.
> > >>
> > >> Possible solution 2: instead of the special offset handling, SLUB provides a
> > >> callback function, which will determine pointer to the object from the
> > >> pointer to a middle of it without knowing the rcu_head offset.
> > >> Downside: this will have some overhead, but SLUB_TINY is not meant to be
> > >> performant anyway so we might not care.
> > >> Upside: we can remove __is_kvfree_rcu_offset() from TINY_RCU as well
> > >>
> > >> Thoughts?
> > >>
> > > For the call_rcu() and to be able to reclaim over it we need to patch the
> > > tree.c(please note TINY already works):
> > > 
> > > <snip>
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b1f883fcd918..ab24229dfa73 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2559,13 +2559,19 @@ static void rcu_do_batch(struct rcu_data *rdp)
> > >                 debug_rcu_head_unqueue(rhp);
> > > 
> > >                 rcu_lock_acquire(&rcu_callback_map);
> > > -               trace_rcu_invoke_callback(rcu_state.name, rhp);
> > > 
> > >                 f = rhp->func;
> > > -               debug_rcu_head_callback(rhp);
> > > -               WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > > -               f(rhp);
> > > 
> > > +               if (__is_kvfree_rcu_offset((unsigned long) f)) {
> > > +                       trace_rcu_invoke_kvfree_callback("", rhp, (unsigned long) f);
> > > +                       kvfree((void *) rhp - (unsigned long) f);
> > > +               } else {
> > > +                       trace_rcu_invoke_callback(rcu_state.name, rhp);
> > > +                       debug_rcu_head_callback(rhp);
> > > +                       WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
> > > +                       f(rhp);
> > > +               }
> > >                 rcu_lock_release(&rcu_callback_map);
> > 
> > Right so that's the first Possible solution, but without the #ifdef. So
> > there's an overhead of checking __is_kvfree_rcu_offset() even if the
> > batching is done in slab and this function is never called with an offset.
> >
> Or fulfilling a missing functionality? TREE is broken in that sense
> whereas a TINY handles it without any issues. 
> 
> It can be called for SLUB_TINY option, just call_rcu() instead of
> batching layer. And yes, kvfree_rcu_barrier() switches to rcu_barrier().

Would this make sense?

		if (IS_ENABLED(CONFIG_TINY_RCU) && __is_kvfree_rcu_offset((unsigned long) f)) {

Just to be repetitive, other alternatives include:

1.	Take advantage of SLOB being no longer with us.

2.	Get rid of Tiny RCU's special casing of kfree_rcu(), and then
	eliminate the above "if" statement in favor of its "else" clause.

3.	Make Tiny RCU implement a trivial version of kfree_rcu() that
	passes a list through RCU.

I don't have strong feelings, and am happy to defer to your guys'
decision.

> > After coming up with Possible solution 2, I've started liking the idea
> > more as RCU could then forget about the __is_kvfree_rcu_offset()
> > "callbacks" completely, and the performant case of TREE_RCU + batching
> > would be unaffected.
> > 
> I doubt it is a performance issue :)

Me neither, especially with IS_ENABLED().

> > I'm speculating perhaps if there was not CONFIG_SLOB in the past, the
> > __is_kvfree_rcu_offset() would never exist in the first place? SLAB and
> > SLUB both can determine start of the object from a pointer to the middle
> > of it, while SLOB couldn't.
> > 
> We needed just to reclaim over RCU. So, i do not know. Paul probably
> knows more then me :)

In the absence of SLOB, yes, I would hope that I would have thought of
determining the start of the object from a pointer to the middle of it.
Or that someone would have pointed that out during review.  But I honestly
do not remember.  ;-)

> > >                 /*
> > > <snip>
> > > 
> > > Mixing up CONFIG_SLUB_TINY with CONFIG_TINY_RCU in the slab_common.c
> > > should be avoided, i.e. if we can, we should eliminate a dependency on
> > > TREE_RCU or TINY_RCU in a slab. As much as possible.
> > > 
> > > So, it requires a more closer look for sure :)
> > 
> > That requires solving Problem 1 above, but question is if it's worth the
> > trouble. Systems running TINY_RCU are unlikely to benefit from the batching?
> > 
> > But sure there's also possibility to hide these dependencies in KConfig,
> > so the slab code would only consider a single (for example) #ifdef
> > CONFIG_KVFREE_RCU_BATCHING that would be set automatically depending on
> > TREE_RCU and !SLUB_TINY.
> > 
> It is for small systems. We can use TINY or !SMP. We covered this AFAIR
> that a single CPU system should not go with batching:
> 
> #ifdef SLUB_TINY || !SMP || TINY_RCU
> 
> or:
> 
> config TINY_RCU
> 	bool
> 	default y if !PREEMPT_RCU && !SMP
> +	select SLUB_TINY
> 
> 
> Paul, more input?

I will say that Tiny RCU used to get much more focus from its users
10-15 years ago than it does now.  So one approach is to implement
the simplest option, and add any needed complexity back in when and if
people complain.  ;-)

							Thanx, Paul
