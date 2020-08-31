Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FEC433E2
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 09:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065F6206F0
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 09:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5Ws0UL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgHaJai (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgHaJah (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 05:30:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76BC061573;
        Mon, 31 Aug 2020 02:30:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g6so5807930ljn.11;
        Mon, 31 Aug 2020 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3L07aghnJbyRPZJOaFH3eUdaOzbfg9qRZ9biyh0gbQw=;
        b=k5Ws0UL8DCYFpZ3p/74f3BUt0hgRrU3trw42TZauoyKkjpfSFJFyYr1RO/SRfBMOhi
         BXz4zu1Y/AXYTZvnUIhAYZDjF+uurBQ2YeDIRQRwHIxRaPEQI8qTJ9y37WP5zkbPr2yh
         xr/K9FGTtSwcHebyK5L5C4ePQ/2hud3fJYR3KNZRpUKXUqcawO8d+85asH9Ef0vk1hKV
         mtv6t7ZTms1obcNAhLsK54eUaIRoymgFK6cTCXAfndNpmXvmTuBW/atDSbcO/L1Wd7UP
         uxIRCTOVlYtwXkfItQA4ecN9H6CdgxFAAGd/qOyVDb0i2qAx9TGJCvMWkCFuIS5y9hcW
         mhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3L07aghnJbyRPZJOaFH3eUdaOzbfg9qRZ9biyh0gbQw=;
        b=NwVnnbaNGqnMKZfkvg7UFsfLtj23lUuFLn0ozVIk2uNcIzIbfNhQx0UTXQXyYIU1X2
         zn2XQw757YVMjqBWL69yKCQo19NskIXcXI0FCmq+lKiqi0t5n95mCP+infTR9EDkWb56
         20m20FHPoNBOZ4uuPvCHPrUlXes+B+aA0RFKDAUhVJi83Q75WW457880uJqZK0xYi4Uf
         S+WgDCKRH7/G6bIHYNc6vUSfmjvz+aMx9WAQvbcYiHA39T0iRAjJNosHsSiNlg+eObWL
         T/MyGKR2NMsTB4LXg/SLJvhTXv4U6AfZLL07QxKXPKcrXYhesX81djFbTE0r0xRIV89Y
         wKZg==
X-Gm-Message-State: AOAM5318/UM9FQAq/ALQ8crJ0zQIF0yL9tzK26HDGThavmtU4ZY4bUV2
        U9ySbT0t9+Bdr9obMOI/aso=
X-Google-Smtp-Source: ABdhPJy/+kx5MJI2fzaOyi9EMdUy8l+fHTOJqKj64glaOAM7OKtQJlgcl/3oWiPfU09NDpt3LhzIyA==
X-Received: by 2002:a05:651c:208:: with SMTP id y8mr250939ljn.233.1598866235282;
        Mon, 31 Aug 2020 02:30:35 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i187sm794599lfd.65.2020.08.31.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 02:30:34 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 31 Aug 2020 11:30:32 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200831093032.GA19139@pc636>
References: <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72>
 <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>
 <20200821153328.GH2855@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821153328.GH2855@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 21, 2020 at 08:33:28AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 20, 2020 at 06:39:57PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 19, 2020 at 05:58:08PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Aug 19, 2020 at 08:21:59AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Aug 19, 2020 at 09:56:54AM -0400, Joel Fernandes wrote:
> > > > > On Wed, Aug 19, 2020 at 03:00:55AM +0000, Zhang, Qiang wrote:
> > > > > > 
> > > > > > 
> > > > > > ________________________________________
> > > > > > 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 Joel Fernandes <joel@joelfernandes.org>
> > > > > > 发送时间: 2020年8月19日 8:04
> > > > > > 收件人: Paul E. McKenney
> > > > > > 抄送: Uladzislau Rezki; Zhang, Qiang; Josh Triplett; Steven Rostedt; Mathieu Desnoyers; Lai Jiangshan; rcu; LKML
> > > > > > 主题: Re: [PATCH] rcu: shrink each possible cpu krcp
> > > > > > 
> > > > > > On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > 
> > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > index b8ccd7b5af82..6decb9ad2421 100644
> > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > > > > > > >  {
> > > > > > > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > > > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > > > > > > +       struct kfree_rcu_cpu *krcp;
> > > > > > > >
> > > > > > > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > > > > > >                 return 0;
> > > > > > > >
> > > > > > > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > > > > > > +       krcp = this_cpu_ptr(&krc)
> > > > > > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > > > > > +
> > > > > > > >
> > > > > > > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > > > > > > Maybe be never.
> > > > > > >
> > > > > > > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > > > > > > hard time getting too worried about it.  ;-)
> > > > > > 
> > > > > > >Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> > > > > > >on the cache reaper who's job is to flush the per-cpu caches. So I
> > > > > > >believe during CPU offlining, the per-cpu slab caches are flushed.
> > > > > > >
> > > > > > >thanks,
> > > > > > >
> > > > > >  >- Joel
> > > > > > 
> > > > > > When cpu going offline, the slub or slab only flush free objects in offline
> > > > > > cpu cache,  put these free objects in node list  or return buddy system,
> > > > > > for those who are still in use, they still stay offline cpu cache.
> > > > > > 
> > > > > > If we want clean per-cpu "krcp" objects when cpu going offline.  we should
> > > > > > free "krcp" cache objects in "rcutree_offline_cpu", this func be called
> > > > > > before other rcu cpu offline func. and then "rcutree_offline_cpu" will be
> > > > > > called in "cpuhp/%u" per-cpu thread.
> > > > > > 
> > > > > 
> > > > > Could you please wrap text properly when you post to mailing list, thanks. I
> > > > > fixed it for you above.
> > > > > 
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 8ce77d9ac716..1812d4a1ac1b 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -3959,6 +3959,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > > > >         unsigned long flags;
> > > > > >         struct rcu_data *rdp;
> > > > > >         struct rcu_node *rnp;
> > > > > > +       struct kfree_rcu_cpu *krcp;
> > > > > >  
> > > > > >         rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > > >         rnp = rdp->mynode;
> > > > > > @@ -3970,6 +3971,11 @@ int rcutree_offline_cpu(unsigned int cpu)
> > > > > >  
> > > > > >         // nohz_full CPUs need the tick for stop-machine to work quickly
> > > > > >         tick_dep_set(TICK_DEP_BIT_RCU);
> > > > > > +
> > > > > > +       krcp = per_cpu_ptr(&krc, cpu);
> > > > > > +       raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > > > +       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > > > >         return 0;
> > > > > 
> > > > > I realized the above is not good enough for what this is trying to do. Unlike
> > > > > the slab, the new kfree_rcu objects cannot always be drained / submitted to
> > > > > RCU because the previous batch may still be waiting for a grace period. So
> > > > > the above code could very well return with the yet-to-be-submitted kfree_rcu
> > > > > objects still in the cache.
> > > > > 
> > > > > One option is to spin-wait here for monitor_todo to be false and keep calling
> > > > > kfree_rcu_drain_unlock() till then.
> > > > > 
> > > > > But then that's not good enough either, because if new objects are queued
> > > > > when interrupts are enabled in the CPU offline path, then the cache will get
> > > > > new objects after the previous set was drained. Further, spin waiting may
> > > > > introduce deadlocks.
> > > > > 
> > > > > Another option is to switch the kfree_rcu() path to non-batching (so new
> > > > > objects cannot be cached in the offline path and are submitted directly to
> > > > > RCU), wait for a GP and then submit the work. But then not sure if 1-argument
> > > > > kfree_rcu() will like that.
> > > > 
> > > > Or spawn a workqueue that does something like this:
> > > > 
> > > > 1.	Get any pending kvfree_rcu() requests sent off to RCU.
> > > > 
> > > > 2.	Do an rcu_barrier().
> > > > 
> > > > 3.	Do the cleanup actions.
> > > > 
> > > > > Probably Qian's original fix for for_each_possible_cpus() is good enough for
> > > > > the shrinker case, and then we can tackle the hotplug one.
> > > > 
> > > > It might take some experimentation to find the best solution.
> > > > 
> > > 
> > > <snip>
> > > static void do_idle(void)
> > > {
> > > ...
> > >  while (!need_resched()) {
> > >   rmb();
> > > 
> > >   local_irq_disable();
> > > 
> > >   if (cpu_is_offline(cpu)) {
> > >    tick_nohz_idle_stop_tick();
> > >    cpuhp_report_idle_dead();
> > >        -> cpuhp_report_idle_dead(void)
> > >               -> rcu_report_dead(smp_processor_id());
> > >    arch_cpu_idle_dead();
> > >   }
> > > ...
> > > <snip>
> > > 
> > > We have the rcu_report_dead() callback. When it gets called IRQs are off
> > > and CPU that is in question is offline.
> > > 
> > >     krcp = per_cpu_ptr(&krc, cpu);
> > >     raw_spin_lock_irqsave(&krcp->lock, flags);
> > >     krcp->monotro_todo = true;
> > >     schedule_delayed_work(&krcp->monitor_work, 0);
> > >     raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > > 
> > > If there is a batch that is in progress, the job will rearm itself.
> > > But i agree, it requires more experiments.
> > 
> > I chatted with Ulad and we believe the timer and/or (delayed) workqueue will
> > get migrated during the CPU offline path, so it is not an issue.
> > 
> > In this case, Qiang's initial patch suffices to fix the shrinker issue.
> 
> As in the patch that is currented in -rcu, correct?
> 
The "[PATCH] rcu: shrink each possible cpu krcp" will fix the
shrinker "issue" when CPU goes offline. So that was valid concern.

As for "main track", our drain work or a timer that triggers it
will be migrated anyway. Just to repeat what Joel wrote earlier,
we do not have any issues with this part.

--
Vlad Rezki
