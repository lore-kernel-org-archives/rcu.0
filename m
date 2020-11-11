Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D30C5517A
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07332087D
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 20:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PynxXI+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKKUWD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUWD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 15:22:03 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05CCC0613D1
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2020 12:22:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so3738494wrc.11
        for <rcu@vger.kernel.org>; Wed, 11 Nov 2020 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsp9YKJhrqfgFKDZ1DBLBnXvo2iYEAgxpR7kKkNGbK0=;
        b=PynxXI+uJIwXWOxlTbxHvJYIcP1mrqLrAEQb43v0TvDdFP3HBL5hMpDVniwGZC10BG
         rBI7i1Dr6MIffeprQnSURaFVrDpRIHiv60WntPNj2FXsPl/iYbAng92WBNcC4RC8bgpN
         kMDvZWtOTgcrg31on07IDt7O9vYEA6mrP8JQeoXiE4KL5C1fPB5qoLtcy/Qq4BY8o1XE
         P0gEDAlbu6XFTkYZtc62G0E9yaXzOv2zb2ks40lJYNX7VRn27lK4EKQoCFG0gxYx8coG
         JvVTxv9OwrRy3+/KkWb0qZT5/FwkbFyGfA1uioFqo/+UI4zwvpCwCjlnMCQz4uh9mHNw
         Mufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsp9YKJhrqfgFKDZ1DBLBnXvo2iYEAgxpR7kKkNGbK0=;
        b=H9YRYvdVCoV9vpejh1E1kRc5v4S+kKJkS9UA6NrDnR9X7yv6L3kWK20WvZrGEEstWN
         qkgzQW2aGyOihK4CgBZpHP4HFcYMXA5BBahBwvOywesJKENXo4VP8lKr5wBGclu0csj7
         uUK0A50rfUi9t8myqz7G3UixFmJoChNKfLRue7xsg2YVCEIJ88/bqUo2rlxVDgiZrzVs
         ut5Jw16Zb0rZkWjTYYxX8MxB7Whc+bszFhAJNT1pCNKVYVkmUyv1yFF7ToMjA9Muuajj
         fxc+B/hlBAOCYDNlPKXIWzqoHCPg0Tj2qq9eh6ALeFrav4NU1Vr9JcV6AzqIN2YIxp5O
         77WQ==
X-Gm-Message-State: AOAM533cY2I4+iDlQIm/+n+fj6aujiIy50e67JGLmO2peSadE1Fg/cOz
        gKMTXWIcYZzC+3lVf/w8m8ftEQ==
X-Google-Smtp-Source: ABdhPJyIi0TclXletCurul9OW62NOWx4SJhCLML+8m7+0jiPgwSpcHL4SCZW/4HaKhu8RDVg7BzvVQ==
X-Received: by 2002:adf:906b:: with SMTP id h98mr31484154wrh.310.1605126119972;
        Wed, 11 Nov 2020 12:21:59 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id u5sm3547921wml.13.2020.11.11.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:21:59 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:21:53 +0100
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
        peterz@infradead.org
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201111202153.GT517454@elver.google.com>
References: <20201110135320.3309507-1-elver@google.com>
 <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
 <20201111133813.GA81547@elver.google.com>
 <20201111130543.27d29462@gandalf.local.home>
 <20201111182333.GA3249@paulmck-ThinkPad-P72>
 <20201111183430.GN517454@elver.google.com>
 <20201111192123.GB3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111192123.GB3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 11, 2020 at 11:21AM -0800, Paul E. McKenney wrote:
[...]
> > >     rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
> > 
> > Sadly, no, next-20201110 already included that one, and that's what I
> > tested and got me all those warnings above.
> 
> Hey, I had to ask!  The only uncertainty I seee is the acquisition of
> the lock in rcu_iw_handler(), for which I add a lockdep check in the
> (untested) patch below.  The other thing I could do is sprinkle such
> checks through the stall-warning code on the assumption that something
> RCU is calling is enabling interrupts.
> 
> Other thoughts?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 70d48c5..3d67650 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -189,6 +189,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
>  
>  	rdp = container_of(iwp, struct rcu_data, rcu_iw);
>  	rnp = rdp->mynode;
> +	lockdep_assert_irqs_disabled();
>  	raw_spin_lock_rcu_node(rnp);
>  	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
>  		rdp->rcu_iw_gp_seq = rnp->gp_seq;

