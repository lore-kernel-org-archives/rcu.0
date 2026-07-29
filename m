Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62548035C;
	Wed, 29 Jul 2026 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342184; cv=none; b=do3mMLqCFRCk9e8vNgm97sNzC41mUQY5kbC5VldPQM/mDWakJK+TGvAtHVm77RRl6MXEJfKFkmCPT/drCo9eoim4zSP++nR29wayYnTkOwknyGjPIp1DOW6WIL6rQM5EIEBQk24iC6BwJmfXQOkTH96WDWpoiCfCGKHAGh8b7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342184; c=relaxed/simple;
	bh=NM20lGHadHSn6VMe6w4FA0M08cTzh4u0xz16qzUTfRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGoaRtvFow501CDkxHLy4UvBeU8peMV2vQZmFAI35tqZCDuaCFiyA3lRUrO4PhEok8VJkfLugFXk7nbED0/Lzp+vIZuLKKmYmcr6xNIwlDPyxkz3aSf5VjkJii8GZg13hiXEIc/M7/7sDkwC5D9jOw/itSYjE4B6t32W1sGpetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMzatcf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMzatcf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D0B1F000E9;
	Wed, 29 Jul 2026 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342182;
	bh=Omh6hJitRM4yP0f4x9s7hhDvDCVb3NchUBaIxLXUGkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BMzatcf3GGO2FLRWx+un4FtC9470r/dollqI5nx8AmO/ol3nJ972v7yj8WcG+6ste
	 CueT30BY+R928uAkjFZ6RVe69YdBSZOs8mxyc7R28lrXlSygmCnY1oHfQwxuQg7dah
	 250RDmINglgVjkWmYDXSZCsYQRYaIzrhJDfY2DQyPPPH+L69yg/cw43lUCToSG87Xz
	 oj/s1fEEUS/oZ3m0oc+RlYevzyjqudZviAk4Q9s8oohr/jB32cDrbPBpcXx2S+lNU0
	 F828DJwPMBcumM17uPofjq3AiRlILktFBdbd/E6YKA/F5z0t8URSzt4e95oxp/NRwZ
	 TOg6RwnPCtzAw==
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
Subject: [PATCH 4/6] srcu: Make Tiny call_srcu() safe to call from any context
Date: Wed, 29 Jul 2026 09:22:03 -0700
Message-ID: <20260729162207.1567770-5-puranjay@kernel.org>
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

Make Tiny call_srcu() safe to call from unknown context: when interrupts
are disabled and the scheduler is up, stage the callback on the
srcu_struct's lockless list that an irq_work re-issues later.  Tiny SRCU
is uniprocessor, so there is no CPU-offline drain.  Gated by
CONFIG_RCU_DEFER, like Tree SRCU.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/srcutiny.h | 11 ++++++---
 kernel/rcu/srcutiny.c    | 53 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 8 deletions(-)

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
index f9c498ae75df2..b454d3e828edc 100644
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
 
@@ -215,11 +218,11 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
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
 
@@ -233,6 +236,39 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	srcu_gp_start_if_needed(ssp);
 	preempt_enable();
 }
+
+void srcu_defer_drain(struct irq_work *iw)
+{
+	struct srcu_struct *ssp = container_of(iw, struct srcu_struct, defer_iw);
+	struct llist_node *node, *next;
+
+	/*
+	 * Callbacks have no mutual ordering guarantee and srcu_barrier() has
+	 * already flushed us, so drain in llist order without reversing.
+	 */
+	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
+		struct rcu_head *rhp = (struct rcu_head *)node;
+
+		srcu_do_enqueue(ssp, rhp, rhp->func);
+	}
+}
+EXPORT_SYMBOL_GPL(srcu_defer_drain);
+
+void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
+	       rcu_callback_t func)
+{
+	if (should_rcu_defer()) {
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
@@ -262,6 +298,15 @@ void synchronize_srcu(struct srcu_struct *ssp)
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

