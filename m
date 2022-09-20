Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE10C54EE9
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 09:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiITJXa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiITJXS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 05:23:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20776BD59
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 02:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CA10B8092F
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 09:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99638C433C1;
        Tue, 20 Sep 2022 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663665786;
        bh=txS+G2Xvgn9VwQfPhSIHVlxMXCxR6lm+DpL0pb8pwOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrSGhZ0pogT/Vl3Rk3Wv1WTqMpkDajEnJTikQ8Lg2VbabnhvRP8VPKupFGSxb/rfX
         Wm9xGVmCvoROn/93kxMTtC7oG/Cl/fvfzsHOSw38Rr4POmi1WzirBHt2aoSjZyaNs/
         hARgfamSvP7A09leNGhlhXsjiX6iCXh64TK90JoDyiBbVb8smM6GPqVcI04y2A2tI/
         SlcDnGG3ZxUW5HPUD9gx/vzXqOKrR6BXqz2DYtXveCSze+KPtz0SwMPQUHZHf+E94w
         cKaCTLUXSCpH1SI5rAQPd5M0xZDODfyxlTFyZOm1WaFjPfvYO7DbcA+TC88qAbwdhG
         M/mxBTMe/55ug==
Date:   Tue, 20 Sep 2022 11:23:03 +0200
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
Message-ID: <20220920092303.GE69891@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-2-kernelfans@gmail.com>
 <20220916145240.GA27819@lothringen>
 <CAFgQCTuB72QZNL4AW95WntkCUqAinzis=6Mjwyfdy_NiMi_pgQ@mail.gmail.com>
 <20220919105149.GA58144@lothringen>
 <Yyk3acmumN7ezhhv@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyk3acmumN7ezhhv@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 11:45:45AM +0800, Pingfan Liu wrote:
> On Mon, Sep 19, 2022 at 12:51:49PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 19, 2022 at 06:24:21PM +0800, Pingfan Liu wrote:
> > > On Fri, Sep 16, 2022 at 10:52 PM Frederic Weisbecker
> > > <frederic@kernel.org> wrote:
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index 438ecae6bd7e..ef6d3ae239b9 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
> > > > >  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > > > >  {
> > > > >       struct task_struct *t = rnp->boost_kthread_task;
> > > > > -     unsigned long mask = rcu_rnp_online_cpus(rnp);
> > > > > +     unsigned long mask;
> > > > >       cpumask_var_t cm;
> > > > >       int cpu;
> > > > >
> > > > > @@ -1233,6 +1233,11 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > > > >       if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
> > > > >               return;
> > > > >       mutex_lock(&rnp->boost_kthread_mutex);
> > > > > +     /*
> > > > > +      * Relying on the lock to serialize, so when onlining, the latest
> > > > > +      * qsmaskinitnext is for cpus_ptr.
> > > > > +      */
> > > > > +     mask = rcu_rnp_online_cpus(rnp);
> > > > >       for_each_leaf_node_possible_cpu(rnp, cpu)
> > > > >               if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
> > > > >                   cpu != outgoingcpu)
> > > >
> > > > Right but you still race against concurrent rcu_report_dead() doing:
> > > >
> > > >       WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask)
> > > >
> > > 
> > > Ah. Indeed, my commit log is not precisely described.
> > > 
> > > In fact, either speedup smp_init [1] or fast kexec reboot [2] still
> > > uses the model: one hotplug initiator and several reactors.  The
> > > initiators are still excluded from each other by the pair
> > > cpu_maps_update_begin()/cpu_maps_update_done(). So there can not be a
> > > cpu-up and cpu-down event at the same time.
> > 
> > Yes but two downing CPUs may race right?
> > 
> > So isn't it possible to have rcu_report_dead() racing against
> > rcutree_offline_cpu()?
> > 
> 
> Yes, two downing cpus can be in a batch.
> 
> There is a nuance between onlining and offlining:
> -1. onlining relies on qsmaskinitnext, which is stable at the point
> rcutree_online_cpu(). And it is what this patch aims for.
> -2. offlining relies on cpu_dying_mask [2/3], instead of qsmaskinitnext
> which is not cleared yet at the point rcutree_offline_cpu().
> 
> It is asymmetric owning to the point of updating qsmaskinitnext.
> 
> Now considering the racing between rcu_report_dead() and
> rcutree_offline_cpu():
> 
> No matter rcutree_offline_cpu() reads out either stale or fresh value of
> qsmaskinitnext, it should intersect with cpu_dying_mask.

Ah I see now, so the race can happen but it is then cancelled by the
stable READ on cpu_dying_mask. Ok.

> 
> Thanks,
> 
> 	Pingfan
