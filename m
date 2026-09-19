Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1A30F92D;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778131; cv=none; b=qpD8jiFznyHoEtVgip5J8yvTAc75yT+V/85WE6+i7caOtszQQbgSa3z8kYKw8M5fvWQfUJWm1ttURnELEgTwVZsxZpt6gXkmawa96wmB8oPrWHmM0/1Gu8QRPRAAsX8n60SpeoycJGu1aBhSEDG8cnbB6RXM3NYQ+y2kiB9GNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778131; c=relaxed/simple;
	bh=eHuCNbH5vQe5moxbQhDHyft3bEu6Bh8yyHHJYYsOEXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mp/ZKVBlt32VkE4yy7FF+tKh3EhHuURMcjlPNok6DsAZ/ui201Wb/tGmTxGZo8WPHYWyHV2ZQtmngJHFD6Va4G+59jY0lQY1/HEDhBG0nnmoq8jCQWMWQy1QgIDwtkDlEfnWO9Oa6k0eVBWBC6XsaRYqBk1ktuKHzop53pcoSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhkOT6qQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhkOT6qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46E71F0089B;
	Sat, 19 Sep 2026 00:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778122;
	bh=Y0X/+HKdRSjBStAJd4m0h0L7c3rpH0Z1KPX1LfaOwy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhkOT6qQ7uHqZtm4q6FMON3LJUpkc9TMnmIknforWSmW8HTrAqSjewErkcE7bNYy+
	 wmT+2B9YRNseOMnyIN8Hf0bbEyE9cbytgn/KWysqUgIkABI3BGsUizlzNRzEDlOt88
	 Bm2yJcYEOOmEBWdjP3L57zi65Abye0F5bzVw2Stf3rWEvTPqRVDeyRp8subDeXjZQi
	 JXNPkrhLv0e+Cqnrj5I3GuyRk5SjmjpTPjeC3Z6yC5pAWnDIljbZ3XuKd2w+ifZ6PQ
	 LrqL4wV9KN8aBpIkf9f2m6MjZQMA4Xa+/H/EJ0VGBKk23uKpWIs9pNCvJsni3wRu4J
	 uEKRyM1JkpNdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9B5A0CE17C1; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 04/19] srcutree: Add an atomic Tree SRCU
Date: Fri, 18 Sep 2026 17:35:06 -0700
Message-Id: <20260919003521.3134552-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some dedicated srcu_struct users have read-side critical sections
which are short, never sleep, and never block on anything which may
itself depend on memory allocation — because they were, until
recently, spinlock or rwlock critical sections. For such a domain the
update side can safely wait for readers by spinning, from contexts
where sleeping is undesirable or the grace-period machinery's
latency (workqueue scheduling, jiffy-paced retries) dominates the
actual reader drain time.

But that is only safe if every reader keeps the promise. Make the
promise explicit and machine-checkable:

 - srcu_read_lock_atomic() / srcu_read_unlock_atomic() enter the
   usual (smp_mb-based) read-side critical section with preemption
   disabled and (except in hardirq, where it is redundant)
   non_block_start() armed, recording SRCU_READ_FLAVOR_ATOMIC in the
   per-CPU reader flavor. Disabling preemption enforces the
   no-sleeping promise on every configuration and bounds the section,
   so it is always running on some CPU; non_block_start() extends the
   enforcement to even potentially-sleeping calls on paths which
   happen not to block. The existing reader-flavor consistency checks
   complain about any mixing with other flavors.

 - synchronize_srcu_atomic() waits for all pre-existing readers by
   repeating the try_synchronize_srcu() both-epoch counter proof with
   cpu_relax() until it succeeds: no sleeping, no index flip, no
   grace-period sequence update, and therefore no interaction with
   concurrent call_srcu(), synchronize_srcu() or srcu_barrier(). It
   always provides the full grace-period guarantee: if the domain
   turns out to have had readers of any other flavor — a caller bug,
   since such a reader may be asleep and spinning on it would be
   unbounded — it complains and falls back to a real (sleeping) grace
   period internally, that being the only correct wait for a
   possibly-sleeping reader. The flavor mask is rechecked on every
   iteration so a first non-atomic reader appearing mid-spin takes
   the same path.

