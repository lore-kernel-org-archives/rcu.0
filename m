Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491284DAF90;
	Fri, 16 Oct 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157621; cv=none; b=ax6kSJJPYcDmsCwllEACDf0iVCrmIkKs9EUwSlIfOGLAd8Aro4WJxBUIP7R0ZOuU53QbkzUIoYDwzg/1emtTX1rj0ZC97pLrmWwixvexnNOFp7f5GMoRNn79wtxBEITZj1+7IO8MuOhORE3YGT8FSn6gGkjIMvVn8lISabZOpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157621; c=relaxed/simple;
	bh=W6MqSnwGc6MbclAyMj6l7nVWWNeF6IQh54VyLCWrbqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKF/fnPaeG0DqI+JA3ReAzjvSqFN+EKmYXPEqIa3AB81c7bb/O5fUsYawCqYz1iDaJ6cWE0BlievhOxc+CMZCCt2vd5NqWX0BuyUU6svFa5LHvNLqiNExXIFfQrUuerJVPH+KNUqK2H6L2A078zAjlCNL5/dpC9kl0T+qnxkMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p3/fofWe; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p3/fofWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1792157607;
	bh=dk1bRyMN9/4GBnroJp5RG77sre23e4Cr79cKLx2F73Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3/fofWerFkTuZeaTvHQI76cO5oQdgo7JAwbJVQq0ggmZN7wKsqAdyttbxqPiRzHC
	 Dh27AHc0I6Cw7Dk2GCHEMPie75RUgja8bp+l5BaIQbvLJD4R2lwMZew2gFUDg3DJ3O
	 NVeig5R2qrBx7RozFynp0aZEdWi21BWogdETd3ypNqz+q7hE2BighNcw1njuOueck8
	 halgF7uXUSqXCl9JLHdGTBG7NadgF9kA1Gv9uOxxK3f+hh8KGY510IfN8urmo+rBdi
	 jvICH5cpa+QTf2C03/tD6WmBBGBo9CTKDTYGHSK646gR9FBeSSfwRU8+QBHlD+JiHQ
	 uoH++07SAryJw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:52b6:7728:7602:8919])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j5m9M4zWKznrh;
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
Subject: [RFC PATCH 04/12] rcu_txn: Add CONFIG_DEBUG_RCU_TXN
Date: Fri, 16 Oct 2026 09:33:11 -0400
Message-Id: <20261016133319.433617-5-mathieu.desnoyers@efficios.com>
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

A pseudo-transaction relies on its caller to exclude other writers, and
has no way to notice when it does not: two writers racing on a slot
corrupt it silently.  Add an option that checks the contract.

It validates the proxy tags, warns about a slot recorded twice in one
transaction, and validates the single-writer contract:

 - a handle must be driven by the task that initialized it;
 - a slot being recorded or installed to must not hold a proxy, which
   would be another writer's;
 - at install, and at the commit of a single record, a slot must still
   hold the old value that was recorded;
 - at settle, a slot must still hold the proxy that was installed.

An embedder may get a transaction ready in one task, initializing it and
reserving its records where an allocation failure can still be handled,
then record and commit it in another task, such as the one that
completes an asynchronous request.  Nothing is recorded in between, so
nothing is mid-flight when the handle changes hands.  rcu_txn_adopt() is
what the task that takes over calls first: it makes that task the one
the checks expect, and warns if the handle already holds records.
Without the option it does nothing.

These checks report every occurrence, with WARN().  A once-only report
would be consumed by the first user to trip it, and hide the others.

The tests stage each violation deterministically, by installing the
other writer's proxy in the slot by hand.

Assisted-by: LLM
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/rcu_txn.h   | 195 ++++++++++++++++++++-
 kernel/rcu/Kconfig.debug  |  16 ++
 lib/rcu_txn.c             |   9 +-
 lib/rcu_txn_internal.h    |  79 +++++++++
 lib/tests/rcu_txn_kunit.c | 350 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 643 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcu_txn.h b/include/linux/rcu_txn.h
index ee152100ab95..2946c63fb044 100644
--- a/include/linux/rcu_txn.h
+++ b/include/linux/rcu_txn.h
@@ -107,6 +107,21 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#ifdef CONFIG_DEBUG_RCU_TXN
+#include <asm/current.h>
+#endif
+
+/*
+ * Contract checks that cost more than a test of the handle's state are built
+ * with CONFIG_DEBUG_RCU_TXN only.  They report every occurrence: a once-only
+ * report would hide the violations of every embedder but the first.
+ */
+#ifdef CONFIG_DEBUG_RCU_TXN
+# define RCU_TXN_WARN_ON(cond)	WARN_ON(cond)
+#else
+# define RCU_TXN_WARN_ON(cond)	BUILD_BUG_ON_INVALID(cond)
+#endif
+
 /*
  * First capacity of an unreserved handle: with its header, such a descriptor
  * fits a 256-byte allocation.  A transaction that records more should
@@ -226,6 +241,10 @@ struct rcu_txn {
 	enum rcu_txn_state state;
 	bool disjoint;			/* declared slot-disjoint */
 	bool bloom_live;		/* the descriptor's filter is armed */
