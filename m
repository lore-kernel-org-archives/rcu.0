Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB88C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBDD2078D
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597428103;
	bh=tlSBhpa4ToPHr0zR2hPhfIijVZq2J3X4X8TvGLSLkgU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=PRJZSjQAS/TsHWzl4e9Z7yQSG111kGuttX+JFv/nhMX49fb6qStoTQKYHgG0IZgx6
	 ywZHOrTArFhT7A5yBVl3rFo/kNli/FQ3ZEL6Fti0EIbYd5jMe3gMYIVwWgE3JT9Ft7
	 7YhIleLgrls24eqSoJp4AeebaZIc5p4sh+aRV3Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHNSBn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgHNSBm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 14:01:42 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5889220771;
        Fri, 14 Aug 2020 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597428101;
        bh=tlSBhpa4ToPHr0zR2hPhfIijVZq2J3X4X8TvGLSLkgU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U9vNT1mSKZy7w26/Fkt1gMXQdcR78Clo1DaaDjTx23XBJP544U/oZs0qT0S0/OczB
         eANl7ItRov1iQjT496z3+SF0LsTUlx0R5Zke9QLWzXvTfb4+J05zob5gC+DzYaZfFI
         j1YupVg3WG/EErHmAjFzlongRtzP3F+F1yePIsDQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0FC073522A0E; Fri, 14 Aug 2020 11:01:41 -0700 (PDT)
Date:   Fri, 14 Aug 2020 11:01:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814180141.GP4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
 <20200814071750.GZ9477@dhcp22.suse.cz>
 <20200814121544.GA32598@pc636>
 <20200814124832.GD9477@dhcp22.suse.cz>
 <20200814133450.GK4295@paulmck-ThinkPad-P72>
 <20200814140604.GE9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814140604.GE9477@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 04:06:04PM +0200, Michal Hocko wrote:
> On Fri 14-08-20 06:34:50, Paul E. McKenney wrote:
> > On Fri, Aug 14, 2020 at 02:48:32PM +0200, Michal Hocko wrote:
> > > On Fri 14-08-20 14:15:44, Uladzislau Rezki wrote:
> > > > > On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> > > > > > Michal Hocko <mhocko@suse.com> writes:
> > > > > [...]
> > > > > > > Why should we limit the functionality of the allocator for something
> > > > > > > that is not a real problem?
> > > > > > 
> > > > > > We'd limit the allocator for exactly ONE new user which was aware of
> > > > > > this problem _before_ the code hit mainline. And that ONE user is
> > > > > > prepared to handle the fail.
> > > > > 
> > > > > If we are to limit the functionality to this one particular user then
> > > > > I would consider a dedicated gfp flag a huge overkill. It would be much
> > > > > more easier to have a preallocated pool of pages and use those and
> > > > > completely avoid the core allocator. That would certainly only shift the
> > > > > complexity to the caller but if it is expected there would be only that
> > > > > single user then it would be probably better than opening a can of worms
> > > > > like allocator usable from raw spin locks.
> > > > > 
> > > > Vlastimil raised same question earlier, i answered, but let me answer again:
> > > > 
> > > > It is hard to achieve because the logic does not stick to certain static test
> > > > case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
> > > > on that, "how heavily" - number of pages are formed, until the drain/reclaimer
> > > > thread frees them.
> > > 
> > > How many pages are talking about - ball park? 100s, 1000s?
> > 
> > Under normal operation, a couple of pages per CPU, which would make
> > preallocation entirely reasonable.  Except that if someone does something
> > that floods RCU callbacks (close(open) in a tight userspace loop, for but
> > one example), then 2000 per CPU might not be enough, which on a 64-CPU
> > system comes to about 500MB.  This is beyond excessive for preallocation
> > on the systems I am familiar with.
> > 
> > And the flooding case is where you most want the reclamation to be
> > efficient, and thus where you want the pages.
> 
> I am not sure the page allocator would help you with this scenario
> unless you are on very large machines. Pagesets scale with the available
> memory and percpu_pagelist_fraction sysctl (have a look at
> pageset_set_high_and_batch). It is roughly 1000th of the zone size for
> each zone. You can check that in /proc/vmstat (my 8G machine)

Small systems might have ~64G.  The medium-sized systems might have
~250G.  There are a few big ones that might have 1.5T.  None of the
/proc/vmstat files from those machines contain anything resembling
the list below, though.

> Node 0, zone      DMA
> Not interesting at all
> Node 0, zone    DMA32
>   pagesets
>     cpu: 0
>               count: 242
>               high:  378
>               batch: 63
>     cpu: 1
>               count: 355
>               high:  378
>               batch: 63
>     cpu: 2
>               count: 359
>               high:  378
>               batch: 63
>     cpu: 3
>               count: 366
>               high:  378
>               batch: 63
> Node 0, zone   Normal
>   pagesets
>     cpu: 0
>               count: 359
>               high:  378
>               batch: 63
>     cpu: 1
>               count: 241
>               high:  378
>               batch: 63
>     cpu: 2
>               count: 297
>               high:  378
>               batch: 63
>     cpu: 3
>               count: 227
>               high:  378
>               batch: 63
> 
> Besides that do you need to be per-cpu? Having 1000 pages available and
> managed under your raw spinlock should be good enough already no?

It needs to be almost entirely per-CPU for performance reasons.  Plus
a user could do a tight close(open()) loop on each CPU.

> > This of course raises the question of how much memory the lockless caches
> > contain, but fortunately these RCU callback flooding scenarios also
> > involve process-context allocation of the memory that is being passed
> > to kfree_rcu().  That allocation should keep the lockless caches from
> > going empty in the common case, correct?
> 
> Yes, those are refilled both on the allocation/free paths. But you
> cannot really rely on that to happen early enough.

So the really ugly scenarios with the tight loops normally allocate
something and immediately either call_rcu() or kfree_rcu() it.
But you are right, someone doing "rm -rf" on a large file tree
with lots of small files might not be doing that many allocations.

> Do you happen to have any numbers that would show the typical usage
> and how often the slow path has to be taken becase pcp lists are
> depleted? In other words even if we provide a functionality to give
> completely lockless way to allocate memory how useful that is?

Not yet, but let's see what we can do.

							Thanx, Paul
