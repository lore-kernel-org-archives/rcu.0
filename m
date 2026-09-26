Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379ED1FCFFC;
	Sat, 26 Sep 2026 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408778; cv=none; b=CaH6xR1TP3fuwy+EcdL1xfvBWyFbtCmpWK/ujz9Bgzy3OgRvHchtBPC9UQk5NdVw+o238hxmnwWuh/0XtGoBJbuGjV+c7YkuXCe/TVVthzSAkQrDZkoseUBwqnYRPu1zNZIbCJrerTv5yhn5HfMKf/5/TSC2wnZ4IqkX3rRGbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408778; c=relaxed/simple;
	bh=wQrY+kvvpsWceAIKRKr1qWW3GprFunT76A6spVNDeZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fbSKKoFbQZokeaWAzM7rcJ1igCd5Vu7ipQvXttPk/rYBHyiDTkBaXySVQLkvcjis47Sf4Mr5tS3BDWNJk+ioFzwMNq/G9IDXDu+mmy+MjyDRJ4+z32QW+jk9j/YNEOWM6KbGvofYQ3WjRCVmgmbGGJT+LZ7Ea3QAXbVo2t5bqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuyGr2zB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuyGr2zB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B26A1F000FF;
	Sat, 26 Sep 2026 07:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790408775;
	bh=IlboVhy3wOMX6HzY0u/ZNdLQlp780rhi+0UwmAoaUXs=;
	h=From:To:Cc:Subject:Date;
	b=PuyGr2zBb79w8ZKpAMj8Q29/2vz1VjtpaaFD3tqWbHjLEdY4QUP440zGuHhitFB//
	 hqQR5yZbOQyZzw3upxhU4C0EnSM0vFH3zRT5MbYRmGyQp2/1vqx/UKhZx9QVg+04rv
	 SRUj5tAxha/R+EdGdYQI6GJgFhrNis5Ul6YkJpFiSnqselr/eZK+r8iiKd/5TLq4rT
	 kE0s997mRqI/RWBjTy3SM+X62iyPTLtN9eDe+ysyNom8HkOzI8ExVQvxXxxbnt4iIN
	 JPTSSB494iGqHaa2dsDn+7xRjx0624BpKnuG6K0K7F9XAWPcB+7UMN0uUONBy+pgTd
	 D1FSF/jgcC0KA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2] kprobes: Make optprobe optimizer multi-generational and asynchronous
Date: Sat, 26 Sep 2026 16:46:09 +0900
Message-ID: <179040876891.171579.9459626579461679924.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Currently, kprobe_optimizer() holds kprobe_mutex, text_mutex, and
cpus_read_lock() simultaneously while executing synchronize_rcu_tasks().
Under PREEMPT_LAZY and server workloads with long-running CPU-bound kernel
tasks or heavy cgroup writeback loops, synchronize_rcu_tasks() can block
for seconds to minutes. Because text_mutex and cpus_read_lock() are held
during this entire wait, any concurrent static key updates, module
loading/unloading, CPU hotplug, or tracing updates stall, frequently
triggering hung-task detector panics.

Instead of penalizing the kernel preemption path with invasive hooks and
global hash lookups, decouple kprobe jump optimization from synchronous
waiting entirely:

1. Replace synchronize_rcu_tasks() with call_rcu_tasks(). Locks
   (text_mutex and cpus_read_lock()) are held only for the brief moment
   needed to patch instructions via arch_unoptimize_kprobes() and
   arch_optimize_kprobes() (microseconds), and are completely released
   while waiting for the Tasks RCU grace period.

2. Introduce a fixed ring of generations (optprobe_gens[OPTPROBE_GEN_MAX])
   to avoid any dynamic memory allocation (kmalloc) or -ENOMEM failure
   modes.

3. The last generation slot in the array is reserved as a "waiting room"
   and is not dispatched to RCU until another in-flight generation has
   finished. While a generation is waiting for its Tasks RCU grace period,
   any newly registered or unregistered probes accumulate in the waiting
   room generation without blocking or requiring additional slots.

4. When the Tasks RCU callback fires, it marks the generation as ready
   and wakes up the optimizer thread to finalize optimization (poking
   the jump instructions) and free cleaned probe slots. Once finalized,
   the generation is marked idle, allowing the waiting room generation
   to be dispatched next.

5. Flushing via wait_for_kprobe_optimizer() waits asynchronously for all
   in-flight and queued generations to drain without stalling other
   kernel subsystems.