This assert didn't fire yet, I just get more of the below. I'll keep
rerunning, but am not too hopeful...

Thanks,
-- Marco

| [...]
| [  125.854798] registered taskstats version 1
| [  125.857453] Running tests on all trace events:
| [  125.857830] Testing all events: OK
| [  166.950008] hrtimer: interrupt took 16803216 ns
| [  181.867305] Running tests again, along with the function tracer
| [  181.882932] Running tests on all trace events:
| [  181.894437] Testing all events: 
| [  415.596777] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 34s!
| [  415.656078] Showing busy workqueues and worker pools:
| [  415.683616] workqueue events: flags=0x0
| [  415.692860]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  415.710520]     pending: vmstat_shepherd
| [  415.735770] workqueue mm_percpu_wq: flags=0x8
| [  415.744135]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  415.759123]     in-flight: 15:vmstat_update
| [  415.784113] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=34s workers=2 idle: 5
| [  510.976952] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 31s!
| [  511.054367] Showing busy workqueues and worker pools:
| [  511.060173] workqueue events: flags=0x0
| [  511.083325]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256 refcnt=3
| [  511.093457]     in-flight: 15:vmstat_shepherd
| [  511.100300]     pending: free_work
| [  511.111488] workqueue events_power_efficient: flags=0x82
| [  511.141245]   pwq 2: cpus=0 flags=0x5 nice=0 active=3/256 refcnt=5
| [  511.151184]     in-flight: 7:check_lifetime
| [  511.157902]     pending: neigh_periodic_work, do_cache_clean
| [  511.171073] workqueue mm_percpu_wq: flags=0x8
| [  511.198620]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  511.208715]     pending: vmstat_update
| [  511.227644] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=31s workers=2 idle: 5
| [  511.255656] pool 2: cpus=0 flags=0x5 nice=0 hung=19s workers=2 manager: 61
| [  544.063224] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 64s!
| [  544.174957] Showing busy workqueues and worker pools:
| [  544.223112] workqueue events: flags=0x0
| [  544.250341]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=2/256 refcnt=3
| [  544.260574]     in-flight: 15:vmstat_shepherd
| [  544.267433]     pending: free_work
| [  544.285271] workqueue mm_percpu_wq: flags=0x8
| [  544.290950]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  544.301150]     pending: vmstat_update
| [  544.315536] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=64s workers=2 idle: 5
| [  544.339558] pool 2: cpus=0 flags=0x5 nice=0 hung=5s workers=2 manager: 61 idle: 7
| [  790.375433] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 32s!
| [  790.435529] Showing busy workqueues and worker pools:
| [  790.455374] workqueue events: flags=0x0
| [  790.471271]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  790.481737]     in-flight: 15:vmstat_shepherd
| [  790.495314] workqueue events_power_efficient: flags=0x82
| [  790.512837]   pwq 2: cpus=0 flags=0x4 nice=0 active=1/256 refcnt=3
| [  790.521833]     in-flight: 107:neigh_periodic_work
| [  790.535532] workqueue mm_percpu_wq: flags=0x8
| [  790.555139]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  790.565610]     pending: vmstat_update
| [  790.579066] pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=32s workers=2 idle: 5
| [  790.603124] pool 2: cpus=0 flags=0x4 nice=0 hung=1s workers=3 idle: 7 61
| [  950.115427] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 40s!
| [  950.177846] Showing busy workqueues and worker pools:
| [  950.183602] workqueue events: flags=0x0
| [  950.207180]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  950.217258]     pending: vmstat_shepherd
| [  992.571446] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 82s!
| [  992.662876] Showing busy workqueues and worker pools:
| [  992.668626] workqueue events: flags=0x0
| [  992.691443]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
| [  992.701473]     pending: vmstat_shepherd
| [ 1001.181519] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
| [ 1001.186952] 	(detected by 0, t=6502 jiffies, g=3441, q=1)
| [ 1001.188828] rcu: All QSes seen, last rcu_preempt kthread activity 528 (4295139809-4295139281), jiffies_till_next_fqs=1, root ->qsmask 0x0
| [ 1001.199298] rcu: rcu_preempt kthread starved for 528 jiffies! g3441 f0x2 RCU_GP_CLEANUP(7) ->state=0x0 ->cpu=0
| [ 1001.205008] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
| [ 1001.210324] rcu: RCU grace-period kthread stack dump:
| [ 1001.214618] task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
| [ 1001.223303] Call trace:
| [ 1001.226919]  __switch_to+0x100/0x1e0
| [ 1001.230803]  __schedule+0x2d0/0x890
| [ 1001.234685]  preempt_schedule_common+0xd4/0x1b0
| [ 1001.238831]  preempt_schedule.part.88+0x20/0x28
| [ 1001.242963]  preempt_schedule+0x20/0x28
| [ 1001.246928]  _raw_spin_unlock_irq+0x80/0x90
| [ 1001.251011]  rcu_gp_kthread+0xe5c/0x19a8
| [ 1001.255024]  kthread+0x174/0x188
| [ 1001.258821]  ret_from_fork+0x10/0x18
| [ 1001.274658] 
| [ 1001.276945] ================================
| [ 1001.279954] WARNING: inconsistent lock state
| [ 1001.283169] 5.10.0-rc3-next-20201110-00001-gc07b306d7fa5-dirty #2 Not tainted
| [ 1001.287067] --------------------------------
| [ 1001.290073] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
| [ 1001.293767] ksoftirqd/0/9 [HC0[0]:SC0[0]:HE0:SE1] takes:
| [ 1001.297148] ffffd53efd5d4358 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x4a0/0xd18
| [ 1001.305027] {IN-HARDIRQ-W} state was registered at:
| [ 1001.308401]   __lock_acquire+0x7bc/0x15b8
| [ 1001.311430]   lock_acquire+0x244/0x498
| [ 1001.314341]   _raw_spin_lock+0x5c/0x78
| [ 1001.317252]   rcu_preempt_deferred_qs_irqrestore+0x84/0x540
| [ 1001.320666]   rcu_preempt_deferred_qs+0x64/0x80
| [ 1001.323789]   rcu_sched_clock_irq+0x4f4/0xd18
| [ 1001.326881]   update_process_times+0x68/0x98
| [ 1001.329932]   tick_sched_handle.isra.16+0x54/0x80
| [ 1001.333110]   tick_sched_timer+0x64/0xd8
| [ 1001.336085]   __hrtimer_run_queues+0x2a4/0x750
| [ 1001.339194]   hrtimer_interrupt+0xf4/0x2a0
| [ 1001.342244]   arch_timer_handler_virt+0x44/0x70
| [ 1001.345419]   handle_percpu_devid_irq+0xfc/0x4d0
| [ 1001.348579]   generic_handle_irq+0x50/0x70
| [ 1001.351596]   __handle_domain_irq+0x9c/0x120
| [ 1001.354677]   gic_handle_irq+0xcc/0x108
| [ 1001.357651]   el1_irq+0xbc/0x180
| [ 1001.360429]   arch_local_irq_save+0x18/0x30
| [ 1001.363460]   __rcu_read_unlock+0x84/0x1d8
| [ 1001.366461]   check_lifetime+0x158/0x4e0
| [ 1001.369460]   process_one_work+0x2c4/0x828
| [ 1001.372486]   worker_thread+0x5c/0x518
| [ 1001.375432]   kthread+0x174/0x188
| [ 1001.378232]   ret_from_fork+0x10/0x18
| [ 1001.381101] irq event stamp: 68414
| [ 1001.383978] hardirqs last  enabled at (68413): [<ffffd53efb1856d0>] rcu_irq_exit_irqson+0x48/0x68
| [ 1001.388412] hardirqs last disabled at (68414): [<ffffd53efb0122bc>] el1_irq+0x7c/0x180
| [ 1001.392557] softirqs last  enabled at (68214): [<ffffd53efb010b58>] __do_softirq+0x650/0x6a4
| [ 1001.396858] softirqs last disabled at (68211): [<ffffd53efb0c0b80>] irq_exit+0x1a8/0x1b0
| [ 1001.400907] 
| [ 1001.400907] other info that might help us debug this:
| [ 1001.404542]  Possible unsafe locking scenario:
| [ 1001.404542] 
| [ 1001.407936]        CPU0
| [ 1001.410369]        ----
| [ 1001.412815]   lock(rcu_node_0);
| [ 1001.417183]   <Interrupt>
| [ 1001.419715]     lock(rcu_node_0);
| [ 1001.424132] 
| [ 1001.424132]  *** DEADLOCK ***
| [ 1001.424132] 
| [ 1001.427638] 1 lock held by ksoftirqd/0/9:
| [ 1001.430588]  #0: ffffd53efd5d4358 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x4a0/0xd18
| [ 1001.439283] 
| [ 1001.439283] stack backtrace:
| [ 1001.442601] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.10.0-rc3-next-20201110-00001-gc07b306d7fa5-dirty #2
| [ 1001.447258] Hardware name: linux,dummy-virt (DT)
| [ 1001.450435] Call trace:
| [ 1001.452985]  dump_backtrace+0x0/0x278
| [ 1001.455904]  show_stack+0x30/0x80
| [ 1001.458690]  dump_stack+0x138/0x1b0
| [ 1001.461525]  print_usage_bug+0x2d8/0x2f8
| [ 1001.464511]  mark_lock.part.46+0x370/0x480
| [ 1001.467538]  mark_held_locks+0x58/0x90
| [ 1001.470495]  lockdep_hardirqs_on_prepare+0xdc/0x298
| [ 1001.473751]  trace_hardirqs_on+0x90/0x388
| [ 1001.476744]  el1_irq+0xd8/0x180
| [ 1001.479486]  arch_local_irq_restore+0x4/0x8
| [ 1001.482521]  trace_preempt_off+0x138/0x1e8
| [ 1001.485531]  preempt_schedule_notrace+0xec/0x1c0
| [ 1001.488707]  ftrace_ops_no_ops+0x174/0x250
| [ 1001.491730]  ftrace_graph_call+0x0/0xc
| [ 1001.494647]  preempt_count_add+0x1c/0x180
| [ 1001.497642]  schedule+0x44/0x108
| [ 1001.500440]  smpboot_thread_fn+0x160/0x298
| [ 1001.503470]  kthread+0x174/0x188
| [ 1001.506245]  ret_from_fork+0x10/0x18
| [ 1001.513585] BUG: scheduling while atomic: ksoftirqd/0/9/0x00000002
| [ 1001.522142] INFO: lockdep is turned off.
| [ 1001.530315] Modules linked in:
| [ 1001.542198] Preemption disabled at:
| [ 1001.546077] [<ffffd53efb219d74>] ftrace_ops_no_ops+0x174/0x250
| [ 1001.558740] CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.10.0-rc3-next-20201110-00001-gc07b306d7fa5-dirty #2
| [ 1001.563426] Hardware name: linux,dummy-virt (DT)
| [ 1001.566615] Call trace:
| [ 1001.569206]  dump_backtrace+0x0/0x278
| [ 1001.572108]  show_stack+0x30/0x80
| [ 1001.574947]  dump_stack+0x138/0x1b0
| [ 1001.577814]  __schedule_bug+0x8c/0xe8
| [ 1001.580769]  __schedule+0x7e8/0x890
| [ 1001.583679]  preempt_schedule_notrace+0x70/0x1c0
| [ 1001.586883]  ftrace_ops_no_ops+0x174/0x250
| [ 1001.589939]  ftrace_graph_call+0x0/0xc
| [ 1001.592891]  preempt_count_add+0x1c/0x180
| [ 1001.595925]  schedule+0x44/0x108
| [ 1001.598741]  smpboot_thread_fn+0x160/0x298
| [ 1001.601808]  kthread+0x174/0x188
| [ 1001.604629]  ret_from_fork+0x10/0x18

