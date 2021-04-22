Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB83C433ED
	for <rcu@archiver.kernel.org>; Thu, 22 Apr 2021 14:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C712E611CD
	for <rcu@archiver.kernel.org>; Thu, 22 Apr 2021 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhDVOg2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVOg1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Apr 2021 10:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC7CD61428;
        Thu, 22 Apr 2021 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619102152;
        bh=tiFdvPYULgY4FUcClRjG+ICYuT+cpftBB1VtMGuSHuQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IU7OSQlrNR2H1A7yCsg3imQrnJtwlKTd61ImcC6LjRvIneBVvhxj5h5Jr/OPrwoJr
         fMZORfIAfQljbdGNATJtpHDkKBnxVqfDOq6+5hpEL24nGPzI36DTtCnhRJGhFsXGhE
         v3V8Nf2y3MqMXaY+4psSqu+bqoqNEXj4BWcPwBcWh9mLD1wFY5piuibGdPhKBri2/R
         VRX6luryI6+ywHkTUh54n+H6DPDt3iH1xsjaJRHY6X1bAsIuT93If1M4+kK5b45rqS
         oojS4EfU3rRCjKXbYG/orRlln3Snao2AAdt/OXDHWZOleclkKp8lGs+08Cl39Z8uv0
         ecOGXo2B89ZSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 41F8A5C03C3; Thu, 22 Apr 2021 07:35:52 -0700 (PDT)
Date:   Thu, 22 Apr 2021 07:35:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: RCU stall query
Message-ID: <20210422143552.GE975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <52dabee9-9c00-d9f9-7df2-4ae1dc643349@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52dabee9-9c00-d9f9-7df2-4ae1dc643349@huawei.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 22, 2021 at 10:20:51AM +0100, John Garry wrote:
> Hi RCU experts,
> 
> Recently I have noticed that I can trigger an RCU stall quite easily on my
> system under specific conditions.
> 
> I have a fair idea why it happens, but need to analyze a proper solution
> further. It looks like a hard IRQ handler and threaded part are tied to
> specific CPU and getting swamped and not relinquishing.
> 
> However, mixed in the RCU splats, I have noticed many BUG logs, like:
> 
> [  207.788748] BUG: spinlock recursion on CPU#46, fio/1470

This is a self-deadlock.  Given that deadlock, and given that spinlocks
disable preemption, the RCU CPU stall warnings are expected behavior.
After all, your code really is grabbing a CPU by the throat and shaking
it indefinitely.

Please build your kernel with CONFIG_PROVE_LOCKING=y and then fix the
issues it calls out.  Then please also fix the bugs resulting in the
"sleeping function called from invalid context" and in the "scheduling
while atomic".

In addition, there are quite a few idle tasks called out in your list of
stalled CPUs.  This is often due to RCU's grace-period kthread (named
"rcu_preempt" in this case) not getting any CPU time.  This is not
unexpected given the "RT throttling activated".  If you are going to run
code at real-time priorities, you must ensure that any number of kernel
kthreads get the CPU time that they need.  As Spiderman's uncle said
"With great power comes great responsibility".

							Thanx, Paul

