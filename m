Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2C4DD3AF;
	Fri, 16 Oct 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157623; cv=none; b=e/6i87edCuNWH6NsMPfOXlcTjmdccfowLd1w1osmetMvyn+u/5XrsPdhEcQ+f4s4v4YthUEbjKXz4Tv0hIiPcS+c1YqdnoxzD9oy7HzqVZ9uSM7KlqV1M4i2lAy/sFjV1bExAAW7U5wGH06ut1Bv9rMqbYXjAzrQl5te28De5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157623; c=relaxed/simple;
	bh=+bL7sZhCEHjIPV33xaMol89GlYBrwyUQdhGZD2qfq7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUTPZb356AivH5BLYOWF8qRq2E98DdppoxAghazSSLj+ssDzt5wKkS7Nyjmifc1G4WLNdoNXxUYK4PHuEPt9eDmEB6dRv2C+Ba5caGxdOjYDItzX5spvNrvJmr3j3tgREt5cVzQ0sRmmXHNCi3jp7x8ZO0GbtKiCPQkqVgFHXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QVj3E1LL; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QVj3E1LL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157609;
	bh=Hlfx7oUNztWWyZtc/jiOzHc00HwwjwryjPDO5nMtj/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QVj3E1LLXUdcq8C6GDh+khoXWGjESqC9QjLZ3WqdmmSffVM8MSIlH76+P4C813cdg
	 N6ljk76e/UiopMz7jFbvxtbMpbQ9Q5V1jWT+xvBQlwGMDiufbH3Rm1uBsCJZTjVeE2
	 DIZYldu2zgwffTS7qUjDDrXAon9VOOPyvqYBDK7WdKouGeTMkhMjd1Jpep0czGH8en
	 tlGmox4Agt76p46u8pAsOZjLHsMlUAWwy3Rcdnmc1fFlexnhMBilNivmkfiBoYpGze
	 OFkS15R7DPG+dvjd1eRp9fKjb8hn1j+1LGHMMOeS2YU6Bgx2m49e0B4BqarMeUoXmd
	 RW5Q/4zvgb2aA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9P0f5MzmjB;
	Fri, 16 Oct 2026 09:33:29 -0400 (EDT)
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
Subject: [RFC PATCH 11/12] samples: Add a cache on RCU pseudo-transactions under one mutex
Date: Fri, 16 Oct 2026 09:33:18 -0400
Message-Id: <20261016133319.433617-12-mathieu.desnoyers@efficios.com>
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

Show the hlist and the list of RCU pseudo-transactions together: a
cache whose entries are found by key in a hash table of rcu_txn_hlist
buckets, and kept in an rcu_txn_list as their LRU.

Lookup threads find entries under RCU alone, and mark the ones they find
referenced.  Writer threads insert, update and delete entries under one
mutex.  An insertion into a full cache evicts the oldest entry, after
moving to the front of the list the referenced entries it finds at its
tail, as a second chance.  Each change is one transaction over both
structures: an insertion that evicts links the new entry into its bucket
and at the front of the list, makes the moves, and unlinks the victim
from both, and at any instant the cache holds all of it or none of it.
Its records are reserved before the writer takes the mutex, which keeps
the allocation out of the critical section.

The module runs for duration_ms when it is loaded, then checks that the
hash table and the list hold the same entries, and reports what it did.
An allocation failure stops the writers there.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 Documentation/RCU/rcu_txn.rst         |   9 +
 MAINTAINERS                           |   1 +
 samples/Kconfig                       |  13 +
 samples/Makefile                      |   1 +
 samples/rcu_txn/Makefile              |   2 +
 samples/rcu_txn/rcu_txn_cache_mutex.c | 354 ++++++++++++++++++++++++++
 6 files changed, 380 insertions(+)
 create mode 100644 samples/rcu_txn/Makefile
 create mode 100644 samples/rcu_txn/rcu_txn_cache_mutex.c

