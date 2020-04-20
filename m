Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC393C54FCB
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 01:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3BB21974
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 01:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YpnksD9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDTBRw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgDTBRw (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sun, 19 Apr 2020 21:17:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6DC061A0C
        for <rcu@vger.kernel.org>; Sun, 19 Apr 2020 18:17:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so9025942qkg.1
        for <rcu@vger.kernel.org>; Sun, 19 Apr 2020 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyrP9WTJWbLpQ+ACpS9TPWrjj1qr7p7/wIvEBDYQHtY=;
        b=YpnksD9KlPFCZmw3cI7A8mPIlIn677+cydopbBLsR+2d8PEOjtrlXdDvfFCpfR6PfD
         Kc4XGxQsou71Rww9XckdyD70HKCUf1yJJ6C4euQxoX0jGw7ike5F0JX4Lfb39r0dor36
         BUiAXrppsvgcocaxlmARiVgBb+CR8jpZJSeAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyrP9WTJWbLpQ+ACpS9TPWrjj1qr7p7/wIvEBDYQHtY=;
        b=nlTLNTKz+XFQcUN0lBsEDkN4Ba7PFqxELBz5EUEo7/gPjVOOIfNwCs72kV6blkD3Ne
         WT/MAdaEvxZQIylJ9gc50EAEPBPYM33+5Xb0M5VzvxD8aiyjWMzdE6q8qRukC12VP424
         mhe/TKOuA80e+GmEH5Y27+9VVLY8Ui9eZgzxhvf0RrWH0ebChntgWIVkZcObGk4P/S/i
         SIjoyK4b7aTpSZ5nHVLRTDJIseH6JVAzImlmFIf299nN6xpd1vP57ftm27tnPbKUplaB
         S4m5pHWltTVWCEMPW9/64Yffd3rPootKPcU01GlUBEFREFEQ4U1ut7YaaF7pWud6ux4e
         pJGQ==
X-Gm-Message-State: AGi0PubCHF3NTnfAlxW+a4edcDrMpcpXjmYnX0dI5pC1sWtn9yJCvH8Y
        KyOO5UGOKNRo8zfZQY3RuVjzhEo7zu8=
X-Google-Smtp-Source: APiQypLq/jx+InNdy18u5kEdRe5EZ/Cay4RqAtuOir4YQkzhzs8KxQHK3RWRn+qs1OzwfsHBl4UnbA==
X-Received: by 2002:a37:7906:: with SMTP id u6mr13048610qkc.489.1587345470898;
        Sun, 19 Apr 2020 18:17:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j92sm17542843qtd.58.2020.04.19.18.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 18:17:50 -0700 (PDT)
Date:   Sun, 19 Apr 2020 21:17:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200420011749.GF176663@google.com>
References: <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
 <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
 <20200417182641.GB168907@google.com>
 <20200417185449.GM17661@paulmck-ThinkPad-P72>
 <20200418123748.GA3306@pc636>
 <20200419145836.GS17661@paulmck-ThinkPad-P72>
 <20200420002713.GA160606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420002713.GA160606@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Apr 19, 2020 at 08:27:13PM -0400, Joel Fernandes wrote:
> On Sun, Apr 19, 2020 at 07:58:36AM -0700, Paul E. McKenney wrote:
> > On Sat, Apr 18, 2020 at 02:37:48PM +0200, Uladzislau Rezki wrote:
> > > On Fri, Apr 17, 2020 at 11:54:49AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Apr 17, 2020 at 02:26:41PM -0400, Joel Fernandes wrote:
> > > > > On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> > > > > > > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > > > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > > > > > > > 
> > > > > > > > > We might need different calling-context restrictions for the two variants
> > > > > > > > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > > > > > > > check for "safe to use normal spinlock in -rt".
> > > > > > > > 
> > > > > > > > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > > > > > > > This one will scream if you do
> > > > > > > > 	raw_spin_lock();
> > > > > > > > 	spin_lock();
> > > > > > > > 
> > > > > > > > Sadly, as of today, there is code triggering this which needs to be
> > > > > > > > addressed first (but it is one list of things to do).
> > > > > > > > 
> > > > > > > > Given the thread so far, is it okay if I repost the series with
> > > > > > > > migrate_disable() instead of accepting a possible migration before
> > > > > > > > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > > > > > > > memory allocations in a possible atomic context) until we get there.
> > > > > > > 
> > > > > > > I prefer something like the following to make it possible to invoke
> > > > > > > kfree_rcu() from atomic context considering call_rcu() is already callable
> > > > > > > from such contexts. Thoughts?
> > > > > > 
> > > > > > So it looks like it would work. However, could we please delay this
> > > > > > until we have an actual case on RT? I just added
> > > > > > 	WARN_ON(!preemptible());
> > > > > 
> > > > > I am not sure if waiting for it to break in the future is a good idea. I'd
> > > > > rather design it in a forward thinking way. There could be folks replacing
> > > > > "call_rcu() + kfree in a callback" with kfree_rcu() for example. If they were
> > > > > in !preemptible(), we'd break on page allocation.
> > > > > 
> > > > > Also as a sidenote, the additional pre-allocation of pages that Vlad is
> > > > > planning on adding would further reduce the need for pages from the page
> > > > > allocator.
> > > > > 
> > > > > Paul, what is your opinion on this?
> > > > 
> > > > My experience with call_rcu(), of which kfree_rcu() is a specialization,
> > > > is that it gets invoked with preemption disabled, with interrupts
> > > > disabled, and during early boot, as in even before rcu_init() has been
> > > > invoked.  This experience does make me lean towards raw spinlocks.
> > > > 
> > > > But to Sebastian's point, if we are going to use raw spinlocks, we need
> > > > to keep the code paths holding those spinlocks as short as possible.
> > > > I suppose that the inability to allocate memory with raw spinlocks held
> > > > helps, but it is worth checking.
> > > >
> > > How about reducing the lock contention even further?
> > 
> > Can we do even better by moving the work-scheduling out from under the
> > spinlock?  This of course means that it is necessary to handle the
> > occasional spurious call to the work handler, but that should be rare
> > and should be in the noise compared to the reduction in contention.
> 
> Yes I think that will be required since -rt will sleep on workqueue locks as
> well :-(. I'm looking into it right now.
> 
>         /*
>          * If @work was previously on a different pool, it might still be
>          * running there, in which case the work needs to be queued on that
>          * pool to guarantee non-reentrancy.
>          */
>         last_pool = get_work_pool(work);
>         if (last_pool && last_pool != pwq->pool) {
>                 struct worker *worker;
> 
>                 spin_lock(&last_pool->lock);

Hmm, I think moving schedule_delayed_work() outside lock will work. Just took
a good look and that's not an issue. However calling schedule_delayed_work()
itself is an issue if the caller of kfree_rcu() is !preemptible() on
PREEMPT_RT. Because the schedule_delayed_work() calls spin_lock on pool->lock
which can sleep on PREEMPT_RT :-(. Which means we have to do either of:

1. Implement a new mechanism for scheduling delayed work that does not
   acquire sleeping locks.

2. Allow kfree_rcu() only from preemptible context (That is Sebastian's
   initial patch to replace local_irq_save() + spin_lock() with
   spin_lock_irqsave()).

3. Queue the work through irq_work or another bottom-half mechanism.

Any other thoughts?

thanks,

 - Joel


> 
> Thanks!
> 
>  - Joel
> 
> 
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> > 
> > > <snip>
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index f288477ee1c2..fb916e065784 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3053,7 +3053,8 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> > > 
> > >         // Previous RCU batch still in progress, try again later.
> > >         krcp->monitor_todo = true;
> > > -       schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > > +       schedule_delayed_work_on(raw_smp_processor_id(),
> > > +               &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > >         spin_unlock_irqrestore(&krcp->lock, flags);
> > >  }
> > > 
> > > @@ -3168,7 +3169,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > >             !krcp->monitor_todo) {
> > >                 krcp->monitor_todo = true;
> > > -               schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > > +               schedule_delayed_work_on(raw_smp_processor_id(),
> > > +                       &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> > >         }
> > > 
> > >  unlock_return:
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 891ccad5f271..49fcc50469f4 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -1723,7 +1723,9 @@ static void rcu_work_rcufn(struct rcu_head *rcu)
> > > 
> > >         /* read the comment in __queue_work() */
> > >         local_irq_disable();
> > > -       __queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
> > > +
> > > +       /* Just for illustration. Can have queue_rcu_work_on(). */
> > > +       __queue_work(raw_smp_processor_id(), rwork->wq, &rwork->work);
> > >         local_irq_enable();
> > >  }
> > > <snip>
> > > 
> > > Thoughts?
> > > 
> > > --
> > > Vlad Rezki
