Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7A136E30;
	Fri, 16 Aug 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791899; cv=none; b=goFtkzc293zGELoXqWOQihDsTg32iyLembZTBdwyl0gFOdV2XHdMC3IYDau+d+MEv0/jNB+t95jy41XhR4t6paPVLkP2kX/+dJaiMd4BugXTNdNvHCPT7eH+9J+9u6rhbT5Z1lrpzbGADGlOYWZJ8YQwsct9kpy72391TIjAryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791899; c=relaxed/simple;
	bh=geQJg3YD9qfSjT0GW6Ak27p78kCmBFeReYEfLDCVq64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh9I/0aaTGNiaZE+X5QUX5U0QquSKYTfXH1jBv17VZxlZAA5IXYqJsRw1nX4dlrPhLTw90ON2MauEFblXM/JPMnqmi7B4P53XmuPHbMOJwv/IK5c+DN1X1ebkJTHG8ZPSmAE4sHRFLMuB5+gUAR4TZQLkxIpEZm5wRWo23Xg/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALIDhqg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALIDhqg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70025C4AF09;
	Fri, 16 Aug 2024 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791898;
	bh=geQJg3YD9qfSjT0GW6Ak27p78kCmBFeReYEfLDCVq64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALIDhqg9aEB7Zji6gTjqPHwkEu1Q31xsj8rtIqOfrWl9Oq5aTId2bHlrlTvwaQ1on
	 G8+DMI6XL6uklFxLiRN+KtkDpa9HyK3MB/h9OXrhKerqkMsmBhPSpPHmrqJnJ25Cok
	 HH2zWtwJQ3eGuDT2JDQMdic5Do2qvt89bD+bDPlCr/BPSwqyuMXfHVHrTaIZcPodpZ
	 JMH52AGh3MEgBjyV/1Vu6z6irScE7Uk6Ro8J5V6+wZvprkswwTTWOlmHeNsMQWbXr2
	 Yi7GCnVCPx9B1sLDtFZt9UsGoYosOtaI0cj2lUK20w4QPg47gVfr25jfJrhn+cpge9
	 LJMh4nfykgjzg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 11/14] rcuscale: Use special allocator for rcu_scale_writer()
Date: Fri, 16 Aug 2024 12:32:53 +0530
Message-Id: <20240816070256.60993-11-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_scale_writer() function needs only a fixed number of rcu_head
structures per kthread, which means that a trivial allocator suffices.
This commit therefore uses an llist-based allocator using a fixed array of
structures per kthread.  This allows aggressive testing of RCU performance
without stressing the slab allocators.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 123 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 113 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 80518662273b..bc7cca979c06 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -105,6 +105,19 @@ static char *scale_type = "rcu";
 module_param(scale_type, charp, 0444);
 MODULE_PARM_DESC(scale_type, "Type of RCU to scalability-test (rcu, srcu, ...)");
 
+// Structure definitions for custom fixed-per-task allocator.
+struct writer_mblock {
+	struct rcu_head wmb_rh;
+	struct llist_node wmb_node;
+	struct writer_freelist *wmb_wfl;
+};
+
+struct writer_freelist {
+	struct llist_head ws_lhg;
+	struct llist_head ____cacheline_internodealigned_in_smp ws_lhp;
+	struct writer_mblock *ws_mblocks;
+};
+
 static int nrealreaders;
 static int nrealwriters;
 static struct task_struct **writer_tasks;
@@ -113,6 +126,7 @@ static struct task_struct *shutdown_task;
 
 static u64 **writer_durations;
 static bool *writer_done;
+static struct writer_freelist *writer_freelists;
 static int *writer_n_durations;
 static atomic_t n_rcu_scale_reader_started;
 static atomic_t n_rcu_scale_writer_started;
@@ -463,13 +477,52 @@ rcu_scale_reader(void *arg)
 	return 0;
 }
 
