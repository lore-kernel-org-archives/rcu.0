Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CBC433E0
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 04:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F7A2078B
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 04:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597206587;
	bh=3oQg9EtXUNowZHv38guplGbXVFeap/2h3AXQPHoZPsU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qaio6lAj6fwswn49iTe1763Oiytyn1RFoZPPtqXTF0MLb5afrmBQNDd9St4eT1AJt
	 S3UjMJrwOU4RNOSF0BEQDafIXCDsda592wz4vNPRZuR94P/pqelv/Y8HgBxqz3Ui69
	 xnYR3xaadwLsMTFNLmAHKtfyDERoF6iExiS2+GAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgHLE3r (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgHLE3q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 00:29:46 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5263206C3;
        Wed, 12 Aug 2020 04:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597206585;
        bh=3oQg9EtXUNowZHv38guplGbXVFeap/2h3AXQPHoZPsU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f+CGjqAKbjSRhPUkCEjSmDJ/Ig6aPnZESaRy3UAVcEEOKyW/gPZc8LHQlHjpDUYyq
         HDqBPsGSWq/uyqIpZo95q9psuLZUiQxwhH+0qv352iR8+cFxyhG4XqL1v0TKLtgaoj
         ZXWbfwJhOkJRHiGgApKQuxtPva7Q5YOGqYUjluP0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8B88235230BE; Tue, 11 Aug 2020 21:29:45 -0700 (PDT)
Date:   Tue, 11 Aug 2020 21:29:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20200812042945.GB4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
 <874kp87mca.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kp87mca.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 12, 2020 at 02:13:25AM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > Hence Ulad's work on kfree_rcu().  The approach is to allocate a
> > page-sized array to hold all the pointers, then fill in the rest of these
> > pointers on each subsequent kfree_rcu() call.  These arrays of pointers
> > also allows use of kfree_bulk() instead of kfree(), which can improve
> > performance yet more.  It is no big deal if kfree_rcu()'s allocation
> > attempts fail occasionally because it can simply fall back to the old
> > linked-list approach.  And given that the various lockless caches in
> > the memory allocator are almost never empty, in theory life is good.
> 
> Of course, it's always the damned reality which ruins the fun.

Classic!!!  And yes, it always is!

> > But in practice, mainline now has CONFIG_PROVE_RAW_LOCK_NESTING,
> > and for good reason -- this Kconfig option makes it at least a
> > little bit harder for mainline developers to mess up RT.  But with
> > CONFIG_PROVE_RAW_LOCK_NESTING=y and lockdep enabled, mainline will now
> > sometimes complain if you invoke kfree_rcu() while holding a raw spinlock.
> > This happens when kfree_rcu() needs to invoke the memory allocator and
> > the memory allocator's caches are empty, thus resulting in the memory
> > allocator attempting to acquire a non-raw spinlock.
> 
> Right.
> 
> > Because kfree_rcu() has a fallback available (just using the old linked
> > list), kfree_rcu() would work well given a way to tell the memory
> > allocator to return NULL instead of acquiring a non-raw spinlock.
> > Which is exactly what Ulad's recent patches are intended to do.
> 
> That much I understood, but I somehow failed to figure the why out
> despite the elaborate changelog. 2 weeks of 30+C seem to have cooked my
> brain :)

Ouch!!!  And what on earth is Germany doing being that warm???

I hate it when that happens...

> > Since then, this thread has discussed various other approaches,
> > including using existing combinations of GFP_ flags, converting
> > the allocator's zone lock to a raw spinlock, and so on.
> >
> > Does that help, or am I missing the point of your question?
> 
> Yes, that helps so far that I understand what the actual problem is. It
> does not really help to make me more happy. :)

I must confess that I was not expecting to find anything resembling
happiness anywhere down this road, whether for myself or anyone else...

> That said, we can support atomic allocations on RT up to the point where
> zone->lock comes into play. We don't know yet exactly where the
> zone->lock induced damage happens. Presumably it's inside
> free_pcppages_bulk() - at least that's where I have faint bad memories
> from 15+ years ago. Aside of that I seriously doubt that it can be made
> work within a reasonable time frame.

I was not considering any approach other than return NULL just before
the code would otherwise have acquired zone->lock.

> But what makes me really unhappy is that my defense line against
> allocations from truly atomic contexts (from RT POV) which was enforced
> on RT gets a real big gap shot into it.

Understood, and agreed:  We do need to keep the RT degradation in check.

> It becomes pretty hard to argue why atomic allocations via kmalloc() or
> kmem_cache_alloc() should be treated any different. Technically they can
> work similar to the page allocations up to the point where regular
> spinlocks come into play or the slab cache is exhausted. Where to draw
> the line?
> 
> It's also unclear for the page allocator case whether we can and should
> stick a limit on the number of pages and/or the pageorder.
> 
> Myself and others spent a considerable amount of time to kill off these
> kind of allocations from various interesting places including the guts
> of send IPI, the affinity setting path and others where people just
> slapped allocations into them because the stack checker warned or
> because they happened to copy the code from some other place.
> 
> RT was pretty much a quick crap detector whenever new incarnations of
> this got added and to some extent continuous education about these
> issues made them less prominent over the years. Using atomic allocations
> should always have a real good rationale, not only in the cases where
> they collide with RT.
> 
> I can understand your rationale and what you are trying to solve. So, if
> we can actually have a distinct GFP variant:
> 
>   GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY
> 
> which is easy to grep for then having the page allocator go down to the
> point where zone lock gets involved is not the end of the world for
> RT in theory - unless that damned reality tells otherwise. :)

I have no objection to an otherwise objectionable name in this particular
case.  After all, we now have 100 characters per line, right?  ;-)

> The page allocator allocations should also have a limit on the number of
> pages and eventually also page order (need to stare at the code or let
> Michal educate me that the order does not matter).

Understood.  I confess that I have but little understanding of that code.

> To make it consistent the same GFP_ variant should allow the slab
> allocator go to the point where the slab cache is exhausted.

Why not wait until someone has an extremely good reason for needing
this functionality from the slab allocators?  After all, leaving out
the slab allocators would provide a more robust defense line.  Yes,
consistent APIs are very good things as a general rule, but maybe this
situation is one of the exceptions to that rule.

> Having a distinct and clearly defined GFP_ variant is really key to
> chase down offenders and to make reviewers double check upfront why this
> is absolutely required.

Checks for that GFP_ variant could be added to automation, though reality
might eventually prove that to be a mixed blessing.

							Thanx, Paul
