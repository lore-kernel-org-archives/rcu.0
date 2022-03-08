Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6BC433F5
	for <rcu@archiver.kernel.org>; Tue,  8 Mar 2022 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbiCHSLj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiCHSLi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Mar 2022 13:11:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B45676D
        for <rcu@vger.kernel.org>; Tue,  8 Mar 2022 10:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0782D6152E
        for <rcu@vger.kernel.org>; Tue,  8 Mar 2022 18:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EF3C340F7;
        Tue,  8 Mar 2022 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646763040;
        bh=KkPihUI/HStIAufz0PnU0WjYUTGObU+HYEiqP+5X5i0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k6cu1QJWvbu7zQqTBJSvXGKPNU9Spwgk49cD0MwFMZeyEy/0h+T8o+FHubBqsfhPF
         PNbZwAEcKrDObw/nZxgyfUsTp1LMy4isqoop1+2c6Ay007H7kZwckBUW38JYGU8hna
         fx7n1a80aSVdEO4KOiYg1iXFcTlV+f/EptNs+IC/d94Zi0qj358G2KXEjuFeG6zR9U
         jLsQpEPQxyZjZI1Ps6G1+bmx7v82VeT96a1AkWBCR5mfo9J5mV1fzDY5P9QFhGaBZF
         QPdheQkxUpmQBN7MygGLFjJiEWAGbkqwXRSf4JVxYvV2tHXN571xJHZ1xVvbLvj5Vy
         f1uWBTsq/UCQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E25E5C08A0; Tue,  8 Mar 2022 10:10:40 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:10:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu: Delay the RCU-selftests during boot.
Message-ID: <20220308181040.GV4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiIrtog8fQOExyVl@linutronix.de>
 <20220305050025.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <YiZGwQltzDSzMMDg@linutronix.de>
 <20220307215327.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <Yic+K7javne8UY5U@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yic+K7javne8UY5U@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 08, 2022 at 12:29:47PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-07 13:53:27 [-0800], Paul E. McKenney wrote:
> > > Correct, verified. But this means, that a task within a rcu_read_lock()
> > > section gets preempted for > 26 seconds before that timer fires. That
> > > delay during boot implies that something went wrong while it might
> > > happen at run-time under "normal" circumstances. So I wouldn't try to
> > > get this case covered.
> > 
> > The point being that there is no problem with the timer being queued,
> > just that it won't go off until later in the boot process.  Which in
> > turn means that all that is lost is the RCU CPU stall warning should one
> > be needed.  Is that correct, or am I missing a turn in there somewhere?
> 
> Correct. Before do_pre_smp_initcalls() there is no ksoftirqd so timers
> won't be processed. Therefore even the 26secs timer triggers, there
> will be no RCU-stall warning. Also I'm not sure how much of preemption
> can happen at this point since there is not much going on.
> Any delay at this points to a lockup and at this point the lockup
> detector isn't even fully operational (it does not trigger here during
> test).

Is sysrq operational at this point in RT?  If so, that can be used
to diagnose the hang, at least in development environments.  If the
need to use sysrq becomes a problem, checks/wakeups can be added to
rcu_sched_clock_irq().

> > > > > swait_event_timeout_exclusive() appears innocent.
> > > > 
> > > > I agree that it would rarely need to block, but if the task executing the
> > > > synchronize_rcu() preempted one of the readers, wouldn't it have to block?
> > > > Or am I missing some code path that excludes that possibility?
> > > 
> > > As explained above, it means ~20secs delay during bootup which I don't
> > > see happen. Once ksoftirqd is up, it is covered.
> > > Also: If _more_ users require a timer to expire so the system can
> > > continue to boot I am willing to investigate _why_ this is needed
> > > because it does delay boot up progress of the system.
> > 
> > Just to double-check -- in RT, ksoftirqd is up and running before the boot
> > sequence reaches the call to rcu_end_inkernel_boot() from kernel_init()?
> 
> Yes, this is the case.
> rcu_end_inkernel_boot() is really at the end of the boot process, we
> reached even SYSTEM_RUNNING ;)

Whew!  ;-)

> > This looks good to me, independent of the other discussion.  From what
> > I can see, this code path is infrequent, so using hrtimer all the time
> > should not be a problem.
> 
> Okay.
> 
> > Unless there are objections, I will pull this one in.
> 
> Good. Less patches for me to carry around.
> Thank you.

And here is what I ended up hand-applying, presumably due to differences
between -rt and -rcu.  I also expanded the changelog a bit.  Could you
please check to make sure that I didn't mess something up?

Oh, and I also couldn't resist taking advantage of 100 columns...
What can I say?

							Thanx, Paul

------------------------------------------------------------------------

commit 2895b3bb5f8a0ebe565c62b1d2e3e1efca669962
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue Mar 8 09:54:13 2022 -0800

    rcu-tasks: Use schedule_hrtimeout_range() to wait for grace periods
    
    The synchronous RCU-tasks grace-period-wait primitives invoke
    schedule_timeout_idle() to give readers a chance to exit their
    read-side critical sections.  Unfortunately, this fails during early
    boot on PREEMPT_RT because PREEMPT_RT relies solely on ksoftirqd to run
    timer handlers.  Because ksoftirqd cannot operate until its kthreads
    are spawned, there is a brief period of time following scheduler
    initialization where PREEMPT_RT cannot run the timer handlers that
    schedule_timeout_idle() relies on, resulting in a hang.
    
    To avoid this boot-time hang, this commit replaces schedule_timeout_idle()
    with schedule_hrtimeout(), so that the timer expires in hardirq context.
    This is ensures that the timer fires even on PREEMPT_RT throughout the
    irqs-enabled portions of boot as well as during runtime.
    
    The timer is set to expire between fract and fract + HZ / 2 jiffies in
    order to align with any other timers that might expire during that time,
    thus reducing the number of wakeups.
    
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 79eb280b1cd2a..bbad6b3376947 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -652,13 +652,16 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	fract = rtp->init_fract;
 
 	while (!list_empty(&holdouts)) {
+		ktime_t exp;
 		bool firstreport;
 		bool needreport;
 		int rtst;
 
 		// Slowly back off waiting for holdouts
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_idle(fract);
+		exp = jiffies_to_nsecs(fract);
+		__set_current_state(TASK_IDLE);
+		schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MODE_REL_HARD);
 
 		if (fract < HZ)
 			fract++;
