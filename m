Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B64C433E0
	for <rcu@archiver.kernel.org>; Thu, 11 Mar 2021 23:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0CB64F8F
	for <rcu@archiver.kernel.org>; Thu, 11 Mar 2021 23:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCKXev (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Mar 2021 18:34:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhCKXeT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Mar 2021 18:34:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96BFE64F70;
        Thu, 11 Mar 2021 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615505658;
        bh=+biSB8+9HumjYwjTHZj/++Nwwgtz3v88RjLI9E9ic8k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hNu33VXsHxiXTtn+zhJfbMEmZbuaGnUw4bKMwQgy+AGnsqfdC+b3EpRdv79JkhcQf
         rVdfegrw8i2QCFo5eyxqBhWGNzB1i24TyLKKUcv6xUBXqOf4bOvJUWg7+BeTNPycRK
         FqbIlUdQAOP+oxNvO0VzLZ8FPWcwnaUEQdgIbucSQ/VsOf64XC9ZnbUO/SALf4aHVS
         xjzgDMCHVcVX961qNEBPFlZyMixQFytwiQhl1kUbTXvTPgDv4wS4Th5vgLJa3XjnJL
         P+q+hE7GkQ8UUYOjm/TWoJX8IMFxQUicmin69VYDDqfjxDm95j7C3nrBPM+MkUyY5d
         sl5eJrcu3c9ZQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 390C735239D7; Thu, 11 Mar 2021 15:34:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 15:34:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 07/10] rcu: Prevent dyntick-idle until
 ksoftirqd has been spawned
Message-ID: <20210311233418.GB2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
 <20210304000019.22459-7-paulmck@kernel.org>
 <20210311232357.GA29548@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311232357.GA29548@lothringen>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 12, 2021 at 12:23:57AM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 03, 2021 at 04:00:16PM -0800, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > After interrupts have enabled at boot but before some random point
> > in early_initcall() processing, softirq processing is unreliable.
> > If softirq sees a need to push softirq-handler invocation to ksoftirqd
> > during this time, then those handlers can be delayed until the ksoftirqd
> > kthreads have been spawned, which happens at some random point in the
> > early_initcall() processing.  In many cases, this delay is just fine.
> > However, if the boot sequence blocks waiting for a wakeup from a softirq
> > handler, this delay will result in a silent-hang deadlock.
> > 
> > This commit therefore prevents these hangs by ensuring that the tick
> > stays active until after the ksoftirqd kthreads have been spawned.
> > This change causes the tick to eventually drain the backlog of delayed
> > softirq handlers, breaking this deadlock.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_plugin.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 2d60377..36212de 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1255,6 +1255,11 @@ static void rcu_prepare_kthreads(int cpu)
> >   */
> >  int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> >  {
> > +	/* Through early_initcall(), need tick for softirq handlers. */
> > +	if (!IS_ENABLED(CONFIG_HZ_PERIODIC) && !this_cpu_ksoftirqd()) {
> > +		*nextevt = 1;
> > +		return 1;
> > +	}
> >  	*nextevt = KTIME_MAX;
> >  	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
> >  	       !rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist);
> > @@ -1350,6 +1355,12 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
> >  
> >  	lockdep_assert_irqs_disabled();
> >  
> > +	/* Through early_initcall(), need tick for softirq handlers. */
> > +	if (!IS_ENABLED(CONFIG_HZ_PERIODIC) && !this_cpu_ksoftirqd()) {
> > +		*nextevt = 1;
> > +		return 1;
> > +	}
> > +
> >  	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
> >  	if (rcu_segcblist_empty(&rdp->cblist) ||
> >  	    rcu_segcblist_is_offloaded(&this_cpu_ptr(&rcu_data)->cblist)) {
> 
> 
> I suspect rcutiny should be concerned as well?
> 
> In fact this patch doesn't look necessary because can_stop_idle_tick() refuse
> to stop the tick when softirqs are pending.

So it does, thank you!  I will drop this patch.

							Thanx, Paul
