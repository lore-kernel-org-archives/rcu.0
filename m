Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC334D8DA2;
	Fri, 16 Oct 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157624; cv=none; b=M7nQvg3SdCtvd6Qu5jFrVtNiSGWvnA2dsj53LNVk/LvhVTl3MZkyQDIqG1sdjIt47YA81V1L3USG/HXckexW5IEILaDeGh9YqB1OvbAyPuXdSq0VP8MXHq/6oEYnJp/CJy5SkYyiVfqekPh5EFOLoptB3Pm+efK6qWDrBflAUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157624; c=relaxed/simple;
	bh=nrZq35NhN4FyB3hND1IIau3GHUShNVlfSt8Kai4MFHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R7Xqjry0sSHLKJ5DmANCDZsvBhm0UKvBcN7RLQnqVSGx3XhsiGCa32ge4hAXMgH74wXw3Mf4LEjzy24llXDxoZ6PjYbgKnekFJgdEN7jYii7jHA9nFzSO4APDYrYA4we9ZiutpIyZCyW/fcE9L3ElBNaRrrHz1oYHWoBzu1RwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=un9u8ye8; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="un9u8ye8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157608;
	bh=cefOYkFMokqeskA622zUxv9LOnOvt6funnS7nklqDQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=un9u8ye8iR/HjEJtT2T2rauBSEzXBfBISAQ6QdwQJ75FkN8eknrvMxOv8dnpWzphf
	 nmrUpjmX5gs4l/nSgjwkY2X2knDdkzGYFEYbBHl3bBllHQ3tZa/C+1AMbn0VVA4nLF
	 zPpTJ77bvYmo8hzhvChc/tJ7V6lPiFonJhBrr4Cz0KelveEU28zI5pC8PpC1uY4ZPI
	 LSaKW9FtSyN9IAue6FmdChrbXirO5J60tyVgN14RtEexBJseetIdToEt7m7TIpkCT9
	 jheVmS2giIoDXJk/SnB59KS9cONCcRdPf6PfJgsyZwi7ePPjQ+nQHFKr7kccK16nhn
	 zbTvaQl9KgbLQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9N0X98zmKb;
	Fri, 16 Oct 2026 09:33:28 -0400 (EDT)
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
Subject: [RFC PATCH 06/12] rcu_txn: Add a doubly-linked list coherent in both directions
Date: Fri, 16 Oct 2026 09:33:13 -0400
Message-Id: <20261016133319.433617-7-mathieu.desnoyers@efficios.com>
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

An update of a doubly-linked list re-points a forward and a backward
edge.  The RCU list does it with two stores, so a reader that walks in
both directions (list_bidir_prev_rcu()) can find the new forward edge
and then the old backward edge: having stepped forward over a node just
inserted, a step back can skip it.

Add rcu_txn_list, a circular doubly-linked list that commits both edges
of each operation as one RCU pseudo-transaction.  At every instant,
a->next == b implies b->prev == a for the nodes of the list, and a
reader walking from node to node never finds the new value of an edge
and then the old value of the other.

Every operation switches two slots, so it installs proxies and allocates
a descriptor: the _rcu forms take a gfp_t and may return -ENOMEM,
leaving the list unchanged.  The _prepare forms record into a
transaction of the caller's, which can be reserved beforehand and can
compose several operations, on this list or with other structures.

A node moves with rcu_txn_list_move_after_prepare() and
_before_prepare(), and the _rcu forms move_after, move_before, move (to
the front) and move_tail.  A move records six edges: the two that unlink
the node, the two that link it at its new place, and the node's own next
and prev, which a reader standing on the node follows.  The add forms
cannot move a node, as they build its links with plain stores.  A move
to where the node already is records nothing.

Its iterators and rcu_txn_list_empty() take the same optional lockdep
condition as those of rcu_txn_hlist, and rcu_txn_list_next_check() and
_prev_check() are the accessors that take one.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/rcu_txn_hlist.h |   7 +-
 include/linux/rcu_txn_list.h  | 544 ++++++++++++++++++++++++++++++++++
 lib/tests/rcu_txn_kunit.c     | 402 +++++++++++++++++++++++++
 3 files changed, 951 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/rcu_txn_list.h

diff --git a/include/linux/rcu_txn_hlist.h b/include/linux/rcu_txn_hlist.h
index aecb1e4b94dc..070ccc131b76 100644
--- a/include/linux/rcu_txn_hlist.h
+++ b/include/linux/rcu_txn_hlist.h
@@ -11,7 +11,9 @@
  * rcu_txn_hlist: an RCU list with a single-pointer head, shaped like hlist, for
  * a single writer (writers mutually excluded, as with hlist_add_head_rcu()).
  * Its edits are recorded into a transaction of <linux/rcu_txn.h>, whose commit
- * makes all of them, on one bucket or on many, visible to readers at once.
+ * makes all of them, on one bucket or on many, visible to readers at once.  It
+ * is the hash-bucket sibling of the circular <linux/rcu_txn_list.h>: its head
+ * is one pointer, half the footprint of a sentinel-node head.
  *
  * Forward-only readers, and pprev
  * -------------------------------
@@ -23,7 +25,8 @@
  *           struct rcu_txn_hlist_node **pprev;  (slot ptr; writer-only) }
  *
  * Readers walk forward only and never load pprev, so each operation has exactly
- * one reader-visible edge: the next slot it re-points.
+ * one reader-visible edge: the next slot it re-points.  This is where the hlist
+ * differs from <linux/rcu_txn_list.h>, whose prev is reader-visible.
  *
  * Single updates and transactions
  * -------------------------------
