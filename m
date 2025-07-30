Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F15187FEC
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842248; cv=none; b=JnNCA0+6jRU88FRK9d7yABPaCHpNlZPMlH28/RMjjhasHu14r4pvnSjtCXkFFzWA2FZQBvoA1JDVnFHpSFa9LRlW88i4dS1i2e3QO08RVD9EXtQ+qENQraOGCjQ9IID+BhGjK2fF7XYGT23giHIO7I/ZwNdJk3wovOWscTLylx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842248; c=relaxed/simple;
	bh=nS5WfiJyDN++X6i4GiHHq5GyaBNmUkSAVJNYFeAMNTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wc+hdUYJDXuKDE49TJAx2dToZGG2PV6sCWx4NeJLk9TBbcyRVhKuZRqplQMJsYnZlTyVLx6cVX0F/QfKbu9MaG5SP8Q/BBddXPWrKrG1Kh47vXEhalLwXhPpjCd/QlU+z/x8rcG3Rb7C23EHJKCKjULdWYnSSrRqw8Gu0i2eaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3BS8FYHY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3BS8FYHY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3ba7659210so4073655a12.2
        for <rcu@vger.kernel.org>; Tue, 29 Jul 2025 19:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753842246; x=1754447046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSnVBVITeOzZAfMv7RC5y4cK3Twu/w5tupUEloHTubA=;
        b=3BS8FYHYNA83lJiFLyPLKNW0+Mld0mPVXquHzfZrAhRG06kpILinyxgx3rthTsoyB1
         W2EKRFBhTMfwNsQEbGA2LCuRJp+EaDNUB22gEfP7C9wV8QoEQ7sFLUe3j/FMufvNDgBM
         S6a5QnY63EhlmVkrkVAaZC/mIesAdcLE6cX6JuSJOrTqHkyV3eZr1M+LfMcNno4cTmMX
         OyxygtLuwEG7Yv/UrhfDqnJMaRokTaUtT1SBLYnbZDNjlpWpeRuxc44gwfDpRK0pctCs
         Daibxpn6vFjBtm2zBJuNeWWRiuQuhes9cIt5cP5PbGH63UlXMGWJWLDeibKV4Pz7gf8P
         C04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842246; x=1754447046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSnVBVITeOzZAfMv7RC5y4cK3Twu/w5tupUEloHTubA=;
        b=AP+G+hpA94GyP7vos5JmHwST/QHMPxnOzLzVGAo/HxYMKbiZiZAHHudjeie/y+XJ3Q
         JW76e9nELn4eVVjciAWBSi+i/yDXORqIXTZcFDtr925rvsahM4MTEsOY1DU8Hr35ZwzG
         y131lBodt3H+HEgshxBo5mmrcyro/Nk5rpb1ua95Z1Gxr54ShJdIDt5/732XBxixmPwX
         pqcUOEZ/JcvYMhbA6av+vCAzEV1tM8QOCJqTUv+FV1hQlmAkHTkQbw6BW9u5dk0wIYdB
         w7bfd+d0Wx9ODvOc2uvlM35BTmW5pwJBSHWA9wtRNmZj0FZnRArHs/dXcRKJJcO7sfJy
         629g==
X-Forwarded-Encrypted: i=1; AJvYcCU17g0/yHIOXeGLQ1k4e9G4f8ZftW3/BrMH+qN/rDY9I9lqkwUQcl7o7EzjV9CPQRhOVWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZItnzTV2sV9dsGDWA3WNsQtQlLHypPk+8PnkKvsxsNqUviEm1
	xNiVJ5nP1P2+1jjzDSq/oODCXHJBC6XTG4R+rKfKBxorLd/ECMdLlQ4hliBLSgkcH2Kv+9pArPo
	ImAKNnA==
X-Google-Smtp-Source: AGHT+IHoQsKozsPlh4E8P2d5oMA0zeGN4kDg69cefdHKKRDMh6Tt1jgzcPFhnMiLARA1JMxVUy4YUoynsJM=
X-Received: from pfbic11.prod.google.com ([2002:a05:6a00:8a0b:b0:756:c6cf:2462])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0c:b0:234:cd25:735
 with SMTP id adf61e73a8af0-23dc0e967afmr2202881637.38.1753842245632; Tue, 29
 Jul 2025 19:24:05 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:23:44 -0700
