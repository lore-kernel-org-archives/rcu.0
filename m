Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90B430CD7;
	Mon,  3 Aug 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765230; cv=none; b=bIroINwwgL+NQldj9Y5J0F0eoty2+Ug/hSKxgi9oXCw4RMNwTJl6yEdWXUlqkfFuZtYkvSn+LzQATxl/jWAEzsBXXP4S/j7MEi636VwK1FuSTdk4hLDYF57jEHMDDfKQbT6OPUQcRFce8k7uWMCOYstO6mMieM1JyZH4+TO2k6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765230; c=relaxed/simple;
	bh=3JdWddTI48wnb/fe2oe4n46d/M3HF6MGQ3GXZ7fKgos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAb5q4HBKWsLh/Pc/ofpLZfWYwrk3bdLBnS8d/wrcYGJ9CYJU2e3S+tPWIPuspioMxlM0d55nIXk3lR15ldRbgCNNB3BokKL9izEdEYvXU9riw9AhjZ2ddgAMvc8f8ZvbUFg+V6P5Llyd8LPZoVOoUT11gT6BX272j+ePeHNxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqQOAh0s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqQOAh0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A1F1F000E9;
	Mon,  3 Aug 2026 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785765229;
	bh=sM/jD8c1DZVPZ/ENWd+7nK7/Ih+2gZL3XN/QDhd+77o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqQOAh0sbQkjiesz7kcnZrq7CVO5HLK/Z/KSMgCLh/+jIZ0nsiKKymUSMkM5VayT+
	 JvdRDd9VbVN/qWvggvOQG55zvrrQ6ZQdbaufH1vc8Zz+7BnoKOB7MoI5IXNWdLZUYw
	 JXyINrOf1dgIMglPhGhkdZrNgeYMGd8N9dcMRnBZSjTVx3TPtWR/mMqkKlt6MQUf4W
	 diBWRS60smfy24m2eYaXvUyedbYbLHEhHfxCidfnMa2EYkXYVN+6BwXsgzbhq9aGsa
	 rhDXBZsYhbAbpFMEhoNk1ZxMp7WZErgwj0YuI8mxORcxtd5Riz/TNUJNYCD4mzKtcb
	 D4RfieUGePksQ==
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
Subject: [PATCH v2 2/6] rcu: Make Tiny call_rcu() safe to call from any context
Date: Mon,  3 Aug 2026 06:53:25 -0700
Message-ID: <20260803135329.2327280-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803134839.2103051-1-puranjay@kernel.org>
References: <20260803134839.2103051-1-puranjay@kernel.org>
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
 kernel/rcu/tiny.c | 104 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dccccd6be9411..5736b964d8ee1 100644
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
@@ -42,8 +44,86 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
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
+static DEFINE_IRQ_WORK(rcu_defer_iw, rcu_defer_drain);
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
+static void rcu_defer_drain(struct irq_work *iw)
+{
+	struct llist_node *node, *next;
+
+	/* Callbacks are unordered, so drain in llist order without reversing. */
+	rcu_defer_draining = true;
+	llist_for_each_safe(node, next, llist_del_all(&rcu_defer_list)) {
+		struct rcu_head *head = (struct rcu_head *)node;
+
+		rcu_do_enqueue(head, head->func);
+	}
+	rcu_defer_draining = false;
+}
+
+static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
+{
+	/* A re-entrant call_rcu() during the drain would livelock it; drop it. */
+	if (rcu_defer_draining && !in_nmi()) {
+		WARN_ONCE(1, "call_rcu() re-entered during callback drain; leaking callback\n");
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
@@ -157,29 +237,15 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
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

