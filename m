Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB019C433E4
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2B020838
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597414473;
	bh=7XJDKDGPtuvC7D1c6ZljiDg3kh/fP9DXGUegT1gE9P4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YC+1S9OLudc91p1aWSkb9UXKBqGAGOkyJrjtQmpYnPlrwMSUiAAT2rYdPwX9+GfkU
	 glfCwIGug8WRCw5V2NYrnuGURcbYxf7hkiYgM0ZBqt94xwEVuDJxYW4npYj0AtBC/U
	 fZyg/VeZ5cwwOpFDXNsBJA8zYgAoLX3lFsr1E2ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHNOOd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbgHNOO0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 10:14:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA6020838;
        Fri, 14 Aug 2020 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597414466;
        bh=7XJDKDGPtuvC7D1c6ZljiDg3kh/fP9DXGUegT1gE9P4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1F7kNfxkFyCzwAPqxDstK6gN9COm7tlJ9NO6Yz55qwQNX88YaR2K6HJzoaF+/b7lJ
         838triLNMMZ3haHQ3CSfJEiOUFA2opCnm5+37h9jimFqfz3anSEjrTLnenZ90mKNSJ
         RhUjkb5XwWT8wp/XCrK7lO6QVouz/bWlWeNgtssY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CD4BF3522A0E; Fri, 14 Aug 2020 07:14:25 -0700 (PDT)
Date:   Fri, 14 Aug 2020 07:14:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20200814141425.GM4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813075027.GD9477@dhcp22.suse.cz>
 <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814083037.GD3982@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 10:30:37AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 14, 2020 at 01:59:04AM +0200, Thomas Gleixner wrote:
> > On Fri, Aug 14 2020 at 00:06, peterz wrote:
> > > I'm still not getting it, how do we end up trying to allocate memory
> > > from under raw spinlocks if you're not allowed to use kfree_rcu() under
> > > one ?
> > >
> > > Can someone please spell out the actual problem?
> > 
> > Your actual problem is the heat wave. Get an icepack already :)
> 
> Sure, but also much of the below wasn't stated anywhere in the thread I
> got Cc'ed on. All I got was half arsed solutions without an actual
> problem statement.
> 
> > To set things straight:
> > 
> >   1) kfree_rcu() which used to be just a conveniance wrapper around
> >      call_rcu() always worked in any context except NMI.
> > 
> >      Otherwise RT would have never worked or would have needed other
> >      horrible hacks to defer kfree in certain contexts including
> >      context switch.
> 
> I've never used kfree_rcu(), htf would I know.

Doing this to kfree_rcu() is the first step.  We will also be doing this
to call_rcu(), which has some long-standing invocations from various
raw contexts, including hardirq handler.

> >   2) RCU grew an optimization for kfree_rcu() which avoids the linked
> >      list cache misses when a large number of objects is freed via
> >      kfree_rcu(). Paul says it speeds up post grace period processing by
> >      a factor of 8 which is impressive.
> > 
> >      That's done by avoiding the linked list and storing the object
> >      pointer in an array of pointers which is page sized. This array is
> >      then freed in bulk without having to touch the rcu head linked list
> >      which obviously avoids cache misses.
> > 
> >      Occasionally kfree_rcu() needs to allocate a page for this but it
> >      can fallback to the linked list when the allocation fails.
> >      
> >      Inconveniantly this allocation happens with an RCU internal raw
> >      lock held, but even if we could do the allocation outside the RCU
> >      internal lock this would not solve the problem that kfree_rcu() can
> >      be called in any context except NMI even on RT.
> > 
> >      So RT forbids allocations from truly atomic contexts even with
> >      GFP_ATOMIC/NOWAIT. GFP_ATOMIC is kinda meaningless on RT because
> >      everything which calls it is in non-atomic context :) But still
> >      GFP_ATOMIC or GFP_NOWAIT retain the semantics of !RT and do not go
> >      down into deeper levels or wait for pages to become available.
> 
> Right so on RT just cut out the allocation and unconditionally make it
> NULL. Since it needs to deal with GFP_ATOMIC|GFP_NOWARN failing the
> allocation anyway.

Except that this is not just RT due to CONFIG_PROVE_RAW_LOCK_NESTING=y.

> >   3) #2 upsets lockdep (with the raw lock nesting enabled) rightfully
> >      when RCU tries to allocate a page, the lockless page cache is empty
> >      and it acquires zone->lock which is a regular spinlock
> 
> There was no lockdep splat in the thread.

I don't see the point of including such a splat given that we know that
lockdep is supposed to splat in this situation.

> >   4) As kfree_rcu() can be used from any context except NMI and RT
> >      relies on it we ran into a circular dependency problem.
> 
> Well, which actual usage sites are under a raw spinlock? Most of the
> ones I could find are not.

There are some on their way in, but this same optimization will be applied
to call_rcu(), and there are no shortage of such call sites in that case.
And these call sites have been around for a very long time.

> >      If we disable that feature for RT then the problem would be solved
> >      except that lockdep still would complain about taking zone->lock
> >      within a forbidden context on !RT kernels.
> > 
> >      Preventing that feature because of that is not a feasible option
> >      either. Aside of that we discuss this postfactum, IOW the stuff is
> >      upstream already despite the problem being known before.
> 
> Well, that's a fail :-( I tought we were supposed to solve known issues
> before shit got merged.

The enforcement is coming in and the kfree_rcu() speed up is coming in
at the same time.  The call_rcu() speedup will appear later.

