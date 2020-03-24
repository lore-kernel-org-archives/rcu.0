Return-Path: <SRS0=d/lD=5J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC0C43331
	for <rcu@archiver.kernel.org>; Tue, 24 Mar 2020 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7CE20789
	for <rcu@archiver.kernel.org>; Tue, 24 Mar 2020 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070428;
	bh=CVbMliaiLHetlonWgeHh8YD4+hWUwi8kmYwVaNcUO/Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bfPZQQg/JCrqqD5iAymsEVp1zMvj65bFR0RaOsud4jS4yJoRj+oYmkp3ObF1zzBv5
	 In2cH4fR38w0ZcZsMtkTKEAoQZrArjeaoB6J5VF8Uli1oquKuH2PBXelsvHoi+8wmn
	 p0xVXe5D+5q9lmHsl/aSqWfDlz4HlELCfigAo7kY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCXRU1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgCXRU1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Mar 2020 13:20:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4165B20775;
        Tue, 24 Mar 2020 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070426;
        bh=CVbMliaiLHetlonWgeHh8YD4+hWUwi8kmYwVaNcUO/Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=2eeNrOWUP4FIZWMFRr2Hkiu9jTYyu7ckc3jgSNndp0ACWBvbY/IB5yyCkKToIBHzR
         j1+2VkC6GKbYp/RUxs3Gr9LFOy62dAygPaXTxrHfm8VfbfIZY41LKOIWb+pv+oOhSE
         n6Wti62syCC1VH2rGVDwA3ZTS++P3eM9MjCmqv1c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 15B9A352275F; Tue, 24 Mar 2020 10:20:26 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:20:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        vpillai@digitalocean.com
Subject: Re: [PATCH RFC v2 tip/core/rcu 01/22] sched/core: Add function to
 sample state of locked-down task
Message-ID: <20200324172026.GK19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200319001100.24917-1-paulmck@kernel.org>
 <20200319132238.75a034c3@gandalf.local.home>
 <20200319173525.GI3199@paulmck-ThinkPad-P72>
 <20200320024943.GA29649@paulmck-ThinkPad-P72>
 <20200324000639.GA29340@google.com>
 <20200324154822.GC19865@paulmck-ThinkPad-P72>
 <20200324165255.GA242454@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324165255.GA242454@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 24, 2020 at 12:52:55PM -0400, Joel Fernandes wrote:
> On Tue, Mar 24, 2020 at 08:48:22AM -0700, Paul E. McKenney wrote:
> [..] 
> > > 
> > > > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > > > index 44edd0a..43991a4 100644
> > > > --- a/kernel/rcu/tree.h
> > > > +++ b/kernel/rcu/tree.h
> > > > @@ -455,6 +455,8 @@ static void rcu_bind_gp_kthread(void);
> > > >  static bool rcu_nohz_full_cpu(void);
> > > >  static void rcu_dynticks_task_enter(void);
> > > >  static void rcu_dynticks_task_exit(void);
> > > > +static void rcu_dynticks_task_trace_enter(void);
> > > > +static void rcu_dynticks_task_trace_exit(void);
> > > >  
> > > >  /* Forward declarations for tree_stall.h */
> > > >  static void record_gp_stall_check_time(void);
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index 9355536..f4a344e 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -2553,3 +2553,21 @@ static void rcu_dynticks_task_exit(void)
> > > >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> > > >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> > > >  }
> > > > +
> > > > +/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > > +static void rcu_dynticks_task_trace_enter(void)
> > > > +{
> > > > +#ifdef CONFIG_TASKS_RCU_TRACE
> > > > +	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > > > +		current->trc_reader_special.b.need_mb = true;
> > > 
> > > If this is every called from middle of a reader section (that is we
> > > transition from IPI-mode to using heavier reader-sections), then is a memory
> > > barrier needed here just to protect the reader section that already started?
> > 
> > That memory barrier is provided by the memory ordering in the callers
> > of rcu_dynticks_task_trace_enter() and rcu_dynticks_task_trace_exit(),
> > namely, those callers' atomic_add_return() invocations.  These barriers
> > pair with the pair of smp_rmb() calls in rcu_dynticks_zero_in_eqs(),
> > which is in turn invoked from the function formerly known as
> > trc_inspect_reader_notrunning(), AKA trc_inspect_reader().
> > 
> > This same pair of smp_rmb() calls also pair with the conditional smp_mb()
> > calls in rcu_read_lock_trace() and rcu_read_unlock_trace().
> > 
> > In your scenario, the calls in rcu_read_lock_trace() and
> > rcu_read_unlock_trace() wouldn't happen, but in that case the ordering
> > from atomic_add_return() would suffice.
> > 
> > Does that work?  Or is there an ordering bug in there somewhere?
> 
> Thanks for explaining. Could the following scenario cause a problem?
> 
> If we consider the litmus test:
> 
> {
> int x = 1;
> int *y = &x;
> int z = 1;
> }
> 
> P0(int *x, int *z, int **y)
> {
> 	int *r0;
> 	int r1;
> 
> 	dynticks_eqs_trace_enter();
> 
> 	rcu_read_lock();
> 	r0 = rcu_dereference(*y);
> 
> 	dynticks_eqs_trace_exit(); // cut-off reader's mb wings :)

RCU Tasks Trace currently assumes that a reader will not start within
idle and end outside of idle.  However, keep in mind that eqs exit
implies a full memory barrier and changes the ->dynticks counter.
The call to rcu_dynticks_task_trace_exit() is not standalone.  Instead,
the atomic_add_return() immediately preceding that call is critically
important.  And ditto for rcu_dynticks_task_trace_enter() and the
atomic_add_return() immediately following it.

The overall effect is similar to that of sequence locks.

> 	r1 = READ_ONCE(*r0); // Reordering of this beyond the unlock() is bad.
> 	rcu_read_unlock();
> }
> 
> P1(int *x, int *z, int **y)
> {
> 	rcu_assign_pointer(*y, z);
> 	synchronize_rcu();
> 	WRITE_ONCE(*x, 0);
> }
> 
> exists (0:r0=x /\ 0:r1=0)
> 
> Then the following situation can happen?
> 
> 	READER					UPDATER
> 
> 						y = &z;
> 
> 	eqs_enter(); // full-mb
> 
> 	rcu_read_lock(); // full-mb
> 	// r0 = x;
> 						// GP-start
> 						// ..zero_in_eqs() notices eqs, no IPI
> 	eqs_exit(); // full-mb
> 
> 	// actual r1 = *x but will reorder
> 
> 	rcu_read_unlock(); // no-mb
> 						// GP-finish as notices nesting = 0
> 						x = 0;

Followed by an smp_rmb() followed the second read of ->dynticks, which
will see a non-zero bottom bit for ->dynticks, and thus return false.
This in turn will cause the possible zero nesting counter to be ignored.

> 	// reordered r1 = *x = 0;
> 
> 
> Basically r0=x /\ r1=0 happened because r1=0. Or did I miss something that
> prevents it?

Yes, the change in value of ->dynticks and the full ordering associated
with the atomic_add_return() that makes this change.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> 
> > > thanks,
> > > 
> > >  - Joel
> > > 
> > > 
> > > > +#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
> > > > +}
> > > > +
> > > > +/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
> > > > +static void rcu_dynticks_task_trace_exit(void)
> > > > +{
> > > > +#ifdef CONFIG_TASKS_RCU_TRACE
> > > > +	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > > > +		current->trc_reader_special.b.need_mb = false;
> > > > +#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
> > > > +}
