Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724242AFB2;
	Fri,  9 Oct 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570685; cv=none; b=gWgEbaN9praa/ouY5WUS8Dc7E29Ce22WSoN01WpE+fUOvu08gPVWAVt209goytiQsOv9kiR3IYtm9ClIxIBPGaa3cpD7y5KQCl5v67bmnRVhWB4/mjTHyobVL6HUdTgRaxs8yjHMdBVswGS6sdD9TI/hLWtFlaUIHjWehZ6AUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570685; c=relaxed/simple;
	bh=UO0f+pVtDorvmvloyM7QOdxZ98wwW4wCvG3pRlPPI/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRNIbKjGQNFMxPu2t3CTZI1Xq1hwmUC7NSgquTocYRQPthlxxmOOE9cBsU8dD3YC+affn9U2cx2zEuoyDN4pimM3dU68k9YwVMI9EiLzyF0aoQTK4Gicdg7uTKnqHXMkd2OuiI7i1o5yhv0qZgPj4yncVGEE44YY7pNa51ve/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jyGPsB0i; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jyGPsB0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1791570109;
	bh=D6dAHv/ZRWwL8L15MiRyMUBmmHlyRLSXPowBr/wJwi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyGPsB0ia0biRknMUPC9tLuMc0hB9QXHTf3kpFEnHwim3DVqEVbPLhqIQ07fkw6fF
	 MGxN6+ns+QVyEvifNXUG2EyNss6SIWEG86iSKL6uhzL9AO39KHI9rNER3OsrRXaFoF
	 P/GK90H2ArYgDn4rAniRgKb9trNTWs8TaFTNJcM+AVGTBrUq9bjJDrcVfBlemp6YW0
	 O5RbOc17K1ZO+hijlBBd0LV97QIF3Ixtiscch28WPWqEZUSHsAEFOvy9Xgd9juL898
	 GGTZ/3EIxtklcJCTo7aFzrReQo2Z1ouPzk9bnfDql2M54F/faqHDSFZIlkYD8ZAXbY
	 i4t4oUJ2TyjxQ==
Received: from compudjdev.. (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4j1ZvK6bylzlxB;
	Fri, 09 Oct 2026 14:21:49 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gary Guo <gary@garyguo.net>,
	Boqun Feng <boqun@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH hazptr v2 4/4] hazptr: Introduce "try acquire" fast path, fallback to overflow list
Date: Fri,  9 Oct 2026 14:21:35 -0400
Message-ID: <20261009182142.6311-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
References: <20261009182142.6311-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a "try acquire" hazard pointer fast path, which performs an
early load of the address to store it into the hazard pointer slot, and
then re-loads that address after a barrier to check whether it has
changed meanwhile.

On comparison failure, rather than re-try, guarantee forward progress by
falling back to the __hazptr_acquire slow path on failure.

The acquire slow path attempts a try-acquire for any available per-CPU
slot. If that fails, it chains the backup slot into the overflow list,
therefore guaranteeing forward progress for both hazard pointer
read-side and synchronize:

- Readers set the wildcard, and then proceed to set the more
  specific address to replace the wildcard.

- One synchronize alternates between two overflow list periods,
  scanning each one while readers are added to the other period,
  thus preventing a steady flow of readers from preventing
  synchronize forward progress.

With this change, the scan on per-CPU slots don't need to expect a
wildcard anymore, because none can be produced by readers. Wildcards are
only expected within overflow lists.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/lkmm/DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net/
Reviewed-by: Gary Guo <gary@garyguo.net>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
Cc: Lian Wang <lianux.mm@gmail.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/hazptr.h |  48 +++++++++++--------
 kernel/hazptr.c        | 103 ++++++++++++++++++++---------------------
 2 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index d1670121947a..df2aca9aa26b 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -25,13 +25,11 @@
 #include <linux/types.h>
 #include <linux/cleanup.h>
 #include <linux/sched.h>
+#include <linux/ptreq.h>
 
 /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
 #define NR_HAZPTR_PERCPU_SLOTS	4
 
-/* The current hazard pointer wildcard. */
-extern void *hazptr_wildcard;
-
 /*
  * Hazard pointer slot.
  */
@@ -190,6 +188,31 @@ void hazptr_note_context_switch(void)
 	}
 }
 