On non-preemptive kernels or configs where CONFIG_TASKS_RCU=n,
call_rcu_tasks() transparently aliases to call_rcu(), preserving full
portability.

Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
base-commit: 5bfa9f1a9dcb6ecb607adbc1c0226605c972935b

Changes in v2:
 - Rebase on Andrea Parri's fix ("kprobes: Fix permanent hang when
   flushing the kprobe optimizer") and use optimizer_passes with
   wait_var_event_mutex() instead of optimizer_completion.
 - Check gen->freeing_list in optprobe_has_queued_probes() so that
   forcibly unoptimized probes are dispatched and accounted for when
   flushing.
 - Ensure kick_kprobe_optimizer() is called when probes are moved to
   freeing_list.
 - Dequeue from freeing_list in optimize_kprobe() before re-optimizing.
 - Introduce cooling_list in optprobe_generation to keep in-use
   unoptimized probes attached during the Tasks RCU grace period.
 - Avoid premature arch_remove_optimized_kprobe() in
   kill_optimized_kprobe() if the probe is queued or in-flight for
   optimizer cleanup.
---
 kernel/kprobes.c |  398 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 303 insertions(+), 95 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4edd8ca5c657..377fa9bfa029 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -43,6 +43,7 @@
 #include <linux/cleanup.h>
 #include <linux/wait.h>
 #include <linux/wait_bit.h>
+#include <linux/rcupdate.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -67,7 +68,7 @@ static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 /* NOTE: change this value only with 'kprobe_mutex' held */
 static bool kprobes_all_disarmed;
 
-/* This protects 'kprobe_table' and 'optimizing_list' */
+/* This protects 'kprobe_table' and 'optprobe_gens' */
 static DEFINE_MUTEX(kprobe_mutex);
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
 
@@ -512,10 +513,39 @@ static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
 	return NULL;
 }
 
-/* Optimization staging list, protected by 'kprobe_mutex' */
-static LIST_HEAD(optimizing_list);
-static LIST_HEAD(unoptimizing_list);
-static LIST_HEAD(freeing_list);
+#define OPTPROBE_GEN_MAX 2
+
+struct optprobe_generation {
+	/* Probes waiting to be optimized (jump installed) after grace period */
+	struct list_head optimizing_list;
+	/* Probes waiting to be unoptimized (jump replaced with breakpoint) */
+	struct list_head unoptimizing_list;
+	/* In-use probes unoptimized and cooling down during Tasks RCU grace period */
+	struct list_head cooling_list;
+	/* Unused probes waiting for grace period before being freed */
+	struct list_head freeing_list;
+	/* Tasks RCU callback head for asynchronous waiting */
+	struct rcu_head rcu;
+	/* True if dispatched and awaiting Tasks RCU callback */
+	bool in_flight;
+	/* True when Tasks RCU callback has fired and ready to finalize */
+	bool ready;
+};
+
+/*
+ * Generational ring of optprobes.
+ *
+ * Incoming probe requests are queued into the waiting room generation
+ * (optprobe_gens[optprobe_cur_gen]). When dispatched, the generation
+ * unoptimizes its probes, invokes call_rcu_tasks(), and optprobe_cur_gen
+ * advances to the next slot.
+ *
+ * To ensure an idle generation is always available to collect incoming
+ * requests without dynamic allocation, the last available generation slot
+ * is never dispatched until another generation has finished.
+ */
+static struct optprobe_generation optprobe_gens[OPTPROBE_GEN_MAX];
+static int optprobe_cur_gen;
 
 static void optimize_kprobe(struct kprobe *p);
 static struct task_struct *kprobe_optimizer_task;
@@ -533,49 +563,84 @@ static unsigned long optimizer_passes;
 #define OPTIMIZE_DELAY 5
 
 /*
- * Optimize (replace a breakpoint with a jump) kprobes listed on
- * 'optimizing_list'.
+ * Note: gen->cooling_list is not checked here because it is strictly
+ * an in-flight holding list for dispatched generations, so it is always
+ * empty in optprobe_cur_gen.
  */
