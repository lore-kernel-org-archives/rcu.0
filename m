Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1337FF68;
	Sat, 19 Sep 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776067; cv=none; b=qqTGe4wVi99/lTzPptziUnjlWBOSgpsjo+LgYEONOKU79wt/4QhMzlnbFxyOAZVWR0yzIXXu4BvcNbyBR/qgVk6KEFMyBiYRiEWgzoLNG31De6q4X4Qp6EvIs8nkFbRenXwG1jjpVYREuZU7k1KsUkunI/kZINxUUS/7nkcagSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776067; c=relaxed/simple;
	bh=lwondw38ogS+1AV3SY5lcYT1UqOiG9QeKShDEhnIyBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNvHZHfd0pbgV29hgFhR991YAJznruDj1qLOqySsbrOpasZc3OZy6bmqDAx/agP91ykdL6KBM97YITgAx5xB0HU0hIUO9wBIpaG6Lo0oQPK/UTFWT4T1mzmeOQ+Hyjyn1HjaQEznHnx+VEVvOu7GK9OJjy8sYtEeiXCHslDcu08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kuwhx4CI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kuwhx4CI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713461F0092C;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=R1ZVlb625x5mbrhMzY0lEcj1zeKw64iHEEKwMEb2/oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kuwhx4CIEuD9m3drvwutVNLTxflB5aeDan5zeS63wzDUHwN2Sv2AcikzcPImRaZwI
	 3Ohw27sdWH+DqPS3vi1OB/ZE5Ni5VrOWC9K8rr1APxRAeJoWH24gI2Xw5RPXhQdQSf
	 ikQwtaCvzV6TtYfZvlKK+t/1Yfe/vC7WvLvUfk81TUS2nunxWHfCzmkwbUGtYIW5Xo
	 OLZC4Re9ppbCsGSI3FTZkmakDDRlcUA4S/+wTFYTqeGXiQG0xyc0AbfCNe/TnS0FJR
	 6U/tUsIysMLCojFtFfwXn5sjimYqLzBRyJlgDNAFWf0b/M7XXNj+fb+ikDJiNa843t
	 ZWmP3j8JKoXPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9534ACE09DD; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH 26/28] hazptr: Implement two-phase wildcard scan
Date: Fri, 18 Sep 2026 17:00:54 -0700
Message-Id: <20260919000056.3132131-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Implement a two-phase wildcard scan to guarantee forward progress of
synchronize_hazptr() even if there is a steady stream of ill-timed
readers which populate wildcards into per-CPU slots.

This is performed by flipping between two wildcard values (1UL and 2UL),
and alternatively scanning for the opposite wildcard while newcoming
readers use the other one.

There is no possibility to miss a reader because all slots for all
wildcards are accounted for during a synchronize.

As a simplification, use this period flip to drive the hazptr overflow
list selection as well, since there is really no point is making the
overflow list flip use a different state.

Protect the wildcard flip with a mutex.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Reviewed-by: Bradley Morgan <include@grrlz.net>
---
 include/linux/hazptr.h |  6 ++-
 kernel/hazptr.c        | 98 ++++++++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 30 deletions(-)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index 43998bf43de4..43122c5673bd 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -28,7 +28,9 @@
 
 /* 4 slots (each sizeof(hazptr_slot_item)) fit in a single 64-byte cache line. */
 #define NR_HAZPTR_PERCPU_SLOTS	4
-#define HAZPTR_WILDCARD		((void *) 0x1UL)
+
+/* The current hazard pointer wildcard. */
+extern void *hazptr_wildcard;
 
 /*
  * Hazard pointer slot.
@@ -243,7 +245,7 @@ void *hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 #endif
 	if (unlikely(slot->addr))
 		return __hazptr_acquire(ctx, addr_p);
-	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
+	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
 
 	/* Memory ordering: Store B before Load A. */
 	smp_mb();
diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index a9d3d68a1525..d3d1050d92cf 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -13,6 +13,17 @@
 #include <linux/list.h>
 #include <linux/export.h>
 
