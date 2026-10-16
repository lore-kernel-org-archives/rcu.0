Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748D4DA9AD;
	Fri, 16 Oct 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157618; cv=none; b=Bn6jy+vGKNXFk4LzD6PTqMy8nhqPy/oav/0DPxUR9WzI85vOBXPGYsSs5I7BDxuXiLeANDQSgxmjJCJW3bZaT+c2pJLqp1iDnkDWXyUvi2tjm2LJrFTLRYRfEJ340urDINDk7ZO/a12Q6alTog2yk/B0hYTJIItaAOCEPjCFbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157618; c=relaxed/simple;
	bh=dzH/WX+gEG5AHOY4FDdXLNfIkkTM2J3q3ki8HKPcXKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GirpGP3UuJVJ2dWdoH9v+8xCRKbisBm3q8vXtnpMh8l2aLMy9xyLkIg15boyv77S4cEUYdD+xG5hR3Kn0zrIGWZHHBEncAMHwwWh7T5Av5w+ALzGEj7c3CiKJoNrKjhzpb5206lvTAcNRa99JSkAC9J9Y87IGdmocn7QmIhA/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=B199JQYR; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="B199JQYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157607;
	bh=iSlfPNzsynis7COBrZAsw8t2pngsoLZVwm5wcaTG2Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B199JQYRwN1Ee6VC9ktSqMK8sYq3om8NsBXKbGWPGEwhnGkeNmfFlc0Fw2tApHTRy
	 lg7JisD8vhlP0caiHfyVEotwY4mbthYH7w2CblLHRHOw91pbnkgBhivqsujZgvfMEE
	 9lBO+ytVeepBXkcT9Bk0D7dXKL1Pe27GOwxfpSMCA5WvH+UdA3HMeWG+lsmc4D7Z/Z
	 pHxhN1vbp840HJ3/PGIuLi8nZQNoCUP0ReBinrFErQ+MWboMsivspmgrZLPyv3keKU
	 bcx/85tShbCK5xBjUEWdEMdOZL/RvTt7ccqY43VU4/+jRNYtZrHzeVlEVKY/b3Ermy
	 uCAq/vWYmPS1Q==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9M23lcznrg;
	Fri, 16 Oct 2026 09:33:27 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	rcu@vger.kernel.org
Subject: [RFC PATCH 02/12] rcu_txn: Add KUnit tests
Date: Fri, 16 Oct 2026 09:33:09 -0400
Message-Id: <20261016133319.433617-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
References: <20261016133319.433617-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the RCU pseudo-transactions: commits of one and of several records,
the three steps of a commit as a reader observes them, typed slots,
growth and reservation of a transaction, cancellation, the sticky
allocation failure, reading back one's own writes, and misuse of a
handle.

The steps of a commit are staged by hand through lib/rcu_txn_internal.h,
since rcu_txn_commit() runs them back to back.

A misuse reports through WARN_ON_ONCE(), which the tests suppress and
count.  Where the architecture does not keep a WARN_ON_ONCE()'s once
state in its bug table (no __WARN_FLAGS), it fires once per boot whether
it is suppressed or not, so the count is only checked to be at most one
there.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 MAINTAINERS               |   1 +
 lib/Kconfig.debug         |  13 ++
 lib/tests/Makefile        |   1 +
 lib/tests/rcu_txn_kunit.c | 463 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 478 insertions(+)
 create mode 100644 lib/tests/rcu_txn_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a5dc2eda633f..5126f4ece4e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22859,6 +22859,7 @@ L:	rcu@vger.kernel.org
 S:	Maintained
 F:	include/linux/rcu_txn*.h
 F:	lib/rcu_txn*
+F:	lib/tests/rcu_txn_kunit.c
 
 RCUTORTURE TEST FRAMEWORK
 M:	"Paul E. McKenney" <paulmck@kernel.org>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b24a2c89b84..5a93d2afdd96 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2844,6 +2844,19 @@ config LIST_PRIVATE_KUNIT_TEST
 
 	  If unsure, say N.
 
