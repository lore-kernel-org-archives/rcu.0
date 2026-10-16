Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D84DA9B6;
	Fri, 16 Oct 2026 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157619; cv=none; b=NJmATzgWp20W9ZTsoR9+QQKu3iwipLnG/WvRW7cA1HrgRgKnztrLZE88KwID89KmxRxnnGVXmXcEXYVkJP9lHYpGGqRA0VhBYJtP+2vkI2Ax/xWcv5KhyQsHodSlcL7ugegRjZtUZkYz/GPonj5/8iDi7goYW1FbUo10OfFKS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157619; c=relaxed/simple;
	bh=27HIR31tc4/8S7CsVVvedmsBiNShtTCWVQFcOt4SlLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8a4MvQqunwnIdqtB1VPQeSL8AMJ7IWki2Js4wiEyn3OC3rrDEmC8WpyMDs7KtzN2PKvmVbWZGGXQOScPuSpKLZZSL8SegeXjZKlsV0ZzBurLgamGmqPAqigEhGQiBAilpzzvyWW/Jn0vLsPhdIZ4AnInbdQCfDfwjYMniDylV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VnpAAuP7; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VnpAAuP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157607;
	bh=Q2hLy7f57U2xwCuowGuDXNzo9/wYKWCFSa/UfWVlRNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnpAAuP7N3QKL3W5Imff5WrOPPV2+R1Kr4MrVtDyiwoaaVH8Pp2JtBBSP9GDq3lEr
	 +KZiYT7B+MOR22eLdC84wo6PxoWKKEBhCmWOxs3nRudPEqhzFCKVLSyr5kZY8M2PSr
	 CgqCp728R+8W7TVlWhOKwJHCFeIw2cmE92fAcANM75YS9dtLByI6WvjEtYncGd+nNP
	 X6/SsrXjJohSN32HaFdOo9TC4cn/EyZX2tTHnq+PESkvKthlSYOhdwLq5AMa6gOeNT
	 WK8Pq775CnSKapvG6OIyG/9pX57Q0sk2Ci/GxgEQEs+az0i6lE0cRfTXXa9u2++r44
	 VlI+/iDZ76d/g==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9M3LJqznZD;
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
Subject: [RFC PATCH 03/12] rcu_txn: Skip the record lookup with a Bloom filter
Date: Fri, 16 Oct 2026 09:33:10 -0400
Message-Id: <20261016133319.433617-4-mathieu.desnoyers@efficios.com>
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

rcu_txn_load() and rcu_txn_record_chain() look the slot up among the
records of the transaction with a linear scan, so a transaction of n
records costs O(n) per access and O(n^2) to build.  Most lookups miss.

Answer the miss from a Bloom filter: a clear bit means the slot is not
recorded, and the scan is skipped.  A hit still goes to the scan, so the
filter never changes an answer.

The filter is armed by the first lookup that faces RCU_TXN_BLOOM_MIN
records, and is not even zeroed before that.  Most transactions hold a
record or two, for which the scan is cheaper than hashing.

The filter takes 128 bytes, which the handle does not carry, as it lives
on the stack: the filter lives in the descriptor, past the records.  A
descriptor of RCU_TXN_BLOOM_MIN records or more has room for it among
the slots of its records array, which the array's __counted_by() covers,
and a resize carries an armed filter over to the new descriptor.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/rcu_txn.h       |  89 ++++++++++++++++++--
 include/linux/rcu_txn_bloom.h | 110 +++++++++++++++++++++++++
 lib/rcu_txn.c                 |  36 ++++++++-
 lib/tests/rcu_txn_kunit.c     | 147 ++++++++++++++++++++++++++++++++++
 4 files changed, 373 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/rcu_txn_bloom.h

diff --git a/include/linux/rcu_txn.h b/include/linux/rcu_txn.h
index 48e87ea2d90b..ee152100ab95 100644
--- a/include/linux/rcu_txn.h
+++ b/include/linux/rcu_txn.h
@@ -102,6 +102,7 @@
 #include <linux/errno.h>
 #include <linux/gfp_types.h>
 #include <linux/rcupdate.h>
