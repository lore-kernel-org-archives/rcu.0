Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983145D5E4;
	Wed,  5 Aug 2026 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932646; cv=none; b=Nv6DbFOCZKXfsk9s19RmC+ysCLXUiJ0HbLSGe3z57MT6CC4FXB7m5VBWpyo9h/O01WNJ7MZtuvkjksA6Xj02VtpDNyZg8eKCF3kL1E2YqxuN2kCBY0s3QJHiXLVuutCTmKwyfLGEXFu0oKcpAy2bZvbV83mV+gLa8X46Ep4/PV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932646; c=relaxed/simple;
	bh=KfqAmejNRotNqn4BSRDfTw6HG1fKLGZx2qlRvQWCHbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSsAKFvvhsaEqV6q/Me6Shpc2E/5+mWW7Lqc49LF9Hc7Y1IIDvLMOPFuuMnARTTRsV5Pzf5ew6amrYsli+FCYGzlOqmD+O53M6GH9B/i3u2Kn/I/kj2Jvg9H+AuJ5bmDZaPjxeQemsiYzdA9Rd+zx1kt8TBJljLBr9vAedEC5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9Rle6RE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9Rle6RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE641F00A3A;
	Wed,  5 Aug 2026 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932644;
	bh=F4fKMwHkoXgcYwZ+GDVXYH9cJRDr3Ob52RPoP9ggB8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9Rle6RERUaulViFjb6THs/Hdl2wKywsQYxNtbSFUewhkIHqZCo+GoeF7/cIPLVnR
	 kAJaqNKa+9m5DRG1oPbPkmaqUOS3EhAwf+FMhNfqAKkTI+8OH7vMi4L0MtgaxQluNK
	 5By1QBBtMP7J0ev7y2K1Q23JvXLe7CJ8ZLXiBf72Yu9PqAa8z2hT1uIMYGO7eoYnwp
	 LfMx5Ovf0beY5vjNxqJa992hJGLobfm3Be7VBnPv7HtxPiCUiuKRsqLfHbbjEipIhV
	 b7ZqtjCtWzRMlKjDX1cgTlGQyed6/OBr20E3FNoNaWWEJ+U4LCQhNycpKbRtetsHg8
	 ZEJF+CJqMIUwQ==
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
Subject: [PATCH v3 2/6] rcu: Make Tiny call_rcu() safe to call from any context
Date: Wed,  5 Aug 2026 05:23:39 -0700
Message-ID: <20260805122346.269445-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805122346.269445-1-puranjay@kernel.org>
References: <20260805122346.269445-1-puranjay@kernel.org>
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
mid-drain (unless from an NMI), as in Tree RCU.  Gated by CONFIG_RCU_DEFER.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/tiny.c | 117 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dccccd6be9411..baffe660043f5 100644
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
@@ -42,8 +44,99 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
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
+static void __rcu_defer_drain(bool guard)
+{
+	struct llist_node *node, *next;
+	unsigned long flags;
+
+	/* Callbacks are unordered, so drain in llist order without reversing. */
+	local_irq_save(flags);
+	if (guard)
+		WRITE_ONCE(rcu_defer_draining, true);
+	llist_for_each_safe(node, next, llist_del_all(&rcu_defer_list)) {
+		struct rcu_head *head = (struct rcu_head *)node;
+
+		head->next = NULL;
+		rcu_do_enqueue(head, head->func);
+	}
+	if (guard)
+		WRITE_ONCE(rcu_defer_draining, false);
+	local_irq_restore(flags);
+}
+
+/* Only the irq_work drain can be re-fed by its own re-issue; see Tree RCU. */
+static void rcu_defer_drain(struct irq_work *iw)
+{
+	__rcu_defer_drain(true);
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
+/* Register any deferred callbacks so a following rcu_barrier() waits for them. */
+static void rcu_defer_flush(void)
+{
+	if (!IS_ENABLED(CONFIG_RCU_DEFER))
+		return;
+	__rcu_defer_drain(false);
+}
+
 void rcu_barrier(void)
 {
+	/* Register any deferred callbacks first. */
+	rcu_defer_flush();
 	wait_rcu_gp(call_rcu_hurry);
 }
 EXPORT_SYMBOL(rcu_barrier);
@@ -157,29 +250,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
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

