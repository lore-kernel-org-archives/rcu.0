Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1AAC433F5
	for <rcu@archiver.kernel.org>; Mon,  7 Mar 2022 15:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiCGPKM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiCGPKL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Mar 2022 10:10:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B0C4BFC5
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 07:09:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6507761356
        for <rcu@vger.kernel.org>; Mon,  7 Mar 2022 15:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A3C340E9;
        Mon,  7 Mar 2022 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646665753;
        bh=Gd0q1+zYGALptQcQA7WaJb84NmUkTbH89e/Xhfi9X9A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RpB0p/hmQvL2z4HQyaSaBP/zap/W7mI8ZpambhKp0IW5BJ7GeJgZstLY8jQMgei/V
         CUpSsMlV+XlOmsPPeWl+jGUpK0h71FaX9nNo0h5XO+UzePyV86GHhGKj871nTWplar
         sYyY+KXG2UAYo3cex6j7pEPmY7k94jBSFPGjeeqzwJErgXhqk2qPqyn7DcUNdWQ7ov
         goHf6xiJU8Wr8Xcax+xRtAF/kPTry9AnUaOC0FSX+stAd+1ZsIYif7cJma6glbLYrS
         5I20rFChwMeP/B+11INQbPIxrZ+9vOMbOLDZQ2K8tbCNTobJSlNN08GDEFCIPLdNhI
         Wo6vE8PdozvPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 660695C024E; Mon,  7 Mar 2022 07:09:13 -0800 (PST)
Date:   Mon, 7 Mar 2022 07:09:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <20220307150913.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <YiHy7Y5fTU3jRdMi@linutronix.de>
 <20220305044007.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <YiXp4+2atG0Ni2rJ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiXp4+2atG0Ni2rJ@linutronix.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 07, 2022 at 12:17:55PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-03-04 20:40:07 [-0800], Paul E. McKenney wrote:
> > > This is what I had in mind. Does this work for you?
> > 
> > This does seem to be working, thank you!  I even manually inserted
> > a pi_lock() acquisition across one of the calls to call_rcu_tasks(),
> > and it did seem to work.
> 
> perfect.

Sounds like I should add that to rcutorture.

> > >  kernel/rcu/tasks.h | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index d64f0b1d8cd3b..f804afb304135 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -113,11 +113,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> > >  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
> > >  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
> > >  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
> > > -	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
> > > +	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
> > 
> > This is the key piece, right? 
> 
> Correct. Possible due to the removal of wait_queue_head (plus there is
> nothing else that would stand in the way otherwise).

Very good!

If the overhead becomes a problem in mainline, presumably we can do
a compile-time switch based on CONFIG_PREEMPT_RT or similar.

> > If so, I am wondering if there are other
> > irq_work instances that need to move to _HARD.
> 
> We already have:
> kernel/rcu/tree.c:      rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);

Because you prompted me to change it from IRQ_WORK_INIT() some time
back?  ;-)

							Thanx, Paul
