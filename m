Return-Path: <SRS0=YgaY=B7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC68C433E1
	for <rcu@archiver.kernel.org>; Fri, 21 Aug 2020 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39792078B
	for <rcu@archiver.kernel.org>; Fri, 21 Aug 2020 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598024016;
	bh=XSyUhUqo+Gos2SbGp1YxB7LP27cXAxleYAB8qOo6Z+c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=coykM7Cf0Jzd98WuXYwqYwWO2PDsRMd/6elONnEyTKgqZ3MELOGd+S0KX+JQVAZm9
	 nKbWRaY/dCuWp1HNoxDfFQG67c7dEVWsnJu+Cr53CM7B83vVvMre41mXTv74j5KmEQ
	 dPI7o5RWJVVXnkgmLSsqlqNUrR0Hm6218ck3IOco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgHUPde (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgHUPd3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 Aug 2020 11:33:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB6F2063A;
        Fri, 21 Aug 2020 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598024008;
        bh=XSyUhUqo+Gos2SbGp1YxB7LP27cXAxleYAB8qOo6Z+c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rhgqW/Px3ewREPr6Shn75ttm9S6U+BsOszbR5E3byLWimS0DkbjrJWthRmRUJ7ih5
         hbVYkq5UereKHbEkQ6EgHnUz+F2wlQDl8gUiAuzXIb6H4UJ9U6eDPwMFoRpjdEpKtg
         4NOLrIcAVm/ETiiy8mEAAC3ItX9gbmJFbOyuw6/0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6B7CD35227D4; Fri, 21 Aug 2020 08:33:28 -0700 (PDT)
Date:   Fri, 21 Aug 2020 08:33:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200821153328.GH2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72>
 <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820223957.GB120898@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 20, 2020 at 06:39:57PM -0400, Joel Fernandes wrote:
> On Wed, Aug 19, 2020 at 05:58:08PM +0200, Uladzislau Rezki wrote:
> > On Wed, Aug 19, 2020 at 08:21:59AM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 19, 2020 at 09:56:54AM -0400, Joel Fernandes wrote:
> > > > On Wed, Aug 19, 2020 at 03:00:55AM +0000, Zhang, Qiang wrote:
> > > > > 
> > > > > 
> > > > > ________________________________________
> > > > > 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 Joel Fernandes <joel@joelfernandes.org>
> > > > > 发送时间: 2020年8月19日 8:04
> > > > > 收件人: Paul E. McKenney
> > > > > 抄送: Uladzislau Rezki; Zhang, Qiang; Josh Triplett; Steven Rostedt; Mathieu Desnoyers; Lai Jiangshan; rcu; LKML
> > > > > 主题: Re: [PATCH] rcu: shrink each possible cpu krcp
> > > > > 
> > > > > On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > 
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index b8ccd7b5af82..6decb9ad2421 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > > > > > >  {
> > > > > > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > > > > > +       struct kfree_rcu_cpu *krcp;
> > > > > > >
> > > > > > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > > > > >                 return 0;
> > > > > > >
> > > > > > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > > > > > +       krcp = this_cpu_ptr(&krc)
> > > > > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > > > > +
> > > > > > >
> > > > > > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > > > > > Maybe be never.
> > > > > >
> > > > > > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > > > > > hard time getting too worried about it.  ;-)
> > > > > 
> > > > > >Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> > > > > >on the cache reaper who's job is to flush the per-cpu caches. So I
> > > > > >believe during CPU offlining, the per-cpu slab caches are flushed.
> > > > > >
> > > > > >thanks,
> > > > > >
> > > > >  >- Joel
> > > > > 
> > > > > When cpu going offline, the slub or slab only flush free objects in offline
> > > > > cpu cache,  put these free objects in node list  or return buddy system,
> > > > > for those who are still in use, they still stay offline cpu cache.
> > > > > 
> > > > > If we want clean per-cpu "krcp" objects when cpu going offline.  we should
> > > > > free "krcp" cache objects in "rcutree_offline_cpu", this func be called
> > > > > before other rcu cpu offline func. and then "rcutree_offline_cpu" will be
> > > > > called in "cpuhp/%u" per-cpu thread.
> > > > > 
> > > > 
> > > > Could you please wrap text properly when you post to mailing list, thanks. I
> > > > fixed it for you above.
> > > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 8ce77d9ac716..1812d4a1ac1b 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3959,6 +3959,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > > >         unsigned long flags;
> > > > >         struct rcu_data *rdp;
> > > > >         struct rcu_node *rnp;
> > > > > +       struct kfree_rcu_cpu *krcp;
> > > > >  
> > > > >         rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > >         rnp = rdp->mynode;
> > > > > @@ -3970,6 +3971,11 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > > >  
> > > > >         // nohz_full CPUs need the tick for stop-machine to work quickly
> > > > >         tick_dep_set(TICK_DEP_BIT_RCU);
> > > > > +
> > > > > +       krcp = per_cpu_ptr(&krc, cpu);
> > > > > +       raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > > +       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > > >         return 0;
> > > > 
> > > > I realized the above is not good enough for what this is trying to do. Unlike
> > > > the slab, the new kfree_rcu objects cannot always be drained / submitted to
> > > > RCU because the previous batch may still be waiting for a grace period. So
> > > > the above code could very well return with the yet-to-be-submitted kfree_rcu
> > > > objects still in the cache.
> > > > 
> > > > One option is to spin-wait here for monitor_todo to be false and keep calling
> > > > kfree_rcu_drain_unlock() till then.
> > > > 
> > > > But then that's not good enough either, because if new objects are queued
> > > > when interrupts are enabled in the CPU offline path, then the cache will get
> > > > new objects after the previous set was drained. Further, spin waiting may
> > > > introduce deadlocks.
> > > > 
> > > > Another option is to switch the kfree_rcu() path to non-batching (so new
> > > > objects cannot be cached in the offline path and are submitted directly to
> > > > RCU), wait for a GP and then submit the work. But then not sure if 1-argument
> > > > kfree_rcu() will like that.
> > > 
> > > Or spawn a workqueue that does something like this:
> > > 
> > > 1.	Get any pending kvfree_rcu() requests sent off to RCU.
> > > 
> > > 2.	Do an rcu_barrier().
> > > 
> > > 3.	Do the cleanup actions.
> > > 
> > > > Probably Qian's original fix for for_each_possible_cpus() is good enough for
> > > > the shrinker case, and then we can tackle the hotplug one.
> > > 
> > > It might take some experimentation to find the best solution.
> > > 
> > 
> > <snip>
> > static void do_idle(void)
> > {
> > ...
> >  while (!need_resched()) {
> >   rmb();
> > 
> >   local_irq_disable();
> > 
> >   if (cpu_is_offline(cpu)) {
> >    tick_nohz_idle_stop_tick();
> >    cpuhp_report_idle_dead();
> >        -> cpuhp_report_idle_dead(void)
> >               -> rcu_report_dead(smp_processor_id());
> >    arch_cpu_idle_dead();
> >   }
> > ...
> > <snip>
> > 
> > We have the rcu_report_dead() callback. When it gets called IRQs are off
> > and CPU that is in question is offline.
> > 
> >     krcp = per_cpu_ptr(&krc, cpu);
> >     raw_spin_lock_irqsave(&krcp->lock, flags);
> >     krcp->monotro_todo = true;
> >     schedule_delayed_work(&krcp->monitor_work, 0);
> >     raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > 
> > If there is a batch that is in progress, the job will rearm itself.
> > But i agree, it requires more experiments.
> 
> I chatted with Ulad and we believe the timer and/or (delayed) workqueue will
> get migrated during the CPU offline path, so it is not an issue.
> 
> In this case, Qiang's initial patch suffices to fix the shrinker issue.

As in the patch that is currented in -rcu, correct?

							Thanx, Paul
