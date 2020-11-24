Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DDC2D0E4
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 03:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E6A20867
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 03:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="urU/6MTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKXDoV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKXDoS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Nov 2020 22:44:18 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5979120857;
        Tue, 24 Nov 2020 03:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606189457;
        bh=KBpMApQhd/4YsrNiab4pwkOUS/yinUhr0BYZPXVRIVE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=urU/6MTmhz3SUDMDpFtibW5ILqrINP81fc5JezHxPhv4zFBLzFICGtdbm9/qnJ7UN
         X3/LoD5P8JG+oXRMDlx6ag4JBzMPm18mkZQxlAL1cbIS+g+5gUUt4m/q5lkjK75Qlc
         aYf+iffgWbppOlhw5ZEom8vDi4vD9Cpeipuzl+J8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EB142352309E; Mon, 23 Nov 2020 19:44:16 -0800 (PST)
Date:   Mon, 23 Nov 2020 19:44:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201124034416.GG1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201120142734.75af5cd6@gandalf.local.home>
 <20201123152720.GA2177956@elver.google.com>
 <20201123112812.19e918b3@gandalf.local.home>
 <20201123134227.6df443db@gandalf.local.home>
 <20201124025945.GG286534@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124025945.GG286534@boqun-archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 24, 2020 at 10:59:45AM +0800, Boqun Feng wrote:
