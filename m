Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A484DD3AB;
	Fri, 16 Oct 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157623; cv=none; b=AIqC+vCI9NMHVSajZdeM8jvWBs+FVXjGIhUzKwOd3rCjbq1gX3jN33xuNI6kbAg4l697e/uUTkq40jma8ZyC9wBahc7fgeUavSlrnpLyhnQKuWgepF1UqRDueEx8WtNTjwuTFMPo2XCernzsXojMaASZVNh+qLGON0NwpFOb4VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157623; c=relaxed/simple;
	bh=7XhgdasQXo4I5Z1Slt6o21B0yGZ3lSBatA5efeB/RPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kv9YikbFYPXsb97GNEltzNN3dM5WEXZ6otvVQVP6qmZrGAVWACDbSliUw8KwXC4s5WctM4agrMdZDnETRWTt7wJ/wfLxALKh0MOZviNWX1/GYvHSZVdWYPxCiR2j4YADtaAFq64gqtjA+Rc1oCF1238gK9VYODRCAFiqdLmVw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=u6m6yU7Z; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="u6m6yU7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157608;
	bh=EBfnN3aBNJmS/ydJjB+U0gJ9z4nYexxsfw3QbAGkaXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6m6yU7ZgZfhar8mvP617Y+dOzz7G9yxKVN0AU3jZB4tlnV8y4xiqzV6swp/bq8/y
	 widyrbnGjz/Bll0i7ie48FJlpyMoDi09SaTovlXFN2AylUlHW2MGu7edUVw0DQp9Py
	 ALfbaxMW+4uk7hVQbPMhay4rSPLBW0T1+nPVbwQil8j7mlfMHfJ5kYMZsX4JA066Qg
	 M81TLYib+YPS5bOJpkGGatwy53qE2PEyZs3V9hfGeJBZlE8FUdDf8xi1H4cg0W47ka
	 u9po936ByRmtr/HreOiBQxvVFDk1Td9g5KcNT9pBh1oB7p96xwgN+hxdUY+wlkW/EL
	 Jv4o+7oM5bhHw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9N4tYMzmj8;
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
Subject: [RFC PATCH 09/12] rcu_txn: Test a list writer against concurrent readers
Date: Fri, 16 Oct 2026 09:33:16 -0400
Message-Id: <20261016133319.433617-10-mathieu.desnoyers@efficios.com>
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

Run one writer on a key-sorted rcu_txn_list while kthreads walk it
forward and backward.

Each walk must see sorted keys.  That alone cannot catch an operation
whose two edges are published separately, since such a list is still
sorted in each direction taken alone.  So, during phases where the
writer only inserts, each forward step p -> q also loads the prev of q
and requires its key to be at least that of p.  That catches an insert
that publishes its forward edge before its backward one, as
list_add_rcu() does; the other order cannot be told from a completed
insert by key.

The test is marked slow.  It needs more than one CPU to exercise real
concurrency.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Documentation/RCU/rcu_txn.rst |   4 +-
 lib/tests/rcu_txn_kunit.c     | 307 ++++++++++++++++++++++++++++++++++
 2 files changed, 310 insertions(+), 1 deletion(-)

diff --git a/Documentation/RCU/rcu_txn.rst b/Documentation/RCU/rcu_txn.rst
index 7bac4bd02456..133ef1ade43e 100644
--- a/Documentation/RCU/rcu_txn.rst
+++ b/Documentation/RCU/rcu_txn.rst
@@ -212,9 +212,11 @@ Testing
 =======
 
 ``CONFIG_RCU_TXN_KUNIT_TEST`` builds the KUnit suite ``rcu_txn``, which covers
-the engine, both data structures and the debug checks::
+the engine, both data structures and the debug checks, and runs one writer
+against concurrent readers of a list::
 
 	./tools/testing/kunit/kunit.py run --arch=x86_64 \
+		--qemu_args="-smp 4" \
 		--kconfig_add CONFIG_RCU_TXN_KUNIT_TEST=y \
 		--kconfig_add CONFIG_DEBUG_KERNEL=y \
 		--kconfig_add CONFIG_DEBUG_RCU_TXN=y \
diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
index 9b67caaa5db7..fa01dcb7df2b 100644
--- a/lib/tests/rcu_txn_kunit.c
+++ b/lib/tests/rcu_txn_kunit.c
@@ -7,11 +7,15 @@
 
 #include <kunit/test.h>
 #include <linux/bug.h>
+#include <linux/kthread.h>
+#include <linux/minmax.h>
 #include <linux/rcu_txn.h>
 #include <linux/rcu_txn_hlist.h>
 #include <linux/rcu_txn_list.h>
 #include <linux/rcupdate.h>
+#include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 
 #include "../rcu_txn_internal.h"	/* the steps of a commit */
@@ -1686,6 +1690,308 @@ static void rcu_txn_test_list_debug_disjoint_compose(struct kunit *test)
 	list_expect(test, &head, keys, ARRAY_SIZE(keys));
 }
 
+/*
+ * One writer mutating a key-sorted list while several readers iterate it
+ * forward and backward.
+ *
+ * Two invariants, because the first one alone cannot see the property this
+ * test exists for.
+ *
+ * (1) Monotonicity, per direction.  The writer keeps the list sorted by key at
+ * all times, so a forward walk must see strictly increasing keys and a reverse
+ * walk strictly decreasing ones.  Out-of-range keys and runaway walks are
+ * caught here too.
+ *
+ * What invariant (1) cannot catch is a torn two-edge publish.  Take an insert
+ * of X between P and Q publishing only its forward edge: the forward ring is
+ * P -> X -> Q, still strictly increasing, and the reverse ring is Q -> P, still
+ * strictly decreasing.  Every torn state of a two-edge operation is sorted in
+ * each direction separately.
+ *
+ * (2) Cross-direction agreement, which is where a torn publish shows.  After
+ * each forward step p -> q the reader also resolves the prev of q and requires
+ * its key to be at least p's.  A forward-only torn insert yields the
+ * predecessor that is not back-linked yet, whose key is smaller than p's.  A
+ * reverse-only torn insert is not caught: the prev of q points to X, whose key
+ * lies between p's and q's, as after a completed insert.  list_add_rcu()
+ * publishes the forward edge first, which is the tear this check is for.
+ *
+ * Invariant (2) holds only in a phase without deletes.  Under concurrent
+ * deletes it is simply false: delete p between the reader's two loads and the
+ * prev of q legitimately becomes the node before p, whose key is smaller.  With
+ * inserts alone the legal outcomes are p itself or a node inserted between p
+ * and q, both with a key at least p's.
+ *
+ * The phase change is a handshake.  The writer numbers its phases, the odd ones
+ * allowing deletes, and after publishing an odd phase waits for every reader
+ * to acknowledge that number.  A reader samples the phase at the top of an
+ * iteration and acknowledges an odd one there, so that no cross-checking walk
+ * is in flight when the writer proceeds; an acknowledgment of an earlier
+ * phase does not count.  Store-release and load-acquire order the walks and
+ * the deletes against the handshake.
+ */
+
+#define CONC_KEY_MAX		100		/* keys are 1..CONC_KEY_MAX */
+#define CONC_READERS		4
+#define CONC_STEP_LIMIT		(CONC_KEY_MAX + 8)	/* runaway-walk guard */
+#define CONC_INSERT_ROUNDS	20
+#define CONC_MIXED_OPS		20000
+
+struct cn {
+	struct rcu_txn_list_node node;
+	struct rcu_head rcu;
+	int key;
+};
+
+struct conc {
+	struct rcu_txn_list_head head;
+	unsigned long phase;	/* odd: deletes as well as inserts */
+	struct cn *live[CONC_KEY_MAX + 1];	/* the writer's: node per key */
+};
+
+struct conc_reader {
+	struct conc *conc;
+	struct task_struct *task;
+	long walks;
+	long violations;	/* invariant (1) */
+	long cross_checks;
+	long cross_violations;	/* invariant (2) */
+	unsigned long ack;	/* last odd phase seen: no cross-check in flight */
+};
+
+static int conc_reader_fn(void *arg)
+{
+	struct conc_reader *r = arg;
+	struct rcu_txn_list_head *head = &r->conc->head;
+
+	while (!kthread_should_stop()) {
+		/* Pairs with the writer's store-release of the phase. */
+		unsigned long phase = smp_load_acquire(&r->conc->phase);
+		bool insert_only = !(phase & 1);
+		struct rcu_txn_list_node *p;
+		int prev_key, steps;
+
+		if (!insert_only) {
+			/* Pairs with the writer's load-acquire of the ack. */
+			smp_store_release(&r->ack, phase);
+		}
+
+		/* Forward: strictly increasing keys, bounded. */
+		rcu_read_lock();
+		prev_key = 0;
+		steps = 0;
+		rcu_txn_list_for_each_rcu(p, head) {
+			int key = container_of(p, struct cn, node)->key;
+
+			if (key < 1 || key > CONC_KEY_MAX || key <= prev_key ||
+			    ++steps > CONC_STEP_LIMIT) {
+				r->violations++;
+				break;
+			}
+			/*
+			 * Invariant (2).  Skipped for the first step, whose
+			 * predecessor is the head.
+			 */
+			if (insert_only && prev_key) {
+				struct rcu_txn_list_node *back =
+						rcu_txn_list_prev_rcu(p);
+
+				r->cross_checks++;
+				if (back != &head->node &&
+				    container_of(back, struct cn,
+						 node)->key < prev_key)
+					r->cross_violations++;
+			}
+			prev_key = key;
+		}
+		rcu_read_unlock();
+
+		/* Reverse: strictly decreasing keys, bounded. */
+		rcu_read_lock();
+		prev_key = CONC_KEY_MAX + 1;
+		steps = 0;
+		rcu_txn_list_for_each_reverse_rcu(p, head) {
+			int key = container_of(p, struct cn, node)->key;
+
+			if (key < 1 || key > CONC_KEY_MAX || key >= prev_key ||
+			    ++steps > CONC_STEP_LIMIT) {
+				r->violations++;
+				break;
+			}
+			prev_key = key;
+		}
+		rcu_read_unlock();
+
+		r->walks += 2;
+		cond_resched();
+	}
+	return 0;
+}
+
+/* Insert @key, keeping the list sorted.  Returns false if it cannot. */
+static bool conc_insert(struct conc *c, int key)
+{
+	struct rcu_txn_list_node *succ = &c->head.node;	/* default: last */
+	struct cn *n = kmalloc(sizeof(*n), GFP_KERNEL);
+	int i;
+
+	if (!n)
+		return false;
+	n->key = key;
+	for (i = key + 1; i <= CONC_KEY_MAX; i++) {
+		if (c->live[i]) {
+			succ = &c->live[i]->node;
+			break;
+		}
+	}
+	if (rcu_txn_list_add_before_rcu(&n->node, succ, GFP_KERNEL)) {
+		kfree(n);
+		return false;
+	}
+	c->live[key] = n;
+	return true;
+}
+
+static bool conc_del(struct conc *c, int key)
+{
+	struct cn *n = c->live[key];
+
+	if (rcu_txn_list_del_rcu(&n->node, GFP_KERNEL))
+		return false;
+	c->live[key] = NULL;
+	kfree_rcu(n, rcu);
+	return true;
+}
+
+/* Replace the node of @key by a new one of the same key: order is kept. */
+static bool conc_replace(struct conc *c, int key)
+{
+	struct cn *old = c->live[key];
+	struct cn *n = kmalloc(sizeof(*n), GFP_KERNEL);
+
+	if (!n)
+		return false;
+	n->key = key;
+	if (rcu_txn_list_replace_rcu(&old->node, &n->node, GFP_KERNEL)) {
+		kfree(n);
+		return false;
+	}
+	c->live[key] = n;
+	kfree_rcu(old, rcu);
+	return true;
+}
+
+static void rcu_txn_test_list_concurrent(struct kunit *test)
+{
+	struct conc_reader *readers;
+	long walks = 0, violations = 0, cross_checks = 0, cross_violations = 0;
+	u32 rng = 2463534242u;
+	bool ok = true;
+	struct conc *c;
+	int i, key, round;
+
+	c = kunit_kzalloc(test, sizeof(*c), GFP_KERNEL);
+	readers = kunit_kcalloc(test, CONC_READERS, sizeof(*readers),
+				GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, c);
+	KUNIT_ASSERT_NOT_NULL(test, readers);
+	rcu_txn_list_init(&c->head);
+
+	for (i = 0; i < CONC_READERS; i++) {
+		readers[i].conc = c;
+		readers[i].task = kthread_run(conc_reader_fn, &readers[i],
+					      "rcu_txn_reader/%d", i);
+		if (IS_ERR(readers[i].task)) {
+			readers[i].task = NULL;
+			ok = false;
+		}
+	}
+
+	/*
+	 * An even phase, repeated: fill the list one key at a time, with
+	 * inserts only, so that the readers cross-check against concurrent
+	 * inserts.  Then hand over to an odd phase and empty it with deletes.
+	 */
+	for (round = 0; ok && round < CONC_INSERT_ROUNDS; round++) {
+		int order[CONC_KEY_MAX], other;
+
+		for (i = 0; i < CONC_KEY_MAX; i++)
+			order[i] = i + 1;
+		for (i = CONC_KEY_MAX - 1; i > 0; i--) {	/* shuffle */
+			rng ^= rng << 13; rng ^= rng >> 17; rng ^= rng << 5;
+			other = rng % (i + 1);
+			swap(order[i], order[other]);
+		}
+
+		/* An even phase, after the deletes of the previous one. */
+		smp_store_release(&c->phase, (c->phase | 1) + 1);
+
+		for (i = 0; ok && i < CONC_KEY_MAX; i++) {
+			ok = conc_insert(c, order[i]);
+			/*
+			 * Let the readers walk in between.  On one cpu they
+			 * only run in this phase if the writer sleeps in it.
+			 */
+			if (i == CONC_KEY_MAX / 2)
+				schedule_timeout_uninterruptible(1);
+			else
+				cond_resched();
+		}
+
+		/* An odd phase: wait until no even phase walk is running. */
+		smp_store_release(&c->phase, c->phase + 1);
+		for (i = 0; i < CONC_READERS; i++) {
+			if (!readers[i].task)
+				continue;
+			/* Pairs with the reader's store-release of its ack. */
+			while (smp_load_acquire(&readers[i].ack) != c->phase)
+				schedule_timeout_uninterruptible(1);
+		}
+
+		for (key = 1; ok && key <= CONC_KEY_MAX; key++) {
+			if (c->live[key])
+				ok = conc_del(c, key);
+			cond_resched();
+		}
+	}
+
+	/* Then inserts, deletes and replaces, at random. */
+	for (i = 0; ok && i < CONC_MIXED_OPS; i++) {
+		rng ^= rng << 13; rng ^= rng >> 17; rng ^= rng << 5;
+		key = 1 + rng % CONC_KEY_MAX;
+
+		if (!c->live[key])
+			ok = conc_insert(c, key);
+		else if (!(rng & 0x300))
+			ok = conc_replace(c, key);
+		else
+			ok = conc_del(c, key);
+		cond_resched();
+	}
+
+	for (i = 0; i < CONC_READERS; i++) {
+		if (readers[i].task)
+			kthread_stop(readers[i].task);
+		walks += readers[i].walks;
+		violations += readers[i].violations;
+		cross_checks += readers[i].cross_checks;
+		cross_violations += readers[i].cross_violations;
+	}
+	for (key = 1; key <= CONC_KEY_MAX; key++)
+		if (c->live[key])
+			conc_del(c, key);
+
+	kunit_info(test, "%ld walks, %ld cross-direction checks\n", walks,
+		   cross_checks);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_GT(test, walks, 0);
+	/* Forward and reverse walks stayed sorted. */
+	KUNIT_EXPECT_EQ(test, violations, 0);
+	/* No two-edge publish was ever seen torn. */
+	KUNIT_EXPECT_GT(test, cross_checks, 0);
+	KUNIT_EXPECT_EQ(test, cross_violations, 0);
+}
+
 static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_single_record),
 	KUNIT_CASE(rcu_txn_test_multi_record),
@@ -1744,6 +2050,7 @@ static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_list_move_phases),
 	KUNIT_CASE(rcu_txn_test_list_compose_moves),
 	KUNIT_CASE(rcu_txn_test_list_debug_disjoint_compose),
+	KUNIT_CASE_SLOW(rcu_txn_test_list_concurrent),
 	{}
 };
 
-- 
2.47.3

