Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67699C433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A3920774
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 08:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KitTYbsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHNIay (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgHNIaw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 04:30:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B209C061383;
        Fri, 14 Aug 2020 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XpANu85erNWSJ40G8O+ekxGWnxTbhgV8bUUFyhfVcKY=; b=KitTYbscYcSRdAj4yqtN8YT7Ih
        KFnh8ZmSs5NQGIz7Y24xS5t2jYwp1LZt8h8zlUaJRVWP9bTVQAjutguJkWInr64JKnXWuNEnhPTGB
        zL6B2r+uJay5Uv/1m2oY2jqo+QIhCoY0dC2CxgLoVRjc7nD2FuPBzWLlw1DzRQ5dAoO2TsnUVQaZN
        D0fvPA9aVWqASSUI93E5z4wyaan271tiP/BniTfpKwGpbgsd5wKcMQUZr5MXrahdYjtUMXeG2Olb7
        cpIXO1xVzmw7jcc2yinfJXdt1hskYjy9Agvu4NNaxmW36ktm3MADlzFWK/ztwUSWdSFoRkXr9M++J
        IptcyMvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6V6m-0008OV-9p; Fri, 14 Aug 2020 08:30:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FB8F980C8B; Fri, 14 Aug 2020 10:30:37 +0200 (CEST)
Date:   Fri, 14 Aug 2020 10:30:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814083037.GD3982@worktop.programming.kicks-ass.net>
References: <874kp87mca.fsf@nanos.tec.linutronix.de>
 <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z9m3xo7.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 01:59:04AM +0200, Thomas Gleixner wrote:
> On Fri, Aug 14 2020 at 00:06, peterz wrote:
> > I'm still not getting it, how do we end up trying to allocate memory
> > from under raw spinlocks if you're not allowed to use kfree_rcu() under
> > one ?
> >
> > Can someone please spell out the actual problem?
> 
> Your actual problem is the heat wave. Get an icepack already :)

Sure, but also much of the below wasn't stated anywhere in the thread I
got Cc'ed on. All I got was half arsed solutions without an actual
problem statement.

> To set things straight:
> 
>   1) kfree_rcu() which used to be just a conveniance wrapper around
>      call_rcu() always worked in any context except NMI.
> 
>      Otherwise RT would have never worked or would have needed other
>      horrible hacks to defer kfree in certain contexts including
>      context switch.

I've never used kfree_rcu(), htf would I know.

>   2) RCU grew an optimization for kfree_rcu() which avoids the linked
>      list cache misses when a large number of objects is freed via
>      kfree_rcu(). Paul says it speeds up post grace period processing by
>      a factor of 8 which is impressive.
> 
>      That's done by avoiding the linked list and storing the object
>      pointer in an array of pointers which is page sized. This array is
>      then freed in bulk without having to touch the rcu head linked list
>      which obviously avoids cache misses.
> 
>      Occasionally kfree_rcu() needs to allocate a page for this but it
>      can fallback to the linked list when the allocation fails.
>      
>      Inconveniantly this allocation happens with an RCU internal raw
>      lock held, but even if we could do the allocation outside the RCU
>      internal lock this would not solve the problem that kfree_rcu() can
>      be called in any context except NMI even on RT.
> 
>      So RT forbids allocations from truly atomic contexts even with
>      GFP_ATOMIC/NOWAIT. GFP_ATOMIC is kinda meaningless on RT because
>      everything which calls it is in non-atomic context :) But still
>      GFP_ATOMIC or GFP_NOWAIT retain the semantics of !RT and do not go
>      down into deeper levels or wait for pages to become available.

Right so on RT just cut out the allocation and unconditionally make it
NULL. Since it needs to deal with GFP_ATOMIC|GFP_NOWARN failing the
allocation anyway.

>   3) #2 upsets lockdep (with the raw lock nesting enabled) rightfully
>      when RCU tries to allocate a page, the lockless page cache is empty
>      and it acquires zone->lock which is a regular spinlock

There was no lockdep splat in the thread.

>   4) As kfree_rcu() can be used from any context except NMI and RT
>      relies on it we ran into a circular dependency problem.

Well, which actual usage sites are under a raw spinlock? Most of the
ones I could find are not.

