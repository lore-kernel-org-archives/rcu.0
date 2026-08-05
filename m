Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58983459AC4;
	Wed,  5 Aug 2026 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932642; cv=none; b=IWbgIRTIaUArRKa52y4cUE9BKK1j/SIQaNKKb0vVe6CZwyosrrReTHag2qWW24l6jfMIJ9nQ1m2zb1K9fTbF8oI/g87zLj9Mo2zu6Nn+VV6fDY7TwIUK/VK+t0Sn6tAVVq/kdbKWl1W1lNS2FNiDCLEUdzD6iK9DPty+IGnzS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932642; c=relaxed/simple;
	bh=EReJDLhEGlZPErokzaY75PeN749eccArMOHc/45VCa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O79JafiiACi05DMwiWegKh3Mare15Ksq3L9oq+E+LS9ZwxFqycgBePfHQ+r2UJYIqKErHvEUhcYIdrLaRBUjqSa7du4EwrvxLnnq8Knxdtfjsx+vs5pLJWeatcENQpBEgIXW4sTLQZhT/EiV0n6gCQa3k/2o3qzK8UiAWY8BV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaImOvrT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaImOvrT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA31F000E9;
	Wed,  5 Aug 2026 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932641;
	bh=kuNIjXo4zSvHj6D7JE/Gr+QwVuRbAcjkxyeYD0d8ipU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GaImOvrTEaIAcDaaRuVDqv4/esokMKc+5d/Uo42OP+gH9Qjo4rGH0M2IeTohD/RDs
	 yXLwWG5shVefHuvRMny2EHNCLOEcE4AsLvy0EjRDDb9xwfqmgvSzBhHyljvTuoN4vW
	 5+FZe8D+bwCo6MTiEiEUlrucAvcdCYt47vhJVCOKLxcb1/fMr6Zqnoh9o9YBmY86ru
	 uXp3+//H+1FIwP+QLeO/m3wOh8JO3PMSkK9hcTQDn1nh7SqMuYwWNoSGzhEh0FOfRM
	 SnJgqIa403+AI3ItZjNyLOBbS/6C2594lCTDXCNL8SNogUouqdA/EmwTmJYngMKEkW
	 ta3YCJlLYTQQQ==
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
Subject: [PATCH v3 1/6] rcu: Make call_rcu() safe to call from any context
Date: Wed,  5 Aug 2026 05:23:38 -0700
Message-ID: <20260805122346.269445-2-puranjay@kernel.org>
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

RCU's per-CPU callback list is only touched with interrupts disabled:
the enqueue runs under local_irq_save() (and the nocb locks when
offloaded), as do callback invocation and grace-period work.  A
call_rcu() that arrives with interrupts already disabled, whether from an
NMI or from instrumentation that re-enters RCU, can interrupt one of
those and corrupt the list or deadlock.

Handle it by deferring: stage the callback on a per-CPU llist and raise
an irq_work that re-issues it once interrupts are on.  The re-issue goes
straight to the enqueue so it cannot defer again.  Callers that only hold
interrupts off are deferred too, which is harmless.  Skip the gate while
the scheduler is down (RCU_SCHEDULER_INACTIVE), since irq_work is not
usable that early and rcu_init() already calls call_rcu().

rcu_barrier() flushes deferred callbacks before it scans the lists by
draining every CPU's ->defer_head itself, and rcutree_migrate_callbacks()
drains an outgoing CPU's.  ->defer_lock is held across llist_del_all() and
the re-issue, so these drainers serialize: a drain that finds the list
empty knows any re-issue in flight has already reached a callback list.

A deferred callback is re-issued without the lazy hint: it has already
waited for the drain, so batching it further would only add latency.

The re-issue runs with interrupts disabled, so instrumentation on the
enqueue path can re-enter call_rcu(), stage another callback, and
re-raise the irq_work, livelocking the drain.  A per-CPU flag guards it:
a call_rcu() that tries to defer while the drain is running, and is not
from an NMI, is dropped with WARN_ONCE() instead of re-queued.  Dropping
leaks the callback, but the alternative is an unbounded loop.

