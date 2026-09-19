Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2B3101C2;
	Sat, 19 Sep 2026 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777982; cv=none; b=b7gZCNfMpQsoHfkJcmpDVvEpCSSYXIcMS+E0R6ZzHr+jHw0mdUMdea01/yAYxSNv21qcI3s+zeRxK1W4yhDHwqNRMJrQI/XHGNxoABR4j5YtLVbosLG/Z90Q6vDcHwoggodWCpvlWasC0CdrHzVazj67s/AqdwnCjg0mmLrT1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777982; c=relaxed/simple;
	bh=OBvp96sBSRDfAeIbSe5VuDOjFCMG/dDULzEQgWMyoR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3dCNhLheMXJ48oczZbJhlnc6IdzYVTH1Q2K6pC7g8mtDcwoiCS5jc9hEJILvbCiYnOU36/tc7exchPizRrmzK+Ikqhk2MxXOxrsZuaeLN9oIxyZaeMoaQXch6sIFXPcCY9BNXfdcM4D7n2IiZHRTGPlQSCMkrQ5rtGQC4tXrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm1ukGmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm1ukGmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD061F0089C;
	Sat, 19 Sep 2026 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777979;
	bh=t70kGK99ykB6bO1w0CUCROUVyI2I9irgr3P1DYysOqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lm1ukGmXeJUTT+Fg2vxD8aDgrvVnukPwa0KlEQ6gmqN82Ea+P5+exM+j6uPnnBOQU
	 hiutKV0uS75UhxYaWsN/MkGQoTnzxljZzocpiEW8nKY5Eejd/kzqAGA6v9Af4nQFqR
	 eHVHuXx96U6tkOkZ+gyMaCU7+9RO85yOpt78IeDlfKQzl4tuH9cXogtl/U5pNT9EuV
	 UPedA7qmQEk2Ot1uhTyZKnVYSX9jF0bv8P2EwR1FNeTHitsFfMw6+i1hPnXpPEj7OU
	 V4rGt6ttY0SEnZJ5u2WdPSjA1D6yZ2jeA+S6HKdi6KUt1unG/8WrNHUTCkak89h0Ec
	 GQAAhBZWi6fMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9A162CE17C1; Fri, 18 Sep 2026 17:32:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/7] srcu: Make Tiny call_srcu() safe to call from any context
Date: Fri, 18 Sep 2026 17:32:55 -0700
Message-Id: <20260919003258.3134343-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
References: <2a742578-120a-421d-9305-5de0b22bda33@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

Give Tiny call_srcu() the same treatment as Tree SRCU.  When interrupts
are disabled and the scheduler is up, stage the callback on the
srcu_struct's lockless list for an irq_work to re-issue later.  Tiny SRCU
is uniprocessor, so there is no CPU-offline drain.  A draining flag drops
a deferring call_srcu() that re-enters mid-drain (unless from an NMI), as
in Tree SRCU; such a drop can strand state the caller tied to the callback,
not just the callback itself.

Interrupts stay off for the whole batch.  TINY_SRCU implies !SMP, where
arch_irq_work_has_interrupt() is false, so the drain always waits for the
tick and a batch is whatever one tick's worth of interrupts-disabled
call_srcu()s staged.  Unlike the other three flavors srcu_do_enqueue() here
has no debug_rcu_head_queue(), so nothing reports a double call_srcu();
termination of the drain rests on srcu_do_enqueue() clearing ->next, and
the callback list self-links at the tail exactly as a double call_srcu()
made it before.

srcu_barrier() (now out of line) and cleanup_srcu_struct() drain the
deferred list first, so a deferred callback is re-issued onto the callback
list and invoked by the grace-period work that cleanup_srcu_struct()
flushes, rather than stranded on a soon-to-be-freed srcu_struct.
cleanup_srcu_struct() also syncs ->defer_iw, since that irq_work is
embedded in the srcu_struct the caller is about to free.

The draining flag is global rather than per-srcu_struct: a re-entrant
call_srcu(B) inside a drain of A raises B's own ->defer_iw, whose drain can
stage back onto A, so a per-srcu_struct flag would not break the chain.
The cost is that a drain of A also drops a non-NMI call_srcu() to any
other srcu_struct for its duration.

Gated by CONFIG_RCU_DEFER like Tree SRCU, though the srcu_struct members
are unconditional.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h | 12 ++++--
 kernel/rcu/srcutiny.c    | 93 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index fbcf13bc12d1..85b5de438450 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -12,6 +12,7 @@
 #define _LINUX_SRCU_TINY_H
 
 #include <linux/irq_work_types.h>
