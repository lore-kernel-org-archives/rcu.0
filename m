Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0013148D2;
	Sat, 19 Sep 2026 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777982; cv=none; b=WLtmhGEwUR4zzsWXydh53Aj7RT+xrMa3e6rmqyIyFvDzhmv7mrdsmBhLDHyYGfP5X6z66mHD8cBHcRUbhxu7elS7maD8i5c1ovWwuARPkQn3CIXV6l5YhbB+UuDYNSoNoArFhNvpV8gdG+wzk0qkvT6M/rEv3V/SnC/nfR0/UvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777982; c=relaxed/simple;
	bh=lYWG9ZshybR5nuwNUqVzzgzYOMmBGYT0b9UucNsGtEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu1eB4z+6jFcEwfVxmO2uPMdzCWBba3epmNzPFF3IrU7P3FczGmByWVvFlvEWSWpXwBcPLJyVo0q+m7eLFcraxAnQYDY/1G2azMhIpuPfizAqQBLu79jLFLdQRGv1NtAYQXD43Nrl7Hyg0V32uZFJklfIOazUZd9s5sHEB28VjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PERz4/Xv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PERz4/Xv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DB01F00899;
	Sat, 19 Sep 2026 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777979;
	bh=GTifvghG5iJtZNN3OfY+ucsIXy4d8ABmqfhLH54yQjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PERz4/XvlY2UXFMzwVK1y/0hBzvjsJrM0h+DXEh3u8ySezc8rlOPTGi3lG5YwnJ+C
	 RSRoyDzULzHunATYPjnwmuCAyGTTT2+CANq6rYe+W/aV612cbgERww74O/MEYmO/6h
	 y93qXlkEtaWkpv2Bud8ot4JTGS3M7UB1IJeDWAiw/2zkPeawWNeNnUMedx4IAPLNZl
	 Pnv0V3asuf9Y87aTl7moosTBBYNqrjUMA8/c+95FrwMeRXHGicOB1LpBkbwOWaSud6
	 DmY+IVVEbVdQut3o6NivIXeoMeSGPO3Ha/rjB+oYtWu+WqAuNz91hj25d7J+T2//23
	 y4nqve2nCq6+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97776CE17BD; Fri, 18 Sep 2026 17:32:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/7] srcu: Make call_srcu() safe to call from any context
Date: Fri, 18 Sep 2026 17:32:54 -0700
Message-Id: <20260919003258.3134343-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
References: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

call_srcu() has the same constraint as call_rcu():
srcu_gp_start_if_needed() enqueues under raw_spin_lock_irqsave() and may
walk the srcu_node tree, as do callback invocation and grace-period work,
so a call_srcu() with interrupts already disabled can race an operation in
flight on this CPU.  call_rcu_tasks_trace() is call_srcu() under the hood,
so a sleepable BPF program freeing an object can reach this.

Defer as call_rcu() does: stage the callback on the srcu_data's
->defer_cbs, chain that srcu_data onto a per-CPU list, and raise a per-CPU
irq_work that re-issues it straight to the enqueue helper, never back
through __call_srcu().  The irqs-enabled path is unchanged; as for
call_rcu() the gate is bare irqs_disabled(), so callers that merely hold
interrupts off are deferred too and pay one irq_work hop, including
call_rcu_tasks_trace() from the BPF memalloc irq_work.

The irq_work is per-CPU rather than per-srcu_struct and statically
initialized, so deferral never runs check_init_srcu_struct(); it is
IRQ_WORK_INIT_HARD as for call_rcu().  srcu_barrier() flushes it first, and
rcutree_migrate_callbacks() calls srcu_offline_drain() for an outgoing CPU.
cleanup_srcu_struct() drains before its "just leak it" early returns, and
srcu_module_going() before freeing any ->sda, since a staged srcu_data left
chained on a per-CPU list would dangle.  Staging is two steps, the callback
onto
->defer_cbs and then the srcu_data onto the per-CPU list, so a flusher can
find the per-CPU list empty while a callback whose call_srcu() has not
returned sits on ->defer_cbs; the staging CPU's own irq_work takes that
one.