The immediate motivation is the proposed conversion of KVM's
gfn_to_pfn_cache to SRCU¹, whose mmu_notifier invalidation path drains
readers before the primary MMU zaps a page. With the readers declared
atomic, that drain becomes spin-only: no sleeping at all in the
notifier, bounded by the longest reader section, satisfying even the
strictest reading of the OOM-reaper non-blocking requirement without
needing to touch the non_block_start() annotation².

This commit also adds atomic-SRCU-specific initializers:
init_srcu_struct_atomic(), DEFINE_SRCU_ATOMIC(), and
DEFINE_STATIC_SRCU_ATOMIC().

This commit implements only Tree SRCU.  Tiny SRCU will follow.

¹ https://lore.kernel.org/all/20260811132237.102400-1-dwmw2@infradead.org/
² https://lore.kernel.org/all/20260812134934.GC662699@ziepe.ca/

[ paulmck: Apply Kunwu Chan feedback. ]

Co-developed-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Assisted-by: Claude:claude-mythos-5
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h     |  81 ++++++++++++++++++--
 include/linux/srcutree.h |   9 ++-
 kernel/rcu/srcutree.c    | 154 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 227 insertions(+), 17 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 7d9bc06df98d..3f232f2e0524 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -36,6 +36,8 @@ static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 int __init_srcu_struct_fast(struct srcu_struct *ssp, const char *name, struct lock_class_key *key);
 int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 				   struct lock_class_key *key);
+int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name,
+			      struct lock_class_key *key);
 #endif // #ifndef CONFIG_TINY_SRCU
 
 #define init_srcu_struct_fast(ssp) \
@@ -52,6 +54,13 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 	__init_srcu_struct_fast_updown((ssp), #ssp, &__srcu_key); \
 })
 
+#define init_srcu_struct_atomic(ssp) \
+({ \
+	static struct lock_class_key __srcu_key; \
+	\
+	__init_srcu_struct_atomic((ssp), #ssp, &__srcu_key); \
+})
+
 #define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
@@ -64,6 +73,7 @@ static inline int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 #ifndef CONFIG_TINY_SRCU
 int init_srcu_struct_fast(struct srcu_struct *ssp);
 int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
+int init_srcu_struct_atomic(struct srcu_struct *ssp);
 #endif // #ifndef CONFIG_TINY_SRCU
 
 #define __SRCU_DEP_MAP_INIT(srcu_name)
@@ -77,14 +87,18 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp);
 })
 
 /* Values for SRCU Tree srcu_data ->srcu_reader_flavor, but also used by rcutorture. */
-#define SRCU_READ_FLAVOR_NORMAL		0x1		// srcu_read_lock().
-#define SRCU_READ_FLAVOR_NMI		0x2		// srcu_read_lock_nmisafe().
-//					0x4		// SRCU-lite is no longer with us.
-#define SRCU_READ_FLAVOR_FAST		0x4		// srcu_read_lock_fast(), also NMI-safe.
-#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x8		// srcu_read_lock_fast_updown().
+#define SRCU_READ_FLAVOR_NORMAL		0x01		// srcu_read_lock().
+#define SRCU_READ_FLAVOR_NMI		0x02		// srcu_read_lock_nmisafe().
+//					0x04		// SRCU-lite is no longer with us.
+#define SRCU_READ_FLAVOR_FAST		0x04		// srcu_read_lock_fast(), also NMI-safe.
+#define SRCU_READ_FLAVOR_FAST_UPDOWN	0x08		// srcu_read_lock_fast_updown().
+#define SRCU_READ_FLAVOR_ATOMIC		0x10		// srcu_read_lock_atomic().
 #define SRCU_READ_FLAVOR_ALL		(SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
-					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
+					 SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN | \
+					 SRCU_READ_FLAVOR_ATOMIC)
 						// All of the above.