-static void do_optimize_kprobes(void)
+static bool optprobe_has_queued_probes(void)
 {
-	lockdep_assert_held(&text_mutex);
-	/*
-	 * The optimization/unoptimization refers 'online_cpus' via
-	 * stop_machine() and cpu-hotplug modifies the 'online_cpus'.
-	 * And same time, 'text_mutex' will be held in cpu-hotplug and here.
-	 * This combination can cause a deadlock (cpu-hotplug tries to lock
-	 * 'text_mutex' but stop_machine() can not be done because
-	 * the 'online_cpus' has been changed)
-	 * To avoid this deadlock, caller must have locked cpu-hotplug
-	 * for preventing cpu-hotplug outside of 'text_mutex' locking.
-	 */
-	lockdep_assert_cpus_held();
+	struct optprobe_generation *gen = &optprobe_gens[optprobe_cur_gen];
 
-	/* Optimization never be done when disarmed */
-	if (kprobes_all_disarmed || !kprobes_allow_optimization ||
-	    list_empty(&optimizing_list))
-		return;
+	return !list_empty(&gen->optimizing_list) ||
+	       !list_empty(&gen->unoptimizing_list) ||
+	       !list_empty(&gen->freeing_list);
+}
 
-	arch_optimize_kprobes(&optimizing_list);
+static int optprobe_active_gens_count(void)
+{
+	int count = 0;
+	int i;
+
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		if (optprobe_gens[i].in_flight || optprobe_gens[i].ready)
+			count++;
+	}
+	return count;
+}
+
+/*
+ * The last generation must not be fired until another generation is done.
+ * (Thus the last generation acts as the waiting room.)
+ */
+static bool optprobe_can_fire(void)
+{
+	return optprobe_active_gens_count() < OPTPROBE_GEN_MAX - 1;
+}
+
+static bool optprobe_has_ready_gens(void)
+{
+	int i;
+
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		if (READ_ONCE(optprobe_gens[i].ready))
+			return true;
+	}
+	return false;
+}
+
+static bool optprobe_optimizer_busy(void)
+{
+	return optprobe_has_queued_probes() || (optprobe_active_gens_count() > 0);
 }
 
 /*
  * Unoptimize (replace a jump with a breakpoint and remove the breakpoint
- * if need) kprobes listed on 'unoptimizing_list'.
+ * if need) kprobes listed on 'unopt_list'.
  */
-static void do_unoptimize_kprobes(void)
+static void do_unoptimize_kprobes(struct list_head *unopt_list,
+				  struct list_head *free_list,
+				  struct list_head *cooling_list)
 {
 	struct optimized_kprobe *op, *tmp;
 
 	lockdep_assert_held(&text_mutex);
-	/* See comment in do_optimize_kprobes() */
+	/*
+	 * The optimization/unoptimization refers 'online_cpus' via
+	 * stop_machine() and cpu-hotplug modifies the 'online_cpus'.
+	 * And same time, 'text_mutex' will be held in cpu-hotplug and here.
+	 * This combination can cause a deadlock (cpu-hotplug tries to lock
+	 * 'text_mutex' but stop_machine() can not be done because
+	 * the 'online_cpus' has been changed)
+	 * To avoid this deadlock, caller must have locked cpu-hotplug
+	 * for preventing cpu-hotplug outside of 'text_mutex' locking.
+	 */
 	lockdep_assert_cpus_held();
 
-	if (!list_empty(&unoptimizing_list))
-		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
+	if (!list_empty(unopt_list))
+		arch_unoptimize_kprobes(unopt_list, free_list);
 
-	/* Loop on 'freeing_list' for disarming and removing from kprobe hash list */
-	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
+	/* Loop on 'free_list' for disarming and removing from kprobe hash list */
+	list_for_each_entry_safe(op, tmp, free_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 		/* Disarm probes if marked disabled and not gone */
@@ -588,17 +653,25 @@ static void do_unoptimize_kprobes(void)
 			 * (reclaiming is done by do_free_cleaned_kprobes().)
 			 */
 			hlist_del_rcu(&op->kp.hlist);
-		} else
-			list_del_init(&op->list);
+		} else {
+			/*
+			 * Keep on cooling_list until the quiescence period
+			 * completes so that kprobe_disarmed() remains false and
+			 * unregister_kprobes() does not prematurely free it.
+			 */
+			list_move(&op->list, cooling_list);
+		}
 	}
 }
 
