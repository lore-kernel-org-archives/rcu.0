Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043B3D75A1;
	Mon, 10 Aug 2026 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364898; cv=none; b=TIz/rh8KM37wvCe8SGO+zk5uJg7ulxp2kh00LGr0hibLmMUkoP5pwqWk7ZdU+6cAoa1CFchrIJWihRpLwl8rrBZcsZ+W6WX6Mb9qWmEmhsscPJWWRSyxXsLCODo3FjpNfy/nXIBXMoHaPL9SlfRIQrmQFP+XYHwFVB8uV3HUcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364898; c=relaxed/simple;
	bh=T9XDYwpQqs/O8dKn05DDy/qIwIvaH2o+0z7ppRdGyl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS8plx6rE79sm+pfJYAcdByFYyq+VSqN+rVaKU1xcpEWHIa8xs+pwwAoyw519sfuo+ey9y5Qs0SaFxltDp2MF40PpPaxOC+PYKSUqt8ZAf08RErJzLFmMgvW+KhASqhHoLtCtSv/SjXdNzVcJTXIZj/WC0XlvRndEomtcvWsf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoPP1ipJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoPP1ipJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0F51F000E9;
	Mon, 10 Aug 2026 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786364896;
	bh=PpX8WmDOIXfXSuF7Dzly1j9xo/oluC1UGMrpWDF2+X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoPP1ipJZmbTLPkzwBWD1VvFXq6RiD3t/HbiGlRrZsARph8FVY0nA7TXSKdgeiv6J
	 Liugltr6CFCTBNmX/cVY19iMc/wfray+EbCTMJLY/e9cjOXg70x8hRYKwn9v71RG8j
	 oHZQRp2pcyed6kd0K1JGFvs1F5rX0MKrjZWYO0unRaxlog8tqOK08RSwzIpYtaX/hs
	 NNdYrLWP3gwoFHOkwCTX3K4qTI7vWe7lEWF6rdUGmdhmC9coqMyJrKGkyL6FAvNFSv
	 HdKAzbvwXaRis+aq33wxSSPAibL35GOoAeV66RoipwTEmljhNvLbToP7dpAvfZwZB+
	 7Fb5fKRWoMpHw==
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
Subject: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
Date: Mon, 10 Aug 2026 05:27:50 -0700
Message-ID: <20260810122758.183765-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810122758.183765-1-puranjay@kernel.org>
References: <20260810122758.183765-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RCU's per-CPU callback list is only touched with interrupts disabled: the
enqueue runs under local_irq_save() (and the nocb locks when offloaded),
as do callback invocation and grace-period work.  A call_rcu() that
arrives with interrupts already disabled, whether from an NMI or from
instrumentation that re-enters RCU, can interrupt one of those and corrupt
the list or deadlock.

Defer instead: stage the callback on a per-CPU llist and raise an irq_work
that re-issues it once interrupts are on, straight to the enqueue so it
cannot defer again.  The gate is bare irqs_disabled(), so callers that
merely hold interrupts off are deferred too and pay one irq_work hop.
Skip it while the scheduler is down (RCU_SCHEDULER_INACTIVE): irq_work is
not usable that early, rcu_init() already calls call_rcu(), and the per-CPU
deferral state is not initialised until rcu_init_one() runs later in it.

rcu_barrier() drains every CPU's ->defer_head before it scans the lists,
and rcutree_migrate_callbacks() drains an outgoing CPU's.  A drain
re-issues onto the draining CPU, so a barrier moves other CPUs' staged
callbacks onto
its own ->cblist; call_rcu() promises no CPU affinity for invocation.
->defer_lock is held across llist_del_all() and the whole re-issue so the
drainers
serialize: one that finds the list empty can conclude that everything
staged before it is already on a callback list.  Interrupts stay off for
the batch.  Where the arch has an irq_work self-IPI that is what one
interrupts-disabled region could stage, normally a single callback; where
arch_irq_work_has_interrupt() is false the drain waits for the tick, so
several regions can accumulate first.

The drain clears ->next before re-issuing.  A double call_rcu() on a head
that is already debug-object-active self-links the staged node, and
rcu_do_enqueue()'s duplicate path returns without clearing it, so the
drain would spin.  A re-add behind other staged callbacks makes a longer
cycle, which that does not bound; a double call_rcu() stays undefined.
llist_del_all() yields newest-first, so a batch is re-issued in reverse
call order; nothing depends on call_rcu() ordering.  The re-issue drops
the lazy hint, since staging records only ->func, so a deferred callback
loses its batching on CONFIG_RCU_LAZY.  kasan_record_aux_stack() moves to
__call_rcu_common() so a use-after-free report names the caller rather
than the irq_work.

The re-issue runs with interrupts disabled, so instrumentation on the
enqueue path can re-enter call_rcu(), stage another callback and re-raise
the irq_work, livelocking the drain.  A per-CPU flag guards it: a deferral
that arrives while this CPU is draining, and is not from an NMI, is
dropped.  The WARN_ONCE() is under CONFIG_PROVE_RCU, so a production kernel
drops it silently.  That leaks the callback and can strand state
the caller tied to it, since a one-shot flag only the callback clears
never resets, but the alternative is an unbounded loop.

A callback deferred past the CPUHP_AP_SMPCFD_DYING irq_work flush leaves
->defer_work claimed with its self-IPI lost.  rcutree_migrate_callbacks()
still re-issues the callback, but the first deferral after that CPU comes
back raises no IPI and waits for the next irq_work there, or for
rcu_barrier().  Unqueueing an irq_work is not something the API offers.

