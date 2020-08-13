Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34187C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 23:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087DB206D9
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 23:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBcIGOt3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6+CTuig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHMX7I (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 19:59:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMX7H (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 19:59:07 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597363144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6nUzIbq6DA8HJk1llkWA+TXgPt/cdU2hca1HD4zah4=;
        b=hBcIGOt3bqsCzxa9hZ4XrjKytsDm/kzFLJ2KzbBrPSZpytGg9Lcz9F8Tr5RU+3QHDFvr6e
        P9wzHrBlj5GV7zh3mM5+PyCj8GcJp8axnNdilF124nieqhX98nybtNV+T1spll+xVF259m
        HBhF5VjzYVqrS8PLaW/sueqPfsTn/VOhSSDqIfPWzrXHxWY+HzqrDluOrpaZ3DMg6UVhfU
        y35vP+bMAFAVYxxnh5NdeKBb4h0kjd9a06om0uRMuII04Ymxqp4SXN6ldt/qCsVYait2Ks
        iEeTB8iCW0Pl9/PANgaYtAVwTmeT+Vyf5EfxwIaRRt7J3pA0GXHZD3RxdthCow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597363144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6nUzIbq6DA8HJk1llkWA+TXgPt/cdU2hca1HD4zah4=;
        b=C6+CTuigi6os+eaYYZIfaAX4Pa5Meh8eoHojpLBk+Ter5Mq2bUmpkNcWfavM1IIOu2o97G
        j+GGVbw8lx/fNHCA==
To:     peterz@infradead.org, "Paul E. McKenney" <paulmck@kernel.org>
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
In-Reply-To: <20200813220619.GA2674@hirez.programming.kicks-ass.net>
References: <20200811210931.GZ4295@paulmck-ThinkPad-P72> <874kp87mca.fsf@nanos.tec.linutronix.de> <20200813075027.GD9477@dhcp22.suse.cz> <20200813095840.GA25268@pc636> <874kp6llzb.fsf@nanos.tec.linutronix.de> <20200813133308.GK9477@dhcp22.suse.cz> <87sgcqty0e.fsf@nanos.tec.linutronix.de> <20200813182618.GX2674@hirez.programming.kicks-ass.net> <20200813185257.GF4295@paulmck-ThinkPad-P72> <20200813220619.GA2674@hirez.programming.kicks-ass.net>
Date:   Fri, 14 Aug 2020 01:59:04 +0200
Message-ID: <875z9m3xo7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14 2020 at 00:06, peterz wrote:
> I'm still not getting it, how do we end up trying to allocate memory
> from under raw spinlocks if you're not allowed to use kfree_rcu() under
> one ?
>
> Can someone please spell out the actual problem?

Your actual problem is the heat wave. Get an icepack already :)

To set things straight:

  1) kfree_rcu() which used to be just a conveniance wrapper around
     call_rcu() always worked in any context except NMI.

     Otherwise RT would have never worked or would have needed other
     horrible hacks to defer kfree in certain contexts including
     context switch.

  2) RCU grew an optimization for kfree_rcu() which avoids the linked
     list cache misses when a large number of objects is freed via
     kfree_rcu(). Paul says it speeds up post grace period processing by
     a factor of 8 which is impressive.

     That's done by avoiding the linked list and storing the object
     pointer in an array of pointers which is page sized. This array is
     then freed in bulk without having to touch the rcu head linked list
     which obviously avoids cache misses.

     Occasionally kfree_rcu() needs to allocate a page for this but it
     can fallback to the linked list when the allocation fails.
     
     Inconveniantly this allocation happens with an RCU internal raw
     lock held, but even if we could do the allocation outside the RCU
     internal lock this would not solve the problem that kfree_rcu() can
     be called in any context except NMI even on RT.

     So RT forbids allocations from truly atomic contexts even with
     GFP_ATOMIC/NOWAIT. GFP_ATOMIC is kinda meaningless on RT because
     everything which calls it is in non-atomic context :) But still
     GFP_ATOMIC or GFP_NOWAIT retain the semantics of !RT and do not go
     down into deeper levels or wait for pages to become available.

  3) #2 upsets lockdep (with the raw lock nesting enabled) rightfully
     when RCU tries to allocate a page, the lockless page cache is empty
     and it acquires zone->lock which is a regular spinlock

  4) As kfree_rcu() can be used from any context except NMI and RT
     relies on it we ran into a circular dependency problem.

     If we disable that feature for RT then the problem would be solved
     except that lockdep still would complain about taking zone->lock
     within a forbidden context on !RT kernels.

     Preventing that feature because of that is not a feasible option
     either. Aside of that we discuss this postfactum, IOW the stuff is
     upstream already despite the problem being known before.

  5) Ulad posted patches which introduce a new GFP allocation mode
     which makes the allocation fail if the lockless cache is empty,
     i.e. it does not try to touch zone->lock in that case.

     That works perfectly fine on RT and !RT, makes lockdep happy and
     Paul is happy as well.

     If the lockless cache, which works perfectly fine on RT, is empty
     then the performance of kfree_rcu() post grace period processing is
     probably not making the situation of the system worse.

     Michal is not fond of the new GFP flag and wants to explore options
     to avoid that completely. But so far there is no real feasible
     solution.

     A) It was suggested to make zone->lock raw, but that's a total
        disaster latency wise. With just a kernel compile (!RT kernel)
        spinwait times are in the hundreds of microseconds.

        RT tests showed max latency of cyclictest go up from 30 to 220
        microseconds, i.e. factor 7 just because of that.

        So not really great.

        It would have had the charm to keep the semantics of GFP_NOWAIT,
        but OTOH even if it would work I'm pretty oppposed to open the
        can of worm which allows allocations from the deepest atomic
        contexts in general without a really good reason.

     B) Michal suggested to have GFP_RT_ATOMIC defined to 0 which would
        not require a new GFP bit and bail out when RT is enabled and
        the context is atomic.

        That of course does not solve the problem vs. lockdep.

        Also the idea to make this conditional on !preemptible() does
        not work because preemptible() returns always false for
        CONFIG_PREEMPT_COUNT=n kernels.

     C) I suggested to make GFP == 0 fail unconditionally when the
        lockless cache is empty, but that changes the semantics on !RT
        kernels for existing users which hand in 0.
        
     D) To solve the lockdep issue of #B Michal suggested to have magic
        lockdep annotations which allow !RT kernels to take zone->lock
        from the otherwise forbidden contexts because on !RT this lock
        nesting could be considered a false positive.

        But this would be horrors of some sorts because there might be
        locks further down which then need the same treatment or some
        general 'yay, I'm excempt from everything' annotation which is
        short of disabling lockdep completly.

        Even if that could be solved and made correct for both RT and
        !RT then this opens the can of worms that this kind of
        annotation would show up all over the place within no time for
        the completely wrong reasons.

