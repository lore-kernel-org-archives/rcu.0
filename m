Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F41CC433DF
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 18:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F14920829
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597428912;
	bh=b6ay/vyEKVZ8RXEJx6KxRdr6eQ3vaLZWKq8VGxdGnV8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tZbcwZzgUZp26pKm6pw18nxCgzZTWLQpYb9+R3NpZPdNb+3ZsDEsUh7Aaeg2Tl9Mj
	 K8PBvKlbds9aR33tjKma4XXJmSuM6o7tQeiJrvgY4auGbGKHJGNye0/dtchXWeDCmK
	 kZzkTeH6VQ+TJ3xtLLjnJw1p3MQV8G0xdD2ETTyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgHNSPL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgHNSPL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 14:15:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B738020771;
        Fri, 14 Aug 2020 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597428910;
        bh=b6ay/vyEKVZ8RXEJx6KxRdr6eQ3vaLZWKq8VGxdGnV8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2fBfQhY6uC9sj72RVEVdg7x4pVFvrV7CcKnk09h4kKus1JucHNaZweaqdqu9pmlml
         LJtl3q3p1+V8C3k82GsKviSrROhRdK7Vc6Iy/jS0cQ4W6Nly1qiAvu9NJSr8sjUK37
         aCDYCreO5QYfVYh7kmxi1ptopctdPeVEJNgKCobw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 99CE73522A0E; Fri, 14 Aug 2020 11:15:10 -0700 (PDT)
Date:   Fri, 14 Aug 2020 11:15:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
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
Message-ID: <20200814181510.GR4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161904.GD2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814161904.GD2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 06:19:04PM +0200, peterz@infradead.org wrote:
> On Fri, Aug 14, 2020 at 07:14:25AM -0700, Paul E. McKenney wrote:
> 
> > Doing this to kfree_rcu() is the first step.  We will also be doing this
> > to call_rcu(), which has some long-standing invocations from various
> > raw contexts, including hardirq handler.
> 
> Most hardirq handler are not raw on RT due to threaded interrupts.
> Lockdep knows about this.

Understood.  But not all hardirq handlers are threaded.

> > > >   4) As kfree_rcu() can be used from any context except NMI and RT
> > > >      relies on it we ran into a circular dependency problem.
> > > 
> > > Well, which actual usage sites are under a raw spinlock? Most of the
> > > ones I could find are not.
> > 
> > There are some on their way in, but this same optimization will be applied
> > to call_rcu(), and there are no shortage of such call sites in that case.
> > And these call sites have been around for a very long time.
> 
> Luckily there is lockdep to help you find the ones that need converting
> to raw_call_rcu() :-)

I already gave you my views on raw_call_rcu().  :-/

> > > >   Clearly the simplest solution but not Pauls favourite and
> > > >   unfortunately he has a good reason.
> > > 
> > > Which isn't actually stated anywhere I suppose ?
> > 
> > Several times, but why not one more?  ;-)
> > 
> > In CONFIG_PREEMPT_NONE=y kernels, which are heavily used, and for which
> > the proposed kfree_rcu() and later call_rcu() optimizations are quite
> > important, there is no way to tell at runtime whether or you are in
> > atomic raw context.
> 
> CONFIG_PREEMPT_NONE has nothing what so ever to do with any of this.

On the contrary, it has everything to do with this.  It is the environment
in which we cannot use preemptible() to dynamically determine whether
or not it is safe to invoke the memory allocator.

> > > > > 2.	Adding a GFP_ flag.
> > > > 
> > > >   Michal does not like the restriction for !RT kernels and tries to
> > > >   avoid the introduction of a new allocation mode.
> > > 
> > > Like above, I tend to be with Michal on this, just wrap the actual
> > > allocation in CONFIG_PREEMPT_RT, the code needs to handle a NULL pointer
> > > there anyway.
> > 
> > That disables the optimization in the CONFIG_PREEMPT_NONE=y case,
> > where it really is needed.
> 
> No, it disables it for CONFIG_PREEMPT_RT.

Except that lockdep still yells at us for CONFIG_PREEMPT_NONE=y, and
again, in the CONFIG_PREEMPT_NONE=y we cannot use preemptible() to
dynamically determine whether it is safe to invoke the memory allocator.

> > I would be OK with either.  In CONFIG_PREEMPT_NONE=n kernels, the
> > kfree_rcu() code could use preemptible() to determine whether it was safe
> > to invoke the allocator.  The code in kfree_rcu() might look like this:
> > 
> > 	mem = NULL;
> > 	if (IS_ENABLED(CONFIG_PREEMPT_NONE) || preemptible())
> > 		mem = __get_free_page(...);
> > 
> > Is your point is that the usual mistakes would then be caught by the
> > usual testing on CONFIG_PREEMPT_NONE=n kernels?
> 
> 	mem = NULL;
> #if !defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_PROVE_LOCKING)
> 	mem = __get_free_page(...)
> #endif
> 	if (!mem)
> 
> But I _really_ would much rather have raw_kfree_rcu() and raw_call_rcu()
> variants for the few places that actually need it.

Until people start propagating them all over because they happen to
unconditionally stop lockdep from complaining.

> > > >  These are not seperate of each other as #3 requires #4. The most
> > > >  horrible solution IMO from a technical POV as it proliferates
> > > >  inconsistency for no good reaosn.
> > > > 
> > > >  Aside of that it'd be solving a problem which does not exist simply
> > > >  because kfree_rcu() does not depend on it and we really don't want to
> > > >  set precedence and encourage the (ab)use of this in any way.
> > > 
> > > My preferred solution is 1, if you want to use an allocator, you simply
> > > don't get to play under raw_spinlock_t. And from a quick grep, most
> > > kfree_rcu() users are not under raw_spinlock_t context.
> > 
> > There is at least one on its way in, but more to the point, we will
> > need to apply this same optimization to call_rcu(), which is used in
> 
> There is no need, call_rcu() works perfectly fine today, thank you.
> You might want to, but that's an entirely different thing.

Sorry, but no.  The call_rcu() callback invocation currently takes
a cache miss on each step through the rcu_head chain.

> > raw atomic context, including from hardirq handlers.
> 
> Threaded IRQs. There really is very little code that is 'raw' on RT.

Except that we also need to run non-RT kernels.

							Thanx, Paul