diff --git a/include/linux/rcu_txn_list.h b/include/linux/rcu_txn_list.h
new file mode 100644
index 000000000000..6d99186e1ecf
--- /dev/null
+++ b/include/linux/rcu_txn_list.h
@@ -0,0 +1,544 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * RCU doubly-linked list whose two directions stay coherent
+ *
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+#ifndef _LINUX_RCU_TXN_LIST_H
+#define _LINUX_RCU_TXN_LIST_H
+
+/*
+ * rcu_txn_list: a circular doubly-linked list whose forward and backward
+ * chains stay mutually coherent under concurrent RCU readers.  A reader may
+ * iterate in either direction, or reverse direction mid-traversal, and never
+ * observe the two directions disagree.
+ *
+ * Why this is not just <linux/rculist.h>
+ * --------------------------------------
+ * The classic RCU list publishes the forward chain.  list_del_rcu() poisons
+ * the removed entry's prev, and where a backward walk is allowed
+ * (list_bidir_prev_rcu(), with list_bidir_del_rcu()), the forward and the
+ * backward edge of an update are still two stores.  Between them a reader sees
+ * one direction changed and not the other, so a step forward followed by a
+ * step backward need not bring it back to where it was.
+ *
+ * Every insertion into or deletion from a doubly-linked list re-points exactly
+ * two reader-visible edges, one forward and one backward:
+ *
+ *   insert E between P and N:   P->next: N -> E   and   N->prev: P -> E
+ *   delete E between P and N:   P->next: E -> N   and   N->prev: E -> P
+ *
+ * A move of E from between P and N to between Q and R re-points six: those of
+ * the delete and of the insert, and E's own next and prev, which a reader
+ * standing on E follows.
+ *
+ * rcu_txn_list commits both edges as one RCU pseudo-transaction
+ * (<linux/rcu_txn.h>): the two slots transiently hold tagged proxies that
+ * share one selector, and one store-release switches both edges from old to
+ * new.  At every instant the forward and backward chains describe the same
+ * list.
+ *
+ * Coherence guarantee
+ * -------------------
+ * For any two nodes that are both members of the list at the instant they are
+ * resolved, the links are mutual inverses: a->next == b implies b->prev == a.
+ * No operation exposes a window where one direction sees a change and the other
+ * does not.
+ *
+ * As with any RCU structure, this does not freeze the list for a long-lived
+ * reader: it may observe an operation that commits during its walk.  What it
+ * observes is coherent in both directions at each step.
+ *
+ * Coherence is a property of one resolution.  Carrying it across two
+ * resolutions needs an ordering between them, which a dependency-chained walk
+ * has (next-then-next, or a prev hop taken from the node the previous load
+ * returned).  A reader comparing two independently-reached slots must supply
+ * its own acquire on weakly-ordered hardware; see the monotonicity note in
+ * <linux/rcu_txn.h>.
+ *
+ * A removed node keeps its own next/prev pointing at its former neighbours, so
+ * a reader standing on it can still reach the live list in either direction,
+ * but the live list no longer points back at it.  The caller reclaims the node
+ * after a grace period, as with list_del_rcu().
+ *
+ * Read side
+ * ---------
+ * Iterate within an RCU read-side critical section.  A slot may transiently
+ * hold a tagged proxy, so next/prev must be read through
+ * rcu_txn_list_next_rcu() / rcu_txn_list_prev_rcu() or the iterators below,
+ * never directly.  This is also why the node type is distinct from struct
+ * list_head: the list_*_rcu accessors do not resolve proxies.
+ *
+ * Write side
+ * ----------
+ * Writers must be mutually excluded, as with list_add_rcu().  Each mutator
+ * records its edges in a transaction, a forward and a backward one or six for
+ * a move, and commits them together.  Such a transaction installs proxies, so
+ * it allocates a descriptor: an _rcu mutator takes a gfp_t and returns 0, or
+ * -ENOMEM if the transaction could not be allocated, in which case the list is
+ * unchanged.  A writer that cannot fail there reserves its transaction first
+ * and uses the _prepare forms.
+ *
+ * A writer that excludes the others walks the list with the same iterators,
+ * outside of an RCU read-side critical section, if it passes them a lockdep
+ * condition for that exclusion, such as lockdep_is_held() of its lock, as with
+ * list_for_each_entry_rcu(); rcu_txn_list_next_check(), _prev_check() and
+ * rcu_txn_list_empty() take one too.
+ */
+
+#include <linux/container_of.h>
+#include <linux/gfp_types.h>
+#include <linux/rcu_txn.h>
+#include <linux/rcupdate.h>
+
+/*
+ * The list node, embedded in the embedder's structure.  next/prev hold a node
+ * pointer or, transiently during a mutation, a tagged proxy: always read them
+ * through the accessors.
+ */
+struct rcu_txn_list_node {
+	struct rcu_txn_list_node __rcu *next, *prev;
+};
+
+/* The list head embeds the circular sentinel node. */
+struct rcu_txn_list_head {
+	struct rcu_txn_list_node node;
+};
+
+#define RCU_TXN_LIST_HEAD_INIT(name)					\
+	{ .node = { .next = RCU_INITIALIZER(&(name).node),		\
+		    .prev = RCU_INITIALIZER(&(name).node) } }
+
+#define RCU_TXN_LIST_HEAD(name)						\
+	struct rcu_txn_list_head name = RCU_TXN_LIST_HEAD_INIT(name)
+
+static inline void rcu_txn_list_init(struct rcu_txn_list_head *head)
+{
+	RCU_INIT_POINTER(head->node.next, &head->node);
+	RCU_INIT_POINTER(head->node.prev, &head->node);
+}
+
+/*
+ * A slot value with bit 0 set is a tagged struct rcu_txn_record * rather than
+ * a node pointer.  Nodes and records are at least pointer-aligned, so bit 0 is
+ * free.
+ */
+#define RCU_TXN_LIST_TAG	1UL
+
+/*
+ * Write-side read of a link slot: this transaction's pending write to @slot if
+ * it recorded one, else the slot's committed value.  A typed wrapper over
+ * rcu_txn_load().
+ *
+ * Every _prepare below reads its neighbour links through this rather than
+ * ->next / ->prev, which is what lets edits compose on one list (see
+ * rcu_txn_list_add_after_prepare()).  Readers use rcu_txn_list_next_rcu() /
+ * _prev_rcu() instead.
+ */
+static inline struct rcu_txn_list_node *
+rcu_txn_list_pending(struct rcu_txn *txn, struct rcu_txn_list_node __rcu **slot)
+{
+	return rcu_txn_load(txn, rcu_txn_slot(slot), RCU_TXN_LIST_TAG);
+}
+
+/*
+ * Forward and backward steps, within an RCU read-side critical section or
+ * where @c, a lockdep condition, holds.
+ */
+#define rcu_txn_list_next_check(node, c)				\
+	rcu_txn_dereference_check((node)->next, RCU_TXN_LIST_TAG, c)
+
+#define rcu_txn_list_prev_check(node, c)				\
+	rcu_txn_dereference_check((node)->prev, RCU_TXN_LIST_TAG, c)
+
+/* Forward and backward steps, for use within an RCU read-side section. */
+static inline struct rcu_txn_list_node *
+rcu_txn_list_next_rcu(struct rcu_txn_list_node *node)
+{
+	return rcu_txn_dereference(node->next, RCU_TXN_LIST_TAG);
+}
+
+static inline struct rcu_txn_list_node *
+rcu_txn_list_prev_rcu(struct rcu_txn_list_node *node)
+{
+	return rcu_txn_dereference(node->prev, RCU_TXN_LIST_TAG);
+}
+
+/*
+ * True iff the list is empty, within an RCU read-side critical section or
+ * where @cond, an optional lockdep condition, holds.
+ *
+ * Unlike list_empty(), which is a plain load, this needs one or the other:
+ * while a commit is in flight on head->node.next, the slot holds a proxy, and
+ * telling an empty list from another then reads the transaction's descriptor,
+ * which is freed after a grace period.  A writer that excludes the others finds
+ * no proxy there, and passes a lockdep condition for that exclusion as @cond.
+ */
+#define rcu_txn_list_empty(head, cond...)				\
+	(&(head)->node ==						\
+	 rcu_txn_list_next_check(&(head)->node, __rcu_txn_cond(cond)))
+
+/**
+ * rcu_txn_list_add_after_prepare() - record the insertion of a node after
+ *                                    another
+ * @txn: the transaction
+ * @new: the node to insert
+ * @pos: the node to insert it after
+ *
+ * Record the two edges of the insertion into the caller's transaction, without
+ * committing.  The caller owns the transaction, from init to commit, and may
+ * combine these records with others, including records of other structures:
+ * publish a node into a tree and splice it into this list atomically, for
+ * instance.
+ *
+ * Several _prepare calls may share a transaction, even when their
+ * neighbourhoods touch.  Each reads its neighbour links through
+ * rcu_txn_list_pending() and records through rcu_txn_record_chain(), so it
+ * sees the transaction's own pending edits, and a second write to a slot
+ * chains onto the first.
+ *
+ * Example: P -> E1 -> E2 -> N, deleting E1 and E2 in one transaction, a record
+ * being written {slot: old -> new}.  del(E1) records {P->next: E1 -> E2} and
+ * {E2->prev: E1 -> P}.  del(E2) then reads E2->prev and gets the pending P, not
+ * the committed E1, so it records against P->next, finds it recorded, and
+ * chains: {P->next: E1 -> N}.  With {N->prev: E2 -> P}, P and N end up linked
+ * and both victims unlinked.
+ *
+ * Two rules remain for the caller:
+ *
+ *   - Look up the nodes before editing.  A traversal made with the _rcu
+ *     accessors sees the committed list, not the transaction's pending one, so
+ *     a caller that walks and edits in the same transaction may find a node
+ *     that its own earlier edit displaced.
+ *
+ *   - Do not call rcu_txn_declare_disjoint() on a transaction that composes
+ *     edits.  It turns off both mechanisms above: in the example, del(E2) would
+ *     read the committed E1 and record {E1->next: E2 -> N} and
+ *     {N->prev: E2 -> E1}, and the commit would link P and N to deleted
+ *     nodes.  The four slots are distinct, so only CONFIG_DEBUG_RCU_TXN
+ *     reports it, at the load.  The _rcu forms below declare disjoint because
+ *     each carries a single operation.
+ */
+static inline void rcu_txn_list_add_after_prepare(struct rcu_txn *txn,
+						  struct rcu_txn_list_node *new,
+						  struct rcu_txn_list_node *pos)
+{
+	struct rcu_txn_list_node *next = rcu_txn_list_pending(txn, &pos->next);
+
+	/* Build the fresh node's links before it becomes reachable. */
+	RCU_INIT_POINTER(new->prev, pos);
+	RCU_INIT_POINTER(new->next, next);
+
+	/* pos->next: next -> new ; next->prev: pos -> new */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&pos->next), next, new,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&next->prev), pos, new,
+			     RCU_TXN_LIST_TAG);
+}
+
+/**
+ * rcu_txn_list_add_before_prepare() - record the insertion of a node before
+ *                                     another
+ * @txn: the transaction
+ * @new: the node to insert
+ * @pos: the node to insert it before
+ *
+ * See rcu_txn_list_add_after_prepare().
+ */
+static inline void
+rcu_txn_list_add_before_prepare(struct rcu_txn *txn,
+				struct rcu_txn_list_node *new,
+				struct rcu_txn_list_node *pos)
+{
+	struct rcu_txn_list_node *prev = rcu_txn_list_pending(txn, &pos->prev);
+
+	RCU_INIT_POINTER(new->next, pos);
+	RCU_INIT_POINTER(new->prev, prev);
+
+	/* prev->next: pos -> new ; pos->prev: prev -> new */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&prev->next), pos, new,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&pos->prev), prev, new,
+			     RCU_TXN_LIST_TAG);
+}
+
+/**
+ * rcu_txn_list_del_prepare() - record the unlink of a node
+ * @txn: the transaction
+ * @elem: the node to unlink
+ *
+ * See rcu_txn_list_add_after_prepare().  @elem's own next/prev are left as
+ * they are, so a reader standing on it can still leave in either direction;
+ * the caller frees @elem a grace period after the commit.
+ */
+static inline void rcu_txn_list_del_prepare(struct rcu_txn *txn,
+					    struct rcu_txn_list_node *elem)
+{
+	struct rcu_txn_list_node *prev = rcu_txn_list_pending(txn, &elem->prev);
+	struct rcu_txn_list_node *next = rcu_txn_list_pending(txn, &elem->next);
+
+	/* prev->next: elem -> next ; next->prev: elem -> prev */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&prev->next), elem, next,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&next->prev), elem, prev,
+			     RCU_TXN_LIST_TAG);
+}
+
+/**
+ * rcu_txn_list_replace_prepare() - record the replacement of a node
+ * @txn: the transaction
+ * @old: the node to replace
+ * @new: the node that replaces it
+ *
+ * See rcu_txn_list_add_after_prepare().  @new takes @old's neighbours, and
+ * @old keeps its own next/prev for readers standing on it.
+ */
+static inline void rcu_txn_list_replace_prepare(struct rcu_txn *txn,
+						struct rcu_txn_list_node *old,
+						struct rcu_txn_list_node *new)
+{
+	struct rcu_txn_list_node *prev = rcu_txn_list_pending(txn, &old->prev);
+	struct rcu_txn_list_node *next = rcu_txn_list_pending(txn, &old->next);
+
+	RCU_INIT_POINTER(new->prev, prev);
+	RCU_INIT_POINTER(new->next, next);
+
+	/* prev->next: old -> new ; next->prev: old -> new */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&prev->next), old, new,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&next->prev), old, new,
+			     RCU_TXN_LIST_TAG);
+}
+
+/**
+ * rcu_txn_list_move_after_prepare() - record the move of a node after another
+ * @txn: the transaction
+ * @elem: the node to move, a node of the list
+ * @pos: the node to move it after
+ *
+ * See rcu_txn_list_add_after_prepare().  Six edges switch together: the two
+ * that unlink @elem, the two that link it after @pos, and @elem's own next and
+ * prev, so that a reader standing on @elem leaves it by its old neighbours
+ * until the commit and by its new ones from then on.  The add forms cannot
+ * move a node: they build its links with plain stores, for a node that no
+ * reader can reach yet.
+ *
+ * A move of @elem after the node it already follows records nothing.  @pos
+ * must not be @elem.
+ */
+static inline void
+rcu_txn_list_move_after_prepare(struct rcu_txn *txn,
+				struct rcu_txn_list_node *elem,
+				struct rcu_txn_list_node *pos)
+{
+	struct rcu_txn_list_node *prev = rcu_txn_list_pending(txn, &elem->prev);
+	struct rcu_txn_list_node *next = rcu_txn_list_pending(txn, &elem->next);
+	struct rcu_txn_list_node *succ;
+
+	if (WARN_ON_ONCE(pos == elem) || pos == prev)
+		return;
+	succ = rcu_txn_list_pending(txn, &pos->next);
+
+	/* prev->next: elem -> next ; next->prev: elem -> prev */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&prev->next), elem, next,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&next->prev), elem, prev,
+			     RCU_TXN_LIST_TAG);
+	/* pos->next: succ -> elem ; succ->prev: pos -> elem */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&pos->next), succ, elem,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&succ->prev), pos, elem,
+			     RCU_TXN_LIST_TAG);
+	/* elem->next: next -> succ ; elem->prev: prev -> pos */
+	rcu_txn_record_chain(txn, rcu_txn_slot(&elem->next), next, succ,
+			     RCU_TXN_LIST_TAG);
+	rcu_txn_record_chain(txn, rcu_txn_slot(&elem->prev), prev, pos,
+			     RCU_TXN_LIST_TAG);
+}
+
+/**
+ * rcu_txn_list_move_before_prepare() - record the move of a node before
+ *                                      another
+ * @txn: the transaction
+ * @elem: the node to move, a node of the list
+ * @pos: the node to move it before
+ *
+ * See rcu_txn_list_move_after_prepare().
+ */
+static inline void
+rcu_txn_list_move_before_prepare(struct rcu_txn *txn,
+				 struct rcu_txn_list_node *elem,
+				 struct rcu_txn_list_node *pos)
+{
+	struct rcu_txn_list_node *prev = rcu_txn_list_pending(txn, &pos->prev);
+
+	if (WARN_ON_ONCE(pos == elem) || prev == elem)
+		return;
+	rcu_txn_list_move_after_prepare(txn, elem, prev);
+}
+
+/*
+ * The _rcu forms: each runs one operation in a transaction of its own.  They
+ * return 0, or -ENOMEM if the transaction could not be allocated with @gfp, in
+ * which case the list is unchanged.  The caller frees a removed or replaced
+ * node after a grace period.
+ */
+
+/*
+ * Start the transaction of a single operation, of @nr records: its slots are
+ * distinct.
+ */
+static inline void __rcu_txn_list_init_one(struct rcu_txn *txn, gfp_t gfp,
+					   unsigned int nr)
+{
+	rcu_txn_init(txn, gfp);
+	rcu_txn_declare_disjoint(txn);
+	/* An OOM is sticky: commit reports it. */
+	rcu_txn_reserve(txn, nr);
+}
+
+static inline int rcu_txn_list_add_after_rcu(struct rcu_txn_list_node *new,
+					     struct rcu_txn_list_node *pos,
+					     gfp_t gfp)
+{
+	struct rcu_txn txn;
+
+	__rcu_txn_list_init_one(&txn, gfp, 2);
+	rcu_txn_list_add_after_prepare(&txn, new, pos);
+	return rcu_txn_commit(&txn);
+}
+
+static inline int rcu_txn_list_add_before_rcu(struct rcu_txn_list_node *new,
+					      struct rcu_txn_list_node *pos,
+					      gfp_t gfp)
+{
+	struct rcu_txn txn;
+
+	__rcu_txn_list_init_one(&txn, gfp, 2);
+	rcu_txn_list_add_before_prepare(&txn, new, pos);
+	return rcu_txn_commit(&txn);
+}
+
+/* Add @new at the head of the list (just after @head). */
+static inline int rcu_txn_list_add_rcu(struct rcu_txn_list_node *new,
+				       struct rcu_txn_list_head *head,
+				       gfp_t gfp)
+{
+	return rcu_txn_list_add_after_rcu(new, &head->node, gfp);
+}
+
+/* Add @new at the tail of the list (just before @head). */
+static inline int rcu_txn_list_add_tail_rcu(struct rcu_txn_list_node *new,
+					    struct rcu_txn_list_head *head,
+					    gfp_t gfp)
+{
+	return rcu_txn_list_add_before_rcu(new, &head->node, gfp);
+}
+
+static inline int rcu_txn_list_del_rcu(struct rcu_txn_list_node *elem,
+				       gfp_t gfp)
+{
+	struct rcu_txn txn;
+
+	__rcu_txn_list_init_one(&txn, gfp, 2);
+	rcu_txn_list_del_prepare(&txn, elem);
+	return rcu_txn_commit(&txn);
+}
+
+static inline int rcu_txn_list_replace_rcu(struct rcu_txn_list_node *old,
+					   struct rcu_txn_list_node *new,
+					   gfp_t gfp)
+{
+	struct rcu_txn txn;
+
+	__rcu_txn_list_init_one(&txn, gfp, 2);
+	rcu_txn_list_replace_prepare(&txn, old, new);
+	return rcu_txn_commit(&txn);
+}
+
+static inline int rcu_txn_list_move_after_rcu(struct rcu_txn_list_node *elem,
+					      struct rcu_txn_list_node *pos,
+					      gfp_t gfp)
+{
+	struct rcu_txn txn;
+
+	__rcu_txn_list_init_one(&txn, gfp, 6);
+	rcu_txn_list_move_after_prepare(&txn, elem, pos);
+	return rcu_txn_commit(&txn);
+}
+
+static inline int rcu_txn_list_move_before_rcu(struct rcu_txn_list_node *elem,
+					       struct rcu_txn_list_node *pos,
+					       gfp_t gfp)
+{
+	struct rcu_txn txn;
+
+	__rcu_txn_list_init_one(&txn, gfp, 6);
+	rcu_txn_list_move_before_prepare(&txn, elem, pos);
+	return rcu_txn_commit(&txn);
+}
+
+/* Move @elem to the head of the list (just after @head). */
+static inline int rcu_txn_list_move_rcu(struct rcu_txn_list_node *elem,
+					struct rcu_txn_list_head *head,
+					gfp_t gfp)
+{
+	return rcu_txn_list_move_after_rcu(elem, &head->node, gfp);
+}
+
+/* Move @elem to the tail of the list (just before @head). */
+static inline int rcu_txn_list_move_tail_rcu(struct rcu_txn_list_node *elem,
+					     struct rcu_txn_list_head *head,
+					     gfp_t gfp)
+{
+	return rcu_txn_list_move_before_rcu(elem, &head->node, gfp);
+}
+
+#define rcu_txn_list_entry(ptr, type, member)				\
+	container_of(ptr, type, member)
+
+#define rcu_txn_list_first_entry_rcu(head, type, member)		\
+	rcu_txn_list_entry(rcu_txn_list_next_rcu(&(head)->node), type, member)
+
+#define rcu_txn_list_last_entry_rcu(head, type, member)			\
+	rcu_txn_list_entry(rcu_txn_list_prev_rcu(&(head)->node), type, member)
+
+/*
+ * Iterate over the list, within an RCU read-side critical section, or where
+ * @cond, an optional lockdep condition, holds.
+ */
+#define rcu_txn_list_for_each_rcu(pos, head, cond...)			\
+	for (pos = rcu_txn_list_next_check(&(head)->node,		\
+					   __rcu_txn_cond(cond));	\
+	     pos != &(head)->node;					\
+	     pos = rcu_txn_list_next_check(pos, __rcu_txn_cond(cond)))
+
+#define rcu_txn_list_for_each_reverse_rcu(pos, head, cond...)		\
+	for (pos = rcu_txn_list_prev_check(&(head)->node,		\
+					   __rcu_txn_cond(cond));	\
+	     pos != &(head)->node;					\
+	     pos = rcu_txn_list_prev_check(pos, __rcu_txn_cond(cond)))
+
+#define rcu_txn_list_for_each_entry_rcu(pos, head, member, cond...)	\
+	for (pos = rcu_txn_list_entry(					\
+			rcu_txn_list_next_check(&(head)->node,		\
+						__rcu_txn_cond(cond)),	\
+			typeof(*(pos)), member);			\
+	     &(pos)->member != &(head)->node;				\
+	     pos = rcu_txn_list_entry(					\
+			rcu_txn_list_next_check(&(pos)->member,		\
+						__rcu_txn_cond(cond)),	\
+			typeof(*(pos)), member))
+
+#define rcu_txn_list_for_each_entry_reverse_rcu(pos, head, member, cond...) \
+	for (pos = rcu_txn_list_entry(					\
+			rcu_txn_list_prev_check(&(head)->node,		\
+						__rcu_txn_cond(cond)),	\
+			typeof(*(pos)), member);			\
+	     &(pos)->member != &(head)->node;				\
+	     pos = rcu_txn_list_entry(					\
+			rcu_txn_list_prev_check(&(pos)->member,		\
+						__rcu_txn_cond(cond)),	\
+			typeof(*(pos)), member))
+
+#endif /* _LINUX_RCU_TXN_LIST_H */
diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
index 13e4bbae1053..9b67caaa5db7 100644
--- a/lib/tests/rcu_txn_kunit.c
+++ b/lib/tests/rcu_txn_kunit.c
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 #include <linux/rcu_txn.h>
 #include <linux/rcu_txn_hlist.h>