+/* Try hazard pointer protection. */
+static inline
+void *__hazptr_try_acquire(struct hazptr_ctx *ctx, void * const *addr_p, struct hazptr_slot *slot)
+{
+	void *early_addr, *addr;
+
+	if (unlikely(slot->addr))
+		return NULL;
+	early_addr = READ_ONCE(*addr_p);	/* Early load. */
+	WRITE_ONCE(slot->addr, early_addr);	/* Store B */
+	/* Memory ordering: Store B before Load A. */
+	smp_mb();
+	addr = READ_ONCE(*addr_p);		/* Load A */
+	/*
+	 * Validate that address did not change between Early load and Load A.
+	 * Use ptr_eq() to make sure that result from Load A is returned to the
+	 * caller to preserve address dependency.
+	 */
+	if (unlikely(!ptr_eq(addr, early_addr))) {
+		WRITE_ONCE(slot->addr, NULL);
+		return NULL;
+	}
+	return addr;
+}
+
 /**
  * hazptr_acquire - Load pointer at address and protect with hazard pointer.
  *
@@ -245,24 +268,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	ctx->acquire_cpu = smp_processor_id();
 	ctx->acquire_caller = _THIS_IP_;
 #endif
-	if (unlikely(slot->addr))
+	addr = __hazptr_try_acquire(ctx, addr_p, slot);
+	if (unlikely(!addr))
 		return __hazptr_acquire(ctx, addr_p);
-	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
-
-	/* Memory ordering: Store B before Load A. */
-	smp_mb();
-
-	/*
-	 * Load @addr_p after storing wildcard to the hazard pointer slot.
-	 */
-	addr = READ_ONCE(*addr_p);	/* Load A */
-
-	/*
-	 * We don't care about ordering of Store C. It will simply
-	 * replace the wildcard by a more specific address. If addr is
-	 * NULL, we simply store NULL into the slot.
-	 */
-	WRITE_ONCE(slot->addr, addr);	/* Store C */
 	slot_item->ctx.ctx = ctx;
 	ctx->slot = slot;
 	return addr;
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 13faa5ba7677..3ca73b56a5c2 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -13,17 +13,9 @@
 #include <linux/list.h>
 #include <linux/export.h>
 
-static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the wildcard and list phase flip. */
+#define HAZPTR_WILDCARD	((void *) 1UL)
 
-/*
- * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
- * hazptr_synchronize forward progress even with a steady stream of readers.
- * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
- * This also affects the overflow list selection: the current list used by
- * readers is array[(unsigned long) hazptr_wildcard - 1].
- */
-void *hazptr_wildcard = (void *) 1UL;
-EXPORT_SYMBOL_GPL(hazptr_wildcard);
+static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the list phase flip. */
 
 /* The current overflow list phase. */
 static unsigned int hazptr_overflow_list_phase;
