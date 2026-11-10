Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338942;
	b=whEOJTD6hGij3kkPLurm0W/xnmQI0DsMRJ/iha6YYmAx+OT9debkls+PDY+Lp26E+nba
	 xgDuuHR69OYN9689ZiOcEmy9NKaU24FnzvOiSasr1alsSB349y3+xV+RtlbjnnDtd1Ewn
	 xM7h8dyme/x28HUAxf7JPyc5QytbjiDsrFZw5kOoH01daLw0bu6eM3cv/Sz3lngW0orst
	 9cq5011wfYXttYRFmg9MPKQrargoHwaAB3ncUrkq6v13ddWapYJ7hnyN4xAALA5C6c9bk
	 nihcmZtMstzl3XvJQoHjeOG3i8xeYeCsexkhm9KsUe6FAIojmd2RLOQEuX9kquNYB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338942;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OCSQQxkI9UE/mJPvaIPvGtFIviaDCGrT5HZJl8ILLAA=;
	b=x+4XrJgQZMKRandFI3V7B+FVWqxcsTfaXwKDDp9eiKLScYAWVvMf/V3MIf/LVLNvT0RH
	 e927H56b/3fTzGrdgqn6Rs5mjXfWlWJpicxKW+i/ApyW8u4qWyLHY3yDWfzo4IkIuDYR+
	 uqaXFtvPvCSM2DrzfOD6t7BT21si+V+q12oILp+EYq968WojbHBqWqYCZO7YyMMoYoLFF
	 OQ6UMwdz6n0DYLOSZHPh8hgDEaL1AA77i/WD+nRahbGMTB2vek9wGra9U/2j61vgtIBQv
	 6hQ/NsR9kM8M5okWrRMO54HZznVnR+Tn3XCfPHtF0RxGOGTgmZeqg2+W0E8AounxgPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=asRAjbWc;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92885606A32A;
	Tue, 10 Nov 2026 19:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92885606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=asRAjbWc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794338934;
	bh=OCSQQxkI9UE/mJPvaIPvGtFIviaDCGrT5HZJl8ILLAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asRAjbWcFEcWYWJrZUN93cYmcu2gfQ3XDbvYVHqdzD7uotUQ3OEVpEdeqwwF7mxL2
	 O8f6hPMo9jfb/ee/DI6MOxzFzWFmRtgcM+++l5IcI3Vd8IbQlgIF1pivseIK+SuiE1
	 wOOZqSQBOTkaoxOmL8U5xUvyBWeAkQKxqJjPeySTvgXS5qDDmMjG8sap+eGQoYYCh8
	 1gogh3ahj+XjadcfT9EnDcktWJzLJ017rTFbCTk0WYCjBsuLc9IOyZoqnGsNbnUDBp
	 7/Mo8riCkMMFT1ysOlIxop8zX9ULy5VJ4T3eUaarfh8x2hVBlnmaK2Tr7zqiDKyTg7
	 c/HkWKrmQWAlA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jPGsy5ByLzNYX;
	Tue, 10 Nov 2026 14:28:54 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	rcu@vger.kernel.org
Subject: [PATCH 3/4] rcutorture: Run NMI-safe SRCU readers from NMI
Date: Tue, 10 Nov 2026 14:28:43 -0500
Message-Id: <20261110192844.44713-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcutorture exercises ->call() from NMI, but never runs a reader there.
So nothing tests the NMI-safe reader flavors where it matters most: in
an NMI that interrupts another reader during its counter update.

Run a reader from the same per-CPU perf-counter NMI, when every reader
flavor in use is NMI-safe. These flavors are srcu_read_lock_nmisafe(),
srcu_read_lock_fast() and srcu_read_lock_atomic(). A new ops hook,
->nmi_reader_capable(), reports whether the reader flavors in use are
all NMI-safe. A new nmi_readers module parameter, on by default, enables
these NMI readers. The statistics count these readers as nmi-reads.

The reader loads rcu_torture_current and checks its element as the
other readers do. The element must not be freed before the reader ends.
It must not go through two grace periods either.

