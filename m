Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2218469828;
	Wed,  5 Aug 2026 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932650; cv=none; b=ROYqllprjxwCdGd0zN3P4pTIfAIA2guZRDJ+jrdari0RbB4hyPKGpVgTME+5Qh4f03sa9q5HRCHVCoQ60McvfRiUrfgIZdzX51kTEWr9/MFx49FM0uai9PcmwcMlAPN8hDJqA1N2xDJFyPdM3bzljZrkAIySV4xMzlhb9S9oFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932650; c=relaxed/simple;
	bh=2HzwJqqykpeRV+fRENdx3Rl435thQUPWJjcF5t8VHQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZENupGhmUvXRnqt3cl2OdkmMOL5KAjHTCLlv6ShqCS9FyxevUosnMYDwmFiqppyJTcfLZIXQkzRulpZVatigmMEUcj54En0p/VmOS+8avxW7aB3HINSNQzWijxrZWPXCSeUINeBHntk7mMiV0suM2O+DKAhkgWBTF1Y5iygFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5VdbbW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5VdbbW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3371F00A3A;
	Wed,  5 Aug 2026 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932648;
	bh=Zuf9N90kRGuzCtffHw96HWj2lxYV2drR4iLhb0zurcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g5VdbbW2QAlQPVDqvZngUXIhSinQCYtAw3H8tKMGcfoLiM5gDtq27681M7i2fbFVq
	 QnSRv7vrJ2xzpvvpGLMKuqs+WcHNKraJhJv+LQdrYEmDJVLMGC5/rTTAiWB6IzjHvA
	 QdMgjptztOJTJ9b0JaLtYWL55nZwkaJS6UOsnMkDXCFsud/94rndMZW9+gyrh45i/S
	 cp+i0Or7EA2KZ7V/MP7yxuGxQRb3osvwAAsSiNIANBKOi6LRI46sT+NfFg7/gRQUis
	 aouXQUsmgR8NiC1HE8+mdtnUwK5jMp7HHTrHuKylwxIe+M1VRJougTBb6n7mrfbcGi
	 cm52NRdVQY0nw==
From: Puranjay Mohan <puranjay@kernel.org>
To: "Lai Jiangshan" <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Josh Triplett" <josh@joshtriplett.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	"Frederic Weisbecker" <frederic@kernel.org>,
	"Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
	"Joel Fernandes" <joelagnelf@nvidia.com>,
	"Boqun Feng" <boqun@kernel.org>,
	"Uladzislau Rezki" <urezki@gmail.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v3 3/6] srcu: Make call_srcu() safe to call from any context
Date: Wed,  5 Aug 2026 05:23:40 -0700
Message-ID: <20260805122346.269445-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805122346.269445-1-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

call_srcu() has the same constraint as call_rcu(): its callback list and
locks are only touched with interrupts disabled.  srcu_gp_start_if_needed()
enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree, as
do callback invocation and grace-period work.  A call_srcu() with
interrupts disabled can race a list operation in flight on this CPU and
corrupt the list or deadlock.  call_rcu_tasks_trace() is call_srcu() under
the hood, so a sleepable BPF program freeing an object can reach this.

Defer as call_rcu() does: stage the callback on the srcu_data's
->defer_cbs, chain that srcu_data onto a per-CPU list, and raise a per-CPU
irq_work that re-issues it straight to the enqueue helper, never back
through __call_srcu().  The common path is unchanged and keeps interrupts
enabled across srcu_gp_start_if_needed().

The irq_work is per-CPU rather than per-srcu_struct and statically
initialized, so deferral never runs check_init_srcu_struct(); it is
IRQ_WORK_INIT_HARD as for call_rcu().  srcu_barrier() and
cleanup_srcu_struct() flush it first, and rcutree_migrate_callbacks()
calls srcu_offline_drain() for an outgoing CPU.  ->lock is held across the
drain so the drainers serialize.

As in call_rcu(), the re-issue runs with interrupts disabled and can be
re-entered by instrumentation, so a flag on the srcu_data being drained
drops a deferring call_srcu() seen mid-drain (unless from an NMI).  Staging
records only the callback, so an expedited request is remembered per
srcu_data in ->defer_exp and the whole batch is re-issued expedited rather
than silently downgraded to a normal grace period.  A dropped callback can
also strand state its caller associated with it, not just the callback
itself.

