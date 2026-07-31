Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BC2F12AC;
	Fri, 31 Jul 2026 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459459; cv=none; b=DbYONuoBA0eJadmZ3Bnwod0ToG674j8HXtbG6TAwyDHj0jNW8I7PO1pSsLH+5MXuh1YmnXXeezNiJyeoN6wmCozjrUx6pEzR0vmiBewKmglYNvLBXJgtGhqJ4ywWjj5+/ucBlGCPLUz9/P/EgSfH3fNlPANIjMZHPWfMfWZvHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459459; c=relaxed/simple;
	bh=6yaACNAX+RwwxA9a4XN/cpfcsOG6aYBuPt5ACPPgKf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9bKOb0o0uRlJDQAY5YwYunTfqJ1M8r7+OdksK19C508dokVfjZQ62DNYSbl2EDMxgdekCKwXV31t2dLkAaUVx5B+IeraMsn3RS+yiearRETOg7HHVwB/Ibnew/LPMrXmHcCmn2GUqY7zDL8XblMI7FKinLENJAcR1wTP3KPHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGM9uucO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGM9uucO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EA21F0155C;
	Fri, 31 Jul 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459454;
	bh=Z4XRmkaW8gQMFR/Q413+T2gtrAOcBrj8MJY193eVErg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGM9uucO1iEolNtaCBQtVaj+AGl9H8eLCnGDFJ+o0o4gvQ7zgHJ0F+TJtI8pNPwkp
	 dYjKYeuFxJdeKm61jltjLu+8lXUPACjmFlYAzwPVkI6567pwDz8uL0zwFaH/AUGJrT
	 eeD9EFWQzroInnFsfg2GY7+qZy7MjJy73YVv1NindEThdIKce6C+/xMcHTc8a/FLjg
	 YbQ/9sJTrEUCQquwSY3MS8+CNSBp/BYw94pwm8txitldMgEO3q5XxBKlOHtColdVYI
	 1QYJdzb0YRfDbyJDWAO+PodnOCBk+sHSSI5F1kQqLrzycU2rqSavnPS1iBHYXPoWdd
	 urCYFaIacXtog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50F7ECE17C1; Thu, 30 Jul 2026 17:57:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Puranjay Mohan <puranjay@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 12/12] rcuscale: Add concurrent expedited GP threads for callback scaling tests
Date: Thu, 30 Jul 2026 17:57:32 -0700
Message-Id: <20260731005732.3530999-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
References: <58bcd561-0520-43ff-95b0-1ed10e1e3bff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 84 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ac0b1c6b7dae20..1097ec15879cb3 100644
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
2.40.1

