Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CEFC433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 10:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60A920782
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 10:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgHKK0x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:26:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:55640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728390AbgHKK0x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 06:26:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A463ACDB;
        Tue, 11 Aug 2020 10:27:11 +0000 (UTC)
Date:   Tue, 11 Aug 2020 12:26:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811102649.GI4793@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
 <20200811081917.GG4793@dhcp22.suse.cz>
 <20200811093713.GB2634@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811093713.GB2634@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 11-08-20 11:37:13, Uladzislau Rezki wrote:
> On Tue, Aug 11, 2020 at 10:19:17AM +0200, Michal Hocko wrote:
> > On Mon 10-08-20 21:25:26, Michal Hocko wrote:
> > > On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
> > [...]
> > > > The problem that i see is we can not use the page allocator from atomic
> > > > contexts, what is our case:
> > > > 
> > > > <snip>
> > > >     local_irq_save(flags) or preempt_disable() or raw_spinlock();
> > > >     __get_free_page(GFP_ATOMIC);
> > > > <snip>
> > > > 
> > > > So if we can convert the page allocator to raw_* lock it will be appreciated,
> > > > at least from our side, IMHO, not from RT one. But as i stated above we need
> > > > to sort raised questions out if converting is done.
> > > > 
> > > > What is your view?
> > > 
> > > To me it would make more sense to support atomic allocations also for
> > > the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> > > work for atomic context in RT sounds subtle and wrong.
> > 
> > I was thinking about this some more. I still think the above would be a
> > reasonable goal we should try to achieve. If for not other then for
> > future maintainability (especially after the RT patchset is merged).
> > I have tried to search for any known problems/attempts to make
> > zone->lock raw but couldn't find anything. Maybe somebody more involved
> > in RT world have something to say about that.
> > 
> I tried yesterday to convert zone->lock. See below files i had to modify:
> <snip>
>         modified:   include/linux/mmzone.h
>         modified:   mm/compaction.c
>         modified:   mm/memory_hotplug.c
>         modified:   mm/page_alloc.c
>         modified:   mm/page_isolation.c
>         modified:   mm/page_reporting.c
>         modified:   mm/shuffle.c
>         modified:   mm/vmscan.c
>         modified:   mm/vmstat.c
> <snip>
> 
> There is one more lock, that is zone->lru_lock one. Both zone->lock and this
> one intersect between each other. If the lru_lock can be nested under zone->lock
> it should be converted as well. But i need to analyze it farther. There are
> two wrapper functions which are used as common interface to lock/unlock both
> locks. See compact_lock_irqsave()/compact_unlock_should_abort_lru() in the 
> mm/compaction.c.
> 
> Any thoughts here?

I am not an expert on compaction. Vlastimil would know better. My
thinking was that zone->lock is a tail lock but compaction/page
isolation might be doing something I am not aware of right now.

> Anyway i tried to convert only zone->lock and use page allocator passing there
> gfp_mask=0 as argument. So it works. CONFIG_PROVE_RAW_LOCK_NESTING does not
> complain about any "bad" lock nesting.
> 
> > Anyway, if the zone->lock is not a good fit for raw_spin_lock then the
> > only way I can see forward is to detect real (RT) atomic contexts and
> > bail out early before taking the lock in the allocator for NOWAIT/ATOMIC
> > requests.
> >
> For RT kernel we can detect it for sure. preemtable() works just fine there,
> i.e. we can identify the context we are currently in.

In previous email I didn't mention why I prefer full NOWAIT semantic
over rt specific bailouts. There are users making NOWAIT allocation
attempts as an opportunistic allocation request which is OK to fail
as they have a fallback to go through. This would imply they would
prefer to know this ASAP rather then get blocked and sleep. A lack of
reports for PREEMPT_RT would suggest that nobody has noticed as this
though.
-- 
Michal Hocko
SUSE Labs
