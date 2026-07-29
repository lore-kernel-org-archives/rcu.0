Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A549219A;
	Wed, 29 Jul 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342187; cv=none; b=hmQWDqxuv/KWLIxFmge3wP2n+gfYIV0u6Nb7F7UeoL45zKpFY8FUM9N6TPznmN3awI+N5foQH5rKsSeNY/Pll0GbCz3VYE8F6FvYMjXxKym64OVUiXv1rPCMQFCmVrpHSzw+tCZPesUgdH3qIsVN1vZQvLArgYMY0zmozCscKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342187; c=relaxed/simple;
	bh=/n5mIIl7e6RrYga/5RicxaMvallwBgmwuB3heSczKgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSC0zNKKuCvgf/kBcRmXhJZP6MSiDtb3/Y9OvnK8EBSQ7O0vbMZt6z2UuOwOApYUv7+pANTvcz77M6+CjOOaQkgHo71Yi1rWhyuhCtSyrvlm1P1CRR2v9gcul0WyG1RmYCBY9nmE4fzSuoEyKtaHsu3b9NFpuc5axhDDIh13WZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmLjusk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmLjusk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0898D1F000E9;
	Wed, 29 Jul 2026 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342186;
	bh=bnU3oj19dDbWTpMPDzjUPF0SZcrT5OXJDHdJ/mYKhLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmLjusk+r1pIYnNPJ0SGdLxyhJsTD722rrGNR+92xuMOkyWB+T7i3VB/eJIkdkKpE
	 4t+qgjz+PRAfAWz3N4ZvwI/68Fqrz9KzlIjcTrWmfx1MLt9x6ENSU3iuyRcLVuCzZl
	 3NNyPqCK8KJmFIS3Ox5J6cRcIjSC+5u0gukB/8tRsW15puMHnkj7PJe7YU32rCVF8k
	 IERX+w0Sw+NUAbWvz7gyWin180JvyENMFYKPfmg2BvTMxRtfWZqE/bsRgRQc5h5mjw
	 CdEcRxPLaleZQZYbLWts23qfJJzqk9DiAqYrZSGjd6Td6rTps8akHm3CZ1rIVrCkSX
	 oMwR1si4D8gYw==
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
Subject: [PATCH 5/6] rcutorture: Exercise ->call() from NMI context
Date: Wed, 29 Jul 2026 09:22:04 -0700
Message-ID: <20260729162207.1567770-6-puranjay@kernel.org>
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

call_rcu() and call_srcu() are now safe to invoke from NMI context, but
rcutorture never calls them from there, leaving the deferral path
untested.

Add an ->nmi_capable flag to rcu_torture_ops and, for flavors that set
it, arm a per-CPU hardware perf counter whose overflow handler submits a
callback via ->call().  The overflow arrives as a real NMI on x86 and a
pseudo-NMI on arm64 (irqchip.gicv3_pseudo_nmi=1); the handler acts only
when in_nmi(), so it exercises the deferral path only for a genuine NMI.
One preallocated callback is kept in flight (guarded by an atomic) to
avoid allocating in NMI.

Report both the count issued from NMI ("nmi-calls:") and the count
invoked ("nmi-cbs:").  rcu_torture_cleanup() disables the perf counters
and then calls cb_barrier(), which drains every deferred callback, so at
that point the two counts must be equal; a mismatch means a callback was
lost and fails the test.  This leans on srcu_barrier()/rcu_barrier()
flushing the deferred callbacks, as added earlier in this series.

Set ->nmi_capable on the NMI-safe flavors: rcu, srcu, srcud, and
tasks-tracing (call_srcu() under the hood).  Tasks and Tasks Rude are
left alone, as call_rcu_tasks_generic() is not yet NMI-safe.

Testing is on by default; the nmi_calls parameter disables it, which
helps rule NMI handling in or out when triaging a failure.  Requires
CONFIG_PERF_EVENTS and a hardware PMU; otherwise silently skipped.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcutorture.c | 115 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 39426a8718fe9..7be6cabf5898c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -48,6 +48,7 @@
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/nmi.h>
+#include <linux/perf_event.h>
 
 #include "rcu.h"
 
@@ -115,6 +116,7 @@ torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testing");
 torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
+torture_param(bool, nmi_calls, true, "Exercise ->call() from NMI on nmi_capable flavors");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
@@ -216,6 +218,8 @@ static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
 static atomic_long_t n_rcu_torture_irqs;
+static atomic_long_t n_rcu_torture_nmi_call;
+static atomic_long_t n_rcu_torture_nmi_cb;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
@@ -433,6 +437,7 @@ struct rcu_torture_ops {
 	bool (*is_task_rcu_boosted)(void);
 	long cbflood_max;
 	int irq_capable;
+	int nmi_capable;
 	int can_boost;
 	int extendables;
 	int slow_gps;
@@ -648,6 +653,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.extendables		= RCUTORTURE_MAX_EXTEND,
 	.debug_objects		= 1,
 	.start_poll_irqsoff	= 1,
+	.nmi_capable		= 1,
 	.name			= "rcu"
 };
 
@@ -942,6 +948,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.debug_objects	= 1,
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
 				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
+	.nmi_capable	= 1,
 	.name		= "srcu"
 };
 
@@ -1005,6 +1012,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.debug_objects	= 1,
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
 				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
+	.nmi_capable	= 1,
 	.name		= "srcud"
 };
 
@@ -1269,6 +1277,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
+	.nmi_capable	= 1,
 	.name		= "tasks-tracing"
 };
 
@@ -2659,12 +2668,97 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 
 static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
 