> >   5) Ulad posted patches which introduce a new GFP allocation mode
> >      which makes the allocation fail if the lockless cache is empty,
> >      i.e. it does not try to touch zone->lock in that case.
> > 
> >      That works perfectly fine on RT and !RT, makes lockdep happy and
> >      Paul is happy as well.
> > 
> >      If the lockless cache, which works perfectly fine on RT, is empty
> >      then the performance of kfree_rcu() post grace period processing is
> >      probably not making the situation of the system worse.
> > 
> >      Michal is not fond of the new GFP flag and wants to explore options
> >      to avoid that completely. But so far there is no real feasible
> >      solution.
> 
> Not only Michal, those patches looked pretty horrid.

They are the first round, and will be improved.

> >      A) It was suggested to make zone->lock raw, but that's a total
> >         disaster latency wise. With just a kernel compile (!RT kernel)
> >         spinwait times are in the hundreds of microseconds.
> 
> Yeah, I know, been there done that, like over a decade ago :-)
> 
> >      B) Michal suggested to have GFP_RT_ATOMIC defined to 0 which would
> >         not require a new GFP bit and bail out when RT is enabled and
> >         the context is atomic.
> 
> I would've written the code like:
> 
> 	void *mem = NULL;
> 
> 	...
> #ifndef CONFIG_PREEMPT_RT
> 	mem = kmalloc(PAGE_SIZE, GFP_ATOMIC|GFP_NOWAIT);
> #endif
> 	if (!mem)
> 	  ....
> 
> Seems much simpler and doesn't pollute the GFP_ space.

But fails in the CONFIG_PROVE_RAW_LOCK_NESTING=y case when lockdep
is enabled.

> >      D) To solve the lockdep issue of #B Michal suggested to have magic
> >         lockdep annotations which allow !RT kernels to take zone->lock
> >         from the otherwise forbidden contexts because on !RT this lock
> >         nesting could be considered a false positive.
> > 
> >         But this would be horrors of some sorts because there might be
> >         locks further down which then need the same treatment or some
> >         general 'yay, I'm excempt from everything' annotation which is
> >         short of disabling lockdep completly.
> > 
> >         Even if that could be solved and made correct for both RT and
> >         !RT then this opens the can of worms that this kind of
> >         annotation would show up all over the place within no time for
> >         the completely wrong reasons.
> 
> So due to this heat crap I've not slept more than a few hours a night
> for the last week, I'm not entirely there, but we already have a bunch
> of lockdep magic for this raw nesting stuff.

Ouch!  Here is hoping for cooler weather soon!

> But yes, we need to avoid abuse, grep for lockdep_off() :-( This
> drivers/md/dm-cache-target.c thing is just plain broken. It sorta
> 'works' on mainline (and even there it can behave badly), but on RT it
> will come apart with a bang.
> 
> > Paul compiled this options list:
> > 
> > > 1.	Prohibit invoking allocators from raw atomic context, such
> > >	as when holding a raw spinlock.
> > 
> >   Clearly the simplest solution but not Pauls favourite and
> >   unfortunately he has a good reason.
> 
> Which isn't actually stated anywhere I suppose ?

Several times, but why not one more?  ;-)

In CONFIG_PREEMPT_NONE=y kernels, which are heavily used, and for which
the proposed kfree_rcu() and later call_rcu() optimizations are quite
important, there is no way to tell at runtime whether or you are in
atomic raw context.

> > > 2.	Adding a GFP_ flag.
> > 
> >   Michal does not like the restriction for !RT kernels and tries to
> >   avoid the introduction of a new allocation mode.
> 
> Like above, I tend to be with Michal on this, just wrap the actual
> allocation in CONFIG_PREEMPT_RT, the code needs to handle a NULL pointer
> there anyway.

That disables the optimization in the CONFIG_PREEMPT_NONE=y case,
where it really is needed.

> > > 3.	Reusing existing GFP_ flags/values/whatever to communicate
> > >	the raw-context information that was to be communicated by
> > >	the new GFP_ flag.
> > >
> > > 4.	Making lockdep forgive acquiring spinlocks while holding
> > >	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.
> 
> Uhh, !CONFIG_PREEMPT_RT, the rest is 'fine'.

I would be OK with either.  In CONFIG_PREEMPT_NONE=n kernels, the
kfree_rcu() code could use preemptible() to determine whether it was safe
to invoke the allocator.  The code in kfree_rcu() might look like this:

	mem = NULL;
	if (IS_ENABLED(CONFIG_PREEMPT_NONE) || preemptible())
		mem = __get_free_page(...);

Is your point is that the usual mistakes would then be caught by the
usual testing on CONFIG_PREEMPT_NONE=n kernels?

> >  These are not seperate of each other as #3 requires #4. The most
> >  horrible solution IMO from a technical POV as it proliferates
> >  inconsistency for no good reaosn.
> > 
> >  Aside of that it'd be solving a problem which does not exist simply
> >  because kfree_rcu() does not depend on it and we really don't want to
> >  set precedence and encourage the (ab)use of this in any way.
> 
> My preferred solution is 1, if you want to use an allocator, you simply
> don't get to play under raw_spinlock_t. And from a quick grep, most
> kfree_rcu() users are not under raw_spinlock_t context.

There is at least one on its way in, but more to the point, we will
need to apply this same optimization to call_rcu(), which is used in
raw atomic context, including from hardirq handlers.

> This here sounds like someone who wants to have his cake and eat it too.

Just looking for a non-negative sized slice of cake, actually!

> I'll try and think about a lockdep annotation that isn't utter crap, but
> that's probably next week, I need this heat to end and get a few nights
> sleep, I'm an utter wreck atm.

Again, here is hoping for cooler weather!

							Thanx, Paul
