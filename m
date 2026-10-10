Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142D4BAA11;
	Sat, 10 Oct 2026 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661201; cv=none; b=rwwT5UuNAUN7chIl2GQPJbIvOjlSIWCjQnThBPomSSyKIHNdXPGJhyTcrfG3wHLKKfeoYYi443n8DblixeyOTcnC6ONujqzgI5pGiRe4ZejzWfsGknCsn+7MSvaGZYPekprCoIb/gsNb+iU84h15azIsoI/j6j/2+g9LZBomkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661201; c=relaxed/simple;
	bh=sYjvaxqxkFNdi4sUEvE6rYYUDtXPCWd+eilqePvbEh0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Wz5NKypLJHiTVna5IOawJ0UJ3QM1I0PpS5uZd0qo2yahLDCvgnmptY2NVIUQBXFrQyRCRfkC+X/8sVEKolCofW7Nf+U2pkUlYfQcNpx6sqoWJHJ+GJQCd9gKRjSiLMeamFzeCs1mRB79BA6EwROzYMSiZDp5juxE7JM1HELs2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=JNxlG5q+; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KvMnCAF4; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="JNxlG5q+";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KvMnCAF4"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791661165; bh=glVgjssUp8RzJlcBNAvMfzu
	EupdUbllE30zizV0Qv2s=; b=JNxlG5q+Vb6Bf+aBowkruFikC/EozsMfnxiZcsXKnXVin3PheO
	CIvIRriOvgYlpa+L9hSY5cDp1GcN+kTQIy0WXII47A6ptO5byxncBBWGBZUVTcD6PfYQs5CeHvd
	XLlggHbK1tJYBTnFCswT/HRSs8fmoDfDnosqYoS9FawUdi32xhIEicisMVnEF+5yRsdwVpkVuN7
	CsJuPB0wDOpJuJOtTs6Rm4ibT3pKYM/cHGpkYSip4Y0/TQuSMj35YSOhkwnRslgVtt4XpYBEzYR
	G8ui78uNI0Zz3zpxw3NvRSIMaYaR15a+/djww229gf+rnOQ457i39nDo2D7uL54om+A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791661165; bh=glVgjssUp8RzJlcBNAvMfzu
	EupdUbllE30zizV0Qv2s=; b=KvMnCAF4pu3RpwOl8QFr/Re/5oEHGo3s/6Ay8nRYCS5bHMs/tZ
	ZnaKAA6iDX5LQJF9+q2dSky46iFp+7s2CSBg==;
Date: Sat, 10 Oct 2026 20:39:26 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_hazptr_v2_4/4=5D_hazptr=3A_Introduce_=22tr?=
 =?US-ASCII?Q?y_acquire=22_fast_path=2C_fallback_to_overflow_list?=
In-Reply-To: <20261009182142.6311-5-mathieu.desnoyers@efficios.com>
References: <20261009182142.6311-1-mathieu.desnoyers@efficios.com> <20261009182142.6311-5-mathieu.desnoyers@efficios.com>
Message-ID: <C53DEBF5-555F-44A8-A11C-A15C83AAD341@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 9 October 2026 19:21:35 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>Introduce a "try acquire" hazard pointer fast path, which performs an
>early load of the address to store it into the hazard pointer slot, and
>then re-loads that address after a barrier to check whether it has
>changed meanwhile.
>
>On comparison failure, rather than re-try, guarantee forward progress by
>falling back to the __hazptr_acquire slow path on failure.
>
>The acquire slow path attempts a try-acquire for any available per-CPU
>slot. If that fails, it chains the backup slot into the overflow list,
>therefore guaranteeing forward progress for both hazard pointer
>read-side and synchronize:
>
>- Readers set the wildcard, and then proceed to set the more
>  specific address to replace the wildcard.
>
>- One synchronize alternates between two overflow list periods,
>  scanning each one while readers are added to the other period,
>  thus preventing a steady flow of readers from preventing
>  synchronize forward progress.
>
>With this change, the scan on per-CPU slots don't need to expect a
>wildcard anymore, because none can be produced by readers. Wildcards are
>only expected within overflow lists.
>
>Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>Suggested-by: Gary Guo <gary@garyguo.net>
>Link: https://lore.kernel.org/lkmm/DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net/
>Reviewed-by: Gary Guo <gary@garyguo.net>

