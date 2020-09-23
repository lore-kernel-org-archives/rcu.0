Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F07C4363D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A522620888
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 23:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWXcq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 19:32:46 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:56359 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgIWXck (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 23 Sep 2020 19:32:40 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 19:32:38 EDT
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id A2BD5FAA31
        for <rcu@vger.kernel.org>; Thu, 24 Sep 2020 00:22:54 +0100 (IST)
Received: (qmail 15211 invoked from network); 23 Sep 2020 23:22:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Sep 2020 23:22:54 -0000
Date:   Thu, 24 Sep 2020 00:22:51 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200923232251.GK3179@techsingularity.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <20200921074716.GC12990@dhcp22.suse.cz>
 <20200921154558.GD29330@paulmck-ThinkPad-P72>
 <20200921160318.GO12990@dhcp22.suse.cz>
 <20200921194819.GA24236@pc636>
 <20200922075002.GU12990@dhcp22.suse.cz>
 <20200922131257.GA29241@pc636>
 <20200923103706.GJ3179@techsingularity.net>
 <20200923154105.GO29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200923154105.GO29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 23, 2020 at 08:41:05AM -0700, Paul E. McKenney wrote:
> > Fundamentally, this is simply shifting the problem from RCU to the page
> > allocator because of the locking arrangements and hazard of acquiring zone
> > lock is a raw spinlock is held on RT. It does not even make the timing
> > predictable as an empty PCU list (for example, a full drain in low memory
> > situations) may mean the emergency path is hit anyway. About all it changes
> > is the timing of when the emergency path is hit in some circumstances --
> > it's not fixing the problem, it's simply changing the shape.
> 
> All good points!
> 
> On the other hand, duplicating a portion of the allocator functionality
> within RCU increases the amount of reserved memory, and needlessly most
> of the time.
> 

But it's very similar to what mempools are for.

> Is there some way that we can locklessly allocate memory, but return
> failure instead of running down the emergency pool? A change to the loop
> that iterates over the migration types?  Or to the loop that iterates
> over the zones?  Something else?
> 

Only by duplicating some of the logic in get_page_from_freelist would
protect the reserves. Even if you had that, the contents of the pcp
pools can easily be zero for the local CPU and you still get stuck.

> > > > Mimicing a similar implementation shouldn't be all that hard
> > > > and you will get your own pool which doesn't affect other page allocator
> > > > users as much as a bonus.
> > > > 
> > > I see your point Michal. As i mentioned before, it is important to avoid of
> > > having such own pools, because the aim is not to waste memory resources. A
> > > page will be returned back to "page allocator" as soon as a scheduler place  
> > > our reclaim thread on a CPU and grace period is passed. So, the resource
> > > can be used for other needs. What is important.
> > 
> > As the emergency path and synchronising can be hit no matter what, why
> > not increase the pool temporarily after the emergency path is hit and
> > shrink it again later if necessary?
> 
> If I understand what you are suggesting, this is in fact what Uladzislau's
> prototyped commit 8c0a1269709d ("rcu/tree: Add a work to allocate
> pages from regular context") on the -rcu "dev" branch is intended to do.
> The issue, as Uladislau noted above, is that scheduler delays can prevent
> these pool-increase actions until the point at which there is no memory.
> 

Scheduler latency would be a problem. You would have to keep an emergency
"rescue" pool that is enough to make slow progress even if no other memory
is available until the worker takes action. The worker that allocates
pages from regular context would be to increase the pool size enough so
the emergency reserve does not have to be used again in the near future.

> > > Otherwise a memory footprint is increased what is bad for low memory
> > > conditions when OOM is involved.
> > 
> > OOM would only be a major factor if the size of the pools meant the
> > machine could not even operate or at least was severely degraded. However,
> > depleting the PCPU lists for RCU may slow kswapd making reclaim progress
> > and cause an OOM in itself, or at least an intervention by a userspace
> > monitor that kills non-critical applications in the background when memory
> > pressure exists.
> 
> When under emergency conditions, we have one page allocated per 500
> objects passed to kvfree_rcu().  So the increase in total allocated
> memory load due to this emergency path is quite small.
> 

Fair enough but any solution that depends on the PCP having even one
page available is going to need a fallback option of some sort.

> > > > > As for memory overhead, it is important to reduce it because of
> > > > > embedded devices like phones, where a low memory condition is a
> > > > > big issue. In that sense pre-allocating is something that we strongly
> > > > > would like to avoid.
> > > > 
> > > > How big "machines" are we talking about here? I would expect that really
> > > > tiny machines would have hard times to really fill up thousands of pages
> > > > with pointers to free...
> > > > 
> > > I mentioned above. We can not rely on static model. We would like to
> > > have a mechanism that gives back ASAP used pages to page allocator
> > > for other needs.
> > 
> > After an emergency, temporarily increase the size of the pool to avoid
> > hitting the emergency path again in the near future.
> 
> By which time we might well already be in OOM territory.  The emergency
> situations can ramp up very quickly.
> 

And if the pcp lists are empty, this problem still exists -- pretty much
anything that depends on the pcp lists always having pages is going to
have a failure case.

> > > > Would a similar scaling as the page allocator feasible. Really I mostly
> > > > do care about shared nature of the pcp allocator list that one user can
> > > > easily monopolize with this API.
> > > > 
> > > I see your concern. pcplist can be monopolized by already existing API:
> > > 
> > >     while (i < 100)
> > >         __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> > 
> > That's not the same class of abuse as it can go to the buddy lists to
> > refill the correct PCP lists, avoid fragmentation issues, obeys watermarks
> > and wakes kswapd if it's not awake already.
> 
> Good point, and we did try doing it this way.  Unfortunately, in current
> !PREEMPT kernels, this approach can deadlock on one of the allocator
> locks via call_rcu().  This experience caused us to look at lockless
> allocator access.  It also inspired the unconditional PREEMPT_COUNT
> approach, but that has its own detractors.  (Yes, we are of course still
> persuing it as well.)
> 

I didn't keep up to date unfortunately but pretty much anything that
needs guaranteed access to pages has to maintain a mempool of some sort.
Even if the page allocator had a common pool for emergency use, it would
be subject to abuse because all it would take is one driver or subsystem
deciding that it was special enough to deplete it. For example, the ml4
driver decided that it should declare itself to be a "memory allocator"
like kswapd for iSCSI (it claims swap-over-nfs, but swap-over-nfs was
only meant to apply when a swapfile was backed by a network fs).

-- 
Mel Gorman
SUSE Labs
