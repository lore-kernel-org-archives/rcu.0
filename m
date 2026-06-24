Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7283BBFA7;
	Wed, 24 Jun 2026 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307499; cv=none; b=cA1JnxYaad2M5iqwKpG9DXenuM8bv1D7u9Na3ZtID0patBY+xr8c6ibq4lbTTecQYdpx+KH7xn5+fnD0uQGAhe8+ja2bpOs+McwioRMSMmuUBiB/XFMdpGjjd7DyBKK47aTFBrnPahRncqj9A1ntqbPUtmM2f/+NJBx9GQ0uOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307499; c=relaxed/simple;
	bh=0kLya3k+VVIpsYWTxm6lSxQWALCYgMNoF/suf1lxAwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuDMZLnzKsAK2NjxzJj/0uVytk0TZXUY5kITipmmfzSRNV19cO9tB2/UnbeAMTPaUG5cWmXFmraeXFF0tPpHNNHNsyjAhZeI7sxSPWT1ppUxshVJfhyABxVr/mXhFpdCEr5mUWJZjWN6jByZd3w3jDBlPY5hRxDi1XDgYAzn3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koluJpxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koluJpxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218C51F000E9;
	Wed, 24 Jun 2026 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307498;
	bh=YcJz1fWcVZtHz20h+2QlG+LiUJYgrFqnmq4CreuuzlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koluJpxHYHjheTvISYfaM4mw/5rc4fQbFRp0NgfhJ7fueChmUDb+X8NTO4+b2fSsU
	 HgXeAcY3+qHVMLey6JLDivsny5tVV0RkjbMPC+bzEYGvs5fCGCzmwgGuB0TT43XQAw
	 Q6LucEYugb1i7xQ1Z4wJ6RlIt6ikS24f1KGApkHdgS8pVF1pI3C833Z8Vc32U8262d
	 izdhkUd819ODq76cAMazGQuy+srFA05ts1XhAb3zzDqclsK9XONT95nVjvmRbQY2OH
	 ZcWnaHuIzGo7eaCTrzs+dp6ZtjyKsgGwwEKdM4DL2VIJWjZHTei9dUd94HcjNOPD8y
	 wHJYHfNsUuXlw==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 11/11] rcuscale: Add concurrent expedited GP threads for callback scaling tests
Date: Wed, 24 Jun 2026 06:23:53 -0700
Message-ID: <20260624132356.516959-12-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624132356.516959-1-puranjay@kernel.org>
References: <20260624132356.516959-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nexp and exp_interval parameters to rcuscale that spawn kthreads
running synchronize_rcu_expedited() in a loop. This generates concurrent
expedited GP load while the normal writers measure GP or callback
latency.

