Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDEDC56201
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A802224A
	for <rcu@archiver.kernel.org>; Thu, 19 Nov 2020 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofcG2IAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgKSTia (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKSTi3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 19 Nov 2020 14:38:29 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D646AC0613D4
        for <rcu@vger.kernel.org>; Thu, 19 Nov 2020 11:38:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so7777119wmb.5
        for <rcu@vger.kernel.org>; Thu, 19 Nov 2020 11:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=63CVBq/T3f539Pn43bgVAE7mj44tLgbi2uoq3Bi9slE=;
        b=ofcG2IAdOd00Si3++HWQxSQ6adLjUlaoebT+IIYa+BS1xIXey4o/OcS+F9gXCSJiHP
         r1zHVQBucx9ucSH3Dv7gQCrIYpvfHvhJjGPqIyijFWa40squGhRbOtkkl5v2XzeQTcOj
         prMHz9i+MeDXnSu+kaj7eix161dHeiq+SOZVwwPbLWg0Yz1Eu5WgxYwSTLKmJH8SZD8z
         9OEERXy5pA++zuZ8o3LZ0VVdNGk6cZwq059C2TYCgh0VUt8LGhdmgwBzdM5gwTU+Jqb9
         ZzE6seji1t/M1jtazgweTztQB7HnXr/iy9b5paO0zr/Y+yyfT+f4muwF3EZVKkDV0zHZ
         qGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=63CVBq/T3f539Pn43bgVAE7mj44tLgbi2uoq3Bi9slE=;
        b=q7PZDnw5YWRKz8YgGJLxcAquZ+rdkPH+lrqFgzriUNR/A65SLi3ZG+l1PqcYeauMvB
         v+dKNmhKX9o5uRVTF2lvxWlUwBjdY1Q68YTVxlqBqH43it+gl04CQxvuP2ys48Ckenfs
         6WFfeKq3Sf4C7kAluq6d0R0wk/Ovof33gMDrbbZMyt6sCR4L47N2zU9OrXYqO131gWPO
         Taxmo/MeCyyW3pqwZtoK9L7Q8qu6kNyi2ZTNkdAv/mFGXex55FZypsdwhXvFWYC8JLoC
         dRIxEsgVzfQLk8mp8mKpIhfxd/eQ5Ch4bkH06uhtZZo6cj1SKZ8njw9Ft3R+0FMfcW+7
         75mQ==
X-Gm-Message-State: AOAM5331/Du/W6o7emozJmXlk26q+bANndTh34QIiIfYoBAxHtfNHuE1
        z2g+jxmc32gDLISr21PhRiEamw==
X-Google-Smtp-Source: ABdhPJwBYDbCsBI+uccPgN5x4QxggRFh2cz+ir6rfBSC/Wh9pe/vAvSgcIdYw8dVZiWvIAie1H50Cg==
X-Received: by 2002:a05:600c:14d4:: with SMTP id i20mr6470722wmh.118.1605814706180;
        Thu, 19 Nov 2020 11:38:26 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id e5sm1319054wrs.84.2020.11.19.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 11:38:24 -0800 (PST)
Date:   Thu, 19 Nov 2020 20:38:19 +0100
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201119193819.GA2601289@elver.google.com>
References: <20201112175406.GF3249@paulmck-ThinkPad-P72>
 <20201113175754.GA6273@paulmck-ThinkPad-P72>
 <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20201119184854.GY1437@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2020 at 10:48AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 19, 2020 at 06:02:59PM +0100, Marco Elver wrote:
> > On Thu, Nov 19, 2020 at 07:14AM -0800, Paul E. McKenney wrote:
> > > On Thu, Nov 19, 2020 at 01:53:57PM +0100, Marco Elver wrote:
> > > > On Wed, Nov 18, 2020 at 03:38PM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Nov 18, 2020 at 11:56:21PM +0100, Marco Elver wrote:
> > > > > > [...]
> > > > > > I think I figured out one piece of the puzzle. Bisection keeps pointing
> > > > > > me at some -rcu merge commit, which kept throwing me off. Nor did it
> > > > > > help that reproduction is a bit flaky. However, I think there are 2
> > > > > > independent problems, but the manifestation of 1 problem triggers the
> > > > > > 2nd problem:
> > > > > > 
> > > > > > 1. problem: slowed forward progress (workqueue lockup / RCU stall reports)
> > > > > > 
> > > > > > 2. problem: DEADLOCK which causes complete system lockup
> > > > > > 
> > > > > > 	| ...
> > > > > > 	|        CPU0
> > > > > > 	|        ----
> > > > > > 	|   lock(rcu_node_0);
> > > > > > 	|   <Interrupt>
> > > > > > 	|     lock(rcu_node_0);
> > > > > > 	| 
> > > > > > 	|  *** DEADLOCK ***
> > > > > > 	| 
> > > > > > 	| 1 lock held by event_benchmark/105:
> > > > > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:493 [inline]
> > > > > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:652 [inline]
> > > > > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3752 [inline]
> > > > > > 	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x428/0xd40 kernel/rcu/tree.c:2581
> > > > > > 	| ...
> > > > > > 
> > > > > > Problem 2 can with reasonable confidence (5 trials) be fixed by reverting:
> > > > > > 
> > > > > > 	rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> > > > > > 
> > > > > > At which point the system always boots to user space -- albeit with a
> > > > > > bunch of warnings still (attached). The supposed "good" version doesn't
> > > > > > end up with all those warnings deterministically, so I couldn't say if
> > > > > > the warnings are expected due to recent changes or not (Arm64 QEMU
> > > > > > emulation, 1 CPU, and lots of debugging tools on).
> > > > > > 
> > > > > > Does any of that make sense?
> > > > > 
> > > > > Marco, it makes all too much sense!  :-/
> > > > > 
> > > > > Does the patch below help?
> > > > > 
> > > > > 							Thanx, Paul
> > > > > 
> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > commit 444ef3bbd0f243b912fdfd51f326704f8ee872bf
> > > > > Author: Peter Zijlstra <peterz@infradead.org>
> > > > > Date:   Sat Aug 29 10:22:24 2020 -0700
> > > > > 
> > > > >     sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
> > > > 
> > > > My assumption is that this is a replacement for "rcu: Don't invoke
> > > > try_invoke_on_locked_down_task() with irqs disabled", right?
> > > 
> > > Hmmm...  It was actually intended to be in addition.
> > > 
> > > > That seems to have the same result (same test setup) as only reverting
> > > > "rcu: Don't invoke..." does: still results in a bunch of workqueue
> > > > lockup warnings and RCU stall warnings, but boots to user space. I
> > > > attached a log. If the warnings are expected (are they?), then it looks
> > > > fine to me.
> > > 
> > > No, they are not at all expected, but might be a different symptom
> > > of the original problem.  Please see below.
> > > 
> > > > (And just in case: with "rcu: Don't invoke..." and "sched/core:
> > > > Allow..." both applied I still get DEADLOCKs -- but that's probably
> > > > expected.)
> > > 
> > > As noted earlier, it is a surprise.  Could you please send me the
> > > console output?
> >  
> > I've attached the output of a run with both commits applied.
> 
> Got it, thank you!
> 
> > > > Testing all events: OK
> > > > hrtimer: interrupt took 17120368 ns
> > > > Running tests again, along with the function tracer
> > > > Running tests on all trace events:
> > > > Testing all events: 
> > > > BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 12s!
> > > > Showing busy workqueues and worker pools:
> > > > workqueue events: flags=0x0
> > > >   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> > > >     pending: vmstat_shepherd
> > > > BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 17s!
> > > > Showing busy workqueues and worker pools:
> > > > workqueue events: flags=0x0
> > > >   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> > > >     pending: vmstat_shepherd
> > > > workqueue events_power_efficient: flags=0x82
> > > >   pwq 2: cpus=0 flags=0x4 nice=0 active=1/256 refcnt=3
> > > >     pending: neigh_periodic_work
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_stall.h:758 rcu_check_gp_start_stall kernel/rcu/tree_stall.h:750 [inline]
> > > > WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_stall.h:758 rcu_check_gp_start_stall.isra.0+0x14c/0x210 kernel/rcu/tree_stall.h:711
> > > 
> > > I have different line numbering,
> > 
> > This is still using next-20201110. I'll rerun with latest -next as well.
> 
> No problem, as it looks like next-20201105 is a reasonable approximation.
> 
> > > but the only warning that I see in this
> > > function is the one complaining that RCU has been ignoring a request to
> > > start a grace period for too long.  This usually happens because the RCU
> > > grace-period kthread (named "rcu_preempt" in your case, but can also be
> > > named "rcu_sched") is being prevented from running, but can be caused
> > > by other things as well.
> > > 
> > > > Modules linked in:
> > > > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc3-next-20201110-00003-g920304642405-dirty #30
> > > > Hardware name: linux,dummy-virt (DT)
> > > > pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
> > > > pc : rcu_check_gp_start_stall kernel/rcu/tree_stall.h:750 [inline]
> > > > pc : rcu_check_gp_start_stall.isra.0+0x14c/0x210 kernel/rcu/tree_stall.h:711
> > > > lr : __xchg_mb arch/arm64/include/asm/cmpxchg.h:88 [inline]
> > > > lr : atomic_xchg include/asm-generic/atomic-instrumented.h:615 [inline]
> > > > lr : rcu_check_gp_start_stall kernel/rcu/tree_stall.h:751 [inline]
> > > > lr : rcu_check_gp_start_stall.isra.0+0x148/0x210 kernel/rcu/tree_stall.h:711
> > > 
> > > Two program counters and four link registers?  Awesome!  ;-)
> > 
> > Ah I'm using syzkaller's symbolizer, which duplicates lines if there was
> > an inline function (remove all the "[inline]" and it should make sense,
> > but the "[inline]" tell you the actual line). Obviously for things like
> > this it's a bit unintuitive. :-)
> 
> Very useful, though, and a big THANK YOU to those who made it happen!
> 
> > > > sp : ffff800010003d20
> > > > x29: ffff800010003d20 x28: ffff274ac3a10000 
> > > > x27: 0000000000000000 x26: ffff274b3dbe72d8 
> > > > x25: ffffbcb867722000 x24: 0000000000000000 
> > > > x23: 0000000000000000 x22: ffffbcb8681d1260 
> > > > x21: ffffbcb86735b000 x20: ffffbcb867404440 
> > > > x19: ffffbcb867404440 x18: 0000000000000123 
> > > > x17: ffffbcb865d400f0 x16: 0000000000000002 
> > > > x15: 0000000000000002 x14: 0000000000000000 
> > > > x13: 003d090000000000 x12: 00001e8480000000 
> > > > x11: ffffbcb867958980 x10: ffff800010003cf0 
> > > > x9 : ffffbcb864f4b7c8 x8 : 0000000000000080 
> > > > x7 : 0000000000000026 x6 : ffffbcb86774e4c0 
> > > > x5 : 0000000000000000 x4 : 00000000d4001f4b 
> > > > x3 : 0000000000000000 x2 : 0000000000000000 
> > > > x1 : 0000000000000001 x0 : 0000000000000000 
> > > > Call trace:
> > > >  rcu_check_gp_start_stall kernel/rcu/tree_stall.h:750 [inline]
> > > >  rcu_check_gp_start_stall.isra.0+0x14c/0x210 kernel/rcu/tree_stall.h:711
> > > >  rcu_core+0x168/0x9e0 kernel/rcu/tree.c:2719
> > > >  rcu_core_si+0x18/0x28 kernel/rcu/tree.c:2737
> > > 
> > > The RCU_SOFTIRQ handler is causing this checking to occur, for whatever
> > > that is worth.
> > > 
> > > >  __do_softirq+0x188/0x6b4 kernel/softirq.c:298
> > > >  do_softirq_own_stack include/linux/interrupt.h:568 [inline]
> > > >  invoke_softirq kernel/softirq.c:393 [inline]
> > > >  __irq_exit_rcu kernel/softirq.c:423 [inline]
> > > >  irq_exit+0x1cc/0x1e0 kernel/softirq.c:447
> > > >  __handle_domain_irq+0xb4/0x130 kernel/irq/irqdesc.c:690
> > > >  handle_domain_irq include/linux/irqdesc.h:170 [inline]
> > > >  gic_handle_irq+0x70/0x108 drivers/irqchip/irq-gic.c:370
> > > >  el1_irq+0xc0/0x180 arch/arm64/kernel/entry.S:651
> > > >  arch_local_irq_restore+0x8/0x10 arch/arm64/include/asm/irqflags.h:124
> > > >  release_probes kernel/tracepoint.c:113 [inline]
> > > >  tracepoint_remove_func kernel/tracepoint.c:315 [inline]
> > > >  tracepoint_probe_unregister+0x220/0x378 kernel/tracepoint.c:382
> > > >  trace_event_reg+0x58/0x150 kernel/trace/trace_events.c:298
> > > >  __ftrace_event_enable_disable+0x424/0x608 kernel/trace/trace_events.c:412
> > > >  ftrace_event_enable_disable kernel/trace/trace_events.c:495 [inline]
> > > >  __ftrace_set_clr_event_nolock+0x120/0x180 kernel/trace/trace_events.c:811
> > > >  __ftrace_set_clr_event+0x60/0x90 kernel/trace/trace_events.c:833
> > > >  event_trace_self_tests+0xd4/0x114 kernel/trace/trace_events.c:3661
> > > >  event_trace_self_test_with_function kernel/trace/trace_events.c:3734 [inline]
> > > >  event_trace_self_tests_init+0x88/0xa8 kernel/trace/trace_events.c:3747
> > > >  do_one_initcall+0xa4/0x500 init/main.c:1212
> > > >  do_initcall_level init/main.c:1285 [inline]
> > > >  do_initcalls init/main.c:1301 [inline]
> > > >  do_basic_setup init/main.c:1321 [inline]
> > > >  kernel_init_freeable+0x344/0x3c4 init/main.c:1521
> > > >  kernel_init+0x20/0x16c init/main.c:1410
> > > >  ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
> > > > irq event stamp: 3274113
> > > > hardirqs last  enabled at (3274112): [<ffffbcb864f8aee4>] rcu_core+0x974/0x9e0 kernel/rcu/tree.c:2716
> > > > hardirqs last disabled at (3274113): [<ffffbcb866233bf0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
> > > > hardirqs last disabled at (3274113): [<ffffbcb866233bf0>] _raw_spin_lock_irqsave+0xb8/0x14c kernel/locking/spinlock.c:159
> > > > softirqs last  enabled at (3272576): [<ffffbcb864e10b80>] __do_softirq+0x630/0x6b4 kernel/softirq.c:325
> > > > softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] do_softirq_own_stack include/linux/interrupt.h:568 [inline]
> > > > softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] invoke_softirq kernel/softirq.c:393 [inline]
> > > > softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] __irq_exit_rcu kernel/softirq.c:423 [inline]
> > > > softirqs last disabled at (3274101): [<ffffbcb864ec6c54>] irq_exit+0x1cc/0x1e0 kernel/softirq.c:447
> > > > ---[ end trace 902768efebf5a607 ]---
> > > > rcu: rcu_preempt: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x0 delta ->gp_activity 4452 ->gp_req_activity 3848 ->gp_wake_time 3848 ->gp_wake_seq 2696 ->gp_seq 2696 ->gp_seq_needed 2700 ->gp_flags 0x1
> > > 
> > > The last thing that RCU's grace-period kthread did was to go to sleep
> > > waiting for a grace-period request (RCU_GP_WAIT_GPS).
> > > 
> > > > rcu: 	rcu_node 0:0 ->gp_seq 2696 ->gp_seq_needed 2700
> > > > rcu: RCU callbacks invoked since boot: 2583
> > > > rcu_tasks: RTGS_WAIT_CBS(11) since 567120 g:1 i:0/0 k. 
> > > > rcu_tasks_rude: RTGS_WAIT_CBS(11) since 567155 g:1 i:0/1 k. 
> > > > rcu_tasks_trace: RTGS_INIT(0) since 4295464549 g:0 i:0/0 k. N0 h:0/0/0
> > > > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > 	(detected by 0, t=3752 jiffies, g=2705, q=8)
> > > > rcu: All QSes seen, last rcu_preempt kthread activity 557 (4295471128-4295470571), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > > > rcu: rcu_preempt kthread starved for 557 jiffies! g2705 f0x2 RCU_GP_CLEANUP(7) ->state=0x0 ->cpu=0
> > > 
> > > And here we see that RCU's grace-period kthread has in fact been starved.
> > > 
> > > This kthread is now in RCU_GP_CLEANUP, perhaps because of the wakeup that is
> > > sent in rcu_check_gp_kthread_starvation().
> > > 
> > > My current guess is that this is a consequence of the earlier failures,
> > > but who knows?
> >  
> > I can try bisection again, or reverting some commits that might be
> > suspicious? But we'd need some selection of suspicious commits.
> 
> The report claims that one of the rcu_node ->lock fields is held
> with interrupts enabled, which would indeed be bad.  Except that all
> of the stack traces that it shows have these locks held within the
> scheduling-clock interrupt handler.  Now with the "rcu: Don't invoke
> try_invoke_on_locked_down_task() with irqs disabled" but without the
> "sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled"
> commit, I understand why.  With both, I don't see how this happens.

