Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E223CC43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69AB20719
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585769646;
	bh=1ziAwZyWgAC9dJ1aazSpPutT4RCKJC3VTwgJQkvvvyw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LlmGOErlYKX7VXW1KIA+Ecc7VytJ0SgyqaXhyESfKFA4HFmUQWwK60Jf9V8Wm6nK1
	 mpeE8JwlHj94Z3Rdt8Es+/irHbWklpypH/banA+tzmm9Fg0dPaz9UY3jUveIUUxAz8
	 Jc0woEYEVoh+e0P5zm8xpXSnuSjz05oCuz8/FvME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgDATeG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbgDATeG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 15:34:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6309220714;
        Wed,  1 Apr 2020 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585769645;
        bh=1ziAwZyWgAC9dJ1aazSpPutT4RCKJC3VTwgJQkvvvyw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MXP/dCzeEguEmqrUkbR0Lc9vwOEIXHDkxr40tpnGwm6DWP0BF5auzVcjxwSUn8wgK
         by661+RJU8b8/bzQaFMLLtPqCDK2qJlBfEYvarJuFYngvS4g15pdFM0IfFiOo1P5VV
         Ouj6X8nHQNDF3vDf/nuWVXjxMOwj8L2WWOW3HOGE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2877335226B3; Wed,  1 Apr 2020 12:34:05 -0700 (PDT)
Date:   Wed, 1 Apr 2020 12:34:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401193405.GH19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
 <20200401134745.GV19865@paulmck-ThinkPad-P72>
 <20200401181601.GA4042@pc636>
 <20200401182615.GE19865@paulmck-ThinkPad-P72>
 <20200401183745.GA5960@pc636>
 <20200401185439.GG19865@paulmck-ThinkPad-P72>
 <20200401190548.GA6360@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401190548.GA6360@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 09:05:48PM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 01, 2020 at 11:54:39AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 01, 2020 at 08:37:45PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Apr 01, 2020 at 11:26:15AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Apr 01, 2020 at 08:16:01PM +0200, Uladzislau Rezki wrote:
> > > > > > > > 
> > > > > > > > Right. Per discussion with Paul, we discussed that it is better if we
> > > > > > > > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > > > > > > > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > > > > > > > 
> > > > > > > As discussed before, we can make use of memory pool API for such
> > > > > > > purpose. But i am not sure if it should be one pool per CPU or
> > > > > > > one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> > > > > > > blocks.
> > > > > > 
> > > > > > There are advantages and disadvantages either way.  The advantage of the
> > > > > > per-CPU pool is that you don't have to worry about something like lock
> > > > > > contention causing even more pain during an OOM event.  One potential
> > > > > > problem wtih the per-CPU pool can happen when callbacks are offloaded,
> > > > > > in which case the CPUs needing the memory might never be getting it,
> > > > > > because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
> > > > > > might never be invoking them.
> > > > > > 
> > > > > > But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
> > > > > > either don't have heavy callback loads (HPC systems) or are carefully
> > > > > > configured (real-time systems).  Plus large systems would probably end
> > > > > > up needing something pretty close to a slab allocator to keep from dying
> > > > > > from lock contention, and it is hard to justify that level of complexity
> > > > > > at this point.
> > > > > > 
> > > > > > Or is there some way to mark a specific slab allocator instance as being
> > > > > > able to keep some amount of memory no matter what the OOM conditions are?
> > > > > > If not, the current per-CPU pre-allocated cache is a better choice in the
> > > > > > near term.
> > > > > > 
> > > > > As for mempool API:
> > > > > 
> > > > > mempool_alloc() just tries to make regular allocation taking into
> > > > > account passed gfp_t bitmask. If it fails due to memory pressure,
> > > > > it uses reserved preallocated pool that consists of number of
> > > > > desirable elements(preallocated when a pool is created).
> > > > > 
> > > > > mempoll_free() returns an element to to pool, if it detects that
> > > > > current reserved elements are lower then minimum allowed elements,
> > > > > it will add an element to reserved pool, i.e. refill it. Otherwise
> > > > > just call kfree() or whatever we define as "element-freeing function."
> > > > 
> > > > Unless I am missing something, mempool_alloc() acquires a per-mempool
> > > > lock on each invocation under OOM conditions.  For our purposes, this
> > > > is essentially a global lock.  This will not be at all acceptable on a
> > > > large system.
> > > > 
> > > It uses pool->lock to access to reserved objects, so if we have one memory
> > > pool per one CPU then it would be serialized.
> > 
> > I am having difficulty parsing your sentence.  It looks like your thought
> > is to invoke mempool_create() for each CPU, so that the locking would be
> > on a per-CPU basis, as in 128 invocations of mempool_init() on a system
> > having 128 hardware threads.  Is that your intent?
> > 
> In order to serialize it, you need to have it per CPU. So if you have 128
> cpus, it means:
> 
> <snip>
> for_each_possible_cpu(...)
>     cpu_pool = mempool_create();
> <snip>
> 
> but please keep in mind that it is not my intention, but i had a though
> about mempool API. Because it has pre-reserve logic inside.

OK, fair point on use of mempool API, but my guess is that extending
the current kfree_rcu() logic will be simpler.

							Thanx, Paul