-/* Reclaim all kprobes on the 'freeing_list' */
-static void do_free_cleaned_kprobes(void)
+/* Reclaim all kprobes on the 'free_list' */
+static void do_free_cleaned_kprobes(struct list_head *free_list)
 {
 	struct optimized_kprobe *op, *tmp;
 
-	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
+	list_for_each_entry_safe(op, tmp, free_list, list) {
+		struct kprobe *_p;
+
 		list_del_init(&op->list);
 		if (WARN_ON_ONCE(!kprobe_unused(&op->kp))) {
 			/*
@@ -610,11 +683,10 @@ static void do_free_cleaned_kprobes(void)
 
 		/*
 		 * The aggregator was holding back another probe while it sat on the
-		 * unoptimizing/freeing lists.  Now that the aggregator has been fully
+		 * unoptimizing/freeing lists. Now that the aggregator has been fully
 		 * reverted we can safely retry the optimization of that sibling.
 		 */
-
-		struct kprobe *_p = get_optimized_kprobe(op->kp.addr);
+		_p = get_optimized_kprobe(op->kp.addr);
 		if (unlikely(_p))
 			optimize_kprobe(_p);
 
@@ -624,67 +696,138 @@ static void do_free_cleaned_kprobes(void)
 
 static void kick_kprobe_optimizer(void);
 
-/* Kprobe jump optimizer */
-static void kprobe_optimizer(void)
+static void optprobe_generation_rcu_cb(struct rcu_head *rcu)
 {
-	guard(mutex)(&kprobe_mutex);
+	struct optprobe_generation *gen;
+
+	gen = container_of(rcu, struct optprobe_generation, rcu);
+	WRITE_ONCE(gen->ready, true);
+	wake_up(&kprobe_optimizer_wait);
+}
+
+static void optprobe_finalize_generation(struct optprobe_generation *gen)
+{
+	struct optimized_kprobe *op, *tmp;
+
+	lockdep_assert_held(&kprobe_mutex);
 
 	scoped_guard(cpus_read_lock) {
 		guard(mutex)(&text_mutex);
 
-		/*
-		 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
-		 * kprobes before waiting for quiesence period.
-		 */
-		do_unoptimize_kprobes();
+		/* Optimization never be done when disarmed */
+		if (!kprobes_all_disarmed && kprobes_allow_optimization &&
+		    !list_empty(&gen->optimizing_list))
+			arch_optimize_kprobes(&gen->optimizing_list);
+	}
+
+	/* Free cleaned kprobes after quiescence period */
+	do_free_cleaned_kprobes(&gen->freeing_list);
+
+	/* Finalize unoptimized kprobes whose quiescence period completed */
+	list_for_each_entry_safe(op, tmp, &gen->cooling_list, list) {
+		if (kprobe_unused(&op->kp)) {
+			/*
+			 * Unregistered while quiescence period was in flight.
+			 * Remove from hash list and move to cur_gen's freeing list.
+			 */
+			hlist_del_rcu(&op->kp.hlist);
+			list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
+			kick_kprobe_optimizer();
+		} else {
+			/* Still in use; now safely disarmed */
+			list_del_init(&op->list);
+			if (!kprobe_disabled(&op->kp))
+				optimize_kprobe(&op->kp);
+		}
+	}
+
+	gen->in_flight = false;
+	WRITE_ONCE(gen->ready, false);
+}
+
+static void optprobe_dispatch_generation(void)
+{
+	struct optprobe_generation *gen;
+
+	lockdep_assert_held(&kprobe_mutex);
+
+	if (!optprobe_can_fire() || !optprobe_has_queued_probes())
+		return;
+
+	gen = &optprobe_gens[optprobe_cur_gen];
+
+	scoped_guard(cpus_read_lock) {
+		guard(mutex)(&text_mutex);
 
 		/*
-		 * Step 2: Wait for quiesence period to ensure all potentially
-		 * preempted tasks to have normally scheduled. Because optprobe
-		 * may modify multiple instructions, there is a chance that Nth
-		 * instruction is preempted. In that case, such tasks can return
-		 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
-		 * Note that on non-preemptive kernel, this is transparently converted
-		 * to synchronoze_sched() to wait for all interrupts to have completed.
+		 * Unoptimize kprobes and collect cleaned (unused and disarmed)
+		 * kprobes before waiting for quiescence period.
 		 */
-		synchronize_rcu_tasks();
+		do_unoptimize_kprobes(&gen->unoptimizing_list, &gen->freeing_list,
+				      &gen->cooling_list);
+	}
+
+	/* Advance cur_gen to the next generation slot */
+	optprobe_cur_gen = (optprobe_cur_gen + 1) % OPTPROBE_GEN_MAX;
+
+	gen->in_flight = true;
+	WRITE_ONCE(gen->ready, false);
+
+	call_rcu_tasks(&gen->rcu, optprobe_generation_rcu_cb);
+}
 
-		/* Step 3: Optimize kprobes after quiesence period */
-		do_optimize_kprobes();
+/* Kprobe jump optimizer */
+static void kprobe_optimizer(void)
+{
+	int i;
 
-		/* Step 4: Free cleaned kprobes after quiesence period */
-		do_free_cleaned_kprobes();
+	guard(mutex)(&kprobe_mutex);
+
+	/* Step 1: Finalize any generation whose Tasks RCU grace period completed */
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		if (READ_ONCE(optprobe_gens[i].ready))
+			optprobe_finalize_generation(&optprobe_gens[i]);
 	}
 
-	/* Step 5: Wake up flushers, and kick optimizer again if needed. */
+	/* Step 2: Dispatch waiting room generation if allowed */
+	optprobe_dispatch_generation();
+
+	/* Step 3: Wake up flushers and kick optimizer again if needed */
 	optimizer_passes++;
 	wake_up_var_locked(&optimizer_passes, &kprobe_mutex);
 
-	if (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list))
-		kick_kprobe_optimizer();	/*normal kick*/
+	if (optprobe_has_queued_probes() && optprobe_can_fire()) {
+		/* Probes remain and can be fired immediately (e.g. retried siblings) */
+		kick_kprobe_optimizer();
+	}
 }
 
 static int kprobe_optimizer_thread(void *data)
 {
 	while (!kthread_should_stop()) {
-		/* To avoid hung_task, wait in interruptible state. */
+		/* Wait until there is work to do or a generation is ready */
 		wait_event_interruptible(kprobe_optimizer_wait,
-			   atomic_read(&optimizer_state) != OPTIMIZER_ST_IDLE ||
-			   kthread_should_stop());
+			atomic_read(&optimizer_state) != OPTIMIZER_ST_IDLE ||
+			optprobe_has_ready_gens() ||
+			kthread_should_stop());
 
 		if (kthread_should_stop())
 			break;
 
 		/*
-		 * If it was a normal kick, wait for OPTIMIZE_DELAY.
-		 * This wait can be interrupted by a flush request.
+		 * If it was a normal kick and no generation is ready to finalize,
+		 * wait for OPTIMIZE_DELAY to batch incoming requests.
+		 * This wait can be interrupted by a flush request or a ready generation.
 		 */
-		if (atomic_read(&optimizer_state) == 1)
+		if (atomic_read(&optimizer_state) == OPTIMIZER_ST_KICKED &&
+		    !optprobe_has_ready_gens()) {
 			wait_event_interruptible_timeout(
 				kprobe_optimizer_wait,
 				atomic_read(&optimizer_state) == OPTIMIZER_ST_FLUSHING ||
+				optprobe_has_ready_gens() ||
 				kthread_should_stop(),
 				OPTIMIZE_DELAY);
+		}
 
 		if (kthread_should_stop())
 			break;
@@ -709,13 +852,10 @@ static void wait_for_kprobe_optimizer_locked(void)
 {
 	lockdep_assert_held(&kprobe_mutex);
 
-	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
+	while (optprobe_optimizer_busy()) {
 		unsigned long passes = optimizer_passes;
 
-		/*
-		 * Set state to OPTIMIZER_ST_FLUSHING and wake up the thread if it's
-		 * idle. If it's already kicked, it will see the state change.
-		 */
+		/* Wake up optimizer thread */
 		if (atomic_xchg_acquire(&optimizer_state,
 			OPTIMIZER_ST_FLUSHING) != OPTIMIZER_ST_FLUSHING)
 			wake_up(&kprobe_optimizer_wait);
@@ -740,10 +880,43 @@ void wait_for_kprobe_optimizer(void)
 bool optprobe_queued_unopt(struct optimized_kprobe *op)
 {
 	struct optimized_kprobe *_op;
+	int i;
 
-	list_for_each_entry(_op, &unoptimizing_list, list) {
-		if (op == _op)
-			return true;
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		list_for_each_entry(_op, &optprobe_gens[i].unoptimizing_list, list) {
+			if (op == _op)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static bool optprobe_queued_freeing(struct optimized_kprobe *op)
+{
+	struct optimized_kprobe *_op;
+	int i;
+
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		list_for_each_entry(_op, &optprobe_gens[i].freeing_list, list) {
+			if (op == _op)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static bool optprobe_queued_cooling(struct optimized_kprobe *op)
+{
+	struct optimized_kprobe *_op;
+	int i;
+
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		list_for_each_entry(_op, &optprobe_gens[i].cooling_list, list) {
+			if (op == _op)
+				return true;
+		}
 	}
 
 	return false;
@@ -777,6 +950,15 @@ static void optimize_kprobe(struct kprobe *p)
 		}
 		return;
 	}
+
+	if (optprobe_queued_cooling(op)) {
+		/* Under in-flight unoptimization. It will be re-optimized upon finalize */
+		return;
+	}
+
+	if (optprobe_queued_freeing(op))
+		list_del_init(&op->list);
+
 	op->kp.flags |= KPROBE_FLAG_OPTIMIZED;
 
 	/*
@@ -786,7 +968,7 @@ static void optimize_kprobe(struct kprobe *p)
 	if (WARN_ON_ONCE(!list_empty(&op->list)))
 		return;
 
-	list_add(&op->list, &optimizing_list);
+	list_add(&op->list, &optprobe_gens[optprobe_cur_gen].optimizing_list);
 	kick_kprobe_optimizer();
 }
 
@@ -819,7 +1001,17 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 				 * in the freeing list for release afterwards.
 				 */
 				force_unoptimize_kprobe(op);
-				list_move(&op->list, &freeing_list);
+				list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
+				kick_kprobe_optimizer();
+			}
+		} else if (optprobe_queued_cooling(op)) {
+			if (force) {
+				/*
+				 * Already unoptimized, move to freeing list for
+				 * release afterwards.
+				 */
+				list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
+				kick_kprobe_optimizer();
 			}
 		} else {
 			/* Dequeue from the optimizing queue */
@@ -834,7 +1026,7 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 		/* Forcibly update the code: this is a special case */
 		force_unoptimize_kprobe(op);
 	} else {
-		list_add(&op->list, &unoptimizing_list);
+		list_add(&op->list, &optprobe_gens[optprobe_cur_gen].unoptimizing_list);
 		kick_kprobe_optimizer();
 	}
 }
@@ -866,23 +1058,27 @@ static void kill_optimized_kprobe(struct kprobe *p)
 	struct optimized_kprobe *op;
 
 	op = container_of(p, struct optimized_kprobe, kp);
-	if (!list_empty(&op->list))
-		/* Dequeue from the (un)optimization queue */
-		list_del_init(&op->list);
-	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-
-	if (kprobe_unused(p)) {
-		/*
-		 * Unused kprobe is on unoptimizing or freeing list. We move it
-		 * to freeing_list and let the kprobe_optimizer() remove it from
-		 * the kprobe hash list and free it.
-		 */
-		if (optprobe_queued_unopt(op))
-			list_move(&op->list, &freeing_list);
+	if (!list_empty(&op->list)) {
+		if (kprobe_unused(p)) {
+			if (optprobe_queued_unopt(op) || optprobe_queued_cooling(op)) {
+				list_move(&op->list, &optprobe_gens[optprobe_cur_gen].freeing_list);
+				kick_kprobe_optimizer();
+			} else if (!optprobe_queued_freeing(op)) {
+				list_del_init(&op->list);
+			}
+		} else {
+			list_del_init(&op->list);
+		}
 	}
+	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 
-	/* Don't touch the code, because it is already freed. */
-	arch_remove_optimized_kprobe(op);
+	/*
+	 * Don't remove the slot if it is queued for freeing or unoptimization;
+	 * the optimizer will reclaim it after the quiescence period.
+	 */
+	if (!optprobe_queued_freeing(op) && !optprobe_queued_unopt(op) &&
+	    !optprobe_queued_cooling(op))
+		arch_remove_optimized_kprobe(op);
 }
 
 static inline
@@ -1079,11 +1275,23 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 
 static void __init init_optprobe(void)
 {
+	int i;
+
 #ifdef __ARCH_WANT_KPROBES_INSN_SLOT
 	/* Init 'kprobe_optinsn_slots' for allocation */
 	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
 #endif
 
+	for (i = 0; i < OPTPROBE_GEN_MAX; i++) {
+		INIT_LIST_HEAD(&optprobe_gens[i].optimizing_list);
+		INIT_LIST_HEAD(&optprobe_gens[i].unoptimizing_list);
+		INIT_LIST_HEAD(&optprobe_gens[i].cooling_list);
+		INIT_LIST_HEAD(&optprobe_gens[i].freeing_list);
+		optprobe_gens[i].in_flight = false;
+		optprobe_gens[i].ready = false;
+	}
+	optprobe_cur_gen = 0;
+
 	init_waitqueue_head(&kprobe_optimizer_wait);
 	atomic_set(&optimizer_state, OPTIMIZER_ST_IDLE);
 	kprobe_optimizer_task = kthread_run(kprobe_optimizer_thread, NULL,