When combined with gp_async=1 (which uses call_rcu() for writers), this
tests how effectively callbacks benefit from expedited grace periods.
With RCU callback expedited GP tracking, the async callbacks should
complete faster because they piggyback on the expedited GPs rather than
waiting for normal GPs.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/rcuscale.c | 84 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ac0b1c6b7dae2..1097ec15879cb 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -91,6 +91,8 @@ torture_param(int, shutdown_secs, !IS_MODULE(CONFIG_RCU_SCALE_TEST) * 300,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, writer_holdoff_jiffies, 0, "Holdoff (jiffies) between GPs, zero to disable");
+torture_param(int, nexp, 0, "Number of expedited GP threads to run concurrently");
+torture_param(int, exp_interval, 0, "Interval (us) between expedited GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
@@ -115,8 +117,10 @@ struct writer_freelist {
 
 static int nrealreaders;
 static int nrealwriters;
+static int nrealexp;
 static struct task_struct **writer_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct **exp_tasks;
 
 static u64 **writer_durations;
 static bool *writer_done;
@@ -462,6 +466,34 @@ rcu_scale_reader(void *arg)
 	return 0;
 }
 
+/*
+ * RCU expedited GP kthread.  Repeatedly invokes expedited grace periods
+ * to generate concurrent expedited GP load while the normal-GP writers
+ * are being measured.  This allows measuring the benefit of callbacks
+ * that can piggyback on expedited grace periods.
+ */
+static int
+rcu_scale_exp(void *arg)
+{
+	long me = (long)arg;
+
+	VERBOSE_SCALEOUT_STRING("rcu_scale_exp task started");
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MIN_NICE);
+
+	if (holdoff)
+		schedule_timeout_idle(holdoff * HZ);
+
+	do {
+		if (exp_interval)
+			udelay(exp_interval);
+		cur_ops->exp_sync();
+		rcu_scale_wait_shutdown();
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_scale_exp");
+	return 0;
+}
+
 /*
  * Allocate a writer_mblock structure for the specified rcu_scale_writer
  * task.
@@ -664,8 +696,10 @@ static void
 rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
-		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff, minruntime, nrealreaders, nrealwriters, writer_holdoff, writer_holdoff_jiffies, verbose, shutdown_secs);
+		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d nexp=%d exp_interval=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
+		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff,
+		 minruntime, nrealreaders, nrealwriters, nrealexp, exp_interval,
+		 writer_holdoff, writer_holdoff_jiffies, verbose, shutdown_secs);
 }
 
 /*
@@ -809,6 +843,13 @@ kfree_scale_cleanup(void)
 	if (torture_cleanup_begin())
 		return;
 
+	if (exp_tasks) {
+		for (i = 0; i < nrealexp; i++)
+			torture_stop_kthread(rcu_scale_exp, exp_tasks[i]);
+		kfree(exp_tasks);
+		exp_tasks = NULL;
+	}
+
 	if (kfree_reader_tasks) {
 		for (i = 0; i < kfree_nrealthreads; i++)
 			torture_stop_kthread(kfree_scale_thread,
@@ -903,6 +944,22 @@ kfree_scale_init(void)
 			goto unwind;
 	}
 
+	if (nrealexp > 0 && cur_ops->exp_sync) {
+		exp_tasks = kzalloc_objs(exp_tasks[0], nrealexp);
+		if (!exp_tasks) {
+			SCALEOUT_ERRSTRING("out of memory");
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
+		for (i = 0; i < nrealexp; i++) {
+			firsterr = torture_create_kthread(rcu_scale_exp,
+							  (void *)i,
+							  exp_tasks[i]);
+			if (torture_init_error(firsterr))
+				goto unwind;
+		}
+	}
+
 	while (atomic_read(&n_kfree_scale_thread_started) < kfree_nrealthreads)
 		schedule_timeout_uninterruptible(1);
 
@@ -959,6 +1016,13 @@ rcu_scale_cleanup(void)
 		return;
 	}
 
+	if (exp_tasks) {
+		for (i = 0; i < nrealexp; i++)
+			torture_stop_kthread(rcu_scale_exp, exp_tasks[i]);
+		kfree(exp_tasks);
+		exp_tasks = NULL;
+	}
+
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_scale_reader,
@@ -1076,6 +1140,7 @@ rcu_scale_init(void)
 		if (kthread_tp)
 			kthread_stime = kthread_tp->stime;
 	}
+	nrealexp = nexp;
 	if (kfree_rcu_test)
 		return kfree_scale_init();
 
@@ -1107,6 +1172,21 @@ rcu_scale_init(void)
 	}
 	while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
 		schedule_timeout_uninterruptible(1);
+	if (nrealexp > 0 && cur_ops->exp_sync) {
+		exp_tasks = kzalloc_objs(exp_tasks[0], nrealexp);
+		if (!exp_tasks) {
+			SCALEOUT_ERRSTRING("out of memory");
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
+		for (i = 0; i < nrealexp; i++) {
+			firsterr = torture_create_kthread(rcu_scale_exp,
+							  (void *)i,
+							  exp_tasks[i]);
+			if (torture_init_error(firsterr))
+				goto unwind;
+		}
+	}
 	writer_tasks = kzalloc_objs(writer_tasks[0], nrealwriters);
 	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
 	writer_n_durations = kzalloc_objs(*writer_n_durations, nrealwriters);
-- 
2.53.0-Meta

