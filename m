Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE8C6377E
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A013C61244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbhGUTky (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236260AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6161B61241;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=1snRh7a0OTp2q6YEi9BnD4DFtqvPotg2NZF7daUlPfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDUE4rOEsIPXjMWR1/0ZMDI9+kbyD0M6VKNYNbPQ1iRgkPa52yzlAwcy37MmrD+Km
         EuwBeyVYHkyvzj1zSkzNo2fLAT/TXPC6LAdI9Pb9k5YCXcBUNonvX0IQC+lvKLdrQN
         232tpFST+fV9BvAXY/3B422/xkxQouYoqXRvZF+q1CsArGDmewGXIqmX2r8VW0PQ6U
         KeEuoYPxlKfHYRHSJu5GbrniLykQy3/yGE+W2n3f/1YorHWDrG5+8ZbHXfavsiNl3m
         0Lw7/5ToKY38FkSsO7tRj7JCF/trC+/rAADIqC3PCvwD8682KDJQySUc8kfxO+Rwfx
         JM7KOig6PeDeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 178475C0A2D; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Date:   Wed, 21 Jul 2021 13:21:12 -0700
Message-Id: <20210721202127.2129660-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Accesses to the rcu_data structure's ->dynticks field have always been
fully ordered because it was not possible to prove that weaker ordering
was safe.  However, with the removal of the rcu_eqs_special_set() function
and the advent of the Linux-kernel memory model, it is now easy to show
that two of the four original full memory barriers can be weakened to
acquire and release operations.  The remaining pair must remain full
memory barriers.  This change makes the memory ordering requirements
more evident, and it might well also speed up the to-idle and from-idle
fastpaths on some architectures.

The following litmus test, adapted from one supplied off-list by Frederic
Weisbecker, models the RCU grace-period kthread detecting an idle CPU
that is concurrently transitioning to non-idle:

	C dynticks-from-idle

	{
		DYNTICKS=0; (* Initially idle. *)
	}

	P0(int *X, int *DYNTICKS)
	{
		int dynticks;
		int x;

		// Idle.
		dynticks = READ_ONCE(*DYNTICKS);
		smp_store_release(DYNTICKS, dynticks + 1);
		smp_mb();
		// Now non-idle
		x = READ_ONCE(*X);
	}

	P1(int *X, int *DYNTICKS)
	{
		int dynticks;

		WRITE_ONCE(*X, 1);
		smp_mb();
		dynticks = smp_load_acquire(DYNTICKS);
	}

	exists (1:dynticks=0 /\ 0:x=1)

Running "herd7 -conf linux-kernel.cfg dynticks-from-idle.litmus" verifies
this transition, namely, showing that if the RCU grace-period kthread (P1)
sees another CPU as idle (P0), then any memory access prior to the start
of the grace period (P1's write to X) will be seen by any RCU read-side
critical section following the to-non-idle transition (P0's read from X).
This is a straightforward use of full memory barriers to force ordering
in a store-buffering (SB) litmus test.

The following litmus test, also adapted from the one supplied off-list
by Frederic Weisbecker, models the RCU grace-period kthread detecting
a non-idle CPU that is concurrently transitioning to idle:

	C dynticks-into-idle

	{
		DYNTICKS=1; (* Initially non-idle. *)
	}

	P0(int *X, int *DYNTICKS)
	{
		int dynticks;

		// Non-idle.
		WRITE_ONCE(*X, 1);
		dynticks = READ_ONCE(*DYNTICKS);
		smp_store_release(DYNTICKS, dynticks + 1);
		smp_mb();
		// Now idle.
	}

	P1(int *X, int *DYNTICKS)
	{
		int x;
		int dynticks;

		smp_mb();
		dynticks = smp_load_acquire(DYNTICKS);
		x = READ_ONCE(*X);
	}

	exists (1:dynticks=2 /\ 1:x=0)

Running "herd7 -conf linux-kernel.cfg dynticks-into-idle.litmus" verifies
this transition, namely, showing that if the RCU grace-period kthread
(P1) sees another CPU as newly idle (P0), then any pre-idle memory access
(P0's write to X) will be seen by any code following the grace period
(P1's read from X).  This is a simple release-acquire pair forcing
ordering in a message-passing (MP) litmus test.

Of course, if the grace-period kthread detects the CPU as non-idle,
it will refrain from reporting a quiescent state on behalf of that CPU,
so there are no ordering requirements from the grace-period kthread in
that case.  However, other subsystems call rcu_is_idle_cpu() to check
for CPUs being non-idle from an RCU perspective.  That case is also
verified by the above litmus tests with the proviso that the sense of
the low-order bit of the DYNTICKS counter be inverted.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 50 +++++++++++++++++++++++++++++++----------------
 kernel/rcu/tree.h |  2 +-
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 42a0032dd99f7..bc6ccf0ba3b24 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -77,7 +77,7 @@
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
-	.dynticks = ATOMIC_INIT(1),
+	.dynticks = 1UL,
 #ifdef CONFIG_RCU_NOCB_CPU
 	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
 #endif
@@ -251,6 +251,21 @@ void rcu_softirq_qs(void)
 	rcu_tasks_qs(current, false);
 }
 
+/*
+ * Increment the current CPU's rcu_data structure's ->dynticks field
+ * with ordering.  Return the new value.
+ */
+static noinstr unsigned long rcu_dynticks_inc(int incby)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+	int seq;
+	
+	seq = READ_ONCE(rdp->dynticks) + incby;
+	smp_store_release(&rdp->dynticks, seq);
+	smp_mb();  // Fundamental RCU ordering guarantee.
+	return seq;
+}
+
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state, that is,
@@ -267,7 +282,7 @@ static noinstr void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = arch_atomic_inc_return(&this_cpu_ptr(&rcu_data)->dynticks);
+	seq = rcu_dynticks_inc(1);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & 0x1));
 }