The per-CPU srcu_defer ->lock, not any srcu_data's, is held with interrupts
off across the whole nested drain: the chain of srcu_datas staged on that
CPU and, for each, its callbacks, with srcu_do_enqueue() taking that
srcu_data's ->lock and possibly starting a grace period for every one.
That is what serializes the drainers.  The bound is as for call_rcu(): what
one interrupts-disabled region could stage, normally a single callback, or
whatever accumulates before the tick where arch_irq_work_has_interrupt() is
false.  Both lists are drained newest-first; nothing depends on call_srcu()
ordering.

The drain clears ->next before re-issuing, which bounds a node self-linked
by a double call_srcu(); a longer cycle is not bounded, and a double
call_srcu() stays undefined, as for call_rcu().

A callback deferred past the CPUHP_AP_SMPCFD_DYING irq_work flush leaves
that CPU's srcu_defer ->iw claimed with its self-IPI lost, as for
call_rcu().  srcu_offline_drain() still re-issues the callback, but the
irq_work cannot be un-queued, and here the claim is shared by every
srcu_struct on the CPU.

As in call_rcu(), the re-issue runs with interrupts disabled and can be
re-entered by instrumentation, so a per-CPU flag, set only while that CPU
is inside its own irq_work drain, drops a deferring call_srcu() seen
mid-drain unless it comes from an NMI.  Such a drop can strand state the
caller associated with the callback, not just the callback itself.

Staging records only the callback, so a deferred expedited call_srcu()
completes as a normal grace period.  Only srcu_expedite_current() can hit
that, and only when invoked with interrupts already disabled.

Gated by CONFIG_RCU_DEFER, though the srcu_data members and the per-CPU
srcu_defer are unconditional.  Under CONFIG_PROVE_RCU, warn if the direct
path is reached from an NMI.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |   4 +
 kernel/rcu/rcu.h         |   3 +
 kernel/rcu/srcutree.c    | 170 ++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.c        |   2 +
 4 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 75e54e4f963f..1ce759fb7094 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -13,6 +13,8 @@
 
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
+#include <linux/irq_work_types.h>
+#include <linux/llist.h>
 
 struct srcu_node;
 struct srcu_struct;
@@ -41,6 +43,8 @@ struct srcu_data {
 	bool srcu_cblist_invoking;		/* Invoking these CBs? */
 	struct timer_list delay_work;		/* Delay for CB invoking */
 	struct work_struct work;		/* Context for CB invoking. */
+	struct llist_head defer_cbs;		/* Callbacks deferred on re-entry. */
+	struct llist_node defer_link;		/* Links onto the per-CPU deferral drain list */
 	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
 	struct rcu_head srcu_ec_head;		/* For srcu_expedite_current() use. */
 	int srcu_ec_state;			/*  State for srcu_expedite_current(). */
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 91e33571a554..d60444bf3a02 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -583,6 +583,9 @@ static inline bool should_rcu_defer(void)
 	       rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
 }
 
+/* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrate_callbacks(). */
+void srcu_offline_drain(int cpu);
+
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ed204b3f4b84..d32c374ee72a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/irq_work.h>
+#include <linux/llist.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
@@ -79,6 +80,38 @@ static void process_srcu(struct work_struct *work);
 static void srcu_irq_work(struct irq_work *work);
 static void srcu_delay_timer(struct timer_list *t);
 
