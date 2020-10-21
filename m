Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE58BC388F9
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 21:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E30E2419A
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603315008;
	bh=bOHoiYFZ+xyJgLQtXuLgV3l45KEiMTOiKzJhlF/pyQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Flh+Fz3MVYZysbL7WD+5PhxP7ZiFiVMkKyN9xT+SPQBb1KhjYJGGMiMmjLk/AX+bj
	 lcdJemgiP6YOnlXQml9Dc9IcsCtsMQvm5ZeSIkQigmHsMEvvrXV9v72saEksEtddcb
	 6Qt+trlC78rlTm29ojZyWN5eKgbibYvWfEqJl71w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505956AbgJUVQs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 17:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505955AbgJUVQr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 17:16:47 -0400
Received: from localhost (cha74-h07-176-172-165-167.dsl.sta.abo.bbox.fr [176.172.165.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2A924198;
        Wed, 21 Oct 2020 21:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603315006;
        bh=bOHoiYFZ+xyJgLQtXuLgV3l45KEiMTOiKzJhlF/pyQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAu0US1Dgp1dTdHuMFxmsvdz8SKGoYc/C6M6PJjSHlApjf2EOiu7O74o7vutUMNJ8
         WUAw05TEbMZXEif9lA4bfO9U0d9ypzZMCojpcXfM4rYH/aWiLdg1sc5wJo3emGrRb6
         O3pt2NWWPo0MFKDQaS8bK0WY5peOAXRzfAJqHclc=
Date:   Wed, 21 Oct 2020 23:16:43 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201021211643.GA78735@lothringen>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
 <20201017031941.GD4015033@google.com>
 <20201017132954.GA15657@lothringen>
 <20201018003556.GA1034551@google.com>
 <20201019123730.GA34192@lothringen>
 <CAEXW_YTtYspPNw_eL1vmGXhY8nJ8uQonSc5KuA1weYv3G+bWPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTtYspPNw_eL1vmGXhY8nJ8uQonSc5KuA1weYv3G+bWPg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 21, 2020 at 11:57:04AM -0700, Joel Fernandes wrote:
> On Mon, Oct 19, 2020 at 5:37 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> > Now, reading the documentation of rcu_barrier() (thanks to you!):
> >
> >     Pseudo-code using rcu_barrier() is as follows:
> >
> >    1. Prevent any new RCU callbacks from being posted.
> >    2. Execute rcu_barrier().
> >    3. Allow the module to be unloaded.
> >
> 
> Basically, you are saying that if all CPUs agree that len == 0
> henceforth (through other memory barriers), then callback enqueuing
> does not need a memory barrier before setting length to 0.

I think setting length to 0 isn't much an issue. At worst we send a useless
IPI and queue a needless callback. But incrementing from 0 to 1 is precisely
what we don't want to miss.

> I think that makes sense but is it worth removing the memory barrier
> before WRITE(len, 1) and hoping after #1, the caller would have
> ensured things are fine? Also I am not sure if the above is the only
> usecase for rcu_barrier().

I'm not sure either. Also I need to check your scenario again.

> > cancel_work_sync() also seem to really sync as well. I'm less sure about del_timer_sync().
> >
> > Say we have:
> >
> > expire_timers (CPU 0)                               CPU 1
> > -------------                                       -----------
> > detach_timer(timer)
> > raw_spin_unlock(&base->lock);
> > call_timer_fn(timer, fn, baseclk);
> >    -> enqueue callback
> > //would need at least smp_wmb() here

Aah, my bad, the smp_mb() after inc_len does that.

> > base->running_timer = NULL;
> >
> >                                                     del_timer_sync() {
> >                                                         raw_spin_lock(&base->lock);
> >                                                         if (base->running_timer != timer)
> >                                                             ret = detach_if_pending(timer, base, true);
> >                                                                 if (!timer_pending())
> >                                                                     return 0;
> >                                                         raw_spin_unlock(&base->lock);
> >                                                     }
> >                                                     //would need at least smp_rmb() here

And rcu_seq_start() implies that, although I'm not sure that's what was intended.
So we are good.

> 
> Regarding "would need at least smp_rmb.." :
> But the rcu_barrier() has the control dependency we discussed in last
> emails, between READ(len) and whatever follows the rcu_barrier().
> That itself will provide the ordering right?

I'm not sure that was enough. The len itself has to be synchronized against
whatever callback enqueuer that got stopped.

> I could be missing something too :-/. But I'll include this patch in
> my next posting anyway and let us also maybe see if Paul disagrees.

Ok.

Thanks!
