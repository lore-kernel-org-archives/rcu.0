Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210701DE89A
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842253; cv=none; b=GBKU6ANwRwlMdD2jJHFlMFNZuJ/49uhxaTxLHPbwOFVnj8zxCX9y4zd6wbHZo8JYVb1TEkIatuhvRpZHezQ+VCItcdRsaUh2kOltrozDw5QxjsKCsBUfZwWqb3QQxoZc3f2L1IwLLtYITL/p+HDczxaBYV2NggNLGU//IaVxEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842253; c=relaxed/simple;
	bh=zoHPkwBwGtruOmM0x6EZYoZDO8zKEm7M8glLRU+YiOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOYNJH/bkVnBhRbOSsEym+EqT0v/lUypgkfeyqBO3/omxNUpVywI94BlgAruHA0ug7aymnJzlCQkBKGq0O5u6iM1j1H4GVRfMMsXnpWQTrZdeZeVrF5tvS7wNIRSCmaoyzYv8RjT8ZzNCaTvhSedoBq8f7Qe5uqaW+heEqbYVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YC2oReaB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YC2oReaB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so6153123a91.1
        for <rcu@vger.kernel.org>; Tue, 29 Jul 2025 19:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753842249; x=1754447049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=66ubHsamEtqUWfBlTghFg/Ipo5QGS23sl8Q6AjMFMf4=;
        b=YC2oReaB6nY5o6y12AoKFVEXjErZV0FMl46xvta/pgBw8ddC4m5sxgY0GLb7hwZUy0
         Q207RQnMI/9hKjyEZiG5DX/v0NPVEyeSjsz9Uu2qsYx9f9BNhlMifOoMPfnbykoG2UM4
         didPE3AZTFGRSKrYMijt/4NbMmYcvoYKCZMIlZqTCBGXGMmQIc8XWBg/gGLc6HyJQTQZ
         Tpu9o1Lw4c7RxvPcVEMT+3xDGQ+/7NkU286hshQU28KcehIRV5UKk7SM9DSKFcvqPkzP
         wyRk4nDnujQhCnBDvWreh/HTv46x4rshp40KRfwBTwfdA51lzpIYlHjboe+hPk5PV2dM
         yzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842249; x=1754447049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66ubHsamEtqUWfBlTghFg/Ipo5QGS23sl8Q6AjMFMf4=;
        b=jdhCCqdq/6nJnwN/0kpJuVgL93dHJHvgz2Le26mSI4ZqbIIgRuFuUbMexqy9edmquc
         FeitWQhb143sCRD4fnaCGi08AlyI7rsNAf8eM2thN/FptuhR8k7YFrNSmsBDWTIXnFu4
         ppRxUHpU1EVioFRgGbHV3FzqRPxt+sK4bCeTsT6pkLiVJbeZ/Qd8Rs7v0q2DDe3r0bXM
         RZbL+2SRrxjJaBG6EJMIraHuQZWi5fGrF1LmLTwO2DHTZZ3yH0bpoiK6YLLzdpYgBUMo
         HbClHSWjgaGlJs7LBRpFpBV501WeNfo6u7D6O915JyKALOuvhmfp8cWjTCfycnCu+F1U
         wrOg==
X-Forwarded-Encrypted: i=1; AJvYcCVXltdDzYhDAv9WR56+OR0Pp+6Z07p8mM84yn4rwW1S/Sdr5h+RhqTtLeakU7qk5su6314=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkllAE/aOSHbxy7pfjJuzBbjP4tMBlGXJ3+wkAuxc+7Cz/asu3
	1ZilijOZX1I6p4tKttCALhAKAOS9oAlcOcm78ho3DYBGY6Zc7kZTXrQAodHgFEyp44w97ouQqhH
	5h4/c1Q==
X-Google-Smtp-Source: AGHT+IFtxe9xMxqmME9I6E6RogvWG3JYyz459sIIvli4kZYQgqRpMMmsSNedqV+8u3MYIRp8qJiKXgKF+ak=
X-Received: from pjk13.prod.google.com ([2002:a17:90b:558d:b0:31c:15c8:4c80])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57e6:b0:31f:313b:4d23
 with SMTP id 98e67ed59e1d1-31f5e3809e4mr2409302a91.20.1753842249538; Tue, 29
 Jul 2025 19:24:09 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:23:46 -0700
In-Reply-To: <20250730022347.71722-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730022347.71722-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730022347.71722-4-yuzhuo@google.com>
Subject: [PATCH v1 3/4] rcuscale: Add file based start/finish control
From: Yuzhuo Jing <yuzhuo@google.com>
To: Ian Rogers <irogers@google.com>, Yuzhuo Jing <yzj@umich.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Frank van der Linden <fvdl@google.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"

In addition to the existing timing-based (holdoff, writer_holdoff)
start control, add file-based controls to debugfs.

This patch adds an option "block_start", which holds all worker threads
until the "rcuscale/should_start" debugfs file is written with a
non-zero integer.  A new "test_complete" file is added to the debugfs
folder, with file content "0" indicating experiment has not finished and
"1" indicating finished.  This is useful for start/finish control by
external test tools.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/rcu/rcuscale.c                         | 79 +++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7b62a84a19d4..5e233e511f81 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5487,6 +5487,11 @@
 
 			Default is 0.
 
