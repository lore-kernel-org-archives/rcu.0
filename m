Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEE4D9553;
	Fri, 16 Oct 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157622; cv=none; b=A0BmFEHr654WpXPxB9lbN/HVkUFK/20iWUmVG2aRPnZBL1NZ72yRXMNHEeejPGauQ4oFg/6shiy+YUjM1karsLfUiTjO3m70q+fD9Lv0Ff2Zu64lDaBhT8qVoOnGTzuCdYZE8dYquRcZelsVrH3qzuJHLeai+T8XnoMw/jycUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157622; c=relaxed/simple;
	bh=GnukF0EAMbTuvPrV1VX0fdJFg3svHNTfh4wJT8Xahhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHQapsPbOr3OeCNOQ37P8Xj+fmUKfbaEsnIhyRaHLuRe5tW1lSJPDw8a26l3hOhbuaCtlCMyYmIqcrjJZZjMaVvvwgzyAAxyldyGcR1ic74KHBDXYrByUs8yyDtknjofGNQgC+e7vxu3D8c258EedWyzsGOR3kq/75ScP6G4PIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bm8zoYe4; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bm8zoYe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157608;
	bh=7X4buT9Q5UTNQL8q3IIuPCNTR7o7TTWY3vI9lkbJNMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bm8zoYe4A8NeM8rRv0rFhyXJI40QQE9A3RxQWiZCAoEub47WmmcMtb55UJw8sX7Hf
	 DM2dko1S/s+RIh48YsxdhfBKebfd+ztMKV0DU/6/0UfujuACHENQHeInrVKsXKSRoF
	 oYmP+wQywjBkSL2yw9SO837wiC9mHIVtp5PARoRY75F3PKqyQOdRtlrn7d9Q6z5v3r
	 vP2/PebAcIBEjqsJvSc5DrZkkzWVCMPgiV0tY7YbWrduUB9ACsRyxRi58KIrvR0BEy
	 iIdGXibejmaZ6SUxIejQEBpl2LQGjoB/n+ipWrcFy+ooHzaIfZ7Hw0b07b2MPfUKAD
	 s+gs7lgiBZyIw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9M6PcWzmKZ;
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
Subject: [RFC PATCH 05/12] rcu_txn: Add an hlist edited through transactions
Date: Fri, 16 Oct 2026 09:33:12 -0400
Message-Id: <20261016133319.433617-6-mathieu.desnoyers@efficios.com>
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

Add rcu_txn_hlist, a list with a single-pointer head shaped like hlist,
whose edits are recorded into an RCU pseudo-transaction.  Its commit
makes all of them, on one list or on many, visible to readers at once:
an entry can move between two hash buckets, through a copy, and be in
exactly one of them at any instant.

Readers walk forward only and never load pprev, so a single update has
one reader-visible edge.  The _rcu forms make such an update outside of
any transaction, as hlist_add_head_rcu() does: they publish that edge
with rcu_assign_pointer(), then write pprev with a plain store, which no
other writer reads in between.  Every transaction settles its slots
before its commit returns, and the writers are excluded, so the slots
they read hold no proxy.  They allocate nothing and cannot fail.

The _prepare forms record into a transaction of the caller's, and
transact pprev too, as a slot of its own.  A later operation of the same
transaction then loads its neighbour's pprev as the transaction leaves
it, which lets edits of one bucket compose, and a transaction that fails
or is cancelled leaves every pprev as it was.  An update with a
successor thus records two edges there, and takes the descriptor path at
commit even alone.

A writer that excludes the others walks a chain with the same iterators
as readers, outside of an RCU read-side critical section, by passing
them a lockdep condition for that exclusion, such as lockdep_is_held()
of its lock, as with hlist_for_each_entry_rcu().  rcu_txn_hlist_empty()
takes the same condition: unlike hlist_empty(), it may have to resolve a
proxy, which reads the descriptor of a commit in flight.  Add
__rcu_txn_cond() to the engine, which picks that optional condition.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/rcu_txn.h       |   7 +
 include/linux/rcu_txn_hlist.h | 483 ++++++++++++++++++++++++++++++++++
 lib/tests/rcu_txn_kunit.c     | 396 ++++++++++++++++++++++++++++
 3 files changed, 886 insertions(+)
 create mode 100644 include/linux/rcu_txn_hlist.h

diff --git a/include/linux/rcu_txn.h b/include/linux/rcu_txn.h
index 2946c63fb044..b9ee242a01ce 100644
--- a/include/linux/rcu_txn.h
+++ b/include/linux/rcu_txn.h
@@ -363,6 +363,13 @@ static inline void *rcu_txn_resolve(void *v, unsigned long tag)
  */
 #define rcu_txn_dereference(p, tag)	rcu_txn_dereference_check(p, tag, 0)
 
