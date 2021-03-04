Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E327C433DB
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 20:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D21664E6C
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhCDUHP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237970AbhCDUHF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Mar 2021 15:07:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9D664F70;
        Thu,  4 Mar 2021 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614888384;
        bh=1E47zo1UX1daMBkM4qjbkmwt7RCf0Z/zmzP302jpzvk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ESZ1zD1BDEfhn5vcQuVXG+O8rmO8vwR8D7S60IGkdnckssg0c6zRGrHTAD5mOgJeg
         HrLj/a7PYOcsipO8oRlm89deUoCaekzKLGn1LUI/YbYiN8B7AVGqPUMC/9Cak+Ez2o
         +VseoP761bOmvHFRXK+GiaGe4Wj5H/IoDS5bfc/XojrA48r5RWWPWqXjwyL+dF+Hf/
         NB/t0EvER4fJcRQHbxGl5mmVZ6sS+aJA37L7MUFxm5iBBymrjgM0plKSfY21gmZgJ9
         fnUR5wx1OTmMU9/IIJ5oN0nj6txa18DaPT6tMG2YKZfoTrPOwrnF/IwU2tWEytTsAF
         RVgAlyP9IOp0g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8A38035226C1; Thu,  4 Mar 2021 12:06:24 -0800 (PST)
Date:   Thu, 4 Mar 2021 12:06:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH tip/core/rcu 02/12] timer: Report ignored local enqueue
 in nohz mode
Message-ID: <20210304200624.GU2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
 <20210304002311.23655-2-paulmck@kernel.org>
 <a1bac9f6-cc67-943d-0f88-aad2f2b46bd7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bac9f6-cc67-943d-0f88-aad2f2b46bd7@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 04, 2021 at 12:58:54PM +0100, Rafael J. Wysocki wrote:
> On 3/4/2021 1:23 AM, paulmck@kernel.org wrote:
> > From: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Enqueuing a local timer after the tick has been stopped will result in
> > the timer being ignored until the next random interrupt.
> > 
> > Perform sanity checks to report these situations.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar<mingo@kernel.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied, thank you!

							Thanx, Paul

> > ---
> >   kernel/sched/core.c | 24 +++++++++++++++++++++++-
> >   1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ca2bb62..4822371 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -674,6 +674,26 @@ int get_nohz_timer_target(void)
> >   	return cpu;
> >   }
> > +static void wake_idle_assert_possible(void)
> > +{
> > +#ifdef CONFIG_SCHED_DEBUG
> > +	/* Timers are re-evaluated after idle IRQs */
> > +	if (in_hardirq())
> > +		return;
> > +	/*
> > +	 * Same as hardirqs, assuming they are executing
> > +	 * on IRQ tail. Ksoftirqd shouldn't reach here
> > +	 * as the timer base wouldn't be idle. And inline
> > +	 * softirq processing after a call to local_bh_enable()
> > +	 * within idle loop sound too fun to be considered here.
> > +	 */
> > +	if (in_serving_softirq())
> > +		return;
> > +
> > +	WARN_ON_ONCE("Late timer enqueue may be ignored\n");
> > +#endif
> > +}
> > +
> >   /*
> >    * When add_timer_on() enqueues a timer into the timer wheel of an
> >    * idle CPU then this timer might expire before the next timer event
> > @@ -688,8 +708,10 @@ static void wake_up_idle_cpu(int cpu)
> >   {
> >   	struct rq *rq = cpu_rq(cpu);
> > -	if (cpu == smp_processor_id())
> > +	if (cpu == smp_processor_id()) {
> > +		wake_idle_assert_possible();
> >   		return;
> > +	}
> >   	if (set_nr_and_not_polling(rq->idle))
> >   		smp_send_reschedule(cpu);
> 
> 