+#include <linux/llist.h>
 #include <linux/swait.h>
 
 struct srcu_struct {
@@ -26,6 +27,8 @@ struct srcu_struct {
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
 	struct irq_work srcu_irq_work;	/* Defer schedule_work() to irq work. */
+	struct llist_head defer_cbs;	/* Callbacks deferred on re-entry. */
+	struct irq_work defer_iw;	/* Re-issues defer_cbs later. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
@@ -33,6 +36,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 void srcu_tiny_irq_work(struct irq_work *irq_work);
+void srcu_defer_drain(struct irq_work *irq_work);
 
 #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
 {									\
@@ -40,6 +44,9 @@ void srcu_tiny_irq_work(struct irq_work *irq_work);
 	.srcu_cb_tail = &name.srcu_cb_head,				\
 	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
 	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
+	.defer_cbs = LLIST_HEAD_INIT(name.defer_cbs),			\
+	.defer_iw = { .node = { .u_flags = IRQ_WORK_HARD_IRQ },		\
+		      .func = srcu_defer_drain },			\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
@@ -131,10 +138,7 @@ static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 	synchronize_srcu(ssp);
 }
 
-static inline void srcu_barrier(struct srcu_struct *ssp)
-{
-	synchronize_srcu(ssp);
-}
+void srcu_barrier(struct srcu_struct *ssp);
 
 static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
 #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 558ba8d316db..5de9a6905838 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -10,6 +10,7 @@
 
 #include <linux/export.h>
 #include <linux/irq_work.h>
+#include <linux/llist.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
@@ -29,6 +30,8 @@ extern int rcu_scheduler_active;
 static LIST_HEAD(srcu_boot_list);
 static bool srcu_init_done;
 
+static void __srcu_defer_drain(struct srcu_struct *ssp);
+
 static int init_srcu_struct_fields(struct srcu_struct *ssp)
 {
 	ssp->srcu_lock_nesting[0] = 0;
@@ -43,6 +46,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
 	INIT_LIST_HEAD(&ssp->srcu_work.entry);
 	init_irq_work(&ssp->srcu_irq_work, srcu_tiny_irq_work);
+	init_llist_head(&ssp->defer_cbs);
+	ssp->defer_iw = IRQ_WORK_INIT_HARD(srcu_defer_drain);
 	return 0;
 }
 
@@ -86,6 +91,16 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(srcu_readers_active(ssp));
+	/*
+	 * Re-issue any deferred callbacks, then wait out ->defer_iw before it is
+	 * freed.  Skipped entirely with CONFIG_RCU_DEFER=n: irq_work_sync() ends
+	 * in an unconditional synchronize_rcu() wherever
+	 * arch_irq_work_has_interrupt() is false, which is every !SMP target.
+	 */
+	if (IS_ENABLED(CONFIG_RCU_DEFER)) {
+		__srcu_defer_drain(ssp);
+		irq_work_sync(&ssp->defer_iw);
+	}
 	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
@@ -213,11 +228,11 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 }
 
 /*
- * Enqueue an SRCU callback on the specified srcu_struct structure,
- * initiating grace-period processing if it is not already running.
+ * Also called by __srcu_defer_drain() to re-issue a deferred callback, so it
+ * must not re-check the deferral condition.
  */
-void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
-	       rcu_callback_t func)
+static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
+			    rcu_callback_t func)
 {
 	unsigned long flags;
 
@@ -231,6 +246,68 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
 }
+
+/*
+ * Set only by the irq_work drain, the one drain its own re-issue can re-feed;
+ * a callback staged during a direct drain is taken by ->defer_iw afterwards.
+ * Global rather than per-srcu_struct: a re-entrant call_srcu(B) inside a drain
+ * of A raises B's own ->defer_iw, whose drain can stage back onto A.
+ */
+static bool srcu_defer_draining;
+
+static void __srcu_defer_drain(struct srcu_struct *ssp)
+{
+	struct llist_node *node, *next;
+	unsigned long flags;
+
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	/* Re-issued newest-first; nothing depends on call_srcu() ordering. */
+	local_irq_save(flags);
+	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
+		struct rcu_head *rhp = (struct rcu_head *)node;
+
+		srcu_do_enqueue(ssp, rhp, rhp->func);
+	}
+	local_irq_restore(flags);
+}
+
+/* Only the irq_work drain can be re-fed by its own re-issue; see Tree SRCU. */
+void srcu_defer_drain(struct irq_work *iw)
+{
+	struct srcu_struct *ssp = container_of(iw, struct srcu_struct, defer_iw);
+
+	WRITE_ONCE(srcu_defer_draining, true);
+	__srcu_defer_drain(ssp);
+	WRITE_ONCE(srcu_defer_draining, false);
+}
+EXPORT_SYMBOL_GPL(srcu_defer_drain);
+
+void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
+	       rcu_callback_t func)
+{
+	if (should_rcu_defer()) {
+		/* A re-entrant call_srcu() during the drain would livelock it. */
+		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
+			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
+				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			return;
+		}
+		rhp->func = func;
+		if (llist_add((struct llist_node *)rhp, &ssp->defer_cbs))
+			irq_work_queue(&ssp->defer_iw);
+		return;
+	}
+
+	/*
+	 * Only reachable from an NMI when deferral is off: before the scheduler
+	 * is up, or with CONFIG_RCU_DEFER=n.  The enqueue can then race.
+	 */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+
+	srcu_do_enqueue(ssp, rhp, func);
+}
 EXPORT_SYMBOL_GPL(call_srcu);
 
 /*
@@ -260,6 +337,14 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/* Register any deferred callbacks, then wait for all in-flight ones. */
+void srcu_barrier(struct srcu_struct *ssp)
+{
+	__srcu_defer_drain(ssp);
+	synchronize_srcu(ssp);
+}
+EXPORT_SYMBOL_GPL(srcu_barrier);
+
 /*
  * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
  */
-- 
2.40.1

