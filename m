Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EACC433EF
	for <rcu@archiver.kernel.org>; Mon,  7 Mar 2022 21:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbiCGVyZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiCGVyY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Mar 2022 16:54:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8B4755B
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 13:53:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2E9160B8E
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 21:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D103C340E9;
        Mon,  7 Mar 2022 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646690008;
        bh=Wxy/iiqVXkrunFXhH27UOlM/zd0jFrJv3iW7Y68vUzQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PD/4Sq7AUmRMkCfX8ugyUwZ+nxoyZ4qFO4xAv7Os4etoc/favixYUJ7+MPYmjKt2d
         +IBkVppopDja8xpwgm0Fcan5yDGGePvg7A3wjl8fovPW6l3W95i0j+PomDzV0NiynD
         SPe0L9/crpS9V3vAeCEUXbILmw6T0pzUX92qHqrQm+0S2m1tFkk3zK6WiSVkO4P2oV
         kHkkTml2It6OVfANu6BYlFbQJc02OXYRant3a9SAxa65IvCOIGa9XRlcmeK2XiQjWf
         0SRAAA+srp8FwuhU7NlvtWyVm6enkdRDRp1X8+wJDhToUYVJM363SaVHwyFd8vrSQL
         f4ArB+OzllalA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC64C5C0260; Mon,  7 Mar 2022 13:53:27 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:53:27 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220307215327.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiIrtog8fQOExyVl@linutronix.de>
 <20220305050025.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <YiZGwQltzDSzMMDg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiZGwQltzDSzMMDg@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 07, 2022 at 06:54:09PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-04 21:00:25 [-0800], Paul E. McKenney wrote:
> > > During SYSTEM_BOOTING we could do softirqs right away but we lack the
> > > infrastructure. Starting with SYSTEM_SCHEDULING we rely on the thread so
> > > it needs to be spawned earlier. The problem with SYSTEM_SCHEDULING+ is
> > > that we may deadlock if the softirqs and performed in IRQ-context.
> > 
> > Understood.  My goal is to prevent RCU from being yet another odd
> > constraint that people writing boot-time code need to worry about.
> > Or at least no additional odd constraints than the ones that it already
> > presents.  :-/
> 
> Do we have that many people doing boot-time code before
> early_initcall()?

It only takes one with an urgent and valid use case who happens to pop
up at a time that is highly inconvenient to all of us.

> > > > This might seem a bit utopian or even unreasonable, but please keep in
> > > > mind that both the scheduler and the idle loop use RCU.
> > > 
> > > But the problem is only the usage of synchronize_rcu().
> > 
> > And synchronize_rcu_expedited(), but yes in that call_rcu() and so
> > on still work.
> 
> That should be the majority of the users.

Again, it only takes one.

> > >                                                         So
> > > rcu_read_lock() and call_rcu() works. Only synchronize_rcu() does not.
> > > Couldn't we make a rule to use at earliest within early_initcall()?
> > 
> > Of course we could make such a rule.
> > 
> > And sometimes, people running into problems with that rule might be able
> > to move their code earlier or later and avoid problems.  But other times
> > they have to do something else.  Which will sometimes mean that we are
> > asking them to re-implement some odd special case of RCU within their
> > own subsystem, which just does not sound like a good idea.
> > 
> > In face, my experience indicates that it is way easier to make RCU work
> > more globally than to work all the issues stemming from these sorts of
> > limits on RCU users.  Takes less time, also.
> > 
> > And it probably is not all -that- hard.
> 
> We had one user _that_ early and he moved away. People might
> misunderstand things or optimize for something not really needed. If
> this is needed _before_ early_initcall() we could still move it right
> after the scheduler is initialized. I would just prefer not to optimize
> for things that might be never needed.
> For instance flush_workqueue() is made "working" a few functions
> earlier (before the RCU selftest). You could enqueue work items earlier,
> they would just wait until workqueue_init().

Or, like expedited grace periods currently do, use the current thread
instead of using workqueues during that time.

> > > > However, that swait_event_timeout_exclusive() doesn't need exact timing
> > > > during boot.  Anything that let other tasks run for at least a few tens
> > > > of microseconds (up to say a millisecond) could easily work just fine.
> > > > Is there any such thing in RT?
> > > 
> > > swait_event_timeout_exclusive() appears not to be the culprit. It is
> > > invoked a few times (with a 6.5ms timeout) but returns without setting
> > > up a timer. So either my setup avoids the timer or this happens always
> > > and is not related to my config).
> > 
> > Now that you mention it, yes.  There is only one CPU, so unless you have
> > an odd series of preemptions, it quickly figures out that it does not
> > need to wait.  But that odd series of preemptions really is out there,
> > patiently waiting for us to lose context on this code.
> 
> Correct, verified. But this means, that a task within a rcu_read_lock()
> section gets preempted for > 26 seconds before that timer fires. That
> delay during boot implies that something went wrong while it might
> happen at run-time under "normal" circumstances. So I wouldn't try to
> get this case covered.