+#define SRCU_READ_FLAVOR_PREDEF		(SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_ATOMIC)
+						// Flavors special DEFINE_SRCU() flavors.
 #define SRCU_READ_FLAVOR_SLOWGP		(SRCU_READ_FLAVOR_FAST | SRCU_READ_FLAVOR_FAST_UPDOWN)
 						// Flavors requiring synchronize_rcu()
 						// instead of smp_mb().
@@ -102,6 +116,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
+void synchronize_srcu_atomic(struct srcu_struct *ssp);
 
 #define SRCU_GET_STATE_COMPLETED 0x1
 
@@ -306,6 +321,43 @@ static inline int srcu_read_lock(struct srcu_struct *ssp)
 	return retval;
 }
 
+/**
+ * srcu_read_lock_atomic - register a new reader promising an atomic section
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * As srcu_read_lock(), but the caller promises that the read-side
+ * critical section never sleeps and never blocks on anything which
+ * may itself depend on memory allocation to make progress. Preemption
+ * is disabled for the duration, which both enforces that promise (any
+ * sleepable call in the section will splat on every configuration)
+ * and bounds the section so that the update side may spin rather
+ * than sleep when waiting for readers: see synchronize_srcu_atomic().
+ *
+ * The lock and matching srcu_read_unlock_atomic() must be invoked on
+ * the same CPU, from the same context; passing the return value to
+ * another task is not permitted for this flavor.
+ */
+static inline int srcu_read_lock_atomic(struct srcu_struct *ssp)
+	__acquires_shared(ssp)
+{
+	int retval;
+
+	preempt_disable();
+	/*
+	 * Arm might_sleep() to catch even a *potentially* sleeping call
+	 * in the section, not just an actual schedule: the atomic-domain
+	 * promise must hold on every path, contended or not. In hardirq
+	 * the annotation would land on the interrupted task; it is also
+	 * redundant there, so skip it.
+	 */
+	if (!in_hardirq())
+		non_block_start();
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
+	retval = __srcu_read_lock(ssp);
+	srcu_lock_acquire(&ssp->dep_map);
+	return retval;
+}
+
 /**
  * srcu_read_lock_fast - register a new reader for an SRCU-protected structure.
  * @ssp: srcu_struct in which to register the new reader.
@@ -498,6 +550,23 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_read_unlock_atomic - unregister an atomic-section reader
+ * @ssp: srcu_struct from which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock_atomic().
+ */
+static inline void srcu_read_unlock_atomic(struct srcu_struct *ssp, int idx)
+	__releases_shared(ssp)
+{
+	WARN_ON_ONCE(idx & ~0x1);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
+	srcu_lock_release(&ssp->dep_map);
+	__srcu_read_unlock(ssp, idx);
+	if (!in_hardirq())
+		non_block_end();
+	preempt_enable();
+}
+
 /**
  * srcu_read_unlock_fast - unregister a old reader from an SRCU-protected structure.
  * @ssp: srcu_struct in which to unregister the old reader.
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 1ce759fb7094..ad9d9658b0a2 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -80,6 +80,7 @@ struct srcu_usage {
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	raw_spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
+	atomic_t srcu_atomic_gp_flag;		/* Serialize atomic GP work. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
@@ -229,14 +230,16 @@ struct srcu_struct {
 	is_static struct srcu_struct name =							\
 		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data, fast)
 #endif
-#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, 0, /* not static */)
+#define DEFINE_SRCU(name)		__DEFINE_SRCU(name, 0, /* !static */)
 #define DEFINE_STATIC_SRCU(name)	__DEFINE_SRCU(name, 0, static)
-#define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* not static */)
+#define DEFINE_SRCU_FAST(name)		__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, /* !static */)
 #define DEFINE_STATIC_SRCU_FAST(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST, static)
 #define DEFINE_SRCU_FAST_UPDOWN(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST_UPDOWN, \
-						      /* not static */)
+						      /* !static */)
 #define DEFINE_STATIC_SRCU_FAST_UPDOWN(name) \
 					__DEFINE_SRCU(name, SRCU_READ_FLAVOR_FAST_UPDOWN, static)
