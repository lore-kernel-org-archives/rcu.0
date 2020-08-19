Return-Path: <SRS0=uuXb=B5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5BFC433DF
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA51D2063A
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 15:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SlHEI38y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgHSPys (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgHSPyp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Aug 2020 11:54:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C06C061383
        for <rcu@vger.kernel.org>; Wed, 19 Aug 2020 08:54:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so18131855qts.6
        for <rcu@vger.kernel.org>; Wed, 19 Aug 2020 08:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q60onHid8iSpku+qZJQw6fYbSE4YurtiDVuXIPIGP8k=;
        b=SlHEI38yuJz9o8rfXLjxWgFh5evie2N52TntNYjdNI3QKdNjfV2hrS0H0D9Apq/91I
         jyU3Yf/xQyrDL1YgD4ykelSilkw501q0jfvs3neauYK+hg/jz9p1m7143P2DBmmybcUp
         gouVlF0T+Kbyl2phbd72SkVbJa6tPK7daI30w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q60onHid8iSpku+qZJQw6fYbSE4YurtiDVuXIPIGP8k=;
        b=KjDhSJegGVbKRVwO9xKux8Wl+l/VGM2fuR2iMMVKc/3zw/ldL7JraW0LFgIeXEZLbh
         VAJktIjGOn6r/Kbq80cvXJFNTcBDFsrStnns0iK4jX7XBDGyOn6KyfwfuKFnZ7Rz5L+Q
         i/lHfpkDcy3ZnDjAprCfPU6v0dF9rk5FVDyUzsP38MNwCgsnEWg3CsQKNc3KDL5m9tQ3
         fEBvlCkj8H+WQ5DkS9w9cqiJGBZN8n+IEaPHbOgWaYTTZhIinGPPECY3P+p3Gu3CESre
         gtcm9CjvIiQuw10YAK/hNKQeggFL0WBy3QCQ2LxfIpT1Ei46eeJlo/7OmWwn3NWSsb/o
         BOJg==
X-Gm-Message-State: AOAM532x2kAisuRh2dgn1F3ILvHYjirBKRdCjEEMgmYk5uEIY1EuyOa7
        JQmoJ2DxiSA5cCHcNaNnIxqlaw==
X-Google-Smtp-Source: ABdhPJwuqNnu315lY6/3tSnYh9rDredR6PTDLHDsn5O+4PtRCIBUtcQiE3KGhRPebhzBHeDJ2OBnJg==
X-Received: by 2002:ac8:24d9:: with SMTP id t25mr23509783qtt.15.1597852481203;
        Wed, 19 Aug 2020 08:54:41 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f39sm30015550qta.59.2020.08.19.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:54:40 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:54:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, boqun.feng@gmail.com
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200819155440.GD3886445@google.com>
References: <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819152159.GX27891@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 19, 2020 at 08:21:59AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 19, 2020 at 09:56:54AM -0400, Joel Fernandes wrote:
> > On Wed, Aug 19, 2020 at 03:00:55AM +0000, Zhang, Qiang wrote:
> > > 
> > > 
> > > ________________________________________
> > > 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 Joel Fernandes <joel@joelfernandes.org>
> > > 发送时间: 2020年8月19日 8:04
> > > 收件人: Paul E. McKenney
> > > 抄送: Uladzislau Rezki; Zhang, Qiang; Josh Triplett; Steven Rostedt; Mathieu Desnoyers; Lai Jiangshan; rcu; LKML
> > > 主题: Re: [PATCH] rcu: shrink each possible cpu krcp
> > > 
> > > On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index b8ccd7b5af82..6decb9ad2421 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > > > >  {
> > > > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > > > +       struct kfree_rcu_cpu *krcp;
> > > > >
> > > > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > > >                 return 0;
> > > > >
> > > > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > > > +       krcp = this_cpu_ptr(&krc)
> > > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > > +
> > > > >
> > > > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > > > Maybe be never.
> > > >
> > > > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > > > hard time getting too worried about it.  ;-)
> > > 
> > > >Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> > > >on the cache reaper who's job is to flush the per-cpu caches. So I
> > > >believe during CPU offlining, the per-cpu slab caches are flushed.
> > > >
> > > >thanks,
> > > >
> > >  >- Joel
> > > 
> > > When cpu going offline, the slub or slab only flush free objects in offline
> > > cpu cache,  put these free objects in node list  or return buddy system,
> > > for those who are still in use, they still stay offline cpu cache.
> > > 
> > > If we want clean per-cpu "krcp" objects when cpu going offline.  we should
> > > free "krcp" cache objects in "rcutree_offline_cpu", this func be called
> > > before other rcu cpu offline func. and then "rcutree_offline_cpu" will be
> > > called in "cpuhp/%u" per-cpu thread.
> > > 
> > 
> > Could you please wrap text properly when you post to mailing list, thanks. I
> > fixed it for you above.
> > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 8ce77d9ac716..1812d4a1ac1b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3959,6 +3959,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> > >         unsigned long flags;
> > >         struct rcu_data *rdp;
> > >         struct rcu_node *rnp;
> > > +       struct kfree_rcu_cpu *krcp;
> > >  
> > >         rdp = per_cpu_ptr(&rcu_data, cpu);
> > >         rnp = rdp->mynode;
> > > @@ -3970,6 +3971,11 @@ int rcutree_offline_cpu(unsigned int cpu)
> > >  
> > >         // nohz_full CPUs need the tick for stop-machine to work quickly
> > >         tick_dep_set(TICK_DEP_BIT_RCU);
> > > +
> > > +       krcp = per_cpu_ptr(&krc, cpu);
> > > +       raw_spin_lock_irqsave(&krcp->lock, flags);
> > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > +       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > >         return 0;
> > 
> > I realized the above is not good enough for what this is trying to do. Unlike
> > the slab, the new kfree_rcu objects cannot always be drained / submitted to
> > RCU because the previous batch may still be waiting for a grace period. So
> > the above code could very well return with the yet-to-be-submitted kfree_rcu
> > objects still in the cache.
> > 
> > One option is to spin-wait here for monitor_todo to be false and keep calling
> > kfree_rcu_drain_unlock() till then.
> > 
> > But then that's not good enough either, because if new objects are queued
> > when interrupts are enabled in the CPU offline path, then the cache will get
> > new objects after the previous set was drained. Further, spin waiting may
> > introduce deadlocks.
> > 
> > Another option is to switch the kfree_rcu() path to non-batching (so new
> > objects cannot be cached in the offline path and are submitted directly to
> > RCU), wait for a GP and then submit the work. But then not sure if 1-argument
> > kfree_rcu() will like that.
> 
> Or spawn a workqueue that does something like this:
> 
> 1.	Get any pending kvfree_rcu() requests sent off to RCU.
> 
> 2.	Do an rcu_barrier().
> 
> 3.	Do the cleanup actions.

One more thing I'n not sure about is if this will even be an issue  because
the delayed-work to run the monitor could be migrated to another (both timers
and wq get migrated).  So in that case, the draining of the kfree_rcu objects
will happened on another CPU.

Adding Boqun as well since I believe he knows a lot about wq and hotplug as
well.

Basically my question is does delayed_work get migrated to another CPU when
one CPU is offline?  If so, I am assuming all races between new
schedule_delayed_work invocations and CPU offlining are handled as well, such
that at some point those new invocations are queued on another CPU.

> > Probably Qian's original fix for for_each_possible_cpus() is good enough for
> > the shrinker case, and then we can tackle the hotplug one.
> 
> It might take some experimentation to find the best solution.

Sure.

thanks,

 - Joel