The NMI may interrupt lockdep, which then does not record the reader.
So the reader loads the pointer with rcu_dereference_raw().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rcu/rcutorture.c | 60 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 968343be4e0d..3b9c08a094cd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -117,6 +117,7 @@ torture_param(int, n_barrier_cbs, 0, "# of callbacks/kthreads for barrier testin
 torture_param(int, n_up_down, 32, "# of concurrent up/down hrtimer-based RCU readers");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
 torture_param(bool, nmi_calls, true, "Exercise ->call() from NMI on nmi_capable flavors");
+torture_param(bool, nmi_readers, true, "Run readers from NMI with NMI-safe reader flavors");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(bool, nwriters, 1, "Number of RCU writer threads (0 or 1)");
 torture_param(int, object_debug, 0, "Enable debug-object double call_rcu() testing");
@@ -220,6 +221,7 @@ static atomic_long_t n_rcu_torture_timers;
 static atomic_long_t n_rcu_torture_irqs;
 static atomic_long_t n_rcu_torture_nmi_call;
 static atomic_long_t n_rcu_torture_nmi_cb;
+static atomic_long_t n_rcu_torture_nmi_read;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
 static unsigned long n_read_exits;
@@ -438,6 +440,7 @@ struct rcu_torture_ops {
 	long cbflood_max;
 	int irq_capable;
 	int nmi_capable;
+	bool (*nmi_reader_capable)(void); // Are ->readlock() and ->readunlock() NMI-safe?
 	int can_boost;
 	int extendables;
 	int slow_gps;
@@ -790,6 +793,14 @@ static int srcu_torture_read_lock(void)
 	return ret;
 }
 
+// Only these reader flavors may be used from NMI.
+static bool srcu_torture_nmi_reader_capable(void)
+{
+	return reader_flavor &&
+	       !(reader_flavor & ~(SRCU_READ_FLAVOR_NMI | SRCU_READ_FLAVOR_FAST |
+				   SRCU_READ_FLAVOR_ATOMIC));
+}
+
 static void
 srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 {
@@ -981,6 +992,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
 				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
 	.nmi_capable	= 1,
+	.nmi_reader_capable = srcu_torture_nmi_reader_capable,
 	.name		= "srcu"
 };
 
@@ -1049,6 +1061,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.have_up_down	= IS_ENABLED(CONFIG_TINY_SRCU)
 				? 0 : SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_FAST_UPDOWN,
 	.nmi_capable	= 1,
+	.nmi_reader_capable = srcu_torture_nmi_reader_capable,
 	.name		= "srcud"
 };
 
@@ -2711,6 +2724,10 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
  * per-CPU hardware perf counter overflows into an NMI, and its handler submits
  * a preallocated callback via ->call().  One callback per CPU is in flight at a
  * time (guarded by an atomic) to avoid allocating in NMI.