+/*
+ * The optional lockdep condition of an iterator, as for
+ * list_for_each_entry_rcu(): the condition if one was given, else 0.
+ */
+#define __rcu_txn_cond(cond...)			___rcu_txn_cond(0, ## cond, 0)
+#define ___rcu_txn_cond(zero, cond, extra...)	((zero) || (cond))
+
 /**
  * rcu_txn_slot() - the engine's view of an RCU-protected pointer's address
  * @pp: address of an __rcu pointer, of any type
diff --git a/include/linux/rcu_txn_hlist.h b/include/linux/rcu_txn_hlist.h
new file mode 100644
index 000000000000..aecb1e4b94dc
--- /dev/null
+++ b/include/linux/rcu_txn_hlist.h
@@ -0,0 +1,483 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * RCU hlist edited through single-writer RCU pseudo-transactions
+ *
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+#ifndef _LINUX_RCU_TXN_HLIST_H
+#define _LINUX_RCU_TXN_HLIST_H
+
+/*
+ * rcu_txn_hlist: an RCU list with a single-pointer head, shaped like hlist, for
+ * a single writer (writers mutually excluded, as with hlist_add_head_rcu()).
+ * Its edits are recorded into a transaction of <linux/rcu_txn.h>, whose commit
+ * makes all of them, on one bucket or on many, visible to readers at once.
+ *
+ * Forward-only readers, and pprev
+ * -------------------------------
+ * A node's backward link is a pointer to the slot that points to it
+ * (&prev->next or &head->first), not to a node, so no operation has a head
+ * special case.
+ *
+ *   Node: { struct rcu_txn_hlist_node *next;    (node ptr; reader-visible)
+ *           struct rcu_txn_hlist_node **pprev;  (slot ptr; writer-only) }
+ *
+ * Readers walk forward only and never load pprev, so each operation has exactly
+ * one reader-visible edge: the next slot it re-points.
+ *
+ * Single updates and transactions
+ * -------------------------------
+ * The _rcu forms make a single update, outside of any transaction: they publish
+ * its one edge with rcu_assign_pointer(), as hlist_add_head_rcu() does, then
+ * write pprev with a plain store.  The writers are mutually excluded, and every
+ * transaction settles its slots before its commit returns, so the slots they
+ * read hold no proxy, and no other writer reads pprev in between.  A single
+ * update allocates nothing and cannot fail.
+ *
+ * The _prepare forms record into a transaction of the caller's, which may
+ * compose several updates, and which may fail or be cancelled.  They transact
+ * pprev too, as a slot of its own.  A later _prepare of the same transaction
+ * then loads its neighbour's pprev as the transaction leaves it, which is what
+ * makes edits of one bucket compose (see rcu_txn_hlist_del_prepare()), and a
+ * transaction that fails or is cancelled leaves every pprev as it was.  An
+ * update with a successor records two edges, and so takes the descriptor path
+ * at commit even alone: a single update is cheapest in its _rcu form.
+ *
+ * Composing edits of one hlist
+ * ----------------------------
+ * Operations whose neighbourhoods touch may share a transaction: each _prepare
+ * loads the slots it reads, next/first and pprev, as the transaction leaves
+ * them, and chains a second write to a slot onto the first.  Two rules remain
+ * for the caller:
+ *
+ *   - Look up the nodes before editing, rather than by traversing the list in
+ *     the middle of the transaction.
+ *
+ *   - Every node an operation is anchored on must still be in the list as the
+ *     transaction leaves it.  A single-writer delete leaves no deletion mark:
+ *     nothing in a deleted anchor distinguishes it from a live one.
+ *
+ *     Example: 1 -> 2 -> 3, del_prepare(2) then add_behind_prepare(9, 2).  The
+ *     delete records {&1->next: 2 -> 3} and {&3->pprev: &2->next -> &1->next}.
+ *     The add then records {&2->next: 3 -> 9}, and chains 3's pprev from
+ *     &2->next, where the delete left it at &1->next.  CONFIG_DEBUG_RCU_TXN
+ *     warns there, in rcu_txn_record_chain().  The commit still returns 0, and
+ *     the committed chain is 1 -> 3: node 9 is reachable only through the
+ *     removed node 2, and 3->pprev points to a slot that no live node holds.  A
+ *     later del_rcu(3) follows that pprev, commits into the unreachable node 9
+ *     and succeeds, while 1->next still points to 3, which the caller then
+ *     frees.
+ *
+ *     add_before and replace anchored on a deleted node chain onto the delete's
+ *     record of 1->next instead, where CONFIG_DEBUG_RCU_TXN warns as well, and
+ *     replace warns again on 3's pprev.  The commit links the deleted node, or
+ *     its replacement, back into the chain.
+ *
+ * Proxy tag
+ * ---------
+ * The slots, head->first, node->next and node->pprev, are transacted under
+ * RCU_TXN_HLIST_TAG, bit 0.  No live value a slot holds carries it: a slot
+ * holds NULL, the address of a node, or, for pprev, the address of a pointer.
+ *
+ * Read side
+ * ---------
+ * Iterate within an RCU read-side critical section, through
+ * rcu_txn_hlist_first_rcu() / _next_rcu() or the macros below.  Never use what
+ * rcu_dereference() returns for node->next directly: a slot may transiently
+ * hold a tagged proxy.
+ *
+ * Write side
+ * ----------
+ * Writers must be mutually excluded.  A removed node keeps its own next, so a
+ * reader standing on it still reaches the live chain; the caller reclaims it
+ * after a grace period, as with hlist_del_rcu().
+ *
+ * The add forms take a node that no reader can reach, and build its next with
+ * a plain store, so they cannot move a node.  To move an entry to another
+ * bucket, delete its node and add a copy's, in one transaction.
+ *
+ * A writer that excludes the others walks the chain with the same iterators,
+ * outside of an RCU read-side critical section, if it passes them a lockdep
+ * condition for that exclusion, such as lockdep_is_held() of its lock, as with
+ * hlist_for_each_entry_rcu(); rcu_txn_hlist_first_check(), _next_check() and
+ * rcu_txn_hlist_empty() take one too.
+ */
+
+#include <linux/build_bug.h>
+#include <linux/container_of.h>
+#include <linux/rcu_txn.h>
+#include <linux/rcupdate.h>
+
+/* Proxy tag of the slots, head->first, node->next and node->pprev. */
+#define RCU_TXN_HLIST_TAG	1UL
+
+/*
+ * Under a zero tag every plain value would pass for a proxy.  A tag beyond
+ * RCU_TXN_TAG_MASK would overlap the address of a record.
+ */
+static_assert(RCU_TXN_HLIST_TAG != 0 &&
+	      (RCU_TXN_HLIST_TAG & ~RCU_TXN_TAG_MASK) == 0);
+
+struct rcu_txn_hlist_node {
+	struct rcu_txn_hlist_node __rcu *next;		/* reader-visible */
+	struct rcu_txn_hlist_node __rcu * __rcu *pprev;	/* writer-only */
+};
+
+/* A bucket head is one pointer, like struct hlist_head. */
+struct rcu_txn_hlist_head {
+	struct rcu_txn_hlist_node __rcu *first;
+};
+
+#define RCU_TXN_HLIST_HEAD_INIT	{ .first = NULL }
+
+static inline void rcu_txn_hlist_init(struct rcu_txn_hlist_head *head)
+{
+	RCU_INIT_POINTER(head->first, NULL);
+}
+
+/*
+ * First node and forward step, within an RCU read-side critical section or
+ * where @c, a lockdep condition, holds.
+ */
+#define rcu_txn_hlist_first_check(head, c)				\
+	rcu_txn_dereference_check((head)->first, RCU_TXN_HLIST_TAG, c)
+
+#define rcu_txn_hlist_next_check(node, c)				\
+	rcu_txn_dereference_check((node)->next, RCU_TXN_HLIST_TAG, c)
+
+/* First node and forward step, for use within an RCU read-side section. */
+static inline struct rcu_txn_hlist_node *
+rcu_txn_hlist_first_rcu(struct rcu_txn_hlist_head *head)
+{
+	return rcu_txn_dereference(head->first, RCU_TXN_HLIST_TAG);
+}
+
+static inline struct rcu_txn_hlist_node *
+rcu_txn_hlist_next_rcu(struct rcu_txn_hlist_node *node)
+{
+	return rcu_txn_dereference(node->next, RCU_TXN_HLIST_TAG);
+}
+
+/*
+ * True iff the chain is empty, within an RCU read-side critical section or
+ * where @cond, an optional lockdep condition, holds.
+ *
+ * Unlike hlist_empty(), which is a plain load, this needs one or the other:
+ * while a commit of two records or more is in flight on head->first, the slot
+ * holds a proxy, and telling an empty chain from another then reads the
+ * transaction's descriptor, which is freed after a grace period.  A writer that
+ * excludes the others finds no proxy there, and passes a lockdep condition for
+ * that exclusion as @cond.
+ */
+#define rcu_txn_hlist_empty(head, cond...)				\
+	(!rcu_txn_hlist_first_check(head, __rcu_txn_cond(cond)))
+
+/*
+ * Write-side read of a head->first or node->next slot: this transaction's
+ * pending write to it if it recorded one, else the slot's committed value.  A
+ * typed wrapper over rcu_txn_load().  The _prepare forms read every forward
+ * link through this, which is what lets edits compose on one bucket (see
+ * rcu_txn_hlist_del_prepare()).  Readers use rcu_txn_hlist_first_rcu() /
+ * _next_rcu() instead.
+ */
+static inline struct rcu_txn_hlist_node *
+rcu_txn_hlist_pending_next(struct rcu_txn *txn,
+			   struct rcu_txn_hlist_node __rcu **slot)
+{
+	return rcu_txn_load(txn, rcu_txn_slot(slot), RCU_TXN_HLIST_TAG);
+}
+
+/* The pprev counterpart of rcu_txn_hlist_pending_next(). */
+static inline struct rcu_txn_hlist_node __rcu **
+__rcu_txn_hlist_pending_pprev(struct rcu_txn *txn,
+			      struct rcu_txn_hlist_node *node)
+{
+	return rcu_txn_load(txn, rcu_txn_slot(&node->pprev), RCU_TXN_HLIST_TAG);
+}
+
+/*
+ * Record that @node's pprev, @old as the transaction leaves it so far, becomes
+ * @new.
+ */
+static inline void
+__rcu_txn_hlist_record_pprev(struct rcu_txn *txn,
+			     struct rcu_txn_hlist_node *node,
+			     struct rcu_txn_hlist_node __rcu **old,
+			     struct rcu_txn_hlist_node __rcu **new)
+{
+	rcu_txn_record_chain(txn, rcu_txn_slot(&node->pprev), old, new,
+			     RCU_TXN_HLIST_TAG);
+}
+
+/**
+ * rcu_txn_hlist_insert_at_slot_prepare() - record an insertion at a slot
+ * @txn: the transaction
+ * @new: the node to insert
+ * @slot: the address of head->first, to insert at the head, or of pos->next,
+ *        to insert behind @pos
+ * @succ: the node @slot points to as this transaction leaves it, or NULL
+ *
+ * Record the edge that makes @slot point to @new, without committing.  When
+ * @succ is non-NULL, its pprev becomes the address of new->next.
+ *
+ * @succ must be read with rcu_txn_hlist_pending_next(): @new is built pointing
+ * at it, and a value read directly would link @new behind a node that an
+ * earlier edit of the same transaction displaced.  The add_head and add_behind
+ * forms below do so.
+ */
+static inline void
+rcu_txn_hlist_insert_at_slot_prepare(struct rcu_txn *txn,
+				     struct rcu_txn_hlist_node *new,
+				     struct rcu_txn_hlist_node __rcu **slot,
+				     struct rcu_txn_hlist_node *succ)
+{
+	/* Build the fresh node's links before it becomes reachable. */
+	RCU_INIT_POINTER(new->next, succ);
+	RCU_INIT_POINTER(new->pprev, slot);
+
+	rcu_txn_record_chain(txn, rcu_txn_slot(slot), succ, new,
+			     RCU_TXN_HLIST_TAG);
+	if (succ)
+		__rcu_txn_hlist_record_pprev(txn, succ, slot, &new->next);
+}
+
+/**
+ * rcu_txn_hlist_add_head_prepare() - record an insertion at the head
+ * @txn: the transaction
+ * @new: the node to insert
+ * @head: the list
+ *
+ * See rcu_txn_hlist_insert_at_slot_prepare().
+ */
+static inline void
+rcu_txn_hlist_add_head_prepare(struct rcu_txn *txn,
+			       struct rcu_txn_hlist_node *new,
+			       struct rcu_txn_hlist_head *head)
+{
+	struct rcu_txn_hlist_node *first =
+			rcu_txn_hlist_pending_next(txn, &head->first);
+
+	rcu_txn_hlist_insert_at_slot_prepare(txn, new, &head->first, first);
+}
+
+/**
+ * rcu_txn_hlist_add_behind_prepare() - record an insertion behind a node
+ * @txn: the transaction
+ * @new: the node to insert
+ * @pos: the node to insert it behind
+ *
+ * See rcu_txn_hlist_insert_at_slot_prepare().
+ */
+static inline void
+rcu_txn_hlist_add_behind_prepare(struct rcu_txn *txn,
+				 struct rcu_txn_hlist_node *new,
+				 struct rcu_txn_hlist_node *pos)
+{
+	struct rcu_txn_hlist_node *next =
+			rcu_txn_hlist_pending_next(txn, &pos->next);
+
+	rcu_txn_hlist_insert_at_slot_prepare(txn, new, &pos->next, next);
+}
+
+/**
+ * rcu_txn_hlist_add_before_prepare() - record an insertion before a node
+ * @txn: the transaction
+ * @new: the node to insert
+ * @pos: the node to insert it before
+ *
+ * @pos's pprev points to the slot to re-point.
+ */
+static inline void
+rcu_txn_hlist_add_before_prepare(struct rcu_txn *txn,
+				 struct rcu_txn_hlist_node *new,
+				 struct rcu_txn_hlist_node *pos)
+{
+	struct rcu_txn_hlist_node __rcu **slot =
+			__rcu_txn_hlist_pending_pprev(txn, pos);
+
+	RCU_INIT_POINTER(new->next, pos);
+	RCU_INIT_POINTER(new->pprev, slot);
+
+	rcu_txn_record_chain(txn, rcu_txn_slot(slot), pos, new,
+			     RCU_TXN_HLIST_TAG);
+	__rcu_txn_hlist_record_pprev(txn, pos, slot, &new->next);
+}
+
+/**
+ * rcu_txn_hlist_del_prepare() - record the unlink of a node
+ * @txn: the transaction
+ * @elem: the node to unlink
+ *
+ * @elem's own next and pprev are left as they are, so a reader standing on it
+ * still reaches the live chain; the caller frees @elem a grace period after the
+ * commit.
+ *
+ * Composing on one bucket, by example: delete the adjacent A and B from head ->
+ * A -> B -> C in one transaction, a record being written {slot: old -> new}.
+ * del(A) records {head->first: A -> B}, and that B's pprev now points to
+ * head->first.  del(B) loads B's pprev as the transaction leaves it and finds
+ * head->first, not the stale A->next, so it records against head->first, finds
+ * it recorded, and chains: {head->first: A -> C}.  It then records that C's
+ * pprev points to head->first.
+ *
+ * Had del(B) read B->pprev directly, it would have found A->next, a slot inside
+ * the node that del(A) unlinks, and head->first would be left pointing to the
+ * deleted B.
+ */
+static inline void rcu_txn_hlist_del_prepare(struct rcu_txn *txn,
+					     struct rcu_txn_hlist_node *elem)
+{
+	struct rcu_txn_hlist_node *next =
+			rcu_txn_hlist_pending_next(txn, &elem->next);
+	struct rcu_txn_hlist_node __rcu **ppv =
+			__rcu_txn_hlist_pending_pprev(txn, elem);
+
+	rcu_txn_record_chain(txn, rcu_txn_slot(ppv), elem, next,
+			     RCU_TXN_HLIST_TAG);
+	if (next)
+		__rcu_txn_hlist_record_pprev(txn, next, &elem->next, ppv);
+}
+
+/**
+ * rcu_txn_hlist_replace_prepare() - record the replacement of a node
+ * @txn: the transaction
+ * @old: the node to replace
+ * @new: the node that replaces it
+ *
+ * @new takes @old's slot and successor, and @old keeps its own next for readers
+ * standing on it.  Arguments are (old, new), as hlist_replace_rcu().
+ */
+static inline void rcu_txn_hlist_replace_prepare(struct rcu_txn *txn,
+						 struct rcu_txn_hlist_node *old,
+						 struct rcu_txn_hlist_node *new)
+{
+	struct rcu_txn_hlist_node *next =
+			rcu_txn_hlist_pending_next(txn, &old->next);
+	struct rcu_txn_hlist_node __rcu **ppv =
+			__rcu_txn_hlist_pending_pprev(txn, old);
+
+	RCU_INIT_POINTER(new->next, next);
+	RCU_INIT_POINTER(new->pprev, ppv);
+
+	rcu_txn_record_chain(txn, rcu_txn_slot(ppv), old, new,
+			     RCU_TXN_HLIST_TAG);
+	if (next)
+		__rcu_txn_hlist_record_pprev(txn, next, &old->next,
+					     &new->next);
+}
+
+/*
+ * The _rcu forms: each makes a single update, outside of any transaction.  See
+ * "Single updates and transactions" above.
+ */
+
+/*
+ * Read a head->first or node->next slot outside of any transaction.
+ * CONFIG_DEBUG_RCU_TXN checks that it holds no proxy: one would be another
+ * writer's, in the middle of its commit.
+ */
+static inline struct rcu_txn_hlist_node *
+__rcu_txn_hlist_load(struct rcu_txn_hlist_node __rcu **slot)
+{
+	struct rcu_txn_hlist_node *v = rcu_dereference_protected(*slot, 1);
+
+	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(v, RCU_TXN_HLIST_TAG));
+	return v;
+}
+
+/* A node's pprev, which only the writers access, outside of any transaction. */
+static inline struct rcu_txn_hlist_node __rcu **
+__rcu_txn_hlist_pprev(struct rcu_txn_hlist_node *node)
+{
+	return rcu_dereference_protected(node->pprev, 1);
+}
+
+static inline void
+__rcu_txn_hlist_insert_at_slot_rcu(struct rcu_txn_hlist_node *new,
+				   struct rcu_txn_hlist_node __rcu **slot)
+{
+	struct rcu_txn_hlist_node *succ = __rcu_txn_hlist_load(slot);
+
+	RCU_INIT_POINTER(new->next, succ);
+	RCU_INIT_POINTER(new->pprev, slot);
+	rcu_assign_pointer(*slot, new);
+	if (succ)
+		RCU_INIT_POINTER(succ->pprev, &new->next);
+}
+
+static inline void rcu_txn_hlist_add_head_rcu(struct rcu_txn_hlist_node *new,
+					      struct rcu_txn_hlist_head *head)
+{
+	__rcu_txn_hlist_insert_at_slot_rcu(new, &head->first);
+}
+
+static inline void rcu_txn_hlist_add_behind_rcu(struct rcu_txn_hlist_node *new,
+						struct rcu_txn_hlist_node *pos)
+{
+	__rcu_txn_hlist_insert_at_slot_rcu(new, &pos->next);
+}
+
+static inline void rcu_txn_hlist_add_before_rcu(struct rcu_txn_hlist_node *new,
+						struct rcu_txn_hlist_node *pos)
+{
+	struct rcu_txn_hlist_node __rcu **slot = __rcu_txn_hlist_pprev(pos);
+
+	RCU_INIT_POINTER(new->next, pos);
+	RCU_INIT_POINTER(new->pprev, slot);
+	rcu_assign_pointer(*slot, new);
+	RCU_INIT_POINTER(pos->pprev, &new->next);
+}
+
+static inline void rcu_txn_hlist_del_rcu(struct rcu_txn_hlist_node *elem)
+{
+	struct rcu_txn_hlist_node __rcu **ppv = __rcu_txn_hlist_pprev(elem);
+	struct rcu_txn_hlist_node *next = __rcu_txn_hlist_load(&elem->next);
+
+	rcu_assign_pointer(*ppv, next);
+	if (next)
+		RCU_INIT_POINTER(next->pprev, ppv);
+}
+
+static inline void rcu_txn_hlist_replace_rcu(struct rcu_txn_hlist_node *old,
+					     struct rcu_txn_hlist_node *new)
+{
+	struct rcu_txn_hlist_node __rcu **ppv = __rcu_txn_hlist_pprev(old);
+	struct rcu_txn_hlist_node *next = __rcu_txn_hlist_load(&old->next);
+
+	RCU_INIT_POINTER(new->next, next);
+	RCU_INIT_POINTER(new->pprev, ppv);
+	rcu_assign_pointer(*ppv, new);
+	if (next)
+		RCU_INIT_POINTER(next->pprev, &new->next);
+}
+
+#define rcu_txn_hlist_entry(ptr, type, member)				\
+	container_of(ptr, type, member)
+
+#define rcu_txn_hlist_entry_safe(ptr, type, member)			\
+({									\
+	typeof(ptr) ____ptr = (ptr);					\
+									\
+	____ptr ? rcu_txn_hlist_entry(____ptr, type, member) : NULL;	\
+})
+
+/*
+ * Iterate forward over a bucket, within an RCU read-side critical section, or
+ * where @cond, an optional lockdep condition, holds.
+ */
+#define rcu_txn_hlist_for_each_rcu(pos, head, cond...)			\
+	for (pos = rcu_txn_hlist_first_check(head, __rcu_txn_cond(cond)); \
+	     pos;							\
+	     pos = rcu_txn_hlist_next_check(pos, __rcu_txn_cond(cond)))
+
+#define rcu_txn_hlist_for_each_entry_rcu(pos, head, member, cond...)	\
+	for (pos = rcu_txn_hlist_entry_safe(				\
+			rcu_txn_hlist_first_check(head, __rcu_txn_cond(cond)), \
+			typeof(*(pos)), member);			\
+	     pos;							\
+	     pos = rcu_txn_hlist_entry_safe(				\
+			rcu_txn_hlist_next_check(&(pos)->member,	\
+						 __rcu_txn_cond(cond)),	\
+			typeof(*(pos)), member))
+
+#endif /* _LINUX_RCU_TXN_HLIST_H */
diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
index 3f005cdee4d0..13e4bbae1053 100644
--- a/lib/tests/rcu_txn_kunit.c
+++ b/lib/tests/rcu_txn_kunit.c
@@ -8,6 +8,7 @@
 #include <kunit/test.h>
 #include <linux/bug.h>
 #include <linux/rcu_txn.h>
