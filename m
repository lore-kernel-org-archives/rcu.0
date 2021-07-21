Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A578C6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04F66127C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhGUTkx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C65861248;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=TghcsihZukWaHpQJ99yWIo35il8HtaorB7/BQl73fHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uipZ3yunoLuFAqlK9Sl84HdujieoI0ubOdRE1sPRNtran90OiOcYdn3ueKQCbHQMy
         CG7kMhbr7CgNCHCAI2VyR3a07kMujMZMoPxECMchaL/q+slzs6xjjq7qtbeJqkEoGp
         HHBJtBflemPMg9rN8mE/2+VJijHuxE7CY0IqZOmvV8IdQBUviEAlFz4EvBXQHo3PYt
         l/h7xkzbzetsV0iRwruinBXk1yMM/52lI/Xx4U5RTxhZ2KpGiltbWd6ca2hcv7MYlr
         YRtpS69URLxLqfxNJVPqkhYJ7oGca2OBgHdUNTNbYpQgnhxnCe7yH8Gg/XvC5vy7xL
         2Qe2TBi8xD2Qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1447A5C0A11; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/18] rcu: Remove special bit at the bottom of the ->dynticks counter
Date:   Wed, 21 Jul 2021 13:21:11 -0700
Message-Id: <20210721202127.2129660-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Commit b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks
counter") reserved a bit at the bottom of the ->dynticks counter to defer
flushing of TLBs, but this facility never has been used.  This commit
therefore removes this capability along with the rcu_eqs_special_set()
function used to trigger it.

Link: https://lore.kernel.org/linux-doc/CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com/
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
[ paulmck: Forward-port to v5.13-rc1. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  3 --
 kernel/rcu/tree.c       | 77 ++++++++---------------------------------
 2 files changed, 14 insertions(+), 66 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 953e70fafe383..9be015305f9f9 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -14,9 +14,6 @@
 
 #include <asm/param.h> /* for HZ */
 
-/* Never flag non-existent other CPUs! */
-static inline bool rcu_eqs_special_set(int cpu) { return false; }
-
 unsigned long get_state_synchronize_rcu(void);
 unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51f24ecd94b26..42a0032dd99f7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -74,17 +74,10 @@
 
 /* Data structures. */
 
-/*
- * Steal a bit from the bottom of ->dynticks for idle entry/exit
- * control.  Initially this is for TLB flushing.
- */
-#define RCU_DYNTICK_CTRL_MASK 0x1
-#define RCU_DYNTICK_CTRL_CTR  (RCU_DYNTICK_CTRL_MASK + 1)
-
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+	.dynticks = ATOMIC_INIT(1),
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
 #endif
@@ -266,7 +259,6 @@ void rcu_softirq_qs(void)
  */
 static noinstr void rcu_dynticks_eqs_enter(void)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
 
 	/*
@@ -275,13 +267,9 @@ static noinstr void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	seq = arch_atomic_inc_return(&this_cpu_ptr(&rcu_data)->dynticks);
 	// RCU is no longer watching.  Better be in extended quiescent state!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_CTR));
-	/* Better not have special action (TLB flush) pending! */
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     (seq & RCU_DYNTICK_CTRL_MASK));
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & 0x1));
 }
 
 /*
@@ -291,7 +279,6 @@ static noinstr void rcu_dynticks_eqs_enter(void)
  */
 static noinstr void rcu_dynticks_eqs_exit(void)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
 
 	/*
@@ -299,15 +286,10 @@ static noinstr void rcu_dynticks_eqs_exit(void)
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	seq = arch_atomic_inc_return(&this_cpu_ptr(&rcu_data)->dynticks);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
-		     !(seq & RCU_DYNTICK_CTRL_CTR));
-	if (seq & RCU_DYNTICK_CTRL_MASK) {
-		arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
-		smp_mb__after_atomic(); /* _exit after clearing mask. */
-	}
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & 0x1));
 }
 
 /*
@@ -324,9 +306,9 @@ static void rcu_dynticks_eqs_online(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR)
+	if (atomic_read(&rdp->dynticks) & 0x1)
 		return;
-	atomic_add(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
+	atomic_inc(&rdp->dynticks);
 }
 
 /*
@@ -336,9 +318,7 @@ static void rcu_dynticks_eqs_online(void)
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-
-	return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
+	return !(arch_atomic_read(&this_cpu_ptr(&rcu_data)->dynticks) & 0x1);
 }
 
 /*
@@ -347,9 +327,7 @@ static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
  */
 static int rcu_dynticks_snap(struct rcu_data *rdp)
 {
-	int snap = atomic_add_return(0, &rdp->dynticks);
-
-	return snap & ~RCU_DYNTICK_CTRL_MASK;
+	return atomic_add_return(0, &rdp->dynticks);
 }
 
 /*
@@ -358,7 +336,7 @@ static int rcu_dynticks_snap(struct rcu_data *rdp)
  */
 static bool rcu_dynticks_in_eqs(int snap)
 {
-	return !(snap & RCU_DYNTICK_CTRL_CTR);
+	return !(snap & 0x1);
 }
 
 /* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
@@ -389,8 +367,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = atomic_read(&rdp->dynticks) & ~(RCU_DYNTICK_CTRL_MASK |
-					       RCU_DYNTICK_CTRL_CTR);
+	snap = atomic_read(&rdp->dynticks) & ~0x1;
 
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
@@ -398,32 +375,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	smp_rmb(); // Order *vp read and ->dynticks re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == (atomic_read(&rdp->dynticks) & ~RCU_DYNTICK_CTRL_MASK);
-}
-
-/*
- * Set the special (bottom) bit of the specified CPU so that it
- * will take special action (such as flushing its TLB) on the
- * next exit from an extended quiescent state.  Returns true if
- * the bit was successfully set, or false if the CPU was not in
- * an extended quiescent state.
- */
-bool rcu_eqs_special_set(int cpu)
-{
-	int old;
-	int new;
-	int new_old;
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-
-	new_old = atomic_read(&rdp->dynticks);
-	do {
-		old = new_old;
-		if (old & RCU_DYNTICK_CTRL_CTR)
-			return false;
-		new = old | RCU_DYNTICK_CTRL_MASK;
-		new_old = atomic_cmpxchg(&rdp->dynticks, old, new);
-	} while (new_old != old);
-	return true;
+	return snap == atomic_read(&rdp->dynticks);
 }
 
 /*
@@ -442,10 +394,9 @@ notrace void rcu_momentary_dyntick_idle(void)
 	int special;
 
 	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	special = atomic_add_return(2 * RCU_DYNTICK_CTRL_CTR,
-				    &this_cpu_ptr(&rcu_data)->dynticks);
+	special = atomic_add_return(2, &this_cpu_ptr(&rcu_data)->dynticks);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(special & RCU_DYNTICK_CTRL_CTR));
+	WARN_ON_ONCE(!(special & 0x1));
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
-- 
2.31.1.189.g2e36527f23