+#include <linux/rcu_txn_bloom.h>	/* read-your-own-writes filter */
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -197,7 +198,13 @@ struct rcu_txn_desc {
 	struct rcu_txn_group group;		/* read by installed proxies */
 	struct rcu_head rcu_head;		/* deferred-free handle */
 	unsigned int cap;			/* records it can hold */
-	struct rcu_txn_record records[] __counted_by(cap);
+	/*
+	 * Record-sized slots of the allocation: the @cap records and, in a
+	 * descriptor of RCU_TXN_BLOOM_MIN records or more, past them, the
+	 * read-your-own-writes filter (__rcu_txn_bloom()).
+	 */
+	unsigned int slots;
+	struct rcu_txn_record records[] __counted_by(slots);
 };
 
 /*
@@ -218,6 +225,7 @@ struct rcu_txn {
 	gfp_t gfp;			/* for the descriptor */
 	enum rcu_txn_state state;
 	bool disjoint;			/* declared slot-disjoint */
+	bool bloom_live;		/* the descriptor's filter is armed */
 };
 
 /*
@@ -463,9 +471,10 @@ static inline void __rcu_txn_done(struct rcu_txn *t)
 
 /*
  * Scan this transaction's records for @slot, or NULL.  Linear, so O(nr) per
- * call and O(nr^2) to build a write set.  The returned pointer is invalidated
- * by the next record() (a grow may move the records), so use it before
- * recording again.
+ * call and O(nr^2) to build a write set -- __rcu_txn_find_ryw() below is what
+ * keeps that off the hot path.  The returned pointer is invalidated by the
+ * next record() (a grow may move the records), so use it before recording
+ * again.
  */
 static inline struct rcu_txn_record *__rcu_txn_scan(const struct rcu_txn *t,
 						    void __rcu **slot)
@@ -478,6 +487,69 @@ static inline struct rcu_txn_record *__rcu_txn_scan(const struct rcu_txn *t,
 	return NULL;
 }
 
+/*
+ * RCU_TXN_BLOOM_MIN: the record count from which the read-your-own-writes
+ * filter (<linux/rcu_txn_bloom.h>) is used.  Below it the filter is never
+ * armed, nor even zeroed.
+ *
+ * rcu_txn_load() is only called on a slot about to be recorded, so loads
+ * track records one for one, and most transactions are tiny: one edge for an
+ * hlist operation, two for a list operation.  Scanning that many records is
+ * cheaper than hashing.
+ *
+ * The filter is built and armed by the first __rcu_txn_find_ryw() that faces
+ * at least this many records, then kept current by every record().  Arming on
+ * the record that crosses the threshold instead would make a transaction of
+ * exactly RCU_TXN_BLOOM_MIN records build a filter it never tests.
+ *
+ * The filter lives in the descriptor, past the records, so that the handle on
+ * the stack does not carry it.  A descriptor of this many records or more has
+ * room for it (rcu_txn_desc_alloc()).
+ */
+#define RCU_TXN_BLOOM_MIN	8
+
+static_assert(RCU_TXN_BLOOM_MIN > 1);
+
+/* The filter of the handle's descriptor: see RCU_TXN_BLOOM_MIN. */
+static inline u64 *__rcu_txn_bloom(const struct rcu_txn *t)
+{
+	return (u64 *)&t->desc->records[t->desc->cap];
+}
+
+/*
+ * Build the filter from the records so far and arm it.  See
+ * RCU_TXN_BLOOM_MIN.
+ */
+static inline void __rcu_txn_bloom_arm(struct rcu_txn *t)
+{
+	u64 *bloom = __rcu_txn_bloom(t);
+	unsigned int i;
+
+	memset(bloom, 0, RCU_TXN_BLOOM_SIZE);
+	for (i = 0; i < t->nr; i++)
+		rcu_txn_bloom_set(bloom, t->records[i].slot);
+	t->bloom_live = true;
+}
+
+/*
+ * __rcu_txn_scan() behind the filter: a clear bit means the slot is not
+ * recorded, and the scan is skipped.  All k bits set leaves the answer to the
+ * scan, which rules out a false positive.  The filter never changes the answer.
+ */
+static inline struct rcu_txn_record *__rcu_txn_find_ryw(struct rcu_txn *t,
+							void __rcu **slot)
+{
+	if (unlikely(!t->bloom_live)) {
+		/* Armed on first use: see RCU_TXN_BLOOM_MIN. */
+		if (t->nr < RCU_TXN_BLOOM_MIN)
+			return __rcu_txn_scan(t, slot);
+		__rcu_txn_bloom_arm(t);
+	}
+	if (!rcu_txn_bloom_test(__rcu_txn_bloom(t), slot))
+		return NULL;			/* definitely absent */
+	return __rcu_txn_scan(t, slot);
+}
+
 /*
  * Grow a full handle: double its capacity, or give an unreserved handle its
  * first RCU_TXN_CAP records.  Returns false if it cannot allocate.
@@ -531,6 +603,8 @@ static inline bool rcu_txn_record(struct rcu_txn *t, void __rcu **slot,
 		return false;			/* OOM, now sticky */
 	r = &t->records[t->nr++];
 	__rcu_txn_record_set(r, slot, old_ptr, new_ptr, tag);
