Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7671DF986;
	Tue,  8 Oct 2024 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395572; cv=none; b=SSVFeNnHeMVRdZXqSnLBZ8dbVRqrzTzBozmzfl9mlnALO2oF2HGMS7+jQkFLEJ8Tw6bsFL6xh4HXX+yC3z51vgRKBhxteXjD0mztwU1rq4C1QBmAwUaW6FpY2doJYxuAzuNycguLmTVW+POdZUmsjkz7WvSn+s0qn6qc0wBTsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395572; c=relaxed/simple;
	bh=CqeorPBfn7xn4x4/jMKXIZM1tORejYC8CC1QTPI+6II=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZNrQULCv40Ox9vw2rWAVWsDB7vSByM/a0SkgclP3BltGbH+H8tiRSSK5nOIHV54uXva3vUgdLmpNCCKaAjl13mji4iIoZcQ7H6lWJrWLcekuEzsgWoMl4tlcUjVEW91GeMCRc1393BLvye+TGjVO/Sq3hWqFXnmQaIp27i25Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ep37mymW; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ep37mymW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728395562;
	bh=CqeorPBfn7xn4x4/jMKXIZM1tORejYC8CC1QTPI+6II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ep37mymW3evxObDnQSIt1sbxWRwIqCJEJg8zI5qZFOdnwyIF1lEeimU1x2fdW++2p
	 xoZNWi7AQXhawbbn7rEar3t/FN+BclKdleWla6J97d6X7/ubl8160zYpGkGqWbmGkM
	 e5CpAk8ILsjCM8zeRvxrcgxKYXWXMonmvkf8dnpd9/G1PP8t0aamSnOMbOs7NSOCAU
	 tXazdlfBc29XdllDSjZY/FXwkQCVrdXiIeIJepVGQSVYNfdFsWwa7Ey13CEXH/hKYE
	 VRK1DaPvw5XOh2AZdbfLY6MpSc3g/Ww1UYNQv1TZYv7D8clPnxK9IbH2T/ZJLhe/96
	 6kICSCx5z4QoQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNHXB3Lv8zLwW;
	Tue,  8 Oct 2024 09:52:42 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [RFC PATCH v3 3/4] hazptr: Implement Hazard Pointers
Date: Tue,  8 Oct 2024 09:50:33 -0400
Message-Id: <20241008135034.1982519-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com>
References: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This API provides existence guarantees of objects through Hazard
Pointers (hazptr). This minimalist implementation is specific to use
with preemption disabled, but can be extended further as needed.

Each hazptr domain defines a fixed number of hazard pointer slots
(nr_cpus) across the entire system.

Its main benefit over RCU is that it allows fast reclaim of
HP-protected pointers without needing to wait for a grace period.

It also allows the hazard pointer scan to call a user-defined callback
to retire a hazard pointer slot immediately if needed. This callback
may, for instance, issue an IPI to the relevant CPU.

There are a few possible use-cases for this in the Linux kernel:

  - Improve performance of mm_count by replacing lazy active mm by
    hazptr.
  - Guarantee object existence on pointer dereference to use refcount:
    - replace locking used for that purpose in some drivers,
    - replace RCU + inc_not_zero pattern,
  - rtmutex: Improve situations where locks need to be taken in
    reverse dependency chain order by guaranteeing existence of
    first and second locks in traversal order, allowing them to be
    locked in the correct order (which is reverse from traversal
    order) rather than try-lock+retry on nested lock.

References:

[1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
     lock-free objects," in IEEE Transactions on Parallel and
     Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004

Link: https://lore.kernel.org/lkml/j3scdl5iymjlxavomgc6u5ndg3svhab6ga23dr36o4f5mt333w@7xslvq6b6hmv/
Link: https://lpc.events/event/18/contributions/1731/
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
Changes since v0:
- Remove slot variable from hp_dereference_allocate().

Changes since v2:
- Address Peter Zijlstra's comments.
- Address Paul E. McKenney's comments.
---
 include/linux/hazptr.h | 165 +++++++++++++++++++++++++++++++++++++++++
 kernel/Makefile        |   2 +-
 kernel/hazptr.c        |  51 +++++++++++++
 3 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hazptr.h
 create mode 100644 kernel/hazptr.c

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
new file mode 100644
index 000000000000..f8e36d2bdc58
--- /dev/null
+++ b/include/linux/hazptr.h
@@ -0,0 +1,165 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+#ifndef _LINUX_HAZPTR_H
+#define _LINUX_HAZPTR_H
+
+/*
+ * HP: Hazard Pointers
+ *
+ * This API provides existence guarantees of objects through hazard
+ * pointers.
+ *
+ * It uses a fixed number of hazard pointer slots (nr_cpus) across the
+ * entire system for each hazard pointer domain.
+ *
+ * Its main benefit over RCU is that it allows fast reclaim of
+ * HP-protected pointers without needing to wait for a grace period.
+ *
+ * It also allows the hazard pointer scan to call a user-defined callback
+ * to retire a hazard pointer slot immediately if needed. This callback
+ * may, for instance, issue an IPI to the relevant CPU.
+ *
+ * References:
+ *
+ * [1]: M. M. Michael, "Hazard pointers: safe memory reclamation for
+ *      lock-free objects," in IEEE Transactions on Parallel and
+ *      Distributed Systems, vol. 15, no. 6, pp. 491-504, June 2004
+ */
+
+#include <linux/percpu.h>
+#include <linux/types.h>
+
+/*
+ * Hazard pointer slot.
+ */
+struct hazptr_slot {
+	void *addr;
+};
+
+struct hazptr_domain {
+	struct hazptr_slot __percpu *percpu_slots;
+};
+
+#define DECLARE_HAZPTR_DOMAIN(domain)					\
+	extern struct hazptr_domain domain
+
+#define DEFINE_HAZPTR_DOMAIN(domain)					\
+	static DEFINE_PER_CPU(struct hazptr_slot, __ ## domain ## _slots); \
+	struct hazptr_domain domain = {					\
+		.percpu_slots = &__## domain ## _slots,			\
+	}
+
+/*
+ * hazptr_scan: Scan hazard pointer domain for @addr.
+ *
+ * Scan hazard pointer domain for @addr.
+ * If @on_match_cb is NULL, wait to observe that each slot contains a value
+ * that differs from @addr.
+ * If @on_match_cb is non-NULL, invoke @on_match_cb for each slot containing
+ * @addr.
+ */
+void hazptr_scan(struct hazptr_domain *domain, void *addr,
+	     void (*on_match_cb)(int cpu, struct hazptr_slot *slot, void *addr));
+
+/*
+ * hazptr_try_protect: Try to protect with hazard pointer.
+ *
+ * Try to protect @addr with a hazard pointer slot. The object existence
+ * should be guaranteed by the caller. Expects to be called from preempt
+ * disable context.
+ *
+ * Returns true if protect succeeds, false otherwise.
+ * On success, if @_slot is not NULL, the protected hazptr slot is stored in @_slot.
+ */
+static inline
+bool hazptr_try_protect(struct hazptr_domain *hazptr_domain, void *addr, struct hazptr_slot **_slot)
+{
+	struct hazptr_slot __percpu *percpu_slots = hazptr_domain->percpu_slots;
+	struct hazptr_slot *slot;
+
+	if (!addr)
+		return false;
+	slot = this_cpu_ptr(percpu_slots);
+	/*
+	 * A single hazard pointer slot per CPU is available currently.
+	 * Other hazard pointer domains can eventually have a different
+	 * configuration.
+	 */
+	if (READ_ONCE(slot->addr))
+		return false;
+	WRITE_ONCE(slot->addr, addr);	/* Store B */
+	if (_slot)
+		*_slot = slot;
+	return true;
+}
+
+/*
+ * hazptr_load_try_protect: Load and try to protect with hazard pointer.
+ *
+ * Load @addr_p, and try to protect the loaded pointer with hazard
+ * pointers.
+ *
+ * Returns a protected address on success, NULL on failure. Expects to
+ * be called from preempt disable context.
+ *
+ * On success, if @_slot is not NULL, the protected hazptr slot is stored in @_slot.
+ */
+static inline
+void *__hazptr_load_try_protect(struct hazptr_domain *hazptr_domain,
+			 void * const * addr_p, struct hazptr_slot **_slot)
+{
+	struct hazptr_slot *slot;
+	void *addr, *addr2;
+
+	/*
+	 * Load @addr_p to know which address should be protected.
+	 */
+	addr = READ_ONCE(*addr_p);
+retry:
+	/* Try to protect the address by storing it into a slot. */
+	if (!hazptr_try_protect(hazptr_domain, addr, &slot))
+		return NULL;
+	/* Memory ordering: Store B before Load A. */
+	smp_mb();
+	/*
+	 * Re-load @addr_p after storing it to the hazard pointer slot.
+	 */
+	addr2 = READ_ONCE(*addr_p);	/* Load A */
+	/*
+	 * If @addr_p content has changed since the first load,
+	 * retire the hazard pointer and try again.
+	 */
+	if (!ptr_eq(addr2, addr)) {
+		WRITE_ONCE(slot->addr, NULL);
+		if (!addr2)
+			return NULL;
+		addr = addr2;
+		goto retry;
+	}
+	if (_slot)
+		*_slot = slot;
+	/*
+	 * Use addr2 loaded from the second READ_ONCE() to preserve
+	 * address dependency ordering.
+	 */
+	return addr2;
+}
+
+/*
+ * Use a comma expression within typeof: __typeof__((void)**(addr_p), *(addr_p))
+ * to generate a compile error if addr_p is not a pointer to a pointer.
+ */
+#define hazptr_load_try_protect(domain, addr_p, slot_p)	\
+	((__typeof__((void)**(addr_p), *(addr_p))) __hazptr_load_try_protect(domain, (void * const *) (addr_p), slot_p))
+
+/* Retire the protected hazard pointer from @slot. */
+static inline
+void hazptr_retire(struct hazptr_slot *slot, void *addr)
+{
+	WARN_ON_ONCE(slot->addr != addr);
+	smp_store_release(&slot->addr, NULL);
+}
+
+#endif /* _LINUX_HAZPTR_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..bf6ed81d5983 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    cpu.o exit.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o user.o \
 	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
-	    extable.o params.o \
+	    extable.o params.o hazptr.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
new file mode 100644
index 000000000000..3f9f14afbf1d
--- /dev/null
+++ b/kernel/hazptr.c
@@ -0,0 +1,51 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+/*
+ * hazptr: Hazard Pointers
+ */
+
+#include <linux/hazptr.h>
+#include <linux/percpu.h>
+
+/*
+ * hazptr_scan: Scan hazard pointer domain for @addr.
+ *
+ * Scan hazard pointer domain for @addr.
+ * If @on_match_cb is non-NULL, invoke @callback for each slot containing
+ * @addr.
+ * Wait to observe that each slot contains a value that differs from
+ * @addr before returning.
+ */
+void hazptr_scan(struct hazptr_domain *hazptr_domain, void *addr,
+	     void (*on_match_cb)(int cpu, struct hazptr_slot *slot, void *addr))
+{
+	struct hazptr_slot __percpu *percpu_slots = hazptr_domain->percpu_slots;
+	int cpu;
+
+	/* Should only be called from preemptible context. */
+	lockdep_assert_preemption_enabled();
+
+	/*
+	 * Store A precedes hazptr_scan(): it unpublishes addr (sets it to
+	 * NULL or to a different value), and thus hides it from hazard
+	 * pointer readers.
+	 */
+	if (!addr)
+		return;
+	/* Memory ordering: Store A before Load B. */
+	smp_mb();
+	/* Scan all CPUs slots. */
+	for_each_possible_cpu(cpu) {
+		struct hazptr_slot *slot = per_cpu_ptr(percpu_slots, cpu);
+
+		if (on_match_cb) {
+			if (smp_load_acquire(&slot->addr) == addr)	/* Load B */
+				on_match_cb(cpu, slot, addr);
+		} else {
+			/* Busy-wait if node is found. */
+			smp_cond_load_acquire(&slot->addr, VAL != addr); /* Load B */
+		}
+	}
+}
-- 
2.39.2

