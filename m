Return-Path: <SRS0=2gH0=EF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB5C4363A
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 14:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACBE221EB
	for <rcu@archiver.kernel.org>; Fri, 30 Oct 2020 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604066434;
	bh=j3obZakTnBgtH0du/tVf4SGr9E3NKxjtntctt0NgIzk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=REIUfF56rYgLrehY1SB4etT0jDgWit+xISBBxFESQc2kQstFBBBJ4fGM51ZEId/AY
	 HUy/8fMZkdhPDuycNwsymVjME3ayLJH/pWFkSiHkSTJJIy86yjIFo1xHzhJRbKutkn
	 rCEU8pr7fQFkNUL7RM8+LdUDYJMKAJrRQ2D1KJZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3OAe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgJ3OAe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Oct 2020 10:00:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28FAF2083B;
        Fri, 30 Oct 2020 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604066433;
        bh=j3obZakTnBgtH0du/tVf4SGr9E3NKxjtntctt0NgIzk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VqPKWlWfzvJ+cnBXHkxqkC+oOeWiZEsHXubCDoFjfPJeVLo1JfHzgpAqgPNnDWrnG
         68kBoIFV6g+XLUGr2ktUnO6j23Xj4a5hBjxALBBeNwdRbT+GoaNapCpQ51N/HRyeAX
         u8Y6NGfZDYgIzTiseEwtgsWIUsHF0EW6AXBv4FLg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B5B713522675; Fri, 30 Oct 2020 07:00:32 -0700 (PDT)
Date:   Fri, 30 Oct 2020 07:00:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RCU stall uses try_invoke_on_locked_down_task() with disabled
 interrupts
Message-ID: <20201030140032.GS3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201030132835.plzgp5d6bv3rslr2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030132835.plzgp5d6bv3rslr2@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 30, 2020 at 02:28:35PM +0100, Sebastian Andrzej Siewior wrote:
> |rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> |rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
> |------------[ cut here ]------------
> |WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:3009 try_invoke_on_locked_down_task+0x8a/0x120
> |Modules linked in:
> |CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.10.0-rc1+ #27
> |Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2014
> |EIP: try_invoke_on_locked_down_task+0x8a/0x120
> |Call Trace:
> | rcu_sched_clock_irq.cold+0x269/0x459
> | update_process_times+0x44/0x80
> | tick_sched_timer+0xe1/0x140
> | __hrtimer_run_queues+0x216/0x560
> | hrtimer_interrupt+0x115/0x260
> | __sysvec_apic_timer_interrupt+0x88/0x2c0
> | sysvec_apic_timer_interrupt+0x39/0x50
> | handle_exception+0x10e/0x10e
> 
> rcu_sched_clock_irq.cold+0x269/0x459 is 
> kernel/rcu/tree_stall.h:267 kernel/rcu/tree_stall.h:475 kernel/rcu/tree_stall.h:634 kernel/rcu/tree.c:3696 kernel/rcu/tree.c:2569

Is this fixed by the following commit 8a26c219cafe ("rcu: Don't invoke
try_invoke_on_locked_down_task() with irqs disabled")?

If so, apologies, I failed to make the -rcu tree's for-v5.11 commits
visible to -next until quite recently.  :-/

							Thanx, Paul

------------------------------------------------------------------------

commit 8a26c219cafe66431da3350da1687a50f635f3c2
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
    Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
    Reported-by: syzbot+f04854e1c5c9e913cc27@syzkaller.appspotmail.com
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 228c55f..70d48c5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -255,13 +255,16 @@ static bool check_slow_task(struct task_struct *t, void *arg)
 
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
@@ -270,6 +273,14 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
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
@@ -279,6 +290,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp)
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list]);
+		put_task_struct(t);
 		ndetected++;
 	}
 	pr_cont("\n");
@@ -299,8 +311,9 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
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
@@ -478,7 +491,6 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		ndetected += rcu_print_task_stall(rnp);
 		if (rnp->qsmask != 0) {
 			for_each_leaf_node_possible_cpu(rnp, cpu)
 				if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
@@ -486,7 +498,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 					ndetected++;
 				}
 		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
 	}
 
 	for_each_possible_cpu(cpu)