+#include <linux/rcu_txn_hlist.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/task.h>
 #include <linux/string.h>
@@ -913,6 +914,387 @@ static void rcu_txn_test_debug_load_proxy(struct kunit *test)
 	rcu_txn_cancel(&txn);
 }
 
+/*
+ * <linux/rcu_txn_hlist.h>
+ */
+
+struct hn {
+	struct rcu_txn_hlist_node node;
+	int key;
+};
+
+/* Freed with the test: a removed node stays valid for any reader. */
+static struct rcu_txn_hlist_node *hn_new(struct kunit *test, int key)
+{
+	struct hn *n = kunit_kzalloc(test, sizeof(*n), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, n);
+	n->key = key;
+	return &n->node;
+}
+
+/* Build the list @keys by prepending in reverse. */
+static void hlist_build(struct kunit *test, struct rcu_txn_hlist_head *head,
+			const int *keys, int nr)
+{
+	int i;
+
+	for (i = nr - 1; i >= 0; i--)
+		rcu_txn_hlist_add_head_rcu(hn_new(test, keys[i]), head);
+}
+
+/* The test is the chain's only writer, and owns every node until it ends. */
+static struct rcu_txn_hlist_node *hlist_find(struct rcu_txn_hlist_head *head,
+					     int key)
+{
+	struct hn *n;
+
+	rcu_txn_hlist_for_each_entry_rcu(n, head, node, true)
+		if (n->key == key)
+			return &n->node;
+	return NULL;
+}
+
+/*
+ * The forward walk gives @want, and each node's pprev points to the slot that
+ * points to it: &head->first for the first node, &prev->next thereafter.  A
+ * torn pprev is invisible to the forward walk but breaks the next edit, hence
+ * the separate check.
+ */
+static void hlist_expect(struct kunit *test, struct rcu_txn_hlist_head *head,
+			 const int *want, int nr)
+{
+	struct rcu_txn_hlist_node __rcu **slot = &head->first;
+	struct rcu_txn_hlist_node *p;
+	int i = 0;
+
+	rcu_txn_hlist_for_each_rcu(p, head, true) {
+		if (i < nr)
+			KUNIT_EXPECT_EQ(test,
+					container_of(p, struct hn, node)->key,
+					want[i]);
+		KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(p->pprev), slot);
+		slot = &p->next;
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, nr);
+}
+
+static void rcu_txn_test_hlist_add(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int behind[] = { 1, 2, 9, 3 };
+	static const int before[] = { 1, 8, 2, 9, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+
+	KUNIT_EXPECT_TRUE(test, rcu_txn_hlist_empty(&head, true));
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	hlist_expect(test, &head, keys, ARRAY_SIZE(keys));
+
+	rcu_txn_hlist_add_behind_rcu(hn_new(test, 9), hlist_find(&head, 2));
+	hlist_expect(test, &head, behind, ARRAY_SIZE(behind));
+
+	rcu_txn_hlist_add_before_rcu(hn_new(test, 8), hlist_find(&head, 2));
+	hlist_expect(test, &head, before, ARRAY_SIZE(before));
+}
+
+static void rcu_txn_test_hlist_del(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int middle[] = { 1, 2, 4, 5 };
+	static const int ends[] = { 2, 4 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *removed;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	removed = hlist_find(&head, 3);
+	rcu_txn_hlist_del_rcu(removed);
+	hlist_expect(test, &head, middle, ARRAY_SIZE(middle));
+	/* A reader standing on the removed node still reaches the chain. */
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_hlist_next_check(removed, true),
+			    hlist_find(&head, 4));
+
+	rcu_txn_hlist_del_rcu(hlist_find(&head, 1));	/* first */
+	rcu_txn_hlist_del_rcu(hlist_find(&head, 5));	/* last */
+	hlist_expect(test, &head, ends, ARRAY_SIZE(ends));
+}
+
+static void rcu_txn_test_hlist_replace(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 1, 22, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	rcu_txn_hlist_replace_rcu(hlist_find(&head, 2), hn_new(test, 22));
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Composition on one bucket, with neighbourhoods that touch: the case the
+ * _prepare forms read their own writes for.
+ */
+
+/* Delete the adjacent 2 and 3 from 1..5 in one transaction. */
+static void rcu_txn_test_hlist_compose_adjacent_del(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int want[] = { 1, 4, 5 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e2, *e3;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	e2 = hlist_find(&head, 2);
+	e3 = hlist_find(&head, 3);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, e2);
+	rcu_txn_hlist_del_prepare(&txn, e3);	/* the neighbour of e2 */
+	/* &1->next, chained, and the pprev of 3 and of 4. */
+	KUNIT_EXPECT_EQ(test, txn.nr, 3);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/* Delete 2 and insert 9 into the same gap, behind 1, in one transaction. */
+static void rcu_txn_test_hlist_compose_del_and_add(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 1, 9, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e1, *e2;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	e1 = hlist_find(&head, 1);
+	e2 = hlist_find(&head, 2);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, e2);
+	rcu_txn_hlist_add_behind_prepare(&txn, hn_new(test, 9), e1);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/* Three consecutive deletes in one transaction: &1->next is chained twice. */
+static void rcu_txn_test_hlist_compose_triple_del(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int want[] = { 1, 5 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e[3];
+	struct rcu_txn txn;
+	int i;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	for (i = 0; i < ARRAY_SIZE(e); i++)
+		e[i] = hlist_find(&head, i + 2);	/* 2, 3, 4 */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	for (i = 0; i < ARRAY_SIZE(e); i++)
+		rcu_txn_hlist_del_prepare(&txn, e[i]);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Insert 9 behind 1, then delete 1, in that order: the fresh node inherits
+ * &1->next as the slot that points to it, and the next operation removes the
+ * node that slot lives in.  add_behind must have recorded &9->next as 2's
+ * pprev, and del(1) must then re-point head->first to the pending 9 rather than
+ * to the committed 2, and record &head->first as 9's pprev.
+ *
+ * A wrong pprev for 2 leaves the forward order intact here: only the pprev
+ * check catches it.
+ */
+static void rcu_txn_test_hlist_compose_add_then_del_host(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 9, 2, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e1;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	e1 = hlist_find(&head, 1);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_add_behind_prepare(&txn, hn_new(test, 9), e1);
+	rcu_txn_hlist_del_prepare(&txn, e1);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Delete the first node, then insert before its successor.  add_before loads
+ * 2's pprev as the transaction leaves it, &head->first, which del(1) recorded.
+ * The committed &1->next would publish head->first == 1.
+ */
+static void rcu_txn_test_hlist_compose_del_then_add_before(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 9, 2, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e1, *e2;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	e1 = hlist_find(&head, 1);
+	e2 = hlist_find(&head, 2);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, e1);
+	rcu_txn_hlist_add_before_prepare(&txn, hn_new(test, 9), e2);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Two buckets in one transaction: a node leaves one and its replacement
+ * enters the other.  The edges are installed as proxies, so that at any instant
+ * the key is in exactly one bucket.
+ */
+static void rcu_txn_test_hlist_move(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int from[] = { 1, 3 };
+	static const int to[] = { 2 };
+	struct rcu_txn_hlist_head a = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_head b = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn txn;
+
+	hlist_build(test, &a, keys, ARRAY_SIZE(keys));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, hlist_find(&a, 2));
+	rcu_txn_hlist_add_head_prepare(&txn, hn_new(test, 2), &b);
+	/* The two forward edges, and the pprev of 3. */
+	KUNIT_EXPECT_EQ(test, txn.nr, 3);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &a, from, ARRAY_SIZE(from));
+	hlist_expect(test, &b, to, ARRAY_SIZE(to));
+}
+
+/*
+ * One _prepare alone: an update with a successor records its forward edge and
+ * the successor's pprev, and commits through the descriptor.
+ */
+static void rcu_txn_test_hlist_prepare_alone(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 1, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, hlist_find(&head, 2));
+	KUNIT_EXPECT_EQ(test, txn.nr, 2);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Every kind of edit in one transaction over 1..5: del(2), add_behind(9, 1),
+ * replace(4, 44), add_before(8, 5).  The last re-points the slot that the
+ * replace made 5's, inside the fresh node 44, and so loads 5's pending pprev
+ * to find it.
+ */
+static void hlist_prepare_mixed(struct kunit *test, struct rcu_txn *txn,
+				struct rcu_txn_hlist_head *head)
+{
+	struct rcu_txn_hlist_node *e1 = hlist_find(head, 1);
+	struct rcu_txn_hlist_node *e2 = hlist_find(head, 2);
+	struct rcu_txn_hlist_node *e4 = hlist_find(head, 4);
+	struct rcu_txn_hlist_node *e5 = hlist_find(head, 5);
+
+	rcu_txn_hlist_del_prepare(txn, e2);
+	rcu_txn_hlist_add_behind_prepare(txn, hn_new(test, 9), e1);
+	rcu_txn_hlist_replace_prepare(txn, e4, hn_new(test, 44));
+	rcu_txn_hlist_add_before_prepare(txn, hn_new(test, 8), e5);
+}
+
+static void rcu_txn_test_hlist_compose_mixed(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int want[] = { 1, 9, 3, 44, 8, 5 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	hlist_prepare_mixed(test, &txn, &head);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * The same transaction, cancelled: nothing was written outside it, so the chain
+ * and every pprev are as they were.  A later single update then finds the
+ * pprev it relies on.
+ */
+static void rcu_txn_test_hlist_cancel(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int want[] = { 1, 2, 4, 5 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	hlist_prepare_mixed(test, &txn, &head);
+	rcu_txn_cancel(&txn);
+	hlist_expect(test, &head, keys, ARRAY_SIZE(keys));
+
+	rcu_txn_hlist_del_rcu(hlist_find(&head, 3));
+	hlist_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Out of memory after two edits, the sticky state set by hand as a failed
+ * record() leaves it: commit() reports it and publishes nothing, and the edits
+ * recorded before the failure leave no pprev behind either.
+ */
+static void rcu_txn_test_hlist_oom(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e1, *e2, *e4;
+	struct rcu_txn txn;
+
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	e1 = hlist_find(&head, 1);
+	e2 = hlist_find(&head, 2);
+	e4 = hlist_find(&head, 4);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, e2);
+	rcu_txn_hlist_add_behind_prepare(&txn, hn_new(test, 9), e1);
+	txn.state = RCU_TXN_OOM;
+	rcu_txn_hlist_replace_prepare(&txn, e4, hn_new(test, 44));
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), -ENOMEM);
+	hlist_expect(test, &head, keys, ARRAY_SIZE(keys));
+}
+
+/*
+ * An add_behind anchored on a node that the same transaction deleted: it
+ * records the successor's pprev from a slot that the delete already moved it
+ * from.
+ */
+static void rcu_txn_test_hlist_debug_ghost_anchor(struct kunit *test)
+{
+	static const int keys[] = { 1, 2, 3 };
+	struct rcu_txn_hlist_head head = RCU_TXN_HLIST_HEAD_INIT;
+	struct rcu_txn_hlist_node *e2;
+	struct rcu_txn txn;
+
+	need_debug(test);
+	hlist_build(test, &head, keys, ARRAY_SIZE(keys));
+	e2 = hlist_find(&head, 2);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_hlist_del_prepare(&txn, e2);
+	kunit_warning_suppress(test) {
+		rcu_txn_hlist_add_behind_prepare(&txn, hn_new(test, 9), e2);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+	hlist_expect(test, &head, keys, ARRAY_SIZE(keys));
+}
+
 static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_single_record),
 	KUNIT_CASE(rcu_txn_test_multi_record),
@@ -946,6 +1328,20 @@ static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_debug_disjoint),
 	KUNIT_CASE(rcu_txn_test_debug_stale_chain),
 	KUNIT_CASE(rcu_txn_test_debug_load_proxy),
+	KUNIT_CASE(rcu_txn_test_hlist_add),
+	KUNIT_CASE(rcu_txn_test_hlist_del),
+	KUNIT_CASE(rcu_txn_test_hlist_replace),
+	KUNIT_CASE(rcu_txn_test_hlist_compose_adjacent_del),
+	KUNIT_CASE(rcu_txn_test_hlist_compose_del_and_add),
+	KUNIT_CASE(rcu_txn_test_hlist_compose_triple_del),
+	KUNIT_CASE(rcu_txn_test_hlist_compose_add_then_del_host),
+	KUNIT_CASE(rcu_txn_test_hlist_compose_del_then_add_before),
+	KUNIT_CASE(rcu_txn_test_hlist_move),
+	KUNIT_CASE(rcu_txn_test_hlist_prepare_alone),
+	KUNIT_CASE(rcu_txn_test_hlist_compose_mixed),
+	KUNIT_CASE(rcu_txn_test_hlist_cancel),
+	KUNIT_CASE(rcu_txn_test_hlist_oom),
+	KUNIT_CASE(rcu_txn_test_hlist_debug_ghost_anchor),
 	{}
 };
 
-- 
2.47.3

