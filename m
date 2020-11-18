Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A2CC5519F
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 22:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35ED246EA
	for <rcu@archiver.kernel.org>; Wed, 18 Nov 2020 22:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vox9ADdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKRW4O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Nov 2020 17:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRW4N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Nov 2020 17:56:13 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910FC0613D4
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2020 14:56:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so4608258wmi.0
        for <rcu@vger.kernel.org>; Wed, 18 Nov 2020 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1seX92mFsrfx7vZyLIxprFubCVzfCSOLsu/hjAP+vTs=;
        b=vox9ADdoLllhyA1WukaU1CRn9MH5Ac1e19bK2BhUq0VExU/Wmxkt8mbTE+40y/r1MV
         NmZpUniroixmZ0iwh6+lKHnnOBGKRU4uv25M9W9AU7/cgxZ1SuqdFPihrQQnjQzbgznF
         sE2K77SL8EQpM0acGAMkBG9BZay0+eqqATgSlTrda7OnH697vk4AGc3DJ4iDuygQhF8C
         s841mg/agEyleLOBAFzE+8WMmLehdkndMmJwA9hfPmP2Vg1sbnpbe91pll7ImLk74dAS
         JXpP0Jf3cwN9Yh/JEdNPZgB/6srsMK5CcUc+PZTIPurEBsKMKSPWR9q7CYfFDe/oGpoQ
         ngPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1seX92mFsrfx7vZyLIxprFubCVzfCSOLsu/hjAP+vTs=;
        b=EBeuHvxskI1c2Q7Bml6OX/4abXyOkfJ3GYUCfAcNFGiUJE/QKU3x8qLfRIL3a5pcWH
         YLi/EAhExd0YCetNp2b3evpjQpSHtSSbsstUOS9irDEn0ia2ZnoMsitAlvL/eMJeVoJk
         wc8pOceCkZdLr/UNeh4GWLe6vzskPyy9GAZWWRs5OgAKmIzWVu84dayixJHH5qN0uns8
         xTflyJXN6Geg1dl7bzie7DemcwOjsNKH8qqUL10MoLRFnPfVvIJj9G0bHiBfPu0lisMG
         MgbBnWzud7fbF6oqyg2cUSEf5MvHj9mdglUBcKXl9C+RUNQKjXAY0cixywyPpR0jPAkB
         svTQ==
X-Gm-Message-State: AOAM532tNiSRJRbmMPqzqOaW7KgUgdiyjNOn3YJ/Ih6xi6xWtWtfcL3C
        +J9a2NDQF5CjXAkU1VDS1NqZmQ==
X-Google-Smtp-Source: ABdhPJwdlAxRq7xNFMtlK6ne5yf2WkyW7uJ1VlCtr6keEqO7/0WNjQ19rvEqd/QRHs2EefbueKWGMw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr1406309wma.86.1605740189466;
        Wed, 18 Nov 2020 14:56:29 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id p4sm35980145wrm.51.2020.11.18.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 14:56:27 -0800 (PST)
Date:   Wed, 18 Nov 2020 23:56:21 +0100
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
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201118225621.GA1770130@elver.google.com>
References: <20201111183430.GN517454@elver.google.com>
 <20201111192123.GB3249@paulmck-ThinkPad-P72>
 <20201111202153.GT517454@elver.google.com>
 <20201112001129.GD3249@paulmck-ThinkPad-P72>
 <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
 <20201112161439.GA2989297@elver.google.com>
 <20201112175406.GF3249@paulmck-ThinkPad-P72>
 <20201113175754.GA6273@paulmck-ThinkPad-P72>
 <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20201117182915.GM1437@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2020 at 10:29AM -0800, Paul E. McKenney wrote:
[...] 
> But it would be good to get the kcompactd() people to look at this (not
> immediately seeing who they are in MAINTAINERS).  Perhaps preemption is
> disabled somehow and I am failing to see it.
> 
> Failing that, maybe someone knows of a way to check for overly long
> timeout handlers.

