Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434661F872D;
	Thu, 16 Jul 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161097; cv=none; b=ZOMQsgfSBjT2HP513OgzE8ZAb/zxy42aBxPO/dpegl0mYzKRtsQEENxIuC7fChGF2eg+JYG+O+QLLJB8L62NSWBoPxnCvON3DcU/GuVykxlLqcgVvktudcAonsohOHZX6vpsAAvWtevcj6OESXbiIdZ+JVLoiuQSRqHfYDCEqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161097; c=relaxed/simple;
	bh=ShaFJLZTzZkuuouNZqg1D0xWB0Hi657+jMGET9iDMjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rv9LdWY8PddbtQHj2iTBLq9nWwdRF7I22/kP5R4tJMOwpKwM169MHh3XA9foTXcZ3+9d9O7WbPbRrA4rK9Uwg13uw5d6fXFA+Tadq+ANb2l3X29WVZ0ntb1DdvI8/1egs57vu1GBUiBWrromSsVpqsVyawJ2PwryiDFfdh7COqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUcPbs+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUcPbs+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8541F0155D;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=xjkbRlOLknSaMSCbByQmhZguL3vIQRJh7+dw3pDUs6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUcPbs+2cSLctJFMpGIsZhkWGQcAGiat7bNMyGasv8r0gONKNN8ewauovAtvYoAir
	 OTBm2tOdoXwSlAhK8utI6TI0UIE5PWBvOxrCNLq+Ftuz4eSY18DJYzj8YhOa4ejL7b
	 WnSOKHVO3anYu4bgv40sAoHdUMUpwgJwEA9NRDrT4ofannaqel/jgxeXYOzG201RqT
	 edLtNkBc9YQ4IRlqcOttXTJDU6b+iKZZVMO1ZzBUPYBuqcZ/ccP57vyVx14nTERbW9
	 5Qao6ZOREyDgbuvpJSRfuHPqE/VPscjtzUcCvWCpO1R6ndptJjpmCo/9LaaU5PqxKo
	 /vrobmckrU5XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3BD04CE0E86; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 10/24] hazptrtorture: Add kthread to release deferred hazard pointers
Date: Wed, 15 Jul 2026 17:17:55 -0700
Message-Id: <20260716001809.11084-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
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
---
 kernel/rcu/hazptrtorture.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 3d559cfb85816d..de2b4e45d9599a 100644
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
@@ -525,12 +606,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
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
@@ -579,6 +662,7 @@ hazptr_torture_cleanup(void)
 		return;
 	}
 
+	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
 	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
 	torture_stop_kthread(hazptr_torture_writer, writer_task);
 
@@ -667,6 +751,12 @@ static int __init hazptr_torture_init(void)
 
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

