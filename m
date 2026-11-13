Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531487;
	b=KnYO+o/PduZ334r1xUzDEQ4cduU49N9t2r/UXm84HZcRRMfJyHm0WpYl4rjWqCvhnbqR
	 52nN+sZZrrKXSyWprMRKuQXGenQsIHjQxETgQBG/HeSztixlZ30/XTCmfDek8A1mmsfes
	 ICHmeHMG/2jflhPToFzEm7Nk5tn6cQWDmmjX8DyHUotPe6NSU7ZbY3UzDWx4ZHahGfJgM
	 /OIJz2Gy8uRQjXO3tSLzgsC36eoSz2FI+RKCz6Ia55WUsbRHKJ8AvSy0SpV+0nN/0S6M3
	 o4PYQeasw52utH1KpOeyCx1WmKOhsbZZL6mb5lR/mEEuDwuITLRfexSzUAiABYBtlUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531487;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iiiJEWiUsmBd6bzNhwIbmOdhxrAsK8Hk8xOItPTxqeY=;
	b=gjw+qKgWoFdLGBiPpxwIQ8w18DDxz4VNGFNoP1a73aiTXGUNnJXctsc/rFHSSYvmvzJl
	 /mY6Y5zKjdx3cd8Qox4uki7l3qoWTiRM6+XyXsR07vpmvur7Hult23ECT66ROEbz+2AhB
	 DyHWuHWwuDsQMWRx7S56AwDk+5/HFOryl2dg8QaAQfDLrBSIR5I+Qy/rXvll0j8YfbHy0
	 XSTMp8oaE42ua4OC3YCLfwAd/dwP6EsXxn4/p9mb40jNxvZt2SP+plG0m0DaNwbg214/m
	 EJucnFRFX20Xdywhmd3Ffddi8vLkeuphZhIGVpyPkmQsmczleGr3B7An4AQG9dZHvqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i73Uglu8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 1CCBD60A2636;
	Fri, 13 Nov 2026 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i73Uglu8
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 700F51F000C4;
	Fri, 13 Nov 2026 00:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531486;
	bh=iiiJEWiUsmBd6bzNhwIbmOdhxrAsK8Hk8xOItPTxqeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i73Uglu8oQNUjRg5BkFkqrJQuXF7SQCCi8cE/4vpIIxjA/EfAMcx8BQ9ObE1kptlO
	 nqEd4TyZW/iQK0cFc2dnr6uJApIh9KokKOSyZ3dA3mS3S0PDMvgEWcvS67JHzMPSzy
	 eIZVzvFFmkdRZo5xBUCqbqGtfCl7vl6sZ/qr4FUd/CxWCLtZfD28J5jkfFzy0rXvzS
	 jagGncMsV2JLRTLbyGWDz1hhc8muTGNWyWrnEHvU6ApXROfuRIBGAYy19OAixRIgR/
	 GeF3F9SRWOvHwT5oglLGlNCh3pqtBWtVMBWC8gvaqMSlX1/L6uTiVbYxsPNB+A9dVh
	 LmBVSEu2gKCzg==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: rcu@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH for-v7.5 08/14] rcuscale: Consolidate per-writer arrays into struct writer_state
Date: Thu, 12 Nov 2026 19:57:35 -0500
Message-ID: <20261113005747.2977123-9-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
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

The writer kthreads keep their state in five parallel arrays indexed by
writer number: writer_tasks, writer_durations, writer_n_durations,
writer_done and writer_freelists.  Each must be allocated, NULL-checked,
freed and cleared separately, and the cleanup path needs several
guards to cope with any one of them being missing.

Collapse them into a single array of struct writer_state, holding the
task pointer, the duration buffer, the measurement count, the done flag
and the existing struct writer_freelist.

This reduces initialization to one allocation and one out-of-memory
check, and cleanup to a single kfree().  As a side effect, this also
fixes a leak: cleanup only ran its frees under "if (writer_tasks)", so
if the writer_tasks allocation failed while a later allocation (for
example writer_durations or writer_n_durations) still succeeded, those
already-allocated arrays were never freed.  With a single allocation,
that partial-allocation state can no longer occur.

Assisted-by: Codex
Fixes: 8704baab9bc8 ("rcutorture: Add RCU grace-period performance tests")
Signed-off-by: Joel Fernandes <jfern@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Tested-by: Bradley Morgan <brads@mainlining.org> # Power10
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 125 ++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 38c75c37a07c..41abf05a14d9 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -115,17 +115,21 @@ struct writer_freelist {
 	struct writer_mblock *ws_mblocks;
 };
 
