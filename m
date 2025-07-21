Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09E12DFA37;
	Mon, 21 Jul 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115075; cv=none; b=Z595DzcRd+xUTs36RAhPn1CzRCPHB4jVa1XrKNm6gkkMOGdPNgruOkwydapVpOrq6ztlm8SvIU/DIZy+oV0WcjOe0WbwPo7OrZe0fNgBD/+ecWUw8qjn3cnZErEe+3TrZ2FPE5KNxoOqna9CMhV/J2vXCHrEuJ6AdACD/emzz6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115075; c=relaxed/simple;
	bh=Fw6xgVyZPHlGcRlgHk3BS90lx5Y6xVMXcZ2s8SWzVHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLCFguneoGLRG7ZiBlrxcfQMnYh/RmHacRJD7nCBOEEfOXCYPIsU+gRtXl6/eRvXMcWNA4KwK5WBAft4i0BM0mV8G+Z+I8Gae7kuSDcATD9/x3DjvJnKmVK1V/yP6WL2xzKjAI8galm+9TKJ35S9JvsFAGE7GfHnwoXik/wpduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvl7MVrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvl7MVrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BEAC4CEF8;
	Mon, 21 Jul 2025 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115075;
	bh=Fw6xgVyZPHlGcRlgHk3BS90lx5Y6xVMXcZ2s8SWzVHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvl7MVrU2WNaAl1YUCU/7NxkhZmO73XfXhU7zbb/kTTrRJYo31lmYM8cFVXwqz4Vw
	 mlmmo/d9gtf2tL6TasVkm38z729F/WOgIvRmsoQDqDfx05bSg5ArqR8mqlDDoOvpmg
	 4VWl+9eWNWZnAJIaQr7TRCWeo5KIXIlpB1tlc8O/KFGzbMItP/NQQP+Fm2JWjz2frp
	 Gnlkj15JCd2lb4Sbv1zOpRdBGqLy7N+FYUEJf06IgtmoJ/h61Uv4nNiHC5mlrvHk5c
	 JW+Ds+ushoHayp8mHVwN6bzCF+EnF/B+/m9WQayqkcsl3+W5T9UALoS5Nro31WZ/gw
	 heHYwdOhKIhjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1474ECE0E09; Mon, 21 Jul 2025 09:24:35 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 4/4] tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast
Date: Mon, 21 Jul 2025 09:24:33 -0700
Message-Id: <20250721162433.10454-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
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

While in the area, SRCU now supports early boot call_srcu().  Therefore,
remove the checks that used to avoid such use from rcu_free_old_probes()
before this commit was applied:

e53244e2c893 ("tracepoint: Remove SRCU protection")

The current commit can be thought of as an approximate revert of that
commit.

Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/tracepoint.h |  6 ++++--
 kernel/tracepoint.c        | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

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
index 62719d2941c90..e19973015cbd7 100644
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
 
@@ -101,17 +108,29 @@ static inline void *allocate_probes(int count)
 	return p == NULL ? NULL : p->probes;
 }
 
-static void rcu_free_old_probes(struct rcu_head *head)
+static void srcu_free_old_probes(struct rcu_head *head)
 {
 	kfree(container_of(head, struct tp_probes, rcu));
 }
 
+static void rcu_free_old_probes(struct rcu_head *head)
+{
+	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
+}
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