+#define DEFINE_SRCU_ATOMIC(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_ATOMIC, /* !static */)
+#define DEFINE_STATIC_SRCU_ATOMIC(name)	__DEFINE_SRCU(name, SRCU_READ_FLAVOR_ATOMIC, static)
 
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires_shared(ssp);
 void synchronize_srcu_expedited(struct srcu_struct *ssp);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c611a7168c70..570d068d1840 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -253,6 +253,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
+	atomic_set(&ssp->srcu_sup->srcu_atomic_gp_flag, 0);
 	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
@@ -330,6 +331,13 @@ int __init_srcu_struct_fast_updown(struct srcu_struct *ssp, const char *name,
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct_fast_updown);
 
+int __init_srcu_struct_atomic(struct srcu_struct *ssp, const char *name, struct lock_class_key *key)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
+	return __init_srcu_struct_common(ssp, name, key);
+}
+EXPORT_SYMBOL_GPL(__init_srcu_struct_atomic);
+
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
@@ -385,6 +393,26 @@ int init_srcu_struct_fast_updown(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct_fast_updown);
 
+/**
+ * init_srcu_struct_atomic - initialize an atomic sleep-RCU structure
+ * @ssp: structure to initialize.
+ *
+ * Use this in place of DEFINE_SRCU_ATOMIC() and DEFINE_STATIC_SRCU_ATOMIC()
+ * for non-static srcu_struct structures that are to be passed to
+ * srcu_read_lock_atomic() and friends.  It is necessary to invoke this on a
+ * given srcu_struct before passing that srcu_struct to any other function.
+ * Each srcu_struct represents a separate domain of SRCU protection.
+ *
+ * And yes, we really are defining a sleepable RCU implementation that
+ * cannot sleep.  Strange universe we live in, isn't it?
+ */
+int init_srcu_struct_atomic(struct srcu_struct *ssp)
+{
+	ssp->srcu_reader_flavor = SRCU_READ_FLAVOR_ATOMIC;
+	return init_srcu_struct_fields(ssp, false, false);
+}
+EXPORT_SYMBOL_GPL(init_srcu_struct_atomic);
+
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 /*
@@ -802,7 +830,10 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	WARN_ON_ONCE(ssp->srcu_reader_flavor && read_flavor != ssp->srcu_reader_flavor);
 	WARN_ON_ONCE(old_read_flavor && ssp->srcu_reader_flavor &&
 		     old_read_flavor != ssp->srcu_reader_flavor);
-	WARN_ON_ONCE(read_flavor == SRCU_READ_FLAVOR_FAST && !ssp->srcu_reader_flavor);
+	WARN_ON_ONCE(!!(read_flavor & SRCU_READ_FLAVOR_PREDEF) &&
+		     read_flavor != ssp->srcu_reader_flavor);
+	WARN_ON_ONCE(!!(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_PREDEF) &&
+		     read_flavor != ssp->srcu_reader_flavor);
 	if (!old_read_flavor) {
 		old_read_flavor = cmpxchg(&sdp->srcu_reader_flavor, 0, read_flavor);
 		if (!old_read_flavor)
@@ -942,7 +973,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
  * are initiating callback invocation.  This allows the ->srcu_have_cbs[]
  * array to have a finite number of elements.
  */
