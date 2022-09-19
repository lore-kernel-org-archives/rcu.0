Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8BAC54EE9
	for <rcu@archiver.kernel.org>; Mon, 19 Sep 2022 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiISKrY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Sep 2022 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiISKq6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Sep 2022 06:46:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C566337
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 03:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95084B818C9
        for <rcu@vger.kernel.org>; Mon, 19 Sep 2022 10:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3BAC433C1;
        Mon, 19 Sep 2022 10:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663583675;
        bh=GbTDomKL++u2cLTK8UTQS273FahbmeL9B7K3idvx1Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NApdUGEHSR8vqfbVOX+fal58RDe8qaWOiKvCkyU9fzhRKzwuZ+3R8pSETyItWAKXs
         /LptC0d0rKUh/R8zwywHSrvYIUaoNdOFnrqEgGyfNJAWF9gUOWGLwiR8zgYvRY7HgU
         5SizojuJpaCI6cY4DgROieVmE2wbwAe9DtiIJWc30mZ8dDL8slNWIMOxphD8fYKvnr
         DC4XecX3viEXKclRSl8QsNyBAB3T372zXC4qwobW/YFsxCoF+puTIfqNrVqa6Xelkg
         qOz9xgB4ByE56E4cb4phn//xsAmxglrx0twfegjtdG+uFliJMLxGiT4T5oYqTp11AK
         giUeBM74M/zPg==
Date:   Mon, 19 Sep 2022 12:34:32 +0200
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
Message-ID: <20220919103432.GA57002@lothringen>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-3-kernelfans@gmail.com>
 <20220916142358.GA27246@lothringen>
 <CAFgQCTu6cxrbZ4jLdV6og2uhAG35LRjhjTw0Emgfpy0BW4kq6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTu6cxrbZ4jLdV6og2uhAG35LRjhjTw0Emgfpy0BW4kq6Q@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 19, 2022 at 12:33:23PM +0800, Pingfan Liu wrote:
> On Fri, Sep 16, 2022 at 10:24 PM Frederic Weisbecker
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index ef6d3ae239b9..e5afc63bd97f 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -1243,6 +1243,12 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
> > >                   cpu != outgoingcpu)
> > >                       cpumask_set_cpu(cpu, cm);
> > >       cpumask_and(cm, cm, housekeeping_cpumask(HK_TYPE_RCU));
> > > +     /*
> > > +      * For concurrent offlining, bit of qsmaskinitnext is not cleared yet.
> > > +      * So resort to cpu_dying_mask, whose changes has already been visible.
> > > +      */
> > > +     if (outgoingcpu != -1)
> > > +             cpumask_andnot(cm, cm, cpu_dying_mask);
> >
> > I'm not sure how the infrastructure changes in your concurrent down patchset
> > but can the cpu_dying_mask concurrently change at this stage?
> >
> 
> For the concurrent down patchset [1], it extends the cpu_down()
> capability to let an initiator to tear down several cpus in a batch
> and in parallel.
> 
> At the first step, all cpus to be torn down should experience
> cpuhp_set_state(cpu, st, CPUHP_TEARDOWN_CPU), by that way, they are
> set in the bitmap cpu_dying_mask [2]. Then the cpu hotplug kthread on
> each teardown cpu can be kicked to work. (Indeed, [2] has a bug, and I
> need to fix it by using another loop to call
> cpuhp_kick_ap_work_async(cpu);)

So if I understand correctly there is a synchronization point for all
CPUs between cpuhp_set_state() and CPUHP_AP_RCUTREE_ONLINE ?

And how about rollbacks through cpuhp_reset_state() ?

Thanks.