+#include <linux/rcu_txn_list.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/task.h>
 #include <linux/string.h>
@@ -1295,6 +1296,396 @@ static void rcu_txn_test_hlist_debug_ghost_anchor(struct kunit *test)
 	hlist_expect(test, &head, keys, ARRAY_SIZE(keys));
 }
 
+/*
+ * <linux/rcu_txn_list.h>
+ */
+
+struct ln {
+	struct rcu_txn_list_node node;
+	int key;
+};
+
+/* Freed with the test: a removed node stays valid for any reader. */
+static struct rcu_txn_list_node *ln_new(struct kunit *test, int key)
+{
+	struct ln *n = kunit_kzalloc(test, sizeof(*n), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, n);
+	n->key = key;
+	return &n->node;
+}
+
+/* Build the list @keys by appending. */
+static void list_build(struct kunit *test, struct rcu_txn_list_head *head,
+		       const int *keys, int nr)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		KUNIT_ASSERT_EQ(test,
+				rcu_txn_list_add_tail_rcu(ln_new(test, keys[i]),
+							  head, GFP_KERNEL),
+				0);
+}
+
+/* The test is the list's only writer, and owns every node until it ends. */
+static struct rcu_txn_list_node *list_find(struct rcu_txn_list_head *head,
+					   int key)
+{
+	struct ln *n;
+
+	rcu_txn_list_for_each_entry_rcu(n, head, node, true)
+		if (n->key == key)
+			return &n->node;
+	return NULL;
+}
+
+/*
+ * The forward walk gives @want, the backward walk gives its mirror, and next
+ * and prev are mutual inverses at every edge of the ring, sentinel included.
+ */
+static void list_expect(struct kunit *test, struct rcu_txn_list_head *head,
+			const int *want, int nr)
+{
+	struct rcu_txn_list_node *p, *q;
+	struct ln *n;
+	int i = 0;
+
+	rcu_txn_list_for_each_entry_rcu(n, head, node, true) {
+		if (i < nr)
+			KUNIT_EXPECT_EQ(test, n->key, want[i]);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, nr);
+	rcu_txn_list_for_each_entry_reverse_rcu(n, head, node, true) {
+		i--;
+		if (i >= 0)
+			KUNIT_EXPECT_EQ(test, n->key, want[i]);
+	}
+	KUNIT_EXPECT_EQ(test, i, 0);
+	p = &head->node;
+	do {
+		q = rcu_txn_list_next_check(p, true);
+		KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(q, true), p);
+		p = q;
+	} while (p != &head->node);
+}
+
+static void rcu_txn_test_list_add(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	RCU_TXN_LIST_HEAD(tail);
+	static const int at_head[] = { 3, 2, 1 };
+	static const int keys[] = { 1, 2, 3 };
+	static const int middle[] = { 1, 8, 2, 9, 3 };
+	int i;
+
+	KUNIT_EXPECT_TRUE(test, rcu_txn_list_empty(&head, true));
+	list_expect(test, &head, NULL, 0);
+
+	for (i = 1; i <= 3; i++)
+		KUNIT_ASSERT_EQ(test,
+				rcu_txn_list_add_rcu(ln_new(test, i), &head,
+						     GFP_KERNEL),
+				0);
+	list_expect(test, &head, at_head, ARRAY_SIZE(at_head));
+
+	list_build(test, &tail, keys, ARRAY_SIZE(keys));
+	list_expect(test, &tail, keys, ARRAY_SIZE(keys));
+
+	KUNIT_EXPECT_EQ(test,
+			rcu_txn_list_add_after_rcu(ln_new(test, 9),
+						   list_find(&tail, 2),
+						   GFP_KERNEL),
+			0);
+	KUNIT_EXPECT_EQ(test,
+			rcu_txn_list_add_before_rcu(ln_new(test, 8),
+						    list_find(&tail, 2),
+						    GFP_KERNEL),
+			0);
+	list_expect(test, &tail, middle, ARRAY_SIZE(middle));
+}
+
+static void rcu_txn_test_list_del(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int middle[] = { 1, 2, 4, 5 };
+	static const int ends[] = { 2, 4 };
+	struct rcu_txn_list_node *removed;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	removed = list_find(&head, 3);
+	KUNIT_EXPECT_EQ(test, rcu_txn_list_del_rcu(removed, GFP_KERNEL), 0);
+	list_expect(test, &head, middle, ARRAY_SIZE(middle));
+	/* A reader standing on the removed node leaves in either direction. */
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(removed, true),
+			    list_find(&head, 4));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(removed, true),
+			    list_find(&head, 2));
+
+	rcu_txn_list_del_rcu(list_find(&head, 1), GFP_KERNEL);	/* first */
+	rcu_txn_list_del_rcu(list_find(&head, 5), GFP_KERNEL);	/* last */
+	list_expect(test, &head, ends, ARRAY_SIZE(ends));
+
+	rcu_txn_list_del_rcu(list_find(&head, 2), GFP_KERNEL);
+	rcu_txn_list_del_rcu(list_find(&head, 4), GFP_KERNEL);
+	list_expect(test, &head, NULL, 0);
+}
+
+static void rcu_txn_test_list_replace(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 1, 22, 3 };
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	KUNIT_EXPECT_EQ(test,
+			rcu_txn_list_replace_rcu(list_find(&head, 2),
+						 ln_new(test, 22), GFP_KERNEL),
+			0);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * The two edges of a delete, by hand, as a reader sees them across install,
+ * flip and settle: old in both directions until the single flip, new in both
+ * directions after.
+ *
+ * Ring: head <-> A <-> B <-> head.  Delete A:
+ *   forward edge:  head->next: A -> B
+ *   backward edge: B->prev:    A -> head
+ */
+static void rcu_txn_test_list_proxy_phases(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2 };
+	static const int want[] = { 2 };
+	struct rcu_txn_list_node *a, *b;
+	struct rcu_txn_record rec[2];
+	struct rcu_txn_group group;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	a = list_find(&head, 1);
+	b = list_find(&head, 2);
+
+	__rcu_txn_group_init(&group);
+	__rcu_txn_record_set(&rec[0], rcu_txn_slot(&head.node.next), a, b,
+			     RCU_TXN_LIST_TAG);
+	__rcu_txn_record_set(&rec[1], rcu_txn_slot(&b->prev), a, &head.node,
+			     RCU_TXN_LIST_TAG);
+	__rcu_txn_record_install(&group, &rec[0]);
+	__rcu_txn_record_install(&group, &rec[1]);
+
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(&head.node, true), a);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(b, true), a);
+
+	__rcu_txn_group_commit(&group);	/* one flip switches both edges */
+
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(&head.node, true), b);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(b, true), &head.node);
+
+	/* No reader holds a proxy here: the records need no grace period. */
+	__rcu_txn_record_settle(&rec[0]);
+	__rcu_txn_record_settle(&rec[1]);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/* Delete the adjacent 2 and 3 from 1..5 in one transaction. */
+static void rcu_txn_test_list_compose_adjacent_del(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int want[] = { 1, 4, 5 };
+	struct rcu_txn_list_node *e2, *e3;
+	struct rcu_txn txn;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	e2 = list_find(&head, 2);
+	e3 = list_find(&head, 3);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_list_del_prepare(&txn, e2);
+	rcu_txn_list_del_prepare(&txn, e3);	/* the neighbour of e2 */
+	/* &1->next is chained; &3->prev and &4->prev are one record each. */
+	KUNIT_EXPECT_EQ(test, txn.nr, 3);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Delete 2 and insert 9 into the same gap in one transaction: both edges of
+ * the gap are written twice.
+ */
+static void rcu_txn_test_list_compose_del_and_add(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3 };
+	static const int want[] = { 1, 9, 3 };
+	struct rcu_txn_list_node *e1, *e2;
+	struct rcu_txn txn;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	e1 = list_find(&head, 1);
+	e2 = list_find(&head, 2);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_list_del_prepare(&txn, e2);
+	rcu_txn_list_add_after_prepare(&txn, ln_new(test, 9), e1);
+	KUNIT_EXPECT_EQ(test, txn.nr, 2);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/* Three consecutive deletes in one transaction: &1->next is chained twice. */
+static void rcu_txn_test_list_compose_triple_del(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int want[] = { 1, 5 };
+	struct rcu_txn_list_node *e[3];
+	struct rcu_txn txn;
+	int i;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	for (i = 0; i < ARRAY_SIZE(e); i++)
+		e[i] = list_find(&head, i + 2);		/* 2, 3, 4 */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	for (i = 0; i < ARRAY_SIZE(e); i++)
+		rcu_txn_list_del_prepare(&txn, e[i]);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/* The moves of a node, in a transaction of their own. */
+static void rcu_txn_test_list_move(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4, 5 };
+	static const int front[] = { 4, 1, 2, 3, 5 };
+	static const int tail[] = { 1, 2, 3, 5, 4 };
+	static const int past_next[] = { 1, 3, 2, 5, 4 };
+	struct rcu_txn_list_node *e1, *e2, *e3, *e4;
+	struct rcu_txn txn;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	e1 = list_find(&head, 1);
+	e2 = list_find(&head, 2);
+	e3 = list_find(&head, 3);
+	e4 = list_find(&head, 4);
+
+	KUNIT_EXPECT_EQ(test, rcu_txn_list_move_rcu(e4, &head, GFP_KERNEL), 0);
+	list_expect(test, &head, front, ARRAY_SIZE(front));
+	KUNIT_EXPECT_EQ(test,
+			rcu_txn_list_move_tail_rcu(e4, &head, GFP_KERNEL), 0);
+	list_expect(test, &head, tail, ARRAY_SIZE(tail));
+	/* Past its next, then back before it: the neighbourhoods overlap. */
+	KUNIT_EXPECT_EQ(test, rcu_txn_list_move_after_rcu(e2, e3, GFP_KERNEL), 0);
+	list_expect(test, &head, past_next, ARRAY_SIZE(past_next));
+	KUNIT_EXPECT_EQ(test, rcu_txn_list_move_before_rcu(e2, e3, GFP_KERNEL), 0);
+	list_expect(test, &head, tail, ARRAY_SIZE(tail));
+
+	/* Where it already is: nothing is recorded. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_list_move_after_prepare(&txn, e2, e1);
+	rcu_txn_list_move_before_prepare(&txn, e1, e2);
+	KUNIT_EXPECT_EQ(test, txn.nr, 0);
+	rcu_txn_cancel(&txn);
+}
+
+/*
+ * The six edges of a move, as a reader sees them across install, flip and
+ * settle: the old list until the single flip, the new one after, the moved
+ * node's own links included.
+ *
+ * Ring: head <-> A <-> B <-> C <-> D <-> head.  Move D after A.
+ */
+static void rcu_txn_test_list_move_phases(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4 };
+	static const int want[] = { 1, 4, 2, 3 };
+	struct rcu_txn_list_node *a, *b, *c, *d, *h = &head.node;
+	struct rcu_txn txn;
+	unsigned int i;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	a = list_find(&head, 1);
+	b = list_find(&head, 2);
+	c = list_find(&head, 3);
+	d = list_find(&head, 4);
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 6));
+	rcu_txn_list_move_after_prepare(&txn, d, a);
+	KUNIT_ASSERT_EQ(test, txn.nr, 6);
+	for (i = 0; i < txn.nr; i++)
+		__rcu_txn_record_install(&txn.desc->group, &txn.records[i]);
+
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(a, true), b);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(b, true), a);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(c, true), d);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(h, true), d);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(d, true), h);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(d, true), c);
+
+	__rcu_txn_group_commit(&txn.desc->group);	/* one flip, six edges */
+
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(a, true), d);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(b, true), d);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(c, true), h);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(h, true), c);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_next_check(d, true), b);
+	KUNIT_EXPECT_PTR_EQ(test, rcu_txn_list_prev_check(d, true), a);
+
+	/* No reader holds a proxy here: the records need no grace period. */
+	for (i = 0; i < txn.nr; i++)
+		__rcu_txn_record_settle(&txn.records[i]);
+	__rcu_txn_free_desc(txn.desc);
+	__rcu_txn_done(&txn);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/* Two moves to the front in one transaction: their edges chain. */
+static void rcu_txn_test_list_compose_moves(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4 };
+	static const int want[] = { 4, 3, 1, 2 };
+	struct rcu_txn txn;
+
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_list_move_after_prepare(&txn, list_find(&head, 3), &head.node);
+	rcu_txn_list_move_after_prepare(&txn, list_find(&head, 4), &head.node);
+	KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	list_expect(test, &head, want, ARRAY_SIZE(want));
+}
+
+/*
+ * Declaring disjoint a transaction that composes edits turns off what makes
+ * them compose: the second delete reads a link the first has already recorded.
+ */
+static void rcu_txn_test_list_debug_disjoint_compose(struct kunit *test)
+{
+	RCU_TXN_LIST_HEAD(head);
+	static const int keys[] = { 1, 2, 3, 4 };
+	struct rcu_txn_list_node *e2, *e3;
+	struct rcu_txn txn;
+
+	need_debug(test);
+	list_build(test, &head, keys, ARRAY_SIZE(keys));
+	e2 = list_find(&head, 2);
+	e3 = list_find(&head, 3);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_declare_disjoint(&txn);
+	rcu_txn_list_del_prepare(&txn, e2);
+	kunit_warning_suppress(test) {
+		rcu_txn_list_del_prepare(&txn, e3);	/* loads &3->prev */
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+	list_expect(test, &head, keys, ARRAY_SIZE(keys));
+}
+
 static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_single_record),
 	KUNIT_CASE(rcu_txn_test_multi_record),
@@ -1342,6 +1733,17 @@ static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_hlist_cancel),
 	KUNIT_CASE(rcu_txn_test_hlist_oom),
 	KUNIT_CASE(rcu_txn_test_hlist_debug_ghost_anchor),
+	KUNIT_CASE(rcu_txn_test_list_add),
+	KUNIT_CASE(rcu_txn_test_list_del),
+	KUNIT_CASE(rcu_txn_test_list_replace),
+	KUNIT_CASE(rcu_txn_test_list_proxy_phases),
+	KUNIT_CASE(rcu_txn_test_list_compose_adjacent_del),
+	KUNIT_CASE(rcu_txn_test_list_compose_del_and_add),
+	KUNIT_CASE(rcu_txn_test_list_compose_triple_del),
+	KUNIT_CASE(rcu_txn_test_list_move),
+	KUNIT_CASE(rcu_txn_test_list_move_phases),
+	KUNIT_CASE(rcu_txn_test_list_compose_moves),
+	KUNIT_CASE(rcu_txn_test_list_debug_disjoint_compose),
 	{}
 };
 
-- 
2.47.3

