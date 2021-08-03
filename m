Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A9C4338F
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9995A601FD
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhHCOZP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:25:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236331AbhHCOZO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Aug 2021 10:25:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4731F11FB;
        Tue,  3 Aug 2021 07:25:03 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1436F3F66F;
        Tue,  3 Aug 2021 07:25:00 -0700 (PDT)
Date:   Tue, 3 Aug 2021 15:24:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Yanfei Xu <yanfei.xu@windriver.com>
Subject: Re: [PATCH rcu 02/18] rcu: Fix stall-warning deadlock due to
 non-release of rcu_node ->lock
Message-ID: <20210803142458.teveyn6t2gwifdcp@e107158-lin.cambridge.arm.com>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210721202127.2129660-2-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi

On 07/21/21 13:21, Paul E. McKenney wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> If rcu_print_task_stall() is invoked on an rcu_node structure that does
> not contain any tasks blocking the current grace period, it takes an
> early exit that fails to release that rcu_node structure's lock.  This
> results in a self-deadlock, which is detected by lockdep.
> 
> To reproduce this bug:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
> 
> This will also result in other complaints, including RCU's scheduler
> hook complaining about blocking rather than preemption and an rcutorture
> writer stall.
> 
> Only a partial RCU CPU stall warning message will be printed because of
> the self-deadlock.
> 
> This commit therefore releases the lock on the rcu_print_task_stall()
> function's early exit path.
> 
> Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

We are seeing similar stall/deadlock issue on android 5.10 kernel, is the fix
relevant here? Trying to apply the patches and test, but the problem is tricky
to reproduce so thought worth asking first.


	[ 1010.244334] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:"}
	[ 1010.250538] rcu: \t2-...!: (42 GPs behind) idle=884/0/0x0 softirq=1646/1647 fqs=0  (false positive?)"}
	[ 1010.259746] rcu: \t3-...!: (1 ticks this GP) idle=134/0/0x0 softirq=3205/3205 fqs=0  (false positive?)"}
	[ 1010.269013] \t(detected by 4, t=6502 jiffies, g=9121, q=110)"}
	[ 1010.274621] "}
	[ 1010.276115] ============================================"}
	[ 1010.281438] WARNING: possible recursive locking detected"}
	[ 1010.286763] 5.10.43-g92fdbb553f50-ab979 #1 Not tainted"}
	[ 1010.291912] --------------------------------------------"}
	[ 1010.297235] swapper/4/0 is trying to acquire lock:"}
	[ 1010.302037] ffff8000121fe618 (rcu_node_0){-.-.}-{2:2}, at: rcu_dump_cpu_stacks+0x60/0xf8"}
	[ 1010.310183] "}
	[ 1010.310183] but task is already holding lock:"}
	[ 1010.316028] ffff8000121fe618 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0x658/0xca0"}
	[ 1010.324341] "}
	[ 1010.324341] other info that might help us debug this:"}
	[ 1010.330882]  Possible unsafe locking scenario:"}
	[ 1010.330882] "}
	[ 1010.336813]        CPU0"}
	[ 1010.339263]        ----"}
	[ 1010.341713]   lock(rcu_node_0);"}
	[ 1010.344872]   lock(rcu_node_0);"}
	[ 1010.348029] "}
	[ 1010.348029]  *** DEADLOCK ***"}
	[ 1010.348029] "}
	[ 1010.353961]  May be due to missing lock nesting notation"}
	[ 1010.353961] "}
	[ 1010.360764] 1 lock held by swapper/4/0:"}
	[ 1010.364607]  #0: ffff8000121fe618 (rcu_node_0){-.-.}-{2:2}, at: rcu_sched_clock_irq+0x658/0xca0"}
	[ 1010.373359] "}
	[ 1010.373359] stack backtrace:"}
	[ 1010.377729] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.10.43-g92fdbb553f50-ab979 #1"}
	[ 1010.385489] Hardware name: ARM Juno development board (r0) (DT)"}
	[ 1010.391421] Call trace:"}
	[ 1010.393877]  dump_backtrace+0x0/0x1c0"}
	[ 1010.397551]  show_stack+0x24/0x30"}
	[ 1010.400877]  dump_stack_lvl+0xf4/0x130"}
	[ 1010.404636]  dump_stack+0x18/0x58"}
	[ 1010.407962]  __lock_acquire+0xa18/0x1ffc"}
	[ 1010.411895]  lock_acquire.part.0+0xc8/0x30c"}
	[ 1010.416089]  lock_acquire+0x68/0x84"}
	[ 1010.419589]  _raw_spin_lock_irqsave+0x84/0x158"}
	[ 1010.424045]  rcu_dump_cpu_stacks+0x60/0xf8"}
	[ 1010.428154]  rcu_sched_clock_irq+0x8d8/0xca0"}
	[ 1010.432435]  update_process_times+0x6c/0xb0"}
	[ 1010.436632]  tick_sched_handle+0x3c/0x60"}
	[ 1010.440566]  tick_sched_timer+0x58/0xb0"}
	[ 1010.444412]  __hrtimer_run_queues+0x1a4/0x5b0"}
	[ 1010.448781]  hrtimer_interrupt+0xf4/0x2cc"}
	[ 1010.452803]  arch_timer_handler_phys+0x40/0x50"}
	[ 1010.457260]  handle_percpu_devid_irq+0x98/0x180"}
	[ 1010.461803]  __handle_domain_irq+0x80/0xec"}
	[ 1010.465911]  gic_handle_irq+0x5c/0xf0"}
	[ 1010.469583]  el1_irq+0xcc/0x180"}
	[ 1010.472735]  cpuidle_enter_state+0xe8/0x350"}
	[ 1010.476929]  cpuidle_enter+0x44/0x60"}
	[ 1010.480515]  do_idle+0x25c/0x2f0"}
	[ 1010.483751]  cpu_startup_entry+0x34/0x8c"}
	[ 1010.487687]  secondary_start_kernel+0x154/0x190"}


Thanks

--
Qais Yousef