The irq_work is IRQ_WORK_INIT_HARD so the re-issue stays prompt on
PREEMPT_RT, where a non-HARD irq_work runs in a kthread that can be
delayed under load.  A hidden CONFIG_RCU_DEFER gates the code and its
IRQ_WORK dependency; without it call_rcu() enqueues directly as before.
Under CONFIG_PROVE_RCU, warn if the direct path is reached from an NMI.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/Kconfig |   6 ++
 kernel/rcu/rcu.h   |  15 +++++
 kernel/rcu/tree.c  | 139 +++++++++++++++++++++++++++++++++++++++++----
 kernel/rcu/tree.h  |   6 ++
 4 files changed, 156 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index f15da8038d0ba..1a5fb3156c062 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -175,6 +175,12 @@ config RCU_STALL_COMMON
 config RCU_NEED_SEGCBLIST
 	def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
 
+# The deferral (and the IRQ_WORK it uses) is only needed where call_rcu() /
+# call_srcu() can be invoked while a callback-list operation is in flight.
+config RCU_DEFER
+	def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
+	select IRQ_WORK
+
 config RCU_FANOUT
 	int "Tree-based hierarchical RCU fanout value"
 	range 2 64 if 64BIT
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 39a9f6fa9a7b2..fd075d91b80cf 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,21 @@ static inline void tasks_cblist_init_generic(void) { }
 #define RCU_SCHEDULER_INIT	1
 #define RCU_SCHEDULER_RUNNING	2
 
+/*
+ * Defer a call_rcu()/call_srcu() callback rather than enqueue it now?  Defer
+ * whenever interrupts are disabled, since a callback-list operation may be in
+ * flight on this CPU.  Not before the scheduler is up, though: that covers
+ * early boot, where irq_work is not yet usable and rcu_init() itself already
+ * calls call_rcu().
+ */
+static inline bool should_rcu_defer(void)
+{
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return false;
+
+	return irqs_disabled() && rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
+}
+
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21b6ce1dffb63..6a83408974c2b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -24,6 +24,7 @@
 #include <linux/smp.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/interrupt.h>