+config RCU_TXN_KUNIT_TEST
+	tristate "KUnit Test for single-writer RCU pseudo-transactions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	select RCU_TXN
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit test suite of the single-writer RCU
+	  pseudo-transactions defined in include/linux/rcu_txn.h.  It tests
+	  the commit of a transaction as readers observe it, and the
+	  lifecycle of a transaction handle, including its misuse.
+
+	  If unsure, say N.
+
 config HASHTABLE_KUNIT_TEST
 	tristate "KUnit Test for Kernel Hashtable structures" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 3cac3b63a752..d9d41a5da87d 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 obj-$(CONFIG_PRANDOM_KUNIT_TEST) += random32_kunit.o
 obj-$(CONFIG_PRINTF_KUNIT_TEST) += printf_kunit.o
 obj-$(CONFIG_RANDSTRUCT_KUNIT_TEST) += randstruct_kunit.o
+obj-$(CONFIG_RCU_TXN_KUNIT_TEST) += rcu_txn_kunit.o
 obj-$(CONFIG_SCANF_KUNIT_TEST) += scanf_kunit.o
 obj-$(CONFIG_SEQ_BUF_KUNIT_TEST) += seq_buf_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
new file mode 100644
index 000000000000..e5323e21157b
--- /dev/null
+++ b/lib/tests/rcu_txn_kunit.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * KUnit tests of the single-writer RCU pseudo-transactions
+ *
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/bug.h>
+#include <linux/rcu_txn.h>
+#include <linux/rcupdate.h>
+#include <linux/string.h>
+
+#include "../rcu_txn_internal.h"	/* the steps of a commit */
+
+/* Bit 0 of the proxy pointer: no value below carries it. */
+#define TAG	1UL
+
+/* Opaque slot values with the tag bit clear. */
+#define T(n)	((void *)(((unsigned long)(n) + 1) << 8))
+
+/*
+ * A WARN_ON_ONCE() of the engine reports once per boot, so a later run of the
+ * suite sees none.  Where the architecture keeps the once state in its bug
+ * table, KUnit counts every suppressed occurrence instead.
+ */
+#ifdef __WARN_FLAGS
+# define EXPECT_ONE_WARNING(test)					\
+	KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1)
+#else
+# define EXPECT_ONE_WARNING(test)					\
+	KUNIT_EXPECT_LE(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1)
+#endif
+
+/*
+ * Each test is the only writer of the structures it builds.  It reads them
+ * as a writer, through the forms that take a lockdep condition, passing true,
+ * and outside of any RCU read-side critical section.
+ *
+ * A test that reads as a reader instead, as read_slot() below does, checks
+ * what it read only after rcu_read_unlock(): a failed KUNIT_EXPECT_*()
+ * allocates with GFP_KERNEL, which may sleep.
+ */
+
+/* Load @slot and resolve it, as a reader does. */
+static void *read_slot(void __rcu **slot)
+{
+	void *v;
+
+	rcu_read_lock();
+	v = rcu_txn_resolve(rcu_dereference(*slot), TAG);
+	rcu_read_unlock();
+	return v;		/* a test value: never dereferenced */
+}
+
+/*
+ * One record: the commit stores the new target directly.  No proxy is ever
+ * installed, so the descriptor is freed at once.
+ */
+static void rcu_txn_test_single_record(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_EXPECT_TRUE(test, rcu_txn_reserve(&txn, 4));
+	rcu_txn_record(&txn, &slot, T(0), T(1), TAG);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(slot), T(1));
+	KUNIT_EXPECT_FALSE(test,
+			   rcu_txn_is_proxy(rcu_access_pointer(slot), TAG));
+}
+
+/*
+ * Two records or more: the commit installs every proxy, flips the group and
+ * settles every slot to new.
+ */
+static void rcu_txn_test_multi_record(struct kunit *test)
+{
+	void __rcu *s1 = RCU_INITIALIZER(T(0));
+	void __rcu *s2 = RCU_INITIALIZER(T(1));
+	void __rcu *s3 = RCU_INITIALIZER(T(2));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_reserve(&txn, 4);
+	rcu_txn_record(&txn, &s1, T(0), T(10), TAG);
+	rcu_txn_record(&txn, &s2, T(1), T(11), TAG);
+	rcu_txn_record(&txn, &s3, T(2), T(12), TAG);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s1), T(10));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s2), T(11));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s3), T(12));
+}
+
+/*
+ * The three steps of a commit, by hand: an installed proxy resolves to old,
+ * the flip makes it resolve to new, and the settle leaves the new target in the
+ * slot.
+ */
+static void rcu_txn_test_commit_steps(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_group group;
+	struct rcu_txn_record rec;
+
+	__rcu_txn_group_init(&group);
+	__rcu_txn_record_set(&rec, &slot, T(0), T(1), TAG);
+	__rcu_txn_record_install(&group, &rec);
+	KUNIT_EXPECT_TRUE(test,
+			  rcu_txn_is_proxy(rcu_access_pointer(slot), TAG));
+	KUNIT_EXPECT_PTR_EQ(test, read_slot(&slot), T(0));
+	__rcu_txn_group_commit(&group);
+	KUNIT_EXPECT_TRUE(test,
+			  rcu_txn_is_proxy(rcu_access_pointer(slot), TAG));
+	KUNIT_EXPECT_PTR_EQ(test, read_slot(&slot), T(1));
+	__rcu_txn_record_settle(&rec);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(slot), T(1));
+}
+
+struct item {
+	struct item __rcu *next;
+	int key;
+};
+
+/*
+ * A typed __rcu pointer as a slot: rcu_txn_slot() hands its address to the
+ * engine and rcu_txn_dereference_check() reads it back with its type, through a
+ * proxy or not.
+ */
+static void rcu_txn_test_typed_slot(struct kunit *test)
+{
+	struct item a = { .key = 1 }, b = { .key = 2 }, c = { .key = 3 };
+	struct item __rcu *head = RCU_INITIALIZER(&a);
+	struct rcu_txn_group group;
+	struct rcu_txn_record rec;
+	struct rcu_txn txn;
+	struct item *it;
+
+	/* Through an installed proxy, before and after the flip. */
+	__rcu_txn_group_init(&group);
+	__rcu_txn_record_set(&rec, rcu_txn_slot(&head), &a, &b, TAG);
+	__rcu_txn_record_install(&group, &rec);
+	it = rcu_txn_dereference_check(head, TAG, true);
+	KUNIT_EXPECT_PTR_EQ(test, it, &a);
+	__rcu_txn_group_commit(&group);
+	it = rcu_txn_dereference_check(head, TAG, true);
+	KUNIT_EXPECT_PTR_EQ(test, it, &b);
+	__rcu_txn_record_settle(&rec);
+
+	/* Two typed slots in one transaction: head -> c -> b. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, rcu_txn_slot(&head), &b, &c, TAG);
+	rcu_txn_record(&txn, rcu_txn_slot(&c.next), NULL, &b, TAG);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	it = rcu_txn_dereference_check(head, TAG, true);
+	KUNIT_EXPECT_EQ(test, it->key, 3);
+	it = rcu_txn_dereference_check(it->next, TAG, true);
+	KUNIT_EXPECT_EQ(test, it->key, 2);
+	KUNIT_EXPECT_NULL(test, rcu_txn_dereference_check(it->next, TAG, true));
+}
+
+/* Record @nr edges on distinct slots.  Returns false if a record() failed. */
+static bool record_all(struct rcu_txn *txn, void __rcu **slots, unsigned int nr)
+{
+	bool all_recorded = true;
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		RCU_INIT_POINTER(slots[i], T(i));
+		if (!rcu_txn_record(txn, &slots[i], T(i), T(100 + i), TAG))
+			all_recorded = false;
+	}
+	return all_recorded;
+}
+
+static bool all_settled(void __rcu **slots, unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++)
+		if (rcu_access_pointer(slots[i]) != T(100 + i))
+			return false;
+	return true;
+}
+
+/*
+ * Record more edges than the first capacity without a reserve(): the
+ * descriptor grows, and the commit settles the whole set.
+ */
+static void rcu_txn_test_grow(struct kunit *test)
+{
+	enum { NR = 3 * RCU_TXN_CAP + 1 };
+	void __rcu *slots[NR];
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_EXPECT_TRUE(test, record_all(&txn, slots, 1));
+	KUNIT_EXPECT_GE(test, txn.cap, RCU_TXN_CAP);
+	rcu_txn_cancel(&txn);
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_EXPECT_TRUE(test, record_all(&txn, slots, NR));
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_TRUE(test, all_settled(slots, NR));
+}
+
+/*
+ * reserve() gives the handle room for its bound, and recording up to the bound
+ * does not move the records.  Recording past it grows the descriptor.
+ */
+static void rcu_txn_test_reserve(struct kunit *test)
+{
+	enum { NR = 2 * RCU_TXN_CAP + 1 };
+	struct rcu_txn_record *records;
+	void __rcu *slots[NR];
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_EXPECT_TRUE(test, rcu_txn_reserve(&txn, 2));
+	KUNIT_EXPECT_GE(test, txn.cap, 2);
+	records = txn.records;
+	KUNIT_EXPECT_TRUE(test, record_all(&txn, slots, 2));
+	KUNIT_EXPECT_PTR_EQ(test, txn.records, records);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_TRUE(test, all_settled(slots, 2));
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_reserve(&txn, 2);
+	KUNIT_EXPECT_TRUE(test, record_all(&txn, slots, NR));
+	KUNIT_EXPECT_GE(test, txn.cap, NR);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_TRUE(test, all_settled(slots, NR));
+}
+
+/* A single-record transaction installs no proxy, and may use a zero tag. */
+static void rcu_txn_test_zero_tag(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	kunit_warning_suppress(test) {
+		rcu_txn_record(&txn, &slot, T(0), T(1), 0);
+		KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+	}
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(slot), T(1));
+}
+
+/*
+ * A cancelled transaction publishes nothing and consumes the handle, which
+ * commits as usual once initialized again.
+ */
+static void rcu_txn_test_cancel(struct kunit *test)
+{
+	void __rcu *s1 = RCU_INITIALIZER(T(0));
+	void __rcu *s2 = RCU_INITIALIZER(T(1));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, &s1, T(0), T(10), TAG);
+	rcu_txn_record(&txn, &s2, T(1), T(11), TAG);
+	rcu_txn_cancel(&txn);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s1), T(0));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s2), T(1));
+	KUNIT_EXPECT_NULL(test, txn.desc);
+	KUNIT_EXPECT_NULL(test, txn.records);
+	KUNIT_EXPECT_EQ(test, txn.state, RCU_TXN_DONE);
+
+	/* A handle that recorded nothing. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_cancel(&txn);
+	KUNIT_EXPECT_EQ(test, txn.state, RCU_TXN_DONE);
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, &s1, T(0), T(10), TAG);
+	rcu_txn_record(&txn, &s2, T(1), T(11), TAG);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s1), T(10));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s2), T(11));
+}
+
+/*
+ * The sticky OOM state, set by hand: no allocation of this size fails on
+ * demand.  Later records do nothing, and commit() and cancel() both release
+ * the handle without publishing.
+ */
+static void rcu_txn_test_oom(struct kunit *test)
+{
+	void __rcu *s1 = RCU_INITIALIZER(T(0));
+	void __rcu *s2 = RCU_INITIALIZER(T(1));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, &s1, T(0), T(10), TAG);
+	txn.state = RCU_TXN_OOM;
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_FALSE(test, rcu_txn_reserve(&txn, 8));
+		KUNIT_EXPECT_FALSE(test,
+				   rcu_txn_record(&txn, &s2, T(1), T(11), TAG));
+		KUNIT_EXPECT_FALSE(test,
+				   rcu_txn_record_chain(&txn, &s2, T(1), T(11),
+							TAG));
+		KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), -ENOMEM);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+	}
+	KUNIT_EXPECT_NULL(test, txn.desc);
+	KUNIT_EXPECT_EQ(test, txn.state, RCU_TXN_DONE);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s1), T(0));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s2), T(1));
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, &s1, T(0), T(10), TAG);
+	rcu_txn_record(&txn, &s2, T(1), T(11), TAG);
+	txn.state = RCU_TXN_OOM;
+	rcu_txn_cancel(&txn);
+	KUNIT_EXPECT_NULL(test, txn.desc);
+	KUNIT_EXPECT_EQ(test, txn.state, RCU_TXN_DONE);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s1), T(0));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(s2), T(1));
+
+	/* declare_disjoint() leaves a handle whose reserve() failed as it is. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	txn.state = RCU_TXN_OOM;
+	kunit_warning_suppress(test) {
+		rcu_txn_declare_disjoint(&txn);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+	}
+	KUNIT_EXPECT_FALSE(test, txn.disjoint);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), -ENOMEM);
+}
+
+/*
+ * load() returns the transaction's pending value of a recorded slot, and
+ * record_chain() fuses a second store to it into the same record.
+ */
+static void rcu_txn_test_ryw_chain(struct kunit *test)
+{
+	enum { NR = 6 };
+	void __rcu *other = RCU_INITIALIZER(T(50));
+	void __rcu *slots[NR];
+	struct rcu_txn txn;
+	unsigned int i;
+
+	for (i = 0; i < NR; i++)
+		RCU_INIT_POINTER(slots[i], T(i));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	for (i = 0; i < NR; i++) {
+		void *v = rcu_txn_load(&txn, &slots[i], TAG);
+
+		KUNIT_EXPECT_PTR_EQ(test, v, T(i));
+		rcu_txn_record_chain(&txn, &slots[i], v, T(20 + i), TAG);
+	}
+	/* Every slot is recorded: loads return the pending values. */
+	for (i = 0; i < NR; i++) {
+		void *v = rcu_txn_load(&txn, &slots[i], TAG);
+
+		KUNIT_EXPECT_PTR_EQ(test, v, T(20 + i));
+		rcu_txn_record_chain(&txn, &slots[i], v, T(100 + i), TAG);
+	}
+	KUNIT_EXPECT_EQ(test, txn.nr, NR);		/* fused */
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_load(&txn, &other, TAG), T(50));
+	for (i = 0; i < NR; i++)		/* nothing is published yet */
+		KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(slots[i]), T(i));
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_TRUE(test, all_settled(slots, NR));
+}
+
+/*
+ * A handle declared disjoint skips the lookup: record_chain() appends, and
+ * load() returns the committed value.
+ */
+static void rcu_txn_test_disjoint(struct kunit *test)
+{
+	void __rcu *a = RCU_INITIALIZER(T(0));
+	void __rcu *b = RCU_INITIALIZER(T(1));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_declare_disjoint(&txn);
+	rcu_txn_record_chain(&txn, &a, rcu_txn_load(&txn, &a, TAG), T(10), TAG);
+	rcu_txn_record_chain(&txn, &b, rcu_txn_load(&txn, &b, TAG), T(11), TAG);
+	KUNIT_EXPECT_EQ(test, txn.nr, 2);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(a), T(10));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(b), T(11));
+}
+
+/*
+ * A handle that commit() consumed must be initialized again.  Each entry
+ * point warns and does nothing.
+ */
+static void rcu_txn_test_consumed_handle(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, &slot, T(0), T(1), TAG);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_FALSE(test, rcu_txn_reserve(&txn, 4));
+		EXPECT_ONE_WARNING(test);
+	}
+	kunit_warning_suppress(test) {
+		bool recorded = rcu_txn_record(&txn, &slot, T(1), T(2), TAG);
+
+		KUNIT_EXPECT_FALSE(test, recorded);
+		EXPECT_ONE_WARNING(test);
+	}
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_FALSE(test,
+				   rcu_txn_record_chain(&txn, &slot, T(1), T(2),
+							TAG));
+		EXPECT_ONE_WARNING(test);
+	}
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_PTR_EQ(test, rcu_txn_load(&txn, &slot, TAG), T(1));
+		EXPECT_ONE_WARNING(test);
+	}
+	kunit_warning_suppress(test) {
+		rcu_txn_declare_disjoint(&txn);
+		KUNIT_EXPECT_FALSE(test, txn.disjoint);
+		EXPECT_ONE_WARNING(test);
+	}
+	kunit_warning_suppress(test) {
+		rcu_txn_cancel(&txn);
+		EXPECT_ONE_WARNING(test);
+	}
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), -EINVAL);
+		EXPECT_ONE_WARNING(test);
+	}
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(slot), T(1));
+}
+
+static struct kunit_case rcu_txn_test_cases[] = {
+	KUNIT_CASE(rcu_txn_test_single_record),
+	KUNIT_CASE(rcu_txn_test_multi_record),
+	KUNIT_CASE(rcu_txn_test_commit_steps),
+	KUNIT_CASE(rcu_txn_test_typed_slot),
+	KUNIT_CASE(rcu_txn_test_grow),
+	KUNIT_CASE(rcu_txn_test_reserve),
+	KUNIT_CASE(rcu_txn_test_zero_tag),
+	KUNIT_CASE(rcu_txn_test_cancel),
+	KUNIT_CASE(rcu_txn_test_oom),
+	KUNIT_CASE(rcu_txn_test_ryw_chain),
+	KUNIT_CASE(rcu_txn_test_disjoint),
+	KUNIT_CASE(rcu_txn_test_consumed_handle),
+	{}
+};
+
+static struct kunit_suite rcu_txn_test_suite = {
+	.name = "rcu_txn",
+	.test_cases = rcu_txn_test_cases,
+};
+
+kunit_test_suite(rcu_txn_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests of the single-writer RCU pseudo-transactions");
+MODULE_LICENSE("GPL");
-- 
2.47.3