+struct srcu_defer;
+static void srcu_defer_drain(struct irq_work *iw);
+static void __srcu_defer_drain(struct srcu_defer *sndp);
+
+/*
+ * Per-CPU call_srcu() deferral state, shared by every srcu_struct.  A deferred
+ * callback is staged on its srcu_data's ->defer_cbs; that srcu_data is chained
+ * via ->defer_link onto ->list, which the irq_work walks.
+ */
+struct srcu_defer {
+	struct llist_head	list;
+	struct irq_work		iw;
+	raw_spinlock_t		lock;
+	bool			draining;
+};
+
+static DEFINE_PER_CPU(struct srcu_defer, srcu_defer) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(srcu_defer.lock),
+	.iw = IRQ_WORK_INIT_HARD(srcu_defer_drain),
+};
+
+/*
+ * Flush pending deferred callbacks so a following srcu_barrier() waits for them.
+ */
+static void srcu_defer_flush(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		__srcu_defer_drain(&per_cpu(srcu_defer, cpu));
+}
+
 /*
  * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
@@ -107,6 +140,11 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 		sdp->cpu = cpu;
 		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
+		/*
+		 * ->defer_cbs and ->defer_link are valid when zeroed and are not
+		 * reinitialized here: that would clobber callbacks a reentrant
+		 * call_srcu() already staged.  See __call_srcu().
+		 */
 		sdp->ssp = ssp;
 	}
 }
@@ -688,6 +726,14 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	unsigned long delay;
 	struct srcu_usage *sup = ssp->srcu_sup;
 
+	/*
+	 * Drain before the early returns below: they leak the srcu_struct, but
+	 * srcu_module_going() frees ->sda regardless, and a staged srcu_data
+	 * left chained on a per-CPU list would then dangle.  Draining first also
+	 * has to precede the ->irq_work sync, since re-issuing a callback can
+	 * start a grace period and re-queue ->irq_work, which schedules ->work.
+	 */
+	srcu_defer_flush();
 	raw_spin_lock_irq_rcu_node(ssp->srcu_sup);
 	delay = srcu_get_delay(ssp);
 	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
