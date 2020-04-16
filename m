Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2BEC2BA2B
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17E5206B9
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgDPV2d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbgDPV2c (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 16 Apr 2020 17:28:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED05C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 14:28:32 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jPC3e-0006oo-Qw; Thu, 16 Apr 2020 23:28:27 +0200
Date:   Thu, 16 Apr 2020 23:28:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416212826.3sxhcttiqhqxdvnx@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416195327.GW17661@paulmck-ThinkPad-P72>
 <20200416200557.GA11301@pc636>
 <20200416202530.GX17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416202530.GX17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 13:25:30 [-0700], Paul E. McKenney wrote:
> 
> True, but that is an optimization rather than an absolute necessity.
> In addition, most two-argument kfree_rcu() callers will take another slot
> from the array that has already been allocated.  So one alternative is
> to do the allocation only if both interrupts and preemption are enabled.
> As long as most kfree_rcu() invocations can allocate, you get good
> performance and things work nicely in -rt.
This would have to be limited to -RT since spinlock_t disables
preemption for !RT.

> Another alternative is to check to see what currently invokes kfree_rcu()
> and work out what to do about any that are invoked from an environment
> in which -rt does not allow memory allocation.  And deal with future
> additions of kfree_rcu() to such environments.
> 
> Given that most people don't test -rt, the second alternative has
> the potential of handing Sebastian an endless stream of bugs that are
> kfree_rcu() usage bugs only in -rt.  But maybe he is OK with that?
> (I wouldn't be, but I will let him speak for himself.)

Hopefully we don't have this OOT ride much longer and so it receives
more / wider testing once it is merged.
However. A grep for current users of kfree_rcu() shows drivers mostly.
Almost no core-code. The parts within kernel/ have a spinlock_t acquire
so no raw_spinlock_t. This should be fine. 

> 							Thanx, Paul

Sebastian
