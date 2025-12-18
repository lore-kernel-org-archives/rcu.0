Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED12571A0;
	Thu, 18 Dec 2025 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022347; cv=none; b=JfUlZLSUY9mn+ejXPfVYI6n01H4FhD9RVxge7QVtR5mnknKriohccew1dGXlnphgxeOjorSBunCFZ1dtR3zj+kRE1enG9V585WZMjE/vBg/ym2Sfkm2WisTWQhnP0rd517oAWev8XgzY0fju8FoZ+3JcGJRhRtHJPe3aLXQoWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022347; c=relaxed/simple;
	bh=81GUwMmOGrOdD48FTUhICmsPzgG46DFE7z/rVAnWpj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJTPsBo6J7C78iA151EugSX7iZCUAahcT20LXE4akfV+Vo8hKBR/s1iekQPsF6K2txQZKUopva2DFkM/ADU45SbHAFIkMfu52hj7wd3HMKPBct4FqtDW93BEO9kI6ig9lwAzr7S8+v0xMRloLfd58ywyHimedp7YJwzV9o9fXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tQgevJyi; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tQgevJyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766022336;
	bh=9mSE4uUm9QS4jRnuJO07Nb3CIxXoe5LmkyYDXf5sG1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQgevJyisveTrRgflVsn9F23xBqLaYd8su86QGOgWYc6y/bPRR+jBhxTqD1xk01EZ
	 VDGPvvdDHa1jH6Oq0H+tHvVCeNOShHKxLjIKrs/4IkJfyDqYnhJuw392PD9liZvDXj
	 1l3JcSKa2qwXp4rt8G4UMSD9fiqPjjovHiCB3ZoZBKlGFTAzqOkvw0WkNJIAxUaU9+
	 rTfJ9pwLZ0/DjK9V/7zvdyfdieMFaOZykf8/vfEWMfYmYyodmUhFf0Ac1+N91+KkeS
	 6ZPIAutnM/M7RMO6Sl9HJiKarwuPRUINiT20os+vZaPTjifTJFVozsXoeCVHoLWm8F
	 4Cym1xOrXmnqA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:a253:d09e:90e7:323f])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dWtm03TRdzbqP;
	Wed, 17 Dec 2025 20:45:36 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [RFC PATCH v4 4/4] hazptr: Migrate per-CPU slots to backup slot on context switch
Date: Wed, 17 Dec 2025 20:45:31 -0500
Message-Id: <20251218014531.3793471-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
References: <20251218014531.3793471-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate with the scheduler to migrate per-CPU slots to the backup slot
on context switch. This ensures that the per-CPU slots won't be used by
blocked or preempted tasks holding on hazard pointers for a long time.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: maged.michael@gmail.com
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev
---
 include/linux/hazptr.h | 63 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/sched.h  |  4 +++
 init/init_task.c       |  3 ++
 kernel/Kconfig.preempt | 10 +++++++
 kernel/fork.c          |  3 ++
 kernel/sched/core.c    |  2 ++
 6 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 70c066ddb0f5..10ac53a42a7a 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/types.h>
 #include <linux/cleanup.h>
+#include <linux/sched.h>
 
 /* 8 slots (each sizeof(void *)) fit in a single cache line. */
 #define NR_HAZPTR_PERCPU_SLOTS	8
