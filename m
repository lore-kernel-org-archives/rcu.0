Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D055C4338F
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 17:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341A1600CD
	for <rcu@archiver.kernel.org>; Wed, 28 Jul 2021 17:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhG1RhS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhG1RhR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 13:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1811E60ED4;
        Wed, 28 Jul 2021 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627493836;
        bh=0iMYYV7iDVe7l593Jo/mmoNw+nYiwUH3LIIfvq8gDz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BHWqdDiFhAzRB0QeopSuKhflh6/8cZE17NWJLiNRf29PkvmnLIZctEJ9PHSt8CVb1
         rrpBMbksE+Yx8t9JzvOKguDJUioNmb30BPI18XZZ8FTtoLtyjcYXBKjxCoBK+hy/dn
         yTPKenH9PTvjXpcBhxKJ4gm2Ks0RSQG2iBrcmdK0zeu7wqOA86n782wpwBGra1w+wR
         GQ8zL51iFpv5PTHYc/1t+xc2qDBZgoKsifiN6IMOmRbt2Q8YzNHO9PL8FeIUC8+v8a
         A0qgBXAVBbLjAZQfXgEYoNQjTued0zmrdfLJOJehvlgGeOpwHLjFfsOXctzVPAYkfm
         5B/Wc2WHqPlYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E43945C048D; Wed, 28 Jul 2021 10:37:15 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:37:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721202127.2129660-4-paulmck@kernel.org>
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

Unfortunately, on x86 smp_mb() is as expensive as a cache-local atomic
increment.  This commit therefore weakens only the read from ->dynticks.
However, the updates are abstracted into a rcu_dynticks_inc() function
to ease any future changes that might be needed.

[ paulmck: Apply Linus Torvalds feedback. ]

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 42a0032dd99f7..c87b3a271d65b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -251,6 +251,15 @@ void rcu_softirq_qs(void)
 	rcu_tasks_qs(current, false);
 }
 
+/*
+ * Increment the current CPU's rcu_data structure's ->dynticks field
+ * with ordering.  Return the new value.
+ */
+static noinstr unsigned long rcu_dynticks_inc(int incby)
+{
+	return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
+}
+
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state, that is,
@@ -267,7 +276,7 @@ static noinstr void rcu_dynticks_eqs_enter(void)
 	 * next idle sojourn.
 	 */
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = arch_atomic_inc_return(&this_cpu_ptr(&rcu_data)->dynticks);
+	seq = rcu_dynticks_inc(1);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & 0x1));
 }
@@ -286,7 +295,7 @@ static noinstr void rcu_dynticks_eqs_exit(void)
 	 * and we also must force ordering with the next RCU read-side
 	 * critical section.
 	 */
-	seq = arch_atomic_inc_return(&this_cpu_ptr(&rcu_data)->dynticks);
+	seq = rcu_dynticks_inc(1);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & 0x1));
@@ -308,7 +317,7 @@ static void rcu_dynticks_eqs_online(void)
 
 	if (atomic_read(&rdp->dynticks) & 0x1)
 		return;
-	atomic_inc(&rdp->dynticks);
+	rcu_dynticks_inc(1);
 }
 
 /*
@@ -318,7 +327,7 @@ static void rcu_dynticks_eqs_online(void)
  */
 static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
-	return !(arch_atomic_read(&this_cpu_ptr(&rcu_data)->dynticks) & 0x1);
+	return !(atomic_read(this_cpu_ptr(&rcu_data.dynticks)) & 0x1);
 }
 
 /*
@@ -327,7 +336,8 @@ static __always_inline bool rcu_dynticks_curr_cpu_in_eqs(void)
  */
 static int rcu_dynticks_snap(struct rcu_data *rdp)
 {
-	return atomic_add_return(0, &rdp->dynticks);
+	smp_mb();  // Fundamental RCU ordering guarantee.
+	return atomic_read_acquire(&rdp->dynticks);
 }
 
 /*
@@ -391,12 +401,12 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
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
