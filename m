Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7486EC433ED
	for <rcu@archiver.kernel.org>; Tue, 18 May 2021 23:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A276124C
	for <rcu@archiver.kernel.org>; Tue, 18 May 2021 23:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhERXQd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 May 2021 19:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235802AbhERXQd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 May 2021 19:16:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91B1761244;
        Tue, 18 May 2021 23:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621379714;
        bh=zvqQUBzCZdDwgxkqtv0tRQcxHrEt6kHuN5grJUD1MKI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X+PMDNp1jIahWu+jXe783dPbYVyQTxiEbUMYBbXoB4ogVYlo/RZJNV0fyAVLPlAYX
         xC+ptSClo7zMWLJNHOxOABjqJr460N1KY00Tov4RB04p0nEgrVUIpci17LmTf4EYB0
         QAKgG7a0JJQS8t4jRUgNa8AcSBErZeeYw6dCoYhvgIB+ChX71/sEXSONvmqBPlXkNF
         IAAqrz4TZ8xiGPd5v0sxVePv+il0ezANa0w8yODD1jFEzChEhDHYygvrMY07CZAY6u
         ah2rOpjzCEpsMCftvUxxTabA++tUlsz7nHti2MmCXriYOGTdy512A4ul9/PN6FdSKP
         92ihFFf7mvufA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 602535C013C; Tue, 18 May 2021 16:15:14 -0700 (PDT)
Date:   Tue, 18 May 2021 16:15:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <20210518231514.GS4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210516102716.689596-1-senozhatsky@chromium.org>
 <20210517162312.GG4441@paulmck-ThinkPad-P17-Gen-1>
 <YKMbQQ0qBAixXC5p@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKMbQQ0qBAixXC5p@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 18, 2021 at 10:41:21AM +0900, Sergey Senozhatsky wrote:
> On (21/05/17 09:23), Paul E. McKenney wrote:
> > On Sun, May 16, 2021 at 07:27:16PM +0900, Sergey Senozhatsky wrote:
> > > Soft watchdog timer function checks if a virtual machine
> > > was suspended and hence what looks like a lockup in fact
> > > is a false positive.
> > > 
> > > This is what kvm_check_and_clear_guest_paused() does: it
> > > tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
> > > and if it's set then we need to touch all watchdogs and bail
> > > out.
> > > 
> > > Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
> > > check works fine.
> > > 
> > > There is, however, one more watchdog that runs from IRQ, so
> > > watchdog timer fn races with it, and that watchdog is not aware
> > > of PVCLOCK_GUEST_STOPPED - RCU stall detector.
> > > 
> > > apic_timer_interrupt()
> > >  smp_apic_timer_interrupt()
> > >   hrtimer_interrupt()
> > >    __hrtimer_run_queues()
> > >     tick_sched_timer()
> > >      tick_sched_handle()
> > >       update_process_times()
> > >        rcu_sched_clock_irq()
> > > 
> > > This triggers RCU stalls on our devices during VM resume.
> > > 
> > > If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
> > > before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
> > > then there is nothing on this VCPU that touches watchdogs and
> > > RCU reads stale gp stall timestamp and new jiffies value, which
> > > makes it think that RCU has stalled.
> > > 
> > > Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
> > > don't report RCU stalls when we resume the VM.
> > 
> > Good point!
> > 
> > But if I understand your patch correctly, if the virtual machine is
> > stopped at any point during a grace period, even if only for a short time,
> > stall warnings are suppressed for that grace period forever, courtesy of
> > the call to rcu_cpu_stall_reset().  So, if something really is stalling,
> > and the virtual machine just happens to stop for a few milliseconds, the
> > stall warning is completely suppressed.  Which would make it difficult
> > to debug the underlying stall condition.
> > 
> > Is it possible to provide RCU with information on the duration of the
> > virtual-machine stoppage so that RCU could adjust the timing of the
> > stall warning?  Maybe by having something like rcu_cpu_stall_reset()
> > that takes the duration of the stoppage in jiffies?
> 
> Good questions!
> 
> And I think I've some bad news and some good news.
> 
> As far as I can tell, none of the PVCLOCK_GUEST_STOPPED handlers take
> the stoppage duration into consideration. For instance, as soon as
> watchdog timer IRQ detects a potential softlockup it checks
> PVCLOCK_GUEST_STOPPED and touches all watchdogs, including RCU:
> 
> watchdog_timer_fn()
>  kvm_check_and_clear_guest_paused()
>   pvclock_touch_watchdogs()
>    rcu_cpu_stall_reset()                 // + the remaining watchdogs
> 
> But things get more complex.
> 
> pvclock_clocksource_read() also checks PVCLOCK_GUEST_STOPPED and calls
> pvclock_touch_watchdogs(). And this path is executed rather often.
> 
> For instance,
> 
> apic_timer_interrupt()
>  smp_apic_timer_interrupt()
>   hrtimer_interrupt()
>    __hrtimer_run_queues()
>     hrtimer_wakeup()
>      try_to_wake_up()
>       update_rq_clock()
>        sched_clock_cpu()
>         sched_clock()
> 	 kvm_sched_clock_read()
> 	  kvm_clock_read()
> 	   pvclock_clocksource_read()
> 	    pvclock_touch_watchdogs()
> 	     rcu_cpu_stall_reset()       // + the remaining watchdogs
> 
> Or
> 
> do_IRQ
>  irq_exit
>   sched_clock_cpu
>    sched_clock
>     kvm_sched_clock_read
>      kvm_clock_read
>       pvclock_clocksource_read
>        pvclock_touch_watchdogs
>         rcu_cpu_stall_reset()            // + the remaining watchdogs
> 
> And so on...
> 
> You may wonder what are the good news then.
> 
> Well. I'd say that my patch (is not beautiful but it) does not add
> a lot of additional or new damage. And it still fixes the valid race
> condition, as far as I'm concerned.

I have tentatively pulled it in for review and testing.

> I think we need to rework how pvclock_touch_watchdogs() does things
> internally, basically what you suggested, and this can be a separate
> effort.

In the shorter term...  PVCLOCK_GUEST_STOPPED is mostly for things like
guest migration and debugger breakpoints, correct?  Either way, I am
wondering if rcu_cpu_stall_reset() should take a lighter touch.  Right
now, it effectively disables all stalls for the current grace period.
Why not make it restart the stall timeout when the stoppage is detected?

The strange thing is that unless something is updating the jiffies counter
to make it look like the system was up during the stoppage time interval,
there should be no reason to tell RCU anything.  Is the jiffies counter
updated in this manner?  (Not seeing it right offhand, but I don't claim
to be familiar with this code.)

							Thanx, Paul