+/*
+ * The current hazard pointer wildcard. Flips between 1UL and 2UL to guarantee
+ * hazptr_synchronize forward progress even with a steady stream of readers.
+ * This wildcard value is used by acquire to temporarily tag the per-CPU slots.
+ * This also affects the overflow list selection: the current list used by
+ * readers is array[(unsigned long) hazptr_wildcard - 1].
+ */
+static DEFINE_MUTEX(hazptr_wildcard_lock);	/* Protect the wildcard flip. */
+void *hazptr_wildcard = (void *) 1UL;
+EXPORT_SYMBOL_GPL(hazptr_wildcard);
+
 struct hazptr_overflow_list {
 	raw_spinlock_t lock;		/* Lock protecting overflow list and list generation. */
 	struct hlist_head head;		/* Overflow list head. */
@@ -28,8 +39,6 @@ struct hazptr_overflow_list {
  * limited to the number of list elements.
  */
 struct hazptr_overflow_list_flip {
-	struct mutex lock;		/* Mutex protecting add_idx from concurrent updates. */
-	unsigned int add_idx;		/* Index of current flip-list to add to. */
 	struct hazptr_overflow_list array[2];
 };
 
@@ -38,6 +47,20 @@ static DEFINE_PER_CPU(struct hazptr_overflow_list_flip, percpu_overflow_list_fli
 DEFINE_PER_CPU(struct hazptr_percpu_slots, hazptr_percpu_slots);
 EXPORT_PER_CPU_SYMBOL_GPL(hazptr_percpu_slots);
 
+static
+void *flip_wildcard(void *wildcard)
+{
+	return ((unsigned long) wildcard == 1UL) ? (void *) 2UL : (void *) 1UL;
+}
+
+static
+bool is_wildcard(void *addr)
+{
+	if ((unsigned long) addr == 1UL || (unsigned long) addr == 2UL)
+		return true;
+	return false;
+}
+
 static
 struct hazptr_slot *hazptr_get_free_percpu_slot(struct hazptr_ctx *ctx)
 {
@@ -72,7 +95,7 @@ void *__hazptr_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
 	 */
 	if (unlikely(!slot))
 		slot = hazptr_chain_backup_slot(ctx);
-	WRITE_ONCE(slot->addr, HAZPTR_WILDCARD);	/* Store B */
+	WRITE_ONCE(slot->addr, READ_ONCE(hazptr_wildcard));	/* Store B */
 
 	/* Memory ordering: Store B before Load A. */
 	smp_mb();
@@ -118,7 +141,9 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
 		for (;;) {
 			void *load_addr = smp_load_acquire(&backup_slot->slot.addr);	/* Load B */
 
-			if (load_addr != addr && load_addr != HAZPTR_WILDCARD)
+			/* We don't expect wildcards in overflow list. */
+			WARN_ON_ONCE(is_wildcard(load_addr));
+			if (load_addr != addr)
 				break;
 			raw_spin_unlock_irqrestore(&overflow_list->lock, flags);
 			cpu_relax();
@@ -139,7 +164,7 @@ void hazptr_synchronize_overflow_list(struct hazptr_overflow_list *overflow_list
 }
 
 static
-void hazptr_synchronize_cpu_slots(int cpu, void *addr)
+void hazptr_synchronize_cpu_slots(int cpu, void *addr, void *scan_wildcard)
 {
 	struct hazptr_percpu_slots *percpu_slots = per_cpu_ptr(&hazptr_percpu_slots, cpu);
 	unsigned int idx;
@@ -148,7 +173,39 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
 		struct hazptr_slot_item *item = &percpu_slots->items[idx];
 
 		/* Busy-wait if node is found. */
-		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != HAZPTR_WILDCARD); /* Load B */
+		smp_cond_load_acquire(&item->slot.addr, VAL != addr && VAL != scan_wildcard); /* Load B */
+	}
+}
+
+static
+void hazptr_scan_period(void *addr, void *scan_wildcard)
+{
+	unsigned int scan_idx = (unsigned long) scan_wildcard - 1;
+	int cpu;
+
+	/* Scan all CPUs slots. */
+	for_each_possible_cpu(cpu) {
+		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
+
+		/*
+		 * Scan CPU slots.
+		 * Forward progress against recurring wildcards is guaranteed
+		 * by scanning for one wildcard while new elements use the
+		 * other wildcard value (1UL vs 2UL).
+		 * Forward progress against recurring single hazard pointer
+		 * values is guaranteed by the fact that a hazard pointer
+		 * is not reclaimed nor reused until the scan for that hazard
+		 * pointer completes, which prevents a steady flow of readers
+		 * to acquire that same hazard pointer value.
+		 */
+		hazptr_synchronize_cpu_slots(cpu, addr, scan_wildcard);
+
+		/*
+		 * Scan backup slots in percpu overflow lists.
+		 * Forward progress is guaranteed by scanning one list
+		 * while new elements are added into the other list.
+		 */
+		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
 	}
 }
 
@@ -161,7 +218,7 @@ void hazptr_synchronize_cpu_slots(int cpu, void *addr)
  */
 void hazptr_synchronize(void *addr)
 {
-	int cpu;
+	void *scan_wildcard;
 
 	/*
 	 * Busy-wait should only be done from preemptible context.
@@ -177,33 +234,19 @@ void hazptr_synchronize(void *addr)
 		return;
 	/* Memory ordering: Store A before Load B. */
 	smp_mb();
-	/* Scan all CPUs slots. */
-	for_each_possible_cpu(cpu) {
-		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
-		unsigned int scan_idx;
-
-		/* Scan CPU slots. */
-		hazptr_synchronize_cpu_slots(cpu, addr);
 
-		/*
-		 * Scan backup slots in percpu overflow lists.
-		 * Forward progress is guaranteed by scanning one list
-		 * while new elements are added into the other list.
-		 */
-		guard(mutex)(&overflow_list_flip->lock);
-		scan_idx = overflow_list_flip->add_idx ^ 1;
-		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx], addr);
-		/* Flip current list. */
-		WRITE_ONCE(overflow_list_flip->add_idx, scan_idx);
-		hazptr_synchronize_overflow_list(&overflow_list_flip->array[scan_idx ^ 1], addr);
-	}
+	guard(mutex)(&hazptr_wildcard_lock);
+	scan_wildcard = flip_wildcard(hazptr_wildcard);
+	hazptr_scan_period(addr, scan_wildcard);
+	WRITE_ONCE(hazptr_wildcard, scan_wildcard);	/* Flip the current wildcard. */
+	hazptr_scan_period(addr, flip_wildcard(scan_wildcard));
 }
 EXPORT_SYMBOL_GPL(hazptr_synchronize);
 
 struct hazptr_slot *hazptr_chain_backup_slot(struct hazptr_ctx *ctx)
 {
 	struct hazptr_overflow_list_flip *overflow_list_flip = this_cpu_ptr(&percpu_overflow_list_flip);
-	unsigned int list_idx = READ_ONCE(overflow_list_flip->add_idx);
+	unsigned int list_idx = (unsigned long) READ_ONCE(hazptr_wildcard) - 1;
 	struct hazptr_overflow_list *overflow_list = &overflow_list_flip->array[list_idx];
 	struct hazptr_slot *slot = &ctx->backup_slot.slot;
 
@@ -233,7 +276,6 @@ void __init hazptr_init(void)
 	for_each_possible_cpu(cpu) {
 		struct hazptr_overflow_list_flip *overflow_list_flip = per_cpu_ptr(&percpu_overflow_list_flip, cpu);
 
-		mutex_init(&overflow_list_flip->lock);
 		for (int i = 0; i < 2; i++) {
 			raw_spin_lock_init(&overflow_list_flip->array[i].lock);
 			INIT_HLIST_HEAD(&overflow_list_flip->array[i].head);
-- 
2.40.1

