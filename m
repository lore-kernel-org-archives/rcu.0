Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBDC433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8570720768
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPguHYO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHNQTU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgHNQTT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 12:19:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3DCC061384;
        Fri, 14 Aug 2020 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tjapFxFFmZX6lmNO1XlptdG6KqxDjEYgdAJY4Ema6jg=; b=FPguHYO9I8AfNvioH+7lUzP1gQ
        CFMl3oLA9FcEo67U8z1RMVYd4Fh11bFWGEpXjVYRETUMUVOr7zMCoCmG9uZgq/ueWOReN9tp+IGdo
        cU5vt7xkNEywdg6soqI7QwtXMcgWNkghEY0ay6z/ZCvZJR+tdZ0jRyrpZveByxNQMUGppQ5PcoNq1
        OPgRfESetOz4gF0uI9n3ty7IyVp9B8x0OCLp10W8vqGxawLLQhJaaMlDO2TWU4zEqZZCDjIrrxnPf
        CgD6/+5pgLSGjZ4oJHli7tdMTrBNkud6WF/dI+9v0VmFo2CqmJsxI5eyJsc08fztffWMX4K0JcurH
        Yr7K1Mlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6cQ6-0003nf-Te; Fri, 14 Aug 2020 16:19:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD7D53011F0;
        Fri, 14 Aug 2020 18:19:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE55E2C369E57; Fri, 14 Aug 2020 18:19:04 +0200 (CEST)
Date:   Fri, 14 Aug 2020 18:19:04 +0200
From:   peterz@infradead.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200814161904.GD2674@hirez.programming.kicks-ass.net>
References: <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814141425.GM4295@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 07:14:25AM -0700, Paul E. McKenney wrote:

> Doing this to kfree_rcu() is the first step.  We will also be doing this
> to call_rcu(), which has some long-standing invocations from various
> raw contexts, including hardirq handler.

Most hardirq handler are not raw on RT due to threaded interrupts.
Lockdep knows about this.

> > >   4) As kfree_rcu() can be used from any context except NMI and RT
> > >      relies on it we ran into a circular dependency problem.
> > 
> > Well, which actual usage sites are under a raw spinlock? Most of the
> > ones I could find are not.
> 
> There are some on their way in, but this same optimization will be applied
> to call_rcu(), and there are no shortage of such call sites in that case.
> And these call sites have been around for a very long time.

Luckily there is lockdep to help you find the ones that need converting
to raw_call_rcu() :-)

> > >   Clearly the simplest solution but not Pauls favourite and
> > >   unfortunately he has a good reason.
> > 
> > Which isn't actually stated anywhere I suppose ?
> 
> Several times, but why not one more?  ;-)
> 
> In CONFIG_PREEMPT_NONE=y kernels, which are heavily used, and for which
> the proposed kfree_rcu() and later call_rcu() optimizations are quite
> important, there is no way to tell at runtime whether or you are in
> atomic raw context.

CONFIG_PREEMPT_NONE has nothing what so ever to do with any of this.

> > > > 2.	Adding a GFP_ flag.
> > > 
> > >   Michal does not like the restriction for !RT kernels and tries to
> > >   avoid the introduction of a new allocation mode.
> > 
> > Like above, I tend to be with Michal on this, just wrap the actual
> > allocation in CONFIG_PREEMPT_RT, the code needs to handle a NULL pointer
> > there anyway.
> 
> That disables the optimization in the CONFIG_PREEMPT_NONE=y case,
> where it really is needed.

No, it disables it for CONFIG_PREEMPT_RT.

> I would be OK with either.  In CONFIG_PREEMPT_NONE=n kernels, the
> kfree_rcu() code could use preemptible() to determine whether it was safe
> to invoke the allocator.  The code in kfree_rcu() might look like this:
> 
> 	mem = NULL;
> 	if (IS_ENABLED(CONFIG_PREEMPT_NONE) || preemptible())
> 		mem = __get_free_page(...);
> 
> Is your point is that the usual mistakes would then be caught by the
> usual testing on CONFIG_PREEMPT_NONE=n kernels?

	mem = NULL;
#if !defined(CONFIG_PREEMPT_RT) && !defined(CONFIG_PROVE_LOCKING)
	mem = __get_free_page(...)
#endif
	if (!mem)

But I _really_ would much rather have raw_kfree_rcu() and raw_call_rcu()
variants for the few places that actually need it.

> > >  These are not seperate of each other as #3 requires #4. The most
> > >  horrible solution IMO from a technical POV as it proliferates
> > >  inconsistency for no good reaosn.
> > > 
> > >  Aside of that it'd be solving a problem which does not exist simply
> > >  because kfree_rcu() does not depend on it and we really don't want to
> > >  set precedence and encourage the (ab)use of this in any way.
> > 
> > My preferred solution is 1, if you want to use an allocator, you simply
> > don't get to play under raw_spinlock_t. And from a quick grep, most
> > kfree_rcu() users are not under raw_spinlock_t context.
> 
> There is at least one on its way in, but more to the point, we will
> need to apply this same optimization to call_rcu(), which is used in

There is no need, call_rcu() works perfectly fine today, thank you.
You might want to, but that's an entirely different thing.

> raw atomic context, including from hardirq handlers.

Threaded IRQs. There really is very little code that is 'raw' on RT.
