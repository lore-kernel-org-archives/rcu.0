Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B46824BD;
	Sun, 22 Sep 2024 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727000472; cv=none; b=B0fVaBQ6Y6DoOADZrNAZXKskoZZe5EYrTGE9bttZ3YYbdjog7sgYlFvx8M5KdsIGw4scybZmBEo3Qi7BAmlXfaylwVDjsJm9HceiVDAohxiomh1Ris/5tXYWOGI7T61aKmHqJ5wXSMI4EmSdCL6nhPb4Tpx5qLc9ZjLRCJMwU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727000472; c=relaxed/simple;
	bh=AqutN8Rp4xr64uA7iGd20GtzJ3zFhQeFxEf1rQBQiq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AkV9e6AGZ5pUlGrDwiLMDkP8tC396hrTJWsVD7UiMBW2f1DbbQFcegiQnZi96ntKHN1HiXZ1hG/7TscfjnAeq9g/uxoqgQbD4g/6Ios5v5GRnBlg2qN1+unsTW3r6g29YLJb5vncX9/mz2UzW/cYC2ab3/S6R2Vq88AnVWV3IWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=w6B+oLdh; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="w6B+oLdh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727000468;
	bh=AqutN8Rp4xr64uA7iGd20GtzJ3zFhQeFxEf1rQBQiq0=;
	h=From:To:Cc:Subject:Date:From;
	b=w6B+oLdhJxQedXSkAVG8HuyPsrQqfuiZYnbPPj1bKrnXW8EPz7uipzzNnAFh997jw
	 6/MWJJ9tH9YIPcUAinYtJ4Xqs0ZWq2U/O9ErDWpDRiLv9qoEv33GyOZO8ROSELKc+G
	 4HOMqZpJrs48pPX6Zbv5AEZu6YSPVx8qvdDZ9x6KogDonC/QX5V8e4z6pKbB6AVAIU
	 ZdVdmZwkkaISVMKrEyazff+Ny3LOvO4HuaQxdvxarAU9/Fxor8dKo1IWJo2UmPeDyJ
	 bN4EDR56Sgrzq5dmHsIG/aVxNa9Y4N92FlW4tdUISdYz0Tb/8mFq/qabIJe3My2lwk
	 nx/nf18WBmXtg==
Received: from thinkos.internal.efficios.com (ip148.ip-54-37-222.eu [54.37.222.148])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XBMbD2lXHz1LkR;
	Sun, 22 Sep 2024 06:20:56 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
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
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [RFC PATCH v1 1/1] hpref: Hazard Pointers with Reference Counter
Date: Sun, 22 Sep 2024 12:20:02 +0200
Message-Id: <20240922102002.321008-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Boqun Feng's patch series and LPC talk gave me a few ideas I wanted to
try. I figured we could improve the concept of reference counters by
adding a hazard-pointer protected fast-path to them.

This API combines hazard pointers and reference counters.
It uses hazard pointers as fast-paths, and falls back to reference
counters either explicitly when the reader expects to hold the object
for a long time, or when no hazard pointer slots are available.

This prototype is implemented in userspace within the liburcu project,
and depends on librseq for per-cpu data structure allocation, indexing,
and updates.

- The top of this liburcu feature branch can be found at:
  https://github.com/compudj/userspace-rcu-dev/tree/hpref
  (it's implemented within liburcu for convenience, but it does
  not actually use RCU).

- librseq can be found at:
  https://git.kernel.org/pub/scm/libs/librseq/librseq.git/

This leverages the fact that both synchronization mechanisms aim to
guarantee existence of objects, and those existence guarantees can be
chained. Each mechanism achieves its purpose in a different way with
different tradeoffs. The hazard pointers are faster to read and scale
better than reference counters, but they consume more memory than a
per-object reference counter.

The fall-back to reference counter allows bounding the number of
hazard pointer slots to a fixed size for the entire system:
nr_cpus * N, where N=8 as it fills a single 64 bytes cache line on
64-bit architectures.

Porting it to the Linux kernel should be straightforward. We might
want to pick heavily contented reference counts such as the mm_struct
mm_count field as a starting point to see if it provides significant
performance gains.

