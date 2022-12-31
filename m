Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466C6C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLaQS7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 11:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLaQSz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 11:18:55 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167E5FC9
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:18:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so35820612lfa.9
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xAAhDrPXjf74vut+mqAuaSR76XtPp3YWi3/GW1n8ok=;
        b=dj4GZZLEn8+HkeD2IYmYSDh6xdHoeVcudAqkUUcB5GbMdr3WxsidLusa/OMSZzFoXJ
         CYaoQy1rMbkO6NvTYGGzK7vGyF9NY2GYirM3/BA3J8aazX6f7KnZeqWdP/8h71dVjrdu
         CwN9vM8pb8zZcAapF3AGO77NowAcK2wzkkNaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xAAhDrPXjf74vut+mqAuaSR76XtPp3YWi3/GW1n8ok=;
        b=3gJAGgx5T/Km4i690Z6vdG4N2bgeFDqyK66b4NjMhiqdy4bmomETQVEmkiwE3vxBOl
         iD0dHiMYfNprLje2Pxr32fqXJBxJ1z6ZDpJ2eMFxd1lC6Fde/2TaQiRSMFZ8cns85U1x
         Uko3w06o8hiJOhztDa/IOXCOWzvW891G7qScGztYjAIQWv/HNNmYc3prXOvdPFtiHCd0
         cZ7GU9JYeLnwMHbiHqHFONg9doRlR3AZFbGA7+E18MXlzsxRgGqcFzeIKTipils+3FLd
         iuys3xhV1eFef2hLmUxYJ18x3+rPqVSRpDBIF2lDF4rt/L5Jp2i0qX6jJ0UPNPOiOeI8
         Vc5A==
X-Gm-Message-State: AFqh2krkwapljemP4dyZN0ucJ2/7A8f7UnGDSWq+ZMDya51eMIgMlPLq
        gpBRImfLzA2rsVD/vDUjwi0nr9fiXPmL7XBImrWb2Q==
X-Google-Smtp-Source: AMrXdXs/vkYBd6o7F8n8NimY4o7DlVOc20RBHBV1lzDXDzFeQbRskqPSZpX94JqRMTcogBNV7EG06VPHPIUb8sius/I=
X-Received: by 2002:a05:6512:b26:b0:4ca:f6de:1c49 with SMTP id
 w38-20020a0565120b2600b004caf6de1c49mr1156367lfu.582.1672503532390; Sat, 31
 Dec 2022 08:18:52 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
In-Reply-To: <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 31 Dec 2022 16:18:40 +0000
Message-ID: <CAEXW_YSGEYnhMROQWuizY8+UDK8K2bhX6tHBHdBDxV2k3euGEQ@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 4:16 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
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
>
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

Ok found the uninterruptible sleep, it is coming from here:

[ 1359.592979] rcu_tort-160      15d.... 346177086us : <stack trace>
[ 1359.592979]  => __ftrace_trace_stack
[ 1359.592979]  => __schedule
[ 1359.592979]  => schedule
[ 1359.592979]  => schedule_timeout
[ 1359.592979]  => torture_kthread_stopping
[ 1359.592979]  => rcu_torture_reader
[ 1359.592979]  => kthread
[ 1359.592979]  => ret_from_fork

Thoughts?
