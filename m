Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F4C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 21:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLaVtQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 16:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaVtP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 16:49:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451906472
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 13:49:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so36564820lfb.1
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 13:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/mE4nOidqN4pUHurlqzOCbLBEBzjdm3WeEYYC3+RiU=;
        b=jtEPVoI9TeZd97TeJoSwQ7lkAbkQRz7EKU82SIgEhcM6o/4cioyNujomqr46tM/Pjw
         O/1Lif/GX/kngAFM3n4c7KgQfEcRbhpo9aC97z4YWYXfaERPWKu3fQQ3E43O/TazBtMh
         QRMxkGRYwUxaRc1fwu+8JhsE51mr6WXKlKvxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/mE4nOidqN4pUHurlqzOCbLBEBzjdm3WeEYYC3+RiU=;
        b=myUNyhWNsF8SUzJFQvh5HTA+dxfbVPEhoXy+K6GXhRduw/jLgXGT0VWQGFJttmZ4Ox
         kyUAdPI+bfbSQ+uBeL45QMu1yFoGcg4CGQd7xVh4fQzYRJnErthCNSJjiG6rC/j0ib8/
         GFMZTSesb4JwmEclJnQs68hRz4V2WgrxJ0ggteGa0dL8Vqxsn8RWOesFC9sLMwVf6ebJ
         sRhTYjKbGvwF4QHMlQtcHIeOkV14ypYjXgiH+EHIfR2vvJMRQi5MvMcG1MtrIZZ6H12l
         gUTiigSYF1m/gqHzilRBVMgwo8ufbdwXxb4Lyz33hH91J3ZRyw4KS80A7GArcTZlSVKu
         isGQ==
X-Gm-Message-State: AFqh2kqEsV2hCdaoUdQWc/+bztBV5MsJVzBOn5yuUdu877dyWLMcgVvH
        yJo0hhVjZhixott9Z+GUtoko8Tgv6rnIvzxuRyl2Sg==
X-Google-Smtp-Source: AMrXdXtCQrpFAspkxOuWqC0eASc3mIYpDXmHGknKao0d8BRZ5Szk7YkE4D9XH+j+d8JTGQlby6vXTZrVcKX9nucPz1E=
X-Received: by 2002:ac2:59ca:0:b0:4cb:3b:846e with SMTP id x10-20020ac259ca000000b004cb003b846emr929744lfn.128.1672523348525;
 Sat, 31 Dec 2022 13:49:08 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YR+FCLUoXH=ND=qSU4Bt9f8LpaR+qXKVf204RKXZZY9Tw@mail.gmail.com>
 <20221231021410.GP4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YStxQFB1qRyHhqFE_hjeO2f+_U-=KY07SewM0LHWv2Q+g@mail.gmail.com>
 <20221231160755.GR4001@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YQQphezde-o4OrzUSr42BFd-gtcJ6V9d5WG5aXVDU8VxA@mail.gmail.com>
 <20221231164650.GU4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221231164650.GU4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 31 Dec 2022 16:49:02 -0500
Message-ID: <CAEXW_YT9dAUc69igExbL0OC4C_Re58uvQ=oa3s2CQZ_xbefMQQ@mail.gmail.com>
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
To:     paulmck@kernel.org
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Dec 31, 2022 at 11:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Dec 31, 2022 at 04:16:25PM +0000, Joel Fernandes wrote:
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
>
> OK, inside expires_timers()?  But that might be a bit intrusive.
>
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
> > * __schedule() ttwu()
> > * prev_state = prev->state; if (p->on_rq && ...
> >
> > I agree with you, it could be that the loops in the test stop but
> > something else in the kernel is looping (via an API that the test
> > called), which is doing uninterruptible sleep loops. Weird indeed.
> >
> > > (Maybe it is waiting on a buggy child task, for example.)
> >
> > Hmm, it is the kernel threads (rcu_torture_read,
> > rcu_torture_fakewriter etc) though, not userspace, that are
> > waking/sleeping.
> >
> > keep you posted, thanks,
>
> schedule_timeout_uninterruptible(), you say?
>
> There is a candidate in rcu_torture_stall(), but one could argue that
> making a stall overlap the end of the test is a user error.  (Would
> not hurt to fix, though.)
>
> There are some candidates in rcu_torture_read_exit(), which are waiting
> on read_exit_child_stop to be set.  Except that this variable is set
> before rcu_torture_cleanup() attempts to stop the readers and fakewriters.
> But maybe the cleanup protocol needs to be less hacky.
>
> If you see "parking due to system shutdown" on the console, then maybe
> there is some confusion in the calls to torture_shutdown_absorb().
>
I don't see that but I see this before the stall:
 rcu-torture: torture_shutdown task shutting down system

> Hmmm...  Some of the tasks run at relatively high priority.  Maybe they
> need to de-prioritize themselves before looping waiting to be stopped.
> These loops look like this:
>
>         while (!kthread_should_stop()) {
>                 torture_shutdown_absorb("rcu_torture_boost");
>                 schedule_timeout_uninterruptible(1);
>         }

Yes, it appears this tight loop is live locked with the timer softirq.
I am trying a run with higher timeout to see if it helps.

>
> Or it might be something else...

I see that kthread_should_stop() returns false, but
torture_must_stop_irq() returns true in the tight while loop mentioned
above. So it seems like the shutdown notifier triggered first. I am
seeing various "is stopping" messages. However I see no "End-test"
messages, which means I think the torture_shutdown_hook() never ran
properly, or something. Anyway now I am doing heavy tracing in
rcu_torture_cleanup() to see what it is upto. My suspicion is it did
not even call torture_stop_kthread() and we are stuck without the
kthreads being stopped.

Thanks.
