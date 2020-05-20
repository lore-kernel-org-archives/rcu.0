Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D40C433E0
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39C220758
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 12:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETMGS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 May 2020 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETMGS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 08:06:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CEC061A0E;
        Wed, 20 May 2020 05:06:18 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jbNU8-0007FV-Jb; Wed, 20 May 2020 14:06:08 +0200
Date:   Wed, 20 May 2020 14:06:08 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org
Subject: Re: [PATCH 3/8] srcu: Use local_lock() for per-CPU struct srcu_data
 access
Message-ID: <20200520120608.mwros5jurmidxxfv@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200520102407.GF317569@hirez.programming.kicks-ass.net>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-05-20 12:24:07 [+0200], Peter Zijlstra wrote:
> On Tue, May 19, 2020 at 10:19:07PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0c71505f0e19c..8d2b5f75145d7 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/srcu.h>
> > +#include <linux/locallock.h>
> >  
> >  #include "rcu.h"
> >  #include "rcu_segcblist.h"
> > @@ -735,6 +736,7 @@ static void srcu_flip(struct srcu_struct *ssp)
> >  	smp_mb(); /* D */  /* Pairs with C. */
> >  }
> >  
> > +static DEFINE_LOCAL_LOCK(sda_lock);
> >  /*
> >   * If SRCU is likely idle, return true, otherwise return false.
> >   *
> > @@ -765,13 +767,13 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> >  	unsigned long tlast;
> >  
> >  	/* If the local srcu_data structure has callbacks, not idle.  */
> > -	local_irq_save(flags);
> > +	local_lock_irqsave(sda_lock, flags);
> >  	sdp = this_cpu_ptr(ssp->sda);
> >  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> > -		local_irq_restore(flags);
> > +		local_unlock_irqrestore(sda_lock, flags);
> >  		return false; /* Callbacks already present, so not idle. */
> >  	}
> > -	local_irq_restore(flags);
> > +	local_unlock_irqrestore(sda_lock, flags);
> 
> Would it perhaps make sense to stick the local_lock in struct srcu_data ?

In that case we would need something for pointer stability before the
lock is acquired.
I remember Paul looked at that patch a few years ago and he said that
that disabling interrupts here is important and matches the other part
instance where the interrupts are disabled. Looking at it now, it seems
that there is just pointer stability but I can't tell if
rcu_segcblist_pend_cbs() needs more than just this.

Sebastian
