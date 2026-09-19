Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A5329C40;
	Sat, 19 Sep 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776064; cv=none; b=KUd6k8wpj/yTjrkKDqsXbIxzRPlEADL1GzCe3VvLhU/oIrYRzBjqad7YHVPvJFgmrCiNgMbbe9qZlcGRqOguLKKUIw7TaYBF2jQ9bXmlX76GLHfA0kSAEsBqGn02Sgfnlde5AMquvrKHjfcInUFtvIvVEgV3LLxde6k23wVHAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776064; c=relaxed/simple;
	bh=GAAHTHlo4xeUjqVjxYVBRZb63pA9MZtilVC2B0Kd+Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyxoBXsq8B9KfRMztlyLhttkt+9beJUj+48N5Dv5pf9cGKVECcbpSW+WLPX/EjLaahn4TqwgC637y1TU+9xMpJngptc04DPUXwwZefbe7+glfxZRPFZCBCiMLZVWm6KklF+YPFHfKem8nO2RBfbxwfTz49XTdz7XeOt/d3IJ76Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1S/yTdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1S/yTdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD0A1F008A3;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=jy2yXzAhvc3P1OAaUTT/aYkzi1pizPds6FePjMK3Hl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1S/yTdpnaYlcqNyIGd5DtyNY2QkqpggJ+tWQQL1AO3FLHOgeShtmPrBzp7MvIwSF
	 IZSOYIM5EmTmLjaG7/9PaPwos+axeTfI66WEk2zqHTxgZxF99wUxB3t2ow5YIbmJvj
	 V9UowxTuIZAWh7nT2GYzSLn2A/oE61Mjmg4vBAQefu9sibn3cawp9R5DNtvwI95kti
	 +f3VqjQ3QA7dxAU0jTI1Sp3zhsmhUeFfdCd9pNsiRDHfYJxOzJ6m1usOY/F4y85kgu
	 bU1dC1FTyjpz1iT7SD/7RbxcM1koABa/z9XDG5pTVTfrdhMi+puIArecX1z0Yd0/qi
	 zPl1+oql4iNrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65DBCCE0B35; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 10/28] hazptrtorture: Add kthread to release deferred hazard pointers
Date: Fri, 18 Sep 2026 17:00:38 -0700
Message-Id: <20260919000056.3132131-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a kthread to release deferred hazard pointers, which
will be used to test acquiring a hazard pointer in one task and releasing
it in another.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 8672169f7868..97663f22b36f 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -30,6 +30,8 @@ MODULE_DESCRIPTION("Hazard-pointer module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmckrcu@meta.com>");
 
+torture_param(int, kthread_do_pending_ms, -1,
+	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (jiffies), 0=disable");
@@ -50,6 +52,7 @@ static int nrealreaders;
 static struct task_struct *writer_task;
 static struct task_struct *preempt_task;
 static struct task_struct **reader_tasks;
+static struct task_struct *do_pending_task;
 static struct task_struct *stats_task;
 
 #define HAZPTR_TORTURE_PIPE_LEN 10
@@ -74,6 +77,14 @@ static atomic_t n_hazptr_torture_free;
 static atomic_t n_hazptr_torture_error;
 static struct list_head hazptr_torture_removed;
 
+// State for a deferred (AKA pending) hazard pointer
+struct hazptr_pending {
+	struct llist_node hpp_node;
+	struct hazptr_ctx hpp_hc;
+	struct hazptr_torture *hpp_htp;
+};
+static DEFINE_PER_CPU(struct llist_head, hazptr_pending);
+
 static int hazptr_torture_writer_state;
 #define HTWS_FIXED_DELAY	0
 #define HTWS_DELAY		1
@@ -416,6 +427,76 @@ static int hazptr_torture_reader(void *arg)
 	return 0;
 }
 
+/*
+ * Release the specified CPU's set of deferred/pending hazard pointers.
+ */
+static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *trsp)
+{
+	struct hazptr_pending *hppp;
+	struct hazptr_pending *hppp1;
+	struct llist_head *llhp;
+	struct llist_node *llnp;
+
+	llhp = per_cpu_ptr(&hazptr_pending, cpu);
+	llnp = llist_del_all(llhp);
+	if (!llnp)
+		return;
+	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
+		hazptr_torture_reader_tail(&hppp->hpp_hc, hppp->hpp_htp, trsp);
+		kfree(hppp);
+	}
+}
+
+/*
+ * Hazard-pointer release of deferred/pending hazard pointers.
+ */
+static int hazptr_torture_do_pending(void *arg)
+{
+	int cpu = 0;
+	DEFINE_TORTURE_RANDOM(rand);
+
+	VERBOSE_TOROUT_STRING("hazptr_torture_do_pending task started");
+	do {
+		if (stutter_will_wait()) {
+			for_each_possible_cpu(cpu)
+				hazptr_torture_do_one_pending(cpu, &rand);
+		} else {
+			cpu = cpumask_next_wrap(cpu, cpu_possible_mask);
+			hazptr_torture_do_one_pending(cpu, &rand);
+		}
+		if (torture_must_stop())
+			torture_hrtimeout_ms(kthread_do_pending_ms, USEC_PER_MSEC, &rand);
+		// Omit stutter_wait() because this function needs to do cleanup.
+	} while (!torture_must_stop());
+	torture_kthread_stopping("hazptr_torture_do_pending");
+	return 0;
+}
+
+/*
+ * Spawn hazptr_torture_do_pending() if there is something for it to do.
+ */
+static int hazptr_torture_do_pending_init(void)
+{
+	if (kthread_do_pending_ms == -1)
+		kthread_do_pending_ms = cur_ops->onstack_ctx ? 0 : 3;
+	if (kthread_do_pending_ms < 0) {
+		pr_alert("Cannot have negative kthread_do_pending_ms, disabling deferral.\n");
+		goto err_out;
+	}
+	if (cur_ops->onstack_ctx && kthread_do_pending_ms) {
+		pr_alert("Cannot defer onstack hazptr_ctx, disabling deferral.\n");
+		goto err_out;
+	}
+	if (!kthread_do_pending_ms)
+		return 0;
+	return torture_create_kthread(hazptr_torture_do_pending, NULL, do_pending_task);
+
+err_out:
+	WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
+	kthread_do_pending_ms = 0;
+	return 0;
+}
+
 /*
  * Print torture statistics.  Caller must ensure that there is only one
  * call to this function at a given time!!!  This is normally accomplished
@@ -524,12 +605,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 {
 	pr_alert("%s" TORTURE_FLAG
 		 "--- %s: nreaders=%d "
+		 "kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
+		 kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
 		 reader_sleep_us,
@@ -578,6 +661,7 @@ hazptr_torture_cleanup(void)
 		return;
 	}
 
+	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
 	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
 	torture_stop_kthread(hazptr_torture_writer, writer_task);
 
@@ -666,6 +750,12 @@ static int __init hazptr_torture_init(void)
 
 	/* Start up the kthreads. */
 
+	// This must be before the readers in order to set up the module
+	// parameters used by the readers.
+	firsterr = hazptr_torture_do_pending_init();
+	if (torture_init_error(firsterr))
+		goto unwind;
+
 	reader_tasks = kzalloc_objs(reader_tasks[0], nrealreaders);
 	for (i = 0; i < nrealreaders; i++) {
 		firsterr = torture_create_kthread(hazptr_torture_reader, (void *)i,
-- 
2.40.1

