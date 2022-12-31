Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD76C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLaQwX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 11:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLaQwX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 11:52:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1765EB
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC79C60A77
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 16:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A83C433D2;
        Sat, 31 Dec 2022 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672505541;
        bh=0gAGPEgX5BuMClKsR014Gm9s5blOGFVnXHezQBcAUOY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T1gTVMoXt0c3cSaoq77QWIxmEsEfTPe2W0SXEAfS+X5wvWejRqqbMSLMlKBvVTaug
         4luqszBuuPKf8cp1feIUVBeSL3/Qz4GAnzP33RuH6F5G0z5eeHKhOlpkg/hikcOIq/
         4otgq7ZBFtFAar2+lbUVYw184I/UvGhEzHNiFJKelt7Z8NEPjd5U0ByfLJQxZ12Unx
         XLFlQnzvVzOYE751lP0G6umyPDetkkwRhy04tI82argIIfH6r8kUBvnMnGvrx6SpFk
         Eq5y1+QT38EyQloisLmJpXQeb3yg6m7Lliuj1IlrXflUV79Wr0ZJJ7hKEAmiW45ODV
         x4P7QUgDsSCCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC4765C0A59; Sat, 31 Dec 2022 08:52:20 -0800 (PST)
Date:   Sat, 31 Dec 2022 08:52:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Message-ID: <20221231165220.GV4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
 <CAEXW_YSGEYnhMROQWuizY8+UDK8K2bhX6tHBHdBDxV2k3euGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSGEYnhMROQWuizY8+UDK8K2bhX6tHBHdBDxV2k3euGEQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 04:18:40PM +0000, Joel Fernandes wrote:
> On Sat, Dec 31, 2022 at 4:16 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Sat, Dec 31, 2022 at 4:07 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sat, Dec 31, 2022 at 12:28:10AM -0500, Joel Fernandes wrote:
> > > > On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I have been firefighting a hang on 6.0.y stable kernels with
> > > > > > rcutorture. It happens mostly consistently when TREE07 is shutting
> > > > > > down.
> > > > > >
> > > > > > It appears that the RCU torture threads are attempted to stop but the
> > > > > > shutdown thread, but are constantly awakened by a timer softirq
> > > > > > handler in ksoftirqd context. When they wake up, they immediately goto
> > > > > > sleep in uninterruptible state until the next time a timer handler
> > > > > > wakes them up. It appears the timer softirq is long enough to cause
> > > > > > RCU stalls and I see it calling 100s of timer function handlers
> > > > > > (call_timer_fn).
> > > > > >
> > > > > > I am doing some more investigation with trace_printk(s):
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> > > > > >
> > > > > > Regarding the timer handlers, I was wondering if it is possible that a
> > > > > > large number of timer handlers constantly queued can cause RCU stalls
> > > > > > due to the timer softirq taking a very long time. That certainly
> > > > > > appears to be the case here. Shouldn't the timer softirq also do
> > > > > > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > > > > > many of them?
> > > > >
> > > > > That is certainly a good thing to try!
> > > >
> > > > I am trying something like this just for testing, let's see what happens ;-)
> > > >
> > > > @@ -1788,9 +1796,14 @@ static inline void __run_timers(struct timer_base *base)
> > > >
> > > >                 while (levels--)
> > > >                         expire_timers(base, heads + levels);
> > >
> > > Might you need to put it inside the body of this "while" loop?
> >
> > I could but even doing the below did not help. Do you see any reason
> > putting inside the loop helps? Let me know.
> >
> > > > +               rcu_softirq_qs();
> > > >         }
> > > >
> > > > I guess I am also wondering why the rcu reader does not stop queuing
> > > > timers. It is doing schedule_timeout_interruptible() constantly even
> > > > though the test is being stopped.
> > >
> > > As in it is doing schedule_timeout_interruptible() in a loop that does
> > > not check torture_must_stop()?  That would be bad unless there is some
> > > reason the loop cannot just stop.  But if the loop cannot just stop,
> > > that leads me to believe that there is a bug elsewhere.  After all, given
> > > that the test is ending, why shouldn't all the loops be able to just stop?
> >
> > Sorry I meant uninterruptible sleep. So
> > schedule_timeout_uninterruptible(). But I still cannot nail where in
> > the torture test it is coming from. Now I put a trace_dump_stack()
> > directly in the schedule loop() and I am hoping it will show:
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index c2bb0cd4225d5..d79bc3b91818a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6390,6 +6390,8 @@ pick_next_task(struct rq *rq, struct task_struct
> > *prev, struct rq_flags *rf)
> > *
> > * WARNING: must be called with preemption disabled!
> > */
> > +static int rcu_tort_ds;
> > +
> > static void __sched notrace __schedule(unsigned int sched_mode)
> > {
> > struct task_struct *prev, *next;
> > @@ -6452,6 +6454,11 @@ static void __sched notrace __schedule(unsigned
> > int sched_mode)
> > if (prev->sched_contributes_to_load)
> > rq->nr_uninterruptible++;
> > + // Dump stack for uninterruptible every 10 stacks.
> > +   if (prev_state & TASK_UNINTERRUPTIBLE && ((rcu_tort_ds++ % 10) == 0)) {
> > +       trace_dump_stack(0);
> > + }
> > +
> > /*
> 
> Ok found the uninterruptible sleep, it is coming from here:
> 
> [ 1359.592979] rcu_tort-160      15d.... 346177086us : <stack trace>
> [ 1359.592979]  => __ftrace_trace_stack
> [ 1359.592979]  => __schedule
> [ 1359.592979]  => schedule
> [ 1359.592979]  => schedule_timeout
> [ 1359.592979]  => torture_kthread_stopping
> [ 1359.592979]  => rcu_torture_reader
> [ 1359.592979]  => kthread
> [ 1359.592979]  => ret_from_fork
> 
> Thoughts?

That is door #3, or a variation on it.  That rcu_torture_reader() task
is waiting to be stopped in torture_kthread_stopping().  The next question
is "why isn't rcu_torture_cleanup() making it to the 'if (reader_tasks)'
code that stops the readers?"

Getting a stack trace of the task executing rcu_torture_cleanup() would
likely be helpful.  Or just check for the console-log messages that it
already emits.  These look like "Stopping rcu_torture_writer task".

							Thanx, Paul
