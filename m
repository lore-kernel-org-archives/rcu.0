Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F64C388F9
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 18:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DDF20797
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 18:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMelV46A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKKSXg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgKKSXf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 13:23:35 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F3E2076E;
        Wed, 11 Nov 2020 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605119013;
        bh=thwSIYGZwA+M6lo+olwWO2RTgi4srQ6bIvtdCjYCQao=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hMelV46A6byW7HFLrR6PlMCvXadJIKkGpRH6gdPmQnsNML7rO5uJSRYDNUdj3SqYt
         E/m8bNEINefQ4qehTvKmR3i8vA0ubQXBfhx7P+YjwPt3QEF/pIAoilfe2kY5wqpsEK
         v19medBLcUc7LoijcNWgbJivF4h/vao41ovQYqa8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2AF3E35225D6; Wed, 11 Nov 2020 10:23:33 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:23:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>,
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
Message-ID: <20201111182333.GA3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201110135320.3309507-1-elver@google.com>
 <CADYN=9+=-ApMi_eEdAeHU6TyuQ7ZJSTQ8F-FCSD33kZH8HR+xg@mail.gmail.com>
 <CANpmjNM8MZphvkTSo=KgCBXQ6fNY4qo6NZD5SBHjNse_L9i5FQ@mail.gmail.com>
 <20201111133813.GA81547@elver.google.com>
 <20201111130543.27d29462@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111130543.27d29462@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 11, 2020 at 01:05:43PM -0500, Steven Rostedt wrote:
> On Wed, 11 Nov 2020 14:38:13 +0100
> Marco Elver <elver@google.com> wrote:
> 
> > [+Cc folks who can maybe help figure out what's going on, since I get
> >   warnings even without KFENCE on next-20201110.]
> > 
> > On Wed, Nov 11, 2020 at 09:29AM +0100, Marco Elver wrote:
> > > On Wed, 11 Nov 2020 at 00:23, Anders Roxell <anders.roxell@linaro.org> wrote:
> > > [...]
> > > > I gave them a spin on next-20201105 [1] and on next-20201110 [2].
> > > >
> > > > I eventually got to a prompt on next-20201105.
> > > > However, I got to this kernel panic on the next-20201110:
> > > >
> > > > [...]
> > > > [ 1514.089966][    T1] Testing event system initcall: OK
> > > > [ 1514.806232][    T1] Running tests on all trace events:
> > > > [ 1514.857835][    T1] Testing all events:
> > > > [ 1525.503262][    C0] hrtimer: interrupt took 10902600 ns
> > > > [ 1623.861452][    C0] BUG: workqueue lockup - pool cpus=0 node=0
> > > > flags=0x0 nice=0 stuck for 65s!
> > > > [...]
> 
> OK, so this blows up when you enable all events?
> 
> Note, it could just be adding overhead (which is exasperated with other
> debug options enabled), which could open up a race window.
>  
> 
> > > > [ 7823.104349][   T28]       Tainted: G        W
> > > > 5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > > [ 7833.206491][   T28] "echo 0 >
> > > > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > [ 7840.750700][   T28] task:kworker/0:1     state:D stack:26640 pid:
> > > > 1872 ppid:     2 flags:0x00000428
> > > > [ 7875.642531][   T28] Workqueue: events toggle_allocation_gate
> > > > [ 7889.178334][   T28] Call trace:
> > > > [ 7897.066649][   T28]  __switch_to+0x1cc/0x1e0
> > > > [ 7905.326856][   T28]  0xffff00000f7077b0
> > > > [ 7928.354644][   T28] INFO: lockdep is turned off.
> > > > [ 7934.022572][   T28] Kernel panic - not syncing: hung_task: blocked tasks
> > > > [ 7934.032039][   T28] CPU: 0 PID: 28 Comm: khungtaskd Tainted: G
> > > >   W         5.10.0-rc3-next-20201110-00008-g8dc06700529d #3
> > > > [ 7934.045586][   T28] Hardware name: linux,dummy-virt (DT)
> > > > [ 7934.053677][   T28] Call trace:
> > > > [ 7934.060276][   T28]  dump_backtrace+0x0/0x420
> > > > [ 7934.067635][   T28]  show_stack+0x38/0xa0
> > > > [ 7934.091277][   T28]  dump_stack+0x1d4/0x278
> > > > [ 7934.098878][   T28]  panic+0x304/0x5d8
> > > > [ 7934.114923][   T28]  check_hung_uninterruptible_tasks+0x5e4/0x640
> > > > [ 7934.123823][   T28]  watchdog+0x138/0x160
> > > > [ 7934.131561][   T28]  kthread+0x23c/0x260
> > > > [ 7934.138590][   T28]  ret_from_fork+0x10/0x18
> > > > [ 7934.146631][   T28] Kernel Offset: disabled
> > > > [ 7934.153749][   T28] CPU features: 0x0240002,20002004
> > > > [ 7934.161476][   T28] Memory Limit: none
> > > > [ 7934.171272][   T28] ---[ end Kernel panic - not syncing: hung_task:
> > > > blocked tasks ]---
> > > >
> > > > Cheers,
> > > > Anders
> > > > [1] https://people.linaro.org/~anders.roxell/output-next-20201105-test.log
> > > > [2] https://people.linaro.org/~anders.roxell/output-next-20201110-test.log
> > > 
> > > Thanks for testing. The fact that it passes on next-20201105 but not
> > > on 20201110 is strange. If you boot with KFENCE disabled (boot param
> > > kfence.sample_interval=0), does it boot?
> > [...]
> > 
> > Right, so I think this is no longer KFENCE's fault. This looks like
> > something scheduler/RCU/ftrace related?! I notice that there have been
> > scheduler changes between next-20201105 and next-20201110.
> 
> I'm not sure any of that would cause this.
> 
> > 
> > I get this with KFENCE disabled:
> > 
> > | Running tests on all trace events:
> > | Testing all events: 
> > | BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 32s!
> > | Showing busy workqueues and worker pools:
> > | workqueue events: flags=0x0
> > |   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
> > |     pending: vmstat_shepherd
> > | workqueue events_power_efficient: flags=0x82
> > |   pwq 2: cpus=0 flags=0x5 nice=0 active=2/256 refcnt=4
> > |     in-flight: 107:neigh_periodic_work
> > |     pending: do_cache_clean
> > | pool 2: cpus=0 flags=0x5 nice=0 hung=3s workers=2 manager: 7
> > | rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > | 	(detected by 0, t=6502 jiffies, g=2885, q=4)
> > | rcu: All QSes seen, last rcu_preempt kthread activity 5174 (4295523265-4295518091), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > | rcu: rcu_preempt kthread starved for 5174 jiffies! g2885 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> > | rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > | rcu: RCU grace-period kthread stack dump:
> > | task:rcu_preempt     state:R  running task     stack:    0 pid:   10 ppid:     2 flags:0x00000428
> > | Call trace:
> > |  __switch_to+0x100/0x1e0
> > |  __schedule+0x2d0/0x890
> > |  preempt_schedule_notrace+0x70/0x1c0
> > |  ftrace_ops_no_ops+0x174/0x250
> > |  ftrace_graph_call+0x0/0xc
> 
> Note, just because ftrace is called here, the blocked task was preempted
> when the ftrace code called preempt_enable_notrace().
> 
> 
> > |  preempt_count_add+0x1c/0x180
> > |  schedule+0x44/0x108
> > |  schedule_timeout+0x394/0x530
> > |  rcu_gp_kthread+0x76c/0x19a8
> > |  kthread+0x174/0x188
> > |  ret_from_fork+0x10/0x18
> > | 
> > | ================================
> > | WARNING: inconsistent lock state
> > | 5.10.0-rc3-next-20201110-00001-gc07b306d7fa5-dirty #18 Not tainted
> > | --------------------------------
> > | inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > | kcompactd0/26 [HC0[0]:SC0[0]:HE0:SE1] takes:
> > | ffffae32e6bd4358 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x4a0/0xd18
> > | {IN-HARDIRQ-W} state was registered at:
> 
> I did some digging here and it looks like the rcu_node lock could be taken
> without interrupts enabled when it does a stall print. That probably should
> be fixed, but it's a symptom of the underlining bug and not the cause.

