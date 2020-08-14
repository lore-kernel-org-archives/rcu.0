Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEF4C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 14:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1710420838
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 14:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgHNOGY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:06:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgHNOGI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 10:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F89EB1B9;
        Fri, 14 Aug 2020 14:06:29 +0000 (UTC)
Date:   Fri, 14 Aug 2020 16:06:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200814140604.GE9477@dhcp22.suse.cz>
References: <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
 <20200814071750.GZ9477@dhcp22.suse.cz>
 <20200814121544.GA32598@pc636>
 <20200814124832.GD9477@dhcp22.suse.cz>
 <20200814133450.GK4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814133450.GK4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri 14-08-20 06:34:50, Paul E. McKenney wrote:
> On Fri, Aug 14, 2020 at 02:48:32PM +0200, Michal Hocko wrote:
> > On Fri 14-08-20 14:15:44, Uladzislau Rezki wrote:
> > > > On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> > > > > Michal Hocko <mhocko@suse.com> writes:
> > > > [...]
> > > > > > Why should we limit the functionality of the allocator for something
> > > > > > that is not a real problem?
> > > > > 
> > > > > We'd limit the allocator for exactly ONE new user which was aware of
> > > > > this problem _before_ the code hit mainline. And that ONE user is
> > > > > prepared to handle the fail.
> > > > 
> > > > If we are to limit the functionality to this one particular user then
> > > > I would consider a dedicated gfp flag a huge overkill. It would be much
> > > > more easier to have a preallocated pool of pages and use those and
> > > > completely avoid the core allocator. That would certainly only shift the
> > > > complexity to the caller but if it is expected there would be only that
> > > > single user then it would be probably better than opening a can of worms
> > > > like allocator usable from raw spin locks.
> > > > 
> > > Vlastimil raised same question earlier, i answered, but let me answer again:
> > > 
> > > It is hard to achieve because the logic does not stick to certain static test
> > > case, i.e. it depends on how heavily kfree_rcu(single/double) are used. Based
> > > on that, "how heavily" - number of pages are formed, until the drain/reclaimer
> > > thread frees them.
> > 
> > How many pages are talking about - ball park? 100s, 1000s?
> 
> Under normal operation, a couple of pages per CPU, which would make
> preallocation entirely reasonable.  Except that if someone does something
> that floods RCU callbacks (close(open) in a tight userspace loop, for but
> one example), then 2000 per CPU might not be enough, which on a 64-CPU
> system comes to about 500MB.  This is beyond excessive for preallocation
> on the systems I am familiar with.
> 
> And the flooding case is where you most want the reclamation to be
> efficient, and thus where you want the pages.

I am not sure the page allocator would help you with this scenario
unless you are on very large machines. Pagesets scale with the available
memory and percpu_pagelist_fraction sysctl (have a look at
pageset_set_high_and_batch). It is roughly 1000th of the zone size for
each zone. You can check that in /proc/vmstat (my 8G machine)

Node 0, zone      DMA
Not interesting at all
Node 0, zone    DMA32
  pagesets
    cpu: 0
              count: 242
              high:  378
              batch: 63
    cpu: 1
              count: 355
              high:  378
              batch: 63
    cpu: 2
              count: 359
              high:  378
              batch: 63
    cpu: 3
              count: 366
              high:  378
              batch: 63
Node 0, zone   Normal
  pagesets
    cpu: 0
              count: 359
              high:  378
              batch: 63
    cpu: 1
              count: 241
              high:  378
              batch: 63
    cpu: 2
              count: 297
              high:  378
              batch: 63
    cpu: 3
              count: 227
              high:  378
              batch: 63

Besides that do you need to be per-cpu? Having 1000 pages available and
managed under your raw spinlock should be good enough already no?
 
> This of course raises the question of how much memory the lockless caches
> contain, but fortunately these RCU callback flooding scenarios also
> involve process-context allocation of the memory that is being passed
> to kfree_rcu().  That allocation should keep the lockless caches from
> going empty in the common case, correct?

Yes, those are refilled both on the allocation/free paths. But you
cannot really rely on that to happen early enough.

Do you happen to have any numbers that would show the typical usage
and how often the slow path has to be taken becase pcp lists are
depleted? In other words even if we provide a functionality to give
completely lockless way to allocate memory how useful that is?
-- 
Michal Hocko
SUSE Labs