>      If we disable that feature for RT then the problem would be solved
>      except that lockdep still would complain about taking zone->lock
>      within a forbidden context on !RT kernels.
> 
>      Preventing that feature because of that is not a feasible option
>      either. Aside of that we discuss this postfactum, IOW the stuff is
>      upstream already despite the problem being known before.

Well, that's a fail :-( I tought we were supposed to solve known issues
before shit got merged.

>   5) Ulad posted patches which introduce a new GFP allocation mode
>      which makes the allocation fail if the lockless cache is empty,
>      i.e. it does not try to touch zone->lock in that case.
> 
>      That works perfectly fine on RT and !RT, makes lockdep happy and
>      Paul is happy as well.
> 
>      If the lockless cache, which works perfectly fine on RT, is empty
>      then the performance of kfree_rcu() post grace period processing is
>      probably not making the situation of the system worse.
> 
>      Michal is not fond of the new GFP flag and wants to explore options
>      to avoid that completely. But so far there is no real feasible
>      solution.

Not only Michal, those patches looked pretty horrid.

>      A) It was suggested to make zone->lock raw, but that's a total
>         disaster latency wise. With just a kernel compile (!RT kernel)
>         spinwait times are in the hundreds of microseconds.

Yeah, I know, been there done that, like over a decade ago :-)

>      B) Michal suggested to have GFP_RT_ATOMIC defined to 0 which would
>         not require a new GFP bit and bail out when RT is enabled and
>         the context is atomic.

I would've written the code like:

	void *mem = NULL;

	...
#ifndef CONFIG_PREEMPT_RT
	mem = kmalloc(PAGE_SIZE, GFP_ATOMIC|GFP_NOWAIT);
#endif
	if (!mem)
	  ....

Seems much simpler and doesn't pollute the GFP_ space.

>      D) To solve the lockdep issue of #B Michal suggested to have magic
>         lockdep annotations which allow !RT kernels to take zone->lock
>         from the otherwise forbidden contexts because on !RT this lock
>         nesting could be considered a false positive.
> 
>         But this would be horrors of some sorts because there might be
>         locks further down which then need the same treatment or some
>         general 'yay, I'm excempt from everything' annotation which is
>         short of disabling lockdep completly.
> 
>         Even if that could be solved and made correct for both RT and
>         !RT then this opens the can of worms that this kind of
>         annotation would show up all over the place within no time for
>         the completely wrong reasons.

So due to this heat crap I've not slept more than a few hours a night
for the last week, I'm not entirely there, but we already have a bunch
of lockdep magic for this raw nesting stuff.

But yes, we need to avoid abuse, grep for lockdep_off() :-( This
drivers/md/dm-cache-target.c thing is just plain broken. It sorta
'works' on mainline (and even there it can behave badly), but on RT it
will come apart with a bang.

> Paul compiled this options list:
> 
> > 1.	Prohibit invoking allocators from raw atomic context, such
> >	as when holding a raw spinlock.
> 
>   Clearly the simplest solution but not Pauls favourite and
>   unfortunately he has a good reason.

Which isn't actually stated anywhere I suppose ?

> > 2.	Adding a GFP_ flag.
> 
>   Michal does not like the restriction for !RT kernels and tries to
>   avoid the introduction of a new allocation mode.

Like above, I tend to be with Michal on this, just wrap the actual
allocation in CONFIG_PREEMPT_RT, the code needs to handle a NULL pointer
there anyway.

> > 3.	Reusing existing GFP_ flags/values/whatever to communicate
> >	the raw-context information that was to be communicated by
> >	the new GFP_ flag.
> >
> > 4.	Making lockdep forgive acquiring spinlocks while holding
> >	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.

Uhh, !CONFIG_PREEMPT_RT, the rest is 'fine'.

>  These are not seperate of each other as #3 requires #4. The most
>  horrible solution IMO from a technical POV as it proliferates
>  inconsistency for no good reaosn.
> 
>  Aside of that it'd be solving a problem which does not exist simply
>  because kfree_rcu() does not depend on it and we really don't want to
>  set precedence and encourage the (ab)use of this in any way.

My preferred solution is 1, if you want to use an allocator, you simply
don't get to play under raw_spinlock_t. And from a quick grep, most
kfree_rcu() users are not under raw_spinlock_t context.

This here sounds like someone who wants to have his cake and eat it too.

I'll try and think about a lockdep annotation that isn't utter crap, but
that's probably next week, I need this heat to end and get a few nights
sleep, I'm an utter wreck atm.