Paul compiled this options list:

> 1.	Prohibit invoking allocators from raw atomic context, such
>	as when holding a raw spinlock.

  Clearly the simplest solution but not Pauls favourite and
  unfortunately he has a good reason.     

> 2.	Adding a GFP_ flag.

  The simplest and most consistent solution. If you really need to do
  allocations from such contexts then deal with the limitations whether
  it's RT or not. Paul has no problem with that and this newfangled
  kfree_rcu() is the only user and can live with that restriction.

  Michal does not like the restriction for !RT kernels and tries to
  avoid the introduction of a new allocation mode.

  My argument here is that consistency is the best solution and the
  extra GFP mode is explicitly restrictive due to the context which it
  is called from. Aside of that this affects exactly ONE use case which
  has a really good reason and does not care about the restriction even
  on !RT because in that situation kfree_rcu() performance is not the
  most urgent problem.

> 3.	Reusing existing GFP_ flags/values/whatever to communicate
>	the raw-context information that was to be communicated by
>	the new GFP_ flag.
>
> 4.	Making lockdep forgive acquiring spinlocks while holding
>	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.

 These are not seperate of each other as #3 requires #4. The most
 horrible solution IMO from a technical POV as it proliferates
 inconsistency for no good reaosn.

 Aside of that it'd be solving a problem which does not exist simply
 because kfree_rcu() does not depend on it and we really don't want to
 set precedence and encourage the (ab)use of this in any way.

Having a distinct GFP mode is technically correct, consistent on all
kernel variants and does not affect any exisiting user of the page
allocator aside of the new kfree_rcu().

I hope that the cloudy and rainy day cured most of my heat wave induced
brain damage to the extent that the above is correctly summarizing the
state of affairs. If not, then please yell and I get an icepack.

Thanks,

        tglx


     

     