@@ -46,6 +47,9 @@ struct hazptr_ctx {
 	struct hazptr_slot *slot;
 	/* Backup slot in case all per-CPU slots are used. */
 	struct hazptr_backup_slot backup_slot;
+#ifdef CONFIG_PREEMPT_HAZPTR
+	struct list_head preempt_node;
+#endif
 };
 
 struct hazptr_percpu_slots {
@@ -98,6 +102,50 @@ bool hazptr_slot_is_backup(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
 	return slot == &ctx->backup_slot.slot;
 }
 
+#ifdef CONFIG_PREEMPT_HAZPTR
+static inline
+void hazptr_chain_task_ctx(struct hazptr_ctx *ctx)
+{
+	list_add(&ctx->preempt_node, &current->hazptr_ctx_list);
+}
+
+static inline
+void hazptr_unchain_task_ctx(struct hazptr_ctx *ctx)
+{
+	list_del(&ctx->preempt_node);
+}
+
+static inline
+void hazptr_note_context_switch(void)
+{
+	struct hazptr_ctx *ctx;
+
+	list_for_each_entry(ctx, &current->hazptr_ctx_list, preempt_node) {
+		struct hazptr_slot *slot;
+
+		if (hazptr_slot_is_backup(ctx, ctx->slot))
+			continue;
+		slot = hazptr_chain_backup_slot(ctx);
+		/*
+		 * Move hazard pointer from per-CPU slot to backup slot.
+		 * This requires hazard pointer synchronize to iterate
+		 * on per-CPU slots with load-acquire before iterating
+		 * on the overflow list.
+		 */
+		WRITE_ONCE(slot->addr, ctx->slot->addr);
+		/*
+		 * store-release orders store to backup slot addr before
+		 * store to per-CPU slot addr.
+		 */
+		smp_store_release(&ctx->slot->addr, NULL);
+	}
+}
+#else
+static inline void hazptr_chain_task_ctx(struct hazptr_ctx *ctx) { }
+static inline void hazptr_unchain_task_ctx(struct hazptr_ctx *ctx) { }
+static inline void hazptr_note_context_switch(void) { }
+#endif
+
 /*
  * hazptr_acquire: Load pointer at address and protect with hazard pointer.
  *
@@ -114,6 +162,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
 	struct hazptr_slot *slot = NULL;
 	void *addr, *addr2;
 
+	ctx->slot = NULL;
 	/*
 	 * Load @addr_p to know which address should be protected.
 	 */
@@ -121,7 +170,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
 	for (;;) {
 		if (!addr)
 			return NULL;
+
 		guard(preempt)();
+		hazptr_chain_task_ctx(ctx);
 		if (likely(!hazptr_slot_is_backup(ctx, slot))) {
 			slot = hazptr_get_free_percpu_slot();
 			/*
@@ -140,8 +191,11 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
 		 * Re-load @addr_p after storing it to the hazard pointer slot.
 		 */
 		addr2 = READ_ONCE(*addr_p);	/* Load A */
-		if (likely(ptr_eq(addr2, addr)))
+		if (likely(ptr_eq(addr2, addr))) {
+			ctx->slot = slot;
+			/* Success. Break loop, enable preemption and return. */
 			break;
+		}
 		/*
 		 * If @addr_p content has changed since the first load,
 		 * release the hazard pointer and try again.
@@ -150,11 +204,14 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const * addr_p)
 		if (!addr2) {
 			if (hazptr_slot_is_backup(ctx, slot))
 				hazptr_unchain_backup_slot(ctx);
+			hazptr_unchain_task_ctx(ctx);
+			/* Loaded NULL. Enable preemption and return NULL. */
 			return NULL;
 		}
 		addr = addr2;
+		hazptr_unchain_task_ctx(ctx);
+		/* Enable preemption and retry. */
 	}
-	ctx->slot = slot;
 	/*
 	 * Use addr2 loaded from the second READ_ONCE() to preserve
 	 * address dependency ordering.
@@ -170,11 +227,13 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 
 	if (!addr)
 		return;
+	guard(preempt)();
 	slot = ctx->slot;
 	WARN_ON_ONCE(slot->addr != addr);
 	smp_store_release(&slot->addr, NULL);
 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
 		hazptr_unchain_backup_slot(ctx);
+	hazptr_unchain_task_ctx(ctx);
 }
 
 void hazptr_init(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b469878de25c..bbec9fd6b163 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -933,6 +933,10 @@ struct task_struct {
 	struct rcu_node			*rcu_blocked_node;
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_PREEMPT_HAZPTR
+	struct list_head		hazptr_ctx_list;
+#endif
+
 #ifdef CONFIG_TASKS_RCU
 	unsigned long			rcu_tasks_nvcsw;
 	u8				rcu_tasks_holdout;
diff --git a/init/init_task.c b/init/init_task.c
index a55e2189206f..117aebf5573a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -160,6 +160,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.rcu_node_entry = LIST_HEAD_INIT(init_task.rcu_node_entry),
 	.rcu_blocked_node = NULL,
 #endif
+#ifdef CONFIG_PREEMPT_HAZPTR
+	.hazptr_ctx_list = LIST_HEAD_INIT(init_task.hazptr_ctx_list),
+#endif
 #ifdef CONFIG_TASKS_RCU
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index da326800c1c9..beb351b42b7c 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -189,3 +189,13 @@ config SCHED_CLASS_EXT
 	  For more information:
 	    Documentation/scheduler/sched-ext.rst
 	    https://github.com/sched-ext/scx
+
+config PREEMPT_HAZPTR
+	bool "Move Hazard Pointers to Task Slots on Context Switch"
+	help
+	  Integrate hazard pointers with the scheduler so the active
+	  hazard pointers using preallocated per-CPU slots are moved to
+	  their context local slot on context switch. This prevents
+	  blocked or preempted tasks to hold on to per-CPU slots for
+	  a long time, which would cause higher overhead for short
+	  hazard pointer critical sections.
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..35c810fe744e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1780,6 +1780,9 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_blocked_node = NULL;
 	INIT_LIST_HEAD(&p->rcu_node_entry);
 #endif /* #ifdef CONFIG_PREEMPT_RCU */
+#ifdef CONFIG_PREEMPT_HAZPTR
+	INIT_LIST_HEAD(&p->hazptr_ctx_list);
+#endif /* #ifdef CONFIG_PREEMPT_HAZPTR */
 #ifdef CONFIG_TASKS_RCU
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f754a60de848..ac8bf2708140 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -60,6 +60,7 @@
 #include <linux/profile.h>
 #include <linux/psi.h>
 #include <linux/rcuwait_api.h>
+#include <linux/hazptr.h>
 #include <linux/rseq.h>
 #include <linux/sched/wake_q.h>
 #include <linux/scs.h>
@@ -6812,6 +6813,7 @@ static void __sched notrace __schedule(int sched_mode)
 
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
+	hazptr_note_context_switch();
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
-- 
2.39.5

