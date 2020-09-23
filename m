Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3CC2D0A8
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4E23119
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600875667;
	bh=TqnyVOKgJO3qR5BiBUnxEC26dgQBbHKNTuhqSQ76W40=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xvLRb1BQ78xnhmH3R5NVdNuNByb3hzDY3xLERocNyzTYSolvRw5vXHaxWiVzmHykB
	 bNbhzW/0tsyszj84/u6uRlFQYHzs3lILQcmJU/1qwNem9TCdpKIyBOXdxu0R22O6eC
	 EB6gFzfYwqokpVMRGVaStEctLC047Kg+SGu6FOW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIWPlH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWPlG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 11:41:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E55B32223E;
        Wed, 23 Sep 2020 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600875665;
        bh=TqnyVOKgJO3qR5BiBUnxEC26dgQBbHKNTuhqSQ76W40=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vNQl9Fbj/5OxzShwt7YWR5QD66fNWSQaUtt7mh+pHa6P8HEgTPnYiLZJtUlS14C8W
         jAYt478V4BW6A+/VDaFESXJ3yM7zlJ0+2Cg6RA4BA10H0npwGYDQh4LPq8ddwQLSSW
         5QyNiarGz1ZuzqmvSEKu65J4YxMeSJKv1VUg12ic=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AE69235226CB; Wed, 23 Sep 2020 08:41:05 -0700 (PDT)
Date:   Wed, 23 Sep 2020 08:41:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
Message-ID: <20200923154105.GO29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923103706.GJ3179@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 23, 2020 at 11:37:06AM +0100, Mel Gorman wrote:
> On Tue, Sep 22, 2020 at 03:12:57PM +0200, Uladzislau Rezki wrote:
> > > > > > Yes, I do well remember that you are unhappy with this approach.
> > > > > > Unfortunately, thus far, there is no solution that makes all developers
> > > > > > happy.  You might be glad to hear that we are also looking into other
> > > > > > solutions, each of which makes some other developers unhappy.  So we
> > > > > > are at least not picking on you alone.  :-/
> > > > > 
> > > > > No worries I do not feel like a whipping boy here. But do expect me to
> > > > > argue against the approach. I would also appreciate it if there was some
> > > > > more information on other attempts, why they have failed. E.g. why
> > > > > pre-allocation is not an option that works well enough in most
> > > > > reasonable workloads.
> > > > Pre-allocating has some drawbacks:
> > > > 
> > > > a) It is impossible to predict how many pages will be required to
> > > >    cover a demand that is controlled by different workloads on
> > > >    various systems.
> > > 
> > > Yes, this is not trivial but not a rocket science either. Remember that
> > > you are relying on a very dumb watermark based pcp pool from the
> > > allocator.
> > >
> > We rely on it, indeed. If the pcp-cache is depleted our special work is
> > triggered to charge our local cache(few pages) such way will also initiate
> > the process of pre-featching pages from the buddy allocator populating
> > the depleted pcp-cache. I do not have any concern here.
> 
> It can interfere with ATOMIC allocations in critical paths in extreme
> circumstances as it potentially puts increased pressure on the emergency
> reserve as watermarks are bypassed. That adds to the risk of a functional
> failuure if reclaim fails to make progress.  The number of pages are likely
> to be limited and unpredictable. As it uses any PCP type, it potentially
> causes fragmention issues. For the last point, the allocations may be
> transient in the RCU case now but not guaranteed forever. As the API is
> in gfp.h, it's open to abuse so the next guy that comes along and thinks
> "I am critical no matter what the name says" will cause problems. While
> you could argue that would be caught in review, plenty of GFP flag abuses
> made it through review.
> 
> Fundamentally, this is simply shifting the problem from RCU to the page
> allocator because of the locking arrangements and hazard of acquiring zone
> lock is a raw spinlock is held on RT. It does not even make the timing
> predictable as an empty PCU list (for example, a full drain in low memory
> situations) may mean the emergency path is hit anyway. About all it changes
> is the timing of when the emergency path is hit in some circumstances --
> it's not fixing the problem, it's simply changing the shape.

All good points!

On the other hand, duplicating a portion of the allocator functionality
within RCU increases the amount of reserved memory, and needlessly most
of the time.

Is there some way that we can locklessly allocate memory, but return
failure instead of running down the emergency pool?  A change to the loop
that iterates over the migration types?  Or to the loop that iterates
over the zones?  Something else?

> > > Mimicing a similar implementation shouldn't be all that hard
> > > and you will get your own pool which doesn't affect other page allocator
> > > users as much as a bonus.
> > > 
> > I see your point Michal. As i mentioned before, it is important to avoid of
> > having such own pools, because the aim is not to waste memory resources. A
> > page will be returned back to "page allocator" as soon as a scheduler place  
> > our reclaim thread on a CPU and grace period is passed. So, the resource
> > can be used for other needs. What is important.
> 
> As the emergency path and synchronising can be hit no matter what, why
> not increase the pool temporarily after the emergency path is hit and
> shrink it again later if necessary?

If I understand what you are suggesting, this is in fact what Uladzislau's
prototyped commit 8c0a1269709d ("rcu/tree: Add a work to allocate
pages from regular context") on the -rcu "dev" branch is intended to do.
The issue, as Uladislau noted above, is that scheduler delays can prevent
these pool-increase actions until the point at which there is no memory.

> > Otherwise a memory footprint is increased what is bad for low memory
> > conditions when OOM is involved.
> 
> OOM would only be a major factor if the size of the pools meant the
> machine could not even operate or at least was severely degraded. However,
> depleting the PCPU lists for RCU may slow kswapd making reclaim progress
> and cause an OOM in itself, or at least an intervention by a userspace
> monitor that kills non-critical applications in the background when memory
> pressure exists.

When under emergency conditions, we have one page allocated per 500
objects passed to kvfree_rcu().  So the increase in total allocated
memory load due to this emergency path is quite small.

> > > > As for memory overhead, it is important to reduce it because of
> > > > embedded devices like phones, where a low memory condition is a
> > > > big issue. In that sense pre-allocating is something that we strongly
> > > > would like to avoid.
> > > 
> > > How big "machines" are we talking about here? I would expect that really
> > > tiny machines would have hard times to really fill up thousands of pages
> > > with pointers to free...
> > > 
> > I mentioned above. We can not rely on static model. We would like to
> > have a mechanism that gives back ASAP used pages to page allocator
> > for other needs.
> 
> After an emergency, temporarily increase the size of the pool to avoid
> hitting the emergency path again in the near future.

By which time we might well already be in OOM territory.  The emergency
situations can ramp up very quickly.

> > > Would a similar scaling as the page allocator feasible. Really I mostly
> > > do care about shared nature of the pcp allocator list that one user can
> > > easily monopolize with this API.
> > > 
> > I see your concern. pcplist can be monopolized by already existing API:
> > 
> >     while (i < 100)
> >         __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> 
> That's not the same class of abuse as it can go to the buddy lists to
> refill the correct PCP lists, avoid fragmentation issues, obeys watermarks
> and wakes kswapd if it's not awake already.

Good point, and we did try doing it this way.  Unfortunately, in current
!PREEMPT kernels, this approach can deadlock on one of the allocator
locks via call_rcu().  This experience caused us to look at lockless
allocator access.  It also inspired the unconditional PREEMPT_COUNT
approach, but that has its own detractors.  (Yes, we are of course still
persuing it as well.)

							Thanx, Paul