The irq_work is IRQ_WORK_INIT_HARD so the re-issue stays prompt on
PREEMPT_RT, where a non-HARD irq_work runs in a kthread that can be
delayed under load.  A hidden CONFIG_RCU_DEFER gates the deferral code and
its IRQ_WORK dependency, though the rcu_data members are unconditional;
without it call_rcu() enqueues directly as before.  Under
CONFIG_PROVE_RCU, warn if the direct path is reached from an NMI.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/Kconfig |   6 +++
 kernel/rcu/rcu.h   |  11 ++++
 kernel/rcu/tree.c  | 131 +++++++++++++++++++++++++++++++++++++++++----
 kernel/rcu/tree.h  |   6 +++
 4 files changed, 143 insertions(+), 11 deletions(-)

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
index 39a9f6fa9a7b2..91e33571a554d 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -572,6 +572,17 @@ static inline void tasks_cblist_init_generic(void) { }
 #define RCU_SCHEDULER_INIT	1
 #define RCU_SCHEDULER_RUNNING	2
 
+/*
+ * Defer whenever interrupts are disabled, since a callback-list operation may
+ * be in flight on this CPU.  Not before the scheduler is up: irq_work is not
+ * usable that early, and rcu_init() itself calls call_rcu().
+ */
+static inline bool should_rcu_defer(void)
+{
+	return IS_ENABLED(CONFIG_RCU_DEFER) && irqs_disabled() &&
+	       rcu_scheduler_active != RCU_SCHEDULER_INACTIVE;
+}
+
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21b6ce1dffb63..3bf3a250f9de8 100644
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
@@ -3148,21 +3149,19 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-static void
-__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
+/*
+ * Also called by __rcu_defer_drain() to re-issue a deferred callback, so it
+ * must not re-check the deferral condition.  Either caller may have interrupts
+ * already disabled, and a drain of a remote CPU re-issues onto the draining
+ * CPU.
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
@@ -3178,7 +3177,6 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 	head->func = func;
 	head->next = NULL;
-	kasan_record_aux_stack(head);
 
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
@@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	local_irq_restore(flags);
 }
 
+/*
+ * Re-issue deferred callbacks straight to the enqueue so they cannot defer
+ * again.  ->defer_lock serializes the drainers: this CPU's irq_work,
+ * rcu_defer_flush() and rcutree_migrate_callbacks().
+ */
+static void __rcu_defer_drain(struct rcu_data *rdp)
+{
+	struct llist_node *node, *next;
+	unsigned long flags;
+
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	raw_spin_lock_irqsave(&rdp->defer_lock, flags);
+	llist_for_each_safe(node, next, llist_del_all(&rdp->defer_head)) {
+		struct rcu_head *head = (struct rcu_head *)node;
+
+		/* Bounds a node self-linked by a double call_rcu(). */
+		head->next = NULL;
+		rcu_do_enqueue(head, head->func, false);
+	}
+	raw_spin_unlock_irqrestore(&rdp->defer_lock, flags);
+}
+
+/*
+ * Only the irq_work drain can be re-fed by its own re-issue, so only it sets
+ * ->defer_draining.  Anything staged during a direct drain is picked up by the
+ * staging CPU's own irq_work.  Every caller of irq_work_run_list() has
+ * interrupts disabled, so the flag is never visible with them enabled.
+ */
+static void rcu_defer_drain(struct irq_work *iw)
+{
+	struct rcu_data *rdp = container_of(iw, struct rcu_data, defer_work);
+
+	WRITE_ONCE(rdp->defer_draining, true);
+	__rcu_defer_drain(rdp);
+	WRITE_ONCE(rdp->defer_draining, false);
+}
+
+/*
+ * Stage @head for this CPU's irq_work to re-issue once interrupts are on.  Only
+ * the drain side takes a lock, so this stays safe from NMI.
+ */
+static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	/*
+	 * Instrumentation on the enqueue path can re-enter here from inside the
+	 * drain.  Re-queuing would livelock it, so drop the callback; an NMI
+	 * cannot loop, so let it through.
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
+static void rcu_defer_flush(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		__rcu_defer_drain(per_cpu_ptr(&rcu_data, cpu));
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
+	/* Record the caller: the irq_work's stack says nothing about it. */
+	kasan_record_aux_stack(head);
+
+	if (should_rcu_defer()) {
+		call_rcu_defer(head, func);
+		return;
+	}
+
+	/*
+	 * Only reachable from an NMI when deferral is off: before the scheduler
+	 * is up, or with CONFIG_RCU_DEFER=n.  The enqueue can then race.
+	 */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+
+	rcu_do_enqueue(head, func, lazy_in);
+}
+
 #ifdef CONFIG_RCU_LAZY
 static bool enable_rcu_lazy __read_mostly = !IS_ENABLED(CONFIG_RCU_LAZY_DEFAULT_OFF);
 module_param(enable_rcu_lazy, bool, 0444);
@@ -3896,8 +3991,12 @@ void rcu_barrier(void)
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
@@ -4231,6 +4330,9 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->rcu_onl_gp_state = RCU_GP_CLEANED;
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
+	init_llist_head(&rdp->defer_head);
+	raw_spin_lock_init(&rdp->defer_lock);
+	rdp->defer_work = IRQ_WORK_INIT_HARD(rcu_defer_drain);
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
@@ -4528,6 +4630,13 @@ void rcutree_migrate_callbacks(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	bool needwake;
 
+	/*
+	 * Callbacks deferred past the point the outgoing CPU's irq_work can run
+	 * sit on ->defer_head, which the ->cblist migration below does not
+	 * cover.  Drain them here, before the early returns.
+	 */
+	__rcu_defer_drain(rdp);
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