diff --git a/Documentation/RCU/rcu_txn.rst b/Documentation/RCU/rcu_txn.rst
index 133ef1ade43e..8f63c1ce9c38 100644
--- a/Documentation/RCU/rcu_txn.rst
+++ b/Documentation/RCU/rcu_txn.rst
@@ -193,6 +193,15 @@ section, if it passes them a lockdep condition for that exclusion, such as
 	backward edge, and a move six, the moved node's own included: each
 	allocates a descriptor.
 
+Samples
+=======
+
+``samples/rcu_txn/`` holds a cache whose entries are found by key in a hash
+table of ``rcu_txn_hlist`` buckets, and kept in an ``rcu_txn_list`` as their
+LRU.  Its lookups run under RCU alone, and each of its changes is one
+transaction over both structures.  ``rcu_txn_cache_mutex`` excludes its
+writers with a single mutex.  ``CONFIG_SAMPLE_RCU_TXN`` builds it.
+
 Debugging
 =========
 
diff --git a/MAINTAINERS b/MAINTAINERS
index e0dd49be20f9..99e0eb6d7331 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22862,6 +22862,7 @@ F:	Documentation/litmus-tests/rcu/RCU-txn+*
 F:	include/linux/rcu_txn*.h
 F:	lib/rcu_txn*
 F:	lib/tests/rcu_txn_kunit.c
+F:	samples/rcu_txn/
 
 RCUTORTURE TEST FRAMEWORK
 M:	"Paul E. McKenney" <paulmck@kernel.org>
diff --git a/samples/Kconfig b/samples/Kconfig
index a75e8e78330d..db4b5680e34d 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -103,6 +103,19 @@ config SAMPLE_KFIFO
 
 	  If in doubt, say "N" here.
 
+config SAMPLE_RCU_TXN
+	tristate "Build RCU pseudo-transaction examples -- loadable modules only"
+	depends on m
+	select RCU_TXN
+	help
+	  Build sample modules of a cache on RCU pseudo-transactions: a hash
+	  table of rcu_txn_hlist buckets, with an rcu_txn_list as its LRU,
+	  that threads look entries up in under RCU alone while other threads
+	  insert, update, delete and evict them.  Each module runs for a while
+	  when it is loaded, then reports what it did.
+
+	  If in doubt, say "N" here.
+
 config SAMPLE_KDB
 	tristate "Build kdb command example -- loadable modules only"
 	depends on KGDB_KDB && m
diff --git a/samples/Makefile b/samples/Makefile
index 07641e177bd8..63bbf54e449d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -18,6 +18,7 @@ subdir-$(CONFIG_SAMPLE_LANDLOCK)	+= landlock
 obj-$(CONFIG_SAMPLE_LIVEPATCH)		+= livepatch/
 subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
 obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
+obj-$(CONFIG_SAMPLE_RCU_TXN)		+= rcu_txn/
 obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
 subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