Gated by CONFIG_RCU_DEFER.  Under CONFIG_PROVE_RCU, warn if the direct
path is reached from an NMI.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/srcutree.h |   5 ++
 kernel/rcu/rcu.h         |   3 +
 kernel/rcu/srcutree.c    | 171 ++++++++++++++++++++++++++++++++++++++-
 kernel/rcu/tree.c        |   2 +
 4 files changed, 177 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 75e54e4f963fa..09a9c8f4a6d24 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -13,6 +13,8 @@
 
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
+#include <linux/irq_work_types.h>
+#include <linux/llist.h>
 
 struct srcu_node;
 struct srcu_struct;
@@ -41,6 +43,9 @@ struct srcu_data {
 	bool srcu_cblist_invoking;		/* Invoking these CBs? */
 	struct timer_list delay_work;		/* Delay for CB invoking */
 	struct work_struct work;		/* Context for CB invoking. */
+	struct llist_head defer_cbs;		/* Callbacks deferred on re-entry. */
+	struct llist_node defer_link;		/* Links onto the per-CPU deferral drain list */
+	bool defer_exp;				/* A deferred callback asked to expedite. */
 	struct rcu_head srcu_barrier_head;	/* For srcu_barrier() use. */
 	struct rcu_head srcu_ec_head;		/* For srcu_expedite_current() use. */
 	int srcu_ec_state;			/*  State for srcu_expedite_current(). */
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fd075d91b80cf..84d74cd5a351c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -587,6 +587,9 @@ static inline bool should_rcu_defer(void)
 	return irqs_disabled() && rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
 }
 
+/* Drain an outgoing CPU's deferred SRCU callbacks; see rcutree_migrate_callbacks(). */
+void srcu_offline_drain(int cpu);
+
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 304112674e8a2..35fface51d50b 100644
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
@@ -79,6 +80,45 @@ static void process_srcu(struct work_struct *work);
 static void srcu_irq_work(struct irq_work *work);
 static void srcu_delay_timer(struct timer_list *t);
 
+struct srcu_defer;
+static void srcu_defer_drain(struct irq_work *iw);
+static void __srcu_defer_drain(struct srcu_defer *sndp, bool guard);
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
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct srcu_defer *sndp = &per_cpu(srcu_defer, cpu);
+
+		if (!llist_empty(&sndp->list))
+			__srcu_defer_drain(sndp, false);
+	}
+}
+
 /*
  * Initialize SRCU per-CPU data.  Note that statically allocated
  * srcu_struct structures might already have srcu_read_lock() and
@@ -107,6 +147,11 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 		sdp->cpu = cpu;
 		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
+		/*
+		 * ->defer_cbs, ->defer_link and ->defer_exp are valid when zeroed
+		 * and are not reinitialized here, lest we clobber callbacks a
+		 * reentrant call_srcu() already staged.  See __call_srcu().
+		 */
 		sdp->ssp = ssp;
 	}
 }
@@ -695,7 +740,12 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		return; /* Just leak it! */
 	if (WARN_ON(srcu_readers_active(ssp)))
 		return; /* Just leak it! */