I'm at a loss, but happy to keep bisecting and trying patches. I'm also
considering:

	Is it the compiler? Probably not, I tried 2 versions of GCC.

	Can we trust lockdep to precisely know IRQ state? I know there's
	been some recent work around this, but hopefully we're not
	affected here?

	Is QEMU buggy?

> At this point, I am reduced to adding lockdep_assert_irqs_disabled()
> calls at various points in that code, as shown in the patch below.
> 
> At this point, I would guess that your first priority would be the
> initial bug rather than this following issue, but you never know, this
> might well help diagnose the initial bug.

I don't mind either way. I'm worried deadlocking the whole system might
be worse.

> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit ccedf00693ef60f7c06d23490fc41bb60dd43dc3
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Nov 19 10:13:06 2020 -0800
> 
>     rcu: Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq() and callees

Applied that. See new log attached -- I don't see any of them have
fired.

I also upgraded to next-20201119 -- nothing has changed though, and the
warnings and deadlocks still appear.

Thanks,
-- Marco

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log

Testing all events: OK
Running tests again, along with the function tracer
Running tests on all trace events:
Testing all events: 
hrtimer: interrupt took 11213232 ns
BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 11s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_shepherd
BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 13s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_shepherd
BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 10s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_shepherd
workqueue events_power_efficient: flags=0x82
  pwq 2: cpus=0 flags=0x4 nice=0 active=1/256 refcnt=3
    pending: neigh_periodic_work
BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 11s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_shepherd
workqueue events_power_efficient: flags=0x82
  pwq 2: cpus=0 flags=0x4 nice=0 active=1/256 refcnt=3
    pending: neigh_periodic_work
BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 21s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    in-flight: 15:vmstat_shepherd
workqueue events_power_efficient: flags=0x82
  pwq 2: cpus=0 flags=0x4 nice=0 active=1/256 refcnt=3
    pending: neigh_periodic_work
pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=8s workers=2 idle: 5
BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 34s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_shepherd
workqueue events_power_efficient: flags=0x82
  pwq 2: cpus=0 flags=0x4 nice=0 active=2/256 refcnt=4
    pending: neigh_periodic_work, do_cache_clean
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=3752 jiffies, g=2365, q=2)
rcu: All QSes seen, last rcu_preempt kthread activity 2599 (4295010564-4295007965), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 2599 jiffies! g2365 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
Call trace:
 __switch_to+0x148/0x1f0 arch/arm64/kernel/process.c:577
 context_switch kernel/sched/core.c:4268 [inline]
 __schedule+0x2dc/0x9a8 kernel/sched/core.c:5018
 preempt_schedule_notrace+0x70/0x1c0 kernel/sched/core.c:5251
 __ftrace_ops_list_func kernel/trace/ftrace.c:6955 [inline]
 ftrace_ops_list_func+0x10c/0x218 kernel/trace/ftrace.c:6976
 ftrace_graph_call+0x0/0x4
 preempt_count_add+0x8/0x1a0 arch/arm64/include/asm/atomic.h:65
 schedule+0x44/0x100 kernel/sched/core.c:5096
 schedule_timeout+0x240/0x538 kernel/time/timer.c:1871
 rcu_gp_fqs_loop kernel/rcu/tree.c:1946 [inline]
 rcu_gp_kthread+0x618/0x1bd8 kernel/rcu/tree.c:2119
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:963
rcu: Stack dump where RCU GP kthread last ran:
Task dump for CPU 0:
task:khungtaskd      state:R  running task     stack:    0 pid:   23 ppid:     2 flags:0x0000042a
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 sched_show_task kernel/sched/core.c:6947 [inline]
 sched_show_task+0x208/0x230 kernel/sched/core.c:6921
 dump_cpu_task+0x4c/0x5c kernel/sched/core.c:8985
 rcu_check_gp_kthread_starvation+0x240/0x388 kernel/rcu/tree_stall.h:482
 print_other_cpu_stall kernel/rcu/tree_stall.h:556 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:679 [inline]
 rcu_pending kernel/rcu/tree.c:3764 [inline]
 rcu_sched_clock_irq+0x131c/0x1408 kernel/rcu/tree.c:2588
 update_process_times+0x6c/0xb8 kernel/time/timer.c:1709
 tick_sched_handle.isra.0+0x58/0x88 kernel/time/tick-sched.c:176
 tick_sched_timer+0x68/0xe0 kernel/time/tick-sched.c:1328
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x288/0x730 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x114/0x288 kernel/time/hrtimer.c:1645
 timer_handler drivers/clocksource/arm_arch_timer.c:647 [inline]
 arch_timer_handler_virt+0x50/0x70 drivers/clocksource/arm_arch_timer.c:658
 handle_percpu_devid_irq+0x104/0x4c0 kernel/irq/chip.c:930
 generic_handle_irq_desc include/linux/irqdesc.h:152 [inline]
 generic_handle_irq+0x54/0x78 kernel/irq/irqdesc.c:650
 __handle_domain_irq+0xac/0x130 kernel/irq/irqdesc.c:687
 handle_domain_irq include/linux/irqdesc.h:170 [inline]
 gic_handle_irq+0x70/0x108 drivers/irqchip/irq-gic.c:370
 el1_irq+0xc0/0x180 arch/arm64/kernel/entry.S:651
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:37 [inline]
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
 _raw_spin_unlock_irq+0x50/0x98 kernel/locking/spinlock.c:199
 finish_lock_switch kernel/sched/core.c:4046 [inline]
 finish_task_switch+0xb4/0x398 kernel/sched/core.c:4146
 context_switch kernel/sched/core.c:4271 [inline]
 __schedule+0x2e0/0x9a8 kernel/sched/core.c:5018
 preempt_schedule_irq+0x4c/0xa0 kernel/sched/core.c:5280
 arm64_preempt_schedule_irq+0xd0/0x118 arch/arm64/kernel/process.c:725
 el1_irq+0xd8/0x180 arch/arm64/kernel/entry.S:664
 check_hung_uninterruptible_tasks kernel/hung_task.c:231 [inline]
 watchdog+0x5d8/0xbe8 kernel/hung_task.c:338
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:963