The point being that there is no problem with the timer being queued,
just that it won't go off until later in the boot process.  Which in
turn means that all that is lost is the RCU CPU stall warning should one
be needed.  Is that correct, or am I missing a turn in there somewhere?

> > > rcu_tasks_wait_gp() does schedule_timeout_idle() and this is the one
> > > that blocks. This could be replaced with schedule_hrtimeout() (just
> > > tested). I hate the idea to use a precise delay in a timeout like
> > > situation. But we could use schedule_hrtimeout_range() with a HZ delta
> > > so it kind of feels like the timer_list timer ;)
> > 
> > If schedule_hrtimeout_range() works, I am good with it.
> > And you are right, precision is not required here.  And maybe
> > schedule_hrtimeout_range() could also be used to create a crude
> > boot-time-only polling loop for the swait_event_timeout_exclusive()?
> 
> I made something to cover the schedule_hrtimeout_range(). I wouldn't
> bother with swait_event_timeout_exclusive() due to large timeout _and_
> we are boot-up.

I welcome the schedule_hrtimeout_range() patch, thank you!

> > > swait_event_timeout_exclusive() appears innocent.
> > 
> > I agree that it would rarely need to block, but if the task executing the
> > synchronize_rcu() preempted one of the readers, wouldn't it have to block?
> > Or am I missing some code path that excludes that possibility?
> 
> As explained above, it means ~20secs delay during bootup which I don't
> see happen. Once ksoftirqd is up, it is covered.
> Also: If _more_ users require a timer to expire so the system can
> continue to boot I am willing to investigate _why_ this is needed
> because it does delay boot up progress of the system.

Just to double-check -- in RT, ksoftirqd is up and running before the boot
sequence reaches the call to rcu_end_inkernel_boot() from kernel_init()?

Otherwise, there is also a one-jiffy wait in play, not just a 20+-second
delay.

> > > > These would be conditioned on IS_ENABLED(CONFIG_PREEMPT_RT).
> > > > 
> > > > But now you are going to tell me that wakeups cannot be done from the
> > > > scheduler tick interrupt handler?  If that is the case, are there other
> > > > approaches?
> > > 
> > > If you by my irqwork patch then I think we are down to:
> > > - spawn ksoftirqd early
> > > - use during boot schedule_hrtimeout() or the whole time (no I idea how
> > >   often this triggers).
> > 
> > The boot-time schedule_hrtimeout_range() seems to cover things, especially
> > given that most of the time there would be no need to block.  Or is
> > there yet another gap where schedule_hrtimeout_range() does not work?
> > (After the scheduler starts.)
> 
> The patch below covers it. This works once the system has a working
> timer which aligns with !RT.
> I've been testing this and understand that tracing is using it. I didn't
> manage to trigger it after boot so I assume here that the user can't
> easily trigger that timer _very_ often.

This looks good to me, independent of the other discussion.  From what
I can see, this code path is infrequent, so using hrtimer all the time
should not be a problem.

Unless there are objections, I will pull this one in.

							Thanx, Paul

> -------->8-----
> 
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Mon, 7 Mar 2022 17:08:23 +0100
> Subject: [PATCH] rcu-tasks: Use schedule_hrtimeout_range() while waiting for
>  the gp.
> 
> The RCU selftest is using schedule_timeout_idle() which fails on
> PREEMPT_RT because it is used early in boot-up phase an which point
> ksoftirqd is not yet ready and is required for the timer to expire.
> 
> To avoid this lockup, use schedule_hrtimeout() and let the timer expire
> in hardirq context. This is ensures that the timer fires even on
> PREEMPT_RT without any further requirement.
> 
> The timer is set to expire between fract and fract + HZ / 2 jiffies in
> order to minimize the amount of extra wake ups and to allign with
> possible other timer which expire within this window.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/rcu/tasks.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index f804afb304135..e99f9e61cc7a3 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -630,12 +630,15 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
>  	while (!list_empty(&holdouts)) {
>  		bool firstreport;
>  		bool needreport;
> +		ktime_t exp;
>  		int rtst;
>  
>  		/* Slowly back off waiting for holdouts */
>  		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
> -		schedule_timeout_idle(fract);
> -
> +		exp = jiffies_to_nsecs(fract);
> +		__set_current_state(TASK_IDLE);
> +		schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2),
> +					 HRTIMER_MODE_REL_HARD);
>  		if (fract < HZ)
>  			fract++;
>  
> -- 
> 2.35.1
> 
