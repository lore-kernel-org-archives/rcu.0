Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC854DA9DE;
	Fri, 16 Oct 2026 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157622; cv=none; b=X2hM6UeMliJNSOtugxL5VIo2tv+eV75e7HfTZ4a1UMJM8MvbC7HKH81xE4vXhyuaTot6ZpeNASoo6EtIZ6VHsCwvAXtHhzD3LBAqbGIpINiVFm4rWDgM9jb5baTxcIKa5B0nXl/+SLG9Tzds48Zm8B8On265zPUSkTaypOdkqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157622; c=relaxed/simple;
	bh=6ikJ2R5JA4KlQvd7YzyTHI4nG8NwOgrmLzN7w2B13SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gBJnOB5vi/2BL7tHTwvLxgC2MgdfEJ8oTwInd3At06CPWFNRietdpn13c9+CWx7jyOnJfjdi+hubTrnGU82H2y8Ymdlccf7jdYrvmViP/hfN9AhWh172FMRG84RG7C4T8vThhn31ekyiv2NceuKSJfRII7+40hKzwvSXXKHkbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TGb6wCzQ; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TGb6wCzQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157608;
	bh=UpbwmKG//X6AfaMXx0hG0RX9+UjAryILC7rBWtKiUXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGb6wCzQJAQWJNYbipRVPv9vwu9dbq6tpFGxo5aPzHfT+M28Y88MRXKYk5j/mvZGG
	 DNNWJfHU6BzLf8BCD9rwP7CwB1IYjiAfbcqGLTJDWPZ4j+CAZjrMMvGlpUkBRylD/i
	 crQtX8EcVbYV2Xpi6GPMyLS5CXO2sc1w1bZJDYG5f3x02LgDZ0qIeD3a/8ciFBRLvL
	 56tFtsQbYEO9QxEivz3+v/LteDi/Q5PGvBRaC1yU8QOCHLgWRp+a/iLHydHh+RF0Eu
	 xDbTYOMMf9LakFSM2UVDXi9COhQu8JHqp+Kf8lSZbgJFi1igMwoRYAiiqcygvqvLPz
	 s9z8xQ8yI0cEQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9N1nzkznrj;
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
Subject: [RFC PATCH 07/12] Documentation/RCU: Describe RCU pseudo-transactions
Date: Fri, 16 Oct 2026 09:33:14 -0400
Message-Id: <20261016133319.433617-8-mathieu.desnoyers@efficios.com>
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

Add a page on the RCU pseudo-transactions to the RCU handbook: when they
apply and what they cost, how a commit proceeds, what readers and
writers call, how a transaction allocates, and the two data structures
built on them.  It ends with the API reference extracted from the
headers.  The overview at the top of <linux/rcu_txn.h> points to it.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Documentation/RCU/index.rst   |   1 +
 Documentation/RCU/rcu_txn.rst | 230 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   1 +
 include/linux/rcu_txn.h       |   2 +
 4 files changed, 234 insertions(+)
 create mode 100644 Documentation/RCU/rcu_txn.rst

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 035871687ee2..4bca16c8573b 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -18,6 +18,7 @@ RCU Handbook
    rcu
    rculist_nulls
    rcuref
+   rcu_txn
    torture
    stallwarn
    listRCU