Does this patch (in -next) help?

							Thanx, Paul

------------------------------------------------------------------------

commit c583bcb8f5edd48c1798798e341f78afb9bf4f6f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Sep 24 15:11:55 2020 -0700

    rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled
    
    The try_invoke_on_locked_down_task() function requires that
    interrupts be enabled, but it is called with interrupts disabled from
    rcu_print_task_stall(), resulting in an "IRQs not enabled as expected"
    diagnostic.  This commit therefore updates rcu_print_task_stall()
    to accumulate a list of the first few tasks while holding the current
    leaf rcu_node structure's ->lock, then releases that lock and only then
    uses try_invoke_on_locked_down_task() to attempt to obtain per-task
    detailed information.  Of course, as soon as ->lock is released, the
    task might exit, so the get_task_struct() function is used to prevent
    the task structure from going away in the meantime.
    
    Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
    Fixes: 5bef8da66a9c ("rcu: Add per-task state to RCU CPU stall warnings")
    Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
    Reported-by: syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com
    Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0fde39b..ca21d28 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -249,13 +249,16 @@ static bool check_slow_task(struct task_struct *t, void *arg)
 
 /*
  * Scan the current list of tasks blocked within RCU read-side critical
- * sections, printing out the tid of each.
+ * sections, printing out the tid of each of the first few of them.
  */
-static int rcu_print_task_stall(struct rcu_node *rnp)
+static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
+	int i = 0;
 	int ndetected = 0;
 	struct rcu_stall_chk_rdr rscr;
 	struct task_struct *t;
+	struct task_struct *ts[8];
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
@@ -264,6 +267,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
+		get_task_struct(t);
+		ts[i++] = t;
+		if (i >= ARRAY_SIZE(ts))
+			break;
+	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	for (i--; i; i--) {
+		t = ts[i];
 		if (!try_invoke_on_locked_down_task(t, check_slow_task, &rscr))
 			pr_cont(" P%d", t->pid);
 		else
@@ -273,6 +284,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list]);
+		put_task_struct(t);
 		ndetected++;
 	}
 	pr_cont("\n");
@@ -293,8 +305,9 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * Because preemptible RCU does not exist, we never have to check for
  * tasks blocked within RCU read-side critical sections.
  */
-static int rcu_print_task_stall(struct rcu_node *rnp)
+static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 {
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
 }
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
@@ -472,7 +485,6 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		ndetected += rcu_print_task_stall(rnp);
 		if (rnp->qsmask != 0) {
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
@@ -480,7 +492,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 					ndetected++;
 				}
 		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
 	}
 
 	for_each_possible_cpu(cpu)