Hey, looks fine to me! 

Reviewed-by: Bradley Morgan <brads@mainlining.org>

(Well needed in my opinion)

>Cc: Paul E. McKenney <paulmck@kernel.org>
>Cc: Boqun Feng <boqun@kernel.org>
>Cc: Bradley Morgan <brads@mainlining.org>
>Cc: Gary Guo <gary@garyguo.net>
>Cc: <rcu@vger.kernel.org>
>Cc: <lkmm@lists.linux.dev>
>Cc: Lian Wang <lianux.mm@gmail.com>
>Cc: Kunwu Chan <kunwu.chan@gmail.com>
>---
> include/linux/hazptr.h |  48 +++++++++++--------
> kernel/hazptr.c        | 103 ++++++++++++++++++++---------------------
> 2 files changed, 77 insertions(+), 74 deletions(-)
>
>diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>index d1670121947a..df2aca9aa26b 100644
>--- a/include/linux/hazptr.h
>+++ b/include/linux/hazptr.h
>@@ -25,13 +25,11 @@
> #include <linux/types.h>
> #include <linux/cleanup.h>
> #include <linux/sched.h>
>+#include <linux/ptreq.h>
> 
> /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache
> line. */
> #define NR_HAZPTR_PERCPU_SLOTS	4
> 
>-/* The current hazard pointer wildcard. */
>-extern void *hazptr_wildcard;
>-
> /*
>  * Hazard pointer slot.
>  */
>@@ -190,6 +188,31 @@ void hazptr_note_context_switch(void)
> 	}
> }
> 
>+/* Try hazard pointer protection. */
>+static inline
>+void *__hazptr_try_acquire(struct hazptr_ctx *ctx, void * const *addr_p, struct hazptr_slot *slot)
>+{
>+	void *early_addr, *addr;
>+
>+	if (unlikely(slot->addr))
>+		return NULL;
>+	early_addr = READ_ONCE(*addr_p);	/* Early load. */
>+	WRITE_ONCE(slot->addr, early_addr);	/* Store B */
>+	/* Memory ordering: Store B before Load A. */
>+	smp_mb();
>+	addr = READ_ONCE(*addr_p);		/* Load A */
>+	/*
>+	 * Validate that address did not change between Early load and Load A.
>+	 * Use ptr_eq() to make sure that result from Load A is returned to the
>+	 * caller to preserve address dependency.
>+	 */
>+	if (unlikely(!ptr_eq(addr, early_addr))) {
>+		WRITE_ONCE(slot->addr, NULL);
>+		return NULL;
>+	}
>+	return addr;
>+}
>+
> /**
>  * hazptr_acquire - Load pointer at address and protect with hazard pointer.
>  *
>@@ -245,24 +268,9 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> 	ctx->acquire_cpu = smp_processor_id();
> 	ctx->acquire_caller = _THIS_IP_;
> #endif
>-	if (unlikely(slot->addr))
>+	addr = __hazptr_try_acquire(ctx, addr_p, slot);
>+	if (unlikely(!addr))
> 		return __hazptr_acquire(ctx, addr_p);
>-	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>-
>-	/* Memory ordering: Store B before Load A. */
>-	smp_mb();
>-
>-	/*
>-	 * Load @addr_p after storing wildcard to the hazard pointer slot.
>-	 */
>-	addr = READ_ONCE(*addr_p);	/* Load A */
>-
>-	/*
>-	 * We don't care about ordering of Store C. It will simply
>-	 * replace the wildcard by a more specific address. If addr is
>-	 * NULL, we simply store NULL into the slot.
>-	 */
>-	WRITE_ONCE(slot->addr, addr);	/* Store C */
> 	slot_item->ctx.ctx = ctx;
> 	ctx->slot = slot;
> 	return addr;
>diff --git a/kernel/hazptr.c b/kernel/hazptr.c
>index 13faa5ba7677..3ca73b56a5c2 100644
>--- a/kernel/hazptr.c
>+++ b/kernel/hazptr.c
>@@ -13,17 +13,9 @@
> #include <linux/list.h>
> #include <linux/export.h>
> 
>-static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the wildcard and list phase flip. */
>+#define HAZPTR_WILDCARD	((void *) 1UL)
> 
>-/*
>- * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
>- * hazptr_synchronize forward progress even with a steady stream of readers.
>- * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
>- * This also affects the overflow list selection: the current list used by
>- * readers is array[(unsigned long) hazptr_wildcard - 1].
>- */
>-void *hazptr_wildcard = (void *) 1UL;
>-EXPORT_SYMBOL_GPL(hazptr_wildcard);
>+static DEFINE_MUTEX(hazptr_phase_lock);	/* Protect the list phase flip. */
> 
> /* The current overflow list phase. */
> static unsigned int hazptr_overflow_list_phase;
>@@ -41,6 +33,10 @@ struct hazptr_overflow_list {
>  * successively iterates on both lists. Therefore, only list removals
>  * can cause the iteration to retry, and the number of removals is
>  * limited to the number of list elements.
>+ *
>+ * Due to the overflow list raw spin lock, the hazard pointer readers are
>+ * blocking, starvation-free with bounded waiting, assuming bounded critical
>+ * sections and no NMI or virtualization-induced holder preemption.
>  */
> struct hazptr_overflow_list_flip {
> 	struct hazptr_overflow_list array[2];
>@@ -51,26 +47,12 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
> DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
> EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
> 
>-static
>-void *flip_wildcard(void *wildcard)
>-{
>-	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
>-}
>-
> static
> unsigned int flip_list_phase(unsigned int phase)
> {
> 	return 1 - phase;
> }
> 
>-static
>-bool is_wildcard(void *addr)
>-{
>-	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
>-		return true;
>-	return false;
>-}
>-
> static
> struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
> {
>@@ -96,16 +78,36 @@ struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
>  */
> void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> {
>-	struct hazptr_slot *slot = hazptr_get_free_percpu_slot(ctx);
>+	struct hazptr_slot *slot;
> 	void *addr;
> 
> 	/*
>-	 * If all the per-CPU slots are already in use, fallback
>-	 * to the backup slot.
>+	 * In case we are called due to nested use of hazard pointers,
>+	 * try a slot protection with per-CPU slots.
> 	 */
>-	if (unlikely(!slot))
>-		slot = hazptr_chain_backup_slot(ctx);
>-	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
>+	slot = hazptr_get_free_percpu_slot(ctx);
>+	if (likely(slot)) {
>+		addr = __hazptr_try_acquire(ctx, addr_p, slot);
>+		if (addr) {
>+			ctx->slot = slot;
>+			return addr;
>+		}
>+	}
>+
>+	/*
>+	 * The backup slot overflow list guarantees forward progress of both
>+	 * hazard pointer readers and synchronize:
>+	 *
>+	 * - Readers set the wildcard, and then proceed to set the more
>+	 *   specific address to replace the wildcard.
>+	 *
>+	 * - One synchronize alternates between two overflow list periods,
>+	 *   scanning each one while readers are added to the other period,
>+	 *   thus preventing a steady flow of readers from preventing
>+	 *   synchronize forward progress.
>+	 */
>+	slot = hazptr_chain_backup_slot(ctx);
>+	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
> 
> 	/* Memory ordering: Store B before Load A. */
> 	smp_mb();
>@@ -121,20 +123,21 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
> 	 * NULL, we simply store NULL into the slot.
> 	 */
> 	WRITE_ONCE(slot->addr, addr);	/* Store C */
>+
> 	ctx->slot = slot;
>-	if (!addr && hazptr_slot_is_backup(ctx, slot))
>+	if (!addr)
> 		hazptr_unchain_backup_slot(ctx);
> 	return addr;
> }
> EXPORT_SYMBOL_GPL(__hazptr_acquire);
> 
> /*
>- * Perform piecewise iteration on overflow list waiting until "addr" is
>- * not present. Raw spinlock is released and taken between each list
>- * item and busy loop iteration. The overflow list generation is checked
>- * each time the lock is taken to validate that the list has not changed
>- * before resuming iteration or busy wait. If the generation has
>- * changed, retry the entire list traversal.
>+ * Perform piecewise iteration on overflow list waiting until "addr" and
>+ * wildcard are not present. Raw spinlock is released and taken between each
>+ * list item and busy loop iteration. The overflow list generation is checked
>+ * each time the lock is taken to validate that the list has not changed before
>+ * resuming iteration or busy wait. If the generation has changed, retry the
>+ * entire list traversal.
>  */
> static
> void hazptr_synchronize_overflow_list(struct hazptr_overflow_list
> *overflow_list, void *addr)
>@@ -147,13 +150,11 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
> retry:
> 	snapshot_gen = overflow_list->gen;
> 	hlist_for_each_entry(backup_slot, &overflow_list->head, overflow_node) {
>-		/* Busy-wait if node is found. */
>+		/* Busy-wait if addr or wildcard are found. */
> 		for (;;) {
> 			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
> 
>-			/* We don't expect wildcards in overflow list. */
>-			WARN_ON_ONCE(is_wildcard(load_addr));
>-			if (load_addr != addr)
>+			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
> 				break;
> 			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
> 			cpu_relax();
>@@ -174,7 +175,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
> }
> 
> static
>-void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
>+void hazptr_synchronize_cpu_slots(int cpu, void *addr)
> {
> 	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
> 	unsigned int idx;
>@@ -182,13 +183,13 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
> 	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> 		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> 
>-		/* Busy-wait if node is found. */
>-		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
>+		/* Busy-wait if addr is found. */
>+		smp_cond_load_acquire(&item->slot.addr, VAL != addr); /* Load B */
> 	}
> }
> 
> static
>-void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
>+void hazptr_scan_cpu_slots(void *addr)
> {
> 	int cpu;
> 
>@@ -196,16 +197,13 @@ void hazptr_scan_cpu_slots_period(void *addr, void *scan_wildcard)
> 	for_each_possible_cpu(cpu) {
> 		/*
> 		 * Scan CPU slots.
>-		 * Forward progress against recurring wildcards is guaranteed
>-		 * by scanning for one wildcard while new elements use the
>-		 * other wildcard value (1UL vs 2UL).
> 		 * Forward progress against recurring single hazard pointer
> 		 * values is guaranteed by the fact that a hazard pointer
> 		 * is not reclaimed nor reused until the scan for that hazard
> 		 * pointer completes, which prevents a steady flow of readers
> 		 * to acquire that same hazard pointer value.
> 		 */
>-		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
>+		hazptr_synchronize_cpu_slots(cpu, addr);
> 	}
> }
> 
>@@ -237,7 +235,6 @@ void hazptr_scan_overflow_list_period(void *addr, unsigned int scan_idx)
> void hazptr_synchronize(void *addr)
> {
> 	unsigned int scan_list_phase;
>-	void *scan_wildcard;
> 
> 	/*
> 	 * Busy-wait should only be done from preemptible context.
>@@ -251,16 +248,14 @@ void hazptr_synchronize(void *addr)
> 	 */
> 	if (!addr)
> 		return;
>+
> 	/* Memory ordering: Store A before Load B. */
> 	smp_mb();
> 
> 	guard(mutex)(&hazptr_phase_lock);
> 
> 	/* Scan per-CPU slots. */
>-	scan_wildcard = flip_wildcard(hazptr_wildcard);
>-	hazptr_scan_cpu_slots_period(addr, scan_wildcard);
>-	WRITE_ONCE(hazptr_wildcard, scan_wildcard);			/* Flip the current wildcard. */
>-	hazptr_scan_cpu_slots_period(addr, flip_wildcard(scan_wildcard));
>+	hazptr_scan_cpu_slots(addr);
> 
> 	/*
> 	 * Scan overflow lists *after* scanning per-CPU slots. See
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