+	rcuscale.block_start= [KNL]
+			Block the experiment start until "1" is written to the
+			rcuscale/should_start file in debugfs.  This is useful
+			for start/finish control by external tools.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 7c88d461ed2c..43bcaeac457f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -87,6 +87,7 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 # define RCUSCALE_SHUTDOWN 1
 #endif
 
+torture_param(bool, block_start, false, "Block all threads after creation and wait for should_start");
 torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
 torture_param(int, gp_async_max, 1000, "Max # outstanding waits per writer");
 torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
@@ -146,6 +147,12 @@ static struct dentry *debugfs_writer_durations;
 static struct dentry *debugfs_reader_tasks;
 static struct dentry *debugfs_writer_tasks;
 static struct dentry *debugfs_kfree_tasks;
+static struct dentry *debugfs_should_start;
+static struct dentry *debugfs_test_complete;
+
+static DECLARE_COMPLETION(start_barrier);
+static bool should_start;
+static bool test_complete;
 
 #define MAX_MEAS 10000
 #define MIN_MEAS 100
@@ -457,6 +464,23 @@ static void rcu_scale_wait_shutdown(void)
 		schedule_timeout_uninterruptible(1);
 }
 
+/*
+ * Wait start_barrier if block_start is enabled.  Exit early if shutdown
+ * is requested.
+ *
+ * Return: true if caller should exit; false if caller should continue.
+ */
+static bool wait_start_barrier(void)
+{
+	if (!block_start)
+		return false;
+	while (wait_for_completion_interruptible(&start_barrier)) {
+		if (torture_must_stop())
+			return true;
+	}
+	return false;
+}
+
 /*
  * RCU scalability reader kthread.  Repeatedly does empty RCU read-side
  * critical section, minimizing update-side interference.  However, the
@@ -475,6 +499,11 @@ rcu_scale_reader(void *arg)
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_rcu_scale_reader_started);
 
+	if (wait_start_barrier()) {
+		torture_kthread_stopping("rcu_scale_reader");
+		return 0;
+	}
+
 	do {
 		local_irq_save(flags);
 		idx = cur_ops->readlock();
@@ -560,6 +589,11 @@ rcu_scale_writer(void *arg)
 	current->flags |= PF_NO_SETAFFINITY;
 	sched_set_fifo_low(current);
 
+	if (wait_start_barrier()) {
+		torture_kthread_stopping("rcu_scale_writer");
+		return 0;
+	}
+
 	if (holdoff)
 		schedule_timeout_idle(holdoff * HZ);
 
@@ -755,6 +789,11 @@ kfree_scale_thread(void *arg)
 	set_user_nice(current, MAX_NICE);
 	kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
 
+	if (wait_start_barrier()) {
+		torture_kthread_stopping("kfree_scale_thread");
+		return 0;
+	}
+
 	start_time = ktime_get_mono_fast_ns();
 
 	if (atomic_inc_return(&n_kfree_scale_thread_started) >= kfree_nrealthreads) {
@@ -1118,6 +1157,32 @@ static const struct file_operations kfrees_fops = {
 	.release = seq_release,
 };
 
+/*
+ * For the "should_start" writable file, reuse debugfs integer parsing, but
+ * override write function to also send complete_all if should_start is
+ * changed to 1.
+ *
+ * Any non-zero value written to this file is converted to 1.
+ */
+static int should_start_set(void *data, u64 val)
+{
+	*(bool *)data = !!val;
+
+	if (block_start && !!val)
+		complete_all(&start_barrier);
+
+	return 0;
+}
+
+static int bool_get(void *data, u64 *val)
+{
+	*val = *(bool *)data;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(should_start_fops, bool_get, should_start_set, "%llu");
+DEFINE_DEBUGFS_ATTRIBUTE(test_complete_fops, bool_get, NULL, "%llu");
+
 /*
  * Create an rcuscale directory exposing run states and results.
  */
@@ -1153,6 +1218,15 @@ static int register_debugfs(void)
 			debugfs_dir, NULL, &kfrees_fops))
 		goto fail;
 
+	if (try_create_file(debugfs_should_start, "should_start", 0644,
+			debugfs_dir, &should_start, &should_start_fops))
+		goto fail;
+
+	/* Future: add notification method for readers waiting on file change. */
+	if (try_create_file(debugfs_test_complete, "test_complete", 0444,
+			debugfs_dir, &test_complete, &test_complete_fops))
+		goto fail;
+
 	return 0;
 fail:
 	pr_err("rcu-scale: Failed to create debugfs file.");
@@ -1176,6 +1250,8 @@ do {						\
 	try_remove(debugfs_reader_tasks);
 	try_remove(debugfs_writer_tasks);
 	try_remove(debugfs_kfree_tasks);
+	try_remove(debugfs_should_start);
+	try_remove(debugfs_test_complete);
 
 	/* Remove directory after files. */
 	try_remove(debugfs_dir);
@@ -1372,6 +1448,9 @@ rcu_scale_init(void)
 	atomic_set(&n_rcu_scale_writer_finished, 0);
 	rcu_scale_print_module_parms(cur_ops, "Start of test");
 
+	if (!block_start)
+		should_start = true;
+
 	/* Start up the kthreads. */
 
 	if (shutdown) {
-- 
2.50.1.552.g942d659e1b-goog

