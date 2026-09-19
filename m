Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE830F7FB;
	Sat, 19 Sep 2026 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777983; cv=none; b=NJbGtvIb0KdkwodafIFT2Ukq6F6sisKQTuJivce+e+LRR3rARH5IOUlN0UoPII8ZnXoirw3+3/ExZtSRl2fSXbMYefvc8Ym3mZHJxz6QqBPzTK469TZnNJ173qn43Pk0xKh2zdcvD7CuFM9r9rfTF/TOto4keRAIJxN1lEitVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777983; c=relaxed/simple;
	bh=bWQMjqP+nsqMQnX9kr3nf6L6PxMdijiuwoNeU0e1hNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oR3xvccZyLcH6a4dyCeMfw0GRJyRCqhmhDCwNrAj3jbfITxkvjp2Cic9lhzh6yT2MvxApyCYj7bB46CEYvaTin8L3LEec79CDliYodW29+YkRMgdxMsjOgKlLhzX7NOkwQ2Q691QsRGgmVRxBAYLSY5fgT2pRpZ0Cr5cwd3gEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEXjp8Me; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEXjp8Me"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA3A1F00898;
	Sat, 19 Sep 2026 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777979;
	bh=7fC/rvpTz6KY8HQNuutCBSh5FydVFzj8Ras4JUDvRqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEXjp8MeL2BF2f4loi7gp4PiLPfZ+1xVLzULW9hGXxvtcxW2WpjqgBdJI7FlxnWkr
	 xDQk0Yvbn7+wXMKTuuqHYn4IuRjSeYhiu//Cdt/xyF5iXWkOIVW0jUJX9id4+zeAht
	 v5v5d1YtSWihjhAnCHQjOVvKmwLZH3XXBWEd0Bpb/csiyBa9FEnva6SP4DXG7wXrls
	 mqtVCf4Tr1zcw991WcKoDzjYgJ4LRFzqfuTu5BvnekY9W47mdNbzvrRh8WFiNAyQYx
	 xqhG3wegRF3iL1yRFtcRhlnH1yGyj7Au40I67LZxdheUgKQXUHNQDFDuVcE+Y1rEs/
	 dG54UaAQmITTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94732CE178A; Fri, 18 Sep 2026 17:32:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/7] rcu: Make Tiny call_rcu() safe to call from any context
Date: Fri, 18 Sep 2026 17:32:53 -0700
Message-Id: <20260919003258.3134343-2-paulmck@kernel.org>
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

Give Tiny call_rcu() the same treatment as Tree RCU.  When interrupts are
disabled and the scheduler is up, stage the callback on a lockless list
that an irq_work re-issues later.  One global list and irq_work suffice
since Tiny RCU is uniprocessor, and there is no CPU-offline drain.

The re-issue runs with interrupts disabled and can be re-entered by
instrumentation, so a draining flag drops a deferring call_rcu() seen
mid-drain (unless from an NMI), as in Tree RCU.  Gated by CONFIG_RCU_DEFER,
though the deferral state is unconditional.

Interrupts stay off for the whole batch, but the re-issue is a tail append
with no locks.  TINY_RCU implies !SMP, where arch_irq_work_has_interrupt()
is false, so the drain always waits for the tick and a batch is whatever
one tick's worth of interrupts-disabled call_rcu()s staged.  As in Tree
RCU the drain clears ->next before re-issuing, which bounds a node
self-linked by a double call_rcu(): rcu_do_enqueue()'s duplicate path
returns without clearing it.  A longer cycle is not bounded; a double
call_rcu() stays undefined.

The idle-task reschedule moves out of the enqueue helper so that a drain
does it once for the batch rather than once per callback, which would
otherwise take the runqueue lock N times with interrupts disabled.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tiny.c | 127 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dccccd6be941..656b6a682e31 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -11,6 +11,8 @@
  */
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/irq_work.h>
+#include <linux/llist.h>
 #include <linux/notifier.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/kernel.h>
@@ -42,8 +44,100 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
 	.gp_seq		= 0 - 300UL,
 };
 