+#include <linux/llist.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
@@ -3148,21 +3149,25 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-static void
-__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
+/*
+ * The callback list is only accessed with interrupts disabled, so a call_rcu()
+ * that arrives with interrupts off (see should_rcu_defer()) stages the callback
+ * on a per-CPU llist that an irq_work re-issues once interrupts are on.
+ */
+static void rcu_defer_drain(struct irq_work *iw);
+
+/*
+ * Enqueue @head on this CPU's rcu_segcblist.  Also called by rcu_defer_drain()
+ * to re-issue a deferred callback, so it must not re-check the deferral
+ * condition.  Either caller may have interrupts already disabled.
+ */
+static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 {
 	static atomic_t doublefrees;
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
 
-	/* Misaligned rcu_head! */
-	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
-
-	/* Avoid NULL dereference if callback is NULL. */
-	if (WARN_ON_ONCE(!func))
-		return;
-
 	if (debug_rcu_head_queue(head)) {
 		/*
 		 * Probable double call_rcu(), so leak the callback.
@@ -3206,6 +3211,104 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	local_irq_restore(flags);
 }
 
+/*
+ * Re-issue deferred callbacks straight to the enqueue so they cannot defer
+ * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
+ * rcu_defer_flush() and rcutree_migrate_callbacks().
+ */
+static void __rcu_defer_drain(struct rcu_data *rdp, bool guard)
+{
+	struct llist_node *node, *next;
+	unsigned long flags;
+
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	raw_spin_lock_irqsave(&rdp->defer_lock, flags);
+	if (guard)
+		WRITE_ONCE(rdp->defer_draining, true);
+	llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) {
+		struct rcu_head *head = (struct rcu_head *)node;
+
+		head->next = NULL;
+		rcu_do_enqueue(head, head->func, false);
+	}
+	if (guard)
+		WRITE_ONCE(rdp->defer_draining, false);
+	raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
+}
+
+/*
+ * Only the irq_work drain can be re-fed by its own re-issue, so only it sets
+ * ->defer_draining.  A direct drain re-issues onto this CPU, and anything
+ * staged during it is picked up by that CPU's own irq_work.
+ */
+static void rcu_defer_drain(struct irq_work *iw)
+{
+	__rcu_defer_drain(container_of(iw, struct rcu_data, defer_work), true);
+}
+
+/* Stage @head for this CPU's irq_work when call_rcu() cannot enqueue now. */
+static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	/*
+	 * Instrumentation on the enqueue path can re-enter here from inside
+	 * rcu_defer_drain().  Re-queuing would livelock the drain, so drop the
+	 * callback; an NMI is one-shot and cannot loop, so let it through.
+	 */
+	if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
+		WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
+			  "call_rcu() re-entered during callback drain; leaking callback\n");
+		return;
+	}
+	head->func = func;
+	if (llist_add((struct llist_node *)head, &rdp->defer_head))
+		irq_work_queue(&rdp->defer_work);
+}
+
+/*
+ * Register pending deferred callbacks into the callback lists so a following
+ * rcu_barrier() waits for them.  This runs before rcu_barrier() scans the
+ * lists.
+ */
+static void rcu_defer_flush(void)
+{
+	int cpu;
+
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		if (!llist_empty(&rdp->defer_head))
+			__rcu_defer_drain(rdp, false);
+	}
+}
+
+static void
+__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
+{
+	/* Misaligned rcu_head! */
+	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
+
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
+	if (should_rcu_defer()) {
+		call_rcu_defer(head, func);
+		return;
+	}
+
+	/* An NMI reaching here entered with irqs enabled, so the enqueue can race. */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+
+	rcu_do_enqueue(head, func, lazy_in);
+}
+
 #ifdef CONFIG_RCU_LAZY
 static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
 module_param(enable_rcu_lazy, bool, 0444);
@@ -3896,8 +3999,12 @@ void rcu_barrier(void)
 	unsigned long flags;
 	unsigned long gseq;
 	struct rcu_data *rdp;
-	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
+	unsigned long s;
 
+	/* Register any deferred callbacks before snapshotting the sequence. */
+	rcu_defer_flush();
+
+	s = rcu_seq_snap(&rcu_state.barrier_sequence);
 	rcu_barrier_trace(TPS("Begin"), -1, s);
 
 	/* Take mutex to serialize concurrent rcu_barrier() requests. */
@@ -4231,6 +4338,10 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
+	init_llist_head(&rdp->defer_head);
+	raw_spin_lock_init(&rdp->defer_lock);
+	/* Hard irq_work so the re-issue runs promptly. */
+	rdp->defer_work = IRQ_WORK_INIT_HARD(rcu_defer_drain);
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
@@ -4528,6 +4639,14 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
+	/*
+	 * Callbacks the outgoing CPU deferred late in the offline path (past the
+	 * point its irq_work can run) sit on ->defer_head, which the ->cblist
+	 * migration below does not cover.  Drain them here, before the early
+	 * returns; the re-issue lands on this CPU.
+	 */
+	__rcu_defer_drain(rdp, false);
+
 	if (rcu_rdp_is_offloaded(rdp))
 		return;
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index eedfa43059e80..b7cac7a13b4f2 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -229,6 +229,12 @@ struct rcu_data {
 	struct rcu_head barrier_head;
 	int exp_watching_snap;		/* Double-check need for IPI. */
 
+	/* Deferral of an NMI/reentrant call_rcu(); see __call_rcu_common(). */
+	struct llist_head defer_head;
+	struct irq_work defer_work;
+	raw_spinlock_t defer_lock;
+	bool defer_draining;
+
 	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct swait_queue_head nocb_cb_wq; /* For nocb kthreads to sleep on. */
-- 
2.53.0-Meta