+struct writer_state {
+	struct writer_freelist wst_fl;
+	struct task_struct *wst_task;
+	u64 *wst_durations;
+	int wst_n_durations;
+	bool wst_done;
+};
+
 static int nrealreaders;
 static int nrealwriters;
 static int nrealexp;
-static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
 static struct task_struct **exp_tasks;
 
-static u64 **writer_durations;
-static bool *writer_done;
-static struct writer_freelist *writer_freelists;
-static int *writer_n_durations;
+static struct writer_state *writer_states;
 static atomic_t n_rcu_scale_reader_started;
 static atomic_t n_rcu_scale_writer_started;
 static atomic_t n_rcu_scale_writer_finished;
@@ -504,9 +508,9 @@ static struct writer_mblock *rcu_scale_alloc(long me)
 	struct writer_freelist *wflp;
 	struct writer_mblock *wmbp;
 
-	if (WARN_ON_ONCE(!writer_freelists))
+	if (WARN_ON_ONCE(!writer_states))
 		return NULL;
-	wflp = &writer_freelists[me];
+	wflp = &writer_states[me].wst_fl;
 	if (llist_empty(&wflp->ws_lhp)) {
 		// ->ws_lhp is private to its rcu_scale_writer task.
 		wmbp = container_of(llist_del_all(&wflp->ws_lhg), struct writer_mblock, wmb_node);
@@ -560,8 +564,9 @@ rcu_scale_writer(void *arg)
 	u64 t;
 	DEFINE_TORTURE_RANDOM(tr);
 	u64 *wdp;
-	u64 *wdpp = writer_durations[me];
-	struct writer_freelist *wflp = &writer_freelists[me];
+	struct writer_state *wsp = &writer_states[me];
+	u64 *wdpp = wsp->wst_durations;
+	struct writer_freelist *wflp = &wsp->wst_fl;
 	struct writer_mblock *wmbp = NULL;
 
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
@@ -631,7 +636,7 @@ rcu_scale_writer(void *arg)
 			started = true;
 		if (!done && i >= MIN_MEAS && time_after(jiffies, jdone)) {
 			done = true;
-			WRITE_ONCE(writer_done[me], true);
+			WRITE_ONCE(wsp->wst_done, true);
 			sched_set_normal(current, 0);
 			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
 				 scale_type, SCALE_FLAG, me, MIN_MEAS);
@@ -649,7 +654,7 @@ rcu_scale_writer(void *arg)
 						cur_ops->get_gp_seq();
 				}
 				if (shutdown_secs) {
-					writer_tasks[me] = NULL;
+					wsp->wst_task = NULL;
 					smp_mb(); /* Assign before wake. */
 					rcu_scale_cleanup();
 					kernel_power_off();
@@ -665,10 +670,10 @@ rcu_scale_writer(void *arg)
 
 			if (!atomic_xchg(&dumped, 1)) {
 				for (i = 0; i < nrealwriters; i++) {
-					if (writer_done[i])
+					if (writer_states[i].wst_done)
 						continue;
 					pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
-					sched_show_task(writer_tasks[i]);
+					sched_show_task(writer_states[i].wst_task);
 				}
 				if (cur_ops->stats)
 					cur_ops->stats();
@@ -676,7 +681,7 @@ rcu_scale_writer(void *arg)
 		}
 		if (!selfreport && time_after(jiffies, jdone + HZ * (70 + me))) {
 			pr_info("%s: Writer %ld self-report: started %d done %d/%d->%d i %d jdone %lu.\n",
-				__func__, me, started, done, writer_done[me], atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
+				__func__, me, started, done, wsp->wst_done, atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
 			selfreport = true;
 		}
 		if (gp_succeeded && started && !alldone && i < MAX_MEAS - 1)
@@ -687,7 +692,7 @@ rcu_scale_writer(void *arg)
 		rcu_scale_free(wmbp);
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max + 1;
+	wsp->wst_n_durations = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -1031,13 +1036,11 @@ rcu_scale_cleanup(void)
 		reader_tasks = NULL;
 	}
 
-	if (writer_tasks) {
+	if (writer_states) {
 		for (i = 0; i < nrealwriters; i++) {
 			torture_stop_kthread(rcu_scale_writer,
-					     writer_tasks[i]);
-			if (!writer_n_durations)
-				continue;
-			j = writer_n_durations[i];
+					     writer_states[i].wst_task);
+			j = writer_states[i].wst_n_durations;
 			pr_alert("%s%s writer %d gps: %d\n",
 				 scale_type, SCALE_FLAG, i, j);
 			ngps += j;
@@ -1051,14 +1054,12 @@ rcu_scale_cleanup(void)
 			 rcuscale_seq_diff(b_rcu_gp_test_finished,
 					   b_rcu_gp_test_started));
 		for (i = 0; i < nrealwriters; i++) {
-			if (!writer_durations)
-				break;
-			if (!writer_n_durations)
-				continue;
-			wdpp = writer_durations[i];
+			struct writer_state *wsp = &writer_states[i];
+
+			wdpp = wsp->wst_durations;
 			if (!wdpp)
 				continue;
-			for (j = 0; j < writer_n_durations[i]; j++) {
+			for (j = 0; j < wsp->wst_n_durations; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
 					scale_type, SCALE_FLAG,
@@ -1066,34 +1067,23 @@ rcu_scale_cleanup(void)
 				if (j % 100 == 0)
 					schedule_timeout_uninterruptible(1);
 			}
-			kfree(writer_durations[i]);
-			if (writer_freelists) {
+			kfree(wdpp);
+			if (wsp->wst_fl.ws_mblocks) {
 				int ctr = 0;
 				struct llist_node *llnp;
-				struct writer_freelist *wflp = &writer_freelists[i];
 
-				if (wflp->ws_mblocks) {
-					llist_for_each(llnp, wflp->ws_lhg.first)
-						ctr++;
-					llist_for_each(llnp, wflp->ws_lhp.first)
-						ctr++;
-					WARN_ONCE(ctr != gp_async_max,
-						  "%s: ctr = %d gp_async_max = %d\n",
-						  __func__, ctr, gp_async_max);
-					kfree(wflp->ws_mblocks);
-				}
+				llist_for_each(llnp, wsp->wst_fl.ws_lhg.first)
+					ctr++;
+				llist_for_each(llnp, wsp->wst_fl.ws_lhp.first)
+					ctr++;
+				WARN_ONCE(ctr != gp_async_max,
+					  "%s: ctr = %d gp_async_max = %d\n",
+					  __func__, ctr, gp_async_max);
+				kfree(wsp->wst_fl.ws_mblocks);
 			}
 		}
-		kfree(writer_tasks);
-		writer_tasks = NULL;
-		kfree(writer_durations);
-		writer_durations = NULL;
-		kfree(writer_n_durations);
-		writer_n_durations = NULL;
-		kfree(writer_done);
-		writer_done = NULL;
-		kfree(writer_freelists);
-		writer_freelists = NULL;
+		kfree(writer_states);
+		writer_states = NULL;
 	}
 
 	/* Do torture-type-specific cleanup operations.  */
@@ -1187,36 +1177,29 @@ rcu_scale_init(void)
 				goto unwind;
 		}
 	}
-	writer_tasks = kzalloc_objs(writer_tasks[0], nrealwriters);
-	writer_durations = kzalloc_objs(*writer_durations, nrealwriters);
-	writer_n_durations = kzalloc_objs(*writer_n_durations, nrealwriters);
-	writer_done = kzalloc_objs(writer_done[0], nrealwriters);
-	if (gp_async) {
-		if (gp_async_max <= 0) {
-			pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
-				__func__, gp_async_max);
-			WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
-			firsterr = -EINVAL;
-			goto unwind;
-		}
-		writer_freelists = kzalloc_objs(writer_freelists[0],
-						nrealwriters);
+	writer_states = kzalloc_objs(writer_states[0], nrealwriters);
+	if (gp_async && gp_async_max <= 0) {
+		pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
+			__func__, gp_async_max);
+		WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
+		firsterr = -EINVAL;
+		goto unwind;
 	}
-	if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done ||
-	    (gp_async && !writer_freelists)) {
+	if (!writer_states) {
 		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
 	for (i = 0; i < nrealwriters; i++) {
-		writer_durations[i] =
-			kzalloc_objs(*writer_durations[i], MAX_MEAS);
-		if (!writer_durations[i]) {
+		struct writer_state *wsp = &writer_states[i];
+
+		wsp->wst_durations = kzalloc_objs(*wsp->wst_durations, MAX_MEAS);
+		if (!wsp->wst_durations) {
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
-		if (writer_freelists) {
-			struct writer_freelist *wflp = &writer_freelists[i];
+		if (gp_async) {
+			struct writer_freelist *wflp = &wsp->wst_fl;
 
 			init_llist_head(&wflp->ws_lhg);
 			init_llist_head(&wflp->ws_lhp);
@@ -1234,7 +1217,7 @@ rcu_scale_init(void)
 			}
 		}
 		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
-						  writer_tasks[i]);
+						  wsp->wst_task);
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
-- 
2.54.0