-static void srcu_gp_end(struct srcu_struct *ssp)
+static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 {
 	unsigned long cbdelay = 1;
 	bool cbs;
@@ -958,7 +989,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	struct srcu_usage *sup = ssp->srcu_sup;
 
 	/* Prevent more than one additional grace period. */
-	mutex_lock(&sup->srcu_cb_mutex);
+	if (!is_atomic)
+		mutex_lock(&sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
 	raw_spin_lock_irq_rcu_node(sup);
@@ -973,7 +1005,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(sup->srcu_gp_seq_needed_exp, gpseq);
 	raw_spin_unlock_irq_rcu_node(sup);
-	mutex_unlock(&sup->srcu_gp_mutex);
+	if (!is_atomic)
+		mutex_unlock(&sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
@@ -1018,13 +1051,15 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
-	mutex_unlock(&sup->srcu_cb_mutex);
+	if (!is_atomic)
+		mutex_unlock(&sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
 	raw_spin_lock_irq_rcu_node(sup);
 	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
 	    ULONG_CMP_LT(gpseq, sup->srcu_gp_seq_needed)) {
+		WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 		srcu_gp_start(ssp);
 		raw_spin_unlock_irq_rcu_node(sup);
 		srcu_reschedule(ssp, 0);
@@ -1148,6 +1183,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	/* If grace period not already in progress, start it. */
 	if (!WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) &&
 	    rcu_seq_state(sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
+		WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 		srcu_gp_start(ssp);
 
 		// And how can that list_add() in the "else" clause
@@ -1482,6 +1518,8 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
+	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
+		return; // Leak the callback rather than corrupt SRCU state.
 	if (should_rcu_defer()) {
 		struct srcu_defer *sndp = this_cpu_ptr(&srcu_defer);
 		struct srcu_data *sdp;
@@ -1621,6 +1659,11 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
+	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC)) {
+		// This works, and exposes a possible bug.
+		synchronize_srcu_atomic(ssp);
+		return;
+	}
 	might_sleep();
 	check_init_srcu_struct(ssp, false);
 	init_completion(&rcu.completion);
@@ -1741,10 +1784,21 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
  * period has elapsed in the meantime.  Unlike get_state_synchronize_srcu(),
  * this function also ensures that any needed SRCU grace period will be
  * started.  This convenience does come at a cost in terms of CPU overhead.
+ *
+ * This function cannot be used with atomic SRCU, which only has
+ * atomic grace periods.  Give a warning if someone tries, and return
+ * the same cookie that would have been returned, but refrain from
+ * messing up state by starting a grace period.  If someone somewhere
+ * somehow invokes synchronize_srcu_atomic(), passing this cookie to
+ * poll_state_synchronize_srcu() will return true.  If no one ever invokes
+ * synchronize_srcu_atomic(), too bad.
  */
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
-	return srcu_gp_start_if_needed(ssp, NULL, true);
+	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
+		return get_state_synchronize_srcu(ssp);
+	else
+		return srcu_gp_start_if_needed(ssp, NULL, true);
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
 
@@ -1833,6 +1887,12 @@ void srcu_barrier(struct srcu_struct *ssp)
 	unsigned long s;
 
 	check_init_srcu_struct(ssp, false);
+	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC)) {
+		// There shouldn't be any callbacks for atomic SRCU,
+		// but just in case.
+		schedule_timeout_uninterruptible(HZ/10);
+		return;
+	}
 
 	/*
 	 * Register any deferred callbacks before snapshotting the sequence.  The
@@ -1904,6 +1964,9 @@ static void srcu_expedite_current_cb(struct rcu_head *rhp)
  * no current grace period, one might be created.  If the current grace
  * period is currently sleeping, that sleep will complete before expediting
  * will take effect.
+ *
+ * This function must not be invoked on srcu_struct structures that are
+ * used with srcu_read_lock_atomic() and synchronize_srcu_atomic().
  */
 void srcu_expedite_current(struct srcu_struct *ssp)
 {
@@ -1911,6 +1974,9 @@ void srcu_expedite_current(struct srcu_struct *ssp)
 	bool needcb = false;
 	struct srcu_data *sdp;
 
+	// Atomic SRCU has no callbacks, so there is nothing to expedite.
+	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
+		return;
 	migrate_disable();
 	sdp = this_cpu_ptr(ssp->sda);
 	raw_spin_lock_irqsave_sdp_contention(sdp, &flags);
@@ -1978,8 +2044,10 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 			return;
 		}
 		idx = rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq));
-		if (idx == SRCU_STATE_IDLE)
+		if (idx == SRCU_STATE_IDLE) {
+			WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 			srcu_gp_start(ssp);
+		}
 		raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		if (idx != SRCU_STATE_IDLE) {
 			if (!is_atomic)
@@ -2015,9 +2083,78 @@ static void srcu_advance_state(struct srcu_struct *ssp, bool is_atomic)
 			return; /* readers present, retry later. */
 		}
 		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
