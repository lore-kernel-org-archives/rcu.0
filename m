Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D31FC8;
	Wed,  2 Oct 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831090; cv=none; b=WjtgKBptCGuLC/tKP2sofgaW+HmCP2uNUS4f/JCJ3JIb1ndgFHiraIt+b9+qa0po1en75DZoHzdTI+mOmIEJws+wKPD5ytH4KElqccUy0OCymEP6BNEVDKEqac3y+1TZ5QtNWeKsKokngKFjIJJklDdC1WCdeHDV7yCwQCXbeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831090; c=relaxed/simple;
	bh=YpbszxPGSpf5EjU2PeRKfD+htiAvIE0R8ZYJQ/cohsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a3F54aYFl28vdIQvLSzOsg9Xr43StYTlY5bxrzq2fXm7HuwqLnGJfNeQRTWobZqQni2E7H2CwhfprG/JPKoP05dQZdUfChIsGpfhRc8Qp4rWhqb8jEwNHpC+Sc+EdZND/AJjyehY+rlPAWbtq4w9ZkQKu6JmHqTdcBnz7vINsY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XncHOzB1; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XncHOzB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727831080;
	bh=YpbszxPGSpf5EjU2PeRKfD+htiAvIE0R8ZYJQ/cohsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XncHOzB1ONmQdzo1CB6cDxvEeibW7m6gIOfIsJN79bRDRsVr/1W6+xQ8cu7+188fh
	 yGWbXG7QwcT+NOta8ICmSr6WVbmtMwOdoyjTz1jrOML2BIsdUEkqEZGycHFzIvpwog
	 6pZ25Vygfk+mDNfoaU4BTQzgKc4FDcCoTJF9zZWrJ2E9QhMuDgpJSL78H5eQEyaNVm
	 L1vZVHILlCgU/IF2UgR10te5GEB0WtBUM8PZd1AyvlwokiY0dWqus6U6wwF1vB5ee0
	 SHFAVY5FRF7TMlsPgZqiNE8bJGZJBmIKRuqoR0lz+n1Dbj7qyEXeOMfMhR/KQ2f9tM
	 J2ek7gvRKsE3Q==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XJGmm40c6zjRK;
	Tue,  1 Oct 2024 21:04:40 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
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
Subject: [RFC PATCH 3/4] hp: Implement Hazard Pointers
Date: Tue,  1 Oct 2024 21:02:04 -0400
Message-Id: <20241002010205.1341915-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This API provides existence guarantees of objects through Hazard
Pointers (HP).

Each HP domain defines a fixed number of hazard pointer slots (nr_cpus)
across the entire system.

Its main benefit over RCU is that it allows fast reclaim of
HP-protected pointers without needing to wait for a grace period.

It also allows the hazard pointer scan to call a user-defined callback
to retire a hazard pointer slot immediately if needed. This callback
may, for instance, issue an IPI to the relevant CPU.

There are a few possible use-cases for this in the Linux kernel:

  - Improve performance of mm_count by replacing lazy active mm by HP.
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
 include/linux/hp.h | 154 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/Makefile    |   2 +-
 kernel/hp.c        |  46 ++++++++++++++
 3 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/hp.h
 create mode 100644 kernel/hp.c