+ *
+ * The same handler also runs a reader, for flavors whose ->nmi_reader_capable()
+ * says that their readers are NMI-safe.  The reader may interrupt another
+ * reader on its CPU, in the middle of its counter update.
  */
 #ifdef CONFIG_PERF_EVENTS
 static struct perf_event_attr rcu_torture_nmi_attr = {
@@ -2735,6 +2752,8 @@ struct rcu_torture_nmi_cb {
 
 static struct perf_event **rcu_torture_nmi_events;
 static int rcu_torture_nmi_hp_state;
+static bool rcu_torture_nmi_do_calls;
+static bool rcu_torture_nmi_do_reads;
 static DEFINE_PER_CPU(struct rcu_torture_nmi_cb, rcu_torture_nmi_cb);
 
 static void rcu_torture_nmi_invoked(struct rcu_head *rhp)
@@ -2745,6 +2764,28 @@ static void rcu_torture_nmi_invoked(struct rcu_head *rhp)
 	atomic_set(&rtncp->inuse, 0);
 }
 
+/*
+ * A reader in NMI.  The NMI may interrupt lockdep, which then does not record
+ * the reader, so the pointer is loaded without a lockdep check.  The element
+ * must not go through two grace periods before the reader ends.
+ */
+static void rcu_torture_nmi_read(void)
+{
+	struct rcu_torture *p;
+	int idx;
+
+	idx = cur_ops->readlock();
+	p = rcu_dereference_raw(rcu_torture_current);
+	if (p) {
+		if (!READ_ONCE(p->rtort_mbtest))
+			atomic_inc(&n_rcu_torture_mberror);
+		if (READ_ONCE(p->rtort_pipe_count) > 1)
+			atomic_inc(&n_rcu_torture_error);
+	}
+	cur_ops->readunlock(idx);
+	atomic_long_inc(&n_rcu_torture_nmi_read);
+}
+
 static void rcu_torture_nmi_overflow(struct perf_event *event,
 				     struct perf_sample_data *data,
 				     struct pt_regs *regs)
@@ -2753,10 +2794,12 @@ static void rcu_torture_nmi_overflow(struct perf_event *event,
 
 	if (!in_nmi())
 		return;
-	if (cur_ops->call && !atomic_xchg(&rtncp->inuse, 1)) {
+	if (rcu_torture_nmi_do_calls && !atomic_xchg(&rtncp->inuse, 1)) {
 		atomic_long_inc(&n_rcu_torture_nmi_call);
 		cur_ops->call(&rtncp->rh, rcu_torture_nmi_invoked);
 	}
+	if (rcu_torture_nmi_do_reads)
+		rcu_torture_nmi_read();
 }
 
 static int rcu_torture_nmi_online(unsigned int cpu)
@@ -2789,7 +2832,10 @@ static void rcu_torture_nmi_init(void)
 {
 	int ret;
 
-	if (!nmi_calls || !cur_ops->nmi_capable || !cur_ops->call)
+	rcu_torture_nmi_do_calls = nmi_calls && cur_ops->nmi_capable && cur_ops->call;
+	rcu_torture_nmi_do_reads = nmi_readers && cur_ops->nmi_reader_capable &&
+				   cur_ops->nmi_reader_capable();
+	if (!rcu_torture_nmi_do_calls && !rcu_torture_nmi_do_reads)
 		return;
 	rcu_torture_nmi_events = kcalloc(nr_cpu_ids, sizeof(*rcu_torture_nmi_events),
 					 GFP_KERNEL);
@@ -2815,9 +2861,12 @@ static void rcu_torture_nmi_cleanup(void)
 	}
 	kfree(rcu_torture_nmi_events);
 	rcu_torture_nmi_events = NULL;
-	if (!atomic_long_read(&n_rcu_torture_nmi_call))
+	if (rcu_torture_nmi_do_calls && !atomic_long_read(&n_rcu_torture_nmi_call))
 		pr_alert("%s: nmi_calls set but no ->call() ever issued from NMI, so NMI ->call() went untested (no PMU, or NMIs unavailable here).\n",
 			 __func__);
+	if (rcu_torture_nmi_do_reads && !atomic_long_read(&n_rcu_torture_nmi_read))
+		pr_alert("%s: nmi_readers set but no reader ever ran in NMI, so NMI readers went untested (no PMU, or NMIs unavailable here).\n",
+			 __func__);
 }
 #else /* #ifdef CONFIG_PERF_EVENTS */
 static void rcu_torture_nmi_init(void) { }
@@ -3212,9 +3261,10 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
 	pr_cont("read-exits: %ld ", data_race(n_read_exits)); // Statistic.
-	pr_cont("nmi-calls: %ld nmi-cbs: %ld ",
+	pr_cont("nmi-calls: %ld nmi-cbs: %ld nmi-reads: %ld ",
 		atomic_long_read(&n_rcu_torture_nmi_call),
-		atomic_long_read(&n_rcu_torture_nmi_cb));
+		atomic_long_read(&n_rcu_torture_nmi_cb),
+		atomic_long_read(&n_rcu_torture_nmi_read));
 	pr_cont("nocb-toggles: %ld:%ld ",
 		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 	pr_cont("gpwraps: %ld\n", n_gpwraps);
-- 
2.47.3

