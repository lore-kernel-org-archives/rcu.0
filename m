Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372601547DA;
	Sat, 21 Sep 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937394; cv=none; b=e0gkt0euEMpkemQGT7SKWLjuZnrtxR+FH2yjKmHtvHzLCxKSYvHnDIKFIA0dHLEFDArlmzOx4hosgk3jvxtyAgDImQBUGJucY1Dc/gpGhnVKRpSWLchY7r0YrL7A/25ebPI6I6tEj/6s8as0weezY8TQ6yOCaP2htxY913fOM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937394; c=relaxed/simple;
	bh=fLocS4rkXo+cdkcTNrdh1/o+NMlSqRy+YLYt+PO+GGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RByJiRYR0S2yRYwNHA10fSKjl1Frzhq3uNiAXikiJO/T8piisYJqi1d/iGXkdqzEmtuxkbtv8m095qxMPBcDVrl0DIuiDlZ47tNBdZSA1xS3koPkQH+g2HNU7SRJ3dRXNo9YNuc+fpeZAmOFG2b32MfDNH/NZVqk+BYjn6G7iH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ocGVMENa; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ocGVMENa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1726936994;
	bh=fLocS4rkXo+cdkcTNrdh1/o+NMlSqRy+YLYt+PO+GGQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ocGVMENak0htCIEdzZaI6MH19tiedl9wKo4gdrjhKDrnYGSWc++fA77KsvqvX25Ua
	 7Dw1e6ZEqfbavp5f1Es4SuWNiVwLivyYEVuNR/CNEIfYP032LbVFz9qgxlNkMYvZM1
	 RYOY+uykGq9SSX07SsRILAtj+KoB9W/fi6exnFSuSvdBTOYv+bm2vlikqLC9xOxNdg
	 JxCcLP+4NGl2lqgL3wu7N8HSW1k7p745xFArmc6H3sKKxEwe+WhOoLW/IoJJ8tG6je
	 u2jmWs1shIxWSQpB2qVg6Mjkrt2kYK37OiMBqqLAJgTMgvqabvQqgeEpTqe7VNzEVY
	 EWMinWrtdwtsQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4X9w6f0QLxz1LVV;
	Sat, 21 Sep 2024 12:43:05 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
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
Subject: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
Date: Sat, 21 Sep 2024 18:42:10 +0200
Message-Id: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
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

    test_urcu_mb         (smp_mb)             nr_reads    829829784 nr_writes     18057836 nr_ops    847887620
    test_hpref_benchmark (smp_mb)             nr_reads   2040376076 nr_writes      2993246 nr_ops   2043369322
    test_hpref_benchmark (barrier/membarrier) nr_reads  10609164704 nr_writes      2208432 nr_ops  10611373136
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
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
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
 include/urcu/hpref.h | 222 +++++++++++++++++++++++++++++++++++++++++++
 src/Makefile.am      |   6 +-
 src/hpref.c          |  78 +++++++++++++++
 3 files changed, 305 insertions(+), 1 deletion(-)
 create mode 100644 include/urcu/hpref.h
 create mode 100644 src/hpref.c

diff --git a/include/urcu/hpref.h b/include/urcu/hpref.h
new file mode 100644
index 00000000..300f7d4e
--- /dev/null
+++ b/include/urcu/hpref.h
@@ -0,0 +1,222 @@
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
+	unsigned int current_slot;
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
+	int cpu = rseq_current_cpu_raw();
+	struct hpref_percpu_slots *cpu_slots = rseq_percpu_ptr(hpref_percpu_slots, cpu);
+	struct hpref_slot *slot = &cpu_slots->slots[cpu_slots->current_slot];
+	bool use_refcount = false;
+	struct hpref_node *node, *node2;
+	unsigned int next_slot;
+
+retry:
+	node = uatomic_load(node_p, CMM_RELAXED);
+	if (!node)
+		return false;
+	/* Use rseq to try setting current slot hp. Store B. */
+	if (rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
+				(intptr_t *) &slot->node, (intptr_t) NULL,
+				(intptr_t) node, cpu)) {
+		slot = &cpu_slots->slots[HPREF_EMERGENCY_SLOT];
+		use_refcount = true;
+		/*
+		 * This may busy-wait for another reader using the
+		 * emergency slot to transition to refcount.
+		 */
+		caa_cpu_relax();
+		goto retry;
+	}
+	/* Memory ordering: Store B before Load A. */
+	cmm_smp_mb();
+	node2 = uatomic_load(node_p, CMM_RELAXED);	/* Load A */
+	if (node != node2) {
+		uatomic_store(&slot->node, NULL, CMM_RELAXED);
+		if (!node2)
+			return false;
+		goto retry;
+	}
+	ctx->type = HPREF_TYPE_HP;
+	ctx->hp = node;
+	ctx->slot = slot;
+	if (use_refcount) {
+		hpref_promote_hp_to_ref(ctx);
+		return true;
+	}
+	/*
+	 * Increment current slot (racy increment is OK because it is
+	 * just a position hint). Skip the emergency slot.
+	 */
+	next_slot = uatomic_load(&cpu_slots->current_slot, CMM_RELAXED) + 1;
+	if (next_slot >= HPREF_EMERGENCY_SLOT)
+		next_slot = 0;
+	uatomic_store(&cpu_slots->current_slot, next_slot, CMM_RELAXED);
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