+#ifdef CONFIG_DEBUG_RCU_TXN
+	/* Task that initialized or adopted the handle, and drives it. */
+	struct task_struct *owner;
+#endif
 };
 
 /*
@@ -251,6 +270,17 @@ static inline bool rcu_txn_is_proxy(const void *v, unsigned long tag)
 	return ((unsigned long)v & tag) == tag;
 }
 
+/*
+ * Does @v, loaded from a slot transacted under @tag, hold an installed proxy?
+ * Unlike rcu_txn_is_proxy(), this answers false under a zero tag, which every
+ * value matches and which marks no proxy.  A zero tag is legal for a
+ * transaction that installs none.
+ */
+static inline bool __rcu_txn_holds_proxy(const void *v, unsigned long tag)
+{
+	return tag && rcu_txn_is_proxy(v, tag);
+}
+
 /*
  * Recover the record's address from a slot value that holds an installed proxy.
  *
@@ -261,6 +291,7 @@ static inline bool rcu_txn_is_proxy(const void *v, unsigned long tag)
  */
 static inline struct rcu_txn_record *__rcu_txn_untag(void *v, unsigned long tag)
 {
+	RCU_TXN_WARN_ON(!rcu_txn_is_proxy(v, tag));
 	return (struct rcu_txn_record *)((unsigned long)v - tag);
 }
 
@@ -383,6 +414,96 @@ static inline void __rcu_txn_record_settle(struct rcu_txn_record *r)
 	rcu_assign_pointer(*r->slot, r->ptr[1]);
 }
 
+/*
+ * CONFIG_DEBUG_RCU_TXN: runtime validation of the single-writer contract.
+ *
+ * This engine requires writer mutual exclusion -- it has no install-time CAS,
+ * no conflict detection and no abort, so two writers racing on one slot simply
+ * corrupt it, and a default build does not detect it.  With
+ * CONFIG_DEBUG_RCU_TXN a violation warns, with a report identifying the
+ * violated handle or slot.  Without it there is no check, and the handle does
+ * not carry the owner field.
+ *
+ * There is no per-structure object to claim an owner on, so the
+ * validator claims the two things that do exist:
+ *
+ *   - the handle.  Its owner is the task that initialized it, or the one
+ *     that adopted it before anything was recorded, and reserve / record /
+ *     load / commit / cancel must all run in that task.  Catches a
+ *     transaction handed between tasks mid-flight.
+ *
+ *   - the slot, which is what two racing writers actually share, and so is
+ *     where the real violation is visible.  In a correct single-writer
+ *     program a slot being recorded or installed to cannot already hold an
+ *     installed proxy.  A proxy sitting there therefore means another
+ *     writer is mid-transaction on that very slot right now.
+ *     Symmetrically, at settle each slot must still hold this writer's
+ *     proxy; anything else means a concurrent writer overwrote it.
+ */
+
+#ifdef CONFIG_DEBUG_RCU_TXN
+
+static inline void __rcu_txn_excl_claim(struct rcu_txn *t)
+{
+	t->owner = current;
+}
+
+static inline void __rcu_txn_excl_owner(const struct rcu_txn *t,
+					const char *what)
+{
+	WARN(t->owner != current,
+	     "rcu_txn %p: %s in a task other than the one that initialized or adopted the handle -- one transaction is driven end to end by one task\n",
+	     t, what);
+}
+
+/* @slot must hold no proxy: it would be another writer's. */
+static inline void __rcu_txn_excl_slot_free(void __rcu **slot,
+					    unsigned long tag, const char *what)
+{
+	void *v = rcu_access_pointer(*slot);
+
+	WARN(__rcu_txn_holds_proxy(v, tag),
+	     "rcu_txn: slot %p already holds an installed proxy (%p) at %s: another writer is mid-transaction on it\n",
+	     slot, v, what);
+}
+
+/*
+ * @r's slot must still hold the recorded old.  This is the only witness of a
+ * single-record commit, which installs no proxy.
+ */
+static inline void __rcu_txn_excl_slot_unchanged(struct rcu_txn_record *r,
+						 const char *what)
+{
+	void *v = rcu_access_pointer(*r->slot);
+
+	WARN(v != r->ptr[0],
+	     "rcu_txn: slot %p holds %p at %s, but %p was recorded as its old: a concurrent writer changed it\n",
+	     r->slot, v, what, r->ptr[0]);
+}
+
+#else	/* !CONFIG_DEBUG_RCU_TXN */
+
+static inline void __rcu_txn_excl_claim(struct rcu_txn *t)
+{
+}
+
+static inline void __rcu_txn_excl_owner(const struct rcu_txn *t,
+					const char *what)
+{
+}
+
+static inline void __rcu_txn_excl_slot_free(void __rcu **slot,
+					    unsigned long tag, const char *what)
+{
+}
+
+static inline void __rcu_txn_excl_slot_unchanged(struct rcu_txn_record *r,
+						 const char *what)
+{
+}
+
+#endif	/* CONFIG_DEBUG_RCU_TXN */
+
 /*
  * Writer side
  * ===========
@@ -403,6 +524,7 @@ static inline void rcu_txn_init(struct rcu_txn *t, gfp_t gfp)
 	memset(t, 0, sizeof(*t));
 	t->state = RCU_TXN_PREPARE;
 	t->gfp = gfp;
+	__rcu_txn_excl_claim(t);
 }
 
 /*
@@ -439,11 +561,29 @@ static inline bool rcu_txn_reserve(struct rcu_txn *t, unsigned int cap)
 		WARN_ON_ONCE(t->state != RCU_TXN_OOM);
 		return false;
 	}
+	__rcu_txn_excl_owner(t, "reserve()");
 	if (t->records && cap <= t->cap)
 		return true;		/* already large enough */
 	return __rcu_txn_resize(t, cap);
 }
 
