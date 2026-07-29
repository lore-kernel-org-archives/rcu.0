Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DD45516D;
	Wed, 29 Jul 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342177; cv=none; b=jL4Or2FP+s085YycvhKRgqN7jrlkMta0MInmgkCxrdgbBnyUJMjneCNk3TFdhOBA6yDt/iutDDyv2JJuZjlGGxStgbP/OlxpDHR0NbBL9nhlP9qhxAvq1mIOUIVPEXwz4W8wQSP7BWXJ0wkAPflmickkBroSZ1b/zPxflzrYbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342177; c=relaxed/simple;
	bh=KG1RsZFWqF2cCnRiz6nGsFv5BB8M/bjg78YAzzYegRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlNwutEChHoGB1tl63zWw0n1EeNq4/VVHa4tq4GZNfW8E01FxZ9xuFqCseMQOTpjuG3PVUvC7bwIeywL76X69BbhubH9a3XxEZ0kam0pY7lbnjVcjIZLbwnQFGwlm9Ks254hSY6DEXufzKA+yaT2c2qlQUywOHzcnlCPcNiJwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxwKIf5N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxwKIf5N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA3F1F000E9;
	Wed, 29 Jul 2026 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342175;
	bh=SZQWidrnH4LJju4p8LdAF7YWrwiU86beA+eqZzfSKsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JxwKIf5NJZ8val46Hl4ai940EmvN7XB9pAySgl1JknAfGdYrHcEvA/Eg1T3oAligO
	 XnI5M3vX5Ya6CewQMC4Iy04dTEu447dPurm/C7+Mw6BNjRKXZbAK+04GH5J+Mqxue2
	 hcMZpZ0TK41BUIwAikfwqOj94aWmNgb69kDrYcHwgSBrsFuPwsRDGn5p3kfeKNRddF
	 bTaEj6NfrllzplF18YCfPWNJFbQ7jhjmDoSy9dRXOudfu25L3KlNK4bPHhNPJPOCdE
	 LDgBzijmRS7o/rBn30zB9tnRyVWwhTzoRljF2htDRaXMgkDT7zmWVEpSKF4y4dsxg4
	 ywfbgLKz6LYMQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
Subject: [PATCH 2/6] rcu: Make Tiny call_rcu() safe to call from any context
Date: Wed, 29 Jul 2026 09:22:01 -0700
Message-ID: <20260729162207.1567770-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729162207.1567770-1-puranjay@kernel.org>
References: <20260729162207.1567770-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make Tiny call_rcu() safe to call from unknown context: when interrupts
are disabled and the scheduler is up, stage the callback on a lockless
list that an irq_work re-issues later.  One global list and irq_work are
enough since Tiny RCU is uniprocessor, and there is no CPU-offline
drain.  Gated by CONFIG_RCU_DEFER, like Tree RCU.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/tiny.c | 101 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dccccd6be9411..71249eac61021 100644
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
@@ -42,8 +44,83 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
 	.gp_seq		= 0 - 300UL,
 };
 
+/*
+ * The callback list is only ever accessed with interrupts disabled (this
+ * enqueue, callback invocation, grace-period work), so enqueuing while a list
+ * operation is in flight would corrupt it.  Defer whenever interrupts are
+ * disabled: the callback goes on a lockless list that an irq_work re-issues
+ * later.  One global list and irq_work suffice, as Tiny RCU is uniprocessor.
+ * Only kernels where that can happen (CONFIG_RCU_DEFER) need this.
+ */
+static void rcu_defer_drain(struct irq_work *iw);
+static LLIST_HEAD(rcu_defer_list);
+static DEFINE_IRQ_WORK(rcu_defer_iw, rcu_defer_drain);
+
+/*
+ * Enqueue @head on the callback list.  Also called by rcu_defer_drain() to
+ * re-issue a deferred callback, so it must not re-check the deferral condition.
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
+
+	if (unlikely(is_idle_task(current))) {
+		/* force scheduling for rcu_qs() */
+		resched_cpu(0);
+	}
+}
+
+static void rcu_defer_drain(struct irq_work *iw)
+{
+	struct llist_node *node, *next;
+
+	/*
+	 * Callbacks have no mutual ordering guarantee and rcu_barrier() has
+	 * already flushed us, so drain in llist order without reversing.
+	 */
+	llist_for_each_safe(node, next, llist_del_all(&rcu_defer_list)) {
+		struct rcu_head *head = (struct rcu_head *)node;
+
+		rcu_do_enqueue(head, head->func);
+	}
+}
+
+static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
+{
+	head->func = func;
+	if (llist_add((struct llist_node *)head, &rcu_defer_list))
+		irq_work_queue(&rcu_defer_iw);
+}
+
+/* Register any deferred callbacks so a following rcu_barrier() waits for them. */
+static void rcu_defer_flush(void)
+{
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+	irq_work_sync(&rcu_defer_iw);
+}
+
 void rcu_barrier(void)
 {
+	/* Register any deferred callbacks first. */
+	rcu_defer_flush();
 	wait_rcu_gp(call_rcu_hurry);
 }
 EXPORT_SYMBOL(rcu_barrier);
@@ -157,29 +234,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
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
-
-	local_irq_save(flags);
-	*rcu_ctrlblk.curtail = head;
-	rcu_ctrlblk.curtail = &head->next;
-	local_irq_restore(flags);
+	/* An NMI reaching here entered with irqs enabled, so the enqueue can race. */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
 
-	if (unlikely(is_idle_task(current))) {
-		/* force scheduling for rcu_qs() */
-		resched_cpu(0);
-	}
+	rcu_do_enqueue(head, func);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.53.0-Meta