================================
WARNING: inconsistent lock state
5.10.0-rc4-next-20201119-00003-gb88cbc8d31ee #4 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
khungtaskd/23 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:516 [inline]
ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:679 [inline]
ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3764 [inline]
ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x7c8/0x1408 kernel/rcu/tree.c:2588
{IN-HARDIRQ-W} state was registered at:
  mark_lock kernel/locking/lockdep.c:4373 [inline]
  mark_usage kernel/locking/lockdep.c:4301 [inline]
  __lock_acquire+0xae8/0x1ac8 kernel/locking/lockdep.c:4784
  lock_acquire kernel/locking/lockdep.c:5435 [inline]
  lock_acquire+0x268/0x508 kernel/locking/lockdep.c:5400
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x78/0x14c kernel/locking/spinlock.c:159
  print_other_cpu_stall kernel/rcu/tree_stall.h:516 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:679 [inline]
  rcu_pending kernel/rcu/tree.c:3764 [inline]
  rcu_sched_clock_irq+0x7c8/0x1408 kernel/rcu/tree.c:2588
  update_process_times+0x6c/0xb8 kernel/time/timer.c:1709
  tick_sched_handle.isra.0+0x58/0x88 kernel/time/tick-sched.c:176
  tick_sched_timer+0x68/0xe0 kernel/time/tick-sched.c:1328
  __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
  __hrtimer_run_queues+0x288/0x730 kernel/time/hrtimer.c:1583
  hrtimer_interrupt+0x114/0x288 kernel/time/hrtimer.c:1645
  timer_handler drivers/clocksource/arm_arch_timer.c:647 [inline]
  arch_timer_handler_virt+0x50/0x70 drivers/clocksource/arm_arch_timer.c:658
  handle_percpu_devid_irq+0x104/0x4c0 kernel/irq/chip.c:930
  generic_handle_irq_desc include/linux/irqdesc.h:152 [inline]
  generic_handle_irq+0x54/0x78 kernel/irq/irqdesc.c:650
  __handle_domain_irq+0xac/0x130 kernel/irq/irqdesc.c:687
  handle_domain_irq include/linux/irqdesc.h:170 [inline]
  gic_handle_irq+0x70/0x108 drivers/irqchip/irq-gic.c:370
  el1_irq+0xc0/0x180 arch/arm64/kernel/entry.S:651
  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:37 [inline]
  __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
  _raw_spin_unlock_irq+0x50/0x98 kernel/locking/spinlock.c:199
  finish_lock_switch kernel/sched/core.c:4046 [inline]
  finish_task_switch+0xb4/0x398 kernel/sched/core.c:4146
  context_switch kernel/sched/core.c:4271 [inline]
  __schedule+0x2e0/0x9a8 kernel/sched/core.c:5018
  preempt_schedule_irq+0x4c/0xa0 kernel/sched/core.c:5280
  arm64_preempt_schedule_irq+0xd0/0x118 arch/arm64/kernel/process.c:725
  el1_irq+0xd8/0x180 arch/arm64/kernel/entry.S:664
  check_hung_uninterruptible_tasks kernel/hung_task.c:231 [inline]
  watchdog+0x5d8/0xbe8 kernel/hung_task.c:338
  kthread+0x13c/0x188 kernel/kthread.c:292
  ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:963