-	/* Wait for irq_work to finish first as it may queue a new work. */
+	/*
+	 * Drain deferred callbacks before syncing ->irq_work: re-issuing one can
+	 * start a grace period and re-queue ->irq_work, which then schedules
+	 * ->work, so both must be waited out after the drain.
+	 */
+	srcu_defer_flush();
 	irq_work_sync(&sup->irq_work);
 	flush_delayed_work(&sup->work);
 	for_each_possible_cpu(cpu) {
@@ -1410,8 +1460,8 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
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
@@ -1423,6 +1473,111 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
 
+/*
+ * The srcu_cblist and srcu_node tree are only accessed with interrupts disabled
+ * (srcu_gp_start_if_needed() enqueues under raw_spin_lock_irqsave() and may walk
+ * the tree).  Like call_rcu(), __call_srcu() defers when interrupts are already
+ * disabled, so a re-entrant call_srcu() -- e.g. call_rcu_tasks_trace() from a
+ * BPF program -- cannot corrupt the list or deadlock.
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
+		 * inside srcu_defer_drain().  Re-queuing would livelock the
+		 * drain, so drop the callback; an NMI cannot loop, so let it in.
+		 */
+		if (READ_ONCE(sndp->draining) && !in_nmi()) {
+			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
+				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			return;
+		}
+		sdp = this_cpu_ptr(ssp->sda);
+		rhp->func = func;
+		if (!do_norm)
+			WRITE_ONCE(sdp->defer_exp, true);
+		if (llist_add((struct llist_node *)rhp, &sdp->defer_cbs)) {
+			/*
+			 * Chain this srcu_data for the drain.  ->ssp must be
+			 * published here: deferral skips check_init_srcu_struct(),
+			 * so on a never-initialized static srcu_struct the
+			 * statically zeroed ->sda still has a NULL ->ssp.
+			 */
+			sdp->ssp = ssp;
+			if (llist_add(&sdp->defer_link, &sndp->list))
+				irq_work_queue(&sndp->iw);
+		}
+		return;
+	}
+
+	/* An NMI reaching here entered with irqs enabled, so the enqueue can race. */
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
+static void __srcu_defer_drain(struct srcu_defer *sndp, bool guard)
+{
+	struct llist_node *snode, *snext;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&sndp->lock, flags);
+	if (guard)
+		WRITE_ONCE(sndp->draining, true);
+	llist_for_each_safe(snode, snext, llist_del_all(&sndp->list)) {
+		struct srcu_data *sdp = container_of(snode, struct srcu_data, defer_link);
+		struct srcu_struct *ssp = sdp->ssp;
+		struct llist_node *cnode, *cnext;
+		bool do_norm;
+
+		cnode = llist_del_all(&sdp->defer_cbs);
+		do_norm = !READ_ONCE(sdp->defer_exp);
+		if (!do_norm)
+			WRITE_ONCE(sdp->defer_exp, false);
+		llist_for_each_safe(cnode, cnext, cnode) {
+			struct rcu_head *rhp = (struct rcu_head *)cnode;
+
+			rhp->next = NULL;
+			srcu_do_enqueue(ssp, rhp, rhp->func, do_norm);
+		}
+	}
+	if (guard)
+		WRITE_ONCE(sndp->draining, false);
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
+	__srcu_defer_drain(container_of(iw, struct srcu_defer, iw), true);
+}
+
+/*
+ * Drain @cpu's deferred call_srcu() callbacks from rcutree_migrate_callbacks()
+ * once @cpu is dead.  One pass covers every srcu_struct, and the re-issue lands
+ * on the current CPU.
+ */
+void srcu_offline_drain(int cpu)
+{
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+	__srcu_defer_drain(&per_cpu(srcu_defer, cpu), false);
+}
+
 /**
  * call_srcu() - Queue a callback for invocation after an SRCU grace period
  * @ssp: srcu_struct in queue the callback
@@ -1677,9 +1832,17 @@ void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
 	int idx;
-	unsigned long s = rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
+	unsigned long s;
 
 	check_init_srcu_struct(ssp);
+
+	/*
+	 * Register any deferred callbacks before snapshotting the sequence.  The
+	 * shared irq_work may also drain other srcu_structs', which is harmless.
+	 */
+	srcu_defer_flush();
+
+	s = rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
 	mutex_lock(&ssp->srcu_sup->srcu_barrier_mutex);
 	if (rcu_seq_done(&ssp->srcu_sup->srcu_barrier_seq, s)) {
 		smp_mb(); /* Force ordering following return. */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6a83408974c2b..227790a87b02f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4646,6 +4646,8 @@ void rcutree_migrate_callbacks(int cpu)
 	 * returns; the re-issue lands on this CPU.
 	 */
 	__rcu_defer_drain(rdp, false);
+	/* Likewise for the outgoing CPU's deferred call_srcu() callbacks. */
+	srcu_offline_drain(cpu);
 
 	if (rcu_rdp_is_offloaded(rdp))
 		return;
-- 
2.53.0-Meta

