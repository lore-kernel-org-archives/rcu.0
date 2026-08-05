Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7D46985D;
	Wed,  5 Aug 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932654; cv=none; b=sbZ6h1IqZxHXnXWVVxNJNNsDVO4rzBwLVYBAAVVeC70q8rmfhZdrSRIKu8OBipZ+qyrCRjRbmiA6xsSpMurUhwbyr+Pg0d1eIYozEIqzHtIZJO6KrluMr9Aa7/CWevXzHSH4cI0/OFae2HO7pUfGU3fAyPZeKnpm18/PcA/7fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932654; c=relaxed/simple;
	bh=2ekOa4qmCh1B2oLM5xZ5ukA5EFOV/uXlpohEZL9VNRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/jvla/7dfzgpDODpE3w2Ju/uOmZEsMvkizzW5fYS4QLswUWZ99/6nhrmu5bRg3AlA9I6jyc0Dolb8Ixrgt9kEANfk/qfDw4tub4ZDWr6xv3Gncgid45CS0VdZcNNQlUGx4b6T0NWKYwiJaBfTTFnTYtyAxw2IAxPPwiLLoC/Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0p3Rhpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0p3Rhpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CB81F000E9;
	Wed,  5 Aug 2026 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932652;
	bh=l+7jmh53O2Wea598EFhmmOEa2DQP55RrLDb9VbBnMb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0p3Rhpl/oq+N7qp8FOcnZJuZJ1aOc8kA/ThYLoDOMxRIyMuZGKN+pnJGfw2XpvWd
	 3Yj9ifB9oGW4L4MkhvKetzILcuCF95AoM5HGgGXWJ94GyM+CpgosfxSItUUzO4on/C
	 bVOYE9d26pm1cKo+hUVghEQFzbuAwg85P/I/6H+ntIh7fATG9kwT/dvLlO42oKOseO
	 BbWDlWX4LunBbcN9AqCI1TdXPeOMW+lqr7iBL8RMl7jJrkLtalbi4wPAUksD+tJ23y
	 vDfQ4MdDeuFMKmS46CxEEWTtOhInG2M2ZkpEENq+nvlNafShRuVZaRuSiSxht7Zmeg
	 K74xvo9Q9YokQ==
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
Subject: [PATCH v3 4/6] srcu: Make Tiny call_srcu() safe to call from any context
Date: Wed,  5 Aug 2026 05:23:41 -0700
Message-ID: <20260805122346.269445-5-puranjay@kernel.org>
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

Give Tiny call_srcu() the same treatment as Tree SRCU.  When interrupts
are disabled and the scheduler is up, stage the callback on the
srcu_struct's lockless list for an irq_work to re-issue later.  Tiny SRCU
is uniprocessor, so there is no CPU-offline drain.  A draining flag drops
a deferring call_srcu() that re-enters mid-drain (unless from an NMI), as
in Tree SRCU.

srcu_barrier() (now out of line) and cleanup_srcu_struct() drain the
deferred list first, so a deferred callback is re-issued onto the callback
list and invoked by the grace-period work that cleanup_srcu_struct()
flushes, rather than stranded on a soon-to-be-freed srcu_struct.  cleanup
also syncs ->defer_iw, since that irq_work is embedded in the srcu_struct
the caller is about to free.

Gated by CONFIG_RCU_DEFER, like Tree SRCU.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/srcutiny.h | 12 ++++--
 kernel/rcu/srcutiny.c    | 79 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index fbcf13bc12d15..a0e54d9182baa 100644
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
index f9c498ae75df2..ba36067909fd0 100644
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
 
+static void __srcu_defer_drain(struct srcu_struct *ssp, bool guard);
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
 
@@ -86,6 +91,11 @@ EXPORT_SYMBOL_GPL(init_srcu_struct_generic);
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(srcu_readers_active(ssp));
+	/* Re-issue any deferred callbacks, then wait out ->defer_iw before it is freed. */
+	if (IS_ENABLED(CONFIG_RCU_DEFER)) {
+		__srcu_defer_drain(ssp, false);
+		irq_work_sync(&ssp->defer_iw);
+	}
 	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
@@ -215,11 +225,11 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
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
 
@@ -233,6 +243,58 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
 }
+
+/* Set while srcu_defer_drain() re-issues, to catch a re-entrant call_srcu(). */
+static bool srcu_defer_draining;
+
+static void __srcu_defer_drain(struct srcu_struct *ssp, bool guard)
+{
+	struct llist_node *node, *next;
+	unsigned long flags;
+
+	/* Callbacks are unordered, so drain in llist order without reversing. */
+	local_irq_save(flags);
+	if (guard)
+		WRITE_ONCE(srcu_defer_draining, true);
+	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
+		struct rcu_head *rhp = (struct rcu_head *)node;
+
+		rhp->next = NULL;
+		srcu_do_enqueue(ssp, rhp, rhp->func);
+	}
+	if (guard)
+		WRITE_ONCE(srcu_defer_draining, false);
+	local_irq_restore(flags);
+}
+
+/* Only the irq_work drain can be re-fed by its own re-issue; see Tree SRCU. */
+void srcu_defer_drain(struct irq_work *iw)
+{
+	__srcu_defer_drain(container_of(iw, struct srcu_struct, defer_iw), true);
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
+	/* An NMI reaching here entered with irqs enabled, so the enqueue can race. */
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && in_nmi());
+
+	srcu_do_enqueue(ssp, rhp, func);
+}
 EXPORT_SYMBOL_GPL(call_srcu);
 
 /*
@@ -262,6 +324,15 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/* Register any deferred callbacks, then wait for all in-flight ones. */
+void srcu_barrier(struct srcu_struct *ssp)
+{
+	if (IS_ENABLED(CONFIG_RCU_DEFER))
+		__srcu_defer_drain(ssp, false);
+	synchronize_srcu(ssp);
+}
+EXPORT_SYMBOL_GPL(srcu_barrier);
+
 /*
  * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
  */
-- 
2.53.0-Meta

