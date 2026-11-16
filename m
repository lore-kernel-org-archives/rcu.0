Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858282;
	b=ZPNDKGjro7SgJfMKgAUP3x1em6XiwTCgu++4Mzi5hVV27g2SenzsY0AayVtYfpgAGwwz
	 CU/c8B9ZKJbGeQi2FWdymNXu7TE1wSXFJQn06OIBPztbaoswgt/POKyuWRPV+M9+7hHAk
	 jZmvrwVcREOWtE8PqLPpLA1FMAErIfY3+5kZT04rj5U5BpRQnkPDavBKvbUhYIab6cwbT
	 SABR7VXZXBaS7vHWIIuBQHfILio1I0fcFil6jVq9IjdEVLCDGqYrkvscNyYwLbG5TX14m
	 NCI6D330sngcn4vwAAC1Zi32Qpn1l889RKAYtB+mTlsjNWxr+71tVuYe6ONge33xtkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xwIbrh/zTRygGrMYQoki+iqMb0ELJDc95T0+mWrWohU=;
	b=iwV8pjuefrDATIltVFCcfaRHIWcTIbZu7+gsmIrbsUuFkV2/nU/5Hb8r7QN7z1bnL8ap
	 LsNmDSoUgQfXQGwKQY58tZiR9q0XM5/XShutq7DTo0rLGka9p41Zw+Qu8esmU3OhA/ZFM
	 qDIjrH7ymAltSSq8bZkxCZv9Ic+BaP1QAeIf4AaolTOQt/XNBpyTxLnCgkpGNnEn5rbUY
	 Xey6an7EuH4JOI9w7LVuzEjCO01MI24Y0JHc2FhimPQRt4USMWeHBee7WXEsYsSWjpPMf
	 HllSXACfaXeMeyWFVlv2sEJQSnSzz5wflOzeUr8Zlt7VLKYWd+ZfjaIS0NxZaXKX27A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEmmsmfO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AA6B5606A339;
	Mon, 16 Nov 2026 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEmmsmfO
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F1AC21F000CA;
	Mon, 16 Nov 2026 19:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858282;
	bh=xwIbrh/zTRygGrMYQoki+iqMb0ELJDc95T0+mWrWohU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EEmmsmfOf6TM3FT6ZwX+6x89bcu+nVWJkEMFvIoyBGRSsylCZ8LRzEWEiRGggzz4u
	 ULFnOkE7aRqwjfrdo0Xvuidh9inOQ9RAjOsohkQ/yxP551OoLNszDSQe5vYKW3hUQo
	 NgI8phbqT/gjPVdKJTU8OP/lmxpz5GAVCJQJnaVH8uGSfqRhmbsRKVYUpkcmtTZQU/
	 q7rlXQtahQkw6LnvgxUYSBB8UcBjRzjd00Vzl1snngA03/2X8Z4R/PkUEGIS7qGlhM
	 u4tc1GXisvXgov3/xVhlvRb7cl8JuMxsF0daxHdKdu7Ag6zVmwbDfItGbQqcPSz9OL
	 ubQHwxMpd/pNw==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/7] rcutorture: Rewrite RCU priority-boost test around a CPU-hungry reader
Date: Mon, 16 Nov 2026 14:44:32 -0500
Message-ID: <20261116194438.306618-2-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116194438.306618-1-jfern@kernel.org>
References: <20261116194438.306618-1-jfern@kernel.org>
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

The old boost test relies on RT throttling being disabled and on grace
periods taking too long, which is fragile.  Instead, each interval one
CPU runs a normal-priority reader that spins inside an RCU read-side
critical section until it has consumed test_boost_reader_ms of CPU time
(measured via sum_exec_runtime, so time spent preempted does not count),
while a SCHED_FIFO hog on the same CPU tries to starve it.  With RT
throttling enabled, an unboosted reader gets only about 5% of the CPU,
far less than it needs within test_boost_duration.  If the reader
finishes, boosting worked, otherwise it failed.

Only one CPU is tested per interval because RCU boosts the readers of an
rcu_node one at a time, so a second slow reader sharing the rcu_node
would wait for the first one's whole CPU burn and falsely fail.

The reader publishes completion before leaving its critical section.
Otherwise the deboost on rcu_read_unlock() lets the hog preempt the
reader before it can set its flag, which falsely fails the test.

Testing methodology:

The test must pass when boosting works and fail when it does not, so
both directions were exercised.  All runs used kvm.sh with
--duration 10 --bootargs "rcutorture.test_boost=2" (which also forces
the test on in scenarios whose .boot file disables it).

Success testing: with the series applied and no other changes, run
TREE01 TREE02 TREE03 TREE08 TREE09 BUSTED-BOOST for 10 minutes each.
Every scenario ended "SUCCESS" with rtbf (boost failures) of 0 in 59 to
83 boost intervals.  (BUSTED-BOOST can no longer fail by construction
because CONFIG_RCU_BOOST is now enabled automatically for preemptible
RCU.)

Failure testing: break boosting on purpose by making the early-return
check in rcu_initiate_boost() (kernel/rcu/tree_plugin.h) always true:

	-	if (!rnp->boost_kthread_task ||
	+	if (1 || !rnp->boost_kthread_task ||

then run TREE03 and TREE02 for 10 minutes each.  Both ended "FAILURE",
with 58 of 72 (TREE03) and 62 of 72 (TREE02) intervals reporting:

	rcu_torture_boost boosting failed
	Boost inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies

The 203 ms is the CPU time that RT throttling leaves a SCHED_NORMAL task
over test_boost_duration, confirming that the reader finishes only when
boosted.  The remaining intervals were discarded because of hotplug or
stutter.  Setting CONFIG_RCU_BOOST_DELAY=3000 also produces failures,
roughly half of the intervals.

Pitfall found while testing: a first version set the reader's finished
flag after rcu_read_unlock(), which failed about half of the intervals
in TREE01 (readers on CPUs brought online by its nr_cpus=17 hotplug)
even with boosting working, hence the ordering above.

test_boost_reader_ms should be well below test_boost_duration minus
RCU_BOOST_DELAY and slack: a boosted reader needs about
RCU_BOOST_DELAY + test_boost_reader_ms / 0.95 to finish.

test_boost_reader_ms is clamped to between 1 ms and the length of the
test window, test_boost_duration.

[ jfern: Apply feedback from Sebastian to use kthread_run_on_cpu() ]
[ jfern: Apply feedback from Sebastian to range-check reader_ms ]
[ jfern: Apply feedback from Sebastian to use div64_ul() ]

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcutorture.c | 184 ++++++++++++++++++++++++----------------
 1 file changed, 110 insertions(+), 74 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 924705b7759d..a81855efbf1f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -149,6 +149,7 @@ torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
 torture_param(int, test_boost_duration, 4, "Duration of each boost test, seconds.");
 torture_param(int, test_boost_holdoff, 0, "Holdoff time from rcutorture start, seconds.");
 torture_param(int, test_boost_interval, 7, "Interval between boost tests, seconds.");
+torture_param(int, test_boost_reader_ms, 2000, "Boost-test reader CPU time, ms.");
 torture_param(int, test_nmis, 0, "End-test NMI tests, 0 to disable.");
 torture_param(bool, test_no_idle_hz, true, "Test support for tickless idle CPUs");
 torture_param(int, test_srcu_lockdep, 0, "Test specified SRCU deadlock scenario.");
@@ -333,6 +334,7 @@ static bool shutdown_time_arrived(void)
 }
 
 static unsigned long boost_starttime;	/* jiffies of next boost test start. */
+static unsigned long boost_claimed;	/* ->boost_starttime of claimed test. */
 static DEFINE_MUTEX(boost_mutex);	/* protect setting boost_starttime */
 					/*  and boost task create/destroy. */
 static atomic_t barrier_cbs_count;	/* Barrier callbacks registered. */
@@ -1334,10 +1336,17 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 }
 
 /*
- * RCU torture priority-boost testing.  Runs one real-time thread per
- * CPU for moderate bursts, repeatedly starting grace periods and waiting
- * for them to complete.  If a given grace period takes too long, we assume
- * that priority inversion has occurred.
+ * RCU torture priority-boost testing.  Each test interval, one CPU
+ * runs a normal-priority reader that spins inside an RCU read-side
+ * critical section until it has consumed test_boost_reader_ms of CPU
+ * time, while a SCHED_FIFO hog on the same CPU tries to starve it.  RT
+ * throttling is left enabled, so an unboosted reader gets only a few
+ * percent of the CPU, far too little to finish within test_boost_duration.
+ * If the reader finishes anyway, boosting lifted it above the hog.
+ *
+ * Only one CPU is tested per interval because RCU boosts the readers
+ * of a given rcu_node one at a time, so a second slow reader sharing the
+ * rcu_node would wait for the first one's whole CPU burn.
  */
 
 static int old_rt_runtime = -1;
