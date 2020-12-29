Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63044C433DB
	for <rcu@archiver.kernel.org>; Tue, 29 Dec 2020 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4EE207D1
	for <rcu@archiver.kernel.org>; Tue, 29 Dec 2020 14:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgL2OWR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 29 Dec 2020 09:22:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2OWR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 29 Dec 2020 09:22:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0603B207C9;
        Tue, 29 Dec 2020 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609251696;
        bh=ERpgRc9yRwdO3teFyki0WiW9JQkWRBJg8KXYQFDCYCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu+akvWKeZ9DcRQonagCQjWgBkdIBXC5iNh63uiGUARPfzaobsbRBO8tJD55Xsxh1
         2jqcpJOYZkP284XQIdAW0sccgVhMrnP+lYWU5VFsYmLCZRLKTD7TJwO5BN+TaVelKn
         8bmHvG8DuSVRIMJYRxf+t3nn0XkHkhBBF/uXmdXVILDrRVgOvvSFZH6t7EngfoE8GT
         wTFFSjSLzqU08k2UaSMiO0IZjMSI4Dt9HNLKOBov2t/0SStWkTSYFNdLIRHbZjJMvN
         PJrFogofWk8kOVjvhKoK2bFa8MTYFMRu3zg3iNl9DncLbaNupOYdtIEEtP7ZmbQf7R
         Z7Q0JBgwEJp9g==
Date:   Tue, 29 Dec 2020 15:21:34 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/19] rcu/nocb: De-offload and re-offload support v4
Message-ID: <20201229142134.GB21613@lothringen>
References: <20201113121334.166723-1-frederic@kernel.org>
 <20201216165930.GJ2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216165930.GJ2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 16, 2020 at 08:59:30AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 13, 2020 at 01:13:15PM +0100, Frederic Weisbecker wrote:
> > 
> > Frederic Weisbecker (19):
> >       rcu/nocb: Turn enabled/offload states into a common flag
> >       rcu/nocb: Provide basic callback offloading state machine bits
> >       rcu/nocb: Always init segcblist on CPU up
> >       rcu/nocb: De-offloading CB kthread
> >       rcu/nocb: Don't deoffload an offline CPU with pending work
> >       rcu/nocb: De-offloading GP kthread
> >       rcu/nocb: Re-offload support
> >       rcu/nocb: Shutdown nocb timer on de-offloading
> >       rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
> >       rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
> >       rcu/nocb: Only cond_resched() from actual offloaded batch processing
> >       rcu/nocb: Process batch locally as long as offloading isn't complete
> >       rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete
> >       tools/rcutorture: Support nocb toggle in TREE01
> 
> I applied the above, with the usual commit-log wordsmithing.
> 
> >       rcutorture: Remove weak nocb declarations
> >       rcutorture: Export nocb (de)offloading functions
> 
> These I folded into the rcutorture commit, as you suggested.

Good!

> 
> >       cpu/hotplug: Add lockdep_is_cpus_held()
> >       timer: Add timer_curr_running()
> 
> I applied these two.
> 
> >       rcu/nocb: Detect unsafe checks for offloaded rdp
> 
> This one didn't apply, probably due to recent changes in -rcu.  Could
> you please take a look?

Ok I'm going to rebase it.

> I believe that the following enhancements will be needed:
> 
> o	Forbid toggling of offlined CPUs.  This is a simple rule that
> 	results in deterministic success or failure.  The current setup
> 	(which I freely admit that I suggested) will fail very rarely,
> 	only if a newly offlined offloaded CPU is toggled before its
> 	remaining callbacks are invoked.  The current state is therefore
> 	an accident waiting to happen.
> 
> 	This will entail fixing a few comments as well.

Sure, I'm always glad to remove lines!

> 
> o	Drain the bypass early in the de-offloading process and prohibit
> 	queuing onto the bypass anywhere in the toggling process.
> 	Then the only CPUs permitted to use the bypass are those that
> 	are fully offloaded.  This approach allows rcu_core() and the
> 	rcuog kthreads to safely manipulate callbacks and grace periods
> 	concurrently.  (Famous last words!)  This might address the
> 	rcutorture writer stall warnings I am seeing.
> 
> 	This will entail fixing a few comments as well.

Ok, I'm checking that.

> 
> o	Avoid double write to rdp->nocb_cb_sleep in nocb_cb_wait().
> 	Unless there is some reason why this is absolutely required.
> 	It will cause confusion as it is.

Ok.

> 
> o	What bad thing happens if we de-offload the CPU corresponding to
> 	the nocb GP kthread?  It does work fine when that CPU is offlined.
> 
> 	Coincidence or not, all but one of the rcutorture writer stalls
> 	is followed by a message refusing to de-offload this CPU.

It probably started with a brainfart that I elaborated a bit too far. Let me check
that again.

> 
> o	The nocb_gp_update_state() function's return value seems backwards.
> 	What am I missing here?

Indeed I should rename it to nocb_gp_check_rdp() or something.

> 
> o	__rcu_nocb_rdp_deoffload(): Why move rcu_nocb_lock_irqsave()
> 	across a comment?

Because the comment only concerns the locking?

> 
> o	We need better debug.  For example, "Can't deoffload an rdp GP
> 	leader (yet)".	Well, which CPU?  For another example, we need
> 	deoffload state in rcutorture writer-stall dumps.

Ok.

> 
> I intend to do the following, and, if feasible, fold them into the
> original commits:
> 
> o	Make rcu_segcblist_is_offloaded() use "&&" instead of a
> 	nested "if" statement.
> 
> o	nocb_cb_wait() needs the "^^^ Ensure CB invocation follows
> 	_sleep test" to be adjusted so that it is properly attached to
> 	its smp_load_acquire().
> 
> o	nocb_cb_wait() -- alphabetical order for local variables, please!
> 	Yeah, I know, others like inverted tree for reasons that escape me
> 	completely.

Ah, ok noted.

Thanks!

> 							Thanx, Paul
> 
> >  include/linux/cpu.h                                |   1 +
> >  include/linux/rcu_segcblist.h                      | 119 +++++-
> >  include/linux/rcupdate.h                           |   4 +
> >  include/linux/timer.h                              |   2 +
> >  kernel/cpu.c                                       |   7 +
> >  kernel/rcu/rcu_segcblist.c                         |  13 +-
> >  kernel/rcu/rcu_segcblist.h                         |  45 ++-
> >  kernel/rcu/rcutorture.c                            |   3 -
> >  kernel/rcu/tree.c                                  |  49 ++-
> >  kernel/rcu/tree.h                                  |   2 +
> >  kernel/rcu/tree_plugin.h                           | 416 +++++++++++++++++++--
> >  kernel/time/timer.c                                |  13 +
> >  .../selftests/rcutorture/configs/rcu/TREE01.boot   |   4 +-
> >  13 files changed, 614 insertions(+), 64 deletions(-)
