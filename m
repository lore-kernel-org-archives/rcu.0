Return-Path: <SRS0=YobW=BZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FBC433E3
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2409220658
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529480;
	bh=VjSy88OZdK0t+zkVLUWmLUAMv7a0kHRUqImAjbyrFIY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aIi2rk4ZAoOvu9/9ORogz2zmgPhbK2N/M9I8B49SCmStBD7wyTS8ccyPJL3dWaORv
	 5ISc/LE0SjjzUxCRyi46hXWFrzEmRVGwWtsRAwDOabZABzFD4xwqFbLEgr+SKAx+S/
	 40As18IVrPxH6mIM8BGtUb3YfgapcfZzQ3rJAB68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHOWLT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgHOWKa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17F922D2A;
        Sat, 15 Aug 2020 03:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597460508;
        bh=VjSy88OZdK0t+zkVLUWmLUAMv7a0kHRUqImAjbyrFIY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SB+4IgrRRU3ZgH0KJxwNukOvD9EdB5xiOV8AHeyhZwJjn5VwTzQ6xt4TbTRgLk8sg
         UDYYv29SK5rDcwK0m6VveCuQ0q7Bd2uGZkbFaixF1nuxWF6Y7+I3Hya/4NRTTgF1HY
         8Pkg5JvbNAm2+Uazhf/YZf5K0ZIahsRly6aoiAjk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8823B3522B27; Fri, 14 Aug 2020 20:01:48 -0700 (PDT)
Date:   Fri, 14 Aug 2020 20:01:48 -0700
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200815030148.GX4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814180141.GP4295@paulmck-ThinkPad-P72>
 <87tux4kefm.fsf@nanos.tec.linutronix.de>
 <20200814234152.GV4295@paulmck-ThinkPad-P72>
 <87ft8okabc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft8okabc.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Aug 15, 2020 at 02:43:51AM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Fri, Aug 14 2020 at 16:41, Paul E. McKenney wrote:
> > On Sat, Aug 15, 2020 at 01:14:53AM +0200, Thomas Gleixner wrote:
> >> As a matter of fact I assume^Wdeclare that removing struct rcu_head which
> >> provides a fallback is not an option at all. I know that you want to,
> >> but it wont work ever. Dream on, but as we agreed on recently there is
> >> this thing called reality which ruins everything.
> >
> > For call_rcu(), agreed.  For kfree_rcu(), we know what the callback is
> > going to do, plus single-argument kfree_rcu() can only be invoked from
> > sleepable context.  (If you want to kfree_rcu() from non-sleepable
> > context, that will cost you an rcu_head in the data structure being
> > freed.)
> 
> kfree_rcu() as of today is just a conveniance wrapper around
> call_rcu(obj, rcu) which can be called from any context and it still
> takes TWO arguments.
> 
> Icepack?

Indeed.  Make that not kfree_rcu(), but rather kvfree_rcu(), which is
in mainline.  :-/

> So if you come up with a new kfree_rcu_magic(void *obj) single argument
> variant which can only be called from sleepable contexts then this does
> not require any of the raw lock vs. non raw hacks at all because you can
> simply allocate without holding the raw lock in the rare case that you
> run out of storage space. With four 4k pages preallocated per CPU that's
> every 2048 invocations per CPU on 64bit.
> 
> So if you run into that situation then you drop the lock and then it's
> racy because you might be preempted or migrated after dropping the lock
> and you might have done a useless allocation, but that does not justify
> having a special allocator just for that? You have an extra page, so
> what?
> 
> To prevent subsequent callers to add to the allocation race you simply
> can let them wait on the first allocating attempt to finish That avoids
> more pointless allocations and as a side effect prevents all of them to
> create more pressure by continuing their open/close loop naturally
> without extra work.

Agreed, as I said, it is the double-argument version that is the
challenge.