@@ -1366,61 +1375,111 @@ static void rcu_torture_enable_rt_throttle(void)
 	old_rt_runtime = -1;
 }
 
-static bool rcu_torture_boost_failed(unsigned long gp_state, unsigned long *start)
+struct rcu_torture_boost_reader {
+	struct completion done;
+	bool in_cs;	// Reader is inside its RCU read-side critical section.
+	bool finished;	// Reader consumed all of its CPU time.
+	bool abort;	// Hog asks the reader to give up.
+	u64 ran_ns;	// CPU time consumed so far.
+};
+
+// Reader CPU time so far, retrying to avoid torn 64-bit loads on 32-bit.
+static u64 rcu_torture_boost_runtime(void)
+{
+	u64 a, b;
+
+	do {
+		a = READ_ONCE(current->se.sum_exec_runtime);
+		b = READ_ONCE(current->se.sum_exec_runtime);
+	} while (a != b);
+	return a;
+}
+
+static int rcu_torture_boost_reader(void *arg)
+{
+	struct rcu_torture_boost_reader *br = arg;
+	u64 goal = (u64)test_boost_reader_ms * NSEC_PER_MSEC;
+	u64 ran;
+	u64 start;
+	int idx;
+
+	idx = cur_ops->readlock();
+	start = rcu_torture_boost_runtime();
+	WRITE_ONCE(br->in_cs, true);
+	do {
+		cpu_relax();
+		ran = rcu_torture_boost_runtime() - start;
+		WRITE_ONCE(br->ran_ns, ran);
+	} while (ran < goal && !READ_ONCE(br->abort) && !torture_must_stop());
+	// Publish before unlocking: deboosting lets the hog preempt us at once.
+	WRITE_ONCE(br->finished, ran >= goal);
+	cur_ops->readunlock(idx);
+	kthread_complete_and_exit(&br->done, 0);
+}
+
+// Run one boost test on this CPU.
+static void rcu_torture_boost_once(void)
 {
-	int cpu;
 	static int dbg_done;
-	unsigned long end = jiffies;
-	bool gp_done;
-	unsigned long j;
-	static unsigned long last_persist;
-	unsigned long lp;
-	unsigned long mininterval = test_boost_duration * HZ - HZ / 2;
+	struct rcu_torture_boost_reader br = { };
+	unsigned long endtime;
+	unsigned long gp_state = 0;
+	unsigned long start;
+	struct task_struct *t;
+	bool stuttered = false;
 
-	if (end - *start > mininterval) {
-		// Recheck after checking time to avoid false positives.
-		smp_mb(); // Time check before grace-period check.
-		if (cur_ops->poll_gp_state(gp_state))
-			return false; // passed, though perhaps just barely
-		if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, &cpu)) {
-			// At most one persisted message per boost test.
-			j = jiffies;
-			lp = READ_ONCE(last_persist);
-			if (time_after(j, lp + mininterval) &&
-			    cmpxchg(&last_persist, lp, j) == lp) {
-				if (cpu < 0)
-					pr_info("Boost inversion persisted: QS from all CPUs\n");
-				else
-					pr_info("Boost inversion persisted: No QS from CPU %d\n", cpu);
-			}
-			return false; // passed on a technicality
+	init_completion(&br.done);
+	t = kthread_run_on_cpu(rcu_torture_boost_reader, &br, raw_smp_processor_id(),
+			       "rcu_torture_boost_rdr_%u");
+	if (IS_ERR(t)) {
+		n_rcu_torture_boost_ktrerror++;
+		return;
+	}
+
+	// Wait for the reader to enter its critical section, then start
+	// a grace period that it will block.
+	start = jiffies;
+	while (!READ_ONCE(br.in_cs) && !torture_must_stop() &&
+	       time_before(jiffies, start + HZ))
+		schedule_timeout_uninterruptible(1);
+	if (!READ_ONCE(br.in_cs))
+		goto out;
+	gp_state = cur_ops->start_gp_poll();
+
+	// Hog the CPU until the reader finishes or the interval ends.
+	start = jiffies;
+	endtime = start + test_boost_duration * HZ;
+	while (!READ_ONCE(br.finished) && time_before(jiffies, endtime) &&
+	       !torture_must_stop()) {
+		if (stutter_wait("rcu_torture_boost")) {
+			sched_set_fifo_low(current);
+			stuttered = true;
+			break;
 		}
+		cpu_relax();
+	}
+
+	smp_mb(); // Time check before reader check.
+	if (!READ_ONCE(br.finished) && !stuttered && !torture_must_stop()) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost boosting failed");
 		n_rcu_torture_boost_failure++;
+		pr_info("Boost inversion: reader got only %llu of %d ms CPU in %lu jiffies, GP %s.\n",
+			div64_ul(READ_ONCE(br.ran_ns), NSEC_PER_MSEC), test_boost_reader_ms,
+			jiffies - start,
+			cur_ops->poll_gp_state(gp_state) ? "ended" : "still pending");
 		if (!xchg(&dbg_done, 1) && cur_ops->gp_kthread_dbg) {
 			pr_info("Boost inversion thread ->rt_priority %u gp_state %lu jiffies %lu\n",
-				current->rt_priority, gp_state, end - *start);
+				current->rt_priority, gp_state, jiffies - start);
 			cur_ops->gp_kthread_dbg();
-			// Recheck after print to flag grace period ending during splat.
-			gp_done = cur_ops->poll_gp_state(gp_state);
-			pr_info("Boost inversion: GP %lu %s.\n", gp_state,
-				gp_done ? "ended already" : "still pending");
-
 		}
