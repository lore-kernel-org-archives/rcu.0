Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32694C4338F
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 17:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5560F46
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhG3RSG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhG3RSF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Jul 2021 13:18:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A979A60E93;
        Fri, 30 Jul 2021 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627665480;
        bh=DRo2yjn7ZjhRYqZjBVZhU9wmXQ2e5A7P6sYXN+gy2Xg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=N17uVNCC1eq49CzR7MVriN7QvmU63JmO5hqP3lk3ENc7HGl7UOTrzM/J3BB1/0CNA
         XwlWfguUdZfibXW1vjVTBbZEnAXJxcEK4uRvY4CR86XIbkZlHe9jQ8NZB8FNjRHpL7
         Ox7KkqAYH6e97+hh+IjgYmolXJKHk/igJTHSXYa6D9/84Qroe7/crM7VCg6Lr2fsWo
         QRyZpL9JLkMivb1XoKOCDij/lN6PvhW68wPRE97hGcc34d4qI0/gpXAeoTxaSafOn6
         fegTw0jArKf/Q3mzD2EDvOIDGItEtpk0ae54QwdCHOYWcc9G3adFut8WWK9PXX+9mI
         IqzhSBwFflGcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 72B6E5C06D1; Fri, 30 Jul 2021 10:18:00 -0700 (PDT)
Date:   Fri, 30 Jul 2021 10:18:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210730171800.GH4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <YQJfjFv8lOnkUkhs@boqun-archlinux>
 <20210729105331.GA301667@lothringen>
 <YQOUmZmAZQIhjEWC@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQOUmZmAZQIhjEWC@boqun-archlinux>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 30, 2021 at 01:56:41PM +0800, Boqun Feng wrote:
> On Thu, Jul 29, 2021 at 12:53:31PM +0200, Frederic Weisbecker wrote:
> > On Thu, Jul 29, 2021 at 03:58:04PM +0800, Boqun Feng wrote:
> > > > The following litmus test, also adapted from the one supplied off-list
> > > > by Frederic Weisbecker, models the RCU grace-period kthread detecting
> > > > a non-idle CPU that is concurrently transitioning to idle:
> > > > 
> > > > 	C dynticks-into-idle
> > > > 
> > > > 	{
> > > > 		DYNTICKS=1; (* Initially non-idle. *)
> > > > 	}
> > > > 
> > > > 	P0(int *X, int *DYNTICKS)
> > > > 	{
> > > > 		int dynticks;
> > > > 
> > > > 		// Non-idle.
> > > > 		WRITE_ONCE(*X, 1);
> > > > 		dynticks = READ_ONCE(*DYNTICKS);
> > > > 		smp_store_release(DYNTICKS, dynticks + 1);
> > > > 		smp_mb();
> > > 
> > > this smp_mb() is not needed, as we rely on the release-acquire pair to
> > > provide the ordering.
> > > 
> > > This means that if we use different implementations (one w/ smp_mb(),
> > > another w/o) rcu_dynticks_inc() for idle-to-nonidle and nonidle-to-idle,
> > > we could save a smp_mb(). Thoughts?
> > 
> > That's exactly what I wanted to propose but everybody was sober. Namely order
> > only the RCU read side critical sections before/after idle together:
> > 
> >      READ side critical section
> >      //enter idle
> >      //exit idle
> >      smp_mb()
> >      READ side critical section
> > 
> > instead of ordering the RCU read side critical section before idle - with the RCU
> > idle extended quiescent state - with the RCU read side critical section after idle:
> > 
> >      READ side critical section
> >      //enter idle
> >      smp_mb();
> >      //exit idle
> >      smp_mb()
> >      READ side critical section
> > 
> > So the side effect now is that if the write side waits for the reader to
> > report a quiescent state and scans its dynticks state and see it's not yet in
> > RCU idle mode, then later on when the read side enters in RCU idle mode we
> > expect it to see the write side updates.
> > But after the barrier removal the reader will only see the write side update
> > once we exit RCU idle mode.
> > 
> > So the following may happen:
> > 
> > 	P0(int *X, int *Y, int *DYNTICKS)
> > 	{
> > 		int y;
> > 
> > 		WRITE_ONCE(*X, 1);
> > 		smp_store_release(DYNTICKS, 1); // rcu_eqs_enter
> > 		//smp_mb() not there anymore
> > 		y = READ_ONCE(*Y);
> > 		smp_store_release(DYNTICKS, 2); // rcu_eqs_exit()
> > 		smp_mb();
> > 	}
> > 
> > 	P1(int *X, int *Y, int *DYNTICKS)
> > 	{
> > 		int x;
> > 		int dynticks;
> > 		
> > 		WRITE_ONCE(*Y, 1);
> > 		smp_mb();
> > 		dynticks = smp_load_acquire(DYNTICKS);
> > 		x = READ_ONCE(*X);
> > 	}
> > 
> > 	exists (1:x=0 /\ 0:y=0)
> > 
> 
> Thanks for the detailed explanation ;-)
> 
> > Theoretically it shouldn't matter because the RCU idle mode isn't
> > supposed to perform RCU reads. But theoretically again once a CPU
> 
> Right, in LOCKDEP=y kernel, rcu_read_lock_held() requires
> rcu_is_watching(), so rcu_dereference() is not allowed in idle mode,
> unless using RCU_NONIDLE() or rcu_irq_enter_irqson() to temporarily exit
> the idle mode.
> 
> > has reported a quiescent state, any further read is expected to see
> > the latest updates from the write side.
> 
> Yes, but in your above case, doesn't P0 already reach to a quiescent
> state even before WRITE_ONCE()? IOW, that case is similar to the
> following:
> 
> 	P0(int *X, int *Y)
> 	{
> 		// in QS
> 
> 		WRITE_ONCE(*X, 1);
> 		y = READ_ONCE(*Y);
> 	}
> 
> 	P1(int *X, int *Y)
> 	{
> 		WRITE_ONCE(*Y, 1);
> 		synchronize_rcu();
> 		x = READ_ONCE(*X);
> 	}
> 
> 	exists (1:x=0 /\ 0:y=0)
> 
> And RCU doesn't guarantee the READ_ONCE() on P0 sees the WRITE_ONCE() on
> P1.
> 
> > 
> > So I don't know what to think. In practice I believe it's not a big deal
> > because RCU idle mode code is usually a fragile path that just handles
> > cpuidle code to put the CPU in/out low power mode. But what about dragons...
> 
> My current thought is that if the cpuidle code requires some ordering
> with synchronize_rcu(), RCU_NONIDLE() should be used, and ordering can
> be guaranteed in this case (RCU_NONIDLE() has a rcu_eqs_exit() in it).
> Otherwise, it's a bug.
> 
> So looks like we can drop that smp_mb() in rcu_eqs_enter()? At least, we
> can say something in the doc to prevent people from relying on the
> ordering between normal reads in RCU idle mode and synchronize_rcu().
> 
> Thoughts?

Is there a benchmark that can show a system-level difference?  My
guess is that the realtime interrupt-latency and scheduler-latency
benchmarks would have the best chance of seeing this.

							Thanx, Paul
