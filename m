Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86609C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6336020781
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 17:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dg2M4+vk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3V/Z8GWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMRJd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:09:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59922 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMRJc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 13:09:32 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597338569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmTNPkuaiUL1AQb4NdLtfKrnPDetmsLhMV6xdmVCJ/I=;
        b=dg2M4+vk4YAvwtgITQvz6MX+2Qesrj0RhveXx/EQ3spoPLsRhO4RjvhdimxRK3BbPWx4/1
        sbdASwc6xPYtlaZau+DOk+Rdr3YsNh5/PlpJVexNmK0ehJC7EkgXKRBFMaZOyH4TSkS+3t
        LJE0ITLc351gOahydQzM/TQ0wMknAphpxpe1sfHPIG/Bf10IIfXTpSQN5k0cD5dR6XxUw2
        W/A+IPCp14xneYz44wtt0CrHCFkMAalXz4qjkk4KxzLh/l4bScKl6I6B8pUOlYmyfjtPYf
        UD5ins7t1okErS9kUXN2z7I1wSKHPJA793f0JpfWDEg/Dmui8jMlAsFyUsKufw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597338569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmTNPkuaiUL1AQb4NdLtfKrnPDetmsLhMV6xdmVCJ/I=;
        b=3V/Z8GWdi7p6FNLtBgXn4mbAlwMQmBdTGGFx3W+5rE2jgmAQ9kSsZ7zER4cf16/CYRNJ25
        Lc3LQQaYCLbmWoDA==
To:     Michal Hocko <mhocko@suse.com>
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
In-Reply-To: <20200813145335.GN9477@dhcp22.suse.cz>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200813075027.GD9477@dhcp22.suse.cz> <20200813095840.GA25268@pc636> <874kp6llzb.fsf@nanos.tec.linutronix.de> <20200813133308.GK9477@dhcp22.suse.cz> <87sgcqty0e.fsf@nanos.tec.linutronix.de> <20200813145335.GN9477@dhcp22.suse.cz>
Date:   Thu, 13 Aug 2020 19:09:29 +0200
Message-ID: <87lfiitquu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:
> On Thu 13-08-20 16:34:57, Thomas Gleixner wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> > Yes, that would have to somehow need to annotate the zone_lock to be ok
>> > in those paths so that lockdep doesn't complain.
>> 
>> That opens the worst of all cans of worms. If we start this here then
>> Joe programmer and his dog will use these lockdep annotation to evade
>> warnings and when exposed to RT it will fall apart in pieces. Just that
>> at that point Joe programmer moved on to something else and the usual
>> suspects can mop up the pieces. We've seen that all over the place and
>> some people even disable lockdep temporarily because annotations don't
>> help.
>
> Hmm. I am likely missing something really important here. We have two
> problems at hand:
> 1) RT will become broken as soon as this new RCU functionality which
> requires an allocation from inside of raw_spinlock hits the RT tree
> 2) lockdep splats which are telling us that early because of the
> raw_spinlock-> spin_lock dependency.

Correct.

> 1) can be handled by handled by the bailing out whenever we have to use
> zone->lock inside the buddy allocator - essentially even more strict
> NOWAIT semantic than we have for RT tree - proposed (pseudo) patch is
> trying to describe that.
>
> 2) would become a false positive if 1) is in place, right? RT wouldn't
> do the illegal nesting and !RT would just work fine because
> GFP_RT_NOWAIT would be simply GFP_NOWAIT & ~__GFP_KSWAPD_RECLAIM.

And how do you deal with that false positive and the subsequent false
positives when this code hits the next regular spinlock in some code
path? Disabling lockdep or crippling coverage?

> Why should we limit the functionality of the allocator for something
> that is not a real problem?

We'd limit the allocator for exactly ONE new user which was aware of
this problem _before_ the code hit mainline. And that ONE user is
prepared to handle the fail.

Any other usage of the page allocator just works. The amount of raw
spinlocks is very limited and there are very good reasons to make them
raw spinlocks. And none of them does allocations inside, except this
particular new one. Some did years ago, but none of them was necessary
at all, quite the contrary most of them were just pointless and in
frequent hot pathes.

Let me ask the question the other way round:

  Is there a real request by Paul that going deeper into the allocator
  is necessary for his new fangled RCU thing?

I haven't seen one and if the lockless allocation fails then the system
might have other worries than getting a page to this particular RCU
thing which has a perfectly working fallback.

It's not affecting anything else. GFP_ATOMIC/NOWAIT still work the same
way as before from all other contexts and that's 99,9999999999% of all
use cases. Why, because none of them happen under a raw spinlock.

Even if we could make this lockdep thing work that does not mean that
it's a good thing to do.

Quite the contrary, you'd just encourage people to create more of those
use cases for probably the completely wrong reasons. Putting a
limitation into place upfront might makes them think farther than just
slapping GFP_RT_ATOMIC in and be done with it. Let me dream :)

I've dealt with tons of patches in the last 15+ years where people just
came up with 's/GFP_KERNEL/GFP_ATOMIC/ because tool complained'
patches. The vast majority of them were bogus because the alloc() was
simply at the wrong place.

Forcing people not to take the easy way out by making the infrastructure
restrictive is way better than encouraging mindless hackery. We have
enough of this (not restricted to memory allocations) all over the
kernel already. No need for more.

>> Really, if your primary lockless caches are empty then any allocation
>> which comes from deep atomic context should simply always fail. Being
>> stuck in an interrupt handler or even deeper for 200+ microseconds
>> waiting for zone lock is just bonkers IMO.
>
> That would require changing NOWAIT/ATOMIC allocations semantic quite
> drastically for !RT kernels as well. I am not sure this is something we
> can do. Or maybe I am just missing your point.

I really do not understand why you think that it affects everything. 

It's exactly ONE particular use case which is affected, i.e. Pauls new
RCU thing if he uses GFP_RT_NOWAIT.

Everything else is not affected at all and NOWAIT/ATOMIC just works as
it used to work because NOWAIT != 0 and ATOMIC != 0.

Thanks,

        tglx