In-Reply-To: <20250730022347.71722-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730022347.71722-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730022347.71722-2-yuzhuo@google.com>
Subject: [PATCH v1 1/4] rcuscale: Create debugfs file for writer durations
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

Creates an "rcuscale" folder in debugfs and creates a "writer_durations"
file in the folder.  This file is in CSV format.  Each line represents
one duration record, with columns defined as:

  writer_id,duration

Added an option "writer_no_print" to skip printing writer durations on
cleanup.

This allows external tools to read structured data and also drastically
improves cleanup performance on large core count machines.

On a 256C 512T machines running nreaders=1 nwriters=511:

Before:
$ time modprobe -r rcuscale; modprobe -r torture
real    3m17.349s
user    0m0.000s
sys     3m15.288s

After:
$ time cat /sys/kernel/debug/rcuscale/writer_durations > durations.csv
real    0m0.005s
user    0m0.000s
sys     0m0.005s
$ time modprobe -r rcuscale; modprobe -r torture
real    0m0.388s
user    0m0.000s
sys     0m0.335s

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 .../admin-guide/kernel-parameters.txt         |   5 +
 kernel/rcu/rcuscale.c                         | 142 +++++++++++++++++-
 2 files changed, 139 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..7b62a84a19d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5583,6 +5583,11 @@
 			periods, but in jiffies.  The default of zero
 			says no holdoff.
 
+	rcuscale.writer_no_print= [KNL]
+			Do not print writer durations to kernel ring buffer.
+			Instead, users can read them from the
+			rcuscale/writer_durations file in debugfs.
+
 	rcutorture.fqs_duration= [KNL]
 			Set duration of force_quiescent_state bursts
 			in microseconds.
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index b521d0455992..ad10b42be6fc 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -40,6 +40,8 @@
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/sched/debug.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #include "rcu.h"
 
@@ -97,6 +99,7 @@ torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, writer_holdoff_jiffies, 0, "Holdoff (jiffies) between GPs, zero to disable");
+torture_param(bool, writer_no_print, false, "Do not print writer durations to ring buffer");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
@@ -138,6 +141,9 @@ static u64 t_rcu_scale_writer_finished;
 static unsigned long b_rcu_gp_test_started;
 static unsigned long b_rcu_gp_test_finished;
 
+static struct dentry *debugfs_dir;
+static struct dentry *debugfs_writer_durations;
+
 #define MAX_MEAS 10000
 #define MIN_MEAS 100
 
@@ -607,6 +613,7 @@ rcu_scale_writer(void *arg)
 		t = ktime_get_mono_fast_ns();
 		*wdp = t - *wdp;
 		i_max = i;
+		writer_n_durations[me] = i_max + 1;
 		if (!started &&
 		    atomic_read(&n_rcu_scale_writer_started) >= nrealwriters)
 			started = true;
@@ -620,6 +627,7 @@ rcu_scale_writer(void *arg)
 			    nrealwriters) {
 				schedule_timeout_interruptible(10);
 				rcu_ftrace_dump(DUMP_ALL);
+				WRITE_ONCE(test_complete, true);
 				SCALEOUT_STRING("Test complete");
 				t_rcu_scale_writer_finished = t;
 				if (gp_exp) {
@@ -666,7 +674,6 @@ rcu_scale_writer(void *arg)
 		rcu_scale_free(wmbp);
 		cur_ops->gp_barrier();
 	}
-	writer_n_durations[me] = i_max + 1;
 	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
@@ -941,6 +948,117 @@ kfree_scale_init(void)
 	return firsterr;
 }
 