+/*
+ * The callback list is only accessed with interrupts disabled, so a call_rcu()
+ * that arrives with interrupts off stages the callback on a lockless list that
+ * an irq_work re-issues later.  One global list and irq_work suffice, as Tiny
+ * RCU is uniprocessor.
+ */
+static void rcu_defer_drain(struct irq_work *iw);
+static LLIST_HEAD(rcu_defer_list);
+static struct irq_work rcu_defer_iw = IRQ_WORK_INIT_HARD(rcu_defer_drain);
+static bool rcu_defer_draining;
+
+/*
+ * Also called by __rcu_defer_drain() to re-issue a deferred callback, so it
+ * must not re-check the deferral condition.
+ */
+static void rcu_do_enqueue(struct rcu_head *head, rcu_callback_t func)
+{
+	static atomic_t doublefrees;
+	unsigned long flags;
+
+	if (debug_rcu_head_queue(head)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
+		return;
+	}
+
+	head->func = func;
+	head->next = NULL;
+
+	local_irq_save(flags);
+	*rcu_ctrlblk.curtail = head;
+	rcu_ctrlblk.curtail = &head->next;
+	local_irq_restore(flags);
+}
+
+/* Force scheduling for rcu_qs() when enqueuing from the idle task. */
+static void rcu_resched_if_idle(void)
+{
+	if (unlikely(is_idle_task(current)))
+		resched_cpu(0);
+}
+
+static void __rcu_defer_drain(void)
+{
+	struct llist_node *node, *next;
+	bool drained = false;
+	unsigned long flags;
+
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+
+	/* Re-issued newest-first; nothing depends on call_rcu() ordering. */
+	local_irq_save(flags);
+	llist_for_each_safe(node, next, llist_del_all(&rcu_defer_list)) {
+		struct rcu_head *head = (struct rcu_head *)node;
+
+		/* Bounds a node self-linked by a double call_rcu(). */
+		head->next = NULL;
+		rcu_do_enqueue(head, head->func);
+		drained = true;
+	}
+	local_irq_restore(flags);
+
+	if (drained)
+		rcu_resched_if_idle();
+}
+
+/* Only the irq_work drain can be re-fed by its own re-issue; see Tree RCU. */
+static void rcu_defer_drain(struct irq_work *iw)
+{
+	WRITE_ONCE(rcu_defer_draining, true);
+	__rcu_defer_drain();
+	WRITE_ONCE(rcu_defer_draining, false);
+}
+
+static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
+{
+	/* A re-entrant call_rcu() during the drain would livelock it; drop it. */
+	if (READ_ONCE(rcu_defer_draining) && !in_nmi()) {
+		WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
+			  "call_rcu() re-entered during callback drain; leaking callback\n");
+		return;
+	}
+	head->func = func;
+	if (llist_add((struct llist_node *)head, &rcu_defer_list))
+		irq_work_queue(&rcu_defer_iw);
+}
+
 void rcu_barrier(void)
 {
+	/* Register any deferred callbacks so the wait below covers them. */
+	__rcu_defer_drain();
 	wait_rcu_gp(call_rcu_hurry);
 }
 EXPORT_SYMBOL(rcu_barrier);
@@ -157,29 +251,19 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	static atomic_t doublefrees;
-	unsigned long flags;
-
-	if (debug_rcu_head_queue(head)) {
-		if (atomic_inc_return(&doublefrees) < 4) {
-			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
-			mem_dump_obj(head);
-		}
+	if (should_rcu_defer()) {
+		call_rcu_defer(head, func);
 		return;
 	}
 
-	head->func = func;
-	head->next = NULL;
+	/*
+	 * Only reachable from an NMI when deferral is off: before the scheduler
+	 * is up, or with CONFIG_RCU_DEFER=n.  The enqueue can then race.
+	 */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 
-	local_irq_save(flags);
-	*rcu_ctrlblk.curtail = head;
-	rcu_ctrlblk.curtail = &head->next;
-	local_irq_restore(flags);
-
-	if (unlikely(is_idle_task(current))) {
-		/* force scheduling for rcu_qs() */
-		resched_cpu(0);
-	}
+	rcu_do_enqueue(head, func);
+	rcu_resched_if_idle();
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -211,10 +295,7 @@ unsigned long start_poll_synchronize_rcu(void)
 {
 	unsigned long gp_seq = get_state_synchronize_rcu();
 
-	if (unlikely(is_idle_task(current))) {
-		/* force scheduling for rcu_qs() */
-		resched_cpu(0);
-	}
+	rcu_resched_if_idle();
 	return gp_seq;
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
-- 
2.40.1

