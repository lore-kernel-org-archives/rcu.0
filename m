Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A5C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 16:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLaQQl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 11:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLaQQk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 11:16:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C65FEC
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:16:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p36so35792755lfa.12
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vov14gFSVOPAR8V0SEH7e940u9CirjyMaFPWziKu6do=;
        b=ktI2PeCD5k0PEXZaLjyF/nneU/U+sKPYqPXi2EOgHUeEfcBdVH8rMdLtVJafnu0sN6
         Gs2sG+kuV3lFkjiqtN4ZV1ip7EotY3T8OlmXIsL6iFxMhl9hGE9J4dtwT5Jv+FbVC1DM
         zKhcBSdFMlKed9e/iGBiaK6OcXsoaexwJIlL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vov14gFSVOPAR8V0SEH7e940u9CirjyMaFPWziKu6do=;
        b=dDisErWdld6/djXj8HtQYpiT+xMqFw/JErg4DIE1jTGIkZPim+q6VhxE52RqeWtlVi
         ddkacIMjGmhS2GluH9MWfO2GCAzY0EO9YXfXA7e6y+ZAH3ymOL1KMZTecJ5Fi8bUoZhu
         hMJJcS6PDvr4Exn8euqj0Uxd7gPAwwW7i1JOB82e6WdKqCQAuoJybLHIib9GkAaKwriA
         7ZNVT0uS3HECnzaC/QpJ6D2A6e/zSBwhFNQx5yrDUtL9dgEVgSMWSnUJFgjlzCJrv1j8
         vjMBvafgVd5W0cq8LgH6UgUpPFhiwY/QWn+6LnP4fFpAMEuiI/zVFlp2aR58oe9VX+89
         YIRg==
X-Gm-Message-State: AFqh2koqazyZ+17RaGKpz/HO5nlj+thqb9rzPgPBiHHYDL61dEw+VK9Z
        vTLkodOchrQHmH7NCIrXtgzfboKAFbpqnnQcjdE+hUJcHeOdq74Q
X-Google-Smtp-Source: AMrXdXuF8xWKPcaGpIf0KG6o6Tf9mFxkKE3ZbEYTX8XVCa+iMrtGi6B/QvQ9+l2jujPr/ZOF6DCi5ARX6S4XfiylokY=
X-Received: by 2002:ac2:5985:0:b0:4ca:fa1b:ebc7 with SMTP id
 w5-20020ac25985000000b004cafa1bebc7mr1072794lfn.169.1672503396874; Sat, 31
 Dec 2022 08:16:36 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 31 Dec 2022 16:16:25 +0000
Message-ID: <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 4:07 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Dec 31, 2022 at 12:28:10AM -0500, Joel Fernandes wrote:
> > On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
> > > > Hello,
> > > >
> > > > I have been firefighting a hang on 6.0.y stable kernels with
> > > > rcutorture. It happens mostly consistently when TREE07 is shutting
> > > > down.
> > > >
> > > > It appears that the RCU torture threads are attempted to stop but the
> > > > shutdown thread, but are constantly awakened by a timer softirq
> > > > handler in ksoftirqd context. When they wake up, they immediately goto
> > > > sleep in uninterruptible state until the next time a timer handler
> > > > wakes them up. It appears the timer softirq is long enough to cause
> > > > RCU stalls and I see it calling 100s of timer function handlers
> > > > (call_timer_fn).
> > > >
> > > > I am doing some more investigation with trace_printk(s):
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=stable/trace-hang-6.0.y&id=b779b1e92c97f29333a282ee8f548da02f64de2b
> > > >
> > > > Regarding the timer handlers, I was wondering if it is possible that a
> > > > large number of timer handlers constantly queued can cause RCU stalls
> > > > due to the timer softirq taking a very long time. That certainly
> > > > appears to be the case here. Shouldn't the timer softirq also do
> > > > rcu_softirq_qs() similar to the ksoftirq loop, in case there are too
> > > > many of them?
> > >
> > > That is certainly a good thing to try!
> >
> > I am trying something like this just for testing, let's see what happens ;-)
> >
> > @@ -1788,9 +1796,14 @@ static inline void __run_timers(struct timer_base *base)
> >
> >                 while (levels--)
> >                         expire_timers(base, heads + levels);
>
> Might you need to put it inside the body of this "while" loop?

I could but even doing the below did not help. Do you see any reason
putting inside the loop helps? Let me know.

> > +               rcu_softirq_qs();
> >         }
> >
> > I guess I am also wondering why the rcu reader does not stop queuing
> > timers. It is doing schedule_timeout_interruptible() constantly even
> > though the test is being stopped.
>
> As in it is doing schedule_timeout_interruptible() in a loop that does
> not check torture_must_stop()?  That would be bad unless there is some
> reason the loop cannot just stop.  But if the loop cannot just stop,
> that leads me to believe that there is a bug elsewhere.  After all, given
> that the test is ending, why shouldn't all the loops be able to just stop?

Sorry I meant uninterruptible sleep. So
schedule_timeout_uninterruptible(). But I still cannot nail where in
the torture test it is coming from. Now I put a trace_dump_stack()
directly in the schedule loop() and I am hoping it will show:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c2bb0cd4225d5..d79bc3b91818a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6390,6 +6390,8 @@ pick_next_task(struct rq *rq, struct task_struct
*prev, struct rq_flags *rf)
*
* WARNING: must be called with preemption disabled!
*/
+static int rcu_tort_ds;
+
static void __sched notrace __schedule(unsigned int sched_mode)
{
struct task_struct *prev, *next;
@@ -6452,6 +6454,11 @@ static void __sched notrace __schedule(unsigned
int sched_mode)
if (prev->sched_contributes_to_load)
rq->nr_uninterruptible++;
+ // Dump stack for uninterruptible every 10 stacks.
+   if (prev_state & TASK_UNINTERRUPTIBLE && ((rcu_tort_ds++ % 10) == 0)) {
+       trace_dump_stack(0);
+ }
+
/*
* __schedule() ttwu()
* prev_state = prev->state; if (p->on_rq && ...

I agree with you, it could be that the loops in the test stop but
something else in the kernel is looping (via an API that the test
called), which is doing uninterruptible sleep loops. Weird indeed.

> (Maybe it is waiting on a buggy child task, for example.)

Hmm, it is the kernel threads (rcu_torture_read,
rcu_torture_fakewriter etc) though, not userspace, that are
waking/sleeping.

keep you posted, thanks,

-  Joel