The hpref read-side performs well even compared to RCU in my benchmarks:

    Results:

    CPU(s):                  16
      On-line CPU(s) list:   0-15
    Vendor ID:               AuthenticAMD
      Model name:            AMD Ryzen 7 PRO 6850U with Radeon Graphics

    8 readers, 1 writer, 10s

    test_rwlock                               nr_reads    190461165 nr_writes           12 nr_ops    190461177
    test_mutex                                nr_reads    248594205 nr_writes     26088306 nr_ops    274682511
    test_urcu_mb         (smp_mb)             nr_reads    829829784 nr_writes     18057836 nr_ops    847887620
    test_perthreadlock                        nr_reads   1623365032 nr_writes      1244814 nr_ops   1624609846
    test_hpref_benchmark (smp_mb)             nr_reads   1994298193 nr_writes     22293162 nr_ops   2016591355
    test_hpref_benchmark (barrier/membarrier) nr_reads  15208690879 nr_writes      1893785 nr_ops  15210584664
    test_urcu_bp         (barrier/membarrier) nr_reads  20242102863 nr_writes       599484 nr_ops  20242702347
    test_urcu            (barrier/membarrier) nr_reads  20714490759 nr_writes       782045 nr_ops  20715272804
    test_urcu_qsbr                            nr_reads  40774708959 nr_writes      3512904 nr_ops  40778221863

References:

