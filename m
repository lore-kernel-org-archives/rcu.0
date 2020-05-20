Return-Path: <SRS0=9J+a=7C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0EFC433DF
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 18:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518D420671
	for <rcu@archiver.kernel.org>; Wed, 20 May 2020 18:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgETS2i convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Wed, 20 May 2020 14:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgETS2h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 May 2020 14:28:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE59C061A0E;
        Wed, 20 May 2020 11:28:37 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jbTRg-0008Qk-Ns; Wed, 20 May 2020 20:28:00 +0200
Date:   Wed, 20 May 2020 20:28:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20200520182800.sdp6t6bgbhn4kkqk@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-4-bigeasy@linutronix.de>
 <20200520102407.GF317569@hirez.programming.kicks-ass.net>
 <20200520120608.mwros5jurmidxxfv@linutronix.de>
 <20200520174259.GA247557@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200520174259.GA247557@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-05-20 13:42:59 [-0400], Joel Fernandes wrote:
> Hi Sebastian,
Hi Joel,

> For pointer stability, can we just use get_local_ptr() and put_local_ptr()
> instead of adding an extra lock? This keeps the pointer stable while keeping
> the section preemptible on -rt. And we already have a lock in rcu_data, I
> prefer not to add another lock if possible.

What is this get_local_ptr() doing? I can't find it anywhere…

> I wrote a diff below with get_local_ptr() (just build tested). Does this
> solve your issue?

see below.

> > I remember Paul looked at that patch a few years ago and he said that
> > that disabling interrupts here is important and matches the other part
> > instance where the interrupts are disabled. Looking at it now, it seems
> > that there is just pointer stability but I can't tell if
> > rcu_segcblist_pend_cbs() needs more than just this.
> 
> Which 'other part' are you referring to? Your patch removed local_irq_save()
> from other places as well right?

The patch converted hunks.

> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 8ff71e5d0fe8b..5f49919205317 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -778,13 +778,17 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
>  	unsigned long tlast;
>  
>  	/* If the local srcu_data structure has callbacks, not idle.  */
> -	local_irq_save(flags);
> -	sdp = this_cpu_ptr(ssp->sda);
> +	sdp = get_local_ptr(ssp->sda);
> +	spin_lock_irqsave_rcu_node(sdp, flags);

You acquire the node lock which was not acquired before. Is that okay?
How is get_local_ptr() different to raw_cpu_ptr()?

>  	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
> -		local_irq_restore(flags);
> +		spin_unlock_irqrestore_rcu_node(sdp, flags);
> +		put_local_ptr(sdp);
>  		return false; /* Callbacks already present, so not idle. */
>  	}
> -	local_irq_restore(flags);
> +
> +	spin_unlock_irqrestore_rcu_node(sdp, flags);
> +	put_local_ptr(sdp);
>  
>  	/*
>  	 * No local callbacks, so probabalistically probe global state.

Sebastian