@@ -41,6 +33,10 @@ struct hazptr_overflow_list {
  * successively iterates on both lists. Therefore, only list removals
  * can cause the iteration to retry, and the number of removals is
  * limited to the number of list elements.
+ *
+ * Due to the overflow list raw spin lock, the hazard pointer readers are
+ * blocking, starvation-free with bounded waiting, assuming bounded critical
+ * sections and no NMI or virtualization-induced holder preemption.
  */
 struct hazptr_overflow_list_flip {
 	struct hazptr_overflow_list array[2];
@@ -51,26 +47,12 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
 DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
 EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
 
-static
-void *flip_wildcard(void *wildcard)
-{
-	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
-}
-
 static
 unsigned int flip_list_phase(unsigned int phase)
 {
 	return 1 - phase;
 }
 
-static
-bool is_wildcard(void *addr)
-{
-	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
-		return true;
-	return false;
-}
-
 static
 struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
 {
@@ -96,16 +78,36 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
  */
 void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 {
-	struct hazptr_slot *slot = hazptr_get_free_percpu_slot(ctx);
+	struct hazptr_slot *slot;
 	void *addr;
 
 	/*
-	 * If all the per-CPU slots are already in use, fallback
-	 * to the backup slot.
+	 * In case we are called due to nested use of hazard pointers,
+	 * try a slot protection with per-CPU slots.
 	 */
-	if (unlikely(!slot))
-		slot = hazptr_chain_backup_slot(ctx);
-	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
+	slot = hazptr_get_free_percpu_slot(ctx);
+	if (likely(slot)) {
+		addr = __hazptr_try_acquire(ctx, addr_p, slot);
+		if (addr) {
+			ctx->slot = slot;
+			return addr;
+		}
+	}
+
+	/*
+	 * The backup slot overflow list guarantees forward progress of both
+	 * hazard pointer readers and synchronize:
+	 *
+	 * - Readers set the wildcard, and then proceed to set the more
+	 *   specific address to replace the wildcard.
+	 *
+	 * - One synchronize alternates between two overflow list periods,
+	 *   scanning each one while readers are added to the other period,
+	 *   thus preventing a steady flow of readers from preventing
+	 *   synchronize forward progress.
+	 */
+	slot = hazptr_chain_backup_slot(ctx);
+	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
 
 	/* Memory ordering: Store B before Load A. */
 	smp_mb();
@@ -121,20 +123,21 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	 * NULL, we simply store NULL into the slot.
 	 */
 	WRITE_ONCE(slot->addr, addr);	/* Store C */
+
 	ctx->slot = slot;
-	if (!addr && hazptr_slot_is_backup(ctx, slot))
+	if (!addr)
 		hazptr_unchain_backup_slot(ctx);
 	return addr;
 }
 EXPORT_SYMBOL_GPL(__hazptr_acquire);
 
 /*
- * Perform piecewise iteration on overflow list waiting until "addr" is
- * not present. Raw spinlock is released and taken between each list
- * item and busy loop iteration. The overflow list generation is checked
- * each time the lock is taken to validate that the list has not changed
- * before resuming iteration or busy wait. If the generation has
- * changed, retry the entire list traversal.
+ * Perform piecewise iteration on overflow list waiting until "addr" and
+ * wildcard are not present. Raw spinlock is released and taken between each
+ * list item and busy loop iteration. The overflow list generation is checked
+ * each time the lock is taken to validate that the list has not changed before
+ * resuming iteration or busy wait. If the generation has changed, retry the
+ * entire list traversal.
  */
 static
 void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list, void *addr)
@@ -147,13 +150,11 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
 retry:
 	snapshot_gen = overflow_list->gen;
 	hlist_for_each_entry(backup_slot, &overflow_list->head, overflow_node) {
-		/* Busy-wait if node is found. */
+		/* Busy-wait if addr or wildcard are found. */
 		for (;;) {
 			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
 
-			/* We don't expect wildcards in overflow list. */
-			WARN_ON_ONCE(is_wildcard(load_addr));
-			if (load_addr != addr)
+			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
 				break;
 			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
 			cpu_relax();
@@ -174,7 +175,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
 }
 
 static
-void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
+void hazptr_synchronize_cpu_slots(int cpu, void *addr)
 {
 	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
 	unsigned int idx;
@@ -182,13 +183,13 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
 	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
 		struct hazptr_slot_item *item = &percpu_slots->items[idx];
 
-		/* Busy-wait if node is found. */
-		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
+		/* Busy-wait if addr is found. */
+		smp_cond_load_acquire(&item->slot.addr, VAL != addr); /* Load B */
 	}
 }
 
 static
-void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
+void hazptr_scan_cpu_slots(void *addr)
 {
 	int cpu;
 
@@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
 	for_each_possible_cpu(cpu) {
 		/*
 		 * Scan CPU slots.
-		 * Forward progress against recurring wildcards is guaranteed
-		 * by scanning for one wildcard while new elements use the
-		 * other wildcard value (1UL vs 2UL).
 		 * Forward progress against recurring single hazard pointer
 		 * values is guaranteed by the fact that a hazard pointer
 		 * is not reclaimed nor reused until the scan for that hazard
 		 * pointer completes, which prevents a steady flow of readers
 		 * to acquire that same hazard pointer value.
 		 */
-		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
+		hazptr_synchronize_cpu_slots(cpu, addr);
 	}
 }
 
@@ -237,7 +235,6 @@ void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
 void hazptr_synchronize(void *addr)
 {
 	unsigned int scan_list_phase;
-	void *scan_wildcard;
 
 	/*
 	 * Busy-wait should only be done from preemptible context.
@@ -251,16 +248,14 @@ void hazptr_synchronize(void *addr)
 	 */
 	if (!addr)
 		return;
+
 	/* Memory ordering: Store A before Load B. */
 	smp_mb();
 
 	guard(mutex)(&hazptr_phase_lock);
 
 	/* Scan per-CPU slots. */
-	scan_wildcard = flip_wildcard(hazptr_wildcard);
-	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
-	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
-	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
+	hazptr_scan_cpu_slots(addr);
 
 	/*
 	 * Scan overflow lists *after* scanning per-CPU slots. See
-- 
2.43.0