irq event stamp: 15198
hardirqs last  enabled at (15197): [<ffffd1f05041241c>] el1_irq+0xdc/0x180 arch/arm64/kernel/entry.S:685
hardirqs last disabled at (15198): [<ffffd1f0504123c0>] el1_irq+0x80/0x180 arch/arm64/kernel/entry.S:648
softirqs last  enabled at (14846): [<ffffd1f050410b80>] __do_softirq+0x630/0x6b4 kernel/softirq.c:325
softirqs last disabled at (14843): [<ffffd1f0504c623c>] do_softirq_own_stack include/linux/interrupt.h:568 [inline]
softirqs last disabled at (14843): [<ffffd1f0504c623c>] invoke_softirq kernel/softirq.c:393 [inline]
softirqs last disabled at (14843): [<ffffd1f0504c623c>] __irq_exit_rcu kernel/softirq.c:423 [inline]
softirqs last disabled at (14843): [<ffffd1f0504c623c>] irq_exit+0x1cc/0x1e0 kernel/softirq.c:447

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rcu_node_0);
  <Interrupt>
    lock(rcu_node_0);

 *** DEADLOCK ***

2 locks held by khungtaskd/23:
 #0: ffffd1f0529f1420 (rcu_read_lock){....}-{1:2}, at: check_hung_uninterruptible_tasks kernel/hung_task.c:226 [inline]
 #0: ffffd1f0529f1420 (rcu_read_lock){....}-{1:2}, at: watchdog+0x15c/0xbe8 kernel/hung_task.c:338
 #1: ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:516 [inline]
 #1: ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:679 [inline]
 #1: ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3764 [inline]
 #1: ffffd1f0529f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x7c8/0x1408 kernel/rcu/tree.c:2588