-
-		return true; // failed
-	} else if (cur_ops->check_boost_failed && !cur_ops->check_boost_failed(gp_state, NULL)) {
-		*start = jiffies;
 	}
-
-	return false; // passed
+out:
+	WRITE_ONCE(br.abort, true);
+	wait_for_completion(&br.done);
 }
 
 static int rcu_torture_boost(void *arg)
 {
-	unsigned long endtime;
-	unsigned long gp_state;
-	unsigned long gp_state_time;
 	unsigned long oldstarttime;
 	unsigned long booststarttime = get_torture_init_jiffies() + test_boost_holdoff * HZ;
 
@@ -1441,9 +1500,6 @@ static int rcu_torture_boost(void *arg)
 
 	/* Each pass through the following loop does one boost-test cycle. */
 	do {
-		bool failed = false; // Test failed already in this test interval
-		bool gp_initiated = false;
-
 		if (kthread_should_stop())
 			goto checkwait;
 
@@ -1457,33 +1513,9 @@ static int rcu_torture_boost(void *arg)
 				goto checkwait;
 		}
 
-		// Do one boost-test interval.
-		endtime = oldstarttime + test_boost_duration * HZ;
-		while (time_before(jiffies, endtime)) {
-			// Has current GP gone too long?
-			if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-				failed = rcu_torture_boost_failed(gp_state, &gp_state_time);
-			// If we don't have a grace period in flight, start one.
-			if (!gp_initiated || cur_ops->poll_gp_state(gp_state)) {
-				gp_state = cur_ops->start_gp_poll();
-				gp_initiated = true;
-				gp_state_time = jiffies;
-			}
-			if (stutter_wait("rcu_torture_boost")) {
-				sched_set_fifo_low(current);
-				// If the grace period already ended,
-				// we don't know when that happened, so
-				// start over.
-				if (cur_ops->poll_gp_state(gp_state))
-					gp_initiated = false;
-			}
-			if (torture_must_stop())
-				goto checkwait;
-		}
-
-		// In case the grace period extended beyond the end of the loop.
-		if (gp_initiated && !failed && !cur_ops->poll_gp_state(gp_state))
-			rcu_torture_boost_failed(gp_state, &gp_state_time);
+		// Do one boost-test interval, if no other CPU claimed it.
+		if (xchg(&boost_claimed, oldstarttime) != oldstarttime)
+			rcu_torture_boost_once();
 
 		/*
 		 * Set the start time of the next test interval.
@@ -5151,6 +5183,10 @@ rcu_torture_init(void)
 		test_boost_interval = 1;
 	if (test_boost_duration < 2)
 		test_boost_duration = 2;
+	if (test_boost_reader_ms < 1)
+		test_boost_reader_ms = 1;
+	if (test_boost_reader_ms > test_boost_duration * MSEC_PER_SEC)
+		test_boost_reader_ms = test_boost_duration * MSEC_PER_SEC;
 	if (rcu_torture_can_boost()) {
 
 		boost_starttime = jiffies + test_boost_interval * HZ;
-- 
2.54.0

