Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E01C433DB
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0938A64E63
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhBQTTu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232691AbhBQTTs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 14:19:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C874A64E62;
        Wed, 17 Feb 2021 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613589547;
        bh=pSG0iuIL31xGXVd9szFmnqpW+CJUWaIRfjO6bTtnfsI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uHYxUrvOUASzSxS2gDGR33EEKxQi8tL6F057S9vZjqehl3d5NgFwW+nfva+80dWfQ
         z90GzJM6i1iWU9GpjDuW89CJ9mHfflZylFucLOGpl2eLqi76S6ea1x7xCdAIDY2X7r
         KEZw2qqilb83+clyqJ2Z/toOCBsCaecvARNYzVYjfQ1XYkJ/OjAPiXdEwhqc+1rv3k
         h3MBg/atXxiojVvPgivQIPGuiCP5eRwqurplyOBWDqy/L+SiLMmxdgUdDyMptCM1GV
         8h1yBD4LqL59GFcpqrovl1QtFk0ATWGX0CTCTsOBPdmeD++J5zKrva+YOHlwfSt9oY
         eOM297eDQ33sg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8C87F3522611; Wed, 17 Feb 2021 11:19:07 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:19:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: Should RCU_BOOST kernels use hrtimers in GP kthread?
Message-ID: <20210217191907.GH2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210216183609.GA7027@paulmck-ThinkPad-P72>
 <20210217153253.fy2mhxo3o3ehsuix@linutronix.de>
 <20210217155447.GC2743@paulmck-ThinkPad-P72>
 <20210217180159.c4lr3h34lkkvjn7s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217180159.c4lr3h34lkkvjn7s@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Feb 17, 2021 at 07:01:59PM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-17 07:54:47 [-0800], Paul E. McKenney wrote:
> > > I though boosting is accomplished by acquiring a rt_mutex in a
> > > rcu_read() section. Do you have some code to point me to, to see how a
> > > timer is involved here? Or is it the timer saying that *now* boosting is
> > > needed.
> > 
> > Yes, this last, which is in the grace-period kthread code, for example,
> > in rcu_gp_fqs_loop().
> >
> > > If your hrtimer is a "normal" hrtimer then it will be served by
> > > ksoftirqd, too. You would additionally need one of the
> > > HRTIMER_MODE_*_HARD to make it work.
> > 
> > Good to know.  Anything I should worry about for this mode?
> 
> Well. It is always hardirq. No spinlock_t, etc. within that callback.
> If you intend to wake a thread, that thread needs an elevated priority
> otherwise it won't be scheduled (assuming there is a RT tasking running
> which would block otherwise ksoftirqd).

Good to know, thank you!  I believe that all the needed locks are already
raw spinlocks, but the actual kernel code always takes precedence over
one's beliefs.

> Ah. One nice thing is that you can move the RCU threads to a house
> keeping CPU - away from the CPU(s) running the RT tasks. Would this
> scenario be still affected (if ksoftirqd would be blocked)?

At this point, I am going to say that it is the sysadm's job to place
the rcuo kthreads, and if they are placed poorly, life is hard.

This means that I need to create a couple of additional polling RCU
grace-period functions for rcutorture's priority-boosting use, but I
probably should have done that a long time ago.  Simpler to just call a
polling API occasionally than to handle all the corner cases of keeping
an RCU callback queued.

> Oh. One thing I forgot to mention: the timer_list timer is nice in terms
> of moving forward (the timer did not fire, the condition is true and you
> move the timeout forward).
> A hrtimer timer on the other hand needs to be removed, forwarded and
> added back to the "timer tree". This is considered more expensive
> especially if the timer does not fire.

There are some timers that are used to cause a wakeup to happen from
a clean environment, but maybe these can instead use irq-work.

> > Also, the current test expects callbacks to be invoked, which involves a
> > number of additional kthreads and timers, for example, in nocb_gp_wait().
> > I suppose I could instead look at grace-period sequence numbers, but I
> > believe that real-life use cases needing RCU priority boosting also need
> > the callbacks to be invoked reasonably quickly (as in within hundreds
> > of milliseconds up through very small numbers of seconds).
> 
> A busy/overloaded kvm-host could lead to delays by not scheduling the
> guest for a while.

That it can!  Aravinda Prasad prototyped a mechanism hinting to the
hypervisor in such cases, but I don't know that this ever saw the light
of day.

> My understanding of the need for RCU boosting is to get a task,
> preempted (by a RT task) within a RCU section, back on the CPU to
> at least close the RCU section. So it is possible to run RCU callbacks
> and free memory.
> The 10 seconds without RCU callbacks shouldn't be bad unless the OOM
> killer got nervous (and if we had memory allocation failures).
> Also, running thousands of accumulated callbacks isn't good either.

Sounds good, thank you!

							Thanx, Paul

> > Thoughts?
> > 
> > 							Thanx, Paul
> Sebastian