stack backtrace:
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.10.0-rc4-next-20201119-00003-gb88cbc8d31ee #4
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x140/0x1bc lib/dump_stack.c:120
 print_usage_bug kernel/locking/lockdep.c:3738 [inline]
 print_usage_bug+0x2a0/0x2f0 kernel/locking/lockdep.c:3705
 valid_state kernel/locking/lockdep.c:3749 [inline]
 mark_lock_irq kernel/locking/lockdep.c:3952 [inline]
 mark_lock.part.0+0x438/0x4e8 kernel/locking/lockdep.c:4409
 mark_lock kernel/locking/lockdep.c:4007 [inline]
 mark_held_locks+0x54/0x90 kernel/locking/lockdep.c:4010
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4028 [inline]
 lockdep_hardirqs_on_prepare+0xe0/0x290 kernel/locking/lockdep.c:4096
 trace_hardirqs_on+0x90/0x370 kernel/trace/trace_preemptirq.c:49
 el1_irq+0xdc/0x180 arch/arm64/kernel/entry.S:685
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:37 [inline]
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
 _raw_spin_unlock_irq+0x50/0x98 kernel/locking/spinlock.c:199
 finish_lock_switch kernel/sched/core.c:4046 [inline]
 finish_task_switch+0xb4/0x398 kernel/sched/core.c:4146
 context_switch kernel/sched/core.c:4271 [inline]
 __schedule+0x2e0/0x9a8 kernel/sched/core.c:5018
 preempt_schedule_irq+0x4c/0xa0 kernel/sched/core.c:5280
 arm64_preempt_schedule_irq+0xd0/0x118 arch/arm64/kernel/process.c:725
 el1_irq+0xd8/0x180 arch/arm64/kernel/entry.S:664
 check_hung_uninterruptible_tasks kernel/hung_task.c:231 [inline]
 watchdog+0x5d8/0xbe8 kernel/hung_task.c:338
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:963
BUG: scheduling while atomic: khungtaskd/23/0x00000002
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<ffffd1f05181ce7c>] preempt_schedule_irq+0x3c/0xa0 kernel/sched/core.c:5278
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.10.0-rc4-next-20201119-00003-gb88cbc8d31ee #4
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x140/0x1bc lib/dump_stack.c:120
 __schedule_bug+0xcc/0xe0 kernel/sched/core.c:4757
 schedule_debug kernel/sched/core.c:4784 [inline]
 __schedule+0x888/0x9a8 kernel/sched/core.c:4912
 preempt_schedule_irq+0x4c/0xa0 kernel/sched/core.c:5280
 arm64_preempt_schedule_irq+0xd0/0x118 arch/arm64/kernel/process.c:725
 el1_irq+0xd8/0x180 arch/arm64/kernel/entry.S:664
 check_hung_uninterruptible_tasks kernel/hung_task.c:231 [inline]
 watchdog+0x5d8/0xbe8 kernel/hung_task.c:338
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:963

--k+w/mQv8wyuph6w0--
