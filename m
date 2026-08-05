Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DB46AA8D;
	Wed,  5 Aug 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932658; cv=none; b=hsrWX0K3xR7S0gKln3gTUsri9/aAn1HdLGsVQz46y91RNQkA/veFbGEUS1IbLGaQlLUalYaim446IMQdhJ6XwdSZzwV7OOOQYOy0z+m8cQY4l7NO0CD0UakbSZ5+ktx/YICwDSV9MIzw7ZZWFYRPS9jf7mpNHvfZslKgVgtWCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932658; c=relaxed/simple;
	bh=AHXnQVK2u8e2iwCU1KLipfIlXvpMOke0bbFculNVqkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElnRAerRdqDhaIDT9cyNas6GZjfIqZUg9CrELyETMmo01eLs8we1YCOPCnmukJ0Hs8rTPKVJbkAUKQj6DaiLx63USa2PZTcOEV4roqwDqm6GiSA+Luj0bAONWv+kI5wXMqN1erVPXZf18AMRdjw7fqNw2JEDJxoPGvVyebfdIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af+CYDeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af+CYDeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C2B1F000E9;
	Wed,  5 Aug 2026 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932657;
	bh=gLRQFYdOJ7aPkEIiatEnmo9QdkwxnK0Nw4TUVjsGhJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=af+CYDeS445OxjQX4XrX2XwNLJHIoll+r3UOi8B6Gl0Ehj7ISD7xtqrQaKx7j/+z5
	 nUs6JkH0KdfUfAk21wuGx/xwbXUTvA/daalLzPpA3ANVNTC5vXd5oZMrCg2fbK1uyw
	 BBj/7EmwAATGJNeXevo7y+Pi/hggw2n7wdus97ypd6MuoTa/ZAGhEG42nzUSWghtJ0
	 dDEAaJKgNzwHff06S5cgZo52YSBHUgRoMYi19jKpdkZOaT5Hx3pNsg2hs97OUQi09W
	 BolWeGrI3jdYY+KYIXa/4bJZAXQH/XV5BWPdr871ES1GAXe87Cb9+NDt/096Sji0DM
	 0AMHEMLzoLe/w==
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
Subject: [PATCH v3 5/6] rcutorture: Exercise ->call() from NMI context
Date: Wed,  5 Aug 2026 05:23:42 -0700
Message-ID: <20260805122346.269445-6-puranjay@kernel.org>
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

call_rcu() and call_srcu() are now safe to invoke from NMI, but
rcutorture never does, leaving the deferral path untested.

Add an ->nmi_capable flag to rcu_torture_ops.  For flavors that set it,
arm a per-CPU hardware perf counter whose overflow handler submits a
callback via ->call().  The handler acts only when in_nmi(), so only a
genuine NMI exercises the deferral path.  One preallocated callback is
kept in flight (guarded by an atomic) to avoid allocating in NMI.

Report the count issued from NMI ("nmi-calls:") and the count invoked
("nmi-cbs:").  rcu_torture_cleanup() disables the counters and then calls
cb_barrier(), which drains every deferred callback, so the two counts must
then match; a mismatch means a lost callback and fails the test.  This
relies on srcu_barrier()/rcu_barrier() flushing deferred callbacks, as
added earlier in the series.

Set ->nmi_capable on the NMI-safe flavors: rcu, srcu, srcud, and
tasks-tracing (call_srcu() under the hood).  Tasks and Tasks Rude are left
alone, as call_rcu_tasks_generic() is not yet NMI-safe.

Enabled by default; the nmi_calls parameter disables it, which helps rule
NMI handling in or out when triaging a failure.  Requires
CONFIG_PERF_EVENTS and a hardware PMU, else silently skipped.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcutorture.c | 154 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 39426a8718fe9..715c4c6c51b90 100644
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
 
@@ -2659,12 +2668,131 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 
 static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
 