+/*
+ * Exercise ->call() from NMI context for flavors that advertise ->nmi_capable.
+ * A per-CPU hardware perf counter overflows into an NMI -- a real NMI on x86,
+ * or a pseudo-NMI on arm64 booted with irqchip.gicv3_pseudo_nmi=1 -- and its
+ * handler submits one preallocated callback via ->call().  Only one callback is
+ * in flight at a time (guarded by an atomic), which avoids allocating in NMI
+ * and is enough to exercise the deferral.  This mirrors how BPF programs reach
+ * ->call() from NMI.  Requires a hardware PMU; when the overflow is not an NMI
+ * the handler does nothing.
+ */
+#ifdef CONFIG_PERF_EVENTS
+static struct perf_event_attr rcu_torture_nmi_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+	.freq		= 1,
+	.sample_freq	= 1000,
+};
+
+static struct perf_event **rcu_torture_nmi_events;
+static struct rcu_head rcu_torture_nmi_rh;
+static atomic_t rcu_torture_nmi_rh_inuse;
+
+static void rcu_torture_nmi_cb(struct rcu_head *rhp)
+{
+	atomic_long_inc(&n_rcu_torture_nmi_cb);
+	atomic_set(&rcu_torture_nmi_rh_inuse, 0);
+}
+
+static void rcu_torture_nmi_overflow(struct perf_event *event,
+				     struct perf_sample_data *data,
+				     struct pt_regs *regs)
+{
+	if (!in_nmi())
+		return;
+	if (cur_ops->call && !atomic_xchg(&rcu_torture_nmi_rh_inuse, 1)) {
+		cur_ops->call(&rcu_torture_nmi_rh, rcu_torture_nmi_cb);
+		atomic_long_inc(&n_rcu_torture_nmi_call);
+	}
+}
+
+static void rcu_torture_nmi_init(void)
+{
+	struct perf_event *event;
+	int cpu;
+
+	if (!nmi_calls || !cur_ops->nmi_capable || !cur_ops->call)
+		return;
+	rcu_torture_nmi_events = kcalloc(nr_cpu_ids, sizeof(*rcu_torture_nmi_events),
+					 GFP_KERNEL);
+	if (!rcu_torture_nmi_events)
+		return;
+	for_each_online_cpu(cpu) {
+		event = perf_event_create_kernel_counter(&rcu_torture_nmi_attr, cpu,
+							 NULL, rcu_torture_nmi_overflow, NULL);
+		if (IS_ERR(event))
+			continue;
+		rcu_torture_nmi_events[cpu] = event;
+		perf_event_enable(event);
+	}
+}
+
+static void rcu_torture_nmi_cleanup(void)
+{
+	int cpu;
+
+	if (!rcu_torture_nmi_events)
+		return;
+	for_each_possible_cpu(cpu) {
+		if (!rcu_torture_nmi_events[cpu])
+			continue;
+		perf_event_disable(rcu_torture_nmi_events[cpu]);
+		perf_event_release_kernel(rcu_torture_nmi_events[cpu]);
+	}
+	kfree(rcu_torture_nmi_events);
+	rcu_torture_nmi_events = NULL;
+}
+#else /* #ifdef CONFIG_PERF_EVENTS */
+static void rcu_torture_nmi_init(void) { }
+static void rcu_torture_nmi_cleanup(void) { }
+#endif /* #else #ifdef CONFIG_PERF_EVENTS */
+
 /*
  * RCU torture reader from timer handler.  Dereferences rcu_torture_current,
  * incrementing the corresponding element of the pipeline array.  The
  * counter in the element should never be greater than 1, otherwise, the
  * RCU implementation is broken.
  */
+
 static void rcu_torture_timer(struct timer_list *unused)
 {
 	WARN_ON_ONCE(!in_serving_softirq());
@@ -3047,6 +3141,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
+	pr_cont("nmi-calls: %ld nmi-cbs: %ld ",
+		atomic_long_read(&n_rcu_torture_nmi_call),
+		atomic_long_read(&n_rcu_torture_nmi_cb));
 	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 	pr_cont("gpwraps: %ld\n", n_gpwraps);
@@ -4325,6 +4422,8 @@ rcu_torture_cleanup(void)
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
+	/* Disable the perf counters (and thus the NMI ->call() firing) now. */
+	rcu_torture_nmi_cleanup();
 	kfree(rcu_torture_reader_mbchk);
 	rcu_torture_reader_mbchk = NULL;
 
@@ -4354,6 +4453,20 @@ rcu_torture_cleanup(void)
 		pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 		cur_ops->cb_barrier();
 	}
+
+	/*
+	 * cb_barrier() above drained every deferred NMI ->call() callback, so the
+	 * count issued from NMI must equal the count invoked; a mismatch means a
+	 * callback was lost.
+	 */
+	if (atomic_long_read(&n_rcu_torture_nmi_call) !=
+	    atomic_long_read(&n_rcu_torture_nmi_cb)) {
+		pr_alert("%s: NMI ->call() lost a callback: issued %ld invoked %ld\n",
+			 __func__, atomic_long_read(&n_rcu_torture_nmi_call),
+			 atomic_long_read(&n_rcu_torture_nmi_cb));
+		atomic_inc(&n_rcu_torture_error);
+	}
+
 	if (cur_ops->cleanup != NULL)
 		cur_ops->cleanup();
 
@@ -4786,6 +4899,8 @@ rcu_torture_init(void)
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
+	/* Arm the per-CPU perf counters that drive ->call() from NMI. */
+	rcu_torture_nmi_init();
 	for (i = 0; i < nrealreaders; i++) {
 		rcu_torture_reader_mbchk[i].rtc_chkrdr = -1;
 		firsterr = torture_create_kthread(rcu_torture_reader, (void *)i,
-- 
2.53.0-Meta