> Hi Steven,
> 
> On Mon, Nov 23, 2020 at 01:42:27PM -0500, Steven Rostedt wrote:
> > On Mon, 23 Nov 2020 11:28:12 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > I noticed:
> > > 
> > > 
> > > [  237.650900] enabling event benchmark_event
> > > 
> > > In both traces. Could you disable CONFIG_TRACEPOINT_BENCHMARK and see if
> > > the issue goes away. That event kicks off a thread that spins in a tight
> > > loop for some time and could possibly cause some issues.
> > > 
> > > It still shouldn't break things, we can narrow it down if it is the culprit.
> > 
> > [ Added Thomas  ]
> > 
> > And that's just one issue. I don't think that has anything to do with the
> > other one:
> > 
> > [ 1614.162007] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [ 1614.168625]  (detected by 0, t=3752 jiffies, g=3529, q=1)
> > [ 1614.170825] rcu: All QSes seen, last rcu_preempt kthread activity 242 (4295293115-4295292873), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > [ 1614.194272] 
> > [ 1614.196673] ================================
> > [ 1614.199738] WARNING: inconsistent lock state
> > [ 1614.203056] 5.10.0-rc4-next-20201119-00004-g77838ee21ff6-dirty #21 Not tainted
> > [ 1614.207012] --------------------------------
> > [ 1614.210125] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > [ 1614.213832] swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] takes:
> > [ 1614.217288] ffffd942547f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x7c0/0x17a0
> > [ 1614.225496] {IN-HARDIRQ-W} state was registered at:
> > [ 1614.229031]   __lock_acquire+0xae8/0x1ac8
> > [ 1614.232203]   lock_acquire+0x268/0x508
> > [ 1614.235254]   _raw_spin_lock_irqsave+0x78/0x14c
> > [ 1614.238547]   rcu_sched_clock_irq+0x7c0/0x17a0
> > [ 1614.241757]   update_process_times+0x6c/0xb8
> > [ 1614.244950]   tick_sched_handle.isra.0+0x58/0x88
> > [ 1614.248225]   tick_sched_timer+0x68/0xe0
> > [ 1614.251304]   __hrtimer_run_queues+0x288/0x730
> > [ 1614.254516]   hrtimer_interrupt+0x114/0x288
> > [ 1614.257650]   arch_timer_handler_virt+0x50/0x70
> > [ 1614.260922]   handle_percpu_devid_irq+0x104/0x4c0
> > [ 1614.264236]   generic_handle_irq+0x54/0x78
> > [ 1614.267385]   __handle_domain_irq+0xac/0x130
> > [ 1614.270585]   gic_handle_irq+0x70/0x108
> > [ 1614.273633]   el1_irq+0xc0/0x180
> > [ 1614.276526]   rcu_irq_exit_irqson+0x40/0x78
> > [ 1614.279704]   trace_preempt_on+0x144/0x1a0
> > [ 1614.282834]   preempt_schedule_common+0xf8/0x1a8
> > [ 1614.286126]   preempt_schedule+0x38/0x40
> > [ 1614.289240]   __mutex_lock+0x608/0x8e8
> > [ 1614.292302]   mutex_lock_nested+0x3c/0x58
> > [ 1614.295450]   static_key_enable_cpuslocked+0x7c/0xf8
> > [ 1614.298828]   static_key_enable+0x2c/0x40
> > [ 1614.301961]   tracepoint_probe_register_prio+0x284/0x3a0
> > [ 1614.305464]   tracepoint_probe_register+0x40/0x58
> > [ 1614.308776]   trace_event_reg+0xe8/0x150
> > [ 1614.311852]   __ftrace_event_enable_disable+0x2e8/0x608
> > [ 1614.315351]   __ftrace_set_clr_event_nolock+0x160/0x1d8
> > [ 1614.318809]   __ftrace_set_clr_event+0x60/0x90
> > [ 1614.322061]   event_trace_self_tests+0x64/0x12c
> > [ 1614.325335]   event_trace_self_tests_init+0x88/0xa8
> > [ 1614.328758]   do_one_initcall+0xa4/0x500
> > [ 1614.331860]   kernel_init_freeable+0x344/0x3c4
> > [ 1614.335110]   kernel_init+0x20/0x16c
> > [ 1614.338102]   ret_from_fork+0x10/0x34
> > [ 1614.341057] irq event stamp: 3206302
> > [ 1614.344123] hardirqs last  enabled at (3206301): [<ffffd9425238da04>] rcu_irq_exit_irqson+0x64/0x78
> > [ 1614.348697] hardirqs last disabled at (3206302): [<ffffd942522123c0>] el1_irq+0x80/0x180
> > [ 1614.353013] softirqs last  enabled at (3204216): [<ffffd94252210b80>] __do_softirq+0x630/0x6b4
> > [ 1614.357509] softirqs last disabled at (3204191): [<ffffd942522c623c>] irq_exit+0x1cc/0x1e0
> > [ 1614.361737] 
> > [ 1614.361737] other info that might help us debug this:
> > [ 1614.365566]  Possible unsafe locking scenario:
> > [ 1614.365566] 
> > [ 1614.369128]        CPU0
> > [ 1614.371747]        ----
> > [ 1614.374282]   lock(rcu_node_0);
> > [ 1614.378818]   <Interrupt>
> > [ 1614.381394]     lock(rcu_node_0);
> > [ 1614.385997] 
> > [ 1614.385997]  *** DEADLOCK ***
> > [ 1614.385997] 
> > [ 1614.389613] 5 locks held by swapper/0/1:
> > [ 1614.392655]  #0: ffffd9425480e940 (event_mutex){+.+.}-{3:3}, at: __ftrace_set_clr_event+0x48/0x90
> > [ 1614.401701]  #1: ffffd9425480a530 (tracepoints_mutex){+.+.}-{3:3}, at: tracepoint_probe_register_prio+0x48/0x3a0
> > [ 1614.410973]  #2: ffffd9425476abf0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x24/0x40
> > [ 1614.419858]  #3: ffffd94254816348 (jump_label_mutex){+.+.}-{3:3}, at: static_key_enable_cpuslocked+0x7c/0xf8
> > [ 1614.429049]  #4: ffffd942547f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x7c0/0x17a0
> > [ 1614.438029] 
> > [ 1614.438029] stack backtrace:
> > [ 1614.441436] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc4-next-20201119-00004-g77838ee21ff6-dirty #21
> > [ 1614.446149] Hardware name: linux,dummy-virt (DT)
> > [ 1614.449621] Call trace:
> > [ 1614.452337]  dump_backtrace+0x0/0x240
> > [ 1614.455372]  show_stack+0x34/0x88
> > [ 1614.458306]  dump_stack+0x140/0x1bc
> > [ 1614.461258]  print_usage_bug+0x2a0/0x2f0
> > [ 1614.464399]  mark_lock.part.0+0x438/0x4e8
> > [ 1614.467528]  mark_held_locks+0x54/0x90
> > [ 1614.470576]  lockdep_hardirqs_on_prepare+0xe0/0x290
> > [ 1614.473935]  trace_hardirqs_on+0x90/0x370
> > [ 1614.477045]  el1_irq+0xdc/0x180
> > [ 1614.479934]  rcu_irq_exit_irqson+0x40/0x78
> > [ 1614.483093]  trace_preempt_on+0x144/0x1a0
> > [ 1614.486211]  preempt_schedule_common+0xf8/0x1a8
> > [ 1614.489479]  preempt_schedule+0x38/0x40
> > [ 1614.492544]  __mutex_lock+0x608/0x8e8
> > 
> > 
> > The above has:
> > 
> >  preempt_schedule_common() {
> >    trace_preempt_on() {
> >      <interrupt>
> > 	el1_irq:
> > 	   handle_arch_irq {
> > 	      irq_enter();
> > 	      [..]
> > 	      irq_exit();
> > 	   }
> > 	   bl trace_hardirqs_on
> > 
> > 
> > I wonder if the lockdep logic got confused on ARM64 by the rework done to
> > lockdep and tracing with respect to irq entry / exit.
> > 
> 
> I'm also staring at this problem and another thing caused my attention
> is that there is a line like the following after the lockdep splat:
> 
> [...] BUG: scheduling while atomic ...
> 
> , which means preemption count has some inconsistency too.
> 
> Given this, a possible case cause this is that we got preempted inside a
> rcu_node lock critical section (I know, this is quite impossible, but
> preemption count and lockdep data are maintained quite separately, so
> it's unlikely they are broken at the same time...)
> 
> Will continue to look into this.
> 
> Regards,
> Boqun
> 
> > Or maybe there's an rcu_node leak lock that happened somewhere?

Were these messages accompanied by an RCU CPU stall warning that listed
some preempted tasks blocking the current grace period?  If so, does
this patch in -rcu help?

d02133f517e5 ("sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled")

							Thanx, Paul

------------------------------------------------------------------------

commit d02133f517e5b4eb417ad88b14c0759a0c0deac6
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Aug 29 10:22:24 2020 -0700

    sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
    
    The try_invoke_on_locked_down_task() function currently requires
    that interrupts be enabled, but it is called with interrupts
    disabled from rcu_print_task_stall(), resulting in an "IRQs not
    enabled as expected" diagnostic.  This commit therefore updates
    try_invoke_on_locked_down_task() to use raw_spin_lock_irqsave() instead
    of raw_spin_lock_irq(), thus allowing use from either context.
    
    Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
    Link: https://lore.kernel.org/lkml/20200928075729.GC2611@hirez.programming.kicks-ass.net/
    Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e172f2d..09ef5cf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2984,7 +2984,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 /**
  * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
- * @p: Process for which the function is to be invoked.
+ * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
@@ -3002,12 +3002,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3024,7 +3023,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
