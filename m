Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C72C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiLaQrJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 11:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiLaQqy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 11:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F46A194
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53BA260BFF
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 16:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF6BC433EF;
        Sat, 31 Dec 2022 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672505210;
        bh=AoFbzk9o3jMCCiTx3iazSLAEIiTSsp/sI9df+3U9WlM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KUgzmdBUzjLyXHkYK3LDxZiIR6t3F+Yse36syygjl/4rhIsboonI39Z9tSLhIPHTz
         Z/2gH0Nn4RvuWLK8gtQlxkKfv9bmBpEU89wbTf6UTo5xjGieYSIOIOVR4YoN14BiKw
         YVU84Vj61qeub2kj9+HXCVt1PJ/n6m934kGxey5q7xt3E0IYj7VeOycFGTPZHnPMwL
         RkZmqVJZlut/2NXo8Rjk2xjPuK6+o28Wr8uvx8z3ZPvxgIg3raQfqSWmAB3AHF2MKc
         tMrOffQW1ycRbeAWtj0oa+aY3f4SN5Zq6l4rjIFeI5zmJEjywkSdyhzKw5pPA7ypyz
         IaDB74bXoivTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5BE8A5C0A59; Sat, 31 Dec 2022 08:46:50 -0800 (PST)
Date:   Sat, 31 Dec 2022 08:46:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Message-ID: <20221231164650.GU4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 04:16:25PM +0000, Joel Fernandes wrote:
> On Sat, Dec 31, 2022 at 4:07 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Dec 31, 2022 at 12:28:10AM -0500, Joel Fernandes wrote:
> > > On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
> > > > > Hello,
> > > > >
> > > > > I have been firefighting a hang on 6.0.y stable kernels with
> > > > > rcutorture. It happens mostly consistently when TREE07 is shutting
> > > > > down.
> > > > >
> > > > > It appears that the RCU torture threads are attempted to stop but the
> > > > > shutdown thread, but are constantly awakened by a timer softirq
> > > > > handler in ksoftirqd context. When they wake up, they immediately goto
> > > > > sleep in uninterruptible state until the next time a timer handler
> > > > > wakes them up. It appears the timer softirq is long enough to cause
> > > > > RCU stalls and I see it calling 100s of timer function handlers
> > > > > (call_timer_fn).
> > > > >
> > > > > I am doing some more investigation with trace_printk(s):
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> > > > >
> > > > > Regarding the timer handlers, I was wondering if it is possible that a
> > > > > large number of timer handlers constantly queued can cause RCU stalls
> > > > > due to the timer softirq taking a very long time. That certainly
> > > > > appears to be the case here. Shouldn't the timer softirq also do
> > > > > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > > > > many of them?
> > > >
> > > > That is certainly a good thing to try!
> > >
> > > I am trying something like this just for testing, let's see what happens ;-)
> > >
> > > @@ -1788,9 +1796,14 @@ static inline void __run_timers(struct timer_base *base)
> > >
> > >                 while (levels--)
> > >                         expire_timers(base, heads + levels);
> >
> > Might you need to put it inside the body of this "while" loop?
> 
> I could but even doing the below did not help. Do you see any reason
> putting inside the loop helps? Let me know.

OK, inside expires_timers()?  But that might be a bit intrusive.

> > > +               rcu_softirq_qs();
> > >         }
> > >
> > > I guess I am also wondering why the rcu reader does not stop queuing
> > > timers. It is doing schedule_timeout_interruptible() constantly even
> > > though the test is being stopped.
> >
> > As in it is doing schedule_timeout_interruptible() in a loop that does
> > not check torture_must_stop()?  That would be bad unless there is some
> > reason the loop cannot just stop.  But if the loop cannot just stop,
> > that leads me to believe that there is a bug elsewhere.  After all, given
> > that the test is ending, why shouldn't all the loops be able to just stop?
> 
> Sorry I meant uninterruptible sleep. So
> schedule_timeout_uninterruptible(). But I still cannot nail where in
> the torture test it is coming from. Now I put a trace_dump_stack()
> directly in the schedule loop() and I am hoping it will show:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c2bb0cd4225d5..d79bc3b91818a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6390,6 +6390,8 @@ pick_next_task(struct rq *rq, struct task_struct
> *prev, struct rq_flags *rf)
> *
> * WARNING: must be called with preemption disabled!
> */
> +static int rcu_tort_ds;
> +
> static void __sched notrace __schedule(unsigned int sched_mode)
> {
> struct task_struct *prev, *next;
> @@ -6452,6 +6454,11 @@ static void __sched notrace __schedule(unsigned
> int sched_mode)
> if (prev->sched_contributes_to_load)
> rq->nr_uninterruptible++;
> + // Dump stack for uninterruptible every 10 stacks.
> +   if (prev_state & TASK_UNINTERRUPTIBLE && ((rcu_tort_ds++ % 10) == 0)) {
> +       trace_dump_stack(0);
> + }
> +
> /*
> * __schedule() ttwu()
> * prev_state = prev->state; if (p->on_rq && ...
> 
> I agree with you, it could be that the loops in the test stop but
> something else in the kernel is looping (via an API that the test
> called), which is doing uninterruptible sleep loops. Weird indeed.
> 
> > (Maybe it is waiting on a buggy child task, for example.)
> 
> Hmm, it is the kernel threads (rcu_torture_read,
> rcu_torture_fakewriter etc) though, not userspace, that are
> waking/sleeping.
> 
> keep you posted, thanks,

schedule_timeout_uninterruptible(), you say?

There is a candidate in rcu_torture_stall(), but one could argue that
making a stall overlap the end of the test is a user error.  (Would
not hurt to fix, though.)

There are some candidates in rcu_torture_read_exit(), which are waiting
on read_exit_child_stop to be set.  Except that this variable is set
before rcu_torture_cleanup() attempts to stop the readers and fakewriters.
But maybe the cleanup protocol needs to be less hacky.

If you see "parking due to system shutdown" on the console, then maybe
there is some confusion in the calls to torture_shutdown_absorb().

Hmmm...  Some of the tasks run at relatively high priority.  Maybe they
need to de-prioritize themselves before looping waiting to be stopped.
These loops look like this:

	while (!kthread_should_stop()) {
		torture_shutdown_absorb("rcu_torture_boost");
		schedule_timeout_uninterruptible(1);
	}

Or it might be something else...

							Thanx, Paul
