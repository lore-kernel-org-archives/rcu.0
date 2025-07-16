Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C112EE986;
	Wed, 16 Jul 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706464; cv=none; b=lYhXpwuxwp2xbGBad7EYsWmPhpENEAAeEn7HmL82Nu8EXGmhpGwYcFwmgnFHP+3HLTAJ37WA9YGhfQkrP0Pl/2R65KNb0fcFnViCX6IIUbK3EBms8ynNMPqcMNsJ48hTpjPUv7r38bxtIrJcr4Sz7dKQD2OOoe2WqHUjeZBYA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706464; c=relaxed/simple;
	bh=FbBP55FTK8DQnBhDqHCSOIfSX2F13FKjrs23EPgtrSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hg0QQfP/qTJJI1zgDCA29OmJ94Rq0pm6/p3u14j6AwMohAx3/F9JXV9394i2Pf+V2pY2otPbpOVCFFBaSk+o9bvRW9Cqzemo/14+HLfGA7hrnoqAQd6D/Dc71vJJCrQcF29CAzT6sIjV0nAUt+ygQGkgv6laG9RuYqip+Il5Dv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhsTAWIT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhsTAWIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3DAC4CEF5;
	Wed, 16 Jul 2025 22:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706463;
	bh=FbBP55FTK8DQnBhDqHCSOIfSX2F13FKjrs23EPgtrSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhsTAWITAi6dj78+khUbUtx14UR2kgZPp1n5B7tJWWBdojYi+yxphpfvH5gQoNo5V
	 yPhtXkn9MzgmxfUya1ecZHYafnIPW8p+ftRi/TcZCSMOD64MI6d0d6oiBOSleSCs6U
	 /HOJ+WFqCDkxpPQ4dWznCT66jS2auHf1BRCJ91nOOWzjgw8w2SeIjYaQlkby/cW9ib
	 FhiWQfBApvO8UhgAKmlqvYK8dSk80y7qe+TDPz04eJjF0JtF4eVhmImerVRAcf+/Ww
	 XI/DzlOj5VdTvN+/NJLTSSUvHi9jqjorb4lH1Z2lpmXB6YC7P+6EEUrzygw1JjhuC3
	 zh4a3IuHJ1wqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80271CE0C4A; Wed, 16 Jul 2025 15:54:23 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RFC 4/4] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
Date: Wed, 16 Jul 2025 15:54:18 -0700
Message-Id: <20250716225418.3014815-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
References: <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
to protect invocation of __DO_TRACE_CALL() means that BPF programs
attached to tracepoints are non-preemptible.  This is unhelpful in
real-time systems, whose users apparently wish to use BPF while also
achieving low latencies.  (Who knew?)

One option would be to use preemptible RCU, but this introduces
many opportunities for infinite recursion, which many consider to
be counterproductive, especially given the relatively small stacks
provided by the Linux kernel.  These opportunities could be shut down
by sufficiently energetic duplication of code, but this sort of thing
is considered impolite in some circles.

Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
readers than those of preemptible RCU, at least on my laptop, where
task_struct access is more expensive than access to per-CPU variables.
And SRCU fast provides way faster readers than does SRCU, courtesy of
being able to avoid the read-side use of smp_mb().  Also, it is quite
straightforward to create srcu_read_{,un}lock_fast_notrace() functions.

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/tracepoint.h |  6 +++--
 kernel/tracepoint.c        | 54 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f85..a22c1ab88560b 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -33,6 +33,8 @@ struct trace_eval_map {
 
 #define TRACEPOINT_DEFAULT_PRIO	10
 
+extern struct srcu_struct tracepoint_srcu;
+
 extern int
 tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
 extern int
@@ -115,7 +117,7 @@ void for_each_tracepoint_in_module(struct module *mod,
 static inline void tracepoint_synchronize_unregister(void)
 {
 	synchronize_rcu_tasks_trace();
-	synchronize_rcu();
+	synchronize_srcu(&tracepoint_srcu);
 }
 static inline bool tracepoint_is_faultable(struct tracepoint *tp)
 {
@@ -271,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	static inline void __do_trace_##name(proto)			\
 	{								\
 		if (cond) {						\
-			guard(preempt_notrace)();			\
+			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
 		}							\
 	}								\
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c90..d96ea84804c64 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -25,6 +25,9 @@ enum tp_func_state {
 extern tracepoint_ptr_t __start___tracepoints_ptrs[];
 extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
 
+DEFINE_SRCU(tracepoint_srcu);
+EXPORT_SYMBOL_GPL(tracepoint_srcu);
+
 enum tp_transition_sync {
 	TP_TRANSITION_SYNC_1_0_1,
 	TP_TRANSITION_SYNC_N_2_1,
@@ -34,6 +37,7 @@ enum tp_transition_sync {
 
 struct tp_transition_snapshot {
 	unsigned long rcu;
+	unsigned long srcu_gp;
 	bool ongoing;
 };
 
@@ -46,6 +50,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
 
 	/* Keep the latest get_state snapshot. */
 	snapshot->rcu = get_state_synchronize_rcu();
+	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = true;
 }
 
@@ -56,6 +61,8 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
 	if (!snapshot->ongoing)
 		return;
 	cond_synchronize_rcu(snapshot->rcu);
+	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
+		synchronize_srcu(&tracepoint_srcu);
 	snapshot->ongoing = false;
 }
 
@@ -78,6 +85,9 @@ static LIST_HEAD(tracepoint_module_list);
  */
 static DEFINE_MUTEX(tracepoints_mutex);
 
+static struct rcu_head *early_probes;
+static bool ok_to_free_tracepoints;
+
 /*
  * Note about RCU :
  * It is used to delay the free of multiple probes array until a quiescent
@@ -101,17 +111,59 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static __init int release_early_probes(void)
+{
+	struct rcu_head *tmp;
+
+	ok_to_free_tracepoints = true;
+
+	while (early_probes) {
+		tmp = early_probes;
+		early_probes = tmp->next;
+		call_srcu(&tracepoint_srcu, tmp, srcu_free_old_probes);
+	}
+
+	return 0;
+}
+
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	/*
+	 * We can't free probes if SRCU is not initialized yet.
+	 * Postpone the wait for SRCU until after it has initialized.
+	 */
+	if (unlikely(!ok_to_free_tracepoints)) {
+		struct tp_probes *tp_probes = container_of(head, struct tp_probes, rcu);
+
+		tp_probes->rcu.next = early_probes;
+		early_probes = &tp_probes->rcu;
+		return;
+	}
+
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
+
+/* SRCU is initialized at core_initcall */
+postcore_initcall(release_early_probes);
+
 static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
 
+		/*
+		 * Tracepoint probes are protected by either RCU or
+		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU
+		 * callback in the [Tasks Trace] RCU callback we cover
+		 * both cases. So let us chain the SRCU and [Tasks Trace]
+		 * RCU callbacks to wait for both grace periods.
+		 */
 		if (tracepoint_is_faultable(tp))
 			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
 		else
-- 
2.40.1