+/*
+ * Exercise ->call() from NMI context for flavors that set ->nmi_capable.  A
+ * per-CPU hardware perf counter overflows into an NMI, and its handler submits
+ * one preallocated callback via ->call().  One callback is in flight at a time
+ * (guarded by an atomic) to avoid allocating in NMI.  This mirrors how a BPF
+ * program reaches ->call() from NMI.
+ */
+#ifdef CONFIG_PERF_EVENTS
+static struct perf_event_attr rcu_torture_nmi_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+	.freq		= 1,
+	.sample_freq	= 100,
+};
+
+/* One in-flight callback per CPU; ->inuse is released by the callback. */
+struct rcu_torture_nmi_cbs {
+	struct rcu_head rh;
+	atomic_t inuse;
+};
+
+static struct perf_event **rcu_torture_nmi_events;
+static int rcu_torture_nmi_hp_state;
+static DEFINE_PER_CPU(struct rcu_torture_nmi_cbs, rcu_torture_nmi_cbs);
+
+static void rcu_torture_nmi_cb(struct rcu_head *rhp)
+{
+	struct rcu_torture_nmi_cbs *rtncp = container_of(rhp, struct rcu_torture_nmi_cbs, rh);
+
+	atomic_long_inc(&n_rcu_torture_nmi_cb);
+	atomic_set(&rtncp->inuse, 0);
+}
+
+static void rcu_torture_nmi_overflow(struct perf_event *event,
+				     struct perf_sample_data *data,
+				     struct pt_regs *regs)
+{
+	struct rcu_torture_nmi_cbs *rtncp = this_cpu_ptr(&rcu_torture_nmi_cbs);
+
+	if (!in_nmi())
+		return;
+	if (cur_ops->call && !atomic_xchg(&rtncp->inuse, 1)) {
+		atomic_long_inc(&n_rcu_torture_nmi_call);
+		cur_ops->call(&rtncp->rh, rcu_torture_nmi_cb);
+	}
+}
+
+static int rcu_torture_nmi_online(unsigned int cpu)
+{
+	struct perf_event *event;
+
+	event = perf_event_create_kernel_counter(&rcu_torture_nmi_attr, cpu, NULL,
+						 rcu_torture_nmi_overflow, NULL);
+	if (IS_ERR(event))
+		return 0;
+	rcu_torture_nmi_events[cpu] = event;
+	perf_event_enable(event);
+	return 0;
+}
+
+static int rcu_torture_nmi_offline(unsigned int cpu)
+{
+	struct perf_event *event = rcu_torture_nmi_events[cpu];
+
+	if (event) {
+		rcu_torture_nmi_events[cpu] = NULL;
+		perf_event_disable(event);
+		perf_event_release_kernel(event);
+	}
+	return 0;
+}
+
+/*
+ * Drive the counters from CPU-hotplug callbacks so that coverage survives the
+ * onoff testing that most scenarios run.
+ */
+static void rcu_torture_nmi_init(void)
+{
+	int ret;
+
+	if (!nmi_calls || !cur_ops->nmi_capable || !cur_ops->call)
+		return;
+	rcu_torture_nmi_events = kcalloc(nr_cpu_ids, sizeof(*rcu_torture_nmi_events),
+					 GFP_KERNEL);
+	if (!rcu_torture_nmi_events)
+		return;
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "rcutorture/nmi:online",
+				rcu_torture_nmi_online, rcu_torture_nmi_offline);
+	if (ret < 0) {
+		kfree(rcu_torture_nmi_events);
+		rcu_torture_nmi_events = NULL;
+		return;
+	}
+	rcu_torture_nmi_hp_state = ret;
+}
+
+static void rcu_torture_nmi_cleanup(void)
+{
+	if (!rcu_torture_nmi_events)
+		return;
+	if (rcu_torture_nmi_hp_state > 0) {
+		cpuhp_remove_state(rcu_torture_nmi_hp_state);
+		rcu_torture_nmi_hp_state = 0;
+	}
+	kfree(rcu_torture_nmi_events);
+	rcu_torture_nmi_events = NULL;
+	if (!atomic_long_read(&n_rcu_torture_nmi_call))
+		pr_alert("%s: nmi_calls set but no ->call() issued from NMI: not supported here.\n",
+			 __func__);
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
@@ -3047,6 +3175,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
+	pr_cont("nmi-calls: %ld nmi-cbs: %ld ",
+		atomic_long_read(&n_rcu_torture_nmi_call),
+		atomic_long_read(&n_rcu_torture_nmi_cb));
 	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 	pr_cont("gpwraps: %ld\n", n_gpwraps);
@@ -3195,7 +3326,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "read_exit_delay=%d read_exit_burst=%d "
 		 "reader_flavor=%x "
 		 "nocbs_nthreads=%d nocbs_toggle=%d "
-		 "test_nmis=%d "
+		 "test_nmis=%d nmi_calls=%d "
 		 "preempt_duration=%d preempt_interval=%d n_up_down=%d\n",
 		 torture_type, tag, nrealreaders, nwriters, nrealfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
@@ -3209,7 +3340,7 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 read_exit_delay, read_exit_burst,
 		 reader_flavor,
 		 nocbs_nthreads, nocbs_toggle,
-		 test_nmis,
+		 test_nmis, nmi_calls,
 		 preempt_duration, preempt_interval, n_up_down);
 }
 
@@ -4283,6 +4414,7 @@ rcu_torture_cleanup(void)
 	int i;
 
 	if (torture_cleanup_begin()) {
+		rcu_torture_nmi_cleanup();
 		if (cur_ops->cb_barrier != NULL) {
 			pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 			cur_ops->cb_barrier();
@@ -4325,6 +4457,8 @@ rcu_torture_cleanup(void)
 		kfree(reader_tasks);
 		reader_tasks = NULL;
 	}
+	/* Disable the perf counters (and thus the NMI ->call() firing) now. */
+	rcu_torture_nmi_cleanup();
 	kfree(rcu_torture_reader_mbchk);
 	rcu_torture_reader_mbchk = NULL;
 
@@ -4354,6 +4488,20 @@ rcu_torture_cleanup(void)
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
 
@@ -4786,6 +4934,8 @@ rcu_torture_init(void)
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

