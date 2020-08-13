Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F90CC433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8948920675
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMQgU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:36:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMQgT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 12:36:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53E3DAD78;
        Thu, 13 Aug 2020 16:36:40 +0000 (UTC)
Date:   Thu, 13 Aug 2020 18:36:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200813163617.GS9477@dhcp22.suse.cz>
References: <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <20200813154159.GR4295@paulmck-ThinkPad-P72>
 <20200813155412.GP9477@dhcp22.suse.cz>
 <20200813162047.GA27774@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813162047.GA27774@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 18:20:47, Uladzislau Rezki wrote:
> > On Thu 13-08-20 08:41:59, Paul E. McKenney wrote:
> > > On Thu, Aug 13, 2020 at 04:53:35PM +0200, Michal Hocko wrote:
> > > > On Thu 13-08-20 16:34:57, Thomas Gleixner wrote:
> > > > > Michal Hocko <mhocko@suse.com> writes:
> > > > > > On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
> > > > > >> It basically requires to convert the wait queue to something else. Is
> > > > > >> the waitqueue strict single waiter?
> > > > > >
> > > > > > I would have to double check. From what I remember only kswapd should
> > > > > > ever sleep on it.
> > > > > 
> > > > > That would make it trivial as we could simply switch it over to rcu_wait.
> > > > > 
> > > > > >> So that should be:
> > > > > >> 
> > > > > >> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
> > > > > >> 
> > > > > >> which is limiting the damage to those callers which hand in
> > > > > >> GFP_RT_NOWAIT.
> > > > > >> 
> > > > > >> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
> > > > > >> zone->lock in the wrong context. And we want to know about that so we
> > > > > >> can look at the caller and figure out how to solve it.
> > > > > >
> > > > > > Yes, that would have to somehow need to annotate the zone_lock to be ok
> > > > > > in those paths so that lockdep doesn't complain.
> > > > > 
> > > > > That opens the worst of all cans of worms. If we start this here then
> > > > > Joe programmer and his dog will use these lockdep annotation to evade
> > > > > warnings and when exposed to RT it will fall apart in pieces. Just that
> > > > > at that point Joe programmer moved on to something else and the usual
> > > > > suspects can mop up the pieces. We've seen that all over the place and
> > > > > some people even disable lockdep temporarily because annotations don't
> > > > > help.
> > > > 
> > > > Hmm. I am likely missing something really important here. We have two
> > > > problems at hand:
> > > > 1) RT will become broken as soon as this new RCU functionality which
> > > > requires an allocation from inside of raw_spinlock hits the RT tree
> > > > 2) lockdep splats which are telling us that early because of the
> > > > raw_spinlock-> spin_lock dependency.
> > > 
> > > That is a reasonable high-level summary.
> > > 
> > > > 1) can be handled by handled by the bailing out whenever we have to use
> > > > zone->lock inside the buddy allocator - essentially even more strict
> > > > NOWAIT semantic than we have for RT tree - proposed (pseudo) patch is
> > > > trying to describe that.
> > > 
> > > Unless I am missing something subtle, the problem with this approach
> > > is that in production-environment CONFIG_PREEMPT_NONE=y kernels, there
> > > is no way at runtime to distinguish between holding a spinlock on the
> > > one hand and holding a raw spinlock on the other.  Therefore, without
> > > some sort of indication from the caller, this approach will not make
> > > CONFIG_PREEMPT_NONE=y users happy.
> > 
> > If the whole bailout is guarded by CONFIG_PREEMPT_RT specific atomicity
> > check then there is no functional problem - GFP_RT_SAFE would still be
> > GFP_NOWAIT so functional wise the allocator will still do the right
> > thing.
> > 
> > [...]
> > 
> > > > That would require changing NOWAIT/ATOMIC allocations semantic quite
> > > > drastically for !RT kernels as well. I am not sure this is something we
> > > > can do. Or maybe I am just missing your point.
> > > 
> > > Exactly, and avoiding changing this semantic for current users is
> > > precisely why we are proposing some sort of indication to be passed
> > > into the allocation request.  In Uladzislau's patch, this was the
> > > __GFP_NO_LOCKS flag, but whatever works.
> > 
> > As I've tried to explain already, I would really hope we can do without
> > any new gfp flags. We are running out of them and they tend to generate
> > a lot of maintenance burden. There is a lot of abuse etc. We should also
> > not expose such an implementation detail of the allocator to callers
> > because that would make future changes even harder. The alias, on the
> > othere hand already builds on top of existing NOWAIT semantic and it
> > just helps the allocator to complain about a wrong usage while it
> > doesn't expose any internals.
> > 
> I know that Matthew and me raised it. We do can handle it without
> introducing any flag. I mean just use 0 as argument to the page_alloc(gfp_flags = 0) 
> 
> i.e. #define __GFP_NO_LOCKS 0
> 
> so it will be handled same way how it is done in the "mm: Add __GFP_NO_LOCKS flag"
> I can re-spin the RFC patch and send it out for better understanding.
> 
> Does it work for you, Michal? Or it is better just to drop the patch here?

That would change the semantic for GFP_NOWAIT users who decided to drop
__GFP_KSWAPD_RECLAIM or even use 0 gfp mask right away, right? The point
I am trying to make is that an alias is good for RT because it doesn't
have any users (because there is no RT atomic user of the allocator)
currently.

-- 
Michal Hocko
SUSE Labs
