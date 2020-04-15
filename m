Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F545C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5797E2076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974993;
	bh=WX3rvK+KLjoJ4P6nj6Msiv1bQF5K85x4Dor+mT2zmIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ts9vHa0HOCMemij09DPF/LAQf+MB6sZYvx7RV9+zO8ZGhcH+OYVCwVzdwGzKf8i2s
	 ti++ed28pET8HLBrKD/fIHj0JvxdAzcoaAekYWL8qc4pGTObcJ5lU1LZySLfF6nhru
	 NQUOpUZcZSLOohH3tx8H5TFoJw2+A7z42htCBJFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441096AbgDOSTq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436610AbgDOSTp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 826BF20771;
        Wed, 15 Apr 2020 18:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974783;
        bh=WX3rvK+KLjoJ4P6nj6Msiv1bQF5K85x4Dor+mT2zmIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vza0tVvLxzjXJDxYh+WJDdtWoKWdKjH/k6qGPBSZZl7mfkBuvr9b6Wz+XQHBGs3cH
         tHqfuDXacGNV8vWprT8hcGJ1hIb5QBYJGTbhgDbxm9viJDfdLDgTrFo2yvLdugDxMt
         JhYZD3IHYS4vZ0gHYNeiEvGge81GtCbpnXDFbdoE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 01/38] rcu: Add comments marking transitions between RCU watching and not
Date:   Wed, 15 Apr 2020 11:19:04 -0700
Message-Id: <20200415181941.11653-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

It is not as clear as it might be just where in RCU's idle entry/exit
code RCU stops and starts watching the current CPU.  This commit therefore
adds comments calling out the transitions.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f13130a..e54a8a1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -238,7 +238,9 @@ void rcu_softirq_qs(void)
 
 /*
  * Record entry into an extended quiescent state.  This is only to be
- * called when not already in an extended quiescent state.
+ * called when not already in an extended quiescent state, that is,
+ * RCU is watching prior to the call to this function and is no longer
+ * watching upon return.
  */
 static void rcu_dynticks_eqs_enter(void)
 {
@@ -251,7 +253,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	/* Better be in an extended quiescent state! */
+	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     (seq & RCU_DYNTICK_CTRL_CTR));
 	/* Better not have special action (TLB flush) pending! */
@@ -261,7 +263,8 @@ static void rcu_dynticks_eqs_enter(void)
 
 /*
  * Record exit from an extended quiescent state.  This is only to be
- * called from an extended quiescent state.
+ * called from an extended quiescent state, that is, RCU is not watching
+ * prior to the call to this function and is watching upon return.
  */
 static void rcu_dynticks_eqs_exit(void)
 {
@@ -274,6 +277,7 @@ static void rcu_dynticks_eqs_exit(void)
 	 * critical section.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	// RCU is now watching.  Better not be in an extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
@@ -584,6 +588,7 @@ static void rcu_eqs_enter(bool user)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
 	if (rdp->dynticks_nesting != 1) {
+		// RCU will still be watching, so just do accounting and leave.
 		rdp->dynticks_nesting--;
 		return;
 	}
@@ -596,7 +601,9 @@ static void rcu_eqs_enter(bool user)
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
 	rcu_dynticks_task_enter();
 }
 
@@ -676,7 +683,9 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	if (irq)
 		rcu_prepare_for_idle();
 
+	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
 
 	if (irq)
 		rcu_dynticks_task_enter();
@@ -751,11 +760,14 @@ static void rcu_eqs_exit(bool user)
 	oldval = rdp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
+		// RCU was already watching, so just do accounting and leave.
 		rdp->dynticks_nesting++;
 		return;
 	}
 	rcu_dynticks_task_exit();
+	// RCU is not watching here ...
 	rcu_dynticks_eqs_exit();
+	// ... but is watching here.
 	rcu_cleanup_after_idle();
 	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
@@ -832,7 +844,9 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		if (irq)
 			rcu_dynticks_task_exit();
 
+		// RCU is not watching here ...
 		rcu_dynticks_eqs_exit();
+		// ... but is watching here.
 
 		if (irq)
 			rcu_cleanup_after_idle();
@@ -842,9 +856,16 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
 		   READ_ONCE(rdp->rcu_urgent_qs) &&
 		   !READ_ONCE(rdp->rcu_forced_tick)) {
+		// We get here only if we had already exited the extended
+		// quiescent state and this was an interrupt (not an NMI).
+		// Therefore, (1) RCU is already watching and (2) The fact
+		// that we are in an interrupt handler and that the rcu_node
+		// lock is an irq-disabled lock prevents self-deadlock.
+		// So we can safely recheck under the lock.
 		raw_spin_lock_rcu_node(rdp->mynode);
-		// Recheck under lock.
 		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+			// A nohz_full CPU is in the kernel and RCU
+			// needs a quiescent state.  Turn on the tick!
 			WRITE_ONCE(rdp->rcu_forced_tick, true);
 			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		}
-- 
2.9.5