@@ -695,7 +741,6 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
-	/* Wait for irq_work to finish first as it may queue a new work. */
 	irq_work_sync(&sup->irq_work);
 	flush_delayed_work(&sup->work);
 	for_each_possible_cpu(cpu) {
@@ -1411,8 +1456,8 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
  * srcu_read_lock(), and srcu_read_unlock() that are all passed the same
  * srcu_struct structure.
  */
-static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
-			rcu_callback_t func, bool do_norm)
+static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
+			    rcu_callback_t func, bool do_norm)
 {
 	if (debug_rcu_head_queue(rhp)) {
 		/* Probable double call_srcu(), so leak the callback. */
@@ -1424,6 +1469,108 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
 
+/*
+ * The srcu_cblist and srcu_node tree are only accessed with interrupts
+ * disabled, so defer when interrupts are already off rather than enqueue into
+ * an operation that may be in flight on this CPU.
+ */
+static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
+			rcu_callback_t func, bool do_norm)
+{
+	if (should_rcu_defer()) {
+		struct srcu_defer *sndp = this_cpu_ptr(&srcu_defer);
+		struct srcu_data *sdp;
+
+		/*
+		 * Instrumentation on the enqueue path can re-enter here from
+		 * inside the drain.  Re-queuing would livelock it, so drop the
+		 * callback; an NMI cannot loop, so let it through.
+		 */
+		if (READ_ONCE(sndp->draining) && !in_nmi()) {
+			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
+				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			return;
+		}
+		sdp = this_cpu_ptr(ssp->sda);
+		rhp->func = func;
+		if (llist_add((struct llist_node *)rhp, &sdp->defer_cbs)) {
+			/*
+			 * Chain this srcu_data for the drain.  ->ssp must be
+			 * published here: deferral skips
+			 * check_init_srcu_struct(), so on a never-initialized
+			 * static srcu_struct the srcu_data are still zeroed and
+			 * the drain would read a NULL ->ssp.
+			 */
+			sdp->ssp = ssp;
+			if (llist_add(&sdp->defer_link, &sndp->list))
+				irq_work_queue(&sndp->iw);
+		}
+		return;
+	}
+
+	/*
+	 * Only reachable from an NMI when deferral is off: before the scheduler
+	 * is up, or with CONFIG_RCU_DEFER=n.  The enqueue can then race.
+	 */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+
+	srcu_do_enqueue(ssp, rhp, func, do_norm);
+}
+
+/*
+ * Re-issue deferred callbacks straight to srcu_do_enqueue() so they cannot defer
+ * again.  ->lock serializes the drainers: the irq_work, srcu_defer_flush() and
+ * srcu_offline_drain().
+ */
+static void __srcu_defer_drain(struct srcu_defer *sndp)
+{
+	struct llist_node *snode, *snext;
+	unsigned long flags;
+
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	raw_spin_lock_irqsave(&sndp->lock, flags);
+	llist_for_each_safe(snode, snext, llist_del_all(&sndp->list)) {
+		struct srcu_data *sdp = container_of(snode, struct srcu_data, defer_link);
+		struct srcu_struct *ssp = sdp->ssp;
+		struct llist_node *cnode, *cnext;
+
+		cnode = llist_del_all(&sdp->defer_cbs);
+		llist_for_each_safe(cnode, cnext, cnode) {
+			struct rcu_head *rhp = (struct rcu_head *)cnode;
+
+			/* Bounds a node self-linked by a double call_srcu(). */
+			rhp->next = NULL;
+			srcu_do_enqueue(ssp, rhp, rhp->func, true);
+		}
+	}
+	raw_spin_unlock_irqrestore(&sndp->lock, flags);
+}
+
+/*
+ * Only the irq_work drain can be re-fed by its own re-issue, so only it sets
+ * ->draining.  A direct drain re-issues onto this CPU, and anything staged
+ * during it is picked up by that CPU's own irq_work.
+ */
+static void srcu_defer_drain(struct irq_work *iw)
+{
+	struct srcu_defer *sndp = container_of(iw, struct srcu_defer, iw);
+
+	WRITE_ONCE(sndp->draining, true);
+	__srcu_defer_drain(sndp);
+	WRITE_ONCE(sndp->draining, false);
+}
+
+/*
+ * Drain @cpu's deferred call_srcu() callbacks once @cpu is dead.  One pass
+ * covers every srcu_struct; the re-issue lands on the current CPU.
+ */
+void srcu_offline_drain(int cpu)
+{
+	__srcu_defer_drain(&per_cpu(srcu_defer, cpu));
+}
+
 /**
  * call_srcu() - Queue a callback for invocation after an SRCU grace period
  * @ssp: srcu_struct in queue the callback
@@ -1678,9 +1825,18 @@ void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
 	int idx;
-	unsigned long s = rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
+	unsigned long s;
 
 	check_init_srcu_struct(ssp);
+
+	/*
+	 * Register any deferred callbacks before snapshotting the sequence.  The
+	 * staging list is per-CPU, not per-srcu_struct, so this also drains
+	 * other srcu_structs'.
+	 */
+	srcu_defer_flush();
+
+	s = rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
 	mutex_lock(&ssp->srcu_sup->srcu_barrier_mutex);
 	if (rcu_seq_done(&ssp->srcu_sup->srcu_barrier_seq, s)) {
 		smp_mb(); /* Force ordering following return. */
@@ -2135,6 +2291,12 @@ static void srcu_module_going(struct module *mod)
 	struct srcu_struct *ssp;
 	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
 
+	/*
+	 * Deferral skips check_init_srcu_struct(), so cleanup_srcu_struct()
+	 * below can be skipped for an srcu_struct that has staged callbacks.
+	 * Drain them before any ->sda is freed.
+	 */
+	srcu_defer_flush();
 	for (i = 0; i < mod->num_srcu_structs; i++) {
 		ssp = *(sspp++);
 		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ff9a2395c9e8..e363e1a6a33c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4636,6 +4636,8 @@ void rcutree_migrate_callbacks(int cpu)
 	 * cover.  Drain them here, before the early returns.
 	 */
 	__rcu_defer_drain(rdp);
+	/* Likewise for the outgoing CPU's deferred call_srcu() callbacks. */
+	srcu_offline_drain(cpu);
 
 	if (rcu_rdp_is_offloaded(rdp))
 		return;
-- 
2.40.1

