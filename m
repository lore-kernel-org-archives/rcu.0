Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC6C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8B72078D
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 13:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHMNdM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:33:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:51250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHMNdL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 09:33:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C000EAC48;
        Thu, 13 Aug 2020 13:33:31 +0000 (UTC)
Date:   Thu, 13 Aug 2020 15:33:08 +0200
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
Message-ID: <20200813133308.GK9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kp6llzb.fsf@nanos.tec.linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu 13-08-20 15:22:00, Thomas Gleixner wrote:
> Uladzislau Rezki <urezki@gmail.com> writes:
> > On Thu, Aug 13, 2020 at 09:50:27AM +0200, Michal Hocko wrote:
> >> On Wed 12-08-20 02:13:25, Thomas Gleixner wrote:
> >> [...]
> >> > I can understand your rationale and what you are trying to solve. So, if
> >> > we can actually have a distinct GFP variant:
> >> > 
> >> >   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
> >> 
> >> Even if we cannot make the zone->lock raw I would prefer to not
> >> introduce a new gfp flag. Well we can do an alias for easier grepping
> >> #define GFP_RT_SAFE	0
> 
> Just using 0 is sneaky but yes, that's fine :)
> 
> Bikeshedding: GFP_RT_NOWAIT or such might be more obvious.

Sounds goood.

> >> that would imply nowait semantic and would exclude waking up kswapd as
> >> well. If we can make wake up safe under RT then the alias would reflect
> >> that without any code changes.
> 
> It basically requires to convert the wait queue to something else. Is
> the waitqueue strict single waiter?

I would have to double check. From what I remember only kswapd should
ever sleep on it.

> >> The second, and the more important part, would be to bail out anytime
> >> the page allocator is to take a lock which is not allowed in the current
> >> RT context. Something like
> 
> >> +	/*
> >> +	 * Hard atomic contexts are not supported by the allocator for
> >> +	 * anything but pcp requests
> >> +	 */
> >> +	if (!preemtable())
> 
> If you make that preemtible() it might even compile, but that still wont
> work because if CONFIG_PREEMPT_COUNT=n then preemptible() is always
> false.

It would be nice to hide all that behind a helper and guarded by
PREEMPT_RT. That would imply PREEMPT_COUNT automatically, right?

> 
> So that should be:
> 
> 	if (!preemptible() && gfp == GFP_RT_NOWAIT)
> 
> which is limiting the damage to those callers which hand in
> GFP_RT_NOWAIT.
> 
> lockdep will yell at invocations with gfp != GFP_RT_NOWAIT when it hits
> zone->lock in the wrong context. And we want to know about that so we
> can look at the caller and figure out how to solve it.

Yes, that would have to somehow need to annotate the zone_lock to be ok
in those paths so that lockdep doesn't complain.
-- 
Michal Hocko
SUSE Labs