diff --git a/samples/rcu_txn/Makefile b/samples/rcu_txn/Makefile
new file mode 100644
index 000000000000..6d7845352afc
--- /dev/null
+++ b/samples/rcu_txn/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_RCU_TXN) += rcu_txn_cache_mutex.o
diff --git a/samples/rcu_txn/rcu_txn_cache_mutex.c b/samples/rcu_txn/rcu_txn_cache_mutex.c
new file mode 100644
index 000000000000..58d17b579cba
--- /dev/null
+++ b/samples/rcu_txn/rcu_txn_cache_mutex.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ * A cache on RCU pseudo-transactions, its writers under one mutex
+ *
+ * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * Entries are found by key in a hash table of rcu_txn_hlist buckets, and kept
+ * in an rcu_txn_list from the most recently inserted to the oldest.  Lookup
+ * threads find entries under RCU alone, and mark the ones they find
+ * referenced.  Writer threads insert, update and delete entries under one
+ * mutex.  The cache holds CACHE_SIZE entries at most: an insertion into a full
+ * cache evicts the oldest entry, after giving a second chance at the front of
+ * the list to the referenced entries it finds at the tail, CACHE_CHANCES of
+ * them at most.
+ *
+ * Each change is one transaction over the hash table and the list together.
+ * An insertion that evicts links the new entry into its bucket and at the
+ * front of the list, moves the entries it gives a second chance, and unlinks
+ * the victim from its bucket and from the list: at any instant, the cache holds
+ * all of it, or none of it.  An update replaces the entry in its bucket and
+ * moves the new one to the front of the list.
+ *
+ * Its records are reserved before the writer takes the mutex, which keeps the
+ * allocation out of the critical section.
+ *
+ * The sample runs for duration_ms when it is loaded, then checks that the hash
+ * table and the list hold the same entries, and reports what it did.  An
+ * allocation failure stops the writers there.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/hash.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/random.h>
+#include <linux/rcu_txn.h>
+#include <linux/rcu_txn_hlist.h>
+#include <linux/rcu_txn_list.h>
+#include <linux/slab.h>
+
+#define CACHE_HASH_BITS	6
+#define CACHE_KEYS	512	/* keys are 0 to CACHE_KEYS - 1 */
+#define CACHE_SIZE	128	/* entries held at most */
+#define CACHE_CHANCES	4	/* second chances an eviction gives at most */
+#define CACHE_THREADS	16	/* of each kind, at most */
+
+/*
+ * What an insertion records at most: the entry into its bucket (two records,
+ * with its successor's pprev) and at the front of the list (two), the second
+ * chances (six each), and the eviction (four).
+ */
+#define CACHE_RECORDS	(4 + 6 * CACHE_CHANCES + 4)
+
+static unsigned int nr_lookups = 2;
+module_param(nr_lookups, uint, 0444);
+MODULE_PARM_DESC(nr_lookups, "Lookup threads");
+
+static unsigned int nr_writers = 2;
+module_param(nr_writers, uint, 0444);
+MODULE_PARM_DESC(nr_writers, "Writer threads");
+
+static unsigned int duration_ms = 2000;
+module_param(duration_ms, uint, 0444);
+MODULE_PARM_DESC(duration_ms, "How long the threads run, from the load");
+
+struct cache_entry {
+	unsigned long key;
+	unsigned long value;			/* key + CACHE_KEYS * version */
+	struct rcu_txn_hlist_node hnode;	/* in its bucket */
+	struct rcu_txn_list_node lru;		/* in the list, newest first */
+	struct rcu_head rcu;
+	bool referenced;			/* found since it last moved */
+};
+
+static struct rcu_txn_hlist_head cache_hash[1 << CACHE_HASH_BITS];
+static RCU_TXN_LIST_HEAD(cache_lru);
+static DEFINE_MUTEX(cache_mutex);	/* excludes the writers */
+static unsigned int cache_count;	/* entries, under cache_mutex */
+
+static atomic_long_t nr_lookup, nr_hit, nr_bad, nr_insert, nr_update,
+		     nr_delete, nr_evict, nr_chance, nr_nomem;
+
+/* Set at the first allocation failure, which stops the writers. */
+static bool cache_failed;
+
+static void cache_fail(void)
+{
+	atomic_long_inc(&nr_nomem);
+	WRITE_ONCE(cache_failed, true);
+}
+
+static struct rcu_txn_hlist_head *cache_bucket(unsigned long key)
+{
+	return &cache_hash[hash_long(key, CACHE_HASH_BITS)];
+}
+
+/* Within an RCU read-side critical section, or with the mutex held. */
+static struct cache_entry *cache_find(unsigned long key)
+{
+	struct cache_entry *e;
+
+	rcu_txn_hlist_for_each_entry_rcu(e, cache_bucket(key), hnode,
+					 lockdep_is_held(&cache_mutex))
+		if (e->key == key)
+			return e;
+	return NULL;
+}
+
+static int cache_lookup_fn(void *arg)
+{
+	unsigned long lookups = 0, hits = 0, bad = 0;
+
+	while (!kthread_should_stop()) {
+		unsigned long key = get_random_u32_below(CACHE_KEYS);
+		struct cache_entry *e;
+
+		rcu_read_lock();
+		e = cache_find(key);
+		if (e) {
+			hits++;
+			if (e->value % CACHE_KEYS != key)
+				bad++;
+			if (!READ_ONCE(e->referenced))
+				WRITE_ONCE(e->referenced, true);
+		}
+		rcu_read_unlock();
+		lookups++;
+		cond_resched();
+	}
+	atomic_long_add(lookups, &nr_lookup);
+	atomic_long_add(hits, &nr_hit);
+	atomic_long_add(bad, &nr_bad);
+	return 0;
+}
+
+/*
+ * Record the eviction of the oldest entry that no lookup found since it last
+ * moved, after giving the referenced entries at the tail a second chance at
+ * the front.  Returns the victim, to free a grace period after the commit.
+ */
+static struct cache_entry *cache_evict_prepare(struct rcu_txn *txn)
+{
+	struct rcu_txn_list_node *head = &cache_lru.node;
+	struct cache_entry *e;
+	unsigned int chances;
+
+	for (chances = 0; ; chances++) {
+		/* The tail as this transaction leaves it so far. */
+		e = container_of(rcu_txn_list_pending(txn, &head->prev),
+				 struct cache_entry, lru);
+		if (chances == CACHE_CHANCES || !READ_ONCE(e->referenced))
+			break;
+		WRITE_ONCE(e->referenced, false);
+		rcu_txn_list_move_after_prepare(txn, &e->lru, head);
+	}
+	atomic_long_add(chances, &nr_chance);
+	rcu_txn_hlist_del_prepare(txn, &e->hnode);
+	rcu_txn_list_del_prepare(txn, &e->lru);
+	return e;
+}
+
+/* Insert @key, or update it, at version @version. */
+static void cache_insert(unsigned long key, unsigned long version)
+{
+	struct cache_entry *new, *old, *victim = NULL;
+	struct rcu_txn txn;
+
+	new = kzalloc_obj(*new, GFP_KERNEL);
+	if (!new) {
+		cache_fail();
+		return;
+	}
+	new->key = key;
+	new->value = key + CACHE_KEYS * version;
+
+	/* An allocation failure is sticky: the commit reports it. */
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_reserve(&txn, CACHE_RECORDS);
+
+	mutex_lock(&cache_mutex);
+	old = cache_find(key);
+	if (old) {
+		/* The new entry takes the old one's place in its bucket. */
+		rcu_txn_hlist_replace_prepare(&txn, &old->hnode, &new->hnode);
+		rcu_txn_list_del_prepare(&txn, &old->lru);
+		victim = old;
+	} else {
+		if (cache_count == CACHE_SIZE)
+			victim = cache_evict_prepare(&txn);
+		rcu_txn_hlist_add_head_prepare(&txn, &new->hnode,
+					       cache_bucket(key));
+	}
+	rcu_txn_list_add_after_prepare(&txn, &new->lru, &cache_lru.node);
+	if (rcu_txn_commit(&txn)) {
+		/* Nothing was published. */
+		mutex_unlock(&cache_mutex);
+		cache_fail();
+		kfree(new);
+		return;
+	}
+	if (!victim)
+		cache_count++;
+	mutex_unlock(&cache_mutex);
+
+	if (old)
+		atomic_long_inc(&nr_update);
+	else
+		atomic_long_inc(victim ? &nr_evict : &nr_insert);
+	if (victim)
+		kfree_rcu(victim, rcu);
+}
+
+static void cache_delete(unsigned long key)
+{
+	struct cache_entry *e;
+	struct rcu_txn txn;
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_reserve(&txn, 4);
+
+	mutex_lock(&cache_mutex);
+	e = cache_find(key);
+	if (e) {
+		rcu_txn_hlist_del_prepare(&txn, &e->hnode);
+		rcu_txn_list_del_prepare(&txn, &e->lru);
+	}
+	if (rcu_txn_commit(&txn)) {
+		mutex_unlock(&cache_mutex);
+		cache_fail();
+		return;
+	}
+	if (e)
+		cache_count--;
+	mutex_unlock(&cache_mutex);
+
+	if (e) {
+		atomic_long_inc(&nr_delete);
+		kfree_rcu(e, rcu);
+	}
+}
+
+static int cache_writer_fn(void *arg)
+{
+	unsigned long version = 0;
+
+	while (!kthread_should_stop()) {
+		unsigned long key = get_random_u32_below(CACHE_KEYS);
+
+		/* After an allocation failure, wait to be stopped. */
+		if (READ_ONCE(cache_failed)) {
+			msleep(20);
+			continue;
+		}
+		if (get_random_u32_below(8))
+			cache_insert(key, ++version);
+		else
+			cache_delete(key);
+		cond_resched();
+	}
+	return 0;
+}
+
+/*
+ * With the threads stopped: every entry of the hash table is in its bucket and
+ * in the list, both ways, and there are cache_count of them.
+ */
+static bool cache_check(void)
+{
+	unsigned int in_hash = 0, in_list = 0, in_reverse = 0, i;
+	struct cache_entry *e;
+	bool ok = true;
+
+	rcu_read_lock();
+	for (i = 0; i < ARRAY_SIZE(cache_hash); i++) {
+		rcu_txn_hlist_for_each_entry_rcu(e, &cache_hash[i], hnode) {
+			ok &= cache_find(e->key) == e;
+			in_hash++;
+		}
+	}
+	rcu_txn_list_for_each_entry_rcu(e, &cache_lru, lru) {
+		ok &= cache_find(e->key) == e;
+		in_list++;
+	}
+	rcu_txn_list_for_each_entry_reverse_rcu(e, &cache_lru, lru)
+		in_reverse++;
+	rcu_read_unlock();
+	return ok && in_hash == cache_count && in_list == cache_count &&
+	       in_reverse == cache_count;
+}
+
+/*
+ * With the threads stopped, no reader or writer is left: free every entry
+ * without unlinking it, which allocates nothing and so cannot fail.
+ */
+static void cache_free_all(void)
+{
+	struct rcu_txn_list_node *node, *next;
+	unsigned int i;
+
+	for (node = rcu_txn_list_next_check(&cache_lru.node, true);
+	     node != &cache_lru.node; node = next) {
+		next = rcu_txn_list_next_check(node, true);
+		kfree(container_of(node, struct cache_entry, lru));
+	}
+	rcu_txn_list_init(&cache_lru);
+	for (i = 0; i < ARRAY_SIZE(cache_hash); i++)
+		rcu_txn_hlist_init(&cache_hash[i]);
+	cache_count = 0;
+}
+
+static int __init cache_init(void)
+{
+	struct task_struct *threads[2 * CACHE_THREADS];
+	unsigned int i, n = 0;
+	bool ok;
+
+	for (i = 0; i < min(nr_lookups, CACHE_THREADS); i++)
+		threads[n++] = kthread_run(cache_lookup_fn, NULL,
+					   "rcu_txn_lookup/%u", i);
+	for (i = 0; i < min(nr_writers, CACHE_THREADS); i++)
+		threads[n++] = kthread_run(cache_writer_fn, NULL,
+					   "rcu_txn_writer/%u", i);
+	msleep(duration_ms);
+	for (i = 0; i < n; i++)
+		if (!IS_ERR(threads[i]))
+			kthread_stop(threads[i]);
+
+	ok = cache_check();
+	pr_info("%ld lookups, %ld hits, %ld bad; %ld insertions, %ld updates, %ld deletions, %ld evictions, %ld second chances, %ld allocation failures; %u entries\n",
+		atomic_long_read(&nr_lookup), atomic_long_read(&nr_hit),
+		atomic_long_read(&nr_bad), atomic_long_read(&nr_insert),
+		atomic_long_read(&nr_update), atomic_long_read(&nr_delete),
+		atomic_long_read(&nr_evict), atomic_long_read(&nr_chance),
+		atomic_long_read(&nr_nomem), cache_count);
+	if (!ok || atomic_long_read(&nr_bad))
+		pr_err("the hash table and the list disagree\n");
+	if (READ_ONCE(cache_failed))
+		pr_warn("an allocation failed, which stopped the writers\n");
+	cache_free_all();
+	return 0;
+}
+
+static void __exit cache_exit(void)
+{
+}
+
+module_init(cache_init);
+module_exit(cache_exit);
+
+MODULE_DESCRIPTION("A cache on RCU pseudo-transactions, its writers under one mutex");
+MODULE_LICENSE("GPL");
-- 
2.47.3

