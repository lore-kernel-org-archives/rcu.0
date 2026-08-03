Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DB24322FA;
	Mon,  3 Aug 2026 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765239; cv=none; b=ga3v3DdsdspZntPy9E4SUHB5JGfj/BHGGvfYrfkML1Yy8oMLjCdkcKzL9a/r2w6c3h2Kl0gtv79T1VDNHxRu3ZSvs86BYENwc+GQ7JVcml4fTarAItOPFfea/H9YpRi34lwmE0mx3eG6PglkMu8LHfCGz6+Y6HDWAxezoxjcjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765239; c=relaxed/simple;
	bh=fJkdKO3QR4xIxABIq31W7cUWz9W4+q87lI0ykMlCOfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czbtXGUqdwvbbRGKmP4n/J1QrGS/w0QMwWHFmJSWFE+VWEVUkjjiYubmm9erGTnflzLrHnt3qto0gNJsUMrVUwHWQleGjfs2JecxK58Od32TGHDwAgqTzHoOOU72fLx+uGRfCC6LWKQei6XRExXQa90e/YeU0sEbVknnEXd5m6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrOFvIGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrOFvIGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAE21F000E9;
	Mon,  3 Aug 2026 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785765237;
	bh=UW/yu4v8sY9etcTcyqgcC/GqOw7GQXjCCRdpg+TEMmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TrOFvIGrQOmvNXyJ8LzUwztA9t8h/TrkvfTxbqRDoWMau29NuEhngB4XMJU/jLv4K
	 WsNFGpMHw8zfpK2vxMfkWifkrh/zTx3EdBhA3Nvfe4xTItIQbZMh/rz1U/184jWVLJ
	 InPhRzZkA38B9DBsWNi56xeS75r8QU35AT1q2jgAbceYr4FNLLOzrSGt0LThki6Ryu
	 56ZhM2myQBjYZ1VMAsCuJoclvnfKdiXg+SJ0qu2v0PAP5UAVdR44rLYeLLjP2osOcT
	 MJWMqJ9Rd5AhJIZDlB8HRe3/B5d35P4IqmzReVIPq4E0wFFo28Mw3dc+0aSh9x1xvI
	 Z3JsOYNIsiAdg==
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
Subject: [PATCH v2 4/6] srcu: Make Tiny call_srcu() safe to call from any context
Date: Mon,  3 Aug 2026 06:53:27 -0700
Message-ID: <20260803135329.2327280-4-puranjay@kernel.org>
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

Give Tiny call_srcu() the same treatment as Tree SRCU.  When interrupts
are disabled and the scheduler is up, stage the callback on the
srcu_struct's lockless list for an irq_work to re-issue later.  Tiny SRCU
is uniprocessor, so there is no CPU-offline drain.  A draining flag drops
a deferring call_srcu() that re-enters mid-drain (unless from an NMI), as
in Tree SRCU.

srcu_barrier() (now out of line) and cleanup_srcu_struct() sync the
irq_work before checking for outstanding callbacks, so a deferred callback
is re-issued onto the callback list, where the leak checks can see it,
rather than stranded on a soon-to-be-freed srcu_struct.

Gated by CONFIG_RCU_DEFER, like Tree SRCU.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/srcutiny.h | 11 ++++---
 kernel/rcu/srcutiny.c    | 63 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index fbcf13bc12d15..47275d182966c 100644
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
+	struct irq_work defer_iw;		/* Registers defer_cbs later. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
@@ -33,6 +36,7 @@ struct srcu_struct {
 
 void srcu_drive_gp(struct work_struct *wp);
 void srcu_tiny_irq_work(struct irq_work *irq_work);
+void srcu_defer_drain(struct irq_work *irq_work);
 
 #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored, ____ignored)	\
 {									\
@@ -40,6 +44,8 @@ void srcu_tiny_irq_work(struct irq_work *irq_work);
 	.srcu_cb_tail = &name.srcu_cb_head,				\
 	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
 	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
+	.defer_cbs = LLIST_HEAD_INIT(name.defer_cbs),			\
+	.defer_iw = { .func = srcu_defer_drain },				\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
@@ -131,10 +137,7 @@ static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
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
index f9c498ae75df2..988819e6ddd4b 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -10,6 +10,7 @@
 
 #include <linux/export.h>
 #include <linux/irq_work.h>
+#include <linux/llist.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
@@ -43,6 +44,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
 	INIT_LIST_HEAD(&ssp->srcu_work.entry);
 	init_irq_work(&ssp->srcu_irq_work, srcu_tiny_irq_work);
+	init_llist_head(&ssp->defer_cbs);
+	init_irq_work(&ssp->defer_iw, srcu_defer_drain);
 	return 0;
 }
 
@@ -86,6 +89,9 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(srcu_readers_active(ssp));
+	/* Re-issue any deferred callbacks so ->srcu_cb_head sees them below. */
+	if (IS_ENABLED(CONFIG_RCU_DEFER))
+		irq_work_sync(&ssp->defer_iw);
 	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
@@ -215,11 +221,11 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 }
 
 /*
- * Enqueue an SRCU callback on the specified srcu_struct structure,
- * initiating grace-period processing if it is not already running.
+ * Enqueue @rhp on the callback list.  Also called by srcu_defer_drain() to
+ * re-issue a deferred callback, so it must not re-check the deferral condition.
  */
-void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
-	       rcu_callback_t func)
+static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
+			    rcu_callback_t func)
 {
 	unsigned long flags;
 
@@ -233,6 +239,46 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
 }
+
+/* Set while srcu_defer_drain() re-issues, to catch a re-entrant call_srcu(). */
+static bool srcu_defer_draining;
+
+void srcu_defer_drain(struct irq_work *iw)
+{
+	struct srcu_struct *ssp = container_of(iw, struct srcu_struct, defer_iw);
+	struct llist_node *node, *next;
+
+	/* Callbacks are unordered, so drain in llist order without reversing. */
+	srcu_defer_draining = true;
+	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
+		struct rcu_head *rhp = (struct rcu_head *)node;
+
+		srcu_do_enqueue(ssp, rhp, rhp->func);
+	}
+	srcu_defer_draining = false;
+}
+EXPORT_SYMBOL_GPL(srcu_defer_drain);
+
+void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
+	       rcu_callback_t func)
+{
+	if (should_rcu_defer()) {
+		/* A re-entrant call_srcu() during the drain would livelock it. */
+		if (srcu_defer_draining && !in_nmi()) {
+			WARN_ONCE(1, "call_srcu() re-entered during callback drain; leaking callback\n");
+			return;
+		}
+		rhp->func = func;
+		if (llist_add((struct llist_node *)rhp, &ssp->defer_cbs))
+			irq_work_queue(&ssp->defer_iw);
+		return;
+	}
+
+	/* An NMI reaching here entered with irqs enabled, so the enqueue can race. */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+
+	srcu_do_enqueue(ssp, rhp, func);
+}
 EXPORT_SYMBOL_GPL(call_srcu);
 
 /*
@@ -262,6 +308,15 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/* Register any deferred callbacks, then wait for all in-flight ones. */
+void srcu_barrier(struct srcu_struct *ssp)
+{
+	if (IS_ENABLED(CONFIG_RCU_DEFER))
+		irq_work_sync(&ssp->defer_iw);
+	synchronize_srcu(ssp);
+}
+EXPORT_SYMBOL_GPL(srcu_barrier);
+
 /*
  * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
  */
-- 
2.53.0-Meta

