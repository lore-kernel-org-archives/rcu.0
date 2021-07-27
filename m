Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4EC4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 19:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D8BF60C51
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 19:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhG0T0J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhG0T0I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 15:26:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592BFC061757
        for <rcu@vger.kernel.org>; Tue, 27 Jul 2021 12:26:08 -0700 (PDT)
Date:   Tue, 27 Jul 2021 21:26:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627413967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/NVEIAMp2sardL2HjycSRyAcJiE4vFj0XnsNwOSpf4=;
        b=RZvt9USgdQoDDhPHokWg5CbwZmCG80aWPgX46NY7yqaPbrEYBocy5YJRL7rl+nUaWBm83A
        ls1BVekmKf7GS/kyhGdKq+OIuTwAIQyYiVrlRFvdDvKMy1+nrtsUMTwxVkKGpSNA9hebE0
        b9A34JUCqJANsce7TlRZ9X9mFLXdZFxsx5i8GuD9eMTrnFOicaX/ySiDtTeREyQIPMJUAa
        zPfIdQO5uEwY5TYgfSlXRbgyA4pSy7j4Ef0J81lAgasFh8yXxMk0fC6QoP0Wwk9ggMI1Lx
        u5xsVHlv9YhccFIqtEIVSlN4LicLBN5jcFajwvcMAuUMFO3ed7bPEnOrT9Z+Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627413967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T/NVEIAMp2sardL2HjycSRyAcJiE4vFj0XnsNwOSpf4=;
        b=8ykXixJ3Pvgahuw/rdUz2x6XdDbOrmg7BOQ9FYe/4gs2XWAjyd3y4d6EMY0M5Bb1BK+ji/
        vwRSduC8qNhQ42Bg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by
 migrate_disable
Message-ID: <20210727192605.7q6ez2kbhd3a64wy@linutronix.de>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
 <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-07-27 10:23:51 [-0700], Paul E. McKenney wrote:
> > I don't fully understand why the CPU-hotplug lock matters here but this
> > is beside the point ;)
> 
> If I remember correctly, any attempt to change the offloaded state
> must hold off CPU-hotplug operations.  So if the current thread is
> holding off CPU-hotplug operations, no other thread can be doing
> an offload or de-offload operation.

I'm not sure what you mean by "change the offloaded state". If the
CPU-hotplug read-lock is acquired you are still preemptible. So you
could migrate to another CPU at which point this_cpu_ptr(&rcu_data)
would change.

> >  kernel/rcu/tree_plugin.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 0ff5e4fb933e7..d8a623ba7d243 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -57,16 +57,18 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> >  	 * timers have their own means of synchronization against the
> >  	 * offloaded state updaters.
> >  	 */
> > +#ifdef CONFIG_SMP
> >  	RCU_LOCKDEP_WARN(
> >  		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
> >  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
> >  		  rcu_lockdep_is_held_nocb(rdp) ||
> >  		  (rdp == this_cpu_ptr(&rcu_data) &&
> > -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> > +		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) ||
> 
> 
> > +		    current->migration_disabled)) ||
> 
> How does this change interact with the one proposed by Valentin?
> 
> https://lore.kernel.org/lkml/20210721115118.729943-3-valentin.schneider@arm.com/

So by looking at the series, it does the same thing. I would prefer
is_pcpu_stable() rather then is_pcpu_safe() but that is a different
topic.
If we settle for this series instead someone should respond to that
thread. Let me see if I find someone.
I'm fine either way :)

Thanks Paul.

> 							Thanx, Paul
> 
> >  		  rcu_current_is_nocb_kthread(rdp)),
> >  		"Unsafe read of RCU_NOCB offloaded state"
> >  	);
> > -
> > +#endif
> >  	return rcu_segcblist_is_offloaded(&rdp->cblist);
> >  }
> >  

Sebastian
