Return-Path: <SRS0=uuXb=B5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E60C433DF
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30420204FD
	for <rcu@archiver.kernel.org>; Wed, 19 Aug 2020 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wbv/PHxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHSN5A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgHSN44 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Aug 2020 09:56:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB9DC061757
        for <rcu@vger.kernel.org>; Wed, 19 Aug 2020 06:56:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so17781208qtm.10
        for <rcu@vger.kernel.org>; Wed, 19 Aug 2020 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8EXV56NXvSonVGTOIjFMHLBEIS4AGNmsqbp4b0UfWho=;
        b=wbv/PHxBEJ9DrjsUo/ReyX4iunRVcZ8rfNh381cnz8Gqm3X2tV3yCcIUOoEUXHU+3D
         oxAHYALSCfaUZgjToik14tSy9bVt+KnPbUUNdzG4kS/qUiM8+iiSDiy52XgNfaXREhWd
         /GOr3d6U7x6pwIz/L5yxwBa5C8rR3ywlV/xU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8EXV56NXvSonVGTOIjFMHLBEIS4AGNmsqbp4b0UfWho=;
        b=sW7plbBZByatxKNpkv8NINSaRck5pCBmJtcsSqOxKm5aJ3YbdEdRRBxCYmakyQQ30f
         w8wDPBYOiAoG32q4tMMTONHiN2kCT5m1e09BpP923jDBlARJd1zzF85baQ4ERuZDYkVl
         sgkSPnHjlE/5WenJTUX0Arq8ZQqciX3gSzost34lZU2IDC2t/3MxCXYxrI/elaWPgV7m
         oic6Bart3xIdrS69MbXJpcRUK6Q5TBKQ7dyMaLBnwqpL2/uJDcBQ/FBWgcBsnGdfuJoG
         vfAsfIcv1H3NMltFw91Ijq4Imo+4m1i641KUWF9pKFWs9jUAjmTn12OaZ60aeW/wJr0X
         CF2Q==
X-Gm-Message-State: AOAM531cbu8cW0xXl/+JiIqZxrTC1wQW4KRvAClhFWJPt1lFj2kupJxX
        S9CZXDCoZAjSLc7swDcabvo7sQ==
X-Google-Smtp-Source: ABdhPJzpjIOeZkNGKmTzXLNI7t1lBdxDZSnEMZAVHDTC6AUr7Sm5OaNbL3KffndwXPTS0DTtXBx5/g==
X-Received: by 2002:aed:3461:: with SMTP id w88mr22401781qtd.180.1597845415324;
        Wed, 19 Aug 2020 06:56:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c22sm22364551qke.2.2020.08.19.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 06:56:54 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:56:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200819135654.GB3875610@google.com>
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 19, 2020 at 03:00:55AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 Joel Fernandes <joel@joelfernandes.org>
> 发送时间: 2020年8月19日 8:04
> 收件人: Paul E. McKenney
> 抄送: Uladzislau Rezki; Zhang, Qiang; Josh Triplett; Steven Rostedt; Mathieu Desnoyers; Lai Jiangshan; rcu; LKML
> 主题: Re: [PATCH] rcu: shrink each possible cpu krcp
> 
> On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b8ccd7b5af82..6decb9ad2421 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >  {
> > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > +       struct kfree_rcu_cpu *krcp;
> > >
> > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > >                 return 0;
> > >
> > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > +       krcp = this_cpu_ptr(&krc)
> > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > +
> > >
> > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > Maybe be never.
> >
> > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > hard time getting too worried about it.  ;-)
> 
> >Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> >on the cache reaper who's job is to flush the per-cpu caches. So I
> >believe during CPU offlining, the per-cpu slab caches are flushed.
> >
> >thanks,
> >
>  >- Joel
> 
> When cpu going offline, the slub or slab only flush free objects in offline
> cpu cache,  put these free objects in node list  or return buddy system,
> for those who are still in use, they still stay offline cpu cache.
> 
> If we want clean per-cpu "krcp" objects when cpu going offline.  we should
> free "krcp" cache objects in "rcutree_offline_cpu", this func be called
> before other rcu cpu offline func. and then "rcutree_offline_cpu" will be
> called in "cpuhp/%u" per-cpu thread.
> 

Could you please wrap text properly when you post to mailing list, thanks. I
fixed it for you above.

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..1812d4a1ac1b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3959,6 +3959,7 @@ int rcutree_offline_cpu(unsigned int cpu)
>         unsigned long flags;
>         struct rcu_data *rdp;
>         struct rcu_node *rnp;
> +       struct kfree_rcu_cpu *krcp;
>  
>         rdp = per_cpu_ptr(&rcu_data, cpu);
>         rnp = rdp->mynode;
> @@ -3970,6 +3971,11 @@ int rcutree_offline_cpu(unsigned int cpu)
>  
>         // nohz_full CPUs need the tick for stop-machine to work quickly
>         tick_dep_set(TICK_DEP_BIT_RCU);
> +
> +       krcp = per_cpu_ptr(&krc, cpu);
> +       raw_spin_lock_irqsave(&krcp->lock, flags);
> +       schedule_delayed_work(&krcp->monitor_work, 0);
> +       raw_spin_unlock_irqrestore(&krcp->lock, flags);
>         return 0;

I realized the above is not good enough for what this is trying to do. Unlike
the slab, the new kfree_rcu objects cannot always be drained / submitted to
RCU because the previous batch may still be waiting for a grace period. So
the above code could very well return with the yet-to-be-submitted kfree_rcu
objects still in the cache.

One option is to spin-wait here for monitor_todo to be false and keep calling
kfree_rcu_drain_unlock() till then.

But then that's not good enough either, because if new objects are queued
when interrupts are enabled in the CPU offline path, then the cache will get
new objects after the previous set was drained. Further, spin waiting may
introduce deadlocks.

Another option is to switch the kfree_rcu() path to non-batching (so new
objects cannot be cached in the offline path and are submitted directly to
RCU), wait for a GP and then submit the work. But then not sure if 1-argument
kfree_rcu() will like that.

Probably Qian's original fix for for_each_possible_cpus() is good enough for
the shrinker case, and then we can tackle the hotplug one.

thanks,

 - Joel

