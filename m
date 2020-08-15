Return-Path: <SRS0=YobW=BZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C084FC433E4
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99BB7204FD
	for <rcu@archiver.kernel.org>; Sat, 15 Aug 2020 21:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="quYqow0s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+JEYArJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHOVzS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgHOVwZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A47C061347;
        Fri, 14 Aug 2020 17:43:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597452231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0G+axppjGzFD1dQNhB/BC6HHOikgQeBJXohrz5/uf+I=;
        b=quYqow0sv/t/SjNiTyD3L+z5nz0GeEj7daya89jKSPPryz+OVDUY5FNaW9KeUjna6pziII
        q3Yi+KIXjxKXk5fNbVwdcMY61G/K1XDwtFyYxdmlQXIjfKX/XXPalJcTwgpbp1gLSS62SE
        /J5thjIZMthAZTCVbsKIsk/S/0QB45mx51zHbNb1v6yLX6fzPazpPa2+Fo5AEBNIpYn+Xa
        /9NeFoRRwdn3Hedh/y9AOevdRs3P9bd1H5RQLEz9jDMXIQuw8/0RDVhlPyzLw0Ouv8CCQg
        +8GuPuGzxYpv+jO1NjzalC7xDjqoI3UO4CyCVQUZSg29E32CIFue6zXE/qqdXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597452231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0G+axppjGzFD1dQNhB/BC6HHOikgQeBJXohrz5/uf+I=;
        b=S+JEYArJZdKGoQo+wpzbe4846cAJl157BcP2o1PIh9OAXUCuoGjDeFJpORMMo4OlFAe11J
        LjfA/Xvu6T6II0BA==
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
In-Reply-To: <20200814234152.GV4295@paulmck-ThinkPad-P72>
References: <20200814180141.GP4295@paulmck-ThinkPad-P72> <87tux4kefm.fsf@nanos.tec.linutronix.de> <20200814234152.GV4295@paulmck-ThinkPad-P72>
Date:   Sat, 15 Aug 2020 02:43:51 +0200
Message-ID: <87ft8okabc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Paul,

On Fri, Aug 14 2020 at 16:41, Paul E. McKenney wrote:
> On Sat, Aug 15, 2020 at 01:14:53AM +0200, Thomas Gleixner wrote:
>> As a matter of fact I assume^Wdeclare that removing struct rcu_head which
>> provides a fallback is not an option at all. I know that you want to,
>> but it wont work ever. Dream on, but as we agreed on recently there is
>> this thing called reality which ruins everything.
>
> For call_rcu(), agreed.  For kfree_rcu(), we know what the callback is
> going to do, plus single-argument kfree_rcu() can only be invoked from
> sleepable context.  (If you want to kfree_rcu() from non-sleepable
> context, that will cost you an rcu_head in the data structure being
> freed.)

kfree_rcu() as of today is just a conveniance wrapper around
call_rcu(obj, rcu) which can be called from any context and it still
takes TWO arguments.

Icepack?

So if you come up with a new kfree_rcu_magic(void *obj) single argument
variant which can only be called from sleepable contexts then this does
not require any of the raw lock vs. non raw hacks at all because you can
simply allocate without holding the raw lock in the rare case that you
run out of storage space. With four 4k pages preallocated per CPU that's
every 2048 invocations per CPU on 64bit.

So if you run into that situation then you drop the lock and then it's
racy because you might be preempted or migrated after dropping the lock
and you might have done a useless allocation, but that does not justify
having a special allocator just for that? You have an extra page, so
what?

To prevent subsequent callers to add to the allocation race you simply
can let them wait on the first allocating attempt to finish That avoids
more pointless allocations and as a side effect prevents all of them to
create more pressure by continuing their open/close loop naturally
without extra work.

> So if the single-argument kfree_rcu() case gets hit with a
> memory-allocation failure, it can fall back to waiting for a grace
> period and doing the free.  Of course, grace-period waits have horrible
> latency, but under OOM life is hard.  If this becomes a problem in
> non-OOM situations due to the lockless caches becoming empty, we will
> have to allocate memory if needed before acquiring the lock with the
> usual backout logic.  Doing that means that we can let the allocator
> acquire locks and maybe even do a little bit of blocking, so that the
> inline grace-period-wait would only happen if the system was well and
> truly OOMed.

No. It dropped the rcu internal lock and does a regular GFP_KENRNEL
allocation which waits for the page to become available. Which is a good
thing in the open/close scenario because it throttles the offender.

>> For normal operations a couple of pages which can be preallocated are
>> enough. What you are concerned of is the case where you run out of
>> pointer storage space.
>
> Agreed.
>
>> There are two reasons why that can happen:
>> 
>>       1) RCU call flooding
>>       2) RCU not being able to run and mop up the backlog
>> 
>> #1 is observable by looking at the remaining storage space and the RCU
>>    call frequency
>> 
>> #2 is uninteresting because it's caused by RCU being stalled / delayed
>>    e.g. by a runaway of some sorts or a plain RCU usage bug.
>>    
>>    Allocating more memory in that case does not solve or improve anything.
>
> Yes, #2 is instead RCU CPU stall warning territory.
>
> If this becomes a problem, one approach is to skip the page-of-pointers
> allocation if the grace period is more than (say) one second old.  If
> the grace period never completes, OOM is unavoidable, but this is a way
> of putting it off for a bit.

Don't even think about optimizing your new thing for #2. It's a
pointless exercise. If the task which runs into the 'can't allocate'
case then is sleeps and waits. End of story.

>> So the interesting case is #1. Which means we need to look at the
>> potential sources of the flooding:
>> 
>>     1) User space via syscalls, e.g. open/close
>>     2) Kernel thread
>>     3) Softirq
>>     4) Device interrupt
>>     5) System interrupts, deep atomic context, NMI ...
>> 
>> #1 trivial fix is to force switching to an high prio thread or a soft
>>    interrupt which does the allocation
>> 
>> #2 Similar to #1 unless that thread loops with interrupts, softirqs or
>>    preemption disabled. If that's the case then running out of RCU
>>    storage space is the least of your worries.
>> 
>> #3 Similar to #2. The obvious candidates (e.g. NET) for monopolizing a
>>    CPU have loop limits in place already. If there is a bug which fails
>>    to care about the limit, why would RCU care and allocate more memory?
>> 
>> #4 Similar to #3. If the interrupt handler loops forever or if the
>>    interrupt is a runaway which prevents task/softirq processing then
>>    RCU free performance is the least of your worries.
>> 
>> #5 Clearly a bug and making RCU accomodate for that is beyond silly.
>> 
>> So if call_rcu() detects that the remaining storage space for pointers
>> goes below the critical point or if it observes high frequency calls
>> then it simply should force a soft interrupt which does the allocation.
>
> Unless call_rcu() has been invoked with scheduler locks held.  But
> eventually call_rcu() should be invoked with interrupts enabled, and at
> that point it would be safe to raise_softirq(), wake_up(), or
> whatever.

If this atomic context corner case is hit within a problematic context
then we talk about the RCU of today and not about the future single
argument thing. And that oldschool RCU has a fallback. We are talking
about pressure corner cases and you really want to squeeze out the last
cache miss?  What for? If there is pressure then these cache misses are
irrelevant.

Thanks,

        tglx
