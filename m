Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE7D3D566E;
	Mon, 10 Aug 2026 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364902; cv=none; b=MGv1fzODT+Sr9C6VnSYA84/Q3uZn42qKiRZn+9SBcTDfJ5RFwj9i1LUYgso1ttnG/gl4AnGQU9tS+iiDgeeZOM/nB7UZq0MeFMqWpFPPcxACHvdSlXizbfc9NfCiEiknf9c8fQLPrvkwhHb5xREmijIiQtK3funSiHf4FPkKuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364902; c=relaxed/simple;
	bh=IDZo4ZqB0SNp2RdCYkNGm42x/R3vAXot0IbrrluCG8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHXdqZlcaqc4OQbhEF/MKybUt7tTAQWMqg+sSHavkm9RjohKJfOxODnzfK7sbm+0qq+XI9AjoJ1vbBY+a3vfTbnUOn6Eo0poCiSKVrjzSesHkZH5xdC545UkyTjlluNJ+ApRwMUWBMrenDfRmAht747ygguUd0M+eO9HtVlG5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrUmJWHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrUmJWHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA7F1F000E9;
	Mon, 10 Aug 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786364900;
	bh=zRx2cUHJLwtDrbQpC2tDv9j1PG1ZjnTzGstPAq7DiUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RrUmJWHzkGPFPWSlQuZnSypETXpQF31sBXz9FzLi7H/Ij3DvAybwYeU3iNJg5RNUg
	 NGfQy4XoeF7TWps404hjbBx+bssP0DXnL2ySj4s+LRkvfH58AAhk0NO/gSEbSiBeAM
	 9pa6gTMtRN44XCJ0qHgICUBYCFk0B84MWZ2eIxZN9M9eKQr7kFBAOZ86DOV6mXz9yv
	 o/9OdWv4ji/gWtz3xHtvy/JxCzjkXdkIfJ7hEbFRInk7S6saPZz95aL823zvJ9ze65
	 NCd3HYSH0K6U5fo1I5zVbdKyemTKkLUIEuBmWUut3bwXa2zE522apjSmvScBBhTP4r
	 TymQp9K0XkB7g==
From: Puranjay Mohan <puranjay@kernel.org>
To: "Lai Jiangshan" <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Josh Triplett" <josh@joshtriplett.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	"Frederic Weisbecker" <frederic@kernel.org>,
	"Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
	"Joel Fernandes" <joelagnelf@nvidia.com>,
	"Boqun Feng" <boqun@kernel.org>,
	"Uladzislau Rezki" <urezki@gmail.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from any context
Date: Mon, 10 Aug 2026 05:27:51 -0700
Message-ID: <20260810122758.183765-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810122758.183765-1-puranjay@kernel.org>
References: <20260810122758.183765-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tiny.c | 127 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 104 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dccccd6be9411..656b6a682e31a 100644
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
2.53.0-Meta

