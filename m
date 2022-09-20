Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B706ECAAD8
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 03:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiITDp5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiITDpz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Sep 2022 23:45:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BC1055D
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 20:45:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so9448473pjq.3
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zw7ZVEjBo+tSz7zCKNQeJJIDbS2jDYqj+Li2Xamr/ng=;
        b=FI91THR/7qcygWjPMB8aWfQBnu+FUUf5cMQ515jSDS/uPDD+0QPDzCrsvvxBbeEQJp
         D01g0xrVFnKzKPsLeif+fprHIOYeZnroUFC5rdxkOKf99st0Q1MnLmMDW6EwnGFr5SGO
         bjcwKdPWDOz5V4p89Ip8jOwYkWKklsjCLKgWFAWYXybbd9f1GGq4MdnPAJV7lvm+xKg+
         I+YfxoobukP2rgQzClh3Z6xh2napmQFMLB0jMniEmnjvYyzsbr4+JtbVX3N97nMnBxdK
         shtYJ65vHL+H1ITkRLBe37eRvVspV03h4oZo+pDOz2gnAzrMeayCJ0Z/RzupVBZklSe/
         E0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zw7ZVEjBo+tSz7zCKNQeJJIDbS2jDYqj+Li2Xamr/ng=;
        b=8RJgQYQ0/x4CZNHw1EZ3eNHnBDPZtKNXodVnZNaRun/911qF657NFaECCIO8xWO38e
         CE9naF9QegqawF7zYb/+aGfCNPIdHilJz+PGJYOpolCzm9uFZB9JvuDRolYEPfArEXSh
         dMTonHpQeRNCV7HpLPJDwvoVh9fbr1FD5dau3oWhXsBhsl70RkWfG0aMtKTUzzCM+xDz
         GRHxR0PrhKoFTmbHGdyvDqz3FCz7nrn3gNwAtWeseojCI6YHugFEIPKAJOwbHUWxwk25
         OkjuhfBZm1eRhIcPcjSAmUdqLy5JbiFIC1t5ItAup3qiohVTD84QvZOKTbuzEiIksVW7
         yXFg==
X-Gm-Message-State: ACrzQf00aLgNRIg1O++PIgPrQB74r9ce0wO7O15ZRDk9NrFloXncKoxy
        FTkF3tWxqJFle633m9XG2A==
X-Google-Smtp-Source: AMsMyM4QmHy3mxVD2GyPiJN6JK0ii6BTBPfCNRix/4PI73XtrHag2aZXAKxnPSY+SJwWZwv73ADMZA==
X-Received: by 2002:a17:902:cccc:b0:178:a9b3:43e6 with SMTP id z12-20020a170902cccc00b00178a9b343e6mr2881182ple.92.1663645554077;
        Mon, 19 Sep 2022 20:45:54 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b00176d218889esm179531plg.228.2022.09.19.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:45:53 -0700 (PDT)
Date:   Tue, 20 Sep 2022 11:45:45 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when
 rcutree_online_cpu()
Message-ID: <Yyk3acmumN7ezhhv@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-2-kernelfans@gmail.com>
 <20220916145240.GA27819@lothringen>
 <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
 <20220919105149.GA58144@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919105149.GA58144@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 19, 2022 at 12:51:49PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 19, 2022 at 06:24:21PM +0800, Pingfan Liu wrote:
> > On Fri, Sep 16, 2022 at 10:52 PM Frederic Weisbecker
> > <frederic@kernel.org> wrote:
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 438ecae6bd7e..ef6d3ae239b9 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > > >  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > > >  {
> > > >       struct task_struct *t = rnp->boost_kthread_task;
> > > > -     unsigned long mask = rcu_rnp_online_cpus(rnp);
> > > > +     unsigned long mask;
> > > >       cpumask_var_t cm;
> > > >       int cpu;
> > > >
> > > > @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > > >       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> > > >               return;
> > > >       mutex_lock(&rnp->boost_kthread_mutex);
> > > > +     /*
> > > > +      * Relying on the lock to serialize, so when onlining, the latest
> > > > +      * qsmaskinitnext is for cpus_ptr.
> > > > +      */
> > > > +     mask = rcu_rnp_online_cpus(rnp);
> > > >       for_each_leaf_node_possible_cpu(rnp, cpu)
> > > >               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
> > > >                   cpu != outgoingcpu)
> > >
> > > Right but you still race against concurrent rcu_report_dead() doing:
> > >
> > >       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
> > >
> > 
> > Ah. Indeed, my commit log is not precisely described.
> > 
> > In fact, either speedup smp_init [1] or fast kexec reboot [2] still
> > uses the model: one hotplug initiator and several reactors.  The
> > initiators are still excluded from each other by the pair
> > cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
> > cpu-up and cpu-down event at the same time.
> 
> Yes but two downing CPUs may race right?
> 
> So isn't it possible to have rcu_report_dead() racing against
> rcutree_offline_cpu()?
> 

Yes, two downing cpus can be in a batch.

There is a nuance between onlining and offlining:
-1. onlining relies on qsmaskinitnext, which is stable at the point
rcutree_online_cpu(). And it is what this patch aims for.
-2. offlining relies on cpu_dying_mask [2/3], instead of qsmaskinitnext
which is not cleared yet at the point rcutree_offline_cpu().

It is asymmetric owning to the point of updating qsmaskinitnext.

Now considering the racing between rcu_report_dead() and
rcutree_offline_cpu():

No matter rcutree_offline_cpu() reads out either stale or fresh value of
qsmaskinitnext, it should intersect with cpu_dying_mask.

Thanks,

	Pingfan