diff --git a/include/linux/hp.h b/include/linux/hp.h
new file mode 100644
index 000000000000..929e8685a0fd
--- /dev/null
+++ b/include/linux/hp.h
@@ -0,0 +1,154 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+#ifndef _LINUX_HP_H
+#define _LINUX_HP_H
+
+/*
+ * HP: Hazard Pointers
+ *
+ * This API provides existence guarantees of objects through hazard
+ * pointers.
+ *
+ * It uses a fixed number of hazard pointer slots (nr_cpus) across the
+ * entire system for each HP domain.
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
+#include <linux/rcupdate.h>
+
+/*
+ * Hazard pointer slot.
+ */
+struct hp_slot {
+	void *addr;
+};
+
+/*
+ * Hazard pointer context, returned by hp_use().
+ */
+struct hp_ctx {
+	struct hp_slot *slot;
+	void *addr;
+};
+
+/*
+ * hp_scan: Scan hazard pointer domain for @addr.
+ *
+ * Scan hazard pointer domain for @addr.
+ * If @retire_cb is NULL, wait to observe that each slot contains a value
+ * that differs from @addr.
+ * If @retire_cb is non-NULL, invoke @callback for each slot containing
+ * @addr.
+ */
+void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
+	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr));
+
+/* Get the hazard pointer context address (may be NULL). */
+static inline
+void *hp_ctx_addr(struct hp_ctx ctx)
+{
+	return ctx.addr;
+}
+
+/*
+ * hp_allocate: Allocate a hazard pointer.
+ *
+ * Allocate a hazard pointer slot for @addr. The object existence should
+ * be guaranteed by the caller.
+ *
+ * Returns a hazard pointer context.
+ */
+static inline
+struct hp_ctx hp_allocate(struct hp_slot __percpu *percpu_slots, void *addr)
+{
+	struct hp_slot *slot;
+	struct hp_ctx ctx;
+
+	if (!addr)
+		goto fail;
+	slot = this_cpu_ptr(percpu_slots);
+	/*
+	 * A single hazard pointer slot per CPU is available currently.
+	 * Other hazard pointer domains can eventually have a different
+	 * configuration.
+	 */
+	if (READ_ONCE(slot->addr))
+		goto fail;
+	WRITE_ONCE(slot->addr, addr);	/* Store B */
+	ctx.slot = slot;
+	ctx.addr = addr;
+	return ctx;
+
+fail:
+	ctx.slot = NULL;
+	ctx.addr = NULL;
+	return ctx;
+}
+
+/*
+ * hp_dereference_allocate: Dereference and allocate a hazard pointer.
+ *
+ * Returns a hazard pointer context.
+ */
+static inline
+struct hp_ctx hp_dereference_allocate(struct hp_slot __percpu *percpu_slots, void * const * addr_p)
+{
+	struct hp_slot *slot;
+	void *addr, *addr2;
+	struct hp_ctx ctx;
+
+	addr = READ_ONCE(*addr_p);
+retry:
+	ctx = hp_allocate(percpu_slots, addr);
+	if (!hp_ctx_addr(ctx))
+		goto fail;
+	/* Memory ordering: Store B before Load A. */
+	smp_mb();
+	/*
+	 * Use RCU dereference without lockdep checks, because
+	 * lockdep is not aware of HP guarantees.
+	 */
+	addr2 = rcu_access_pointer(*addr_p);	/* Load A */
+	/*
+	 * If @addr_p content has changed since the first load,
+	 * clear the hazard pointer and try again.
+	 */
+	if (!ptr_eq(addr2, addr)) {
+		WRITE_ONCE(slot->addr, NULL);
+		if (!addr2)
+			goto fail;
+		addr = addr2;
+		goto retry;
+	}
+	ctx.slot = slot;
+	ctx.addr = addr2;
+	return ctx;
+
+fail:
+	ctx.slot = NULL;
+	ctx.addr = NULL;
+	return ctx;
+}
+
+/* Retire the hazard pointer in @ctx. */
+static inline
+void hp_retire(const struct hp_ctx ctx)
+{
+	smp_store_release(&ctx.slot->addr, NULL);
+}
+
+#endif /* _LINUX_HP_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..ec16de96fa80 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    cpu.o exit.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o user.o \
 	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
-	    extable.o params.o \
+	    extable.o params.o hp.o \
 	    kthread.o sys_ni.o nsproxy.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
diff --git a/kernel/hp.c b/kernel/hp.c
new file mode 100644
index 000000000000..b2447bf15300
--- /dev/null
+++ b/kernel/hp.c
@@ -0,0 +1,46 @@
+// SPDX-FileCopyrightText: 2024 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+//
+// SPDX-License-Identifier: LGPL-2.1-or-later
+
+/*
+ * HP: Hazard Pointers
+ */
+
+#include <linux/hp.h>
+#include <linux/percpu.h>
+
+/*
+ * hp_scan: Scan hazard pointer domain for @addr.
+ *
+ * Scan hazard pointer domain for @addr.
+ * If @retire_cb is non-NULL, invoke @callback for each slot containing
+ * @addr.
+ * Wait to observe that each slot contains a value that differs from
+ * @addr before returning.
+ */
+void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
+	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
+{
+	int cpu;
+
+	/*
+	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
+	 * NULL or to a different value), and thus hides it from hazard
+	 * pointer readers.
+	 */
+
+	if (!addr)
+		return;
+	/* Memory ordering: Store A before Load B. */
+	smp_mb();
+	/* Scan all CPUs slots. */
+	for_each_possible_cpu(cpu) {
+		struct hp_slot *slot = per_cpu_ptr(percpu_slots, cpu);
+
+		if (retire_cb && smp_load_acquire(&slot->addr) == addr)	/* Load B */
+			retire_cb(cpu, slot, addr);
+		/* Busy-wait if node is found. */
+		while ((smp_load_acquire(&slot->addr)) == addr)	/* Load B */
+			cpu_relax();
+	}
+}
-- 
2.39.2