> > So if the single-argument kfree_rcu() case gets hit with a
> > memory-allocation failure, it can fall back to waiting for a grace
> > period and doing the free.  Of course, grace-period waits have horrible
> > latency, but under OOM life is hard.  If this becomes a problem in
> > non-OOM situations due to the lockless caches becoming empty, we will
> > have to allocate memory if needed before acquiring the lock with the
> > usual backout logic.  Doing that means that we can let the allocator
> > acquire locks and maybe even do a little bit of blocking, so that the
> > inline grace-period-wait would only happen if the system was well and
> > truly OOMed.
> 
> No. It dropped the rcu internal lock and does a regular GFP_KENRNEL
> allocation which waits for the page to become available. Which is a good
> thing in the open/close scenario because it throttles the offender.

Understood, especially that last.  But it really doesn't want to be
waiting in the memory allocator for more than a grace period.  But that
was hashed out quite some time ago, and there is a combination of GFP_*
flags that achieves the right balance for the can-sleep situation.

> >> For normal operations a couple of pages which can be preallocated are
> >> enough. What you are concerned of is the case where you run out of
> >> pointer storage space.
> >
> > Agreed.
> >
> >> There are two reasons why that can happen:
> >> 
> >>       1) RCU call flooding
> >>       2) RCU not being able to run and mop up the backlog
> >> 
> >> #1 is observable by looking at the remaining storage space and the RCU
> >>    call frequency
> >> 
> >> #2 is uninteresting because it's caused by RCU being stalled / delayed
> >>    e.g. by a runaway of some sorts or a plain RCU usage bug.
> >>    
> >>    Allocating more memory in that case does not solve or improve anything.
> >
> > Yes, #2 is instead RCU CPU stall warning territory.
> >
> > If this becomes a problem, one approach is to skip the page-of-pointers
> > allocation if the grace period is more than (say) one second old.  If
> > the grace period never completes, OOM is unavoidable, but this is a way
> > of putting it off for a bit.
> 
> Don't even think about optimizing your new thing for #2. It's a
> pointless exercise. If the task which runs into the 'can't allocate'
> case then is sleeps and waits. End of story.

Agreed, and hence my "If this becomes a problem".  Until such time,
it is pointless.  For one thing, we don't yet know the failure mode.
But it has been helpful for me to think a move or two ahead when
playing against RCU, hence the remainder of my paragraph.

> >> So the interesting case is #1. Which means we need to look at the
> >> potential sources of the flooding:
> >> 
> >>     1) User space via syscalls, e.g. open/close
> >>     2) Kernel thread
> >>     3) Softirq
> >>     4) Device interrupt
> >>     5) System interrupts, deep atomic context, NMI ...
> >> 
> >> #1 trivial fix is to force switching to an high prio thread or a soft
> >>    interrupt which does the allocation
> >> 
> >> #2 Similar to #1 unless that thread loops with interrupts, softirqs or
> >>    preemption disabled. If that's the case then running out of RCU
> >>    storage space is the least of your worries.
> >> 
> >> #3 Similar to #2. The obvious candidates (e.g. NET) for monopolizing a
> >>    CPU have loop limits in place already. If there is a bug which fails
> >>    to care about the limit, why would RCU care and allocate more memory?
> >> 
> >> #4 Similar to #3. If the interrupt handler loops forever or if the
> >>    interrupt is a runaway which prevents task/softirq processing then
> >>    RCU free performance is the least of your worries.
> >> 
> >> #5 Clearly a bug and making RCU accomodate for that is beyond silly.
> >> 
> >> So if call_rcu() detects that the remaining storage space for pointers
> >> goes below the critical point or if it observes high frequency calls
> >> then it simply should force a soft interrupt which does the allocation.
> >
> > Unless call_rcu() has been invoked with scheduler locks held.  But
> > eventually call_rcu() should be invoked with interrupts enabled, and at
> > that point it would be safe to raise_softirq(), wake_up(), or
> > whatever.
> 
> If this atomic context corner case is hit within a problematic context
> then we talk about the RCU of today and not about the future single
> argument thing. And that oldschool RCU has a fallback. We are talking
> about pressure corner cases and you really want to squeeze out the last
> cache miss?  What for? If there is pressure then these cache misses are
> irrelevant.

Of course.  My point was instead that even this atomic corner case was
likely to have escape routes in the form of occasional non-atomic calls,
and that these could do the wakeups.

Again, thank you.

							Thanx, Paul
