Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0249CC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F85208E0
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586973387;
	bh=R3U8ruUZCy2b+zPpilk1INGfcdSjpW6KV+g7uUbC4hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KS+9WQuMpvrIUdj2884qZCFCW/y/NzX5zTQMEUxo9i7XWEQbyMxVSDX1IRcTqwN+A
	 1iyElnpuE+p5Fow1snm1oTw7tE+cDF7Z7e1dMmjVKnZJe70nVgaQ5QTa7CB2cqPAu/
	 9ltev9r+k/kYzwRDkCTZn4iDIsi/Ty08zLKT+X0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411510AbgDOR4Z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416571AbgDOR4T (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:56:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7CFC21655;
        Wed, 15 Apr 2020 17:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973378;
        bh=R3U8ruUZCy2b+zPpilk1INGfcdSjpW6KV+g7uUbC4hA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMlgMY+o8Ps0Jt8dK7wvjY2aqMu04L67aOVc9wDOQs6+7yd7Eo1CdCD4hPlM2q4A0
         h9nPoRxjYcXpq7Khs75tkS9ev9l7xnWEvEpg/xl4aeUlbKjgXBeRdO2JTw3Jn0IxES
         wybS65ieUg5q6wqSTqKROGJ8B8GvkRy3s1MOtlGk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/6] rcu: Don't use negative nesting depth in __rcu_read_unlock()
Date:   Wed, 15 Apr 2020 10:56:13 -0700
Message-Id: <20200415175614.10837-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415175543.GA10416@paulmck-ThinkPad-P72>
References: <20200415175543.GA10416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Now that RCU flavors have been consolidated, an RCU-preempt
rcu_read_unlock() in an interrupt or softirq handler cannot possibly
end the RCU read-side critical section.  Consider the old vulnerability
involving rcu_read_unlock() being invoked within such a handler that
interrupted an __rcu_read_unlock_special(), in which a wakeup might be
invoked with a scheduler lock held.  Because rcu_read_unlock_special()
no longer does wakeups in such situations, it is no longer necessary
for __rcu_read_unlock() to set the nesting level negative.

This commit therfore removes this recursion-protection code from
__rcu_read_unlock().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
[ paulmck: Let rcu_exp_handler() continue to call rcu_report_exp_rdp(). ]
[ paulmck: Adjust other checks given no more negative nesting. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h    | 31 +++++--------------------------
 kernel/rcu/tree_plugin.h | 22 +++++++---------------
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1a617b9..0e5ccb3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -639,6 +639,7 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
  */
 static void rcu_exp_handler(void *unused)
 {
+	int depth = rcu_preempt_depth();
 	unsigned long flags;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
@@ -649,7 +650,7 @@ static void rcu_exp_handler(void *unused)
 	 * critical section.  If also enabled or idle, immediately
 	 * report the quiescent state, otherwise defer.
 	 */
-	if (!rcu_preempt_depth()) {
+	if (!depth) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
@@ -673,7 +674,7 @@ static void rcu_exp_handler(void *unused)
 	 * can have caused this quiescent state to already have been
 	 * reported, so we really do need to check ->expmask.
 	 */
-	if (rcu_preempt_depth() > 0) {
+	if (depth > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			rdp->exp_deferred_qs = true;
@@ -683,30 +684,8 @@ static void rcu_exp_handler(void *unused)
 		return;
 	}
 
-	/*
-	 * The final and least likely case is where the interrupted
-	 * code was just about to or just finished exiting the RCU-preempt
-	 * read-side critical section, and no, we can't tell which.
-	 * So either way, set ->deferred_qs to flag later code that
-	 * a quiescent state is required.
-	 *
-	 * If the CPU is fully enabled (or if some buggy RCU-preempt
-	 * read-side critical section is being used from idle), just
-	 * invoke rcu_preempt_deferred_qs() to immediately report the
-	 * quiescent state.  We cannot use rcu_read_unlock_special()
-	 * because we are in an interrupt handler, which will cause that
-	 * function to take an early exit without doing anything.
-	 *
-	 * Otherwise, force a context switch after the CPU enables everything.
-	 */
-	rdp->exp_deferred_qs = true;
-	if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
-	    WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs())) {
-		rcu_preempt_deferred_qs(t);
-	} else {
-		set_tsk_need_resched(t);
-		set_preempt_need_resched();
-	}
+	// Finally, negative nesting depth should not happen.
+	WARN_ON_ONCE(1);
 }
 
 /* PREEMPTION=y, so no PREEMPTION=n expedited grace period to clean up after. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f31c599..088e84e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -345,9 +345,7 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
-/* Bias and limit values for ->rcu_read_lock_nesting. */
-#define RCU_NEST_BIAS INT_MAX
-#define RCU_NEST_NMAX (-INT_MAX / 2)
+/* limit value for ->rcu_read_lock_nesting. */
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
 static void rcu_preempt_read_enter(void)
@@ -355,9 +353,9 @@ static void rcu_preempt_read_enter(void)
 	current->rcu_read_lock_nesting++;
 }
 
-static void rcu_preempt_read_exit(void)
+static int rcu_preempt_read_exit(void)
 {
-	current->rcu_read_lock_nesting--;
+	return --current->rcu_read_lock_nesting;
 }
 
 static void rcu_preempt_depth_set(int val)
@@ -390,21 +388,15 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
-	if (rcu_preempt_depth() != 1) {
-		rcu_preempt_read_exit();
-	} else {
+	if (rcu_preempt_read_exit() == 0) {
 		barrier();  /* critical section before exit code. */
-		rcu_preempt_depth_set(-RCU_NEST_BIAS);
-		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
-		barrier();  /* ->rcu_read_unlock_special load before assign */
-		rcu_preempt_depth_set(0);
 	}
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		int rrln = rcu_preempt_depth();
 
-		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
+		WARN_ON_ONCE(rrln < 0 || rrln > RCU_NEST_PMAX);
 	}
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
@@ -556,7 +548,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
 	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
-	       rcu_preempt_depth() <= 0;
+	       rcu_preempt_depth() == 0;
 }
 
 /*
@@ -692,7 +684,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
-	} else if (!rcu_preempt_depth()) {
+	} else if (!WARN_ON_ONCE(rcu_preempt_depth())) {
 		rcu_qs(); /* Report immediate QS. */
 		return;
 	}
-- 
2.9.5

