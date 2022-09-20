Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C12ECAAD8
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 09:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiITJBR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiITJAd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 05:00:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9766253
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 02:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4232CE16A5
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 09:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A853AC433D6;
        Tue, 20 Sep 2022 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663664425;
        bh=P2FJ+QFIEceUj3/7YFsZI8LxnUKqTW5z0aybBZA9TbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8DdL51aKQtdylYDbYkoQv+ll+t+u66vlcQl40sHI5X5ijzSxrpi+RpNv/OLNIesn
         FNK7EcIW8Eek5efELx5E1ObDDZhlssCUHLOfyeP6YDGh1PytprIJ1xxZ0kALHSRGCJ
         Ktn35UsFHj5JbM1g8yTu5psRu7scm/QH5xc8Rm15DKHf4XcK2cpnETc9Vhnr4ctOe6
         4IHU7DuAmee3Ez/hHwX14SXN2BRUo2Dwyx/IXwr+ZBstppHutc0paa93zl6kaVh68q
         jxaJTqjIFkL+V2BnZBiXaJXlC7mVFG6RVZA2kZDO6c+LclXYmzjZqu+tzRvPtKgzBS
         Vn26gWSf3KUIw==
Date:   Tue, 20 Sep 2022 11:00:21 +0200
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
Subject: Re: [PATCHv2 2/3] rcu: Resort to cpu_dying_mask for affinity when
 offlining
Message-ID: <20220920090021.GC69891@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-3-kernelfans@gmail.com>
 <20220916142358.GA27246@lothringen>
 <CAFgQCTu6cxrbZ4jLdV6og2uhAG35LRjhjTw0Emgfpy0BW4kq6Q@mail.gmail.com>
 <20220919103432.GA57002@lothringen>
 <YykweX7mXEk/83Ft@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YykweX7mXEk/83Ft@piliu.users.ipa.redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 11:16:09AM +0800, Pingfan Liu wrote:
> On Mon, Sep 19, 2022 at 12:34:32PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 19, 2022 at 12:33:23PM +0800, Pingfan Liu wrote:
> > > On Fri, Sep 16, 2022 at 10:24 PM Frederic Weisbecker
> > > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > > index ef6d3ae239b9..e5afc63bd97f 100644
> > > > > --- a/kernel/rcu/tree_plugin.h
> > > > > +++ b/kernel/rcu/tree_plugin.h
> > > > > @@ -1243,6 +1243,12 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > > > >                   cpu != outgoingcpu)
> > > > >                       cpumask_set_cpu(cpu, cm);
> > > > >       cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
> > > > > +     /*
> > > > > +      * For concurrent offlining, bit of qsmaskinitnext is not cleared yet.
> > > > > +      * So resort to cpu_dying_mask, whose changes has already been visible.
> > > > > +      */
> > > > > +     if (outgoingcpu != -1)
> > > > > +             cpumask_andnot(cm, cm, cpu_dying_mask);
> > > >
> > > > I'm not sure how the infrastructure changes in your concurrent down patchset
> > > > but can the cpu_dying_mask concurrently change at this stage?
> > > >
> > > 
> > > For the concurrent down patchset [1], it extends the cpu_down()
> > > capability to let an initiator to tear down several cpus in a batch
> > > and in parallel.
> > > 
> > > At the first step, all cpus to be torn down should experience
> > > cpuhp_set_state(cpu, st, CPUHP_TEARDOWN_CPU), by that way, they are
> > > set in the bitmap cpu_dying_mask [2]. Then the cpu hotplug kthread on
> > > each teardown cpu can be kicked to work. (Indeed, [2] has a bug, and I
> > > need to fix it by using another loop to call
> > > cpuhp_kick_ap_work_async(cpu);)
> > 
> > So if I understand correctly there is a synchronization point for all
> > CPUs between cpuhp_set_state() and CPUHP_AP_RCUTREE_ONLINE ?
> > 
> 
> Yes, your understanding is right.
> 
> > And how about rollbacks through cpuhp_reset_state() ?
> > 
> 
> Originally, cpuhp_reset_state() is not considered in my fast kexec
> reboot series since at that point, all devices have been shutdown and
> have no way to back. The rebooting just adventures to move on.
> 
> But yes as you point out, cpuhp_reset_state() throws a challenge to keep
> the stability of cpu_dying_mask.
> 
> Considering we have the following order.
> 1.
>   set_cpu_dying(true)
>   rcutree_offline_cpu()
> 2. when rollback
>   set_cpu_dying(false)
>   rcutree_online_cpu()
> 
> 
> The dying mask is stable before rcu routines, and
> rnp->boost_kthread_mutex can be used to build a order to access the
> latest cpu_dying_mask as in [1/3].

Ok thanks for the clarification!
