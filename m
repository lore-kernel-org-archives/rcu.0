Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519A3C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D20C20801
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581981998;
	bh=SUHUIqPehpsKC2p2nm1j8n3CMYFBYTGDwlnziZP/idM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nBRfRVUvnoZGUnyce/EFt0BUQDnsNjvF/lfqZ0WJvLbfAjKjWiJw9xcG7kdvFL6o9
	 gnkxo+9NeOyaXClzi/sV8KA0lPmuOj0czW6EwZSIXBweMZXnL6BARhlmvGMfDPM4ts
	 D73CJnrcXvAQ5fwIH7y8FIoYRvjKRHlpyNBl/Wos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgBQX0h (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgBQX0h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 18:26:37 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241BB207FD;
        Mon, 17 Feb 2020 23:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581981996;
        bh=SUHUIqPehpsKC2p2nm1j8n3CMYFBYTGDwlnziZP/idM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nWEkPg92zKH1GOOt7LNxCJgqbfPStO4sfhRxOozAlbzQI3dmbDTc3/+GeAJgWWrml
         QmmD4I6B+BvG4ikCZd+VxgA1qaC6dVjX/974S0ou+Rw0PtxUDIeuHyRF12L3ZLGdZU
         cXonvaQtYH5A5PHHMYCMRqawd4H/LEEFgZ5UXp94=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F37DD35227A8; Mon, 17 Feb 2020 15:26:35 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:26:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH V2 4/7] rcu: don't use negative ->rcu_read_lock_nesting
Message-ID: <20200217232635.GC17570@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-5-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102124559.1135-5-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Nov 02, 2019 at 12:45:56PM +0000, Lai Jiangshan wrote:
> Negative ->rcu_read_lock_nesting was introduced to prevent
> scheduler deadlock. But now with the help of deferred qs
> mechanism, we can defer qs rather than persevere in reporting qs
> and deadlock. So negative ->rcu_read_lock_nesting is useless now
> and rcu_read_unlock() can be simplified.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

I have queued this for further review and testing, thank you!

There were a few adjustments, so please see the updated patch below.

							Thanx, Paul

------------------------------------------------------------------------

commit 756b5aea6df6d769a346d4b55cc66707b2d607a9
Author: Lai Jiangshan <laijs@linux.alibaba.com>
Date:   Sat Feb 15 15:23:26 2020 -0800

    rcu: Don't use negative nesting depth in __rcu_read_unlock()
    
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

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index c2b04da..72952ed 100644
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
index be3d100..571b7c9 100644
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