+/*
+ * Allocate a writer_mblock structure for the specified rcu_scale_writer
+ * task.
+ */
+static struct writer_mblock *rcu_scale_alloc(long me)
+{
+	struct llist_node *llnp;
+	struct writer_freelist *wflp;
+	struct writer_mblock *wmbp;
+
+	if (WARN_ON_ONCE(!writer_freelists))
+		return NULL;
+	wflp = &writer_freelists[me];
+	if (llist_empty(&wflp->ws_lhp)) {
+		// ->ws_lhp is private to its rcu_scale_writer task.
+		wmbp = container_of(llist_del_all(&wflp->ws_lhg), struct writer_mblock, wmb_node);
+		wflp->ws_lhp.first = &wmbp->wmb_node;
+	}
+	llnp = llist_del_first(&wflp->ws_lhp);
+	if (!llnp)
+		return NULL;
+	return container_of(llnp, struct writer_mblock, wmb_node);
+}
+
+/*
+ * Free a writer_mblock structure to its rcu_scale_writer task.
+ */
+static void rcu_scale_free(struct writer_mblock *wmbp)
+{
+	struct writer_freelist *wflp;
+
+	if (!wmbp)
+		return;
+	wflp = wmbp->wmb_wfl;
+	llist_add(&wmbp->wmb_node, &wflp->ws_lhg);
+}
+
 /*
  * Callback function for asynchronous grace periods from rcu_scale_writer().
  */
 static void rcu_scale_async_cb(struct rcu_head *rhp)
 {
+	struct writer_mblock *wmbp = container_of(rhp, struct writer_mblock, wmb_rh);
+
 	atomic_dec(this_cpu_ptr(&n_async_inflight));
-	kfree(rhp);
+	rcu_scale_free(wmbp);
 }
 
 /*
@@ -482,13 +535,13 @@ rcu_scale_writer(void *arg)
 	int i_max;
 	unsigned long jdone;
 	long me = (long)arg;
-	struct rcu_head *rhp = NULL;
 	bool selfreport = false;
 	bool started = false, done = false, alldone = false;
 	u64 t;
 	DEFINE_TORTURE_RANDOM(tr);
 	u64 *wdp;
 	u64 *wdpp = writer_durations[me];
+	struct writer_mblock *wmbp = NULL;
 
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
 	WARN_ON(!wdpp);
@@ -529,17 +582,18 @@ rcu_scale_writer(void *arg)
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
 		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
-			if (!rhp)
-				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
-			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
+			if (!wmbp)
+				wmbp = rcu_scale_alloc(me);
+			if (wmbp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
 				atomic_inc(this_cpu_ptr(&n_async_inflight));
-				cur_ops->async(rhp, rcu_scale_async_cb);
-				rhp = NULL;
+				cur_ops->async(&wmbp->wmb_rh, rcu_scale_async_cb);
+				wmbp = NULL;
 				gp_succeeded = true;
 			} else if (!kthread_should_stop()) {
 				cur_ops->gp_barrier();
 			} else {
-				kfree(rhp); /* Because we are stopping. */
+				rcu_scale_free(wmbp); /* Because we are stopping. */
+				wmbp = NULL;
 			}
 		} else if (gp_exp) {
 			cur_ops->exp_sync();
@@ -607,6 +661,7 @@ rcu_scale_writer(void *arg)
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
 	if (gp_async && cur_ops->async) {
+		rcu_scale_free(wmbp);
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max + 1;
@@ -970,12 +1025,30 @@ rcu_scale_cleanup(void)
 					schedule_timeout_uninterruptible(1);
 			}
 			kfree(writer_durations[i]);
+			if (writer_freelists) {
+				int ctr = 0;
+				struct llist_node *llnp;
+				struct writer_freelist *wflp = &writer_freelists[i];
+
+				if (wflp->ws_mblocks) {
+					llist_for_each(llnp, wflp->ws_lhg.first)
+						ctr++;
+					llist_for_each(llnp, wflp->ws_lhp.first)
+						ctr++;
+					WARN_ONCE(ctr != gp_async_max,
+						  "%s: ctr = %d gp_async_max = %d\n",
+						  __func__, ctr, gp_async_max);
+					kfree(wflp->ws_mblocks);
+				}
+			}
 		}
 		kfree(writer_tasks);
 		kfree(writer_durations);
 		kfree(writer_n_durations);
 		kfree(writer_done);
 		writer_done = NULL;
+		kfree(writer_freelists);
+		writer_freelists = NULL;
 	}
 
 	/* Do torture-type-specific cleanup operations.  */
@@ -1002,8 +1075,9 @@ rcu_scale_shutdown(void *arg)
 static int __init
 rcu_scale_init(void)
 {
-	long i;
 	int firsterr = 0;
+	long i;
+	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
@@ -1074,7 +1148,18 @@ rcu_scale_init(void)
 	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
 	writer_n_durations = kcalloc(nrealwriters, sizeof(*writer_n_durations), GFP_KERNEL);
 	writer_done = kcalloc(nrealwriters, sizeof(writer_done[0]), GFP_KERNEL);
-	if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done) {
+	if (gp_async) {
+		if (gp_async_max <= 0) {
+			pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
+				__func__, gp_async_max);
+			WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
+			firsterr = -EINVAL;
+			goto unwind;
+		}
+		writer_freelists = kcalloc(nrealwriters, sizeof(writer_freelists[0]), GFP_KERNEL);
+	}
+	if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done ||
+	    (gp_async && !writer_freelists)) {
 		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
@@ -1087,6 +1172,24 @@ rcu_scale_init(void)
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
+		if (writer_freelists) {
+			struct writer_freelist *wflp = &writer_freelists[i];
+
+			init_llist_head(&wflp->ws_lhg);
+			init_llist_head(&wflp->ws_lhp);
+			wflp->ws_mblocks = kcalloc(gp_async_max, sizeof(wflp->ws_mblocks[0]),
+						   GFP_KERNEL);
+			if (!wflp->ws_mblocks) {
+				firsterr = -ENOMEM;
+				goto unwind;
+			}
+			for (j = 0; j < gp_async_max; j++) {
+				struct writer_mblock *wmbp = &wflp->ws_mblocks[j];
+
+				wmbp->wmb_wfl = wflp;
+				llist_add(&wmbp->wmb_node, &wflp->ws_lhp);
+			}
+		}
 		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
 						  writer_tasks[i]);
 		if (torture_init_error(firsterr))
-- 
2.40.1