> in ..
> 
> fio-3.1
> Starting 6 processes
> [70.656622] sched: RT throttling activatedB/s][r=356k,w=0 IOPS][eta
> 01h:14m:43s]
> [  207.632161] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:ta
> 01h:12m:26s]
> [  207.638261] rcu:  0-...!: (1 GPs behind) idle=312/1/0x4000000000000000
> softirq=508/512 fqs=0
> [  207.646777] rcu:  1-...!: (1 GPs behind) idle=694/0/0x0 softirq=868/869
> fqs=1
> [  207.653988] rcu:  2-...!: (1 GPs behind) idle=e80/0/0x0 softirq=567/568
> fqs=1
> [  207.661199] rcu:  3-...!: (1 GPs behind) idle=e92/1/0x4000000000000000
> softirq=529/540 fqs=1
> [  207.669713] rcu:  4-...!: (1 ticks this GP) idle=fee/1/0x4000000000000002
> softirq=403/404 fqs=1
> [  207.678486] rcu:  5-...!: (1 GPs behind) idle=fb8/0/0x0 softirq=1165/1167
> fqs=1
> [  207.685871] rcu:  6-...!: (1 GPs behind) idle=05c/0/0x0 softirq=408/408
> fqs=1
> [  207.693081] rcu:  7-...!: (1 GPs behind) idle=b78/0/0x0 softirq=405/406
> fqs=1
> [  207.700292] rcu:  8-...!: (1 ticks this GP) idle=b12/1/0x4000000000000002
> softirq=490/491 fqs=1
> [  207.709065] rcu:  9-...!: (1 GPs behind) idle=628/0/0x0 softirq=330/331
> fqs=1
> [  207.716275] rcu:  10-...!: (1 GPs behind) idle=7c0/0/0x0 softirq=431/431
> fqs=1
> [  207.723573] rcu:  11-...!: (1 GPs behind) idle=28c/0/0x0 softirq=560/563
> fqs=1
> [  207.730870] rcu:  12-...!: (1 GPs behind) idle=68c/0/0x0 softirq=427/431
> fqs=1
> [  207.738167] rcu:  13-...!: (25 ticks this GP) idle=814/0/0x0
> softirq=356/356 fqs=1
> [  207.745812] rcu:  14-...!: (1 GPs behind) idle=8a0/0/0x0 softirq=631/631
> fqs=1
> [  207.753109] rcu:  15-...!: (1 GPs behind) idle=2c0/0/0x0 softirq=300/300
> fqs=1
> [  207.760405] rcu:  Tasks blocked on level-1 rcu_node (CPUs 0-15): P442
> P520
> [  207.767280] rcu:  25-...!: (1 GPs behind) idle=e58/0/0x0 softirq=581/581
> fqs=1
> [  207.774577] rcu:  46-...!: (1 GPs behind) idle=9c2/1/0x4000000000000002
> softirq=268/268 fqs=2
> [  207.783185]  (detected by 46, t=5289 jiffies, g=953, q=778)
> [  207.788748] BUG: spinlock recursion on CPU#46, fio/1470
> [  207.793961]  lock: rcu_state+0x500/0x2d00, .magic: dead4ead, .owner:
> fio/1470, .owner_cpu: 46
> [  207.802492] CPU: 46 PID: 1470 Comm: fio Not tainted
> 5.12.0-rc7-00011-g69d2c55f9bb8 #228
> [  207.810485] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05
> IT21 Nemo 2.0 RC0 04/18/2018
> [  207.819606] Call trace:
> [  207.822040]  dump_backtrace+0x0/0x1b0
> [  207.825698]  show_stack+0x18/0x68
> [  207.829002]  dump_stack+0xd8/0x134
> [  207.832396]  spin_dump+0x84/0x94
> [  207.835615]  do_raw_spin_lock+0x108/0x120
> [  207.839617]  _raw_spin_lock_irqsave+0x30/0x60
> [  207.843965]  rcu_dump_cpu_stacks+0x70/0x140
> [  207.848138]  rcu_sched_clock_irq+0xaac/0xc80
> [  207.852400]  update_process_times+0x9c/0xe8
> [  207.856573]  tick_sched_handle.isra.20+0x40/0x58
> [  207.861181]  tick_sched_timer+0x4c/0xa8
> [  207.865006]  __hrtimer_run_queues+0x11c/0x1b0
> [  207.869352]  hrtimer_interrupt+0xe8/0x240
> [  207.873351]  arch_timer_handler_phys+0x30/0x40
> [  207.877786]  handle_percpu_devid_irq+0x84/0x148
> [  207.882307]  generic_handle_irq+0x30/0x48
> [  207.886304]  __handle_domain_irq+0x64/0xc0
> [  207.890389]  gic_handle_irq+0xc0/0x138
> [  207.894131]  el1_irq+0xb0/0x180
> [  207.897261]  do_io_getevents+0x78/0x168
> [  207.901088]  __arm64_sys_io_getevents+0x60/0xd0
> [  207.905606]  el0_svc_common.constprop.2+0x8c/0x128
> [  207.910387]  do_el0_svc+0x24/0x90
> [  207.913690]  el0_svc+0x24/0x38
> [  207.916733]  el0_sync_handler+0x90/0xb8
> [  207.920557]  el0_sync+0x154/0x180
> [  228.640117] rcu: INFO: rcu_preempt detected stalls on
> CPUs/tasks::12m:05s]
> 
> 
> And on other runs:
> 
> [375.140802] BUG: sleeping function called from invalid context at
> include/linux/uaccess.h:174
> 
> [375.224247] BUG: scheduling while atomic: fio/1473/0x00000004
> 
> [ 740.723625] BUG: scheduling while atomic: swapper/64/0/0x00000008
> 
> This seems to be something to be concerned about. Could this be related to
> RCU code, or some BUG(s) which may be exposed as a side-effect of the RCU
> stall?
> 
> Some relevant config items are below. And another splat.
> 
> Thanks,
> John
> 
> 
> # RCU Subsystem
> CONFIG_TREE_RCU=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_FANOUT=64
> CONFIG_RCU_FANOUT_LEAF=16
> # CONFIG_RCU_FAST_NO_HZ is not set
> # CONFIG_RCU_BOOST is not set
> # CONFIG_RCU_NOCB_CPU is not set
> # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> # end of RCU Subsystem
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> # RCU Debugging
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_TRACE=y
> # CONFIG_RCU_EQS_DEBUG is not set
> # CONFIG_RCU_STRICT_GRACE_PERIOD is not set
> # end of RCU Debugging
> 
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> CONFIG_DEBUG_SPINLOCK=y
> 
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_COUNT=y
> CONFIG_PREEMPTION=y
> CONFIG_PREEMPT_RCU=y
> CONFIG_PREEMPT_NOTIFIERS=y
> # CONFIG_DEBUG_PREEMPT is not set
> 
> 
> 
> john@ubuntu:~$ [243.624228] sched: RT throttling activated
> [316.247401] loop0: detected capacity change from 0 to 8
> [331.631543] Filesystem uses "xz" compression. This is not supported
> [375.110768] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [375.116873] rcu: Tasks blocked on level-1 rcu_node (CPUs 0-15):
> [375.122882](detected by 54, t=5255 jiffies, g=2069, q=1865)
> [375.128617] rcu: All QSes seen, last rcu_preempt kthread activity 1
> (4294985656-4294985655), jiffies_till_next_fqs=1, root ->qsmask 0x1
> [375.140802] BUG: sleeping function called from invalid context at
> include/linux/uaccess.h:174
> [375.149325] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1473,
> name: fio
> [375.156904] CPU: 54 PID: 1473 Comm: fio Not tainted
> 5.12.0-rc7-00011-g69d2c55f9bb8 #228
> [375.164901] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05
> IT21 Nemo 2.0 RC0 04/18/2018
> [375.174023] Call trace:
> [375.176457]dump_backtrace+0x0/0x1b0
> [375.180126]show_stack+0x18/0x68
> [375.183431]dump_stack+0xd8/0x134
> [375.186825]___might_sleep+0xf8/0x130
> [375.190567]__might_sleep+0x54/0x90
> [375.194130]__might_fault+0x1c/0x28
> [375.197697]put_timespec64+0x44/0xd8
> [375.201351]__arm64_sys_clock_gettime+0xa0/0xe0
> [375.205960]el0_svc_common.constprop.2+0x8c/0x128
> [375.210741]do_el0_svc+0x24/0x90
> [375.214045]el0_svc+0x24/0x38
> [375.217091]el0_sync_handler+0x90/0xb8
> [375.220915]el0_sync+0x154/0x180
> [375.224247] BUG: scheduling while atomic: fio/1473/0x00000004
> [375.229988] Modules linked in:
> [375.233033] CPU: 54 PID: 1473 Comm: fio Tainted: GW
> 5.12.0-rc7-00011-g69d2c55f9bb8 #228
> [375.242413] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05
> IT21 Nemo 2.0 RC0 04/18/2018
> [375.251532] Call trace:
> [375.253966]dump_backtrace+0x0/0x1b0
> [375.257618]show_stack+0x18/0x68
> [375.260922]dump_stack+0xd8/0x134
> [375.264312]__schedule_bug+0x60/0x78
> [375.267963]__schedule+0x63c/0x6e8
> [375.271440]schedule+0x70/0x108
> [375.274657]do_notify_resume+0x1a8/0x428
> [375.278655]work_pending+0xc/0x324
> [375.282182] BUG: spinlock recursion on CPU#54, fio/1473
> [375.287400]lock: rcu_state+0xa00/0x2d00, .magic: dead4ead, .owner:
> fio/1473, .owner_cpu: 54
> [375.295928] CPU: 54 PID: 1473 Comm: fio Tainted: GW
> 5.12.0-rc7-00011-g69d2c55f9bb8 #228
> [375.305309] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05
> IT21 Nemo 2.0 RC0 04/18/2018
> [375.314428] Call trace:
> [375.316862]dump_backtrace+0x0/0x1b0
> [375.320513]show_stack+0x18/0x68
> [375.323817]dump_stack+0xd8/0x134
> [375.327207]spin_dump+0x84/0x94
> [375.330426]do_raw_spin_lock+0x108/0x120
> [375.334427]_raw_spin_lock+0x20/0x30
> [375.338081]rcu_note_context_switch+0xbc/0x348
> [375.342603]__schedule+0xc8/0x6e8
> [375.345993]preempt_schedule_notrace+0x50/0x70
> [375.350512]__arm64_sys_io_submit+0x188/0x240
> [375.354946]el0_svc_common.constprop.2+0x8c/0x128
> [375.359727]do_el0_svc+0x24/0x90
> [375.363032]el0_svc+0x24/0x38
> [375.366074]el0_sync_handler+0x90/0xb8
> [375.369898]el0_sync+0x154/0x180
> [438.130403] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [501.149998] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
