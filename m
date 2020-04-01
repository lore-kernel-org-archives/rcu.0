Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A726DC43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CBD20784
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585767281;
	bh=k7sUy1LckokKCq2t+CbZYwxrRl/pN5BuQ9TB1aBzy3s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j6EhdSFrsRPpJhb6hfscgSn8sJedvqHDC8I8/XiBg00nuYX4FeTZLrDWe4LlnYBjZ
	 3Pl9cv8EU8Tzu1tuD1qHi2agQIlzgQRwG7TgSO9+q0miEXjvvH1ma4zP9RJOoyoWGj
	 5wqQkjYH4tz6aZJ/gfCs9aLSn8OWl0z+P3eSqfVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgDASyl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727541AbgDASyk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 14:54:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8EF206F5;
        Wed,  1 Apr 2020 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767279;
        bh=k7sUy1LckokKCq2t+CbZYwxrRl/pN5BuQ9TB1aBzy3s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MelMnNfTeXQKB2DLtL0mdeiiR66K6cabljyah83phWY7fdJUjLuPt4zCaK7fbv34z
         sf7GNcZ4tb6Y8cyamfZeYMytmvw3aktkQ2uzTnGYopg9J4KqjlBGMnPPod5zuWLsWR
         TQIb+KijMaQ2MXLmp8humArdY09lhSqBVn5Q2b+A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4314F35226B3; Wed,  1 Apr 2020 11:54:39 -0700 (PDT)
Date:   Wed, 1 Apr 2020 11:54:39 -0700
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
Message-ID: <20200401185439.GG19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
 <20200331150911.GC236678@google.com>
 <20200331160119.GA27614@pc636>
 <20200331183000.GD236678@google.com>
 <20200401122550.GA32593@pc636>
 <20200401134745.GV19865@paulmck-ThinkPad-P72>
 <20200401181601.GA4042@pc636>
 <20200401182615.GE19865@paulmck-ThinkPad-P72>
 <20200401183745.GA5960@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401183745.GA5960@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 08:37:45PM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 01, 2020 at 11:26:15AM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 01, 2020 at 08:16:01PM +0200, Uladzislau Rezki wrote:
> > > > > > 
> > > > > > Right. Per discussion with Paul, we discussed that it is better if we
> > > > > > pre-allocate N number of array blocks per-CPU and use it for the cache.
> > > > > > Default for N being 1 and tunable with a boot parameter. I agree with this.
> > > > > > 
> > > > > As discussed before, we can make use of memory pool API for such
> > > > > purpose. But i am not sure if it should be one pool per CPU or
> > > > > one pool per NR_CPUS, that would contain NR_CPUS * N pre-allocated
> > > > > blocks.
> > > > 
> > > > There are advantages and disadvantages either way.  The advantage of the
> > > > per-CPU pool is that you don't have to worry about something like lock
> > > > contention causing even more pain during an OOM event.  One potential
> > > > problem wtih the per-CPU pool can happen when callbacks are offloaded,
> > > > in which case the CPUs needing the memory might never be getting it,
> > > > because in the offloaded case (RCU_NOCB_CPU=y) the CPU posting callbacks
> > > > might never be invoking them.
> > > > 
> > > > But from what I know now, systems built with CONFIG_RCU_NOCB_CPU=y
> > > > either don't have heavy callback loads (HPC systems) or are carefully
> > > > configured (real-time systems).  Plus large systems would probably end
> > > > up needing something pretty close to a slab allocator to keep from dying
> > > > from lock contention, and it is hard to justify that level of complexity
> > > > at this point.
> > > > 
> > > > Or is there some way to mark a specific slab allocator instance as being
> > > > able to keep some amount of memory no matter what the OOM conditions are?
> > > > If not, the current per-CPU pre-allocated cache is a better choice in the
> > > > near term.
> > > > 
> > > As for mempool API:
> > > 
> > > mempool_alloc() just tries to make regular allocation taking into
> > > account passed gfp_t bitmask. If it fails due to memory pressure,
> > > it uses reserved preallocated pool that consists of number of
> > > desirable elements(preallocated when a pool is created).
> > > 
> > > mempoll_free() returns an element to to pool, if it detects that
> > > current reserved elements are lower then minimum allowed elements,
> > > it will add an element to reserved pool, i.e. refill it. Otherwise
> > > just call kfree() or whatever we define as "element-freeing function."
> > 
> > Unless I am missing something, mempool_alloc() acquires a per-mempool
> > lock on each invocation under OOM conditions.  For our purposes, this
> > is essentially a global lock.  This will not be at all acceptable on a
> > large system.
> > 
> It uses pool->lock to access to reserved objects, so if we have one memory
> pool per one CPU then it would be serialized.

I am having difficulty parsing your sentence.  It looks like your thought
is to invoke mempool_create() for each CPU, so that the locking would be
on a per-CPU basis, as in 128 invocations of mempool_init() on a system
having 128 hardware threads.  Is that your intent?

							Thanx, Paul