+	if (unlikely(t->bloom_live))	/* armed: keep it current */
+		rcu_txn_bloom_set(__rcu_txn_bloom(t), slot);
 	return true;
 }
 
@@ -579,7 +653,8 @@ static inline bool rcu_txn_record(struct rcu_txn *t, void __rcu **slot,
  * a list, may write the same slot.
  *
  * This skips the lookup among the records so far on every load and record, a
- * scan: a small saving from the second record on.
+ * scan or, past RCU_TXN_BLOOM_MIN records, a Bloom filter test: a small saving
+ * from the second record on.
  *
  * Recording a slot twice on such a handle breaks the rule of rcu_txn_record(),
  * with the consequence stated there.
@@ -619,7 +694,7 @@ static inline void *rcu_txn_load(struct rcu_txn *t, void __rcu **slot,
 	/* A consumed handle has no record left: it reads committed values. */
 	WARN_ON_ONCE(t->state == RCU_TXN_DONE);
 	if (!t->disjoint) {
-		r = __rcu_txn_scan(t, slot);
+		r = __rcu_txn_find_ryw(t, slot);
 		if (r)
 			return r->ptr[1];	/* our own pending write */
 	}
@@ -637,7 +712,7 @@ static inline bool __rcu_txn_chain(struct rcu_txn *t, void __rcu **slot,
 {
 	struct rcu_txn_record *r;
 
-	r = __rcu_txn_scan(t, slot);
+	r = __rcu_txn_find_ryw(t, slot);
 	if (!r)
 		return rcu_txn_record(t, slot, old_ptr, new_ptr, tag);
 	r->ptr[1] = new_ptr;		/* committed old preserved */
diff --git a/include/linux/rcu_txn_bloom.h b/include/linux/rcu_txn_bloom.h
new file mode 100644
index 000000000000..c2b3b0e6ff01
--- /dev/null
+++ b/include/linux/rcu_txn_bloom.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * Read-your-own-writes Bloom filter of the RCU pseudo-transactions
+ *
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+#ifndef _LINUX_RCU_TXN_BLOOM_H
+#define _LINUX_RCU_TXN_BLOOM_H
+
+/*
+ * An RCU pseudo-transaction with read-your-own-writes must decide, per
+ * access, whether a slot is already in this transaction's write set.
+ * The authoritative test is a linear scan of the records, so a write
+ * set of n slots costs O(n) per access and O(n^2) to build -- and the
+ * scan is pure overhead on the dominant case, the lookup miss.
+ *
+ * This Bloom filter is an optimisation to answer the miss in O(1)
+ * without false negatives: a clear bit means the slot is definitely
+ * absent, so the scan is skipped outright.  All k bits set means
+ * present or a false positive, so the scan runs.
+ *
+ * Correctness never depends on the filter's presence, width or k.  A false
+ * positive only costs time: the scan of the records that the filter fails to
+ * skip, which then finds the slot absent.  Correctness does depend on the
+ * absence of false negatives, which is an obligation on the engine: the filter
+ * must be set for every slot recorded while it is live (arming rebuilds it
+ * from all records, so this holds from the moment it goes live).
+ *
+ * This is the mechanism only.  The state belongs to the caller, which
+ * provides RCU_TXN_BLOOM_SIZE bytes and owns zeroing them; where they live and
+ * when the filter is armed is the engine's policy: see RCU_TXN_BLOOM_MIN in
+ * <linux/rcu_txn.h>.  These helpers are pure functions over the array.
+ */
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+/*
+ * RCU_TXN_BLOOM_WORDS sets the filter width (64 bits each; 16 = 1024 bits).
+ * With k bits over m = 64 * WORDS bits and n recorded slots the false-positive
+ * rate is ~(1 - e^{-kn/m})^k, which for a sparse filter is (kn/m)^k: doubling
+ * the width divides it by ~2^k.
+ *
+ * Both width and k only ever trade filter cost against the false-positive
+ * rate: correctness never depends on either.
+ */
+#define RCU_TXN_BLOOM_WORDS	16
+
+/*
+ * RCU_TXN_BLOOM_K sets the number of hash bits a slot maps to.  Raising k by
+ * one multiplies the false-positive rate by the fill factor kn/m: a win only
+ * while the filter is sparse.
+ */
+#define RCU_TXN_BLOOM_K		3
+
+#define RCU_TXN_BLOOM_BITS	(64ULL * RCU_TXN_BLOOM_WORDS)
+#define RCU_TXN_BLOOM_SIZE	(sizeof(u64) * RCU_TXN_BLOOM_WORDS)
+
+/*
+ * Two independent hashes of the slot, for Kirsch-Mitzenmacher double hashing:
+ * one SplitMix64 avalanche (two multiplies), its 64 bits split into two 32-bit
+ * lanes.  A single multiply would leave the k positions correlated, slot
+ * addresses being aligned and clustered.  h2 is forced odd so that h1 + i*h2
+ * visits k distinct bits.
+ */
+static inline void rcu_txn_bloom_h1h2(void __rcu **slot, u64 *h1, u64 *h2)
+{
+	/*
+	 * Shift by the alignment every slot has, 4 bytes on 32-bit: >> 3 would
+	 * map adjacent slots there to the same k positions.  On 64-bit the one
+	 * zero bit left is mixed away by the avalanche.
+	 */
+	u64 x = (u64)(unsigned long)slot >> 2;
+
+	x ^= x >> 30; x *= 0xbf58476d1ce4e5b9ULL;
+	x ^= x >> 27; x *= 0x94d049bb133111ebULL;
+	x ^= x >> 31;
+	*h1 = x & 0xffffffffULL;		/* low lane */
+	*h2 = (x >> 32) | 1;			/* high lane, odd stride */
+}
+
+static inline bool rcu_txn_bloom_test(const u64 *bloom, void __rcu **slot)
+{
+	u64 h1, h2;
+	unsigned int i;
+
+	rcu_txn_bloom_h1h2(slot, &h1, &h2);
+	for (i = 0; i < RCU_TXN_BLOOM_K; i++) {
+		u64 idx = (h1 + (u64)i * h2) % RCU_TXN_BLOOM_BITS;
+
+		if (!(bloom[idx >> 6] & ((u64)1 << (idx & 63))))
+			return false;	/* a clear bit: definitely absent */
+	}
+	return true;	/* all k bits set: present (or a false positive) */
+}
+
+static inline void rcu_txn_bloom_set(u64 *bloom, void __rcu **slot)
+{
+	u64 h1, h2;
+	unsigned int i;
+
+	rcu_txn_bloom_h1h2(slot, &h1, &h2);
+	for (i = 0; i < RCU_TXN_BLOOM_K; i++) {
+		u64 idx = (h1 + (u64)i * h2) % RCU_TXN_BLOOM_BITS;
+
+		bloom[idx >> 6] |= (u64)1 << (idx & 63);
+	}
+}
+
+#endif /* _LINUX_RCU_TXN_BLOOM_H */
diff --git a/lib/rcu_txn.c b/lib/rcu_txn.c
index 232ad715468a..b040af0a8cdb 100644
--- a/lib/rcu_txn.c
+++ b/lib/rcu_txn.c
@@ -9,6 +9,8 @@
  */
 
 #include <linux/export.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
 #include <linux/overflow.h>
 #include <linux/rcu_txn.h>
 #include <linux/rcupdate.h>
@@ -17,6 +19,24 @@
 
 #include "rcu_txn_internal.h"
 
+/* Record-sized slots that the filter takes, past the records. */
+#define RCU_TXN_BLOOM_SLOTS						\
+	DIV_ROUND_UP(RCU_TXN_BLOOM_SIZE, sizeof(struct rcu_txn_record))
+
+/*
+ * The records that a descriptor of @slots record-sized slots holds.  Once they
+ * are RCU_TXN_BLOOM_MIN or more, the filter takes the slots past them: a
+ * descriptor with slots for that many records but not for the filter as well
+ * holds RCU_TXN_BLOOM_MIN - 1 records.
+ */
+static unsigned int rcu_txn_desc_cap(unsigned int slots)
+{
+	if (slots < RCU_TXN_BLOOM_MIN)
+		return slots;
+	return max_t(unsigned int, slots - RCU_TXN_BLOOM_SLOTS,
+		     RCU_TXN_BLOOM_MIN - 1);
+}
+
 /*
  * Allocate a transaction descriptor for at least @cap records, with its flip
  * group initialized.  Its capacity is what the allocation holds, which may be
@@ -32,12 +52,17 @@ static struct rcu_txn_desc *rcu_txn_desc_alloc(unsigned int cap, gfp_t gfp)
 	struct rcu_txn_desc *desc;
 	size_t size;
 
-	size = kmalloc_size_roundup(struct_size(desc, records, cap));
+	size = struct_size(desc, records, cap);
+	if (cap >= RCU_TXN_BLOOM_MIN)
+		size = size_add(size, RCU_TXN_BLOOM_SLOTS *
+				      sizeof(struct rcu_txn_record));
+	size = kmalloc_size_roundup(size);
 	desc = kmalloc(size, gfp);
 	if (!desc)
 		return NULL;
 	__rcu_txn_group_init(&desc->group);
-	desc->cap = (size - sizeof(*desc)) / sizeof(desc->records[0]);
+	desc->slots = (size - sizeof(*desc)) / sizeof(desc->records[0]);
+	desc->cap = rcu_txn_desc_cap(desc->slots);
 	return desc;
 }
 
@@ -66,6 +91,13 @@ bool __rcu_txn_resize(struct rcu_txn *t, unsigned int cap)
 	if (t->nr)		/* @records is NULL until first allocated */
 		memcpy(desc->records, t->records,
 		       (size_t)t->nr * sizeof(*desc->records));
+	/*
+	 * An armed filter moves too: both descriptors hold RCU_TXN_BLOOM_MIN
+	 * records or more, so both have room for it.
+	 */
+	if (t->bloom_live)
+		memcpy(&desc->records[desc->cap], __rcu_txn_bloom(t),
+		       RCU_TXN_BLOOM_SIZE);
 	kfree(t->desc);		/* NULL if it had none */
 	t->desc = desc;
 	t->records = desc->records;
diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
index e5323e21157b..3111fc537ff3 100644
--- a/lib/tests/rcu_txn_kunit.c
+++ b/lib/tests/rcu_txn_kunit.c
@@ -436,6 +436,147 @@ static void rcu_txn_test_consumed_handle(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(slot), T(1));
 }
 
+static void __rcu *bloom_slots[4096];
+
+/* An empty filter answers absent for every slot. */
+static void rcu_txn_test_bloom_empty(struct kunit *test)
+{
+	u64 bloom[RCU_TXN_BLOOM_WORDS] = {};
+	unsigned int i, present = 0;
+
+	for (i = 0; i < ARRAY_SIZE(bloom_slots); i++)
+		present += rcu_txn_bloom_test(bloom, &bloom_slots[i]);
+	KUNIT_EXPECT_EQ(test, present, 0);
+}
+
+/*
+ * No false negatives: every slot ever set still reads present, whatever is set
+ * after it.  This is the property the engine's correctness rests on.
+ */
+static void rcu_txn_test_bloom_no_false_negative(struct kunit *test)
+{
+	u64 bloom[RCU_TXN_BLOOM_WORDS] = {};
+	unsigned int i, j, missing = 0;
+
+	for (i = 0; i < ARRAY_SIZE(bloom_slots); i++) {
+		rcu_txn_bloom_set(bloom, &bloom_slots[i]);
+		/* Testing all i + 1 each round is O(n^2): sample. */
+		for (j = 0; j <= i; j += i / 16 + 1)
+			missing += !rcu_txn_bloom_test(bloom, &bloom_slots[j]);
+	}
+	for (i = 0; i < ARRAY_SIZE(bloom_slots); i++)
+		missing += !rcu_txn_bloom_test(bloom, &bloom_slots[i]);
+	KUNIT_EXPECT_EQ(test, missing, 0);
+}
+
+/*
+ * The filter still discriminates past its design fill: with an eighth of the
+ * slots set, not every absent slot reads present.  The bound only has to catch
+ * a degenerate hash.
+ */
+static void rcu_txn_test_bloom_discriminates(struct kunit *test)
+{
+	const unsigned int nr = ARRAY_SIZE(bloom_slots);
+	u64 bloom[RCU_TXN_BLOOM_WORDS] = {};
+	unsigned int i, false_positives = 0;
+
+	for (i = 0; i < nr / 8; i++)
+		rcu_txn_bloom_set(bloom, &bloom_slots[i]);
+	for (i = nr / 8; i < nr; i++)
+		false_positives += rcu_txn_bloom_test(bloom, &bloom_slots[i]);
+	KUNIT_EXPECT_LT(test, false_positives, nr - nr / 8);
+}
+
+/*
+ * The filter does not depend on insertion order.  Arming rebuilds it from the
+ * records so far, so a rebuilt filter must match one grown incrementally.
+ */
+static void rcu_txn_test_bloom_rebuild(struct kunit *test)
+{
+	u64 bloom[RCU_TXN_BLOOM_WORDS] = {}, rebuilt[RCU_TXN_BLOOM_WORDS] = {};
+	unsigned int i;
+
+	for (i = 0; i < 64; i++)
+		rcu_txn_bloom_set(bloom, &bloom_slots[i]);
+	for (i = 64; i-- > 0; )
+		rcu_txn_bloom_set(rebuilt, &bloom_slots[i]);
+	KUNIT_EXPECT_MEMEQ(test, bloom, rebuilt, sizeof(bloom));
+}
+
+/*
+ * The engine arms the filter at the first lookup that faces RCU_TXN_BLOOM_MIN
+ * records, and keeps it current from then on: slots recorded before and after
+ * the arming are both found.
+ */
+static void rcu_txn_test_bloom_arming(struct kunit *test)
+{
+	enum { NR = 2 * RCU_TXN_BLOOM_MIN };
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
+		/* The lookup that faces RCU_TXN_BLOOM_MIN records arms it. */
+		KUNIT_EXPECT_EQ(test, txn.bloom_live, i >= RCU_TXN_BLOOM_MIN);
+		rcu_txn_record_chain(&txn, &slots[i], v, T(20 + i), TAG);
+	}
+	for (i = 0; i < NR; i++) {
+		void *v = rcu_txn_load(&txn, &slots[i], TAG);
+
+		KUNIT_EXPECT_PTR_EQ(test, v, T(20 + i));
+		rcu_txn_record_chain(&txn, &slots[i], v, T(100 + i), TAG);
+	}
+	KUNIT_EXPECT_EQ(test, txn.nr, NR);		/* fused */
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_TRUE(test, all_settled(slots, NR));
+
+	/* A handle declared disjoint never looks up, and never arms. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_declare_disjoint(&txn);
+	for (i = 0; i < NR; i++) {
+		void *v = rcu_txn_load(&txn, &slots[i], TAG);
+
+		rcu_txn_record_chain(&txn, &slots[i], v, T(i), TAG);
+	}
+	KUNIT_EXPECT_FALSE(test, txn.bloom_live);
+	rcu_txn_cancel(&txn);
+}
+
+/*
+ * An armed filter moves with the records when the transaction outgrows its
+ * descriptor: every slot recorded before and after the move is still found.
+ */
+static void rcu_txn_test_bloom_grow(struct kunit *test)
+{
+	enum { NR = 8 * RCU_TXN_BLOOM_MIN };
+	void __rcu *slots[NR];
+	unsigned int i, cap = 0;
+	struct rcu_txn txn;
+
+	for (i = 0; i < NR; i++)
+		RCU_INIT_POINTER(slots[i], T(i));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	for (i = 0; i < NR; i++) {
+		void *v = rcu_txn_load(&txn, &slots[i], TAG);
+
+		if (txn.bloom_live && !cap)
+			cap = txn.cap;		/* armed in this descriptor */
+		rcu_txn_record_chain(&txn, &slots[i], v, T(100 + i), TAG);
+	}
+	KUNIT_ASSERT_NE(test, cap, 0);
+	KUNIT_EXPECT_GT(test, txn.cap, cap);	/* grown since */
+	for (i = 0; i < NR; i++)
+		KUNIT_EXPECT_PTR_EQ(test, rcu_txn_load(&txn, &slots[i], TAG),
+				    T(100 + i));
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	KUNIT_EXPECT_TRUE(test, all_settled(slots, NR));
+}
+
 static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_single_record),
 	KUNIT_CASE(rcu_txn_test_multi_record),
@@ -449,6 +590,12 @@ static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_ryw_chain),
 	KUNIT_CASE(rcu_txn_test_disjoint),
 	KUNIT_CASE(rcu_txn_test_consumed_handle),
+	KUNIT_CASE(rcu_txn_test_bloom_empty),
+	KUNIT_CASE(rcu_txn_test_bloom_no_false_negative),
+	KUNIT_CASE(rcu_txn_test_bloom_discriminates),
+	KUNIT_CASE(rcu_txn_test_bloom_rebuild),
+	KUNIT_CASE(rcu_txn_test_bloom_arming),
+	KUNIT_CASE(rcu_txn_test_bloom_grow),
 	{}
 };
 
-- 
2.47.3

