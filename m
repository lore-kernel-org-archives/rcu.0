Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31759C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DE1214D8
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 15:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504962AbgDPPUd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408871AbgDPPU3 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 11:20:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E31C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 08:20:29 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP6JX-0007A0-Fo; Thu, 16 Apr 2020 17:20:27 +0200
Date:   Thu, 16 Apr 2020 17:20:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416150038.GA7772@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 17:01:43 [+0200], Uladzislau Rezki wrote:
> > > @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	unsigned long flags;
> > >  	struct kfree_rcu_cpu *krcp;
> > >  
> > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > -	krcp = this_cpu_ptr(&krc);
> > > -	if (krcp->initialized)
> > > -		spin_lock(&krcp->lock);
> > > +	krcp = raw_cpu_ptr(&krc);
> > > +	spin_lock_irqsave(&krcp->lock, flags);
> > 
> It is not a good way to access to per-CPU variable. There is a race in
> your code. So, we will rework it anyway soon. To guarantee that we stay
> on the same CPU, first we disable IRQ's then we access per-CPU var and
> take a spinlock.

What is the worst thing that can happen if a CPU migration happens
between raw_cpu_ptr() and spin_lock_irqsave() ?

> --
> Vlad Rezki

Sebastian