@@ -286,7 +301,7 @@ static noinstr void rcu_dynticks_eqs_exit(void)
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = arch_atomic_inc_return(&this_cpu_ptr(&rcu_data)->dynticks);
+	seq = rcu_dynticks_inc(1);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & 0x1));
@@ -306,9 +321,9 @@ static void rcu_dynticks_eqs_online(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (atomic_read(&rdp->dynticks) & 0x1)
+	if (READ_ONCE(rdp->dynticks) & 0x1)
 		return;
-	atomic_inc(&rdp->dynticks);
+	rcu_dynticks_inc(1);
 }
 
 /*
@@ -318,7 +333,7 @@ static void rcu_dynticks_eqs_online(void)
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(arch_atomic_read(&this_cpu_ptr(&rcu_data)->dynticks) & 0x1);
+	return !(READ_ONCE(this_cpu_ptr(&rcu_data)->dynticks) & 0x1);
 }
 
 /*
@@ -327,7 +342,8 @@ static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
  */
 static int rcu_dynticks_snap(struct rcu_data *rdp)
 {
-	return atomic_add_return(0, &rdp->dynticks);
+	smp_mb();  // Fundamental RCU ordering guarantee.
+	return smp_load_acquire(&rdp->dynticks);
 }
 
 /*
@@ -367,7 +383,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	int snap;
 
 	// If not quiescent, force back to earlier extended quiescent state.
-	snap = atomic_read(&rdp->dynticks) & ~0x1;
+	snap = READ_ONCE(rdp->dynticks) & ~0x1;
 
 	smp_rmb(); // Order ->dynticks and *vp reads.
 	if (READ_ONCE(*vp))
@@ -375,7 +391,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
 	smp_rmb(); // Order *vp read and ->dynticks re-read.
 
 	// If still in the same extended quiescent state, we are good!
-	return snap == atomic_read(&rdp->dynticks);
+	return snap == READ_ONCE(rdp->dynticks);
 }
 
 /*
@@ -391,12 +407,12 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
  */
 notrace void rcu_momentary_dyntick_idle(void)
 {
-	int special;
+	int seq;
 
 	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
-	special = atomic_add_return(2, &this_cpu_ptr(&rcu_data)->dynticks);
+	seq = rcu_dynticks_inc(2);
 	/* It is illegal to call this from idle state. */
-	WARN_ON_ONCE(!(special & 0x1));
+	WARN_ON_ONCE(!(seq & 0x1));
 	rcu_preempt_deferred_qs(current);
 }
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
@@ -612,7 +628,7 @@ static noinstr void rcu_eqs_enter(bool user)
 
 	lockdep_assert_irqs_disabled();
 	instrumentation_begin();
-	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, READ_ONCE(rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
@@ -747,7 +763,7 @@ noinstr void rcu_nmi_exit(void)
 	 */
 	if (rdp->dynticks_nmi_nesting != 1) {
 		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
-				  atomic_read(&rdp->dynticks));
+				  READ_ONCE(rdp->dynticks));
 		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
 			   rdp->dynticks_nmi_nesting - 2);
 		instrumentation_end();
@@ -755,7 +771,7 @@ noinstr void rcu_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, READ_ONCE(rdp->dynticks));
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
 
 	if (!in_nmi())
@@ -863,7 +879,7 @@ static void noinstr rcu_eqs_exit(bool user)
 	instrument_atomic_write(&rdp->dynticks, sizeof(rdp->dynticks));
 
 	rcu_cleanup_after_idle();
-	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&rdp->dynticks));
+	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, READ_ONCE(rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdp->dynticks_nesting, 1);
 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
@@ -1026,7 +1042,7 @@ noinstr void rcu_nmi_enter(void)
 
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
 			  rdp->dynticks_nmi_nesting,
-			  rdp->dynticks_nmi_nesting + incby, atomic_read(&rdp->dynticks));
+			  rdp->dynticks_nmi_nesting + incby, READ_ONCE(rdp->dynticks));
 	instrumentation_end();
 	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
 		   rdp->dynticks_nmi_nesting + incby);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb4086..ce611da2ff6b3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -184,7 +184,7 @@ struct rcu_data {
 	int dynticks_snap;		/* Per-GP tracking for dynticks. */
 	long dynticks_nesting;		/* Track process nesting level. */
 	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
-	atomic_t dynticks;		/* Even value for idle, else odd. */
+	unsigned long dynticks;		/* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 	bool rcu_forced_tick;		/* Forced tick to provide QS. */
-- 
2.31.1.189.g2e36527f23

