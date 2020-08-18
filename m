Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9831BC433E1
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CD25206B5
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 15:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHRPCg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:02:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgHRPCf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 11:02:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89C94AFC1;
        Tue, 18 Aug 2020 15:02:59 +0000 (UTC)
Date:   Tue, 18 Aug 2020 17:02:32 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200818150232.GQ28270@dhcp22.suse.cz>
References: <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
 <20200817222803.GE23602@paulmck-ThinkPad-P72>
 <20200818074344.GL28270@dhcp22.suse.cz>
 <20200818135327.GF23602@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818135327.GF23602@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue 18-08-20 06:53:27, Paul E. McKenney wrote:
> On Tue, Aug 18, 2020 at 09:43:44AM +0200, Michal Hocko wrote:
> > On Mon 17-08-20 15:28:03, Paul E. McKenney wrote:
> > > On Mon, Aug 17, 2020 at 10:28:49AM +0200, Michal Hocko wrote:
> > > > On Mon 17-08-20 00:56:55, Uladzislau Rezki wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png
> > > > 
> > > > 1/8 of the memory in pcp lists is quite large and likely not something
> > > > used very often.
> > > > 
> > > > Both these numbers just make me think that a dedicated pool of page
> > > > pre-allocated for RCU specifically might be a better solution. I still
> > > > haven't read through that branch of the email thread though so there
> > > > might be some pretty convincing argments to not do that.
> > > 
> > > To avoid the problematic corner cases, we would need way more dedicated
> > > memory than is reasonable, as in well over one hundred pages per CPU.
> > > Sure, we could choose a smaller number, but then we are failing to defend
> > > against flooding, even on systems that have more than enough free memory
> > > to be able to do so.  It would be better to live within what is available,
> > > taking the performance/robustness hit only if there isn't enough.
> > 
> > Thomas had a good point that it doesn't really make much sense to
> > optimize for flooders because that just makes them more effective.
> 
> The point is not to make the flooders go faster, but rather for the
> system to be robust in the face of flooders.  Robust as in harder for
> a flooder to OOM the system.

Do we see this to be a practical problem? I am really confused because
the initial argument was revolving around an optimization now you are
suggesting that this is actually system stability measure. And I fail to
see how allowing an easy way to deplete pcp caches completely solves
any of that. Please do realize that if allow that then every user who
relies on pcp caches will have to take a slow(er) path and that will
have performance consequences. The pool is a global and a scarce
resource. That's why I've suggested a dedicated preallocated pool and
use it instead of draining global pcp caches.

> And reducing the number of post-grace-period cache misses makes it
> easier for the callback-invocation-time memory freeing to keep up with
> the flooder, thus avoiding (or at least delaying) the OOM.
> 
> > > My current belief is that we need a combination of (1) either the
> > > GFP_NOLOCK flag or Peter Zijlstra's patch and
> > 
> > I must have missed the patch?
> 
> If I am keeping track, this one:
> 
> https://lore.kernel.org/lkml/20200814215206.GL3982@worktop.programming.kicks-ass.net/

OK, I have certainly noticed that one but didn't react but my response
would be similar to the dedicated gfp flag. This is less of a hack than
__GFP_NOLOCK  but it still exposes very internal parts of the allocator
and I find that a quite problematic from the future maintenance of the
allocator. The risk of an easy depletion of the pcp pool is also there
of course.
-- 
Michal Hocko
SUSE Labs
