Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56978C4332B
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 23:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE6120753
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 23:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584662311;
	bh=1Iilp28i0bCTskgCsO8oASv9W7OdeQt1V3gTWMx3C9w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=U2jHJ4FdWTb6e9V0CwSE3Bh7d8esefwwS51ClsLq0tMcw4zcY1Ic9ojaWWey0Rtu1
	 s4RCjGm8Ion2Qh3R4/ZaPP8c5kWGAv2rKUOrWUer8i1grsbYzaG6UYo1Oi6CCGek9+
	 i27aR5ZWF0LwAtgR00UvubbEc/6/PA/M6jn/gOLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgCSX6a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgCSX6a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Mar 2020 19:58:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C21C20754;
        Thu, 19 Mar 2020 23:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584662309;
        bh=1Iilp28i0bCTskgCsO8oASv9W7OdeQt1V3gTWMx3C9w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=elmVnY1ABSGb+xRrvQ9PcXrqvEzg7FUzJ8x5d4XySe6/R7CY5EuUbuwIqVmiHvmYk
         Oeroik0vKThlwP2ABGqsFEnevbm2UG7svAs2L0l7b4i4BbWUfVJHHE05dawmBDhHpv
         h8Pn9EhppW+Ju+LisnA8r3T6cMvB0Hych4BTQ+lg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 49DA235226B9; Thu, 19 Mar 2020 16:58:29 -0700 (PDT)
Date:   Thu, 19 Mar 2020 16:58:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH RFC v2 tip/core/rcu 09/22] rcu-tasks: Add an RCU-tasks
 rude variant
Message-ID: <20200319235829.GK3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-9-paulmck@kernel.org>
 <20200319150432.1ac9dac9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319150432.1ac9dac9@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 19, 2020 at 03:04:32PM -0400, Steven Rostedt wrote:
> On Wed, 18 Mar 2020 17:10:47 -0700
> paulmck@kernel.org wrote:
> 
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds a "rude" variant of RCU-tasks that has as quiescent
> > states schedule(), cond_resched_tasks_rcu_qs(), userspace execution,
> > and (in theory, anyway) cond_resched().  In other words, RCU-tasks rude
> > readers are regions of code with preemption disabled, but excluding code
> > early in the CPU-online sequence and late in the CPU-offline sequence.
> > Updates make use of IPIs and force an IPI and a context switch on each
> > online CPU.  This variant is useful in some situations in tracing.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > [ paulmck: Apply EXPORT_SYMBOL_GPL() feedback from Qiujun Huang. ]
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  include/linux/rcupdate.h |  3 ++
> >  kernel/rcu/Kconfig       | 12 +++++-
> >  kernel/rcu/tasks.h       | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 112 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 5523145..2be97a8 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -37,6 +37,7 @@
> >  /* Exported common interfaces */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func);
> >  void rcu_barrier_tasks(void);
> > +void rcu_barrier_tasks_rude(void);
> >  void synchronize_rcu(void);
> >  
> >  #ifdef CONFIG_PREEMPT_RCU
> > @@ -138,6 +139,8 @@ static inline void rcu_init_nohz(void) { }
> >  #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t)
> >  void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
> >  void synchronize_rcu_tasks(void);
> > +void call_rcu_tasks_rude(struct rcu_head *head, rcu_callback_t func);
> > +void synchronize_rcu_tasks_rude(void);
> >  void exit_tasks_rcu_start(void);
> >  void exit_tasks_rcu_finish(void);
> >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index 38475d0..0d43ec1 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -71,7 +71,7 @@ config TREE_SRCU
> >  	  This option selects the full-fledged version of SRCU.
> >  
> >  config TASKS_RCU_GENERIC
> > -	def_bool TASKS_RCU
> > +	def_bool TASKS_RCU || TASKS_RUDE_RCU
> >  	select SRCU
> >  	help
> >  	  This option enables generic infrastructure code supporting
> > @@ -84,6 +84,16 @@ config TASKS_RCU
> >  	  only voluntary context switch (not preemption!), idle, and
> >  	  user-mode execution as quiescent states.  Not for manual selection.
> >  
> > +config TASKS_RUDE_RCU
> > +	def_bool 0
> > +	default n
> 
> No need for "default n" as that's the default without it.

Removed!

> > +	help
> > +	  This option enables a task-based RCU implementation that uses
> > +	  only context switch (including preemption) and user-mode
> > +	  execution as quiescent states.  It forces IPIs and context
> > +	  switches on all online CPUs, including idle ones, so use
> > +	  with caution.  Not for manual selection.
> 
> Really don't need the "Not for manual selection", as not having a prompt
> shows that too.

And also removed.

> > +
> >  config RCU_STALL_COMMON
> >  	def_bool TREE_RCU
> >  	help
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index d77921e..7ba1730 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -180,6 +180,9 @@ static void __init rcu_tasks_bootup_oddness(void)
> >  	else
> >  		pr_info("\tTasks RCU enabled.\n");
> >  #endif /* #ifdef CONFIG_TASKS_RCU */
> > +#ifdef CONFIG_TASKS_RUDE_RCU
> > +	pr_info("\tRude variant of Tasks RCU enabled.\n");
> > +#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
> >  }
> >  
> >  #endif /* #ifndef CONFIG_TINY_RCU */
> > @@ -410,3 +413,98 @@ static int __init rcu_spawn_tasks_kthread(void)
> >  core_initcall(rcu_spawn_tasks_kthread);
> >  
> >  #endif /* #ifdef CONFIG_TASKS_RCU */
> > +
> > +#ifdef CONFIG_TASKS_RUDE_RCU
> > +
> > +////////////////////////////////////////////////////////////////////////
> > +//
> > +// "Rude" variant of Tasks RCU, inspired by Steve Rostedt's trick of
> > +// passing an empty function to schedule_on_each_cpu().  This approach
> > +// provides an asynchronous call_rcu_rude() API and batching of concurrent
> > +// calls to the synchronous synchronize_rcu_rude() API.  This sends IPIs
> > +// far and wide and induces otherwise unnecessary context switches on all
> > +// online CPUs, whether online or not.
> 
>    "on all online CPUs, whether online or not" ????

Good catch!  It should be "whether idle or not".  Fixed.  ;-)

							Thanx, Paul

> -- Steve
> 
> > +
> > +// Empty function to allow workqueues to force a context switch.
> > +static void rcu_tasks_be_rude(struct work_struct *work)
> > +{
> > +}
> > +