I think I figured out one piece of the puzzle. Bisection keeps pointing
me at some -rcu merge commit, which kept throwing me off. Nor did it
help that reproduction is a bit flaky. However, I think there are 2
independent problems, but the manifestation of 1 problem triggers the
2nd problem:

1. problem: slowed forward progress (workqueue lockup / RCU stall reports)

2. problem: DEADLOCK which causes complete system lockup

	| ...
	|        CPU0
	|        ----
	|   lock(rcu_node_0);
	|   <Interrupt>
	|     lock(rcu_node_0);
	| 
	|  *** DEADLOCK ***
	| 
	| 1 lock held by event_benchmark/105:
	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: print_other_cpu_stall kernel/rcu/tree_stall.h:493 [inline]
	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: check_cpu_stall kernel/rcu/tree_stall.h:652 [inline]
	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_pending kernel/rcu/tree.c:3752 [inline]
	|  #0: ffffbb6e0b804458 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x428/0xd40 kernel/rcu/tree.c:2581
	| ...

Problem 2 can with reasonable confidence (5 trials) be fixed by reverting:

	rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled

At which point the system always boots to user space -- albeit with a
bunch of warnings still (attached). The supposed "good" version doesn't
end up with all those warnings deterministically, so I couldn't say if
the warnings are expected due to recent changes or not (Arm64 QEMU
emulation, 1 CPU, and lots of debugging tools on).

Does any of that make sense?

Thanks,
-- Marco

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=log

Testing all events: OK
Running tests again, along with the function tracer
Running tests on all trace events:
Testing all events: 
hrtimer: interrupt took 10156432 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=3752 jiffies, g=2785, q=6)
rcu: All QSes seen, last rcu_preempt kthread activity 3752 (4295396561-4295392809), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 3752 jiffies! g2785 f0x0 RCU_GP_ONOFF(3) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
Call trace:
 __switch_to+0x10c/0x200 arch/arm64/kernel/process.c:578
 context_switch kernel/sched/core.c:3773 [inline]
 __schedule+0x2d8/0x980 kernel/sched/core.c:4522
 preempt_schedule_common+0x4c/0x1a8 kernel/sched/core.c:4681
 preempt_schedule+0x38/0x40 kernel/sched/core.c:4706
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x94/0xa8 kernel/locking/spinlock.c:183
 rcu_gp_init kernel/rcu/tree.c:1820 [inline]
 rcu_gp_kthread+0x34c/0x1bd8 kernel/rcu/tree.c:2105
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=3752 jiffies, g=2817, q=6)
rcu: All QSes seen, last rcu_preempt kthread activity 856 (4295412565-4295411709), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 856 jiffies! g2817 f0x2 RCU_GP_CLEANUP(7) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
Call trace:
 __switch_to+0x10c/0x200 arch/arm64/kernel/process.c:578
 context_switch kernel/sched/core.c:3773 [inline]
 __schedule+0x2d8/0x980 kernel/sched/core.c:4522
 preempt_schedule_common+0x4c/0x1a8 kernel/sched/core.c:4681
 preempt_schedule+0x38/0x40 kernel/sched/core.c:4706
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
 _raw_spin_unlock_irq+0x84/0x98 kernel/locking/spinlock.c:199
 rcu_gp_cleanup kernel/rcu/tree.c:2015 [inline]
 rcu_gp_kthread+0x1038/0x1bd8 kernel/rcu/tree.c:2119
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
BUG: workqueue lockup - pool cpus=0 flags=0x4 nice=0 stuck for 16s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    pending: vmstat_shepherd
workqueue events_power_efficient: flags=0x82
  pwq 2: cpus=0 flags=0x4 nice=0 active=2/256 refcnt=4
    pending: neigh_periodic_work, do_cache_clean
workqueue rcu_gp: flags=0x8
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
    in-flight: 15:srcu_invoke_callbacks