diff --git a/Documentation/RCU/rcu_txn.rst b/Documentation/RCU/rcu_txn.rst
new file mode 100644
index 000000000000..6e48306ebc19
--- /dev/null
+++ b/Documentation/RCU/rcu_txn.rst
@@ -0,0 +1,230 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Single-writer RCU pseudo-transactions
+=====================================
+
+An RCU pseudo-transaction switches a *set* of RCU-protected pointers from
+their old values to their new values with a single store, as observed by
+concurrent RCU readers: at any instant, every pointer of the set reads old, or
+every pointer reads new.  A reader that follows several of them, each load
+depending on the previous one, sees old values, then new ones, and never an
+old value after a new one.
+
+The implementation is in ``include/linux/rcu_txn.h`` and ``lib/rcu_txn.c``.
+Code that uses it selects ``CONFIG_RCU_TXN``.
+
+When to use it
+==============
+
+``rcu_assign_pointer()`` publishes one pointer atomically.  An update that
+re-points several pointers one at a time exposes its intermediate states: a
+reader that loads two of them may get the new value of one and then the old
+value of the other.  Moving an object between two hash buckets is such an
+update, and so is every insertion into or removal from a doubly-linked list.
+
+A pseudo-transaction removes the intermediate states.  It does not replace the
+update-side lock: the writers of a slot are excluded by the caller, and the
+transaction neither detects nor resolves conflicts between them.  It is
+"pseudo" in that sense: there is no read set and no abort, and readers get no
+snapshot.
+
+A pseudo-transaction is not free, on the update side above all.  The writer
+allocates a descriptor for each transaction, with the ``gfp_t`` given to
+``rcu_txn_init()``, and a transaction that switches two pointers or more frees
+it with ``kfree_rcu()``, a grace period after its commit, as readers may still
+be reading it: an allocation, which can fail, and a deferred free for every
+update, where ``rcu_assign_pointer()`` needs neither.  The reader pays a test of
+the low bits of every pointer it loads, which is nearly free: only while a
+commit is in flight on that pointer does the reader also read the descriptor,
+with three more loads, one of them an acquire.
+
+How it works
+============
+
+The pointers a transaction switches are called *slots*: they are the *edges* of
+the data structure that the update re-points.  The writer builds a *record* per
+slot, holding the slot's old and new targets, and commits in three steps:
+
+1. *Install.*  Each slot is made to point at its record, with tag bits set that
+   mark the value as a *proxy* rather than a target.  A reader that finds a
+   proxy resolves it through the record, which still answers with the old
+   target.
+
+2. *Commit.*  The records of a transaction share one word, the *selector* of
+   their *flip group*.  The writer stores 1 to it.  From then on every proxy of
+   the transaction resolves to its new target.
+
+3. *Settle.*  Each slot is overwritten with its new target, and the records
+   are freed after a grace period.
+
+The selector is written once, from 0 to 1, so a reader that resolves several
+slots of a transaction over time sees old targets, then new targets, and never
+an old target after a new one, provided that each of its loads depends on the
+previous one.  The header describes the memory ordering in detail.
+
+A transaction of a single record installs no proxy: its commit is one
+``rcu_assign_pointer()``.
+
+Tags
+====
+
+The embedder chooses the tag that marks a proxy in its slots: typically bit 0,
+or a reserved value of a type code that its pointers already carry.  The tag
+must be within ``RCU_TXN_TAG_MASK``, the low bits that the alignment of a
+record leaves clear, and no value that the embedder stores in a slot may carry
+all of the tag's bits.
+
+Readers
+=======
+
+A reader loads a slot with ``rcu_txn_dereference()`` instead of
+``rcu_dereference()``::
+
+	rcu_read_lock();
+	child = rcu_txn_dereference(node->left, FOO_TAG);
+	if (child)
+		do_something_with(child);
+	rcu_read_unlock();
+
+``rcu_txn_dereference()`` is ``rcu_dereference()`` followed by
+``rcu_txn_resolve()``.  A reader that already has the loaded value, for
+instance because it tests other bits of it, calls ``rcu_txn_resolve()``
+itself.
+
+The load and the resolution must happen in one RCU read-side critical section:
+the record a proxy points at is freed with ``kfree_rcu()``.
+
+Writers
+=======
+
+The writer declares a handle on its stack, records the edges of the update and
+commits them::
+
+	struct rcu_txn txn;
+	struct foo *child;
+	int err;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_reserve(&txn, 2);
+
+	spin_lock(&foo_lock);
+	child = rcu_dereference_protected(a->left, lockdep_is_held(&foo_lock));
+	rcu_txn_record(&txn, rcu_txn_slot(&a->left), child, NULL, FOO_TAG);
+	rcu_txn_record(&txn, rcu_txn_slot(&b->right), NULL, child, FOO_TAG);
+	err = rcu_txn_commit(&txn);
+	spin_unlock(&foo_lock);
+
+Here ``child`` moves from ``a->left`` to an empty ``b->right``: at any instant
+it is in exactly one of the two places.
+
+Slots are ``__rcu`` pointers.  ``rcu_txn_slot()`` converts the address of one,
+of any type, to the ``void __rcu **`` the engine takes, and lets sparse check
+the annotation.
+
+A handle ends in ``rcu_txn_commit()`` or in ``rcu_txn_cancel()``.  Either
+consumes it, and it must be initialized again before it is reused.
+
+Allocation
+----------
+
+A transaction allocates a descriptor, with the ``gfp_t`` given to
+``rcu_txn_init()``.  ``rcu_txn_reserve()`` allocates it for a given number of
+records; otherwise the first ``rcu_txn_record()`` does, even for a single
+record, and a later one may grow it.
+
+A failed allocation is sticky: later records do nothing, and
+``rcu_txn_commit()`` publishes nothing and returns ``-ENOMEM``.  A writer may
+therefore ignore the return values of ``rcu_txn_reserve()`` and
+``rcu_txn_record()`` and check that of ``rcu_txn_commit()`` only, as in the
+example above.
+
+A writer that records under a spinlock reserves its record bound before it
+takes the lock, as above, or initializes the handle with a non-sleeping
+``gfp_t``.  Under a raw or a bit spinlock only the reserve will do, since
+``PREEMPT_RT`` does not allow the allocator there.  ``rcu_txn_commit()`` and
+``rcu_txn_cancel()`` allocate nothing, do not sleep, and may be called under
+such a lock.
+
+An update that re-points a single slot needs no transaction.  Every
+transaction settles its slots before its commit returns, and the writers of the
+slot are excluded, so the slot holds no proxy: ``rcu_assign_pointer()``
+publishes the update, as the ``_rcu`` operations of ``rcu_txn_hlist`` do.
+
+Writing a slot twice
+--------------------
+
+``rcu_txn_record()`` requires the records of a transaction to target distinct
+slots.  A writer that may write the same slot twice in one transaction reads
+the slot with ``rcu_txn_load()``, which returns the transaction's pending value
+for it, and records with ``rcu_txn_record_chain()``, which updates the record
+the slot already has::
+
+	old = rcu_txn_load(&txn, slot, FOO_TAG);
+	rcu_txn_record_chain(&txn, slot, old, new, FOO_TAG);
+
+This is what allows several operations on one data structure to be composed in
+one transaction.  The lookup among the transaction's records is a linear scan,
+behind a Bloom filter once the transaction holds enough of them.
+``rcu_txn_declare_disjoint()`` turns the lookup off for a transaction whose
+slots are known to be distinct.
+
+Data structures
+===============
+
+Two data structures are built on the engine.  Each provides ``_prepare``
+operations, which record into a transaction owned by the caller, and ``_rcu``
+operations, which carry out a single operation by themselves.
+Readers walk them with ``_rcu`` iterators.  A writer that excludes the others
+walks them with the same iterators outside of an RCU read-side critical
+section, if it passes them a lockdep condition for that exclusion, such as
+``lockdep_is_held()`` of its lock, as with ``list_for_each_entry_rcu()``.
+
+``include/linux/rcu_txn_hlist.h``
+	A list with a single-pointer head, like ``hlist``.  Its ``_prepare``
+	operations compose: several nodes can be added to or removed from one
+	or several lists atomically.  An ``_rcu`` operation publishes its
+	update with one ``rcu_assign_pointer()`` and allocates nothing.
+
+``include/linux/rcu_txn_list.h``
+	A circular doubly-linked list whose forward and backward chains are
+	mutually coherent at every instant, which allows readers to walk it in
+	both directions.  An insertion or a removal switches a forward and a
+	backward edge, and a move six, the moved node's own included: each
+	allocates a descriptor.
+
+Debugging
+=========
+
+``CONFIG_DEBUG_RCU_TXN`` enables the checks that cost more than a test of the
+handle's state.  It validates the tags, reports a slot recorded twice, and
+validates the single-writer contract: it warns when a handle is driven by a
+task other than the one that initialized it, and when a slot that a transaction
+records, installs to or settles was changed by another writer in the meantime.
+A task that takes over a handle which another got ready, with nothing recorded
+yet, calls ``rcu_txn_adopt()`` first, which makes it the task the check
+expects.
+
+Misuse of a handle, such as recording into one that was already committed,
+warns in every build.
+
+Testing
+=======
+
+``CONFIG_RCU_TXN_KUNIT_TEST`` builds the KUnit suite ``rcu_txn``, which covers
+the engine, both data structures and the debug checks::
+
+	./tools/testing/kunit/kunit.py run --arch=x86_64 \
+		--kconfig_add CONFIG_RCU_TXN_KUNIT_TEST=y \
+		--kconfig_add CONFIG_DEBUG_KERNEL=y \
+		--kconfig_add CONFIG_DEBUG_RCU_TXN=y \
+		'rcu_txn*'
+
+API
+===
+
+.. kernel-doc:: include/linux/rcu_txn.h
+
+.. kernel-doc:: include/linux/rcu_txn_hlist.h
+
+.. kernel-doc:: include/linux/rcu_txn_list.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 5126f4ece4e7..f34040369eb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22857,6 +22857,7 @@ RCU PSEUDO-TRANSACTIONS
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
 S:	Maintained
+F:	Documentation/RCU/rcu_txn.rst
 F:	include/linux/rcu_txn*.h
 F:	lib/rcu_txn*
 F:	lib/tests/rcu_txn_kunit.c
diff --git a/include/linux/rcu_txn.h b/include/linux/rcu_txn.h
index b9ee242a01ce..19f1365ae8ae 100644
--- a/include/linux/rcu_txn.h
+++ b/include/linux/rcu_txn.h
@@ -12,6 +12,8 @@
  * the slots, from their old to their new targets with a single store, as
  * observed by concurrent RCU readers: at any instant, every slot of the set
  * resolves to its old target, or every slot to its new one.
+ * Documentation/RCU/rcu_txn.rst says when to use them, and describes the data
+ * structures built on them.
  *
  * The slots are the edges of the data structure that an update re-points; the
  * writer records each edge as its slot with the slot's old and new targets.
-- 
2.47.3