+/**
+ * rcu_txn_adopt() - take over a handle that another task got ready
+ * @t: the handle, initialized and holding no record yet
+ *
+ * One task drives a transaction end to end.  An embedder may still get a
+ * handle ready in one task, where it can sleep and fail, with rcu_txn_init()
+ * and rcu_txn_reserve(), and have another record and commit, or cancel.  The
+ * task that takes over calls this first.  The embedder makes sure that the
+ * task which got the handle ready is done with it.
+ */
+static inline void rcu_txn_adopt(struct rcu_txn *t)
+{
+	/* A handle that changes hands with records in it is mid-flight. */
+	RCU_TXN_WARN_ON(t->nr);
+	__rcu_txn_excl_claim(t);
+}
+
 /* Free a descriptor that installed no proxy: see lib/rcu_txn.c. */
 void __rcu_txn_free_desc(struct rcu_txn_desc *desc);
 
@@ -581,8 +721,8 @@ bool __rcu_txn_grow(struct rcu_txn *t);
  * Records must target pairwise-distinct slots.  record() appends without
  * looking for an earlier record of the same slot; recording a slot twice
  * installs two proxies on it and settles both in record order, so the earlier
- * edit is lost.  Use rcu_txn_record_chain() when the same slot may be written
- * twice.
+ * edit is lost.  CONFIG_DEBUG_RCU_TXN warns about it at commit.  Use
+ * rcu_txn_record_chain() when the same slot may be written twice.
  *
  * Context: The caller excludes other writers of @slot.  May sleep if the
  * handle is full and its gfp_t allows it.
@@ -599,6 +739,15 @@ static inline bool rcu_txn_record(struct rcu_txn *t, void __rcu **slot,
 		WARN_ON_ONCE(t->state != RCU_TXN_OOM);
 		return false;
 	}
+	/*
+	 * Neither value may look like a proxy under @tag.  After settle the
+	 * slot holds @new_ptr directly: were it tagged, every later reader
+	 * would resolve it as a proxy and dereference garbage.
+	 */
+	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(old_ptr, tag));
+	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(new_ptr, tag));
+	__rcu_txn_excl_owner(t, "record()");
+	__rcu_txn_excl_slot_free(slot, tag, "record()");
 	if (unlikely(t->nr == t->cap) && !__rcu_txn_grow(t))
 		return false;			/* OOM, now sticky */
 	r = &t->records[t->nr++];
@@ -657,7 +806,8 @@ static inline bool rcu_txn_record(struct rcu_txn *t, void __rcu **slot,
  * from the second record on.
  *
  * Recording a slot twice on such a handle breaks the rule of rcu_txn_record(),
- * with the consequence stated there.
+ * with the consequence stated there.  CONFIG_DEBUG_RCU_TXN warns about it at
+ * the offending rcu_txn_load() or rcu_txn_record_chain().
  *
  * Call after init and before the first record().  On a handle whose reserve()
  * failed it does nothing: the failure is sticky, and commit() reports it.
@@ -672,6 +822,27 @@ static inline void rcu_txn_declare_disjoint(struct rcu_txn *t)
 	t->disjoint = true;
 }
 