[1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
     lock-free objects," in IEEE Transactions on Parallel and
     Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004

Link: https://lore.kernel.org/lkml/j3scdl5iymjlxavomgc6u5ndg3svhab6ga23dr36o4f5mt333w@7xslvq6b6hmv/
Link: https://lpc.events/event/18/contributions/1731/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Change-Id: I6369064a0e1a1f9632394df31ff41c76905d17e3
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev
---
Changes since v0:
- Re-load cpu and cpu_slots when rseq critical section aborts,
- Remove the notion of "current_slot" hint from the hpref_hp_get
  fast-path. Just try all slots instead. Removing this counter
  management improves performance of the fast path by about 50%.
---
 include/urcu/hpref.h | 229 +++++++++++++++++++++++++++++++++++++++++++
 src/Makefile.am      |   6 +-
 src/hpref.c          |  78 +++++++++++++++
 3 files changed, 312 insertions(+), 1 deletion(-)
 create mode 100644 include/urcu/hpref.h
 create mode 100644 src/hpref.c

diff --git a/include/urcu/hpref.h b/include/urcu/hpref.h
new file mode 100644
index 00000000..34f2bb9b
--- /dev/null
+++ b/include/urcu/hpref.h
@@ -0,0 +1,229 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+#ifndef _URCU_HPREF_H
+#define _URCU_HPREF_H
+
+/*
+ * HPREF: Hazard pointers with reference counters
+ *
+ * This API combines hazard pointers and reference counters.
+ * It uses hazard pointers as fast-paths, and fall-back to reference
+ * counters either explicitly when the reader expects to hold the object
+ * for a long time, or when no hazard pointer slots are available.
+ *
+ * This leverages the fact that both synchronization mechanisms aim to
+ * guarantee existence of objects, and those existence guarantees can be
+ * chained. Each mechanism achieves its purpose in a different way with
+ * different tradeoffs. The hazard pointers are faster to read and scale
+ * better than reference counters, but they consume more memory than a
+ * per-object reference counter.
+ *
+ * The fall-back to reference counter allows bounding the number of
+ * hazard pointer slots to a fixed size for the entire system:
+ * nr_cpus * N, where N=8 as it fills a single 64 bytes cache line on
+ * 64-bit architectures.
+ *
+ * References:
+ *
+ * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
+ *      lock-free objects," in IEEE Transactions on Parallel and
+ *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <rseq/mempool.h>	/* Per-CPU memory */
+#include <rseq/rseq.h>
+
+#include <urcu/ref.h>
+#include <urcu/uatomic.h>
+#include <urcu/compiler.h>
+
+struct hpref_node {
+	struct urcu_ref refcount;
+	void (*release)(struct hpref_node *node);
+};
+
+struct hpref_slot {
+	/* Use rseq to set from reader only if zero. */
+	struct hpref_node *node;
+};
+
+#define NR_PERCPU_SLOTS_BITS	3
+#define HPREF_NR_PERCPU_SLOTS	(1U << NR_PERCPU_SLOTS_BITS)
+/*
+ * The emergency slot is only used for short critical sections
+ * (would be preempt off in when porting this code to the kernel): only
+ * to ensure we have a free slot for taking a reference count as
+ * fallback.
+ */
+#define HPREF_EMERGENCY_SLOT	(HPREF_NR_PERCPU_SLOTS - 1)
+
+struct hpref_percpu_slots {
+	struct hpref_slot slots[HPREF_NR_PERCPU_SLOTS];
+};
+
+enum hpref_type {
+	HPREF_TYPE_HP,
+	HPREF_TYPE_REF,
+};
+
+struct hpref_ctx {
+	struct hpref_slot *slot;
+	struct hpref_node *hp;
+	enum hpref_type type;
+};
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+extern struct hpref_percpu_slots *hpref_percpu_slots;
+
+void hpref_release(struct urcu_ref *ref);
+
+/*
+ * hpref_synchronize: Wait for any reader possessing a hazard pointer to
+ *                    @node to clear its hazard pointer slot.
+ */
+void hpref_synchronize(struct hpref_node *node);
+
+/*
+ * hpref_synchronize_put: Wait for any reader possessing a hazard
+ *                        pointer to clear its slot and put reference
+ *                        count.
+ */
+void hpref_synchronize_put(struct hpref_node *node);
+
+static inline
+void hpref_node_init(struct hpref_node *node,
+		void (*release)(struct hpref_node *node))
+{
+	urcu_ref_init(&node->refcount);
+	node->release = release;
+}
+
+/*
+ * hpref_promote_hp_to_ref: Promote hazard pointer to reference count.
+ */
+static inline
+void hpref_promote_hp_to_ref(struct hpref_ctx *ctx)
+{
+	if (ctx->type == HPREF_TYPE_REF)
+		return;
+	urcu_ref_get(&ctx->hp->refcount);
+	uatomic_store(&ctx->slot->node, NULL, CMM_RELEASE);
+	ctx->slot = NULL;
+	ctx->type = HPREF_TYPE_REF;
+}
+
+/*
+ * hpref_hp_get: Obtain a reference to a stable object, protected either
+ *               by hazard pointer (fast-path) or using reference
+ *               counter as fall-back.
+ */
+static inline
+bool hpref_hp_get(struct hpref_node **node_p, struct hpref_ctx *ctx)
+{
+	int cpu = rseq_current_cpu_raw(), ret;
+	struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
+	struct hpref_node *node, *node2;
+	struct hpref_slot *slot;
+	unsigned int slot_nr;
+
+	node = uatomic_load(node_p, CMM_RELAXED);
+	if (!node)
+		return false;
+retry:
+	for (slot_nr = 0; slot_nr < HPREF_NR_PERCPU_SLOTS; /* inc in loop. */) {
+		slot = &cpu_slots->slots[slot_nr];
+		/* Use rseq to try setting slot hp. Store B. */
+		ret = rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
+					(intptr_t *) &slot->node, (intptr_t) NULL,
+					(intptr_t) node, cpu);
+		if (!ret)
+			break;	/* Success. */
+		if (ret < 0) {
+			/*
+			 * Abort due to preemption/migration/signal
+			 * delivery or CPU number mismatch.
+			 */
+			cpu = rseq_current_cpu_raw();
+			cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
+		}
+		if (slot_nr == HPREF_EMERGENCY_SLOT) {
+			/*
+			 * This may busy-wait for another reader using the
+			 * emergency slot to transition to refcount.
+			 */
+			caa_cpu_relax();
+		} else {
+			slot_nr++;
+		}
+		goto retry;
+	}
+	/* Memory ordering: Store B before Load A. */
+	cmm_smp_mb();
+	node2 = uatomic_load(node_p, CMM_RELAXED);	/* Load A */
+	/*
+	 * If @node_p content has changed since the first load,
+	 * clear the hazard pointer and try again.
+	 */
+	if (node != node2) {
+		uatomic_store(&slot->node, NULL, CMM_RELAXED);
+		if (!node2)
+			return false;
+		node = node2;
+		goto retry;
+	}
+	ctx->type = HPREF_TYPE_HP;
+	ctx->hp = node;
+	ctx->slot = slot;
+	if (slot_nr == HPREF_EMERGENCY_SLOT)
+		hpref_promote_hp_to_ref(ctx);
+	return true;
+}
+
+static inline
+void hpref_put(struct hpref_ctx *ctx)
+{
+	if (ctx->type == HPREF_TYPE_REF) {
+		urcu_ref_put(&ctx->hp->refcount, hpref_release);
+	} else {
+		/* Release HP. */
+		uatomic_store(&ctx->slot->node, NULL, CMM_RELEASE);
+	}
+	ctx->hp = NULL;
+}
+
+/*
+ * hpref_set_pointer: Store pointer @node to @ptr, with RCU publication
+ *                    guarantees.
+ */
+static inline
+void hpref_set_pointer(struct hpref_node **ptr, struct hpref_node *node)
+{
+	if (__builtin_constant_p(node) && node == NULL)
+		uatomic_store(ptr, NULL, CMM_RELAXED);
+	else
+		uatomic_store(ptr, node, CMM_RELEASE);
+}
+
+/*
+ * Return the content of the hpref context hazard pointer field.
+ */
+static inline
+struct hpref_node *hpref_ctx_pointer(struct hpref_ctx *ctx)
+{
+	return ctx->hp;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _URCU_HPREF_H */
diff --git a/src/Makefile.am b/src/Makefile.am
index b555c818..7312c9f7 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -19,7 +19,8 @@ RCULFHASH = rculfhash.c rculfhash-mm-order.c rculfhash-mm-chunk.c \
 lib_LTLIBRARIES = liburcu-common.la \
 		liburcu.la liburcu-qsbr.la \
 		liburcu-mb.la liburcu-bp.la \
-		liburcu-memb.la liburcu-cds.la
+		liburcu-memb.la liburcu-cds.la \
+		liburcu-hpref.la
 
 #
 # liburcu-common contains wait-free queues (needed by call_rcu) as well
@@ -50,6 +51,9 @@ liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c lfstack.c \
 	workqueue.c workqueue.h $(RCULFHASH) $(COMPAT)
 liburcu_cds_la_LIBADD = liburcu-common.la
 
+liburcu_hpref_la_SOURCES = hpref.c
+liburcu_hpref_la_LIBADD = -lrseq
+
 pkgconfigdir = $(libdir)/pkgconfig
 pkgconfig_DATA = liburcu-cds.pc liburcu.pc liburcu-bp.pc liburcu-qsbr.pc \
 	liburcu-mb.pc liburcu-memb.pc
diff --git a/src/hpref.c b/src/hpref.c
new file mode 100644
index 00000000..f63530f5
--- /dev/null
+++ b/src/hpref.c
@@ -0,0 +1,78 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+/*
+ * HPREF: Hazard pointers with reference counters
+ */
+
+#define _LGPL_SOURCE
+#include <urcu/hpref.h>
+#include <rseq/mempool.h>	/* Per-CPU memory */
+
+static struct rseq_mempool *mempool;
+struct hpref_percpu_slots *hpref_percpu_slots;
+
+void hpref_release(struct urcu_ref *ref)
+{
+	struct hpref_node *node = caa_container_of(ref, struct hpref_node, refcount);
+
+	node->release(node);
+}
+
+/*
+ * hpref_synchronize: Wait for any reader possessing a hazard pointer to
+ *                    @node to clear its hazard pointer slot.
+ */
+void hpref_synchronize(struct hpref_node *node)
+{
+	int nr_cpus = rseq_get_max_nr_cpus(), cpu;
+
+	/* Memory ordering: Store A before Load B. */
+	cmm_smp_mb();
+	/* Scan all CPUs slots. */
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
+		struct hpref_slot *slot;
+		unsigned int i;
+
+		for (i = 0; i < HPREF_NR_PERCPU_SLOTS; i++) {
+			slot = &cpu_slots->slots[i];
+			/* Busy-wait if node is found. */
+			while (uatomic_load(&slot->node, CMM_ACQUIRE) == node)	/* Load B */
+				caa_cpu_relax();
+		}
+	}
+}
+
+/*
+ * hpref_synchronize_put: Wait for any reader possessing a hazard
+ *                        pointer to clear its slot and put reference
+ *                        count.
+ */
+void hpref_synchronize_put(struct hpref_node *node)
+{
+	if (!node)
+		return;
+	hpref_synchronize(node);
+	urcu_ref_put(&node->refcount, hpref_release);
+}
+
+static __attribute__((constructor))
+void hpref_init(void)
+{
+	mempool = rseq_mempool_create("hpref", sizeof(struct hpref_percpu_slots), NULL);
+	if (!mempool)
+		abort();
+	hpref_percpu_slots = rseq_mempool_percpu_zmalloc(mempool);
+	if (!hpref_percpu_slots)
+		abort();
+}
+
+static __attribute__((destructor))
+void hpref_exit(void)
+{
+	rseq_mempool_percpu_free(hpref_percpu_slots);
+	if (rseq_mempool_destroy(mempool))
+		abort();
+}
-- 
2.39.2

