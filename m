Return-Path: <SRS0=xcwz=6D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2499C38A30
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9018321973
	for <rcu@archiver.kernel.org>; Sun, 19 Apr 2020 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587308317;
	bh=zhx5jyEEWWUvT0W+wcXJf5McdOJ9DuVLWHzk4Y8bM3g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MSPbicV2fsLM8i4xaKzvY191Mtw+/uWhuC6UPZfXFm8mUDjeyStkFEv2ZAZRClea1
	 1flRWLUgBTD6PZ6nTdW05Fef4ppzeKHygJ/KYQvTw+xWCecx1iSrfa80P6l6fI8Oly
	 VmZQ2wq+H7cr+xLkGQihs3IbVS5v1GchXymEUldY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSO6h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgDSO6h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Apr 2020 10:58:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5745121841;
        Sun, 19 Apr 2020 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308316;
        bh=zhx5jyEEWWUvT0W+wcXJf5McdOJ9DuVLWHzk4Y8bM3g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Gxl1N+i75c9VmWan6dz+H7FYVHNZisJPf3Z3MpQ0oko9sS7ePRI6EpEiYCvyf/U/O
         FuzWRmND2x98O3NrR6Y5SiV85dZIWkVE8wx+GGflsysy5bufqSylJ6+MAb7Solm9cy
         1obcaaSAEx25Modsp1hEFEVanP/RvZTL7S/T7nKY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 258F235226A1; Sun, 19 Apr 2020 07:58:36 -0700 (PDT)
Date:   Sun, 19 Apr 2020 07:58:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200419145836.GS17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
 <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
 <20200417182641.GB168907@google.com>
 <20200417185449.GM17661@paulmck-ThinkPad-P72>
 <20200418123748.GA3306@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418123748.GA3306@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Apr 18, 2020 at 02:37:48PM +0200, Uladzislau Rezki wrote:
> On Fri, Apr 17, 2020 at 11:54:49AM -0700, Paul E. McKenney wrote:
> > On Fri, Apr 17, 2020 at 02:26:41PM -0400, Joel Fernandes wrote:
> > > On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> > > > > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > > > > > 
> > > > > > > We might need different calling-context restrictions for the two variants
> > > > > > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > > > > > check for "safe to use normal spinlock in -rt".
> > > > > > 
> > > > > > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > > > > > This one will scream if you do
> > > > > > 	raw_spin_lock();
> > > > > > 	spin_lock();
> > > > > > 
> > > > > > Sadly, as of today, there is code triggering this which needs to be
> > > > > > addressed first (but it is one list of things to do).
> > > > > > 
> > > > > > Given the thread so far, is it okay if I repost the series with
> > > > > > migrate_disable() instead of accepting a possible migration before
> > > > > > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > > > > > memory allocations in a possible atomic context) until we get there.
> > > > > 
> > > > > I prefer something like the following to make it possible to invoke
> > > > > kfree_rcu() from atomic context considering call_rcu() is already callable
> > > > > from such contexts. Thoughts?
> > > > 
> > > > So it looks like it would work. However, could we please delay this
> > > > until we have an actual case on RT? I just added
> > > > 	WARN_ON(!preemptible());
> > > 
> > > I am not sure if waiting for it to break in the future is a good idea. I'd
> > > rather design it in a forward thinking way. There could be folks replacing
> > > "call_rcu() + kfree in a callback" with kfree_rcu() for example. If they were
> > > in !preemptible(), we'd break on page allocation.
> > > 
> > > Also as a sidenote, the additional pre-allocation of pages that Vlad is
> > > planning on adding would further reduce the need for pages from the page
> > > allocator.
> > > 
> > > Paul, what is your opinion on this?
> > 
> > My experience with call_rcu(), of which kfree_rcu() is a specialization,
> > is that it gets invoked with preemption disabled, with interrupts
> > disabled, and during early boot, as in even before rcu_init() has been
> > invoked.  This experience does make me lean towards raw spinlocks.
> > 
> > But to Sebastian's point, if we are going to use raw spinlocks, we need
> > to keep the code paths holding those spinlocks as short as possible.
> > I suppose that the inability to allocate memory with raw spinlocks held
> > helps, but it is worth checking.
> >
> How about reducing the lock contention even further?

Can we do even better by moving the work-scheduling out from under the
spinlock?  This of course means that it is necessary to handle the
occasional spurious call to the work handler, but that should be rare
and should be in the noise compared to the reduction in contention.

Thoughts?

							Thanx, Paul

> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f288477ee1c2..fb916e065784 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3053,7 +3053,8 @@ static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
> 
>         // Previous RCU batch still in progress, try again later.
>         krcp->monitor_todo = true;
> -       schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +       schedule_delayed_work_on(raw_smp_processor_id(),
> +               &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>         spin_unlock_irqrestore(&krcp->lock, flags);
>  }
> 
> @@ -3168,7 +3169,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>             !krcp->monitor_todo) {
>                 krcp->monitor_todo = true;
> -               schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
> +               schedule_delayed_work_on(raw_smp_processor_id(),
> +                       &krcp->monitor_work, KFREE_DRAIN_JIFFIES);
>         }
> 
>  unlock_return:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 891ccad5f271..49fcc50469f4 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1723,7 +1723,9 @@ static void rcu_work_rcufn(struct rcu_head *rcu)
> 
>         /* read the comment in __queue_work() */
>         local_irq_disable();
> -       __queue_work(WORK_CPU_UNBOUND, rwork->wq, &rwork->work);
> +
> +       /* Just for illustration. Can have queue_rcu_work_on(). */
> +       __queue_work(raw_smp_processor_id(), rwork->wq, &rwork->work);
>         local_irq_enable();
>  }
> <snip>
> 
> Thoughts?
> 
> --
> Vlad Rezki