+/*
+ * On a handle declared disjoint, warn when a load or a record targets a slot
+ * that the transaction has already recorded.  The load would return the
+ * committed value where its caller expects the pending one, and the record
+ * would install a second proxy on the slot.
+ */
+#ifdef CONFIG_DEBUG_RCU_TXN
+static inline void __rcu_txn_disjoint_check(const struct rcu_txn *t,
+					    void __rcu **slot, const char *what)
+{
+	WARN(t->disjoint && __rcu_txn_scan(t, slot),
+	     "rcu_txn %p: slot %p is already recorded at %s, on a handle declared disjoint\n",
+	     t, slot, what);
+}
+#else
+static inline void __rcu_txn_disjoint_check(const struct rcu_txn *t,
+					    void __rcu **slot, const char *what)
+{
+}
+#endif
+
 /**
  * rcu_txn_load() - load a slot as the transaction will leave it
  * @t: the handle
@@ -681,6 +852,10 @@ static inline void rcu_txn_declare_disjoint(struct rcu_txn *t)
  * On a handle declared disjoint, this returns the committed value without
  * looking for a pending one.
  *
+ * CONFIG_DEBUG_RCU_TXN checks that an unrecorded slot holds no proxy under
+ * @tag: this writer owns every store to the slot, and its earlier transactions
+ * settled before commit() returned.
+ *
  * Context: The caller excludes other writers of @slot.
  * Return: the pending new value of the transaction's record for @slot if it
  * has one, else the slot's current value.
@@ -691,6 +866,7 @@ static inline void *rcu_txn_load(struct rcu_txn *t, void __rcu **slot,
 	struct rcu_txn_record *r;
 	void *v;
 
+	__rcu_txn_excl_owner(t, "load()");
 	/* A consumed handle has no record left: it reads committed values. */
 	WARN_ON_ONCE(t->state == RCU_TXN_DONE);
 	if (!t->disjoint) {
@@ -698,7 +874,9 @@ static inline void *rcu_txn_load(struct rcu_txn *t, void __rcu **slot,
 		if (r)
 			return r->ptr[1];	/* our own pending write */
 	}
+	__rcu_txn_disjoint_check(t, slot, "load()");
 	v = rcu_dereference_protected(*slot, 1);
+	RCU_TXN_WARN_ON(__rcu_txn_holds_proxy(v, tag));
 	return v;
 }
 
@@ -715,6 +893,9 @@ static inline bool __rcu_txn_chain(struct rcu_txn *t, void __rcu **slot,
 	r = __rcu_txn_find_ryw(t, slot);
 	if (!r)
 		return rcu_txn_record(t, slot, old_ptr, new_ptr, tag);
+	RCU_TXN_WARN_ON(r->tag != tag);
+	/* The caller must have read its own write. */
+	RCU_TXN_WARN_ON(r->ptr[1] != old_ptr);
 	r->ptr[1] = new_ptr;		/* committed old preserved */
 	return true;
 }
