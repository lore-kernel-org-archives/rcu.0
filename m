Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB53C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 07:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186EB20639
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 07:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgHNHRx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:17:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgHNHRx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 03:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 565B5AC7F;
        Fri, 14 Aug 2020 07:18:14 +0000 (UTC)
Date:   Fri, 14 Aug 2020 09:17:50 +0200
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
Message-ID: <20200814071750.GZ9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813145335.GN9477@dhcp22.suse.cz>
 <87lfiitquu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfiitquu.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 19:09:29, Thomas Gleixner wrote:
> Michal Hocko <mhocko@suse.com> writes:
[...]
> > Why should we limit the functionality of the allocator for something
> > that is not a real problem?
> 
> We'd limit the allocator for exactly ONE new user which was aware of
> this problem _before_ the code hit mainline. And that ONE user is
> prepared to handle the fail.

If we are to limit the functionality to this one particular user then
I would consider a dedicated gfp flag a huge overkill. It would be much
more easier to have a preallocated pool of pages and use those and
completely avoid the core allocator. That would certainly only shift the
complexity to the caller but if it is expected there would be only that
single user then it would be probably better than opening a can of worms
like allocator usable from raw spin locks.

Paul would something like that be feasible?

Really we have been bitten by a single usecase gfp flags in the past.

[...]
> Even if we could make this lockdep thing work that does not mean that
> it's a good thing to do.
> 
> Quite the contrary, you'd just encourage people to create more of those
> use cases for probably the completely wrong reasons. Putting a
> limitation into place upfront might makes them think farther than just
> slapping GFP_RT_ATOMIC in and be done with it. Let me dream :)

Good one ;) But seriously. I was suggesting lockdep workaround because
I reckon that is less prone to an abuse than gfp flags. Lockdep is that
scary thing people do not want to touch by a long pole but gfp flags
are something you have to deal with when calling allocator and people
tend to be creative. We used to suck in documentation so I am not
wondering but things have improved so maybe the usage is going to
improve as well. Anyway __GFP_NO_LOCK would be a free ticket to "I want
to optimize even further" land. Maybe a better naming would be better
but I am skeptical.

> I've dealt with tons of patches in the last 15+ years where people just
> came up with 's/GFP_KERNEL/GFP_ATOMIC/ because tool complained'
> patches. The vast majority of them were bogus because the alloc() was
> simply at the wrong place.

Completely agreed.
 
> Forcing people not to take the easy way out by making the infrastructure
> restrictive is way better than encouraging mindless hackery. We have
> enough of this (not restricted to memory allocations) all over the
> kernel already. No need for more.

I do agree with you. I just slightly disagree where the danger is.
Explicit lockdep usage outside of the core is spread much less than the
allocator so the abuse is less likely.
-- 
Michal Hocko
SUSE Labs
