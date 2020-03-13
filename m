Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6D6C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 02:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43E2072F
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584067252;
	bh=M76NEENupVehXA7TGC3d9xvQsRxSR1zMhVkA5XMsdsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vJ2IoFwTppk5LjIngjdMJ4p+EuXzhjAbckVal/xxStPUeZPaEFCXaunqGApE6i6Qt
	 jpPOChjiZknqOlCipdi1JdRQjVBrXg96jGKZZXHaTjwTxIK4e4qAOAnPHB8eBNV/Mi
	 aiO6yIXDQPz3uMkxtXhjzU3qkuLVX/z2ut2zNS4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgCMCkt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbgCMCks (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 22:40:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B95E2073B;
        Fri, 13 Mar 2020 02:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584067248;
        bh=M76NEENupVehXA7TGC3d9xvQsRxSR1zMhVkA5XMsdsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOJlgan3gBFU1jxmFLXVMnQRX1LclFoGfDqBKbBus7JmwhmBDFJKqzFC+9i/RpahC
         1+KxEYfXELrRLOAeraSauiPvnjzAyqtL3/gUx2DXjfbk/Ho6L5tJC9x/Ivz+MXkteb
         RcUQtcVLNigX6yqPJiLZpGvL8PZRXlCgk3CG3nfg=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 2/2] rcu: Add comments marking transitions between RCU watching and not
Date:   Thu, 12 Mar 2020 19:40:46 -0700
Message-Id: <20200313024046.27622-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200313024007.GA27492@paulmck-ThinkPad-P72>
References: <20200313024007.GA27492@paulmck-ThinkPad-P72>
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
index f7d3e48..2f4c91a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -225,7 +225,9 @@ void rcu_softirq_qs(void)
 
 /*
  * Record entry into an extended quiescent state.  This is only to be
- * called when not already in an extended quiescent state.
+ * called when not already in an extended quiescent state, that is,
+ * RCU is watching prior to the call to this function and is no longer
+ * watching upon return.
  */
 static void rcu_dynticks_eqs_enter(void)
 {
@@ -238,7 +240,7 @@ static void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
-	/* Better be in an extended quiescent state! */
+	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     (seq & RCU_DYNTICK_CTRL_CTR));
 	/* Better not have special action (TLB flush) pending! */
@@ -248,7 +250,8 @@ static void rcu_dynticks_eqs_enter(void)
 
 /*
  * Record exit from an extended quiescent state.  This is only to be
- * called from an extended quiescent state.
+ * called from an extended quiescent state, that is, RCU is not watching
+ * prior to the call to this function and is watching upon return.
  */
 static void rcu_dynticks_eqs_exit(void)
 {
@@ -261,6 +264,7 @@ static void rcu_dynticks_eqs_exit(void)
 	 * critical section.
 	 */
 	seq = atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	// RCU is now watching.  Better not be in an extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     !(seq & RCU_DYNTICK_CTRL_CTR));
 	if (seq & RCU_DYNTICK_CTRL_MASK) {
@@ -571,6 +575,7 @@ static void rcu_eqs_enter(bool user)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdp->dynticks_nesting == 0);
 	if (rdp->dynticks_nesting != 1) {
+		// RCU will still be watching, so just do accounting and leave.
 		rdp->dynticks_nesting--;
 		return;
 	}
@@ -583,7 +588,9 @@ static void rcu_eqs_enter(bool user)
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
+	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
 	rcu_dynticks_task_enter();
 }
 
@@ -663,7 +670,9 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
 	if (irq)
 		rcu_prepare_for_idle();
 
+	// RCU is watching here ...
 	rcu_dynticks_eqs_enter();
+	// ... but is no longer watching here.
 
 	if (irq)
 		rcu_dynticks_task_enter();
@@ -738,11 +747,14 @@ static void rcu_eqs_exit(bool user)
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
@@ -819,7 +831,9 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		if (irq)
 			rcu_dynticks_task_exit();
 
+		// RCU is not watching here ...
 		rcu_dynticks_eqs_exit();
+		// ... but is watching here.
 
 		if (irq)
 			rcu_cleanup_after_idle();
@@ -829,9 +843,16 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
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