@@ -733,7 +914,8 @@ static inline bool __rcu_txn_chain(struct rcu_txn *t, void __rcu **slot,
  * rcu_txn_record() does.  See the pair's contract above.
  *
  * On the chain path @old_ptr is the record's pending value, and a different
- * @old_ptr means the caller computed @new_ptr from a stale read.
+ * @old_ptr means the caller computed @new_ptr from a stale read, which
+ * CONFIG_DEBUG_RCU_TXN warns about.
  *
  * Context: As rcu_txn_record().
  * Return: As rcu_txn_record().
@@ -747,7 +929,9 @@ static inline bool rcu_txn_record_chain(struct rcu_txn *t, void __rcu **slot,
 		WARN_ON_ONCE(t->state != RCU_TXN_OOM);
 		return false;
 	}
+	__rcu_txn_excl_owner(t, "record_chain()");
 	if (t->disjoint) {		/* no slot repeats: skip the lookup */
+		__rcu_txn_disjoint_check(t, slot, "record_chain()");
 		return rcu_txn_record(t, slot, old_ptr, new_ptr, tag);
 	}
 	return __rcu_txn_chain(t, slot, old_ptr, new_ptr, tag);
@@ -770,6 +954,7 @@ static inline bool rcu_txn_record_chain(struct rcu_txn *t, void __rcu **slot,
  */
 static inline void rcu_txn_cancel(struct rcu_txn *t)
 {
+	__rcu_txn_excl_owner(t, "cancel()");
 	/* A consumed handle must be initialized again before reuse. */
 	if (WARN_ON_ONCE(t->state == RCU_TXN_DONE))
 		return;
@@ -811,6 +996,7 @@ static inline int rcu_txn_commit(struct rcu_txn *t)
 {
 	const unsigned int nr = t->nr;
 
+	__rcu_txn_excl_owner(t, "commit()");
 	/* A consumed handle must be initialized again before reuse. */
 	if (WARN_ON_ONCE(t->state == RCU_TXN_DONE))
 		return -EINVAL;
@@ -823,6 +1009,7 @@ static inline int rcu_txn_commit(struct rcu_txn *t)
 			struct rcu_txn_record *r = &t->records[0];
 
 			/* One record: its settle store is the whole commit. */
+			__rcu_txn_excl_slot_unchanged(r, "commit");
 			__rcu_txn_record_settle(r);
 		}
 		__rcu_txn_release_desc(t);	/* no proxy: free now */
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index e078e988773d..9faa8a5e801c 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -239,4 +239,20 @@ config TRIVIAL_PREEMPT_RCU
 
 	  This has no value for production and is only for testing.
 
+config DEBUG_RCU_TXN
+	bool "Debug checks for single-writer RCU pseudo-transactions"
+	depends on DEBUG_KERNEL && RCU_TXN
+	help
+	  Enable the costlier contract checks of <linux/rcu_txn.h>: validity
+	  of the proxy tags, pairwise-distinct recorded slots, and a validator
+	  of the single-writer contract.  The validator warns when a
+	  transaction is driven by two tasks, and when a slot it records,
+	  installs to or settles was touched by another writer in the
+	  meantime.
+
+	  This adds an owner field to every transaction handle and a pairwise
+	  scan of the records to every commit of two records or more.
+
+	  Say N unless you are debugging a user of RCU pseudo-transactions.
+
 endmenu # "RCU Debugging"
diff --git a/lib/rcu_txn.c b/lib/rcu_txn.c
index b040af0a8cdb..a4a71dfb2282 100644
--- a/lib/rcu_txn.c
+++ b/lib/rcu_txn.c
@@ -123,14 +123,19 @@ void __rcu_txn_commit_desc(struct rcu_txn_desc *desc, unsigned int nr)
 	struct rcu_txn_record *records = desc->records;
 	unsigned int i;
 
+	__rcu_txn_assert_distinct_slots(records, nr);
 	/* Install: readers still resolve to old, the selector being 0. */
-	for (i = 0; i < nr; i++)
+	for (i = 0; i < nr; i++) {
+		__rcu_txn_excl_slot_installable(&records[i]);
 		__rcu_txn_record_install(&desc->group, &records[i]);
+	}
 	/* Flip: every proxy resolves to new. */
 	__rcu_txn_group_commit(&desc->group);
 	/* Settle. */
-	for (i = 0; i < nr; i++)
+	for (i = 0; i < nr; i++) {
+		__rcu_txn_excl_slot_ours(&records[i]);
 		__rcu_txn_record_settle(&records[i]);
+	}
 	/* A reader may still hold a proxy, which lives in the descriptor. */
 	kfree_rcu(desc, rcu_head);
 }
diff --git a/lib/rcu_txn_internal.h b/lib/rcu_txn_internal.h
index 7e79a48697a8..a654b2ffaaa6 100644
--- a/lib/rcu_txn_internal.h
+++ b/lib/rcu_txn_internal.h
@@ -42,9 +42,88 @@ static inline void __rcu_txn_group_commit(struct rcu_txn_group *group)
 static inline void __rcu_txn_record_install(struct rcu_txn_group *group,
 					    struct rcu_txn_record *r)
 {
+	/*
+	 * Installing requires a non-zero tag within RCU_TXN_TAG_MASK, none of
+	 * whose bits is set in the record's address.  Under a zero tag every
+	 * plain value passes rcu_txn_is_proxy(), and readers would resolve live
+	 * values as proxies.  With a tag bit already set in the address, the OR
+	 * changes nothing and __rcu_txn_untag() subtracts to a wrong address.
+	 */
+	RCU_TXN_WARN_ON(!r->tag || (r->tag & ~RCU_TXN_TAG_MASK));
+	RCU_TXN_WARN_ON((unsigned long)r & r->tag);
 	r->group = group;
 	/* Store-release of slot pairs with rcu_dereference(). */
 	rcu_assign_pointer(*r->slot, (void *)((unsigned long)r | r->tag));
 }
 
+/*
+ * The install and settle checks of CONFIG_DEBUG_RCU_TXN: see
+ * <linux/rcu_txn.h>.
+ */
+#ifdef CONFIG_DEBUG_RCU_TXN
+
+/* At settle, @r's slot must still hold the proxy this writer installed. */
+static inline void __rcu_txn_excl_slot_ours(struct rcu_txn_record *r)
+{
+	void *want = (void *)((unsigned long)r | r->tag);
+	void *v = rcu_access_pointer(*r->slot);
+
+	WARN(v != want,
+	     "rcu_txn: slot %p holds %p at settle, expected our installed proxy %p: a concurrent writer overwrote it\n",
+	     r->slot, v, want);
+}
+
+/*
+ * At the multi-record install, @r's slot must hold no proxy and must still
+ * hold the recorded old.
+ *
+ * The value check catches a racing writer that ran a complete transaction on
+ * the slot -- install, flip, settle -- between this transaction's record() and
+ * its install.  That writer leaves a plain value behind, so the slot looks
+ * free; installing over it would publish a stale old to readers, then settle
+ * over the other writer's committed value.
+ *
+ * A correct single-writer program never trips it: this transaction has not
+ * written the slot yet, the writer's earlier transactions settled before
+ * returning, and chaining keeps the committed old in ptr[0].
+ */
+static inline void __rcu_txn_excl_slot_installable(struct rcu_txn_record *r)
+{
+	__rcu_txn_excl_slot_free(r->slot, r->tag, "install");
+	__rcu_txn_excl_slot_unchanged(r, "install");
+}
+
+/*
+ * Records must target pairwise-distinct slots: see rcu_txn_record().  They are
+ * in record order, hence the pairwise scan.
+ */
+static inline void
+__rcu_txn_assert_distinct_slots(const struct rcu_txn_record *records,
+				unsigned int nr)
+{
+	unsigned int i, j;
+
+	for (i = 1; i < nr; i++)
+		for (j = 0; j < i; j++)
+			WARN_ON(records[i].slot == records[j].slot);
+}
+
+#else	/* !CONFIG_DEBUG_RCU_TXN */
+
+static inline void __rcu_txn_excl_slot_ours(struct rcu_txn_record *r)
+{
+}
+
+static inline void __rcu_txn_excl_slot_installable(struct rcu_txn_record *r)
+{
+}
+
+static inline void
+__rcu_txn_assert_distinct_slots(const struct rcu_txn_record *records,
+				unsigned int nr)
+{
+}
+
+#endif	/* CONFIG_DEBUG_RCU_TXN */
+
 #endif /* _LIB_RCU_TXN_INTERNAL_H */
diff --git a/lib/tests/rcu_txn_kunit.c b/lib/tests/rcu_txn_kunit.c
index 3111fc537ff3..3f005cdee4d0 100644
--- a/lib/tests/rcu_txn_kunit.c
+++ b/lib/tests/rcu_txn_kunit.c
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 #include <linux/rcu_txn.h>
 #include <linux/rcupdate.h>
+#include <linux/sched/task.h>
 #include <linux/string.h>
 
 #include "../rcu_txn_internal.h"	/* the steps of a commit */
@@ -577,6 +578,341 @@ static void rcu_txn_test_bloom_grow(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, all_settled(slots, NR));
 }
 
+/*
+ * CONFIG_DEBUG_RCU_TXN
+ *
+ * Every case below is an embedder bug that the debug checks report.  The
+ * writer/writer races are staged deterministically: the other writer's proxy is
+ * installed in the slot by hand, as a real race would leave it.
+ */
+
+static void need_debug(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_DEBUG_RCU_TXN))
+		kunit_skip(test, "CONFIG_DEBUG_RCU_TXN is off");
+}
+
+#ifdef CONFIG_DEBUG_RCU_TXN
+static void set_owner(struct rcu_txn *t, struct task_struct *task)
+{
+	t->owner = task;
+}
+#else
+static void set_owner(struct rcu_txn *t, struct task_struct *task)
+{
+}
+#endif
+
+/*
+ * Install a proxy into @slot by hand, as a writer stopped between its install
+ * and its flip leaves it.  commit() runs install, flip and settle back to back,
+ * so one task cannot stop a transaction there.
+ */
+static void install_by_hand(struct rcu_txn_group *group,
+			    struct rcu_txn_record *rec, void __rcu **slot,
+			    void *old_ptr, void *new_ptr)
+{
+	__rcu_txn_group_init(group);
+	__rcu_txn_record_set(rec, slot, old_ptr, new_ptr, TAG);
+	__rcu_txn_record_install(group, rec);
+}
+
+/* A well-formed single-writer transaction trips nothing. */
+static void rcu_txn_test_debug_control(struct kunit *test)
+{
+	void __rcu *a = RCU_INITIALIZER(T(0));
+	void __rcu *b = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+	unsigned int i;
+
+	need_debug(test);
+	kunit_warning_suppress(test) {
+		for (i = 0; i < 100; i++) {
+			void *to = T(1 + i), *from = T(i);
+
+			rcu_txn_init(&txn, GFP_KERNEL);
+			rcu_txn_record(&txn, &a, from, to, TAG);
+			rcu_txn_record_chain(&txn, &b,
+					     rcu_txn_load(&txn, &b, TAG), to,
+					     TAG);
+			KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+		}
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+	}
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(a), T(100));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(b), T(100));
+}
+
+/* A handle driven by a task other than the one that initialized it. */
+static void rcu_txn_test_debug_owner(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	need_debug(test);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	set_owner(&txn, &init_task);	/* as if another task initialized it */
+	kunit_warning_suppress(test) {
+		rcu_txn_record(&txn, &slot, T(0), T(1), TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	set_owner(&txn, current);
+	rcu_txn_cancel(&txn);
+}
+
+/*
+ * A handle got ready by one task and adopted by the one that drives it.  Not
+ * with records in it: that is a transaction changing hands mid-flight.
+ */
+static void rcu_txn_test_debug_adopt(struct kunit *test)
+{
+	void __rcu *a = RCU_INITIALIZER(T(0));
+	void __rcu *b = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	need_debug(test);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, rcu_txn_reserve(&txn, 2));
+	set_owner(&txn, &init_task);	/* as if another task got it ready */
+	kunit_warning_suppress(test) {
+		rcu_txn_adopt(&txn);
+		rcu_txn_record(&txn, &a, T(0), T(1), TAG);
+		rcu_txn_record(&txn, &b, T(0), T(1), TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 0);
+		rcu_txn_adopt(&txn);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+		KUNIT_EXPECT_EQ(test, rcu_txn_commit(&txn), 0);
+	}
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(a), T(1));
+	KUNIT_EXPECT_PTR_EQ(test, rcu_access_pointer(b), T(1));
+}
+
+/*
+ * A second writer records a slot where the first has already installed a
+ * proxy.  This is the interleaving where the violation is visible: the first
+ * writer is between its install and its flip, so its proxy is sitting in the
+ * slot.
+ */
+static void rcu_txn_test_debug_record_over_proxy(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_group group;
+	struct rcu_txn_record rec;
+	struct rcu_txn txn;
+
+	need_debug(test);
+	install_by_hand(&group, &rec, &slot, T(0), T(1));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	kunit_warning_suppress(test) {
+		rcu_txn_record(&txn, &slot, T(1), T(2), TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+}
+
+/*
+ * A second writer installs onto a slot where the first has already installed a
+ * proxy.  It recorded the slot while it was still plain, so record() saw
+ * nothing wrong; the overlap only becomes visible at its own install, which
+ * finds a proxy there and not the recorded old.
+ */
+static void rcu_txn_test_debug_install_over_proxy(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_record rec, other;
+	struct rcu_txn_group group;
+
+	need_debug(test);
+	/* Recorded while the slot is still plain. */
+	__rcu_txn_record_set(&rec, &slot, T(0), T(2), TAG);
+	install_by_hand(&group, &other, &slot, T(0), T(1));
+	kunit_warning_suppress(test) {
+		__rcu_txn_excl_slot_installable(&rec);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 2);
+	}
+}
+
+/*
+ * A peer ran a complete transaction on the slot between our record() and our
+ * commit().  It leaves a plain value behind, so the slot looks free; the
+ * witness is that it no longer holds the recorded old.  The peer's committed
+ * write is staged by a plain store, which is what it leaves behind.
+ */
+static void rcu_txn_test_debug_install_over_settled(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_record rec;
+
+	need_debug(test);
+	__rcu_txn_record_set(&rec, &slot, T(0), T(1), TAG);
+	rcu_assign_pointer(slot, T(2));		/* a peer committed 0 -> 2 */
+	kunit_warning_suppress(test) {
+		__rcu_txn_excl_slot_installable(&rec);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+/* Our proxy is gone by the time we settle: someone overwrote it. */
+static void rcu_txn_test_debug_settle_clobbered(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_group group;
+	struct rcu_txn_record rec;
+
+	need_debug(test);
+	/* Stands for our install. */
+	install_by_hand(&group, &rec, &slot, T(0), T(1));
+	rcu_assign_pointer(slot, T(2));		/* a peer overwrites it */
+	kunit_warning_suppress(test) {
+		__rcu_txn_excl_slot_ours(&rec);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+/*
+ * The single-record commit stores blind, with no proxy and no install, so its
+ * only witness is the slot's value: it must still hold the recorded old.
+ */
+static void rcu_txn_test_debug_single_record_changed(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	need_debug(test);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record(&txn, &slot, T(0), T(1), TAG);
+	rcu_assign_pointer(slot, T(2));		/* a peer changed it under us */
+	kunit_warning_suppress(test) {
+		rcu_txn_commit(&txn);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+/*
+ * One slot recorded twice, not adjacently: the commit would install both
+ * records and settle them in record order, dropping the earlier edit.
+ */
+static void rcu_txn_test_debug_duplicate_slot(struct kunit *test)
+{
+	void __rcu *a = RCU_INITIALIZER(T(0));
+	void __rcu *b = RCU_INITIALIZER(T(1));
+	struct rcu_txn_record recs[3];
+
+	need_debug(test);
+	__rcu_txn_record_set(&recs[0], &a, T(0), T(10), TAG);
+	__rcu_txn_record_set(&recs[1], &b, T(1), T(11), TAG);
+	__rcu_txn_record_set(&recs[2], &a, T(10), T(12), TAG);
+	kunit_warning_suppress(test) {
+		__rcu_txn_assert_distinct_slots(recs, ARRAY_SIZE(recs));
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+/*
+ * No value stored in a transacted slot may carry the slot's tag: a reader
+ * would take it for a proxy.  Caught at the record that introduces it, on the
+ * new value and on the old.
+ */
+static void rcu_txn_test_debug_tagged_value(struct kunit *test)
+{
+	void *tagged = (void *)((unsigned long)T(1) | TAG);
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	need_debug(test);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	kunit_warning_suppress(test) {
+		rcu_txn_record(&txn, &slot, T(0), tagged, TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+
+	rcu_txn_init(&txn, GFP_KERNEL);
+	kunit_warning_suppress(test) {
+		rcu_txn_record(&txn, &slot, tagged, T(2), TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+}
+
+/* A proxy cannot be installed under a zero tag: nothing would mark it. */
+static void rcu_txn_test_debug_install_zero_tag(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_group group;
+	struct rcu_txn_record rec;
+
+	need_debug(test);
+	__rcu_txn_group_init(&group);
+	__rcu_txn_record_set(&rec, &slot, T(0), T(1), 0);
+	kunit_warning_suppress(test) {
+		__rcu_txn_record_install(&group, &rec);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+}
+
+/*
+ * On a handle declared disjoint, a load or a record of a slot already recorded:
+ * the load would miss the pending value, and the record would put a second
+ * proxy on the slot.
+ */
+static void rcu_txn_test_debug_disjoint(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	need_debug(test);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_declare_disjoint(&txn);
+	rcu_txn_record_chain(&txn, &slot, T(0), T(1), TAG);
+	kunit_warning_suppress(test) {
+		KUNIT_EXPECT_PTR_EQ(test, rcu_txn_load(&txn, &slot, TAG), T(0));
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	kunit_warning_suppress(test) {
+		rcu_txn_record_chain(&txn, &slot, T(0), T(2), TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+}
+
+/*
+ * record_chain() given an old value that is not the pending one: its caller
+ * computed the new value from a stale read.
+ */
+static void rcu_txn_test_debug_stale_chain(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn txn;
+
+	need_debug(test);
+	rcu_txn_init(&txn, GFP_KERNEL);
+	rcu_txn_record_chain(&txn, &slot, T(0), T(1), TAG);
+	kunit_warning_suppress(test) {
+		rcu_txn_record_chain(&txn, &slot, T(0), T(2), TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+}
+
+/* load() finds another writer's proxy in a slot it has not recorded. */
+static void rcu_txn_test_debug_load_proxy(struct kunit *test)
+{
+	void __rcu *slot = RCU_INITIALIZER(T(0));
+	struct rcu_txn_group group;
+	struct rcu_txn_record rec;
+	struct rcu_txn txn;
+
+	need_debug(test);
+	install_by_hand(&group, &rec, &slot, T(0), T(1));
+	rcu_txn_init(&txn, GFP_KERNEL);
+	kunit_warning_suppress(test) {
+		rcu_txn_load(&txn, &slot, TAG);
+		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
+	}
+	rcu_txn_cancel(&txn);
+}
+
 static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_single_record),
 	KUNIT_CASE(rcu_txn_test_multi_record),
@@ -596,6 +932,20 @@ static struct kunit_case rcu_txn_test_cases[] = {
 	KUNIT_CASE(rcu_txn_test_bloom_rebuild),
 	KUNIT_CASE(rcu_txn_test_bloom_arming),
 	KUNIT_CASE(rcu_txn_test_bloom_grow),
+	KUNIT_CASE(rcu_txn_test_debug_control),
+	KUNIT_CASE(rcu_txn_test_debug_owner),
+	KUNIT_CASE(rcu_txn_test_debug_adopt),
+	KUNIT_CASE(rcu_txn_test_debug_record_over_proxy),
+	KUNIT_CASE(rcu_txn_test_debug_install_over_proxy),
+	KUNIT_CASE(rcu_txn_test_debug_install_over_settled),
+	KUNIT_CASE(rcu_txn_test_debug_settle_clobbered),
+	KUNIT_CASE(rcu_txn_test_debug_single_record_changed),
+	KUNIT_CASE(rcu_txn_test_debug_duplicate_slot),
+	KUNIT_CASE(rcu_txn_test_debug_tagged_value),
+	KUNIT_CASE(rcu_txn_test_debug_install_zero_tag),
+	KUNIT_CASE(rcu_txn_test_debug_disjoint),
+	KUNIT_CASE(rcu_txn_test_debug_stale_chain),
+	KUNIT_CASE(rcu_txn_test_debug_load_proxy),
 	{}
 };
 
-- 
2.47.3