-		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
+		srcu_gp_end(ssp, is_atomic);  /* Releases ->srcu_gp_mutex. */
+	}
+}
+
+/**
+ * synchronize_srcu_atomic - spin for prior SRCU read-side critical-section completion
+ * @ssp: srcu_struct with which to synchronize.
+ *
+ * Similar to synchronize_srcu(), but spins rather than blocking.
+ * Use only with srcu_read_lock_atomic() and srcu_read_unlock_atomic(),
+ * which are forbidden from voluntarily context switching.  If
+ * synchronize_srcu_atomic() is invoked from a more restrictive context
+ * (for example, interrupts disabled) for a given srcu_struct structure,
+ * then for that structure, all calls to both srcu_read_lock_atomic()
+ * and srcu_read_unlock_atomic() must be invoked from that same context,
+ * or one that is even more strict.
+ *
+ * If synchronize_srcu_atomic() is invoked on a given srcu_struct
+ * structure, then none of call_srcu(), synchronize_srcu(),
+ * synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
+ * srcu_barrier(), or srcu_expedite_current() may be invoked on that
+ * same structure.
+ *
+ * Because synchronize_srcu_atomic() is even more expedited than is
+ * synchronize_srcu_expedited(), there is no expedited counterpart to
+ * this function.
+ */
+void synchronize_srcu_atomic(struct srcu_struct *ssp)
+{
+	unsigned long srcu_state;
+	struct srcu_usage *sup = ssp->srcu_sup;
+
+	// Initialize.	Either init_srcu_struct() was invoked or
+	// DEFINE_SRCU() or similar was used.  Therefore, no allocation
+	// will be done here.
+	check_init_srcu_struct(ssp, true);
+	srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_ATOMIC);
+
+	// Perhaps others will do our work for us.
+	srcu_state = get_state_synchronize_srcu(ssp);
+	while (atomic_read(&sup->srcu_atomic_gp_flag) ||
+	       atomic_xchg(&sup->srcu_atomic_gp_flag, 1)) {
+		if (poll_state_synchronize_srcu(ssp, srcu_state))
+			return;
+		cpu_relax();
+	}
+
+	// One last check for others doing our work for us under the lock.
+	raw_spin_lock_irq_rcu_node(sup);
+	if (poll_state_synchronize_srcu(ssp, srcu_state)) {
+		raw_spin_unlock_irq_rcu_node(sup);
+		atomic_set(&sup->srcu_atomic_gp_flag, 0);
+		return;
+	}
+
+	// OK, we really have to do it ourselves.  Start the grace period.
+	non_block_start();  // We must not voluntarily block!
+	smp_store_release(&sup->srcu_gp_seq_needed, srcu_state); // See srcu_funnel_gp_start().
+	ASSERT_EXCLUSIVE_WRITER(ssp->srcu_sup->srcu_gp_seq);
+	srcu_gp_start(ssp);
+	raw_spin_unlock_irq_rcu_node(sup);
+
+	// Wait for it to complete, helping it along.
+	while (!poll_state_synchronize_srcu(ssp, srcu_state)) {
+		cpu_relax();
+		srcu_advance_state(ssp, true);
 	}
+	ASSERT_EXCLUSIVE_WRITER(sup->srcu_atomic_gp_flag);
+	atomic_set_release(&sup->srcu_atomic_gp_flag, 0);
+	non_block_end();
 }
+EXPORT_SYMBOL_GPL(synchronize_srcu_atomic);
 
 /*
  * Invoke a limited number of SRCU callbacks that have passed through
@@ -2098,6 +2235,7 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 		}
 	} else if (!rcu_seq_state(ssp->srcu_sup->srcu_gp_seq)) {
 		/* Outstanding request and no GP.  Start one. */
+		WARN_ON_ONCE(ssp->srcu_reader_flavor & SRCU_READ_FLAVOR_ATOMIC);
 		srcu_gp_start(ssp);
 	}
 	raw_spin_unlock_irq_rcu_node(ssp->srcu_sup);
-- 
2.40.1

