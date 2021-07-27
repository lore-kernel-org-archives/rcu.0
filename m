Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C997C4338F
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA41260F6B
	for <rcu@archiver.kernel.org>; Tue, 27 Jul 2021 23:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhG0X00 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232314AbhG0X00 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Jul 2021 19:26:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B26460234;
        Tue, 27 Jul 2021 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627428386;
        bh=JTO6D3Oqquv/hIGkpJkaGESS3ElgJo7cIlMXI79V4i8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7RkpGxEcSYr7GTNAURTW6SCbXFi6RSVczAGG8cyFCsn/jyOS6COcqh5qgxkyiXvM
         bdWI3SzZxs6d85obgTJZyTDLZPm0Djd6cPZsNOF8RGCRWTk50SZbAmHQm9/HJojJ/f
         i82cR01OXyQbbxDzuQQORoutAivKtNkN0qyuKosXDHVZFwmU15KR3B9AJrUq9Xq/NY
         dxYyoNy6xd+2mREUGhULKwSLYD0ZPAUEhtKtrXDE19dbC29QVUB4aDFibn/NiIuetU
         jLvRWyAK6wStUtr6+iFmQhinNXgnjCgpD1wziGVh4C+Vd6Gi98NQrFrrWomKzDow0O
         M2fwInYv11r3A==
Date:   Wed, 28 Jul 2021 01:26:23 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu/nocb: Extend checks for offloaded rdp by
 migrate_disable
Message-ID: <20210727232623.GE283787@lothringen>
References: <20210727163815.nwvg5delbqs3ysxl@linutronix.de>
 <20210727172351.GC4397@paulmck-ThinkPad-P17-Gen-1>
 <20210727192605.7q6ez2kbhd3a64wy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727192605.7q6ez2kbhd3a64wy@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 27, 2021 at 09:26:05PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-07-27 10:23:51 [-0700], Paul E. McKenney wrote:
> > > I don't fully understand why the CPU-hotplug lock matters here but this
> > > is beside the point ;)
> > 
> > If I remember correctly, any attempt to change the offloaded state
> > must hold off CPU-hotplug operations.  So if the current thread is
> > holding off CPU-hotplug operations, no other thread can be doing
> > an offload or de-offload operation.
> 
> I'm not sure what you mean by "change the offloaded state". If the
> CPU-hotplug read-lock is acquired you are still preemptible. So you
> could migrate to another CPU at which point this_cpu_ptr(&rcu_data)
> would change.

Sure but it's fine to read the offloaded state of a remote CPU if
CPU hotplug lock is held.

> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index 0ff5e4fb933e7..d8a623ba7d243 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -57,16 +57,18 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> > >  	 * timers have their own means of synchronization against the
> > >  	 * offloaded state updaters.
> > >  	 */
> > > +#ifdef CONFIG_SMP
> > >  	RCU_LOCKDEP_WARN(
> > >  		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
> > >  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
> > >  		  rcu_lockdep_is_held_nocb(rdp) ||
> > >  		  (rdp == this_cpu_ptr(&rcu_data) &&
> > > -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> > > +		   (!(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible()) ||
> > 
> > 
> > > +		    current->migration_disabled)) ||
> > 
> > How does this change interact with the one proposed by Valentin?
> > 
> > https://lore.kernel.org/lkml/20210721115118.729943-3-valentin.schneider@arm.com/
> 
> So by looking at the series, it does the same thing. I would prefer
> is_pcpu_stable() rather then is_pcpu_safe() but that is a different
> topic.
> If we settle for this series instead someone should respond to that
> thread. Let me see if I find someone.
> I'm fine either way :)

Either way I believe it won't work, please check:

https://lore.kernel.org/lkml/20210727230814.GC283787@lothringen/

I wonder also, how many similar assumption out there do we have that
rely on softirqs not being preemptible. Most of them probably silent.

Thanks.
