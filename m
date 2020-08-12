Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5428CC433DF
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 00:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 245AA2076C
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 00:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHoygjWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9gP+Z/SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLANa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLAN3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 20:13:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7AC06174A;
        Tue, 11 Aug 2020 17:13:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597191205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=9o2xocBmMKWGpKJOBWpYqCTq3dBqHfmmP5MZZ+TNn/k=;
        b=aHoygjWdGZLlY8I2asIR9AK7/L1qaNlfnKbQF77c8rvEbH0zI4dH5SbFfMnzz+pShD31Hr
        6FTMVMX69bLPxLQnGDRnq7P6FVSUcQ/r8et1bEoz9mgSTLYT/9ZuvEr83H8wsJLHwcHPw6
        X0QM/TzIG1LZN3aGLkFcg5D8zadEXmq9q5RsnRkRa69xeYPS5W3ZfhbzwO8Gc1tiHtnve+
        caiGNa0gySL2o171pqgUUT5lZTehMRpGl1Zvd+xLXYmYcR/N0e2Hu5gikapcZFIOJ+3bU+
        xMQj0rNpG52+nR6yxYlQv+y3f9AVbBxYCE7fuJJGEsO86iRJFA07Odr+1msthA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597191205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=9o2xocBmMKWGpKJOBWpYqCTq3dBqHfmmP5MZZ+TNn/k=;
        b=9gP+Z/SDK+tLZqCqOYjUwckIMb00/9iARm/1+28b1XjOnsTDRjNgOuOtlQi5M96ompf4ZV
        7sTn42mKQdyuS2Bg==
To:     paulmck@kernel.org
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
In-Reply-To: <20200811210931.GZ4295@paulmck-ThinkPad-P72>
Date:   Wed, 12 Aug 2020 02:13:25 +0200
Message-ID: <874kp87mca.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> Hence Ulad's work on kfree_rcu().  The approach is to allocate a
> page-sized array to hold all the pointers, then fill in the rest of these
> pointers on each subsequent kfree_rcu() call.  These arrays of pointers
> also allows use of kfree_bulk() instead of kfree(), which can improve
> performance yet more.  It is no big deal if kfree_rcu()'s allocation
> attempts fail occasionally because it can simply fall back to the old
> linked-list approach.  And given that the various lockless caches in
> the memory allocator are almost never empty, in theory life is good.

Of course, it's always the damned reality which ruins the fun.

> But in practice, mainline now has CONFIG_PROVE_RAW_LOCK_NESTING,
> and for good reason -- this Kconfig option makes it at least a
> little bit harder for mainline developers to mess up RT.  But with
> CONFIG_PROVE_RAW_LOCK_NESTING=y and lockdep enabled, mainline will now
> sometimes complain if you invoke kfree_rcu() while holding a raw spinlock.
> This happens when kfree_rcu() needs to invoke the memory allocator and
> the memory allocator's caches are empty, thus resulting in the memory
> allocator attempting to acquire a non-raw spinlock.

Right.

> Because kfree_rcu() has a fallback available (just using the old linked
> list), kfree_rcu() would work well given a way to tell the memory
> allocator to return NULL instead of acquiring a non-raw spinlock.
> Which is exactly what Ulad's recent patches are intended to do.

That much I understood, but I somehow failed to figure the why out
despite the elaborate changelog. 2 weeks of 30+C seem to have cooked my
brain :)

> Since then, this thread has discussed various other approaches,
> including using existing combinations of GFP_ flags, converting
> the allocator's zone lock to a raw spinlock, and so on.
>
> Does that help, or am I missing the point of your question?

Yes, that helps so far that I understand what the actual problem is. It
does not really help to make me more happy. :)

That said, we can support atomic allocations on RT up to the point where
zone->lock comes into play. We don't know yet exactly where the
zone->lock induced damage happens. Presumably it's inside
free_pcppages_bulk() - at least that's where I have faint bad memories
from 15+ years ago. Aside of that I seriously doubt that it can be made
work within a reasonable time frame.

But what makes me really unhappy is that my defense line against
allocations from truly atomic contexts (from RT POV) which was enforced
on RT gets a real big gap shot into it.

It becomes pretty hard to argue why atomic allocations via kmalloc() or
kmem_cache_alloc() should be treated any different. Technically they can
work similar to the page allocations up to the point where regular
spinlocks come into play or the slab cache is exhausted. Where to draw
the line?

It's also unclear for the page allocator case whether we can and should
stick a limit on the number of pages and/or the pageorder.

Myself and others spent a considerable amount of time to kill off these
kind of allocations from various interesting places including the guts
of send IPI, the affinity setting path and others where people just
slapped allocations into them because the stack checker warned or
because they happened to copy the code from some other place.

RT was pretty much a quick crap detector whenever new incarnations of
this got added and to some extent continuous education about these
issues made them less prominent over the years. Using atomic allocations
should always have a real good rationale, not only in the cases where
they collide with RT.

I can understand your rationale and what you are trying to solve. So, if
we can actually have a distinct GFP variant:

  GFP_I_ABSOLUTELY_HAVE_TO_DO_THAT_AND_I_KNOW_IT_CAN_FAIL_EARLY

which is easy to grep for then having the page allocator go down to the
point where zone lock gets involved is not the end of the world for
RT in theory - unless that damned reality tells otherwise. :)

The page allocator allocations should also have a limit on the number of
pages and eventually also page order (need to stare at the code or let
Michal educate me that the order does not matter).

To make it consistent the same GFP_ variant should allow the slab
allocator go to the point where the slab cache is exhausted.

Having a distinct and clearly defined GFP_ variant is really key to
chase down offenders and to make reviewers double check upfront why this
is absolutely required.

Thanks,

        tglx
