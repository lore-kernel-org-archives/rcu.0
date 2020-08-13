Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4109C433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 14:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D901120781
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 14:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHMOxi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:53:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMOxi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 10:53:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2537CAE1A;
        Thu, 13 Aug 2020 14:53:58 +0000 (UTC)
Date:   Thu, 13 Aug 2020 16:53:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
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
Message-ID: <20200813145335.GN9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgcqty0e.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 16:34:57, Thomas Gleixner wrote:
> Michal Hocko <mhocko@suse.com> writes:
> > On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
> >> It basically requires to convert the wait queue to something else. Is
> >> the waitqueue strict single waiter?
> >
> > I would have to double check. From what I remember only kswapd should
> > ever sleep on it.
> 
> That would make it trivial as we could simply switch it over to rcu_wait.
> 
> >> So that should be:
> >> 
> >> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
> >> 
> >> which is limiting the damage to those callers which hand in
> >> GFP_RT_NOWAIT.
> >> 
> >> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
> >> zone->lock in the wrong context. And we want to know about that so we
> >> can look at the caller and figure out how to solve it.
> >
> > Yes, that would have to somehow need to annotate the zone_lock to be ok
> > in those paths so that lockdep doesn't complain.
> 
> That opens the worst of all cans of worms. If we start this here then
> Joe programmer and his dog will use these lockdep annotation to evade
> warnings and when exposed to RT it will fall apart in pieces. Just that
> at that point Joe programmer moved on to something else and the usual
> suspects can mop up the pieces. We've seen that all over the place and
> some people even disable lockdep temporarily because annotations don't
> help.

Hmm. I am likely missing something really important here. We have two
problems at hand:
1) RT will become broken as soon as this new RCU functionality which
requires an allocation from inside of raw_spinlock hits the RT tree
2) lockdep splats which are telling us that early because of the
raw_spinlock-> spin_lock dependency.

1) can be handled by handled by the bailing out whenever we have to use
zone->lock inside the buddy allocator - essentially even more strict
NOWAIT semantic than we have for RT tree - proposed (pseudo) patch is
trying to describe that.

2) would become a false positive if 1) is in place, right? RT wouldn't
do the illegal nesting and !RT would just work fine because
GFP_RT_NOWAIT would be simply GFP_NOWAIT & ~__GFP_KSWAPD_RECLAIM.
Why should we limit the functionality of the allocator for something
that is not a real problem?

> PeterZ might have opinions about that too I suspect.
> 
> Really, if your primary lockless caches are empty then any allocation
> which comes from deep atomic context should simply always fail. Being
> stuck in an interrupt handler or even deeper for 200+ microseconds
> waiting for zone lock is just bonkers IMO.

That would require changing NOWAIT/ATOMIC allocations semantic quite
drastically for !RT kernels as well. I am not sure this is something we
can do. Or maybe I am just missing your point.
-- 
Michal Hocko
SUSE Labs
