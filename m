Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476DECAAD3
	for <rcu@archiver.kernel.org>; Mon, 19 Sep 2022 10:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiISK41 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Sep 2022 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiISK4I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Sep 2022 06:56:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51E01054F
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 03:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A548B819A4
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 10:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF812C433C1;
        Mon, 19 Sep 2022 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663584713;
        bh=nmFqW3TjkjE2QVblrzWfVg9k4JK6XqUL7eUpw4/PeWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhhagX9Jpc4cuj5sK2TmR725SH63Tf+87Db/HYkitdT0QCYf1vJq/AZv70y5LDsbx
         fVZyeLfhmbN0cjc8wxGDJyF6oqGDAFuXKlNvJQDvlDavuWjgQHCFK0Ir9j2TsoSN9t
         ipM7x6e3SWvGi7Xdf8ZUg25E03HnFjLD8opttHEQNmpl70z/8ijPhYrfmPlL9MK9bq
         +qIZ9SHlbH9wx9Oug3c53FNqj+0RYr5+BMVSN2kKefdT5l7KXhpwVD/HwDmkf0+chX
         hSG8tjElVtLxlnO1AdObMV+5SL8Rw4MCq5KeZUQhB3ag7A+Y0T5fq4Jel5YHwGClBL
         RJNYXOXG0lrAA==
Date:   Mon, 19 Sep 2022 12:51:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
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
Message-ID: <20220919105149.GA58144@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-2-kernelfans@gmail.com>
 <20220916145240.GA27819@lothringen>
 <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 19, 2022 at 06:24:21PM +0800, Pingfan Liu wrote:
> On Fri, Sep 16, 2022 at 10:52 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 438ecae6bd7e..ef6d3ae239b9 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > >  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > >  {
> > >       struct task_struct *t = rnp->boost_kthread_task;
> > > -     unsigned long mask = rcu_rnp_online_cpus(rnp);
> > > +     unsigned long mask;
> > >       cpumask_var_t cm;
> > >       int cpu;
> > >
> > > @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > >       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> > >               return;
> > >       mutex_lock(&rnp->boost_kthread_mutex);
> > > +     /*
> > > +      * Relying on the lock to serialize, so when onlining, the latest
> > > +      * qsmaskinitnext is for cpus_ptr.
> > > +      */
> > > +     mask = rcu_rnp_online_cpus(rnp);
> > >       for_each_leaf_node_possible_cpu(rnp, cpu)
> > >               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
> > >                   cpu != outgoingcpu)
> >
> > Right but you still race against concurrent rcu_report_dead() doing:
> >
> >       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
> >
> 
> Ah. Indeed, my commit log is not precisely described.
> 
> In fact, either speedup smp_init [1] or fast kexec reboot [2] still
> uses the model: one hotplug initiator and several reactors.  The
> initiators are still excluded from each other by the pair
> cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
> cpu-up and cpu-down event at the same time.

Yes but two downing CPUs may race right?

So isn't it possible to have rcu_report_dead() racing against
rcutree_offline_cpu()?

Thanks.