+/*
+ * A seq_file for writer_durations.  Content is only visible when all writers
+ * finish.  Element i of the sequence is writer_durations + i.
+ */
+static void *writer_durations_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t writer_id = *pos;
+
+	if (!test_complete || writer_id < 0 || writer_id >= nrealwriters)
+		return NULL;
+
+	return writer_durations + writer_id;
+}
+
+static void *writer_durations_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return writer_durations_start(m, pos);
+}
+
+static void writer_durations_stop(struct seq_file *m, void *v)
+{
+}
+
+/*
+ * Each element in the seq_file is an array of one writer's durations.
+ * Each element prints writer_n_durations[writer_id] lines, and each line
+ * contains one duration record, in CSV format:
+ * writer_id,duration
+ */
+static int writer_durations_show(struct seq_file *m, void *v)
+{
+	u64 **durations = v;
+	loff_t writer_id = durations - writer_durations;
+
+	for (int i = 0; i < writer_n_durations[writer_id]; ++i)
+		seq_printf(m, "%lld,%lld\n", writer_id, durations[0][i]);
+
+	return 0;
+}
+
+static const struct seq_operations writer_durations_op = {
+	.start	= writer_durations_start,
+	.next	= writer_durations_next,
+	.stop	= writer_durations_stop,
+	.show	= writer_durations_show
+};
+
+static int writer_durations_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &writer_durations_op);
+}
+
+static const struct file_operations writer_durations_fops = {
+	.owner = THIS_MODULE,
+	.open = writer_durations_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+/*
+ * Create an rcuscale directory exposing run states and results.
+ */
+static int register_debugfs(void)
+{
+#define try_create_file(variable, name, mode, parent, data, fops)		\
+({										\
+	variable = debugfs_create_file((name), (mode), (parent), (data), (fops)); \
+	err = PTR_ERR_OR_ZERO(variable);					\
+	err;									\
+})
+
+	int err;
+
+	debugfs_dir = debugfs_create_dir("rcuscale", NULL);
+	err = PTR_ERR_OR_ZERO(debugfs_dir);
+	if (err)
+		goto fail;
+
+	if (try_create_file(debugfs_writer_durations, "writer_durations", 0444,
+			debugfs_dir, NULL, &writer_durations_fops))
+		goto fail;
+
+	return 0;
+fail:
+	pr_err("rcu-scale: Failed to create debugfs file.");
+	/* unregister_debugfs is called by rcu_scale_cleanup, avoid
+	 * calling it twice.
+	 */
+	return err;
+#undef try_create_file
+}
+
+static void unregister_debugfs(void)
+{
+#define try_remove(variable)			\
+do {						\
+	if (!IS_ERR_OR_NULL(variable))		\
+		debugfs_remove(variable);	\
+	variable = NULL;			\
+} while (0)
+
+	try_remove(debugfs_writer_durations);
+
+	/* Remove directory after files. */
+	try_remove(debugfs_dir);
+
+#undef try_remove
+}
+
 static void
 rcu_scale_cleanup(void)
 {
@@ -961,6 +1079,8 @@ rcu_scale_cleanup(void)
 	if (gp_exp && gp_async)
 		SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
+	unregister_debugfs();
+
 	// If built-in, just report all of the GP kthread's CPU time.
 	if (IS_BUILTIN(CONFIG_RCU_SCALE_TEST) && !kthread_tp && cur_ops->rso_gp_kthread)
 		kthread_tp = cur_ops->rso_gp_kthread();
@@ -1020,13 +1140,15 @@ rcu_scale_cleanup(void)
 			wdpp = writer_durations[i];
 			if (!wdpp)
 				continue;
-			for (j = 0; j < writer_n_durations[i]; j++) {
-				wdp = &wdpp[j];
-				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
-					scale_type, SCALE_FLAG,
-					i, j, *wdp);
-				if (j % 100 == 0)
-					schedule_timeout_uninterruptible(1);
+			if (!writer_no_print) {
+				for (j = 0; j < writer_n_durations[i]; j++) {
+					wdp = &wdpp[j];
+					pr_alert("%s%s %4d writer-duration: %5d %llu\n",
+						scale_type, SCALE_FLAG,
+						i, j, *wdp);
+					if (j % 100 == 0)
+						schedule_timeout_uninterruptible(1);
+				}
 			}
 			kfree(writer_durations[i]);
 			if (writer_freelists) {
@@ -1202,6 +1324,10 @@ rcu_scale_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
+
+	if (register_debugfs())
+		goto unwind;
+
 	torture_init_end();
 	return 0;
 
-- 
2.50.1.552.g942d659e1b-goog

