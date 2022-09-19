Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A243BECAAD3
	for <rcu@archiver.kernel.org>; Mon, 19 Sep 2022 10:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiISKnj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Sep 2022 06:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiISKnP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Sep 2022 06:43:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E533E06
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 03:25:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l9so6723833lji.4
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SU+rMZKoyjMoRroL2uZRyS5j14QUSa2pGGiqOgrvq1w=;
        b=Y6nmWqjE6jlSekMyvja5excmVWhWdcAWa2f23bWdOXMJ1AGWvBszhpw7baRWXrJG3u
         Ze1yc/eLlb7yPsySD6Mp/GkeYndKDFOui2hpHBH7Jk8hKIioZVZVc1Asbi7dNeP0yydC
         eq4eT6lGMsrpUAJ8knu6BtSVMMrGFpWDf9Km4LVRnrqAjfgOEcegT/UZBRpYKWG97Dio
         9VAsaNwC9PccGdgmxzpBBFYiQEQ5tZyzOshwLWV21Sm3RXDUkMS7cnpHoy+bxP86gJZG
         T9WZOHhTRh49msAyi0O8Wdea+IhBMCb05HK+c166HMcFsNSQIikwYWtZAppHjo5yu868
         CjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SU+rMZKoyjMoRroL2uZRyS5j14QUSa2pGGiqOgrvq1w=;
        b=SFFF7T0ihm2P3KN2NNiEILLw0mvF25+F5YYWRKmtHnfDDJ1AAiwtYwPPyeNGV+dXuU
         v6XY+KpyqgiU11J+dVaZEiKKJi1Sak25ieP9qzu06UwEbO13YtLUUjfNR4r/zc9eNtRq
         BgTZWkT7t1jfzl8F1WtNaVG95qAcFVdsvPcCgsz4JWYa4UEZxYMVXr5n14Heu0lsCuXz
         J1EwQHNhvuLWOcgRBv0orBD8LY2MJ7VC2ypmxCIs8mDWRdeJky6YWrGy0NXHiphuMkFV
         5arBCasKyeQQ3/O9cR1WScN6M9IDCw4LlNmZtguXl5ASiZl8cCu+tBL9z70uBt0Y3TwK
         P9zA==
X-Gm-Message-State: ACrzQf2TNYfr/1WenyAYx/pMkvpPx7MbmBaU6tGXfPu7+iNDsvAefU/n
        /K+SdJL4w8G1oAOe7tAD2Xr+gMuzwSWA175yHg==
X-Google-Smtp-Source: AMsMyM6rczNEQtQG79to0HMKUp8SSoC7iUD1gx2gn4m9PwDNfp5RL+iQaBh+LP/7yn3hD/kdhnnIN2nYqGgxXFTDKD4=
X-Received: by 2002:a2e:b61c:0:b0:26c:c17:feeb with SMTP id
 r28-20020a2eb61c000000b0026c0c17feebmr5219555ljn.199.1663583073774; Mon, 19
 Sep 2022 03:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220915055825.21525-1-kernelfans@gmail.com> <20220915055825.21525-2-kernelfans@gmail.com>
 <20220916145240.GA27819@lothringen>
In-Reply-To: <20220916145240.GA27819@lothringen>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 19 Sep 2022 18:24:21 +0800
Message-ID: <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] rcu: Keep qsmaskinitnext fresh when rcutree_online_cpu()
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 16, 2022 at 10:52 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> On Thu, Sep 15, 2022 at 01:58:23PM +0800, Pingfan Liu wrote:
> > rcutree_online_cpu() is concurrent, so there is the following race
> > scene:
> >
> >         CPU 1                               CPU2
> > mask_old = rcu_rnp_online_cpus(rnp);
> > ...
> >
> >                                    mask_new = rcu_rnp_online_cpus(rnp);
> >                                    ...
> >                                    set_cpus_allowed_ptr(t, cm);
> >
> > set_cpus_allowed_ptr(t, cm);
> >
> > Consequently, the old mask will overwrite the new mask in the task's cpus_ptr.
> >
> > Since there is a mutex ->boost_kthread_mutex, using it to build an
> > order, then the latest ->qsmaskinitnext will be fetched for updating cpus_ptr.
> >
> > But for concurrent offlining, ->qsmaskinitnext is not reilable when
> > rcutree_offline_cpu(). That is another story and comes in the following
> > patch.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/tree_plugin.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 438ecae6bd7e..ef6d3ae239b9 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> >  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> >  {
> >       struct task_struct *t = rnp->boost_kthread_task;
> > -     unsigned long mask = rcu_rnp_online_cpus(rnp);
> > +     unsigned long mask;
> >       cpumask_var_t cm;
> >       int cpu;
> >
> > @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> >       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> >               return;
> >       mutex_lock(&rnp->boost_kthread_mutex);
> > +     /*
> > +      * Relying on the lock to serialize, so when onlining, the latest
> > +      * qsmaskinitnext is for cpus_ptr.
> > +      */
> > +     mask = rcu_rnp_online_cpus(rnp);
> >       for_each_leaf_node_possible_cpu(rnp, cpu)
> >               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
> >                   cpu != outgoingcpu)
>
> Right but you still race against concurrent rcu_report_dead() doing:
>
>       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
>

Ah. Indeed, my commit log is not precisely described.

In fact, either speedup smp_init [1] or fast kexec reboot [2] still
uses the model: one hotplug initiator and several reactors.  The
initiators are still excluded from each other by the pair
cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
cpu-up and cpu-down event at the same time.

Thanks,

    Pingfan