pool 0: cpus=0 node=0 flags=0x0 nice=0 hung=0s workers=3 idle: 111 5
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=3752 jiffies, g=2829, q=6)
rcu: All QSes seen, last rcu_preempt kthread activity 1522 (4295422970-4295421448), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 1522 jiffies! g2829 f0x2 RCU_GP_CLEANUP(7) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 sched_show_task kernel/sched/core.c:6445 [inline]
 sched_show_task+0x1fc/0x228 kernel/sched/core.c:6420
 rcu_check_gp_kthread_starvation+0xc8/0xe4 kernel/rcu/tree_stall.h:452
 print_other_cpu_stall kernel/rcu/tree_stall.h:520 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:640 [inline]
 rcu_pending kernel/rcu/tree.c:3752 [inline]
 rcu_sched_clock_irq+0xb34/0xc48 kernel/rcu/tree.c:2581
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
 finish_lock_switch kernel/sched/core.c:3513 [inline]
 finish_task_switch+0xa8/0x290 kernel/sched/core.c:3613
 context_switch kernel/sched/core.c:3776 [inline]
 __schedule+0x2dc/0x980 kernel/sched/core.c:4522
 preempt_schedule_common+0x4c/0x1a8 kernel/sched/core.c:4681
 preempt_schedule+0x38/0x40 kernel/sched/core.c:4706
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
 _raw_spin_unlock_irq+0x84/0x98 kernel/locking/spinlock.c:199
 rcu_gp_cleanup kernel/rcu/tree.c:2046 [inline]
 rcu_gp_kthread+0x1144/0x1bd8 kernel/rcu/tree.c:2119
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=3752 jiffies, g=2845, q=6)
rcu: All QSes seen, last rcu_preempt kthread activity 2796 (4295435367-4295432571), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 2796 jiffies! g2845 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x0000042a
Call trace:
 dump_backtrace+0x0/0x240 arch/arm64/kernel/stacktrace.c:100
 show_stack+0x34/0x88 arch/arm64/kernel/stacktrace.c:196
 sched_show_task kernel/sched/core.c:6445 [inline]
 sched_show_task+0x1fc/0x228 kernel/sched/core.c:6420
 rcu_check_gp_kthread_starvation+0xc8/0xe4 kernel/rcu/tree_stall.h:452
 print_other_cpu_stall kernel/rcu/tree_stall.h:520 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:640 [inline]
 rcu_pending kernel/rcu/tree.c:3752 [inline]
 rcu_sched_clock_irq+0xb34/0xc48 kernel/rcu/tree.c:2581
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
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:124 [inline]
 rcu_irq_enter_irqson+0x40/0x78 kernel/rcu/tree.c:1078
 trace_preempt_disable_rcuidle include/trace/events/preemptirq.h:51 [inline]
 trace_preempt_off+0x108/0x1f8 kernel/trace/trace_preemptirq.c:130
 preempt_latency_start kernel/sched/core.c:4164 [inline]
 preempt_latency_start kernel/sched/core.c:4157 [inline]
 preempt_schedule_notrace+0x170/0x1c0 kernel/sched/core.c:4747
 __ftrace_ops_list_func kernel/trace/ftrace.c:6956 [inline]
 ftrace_ops_list_func+0x108/0x230 kernel/trace/ftrace.c:6977
 ftrace_graph_call+0x0/0x4
 preempt_count_add+0x8/0x1a0 arch/arm64/include/asm/atomic.h:65
 schedule+0x44/0x100 kernel/sched/core.c:4599
 schedule_timeout+0x240/0x538 kernel/time/timer.c:1871
 rcu_gp_fqs_loop kernel/rcu/tree.c:1942 [inline]
 rcu_gp_kthread+0x618/0x1bd8 kernel/rcu/tree.c:2115
 kthread+0x13c/0x188 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:961
OK

--0OAP2g/MAC+5xKAE--
