Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD991D5ACE
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842250; cv=none; b=P9XFatsZINHPaWu+fiUrms1vYh//xjHU0NYCB6K8KoJxosilh4l8Yi437uEtyzKYWAA4d+g0d+BPSCEIZad7EO30bJEalJFX6znNHYfQsHqEdOQkI2JCkrOInYheA+02JRkU4oISsmexTi4s5UvYwG/ikhtM0Uc8t5/bP6t6IY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842250; c=relaxed/simple;
	bh=9Ujt5KaGB2d5xYGZWoI/rd724qikJUaU1Yrwkr7rzPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B39KlCHu5b+QENKoBsFxVYSe0Vybo8SoPf++jHb4JYxd3rN58EbzP/ZCGLyOX+hEuwc0GgBdgU8wwcpLmj3apUGd23inzU2ONXBT5rklOQQhLK3sWCvRrFaPMhIITUspR36HEluj1xzz29H6MDBFImAwkAGS4zyxo2LIZ985JeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXR7Pbje; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXR7Pbje"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31edd69d754so2996150a91.1
        for <rcu@vger.kernel.org>; Tue, 29 Jul 2025 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753842248; x=1754447048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=db7w+qlj3x6A30qhGk3svrDuPx+Id3qEqe7Z1wrV5Fc=;
        b=hXR7Pbjevb5yl4z410JO/4uNbP4zs2ic5lmmZvYQdEhYd4xdM6Ay3PoBi2TKgzyMhT
         7wJPpzjoLuse61ta58OwtGP6rwmxdDKK6qiBKKSLO0P+HRYnv3aq1JK+AxWYP0kvVWex
         Qzqm66JxUz3GdVICx1VfinwkwB+fi4rBnH4yBOlnzYDIinDRHHCl8wlTduORvrhk7RQJ
         ct8MwHk4ZQ4SJ7LXJwlnqWel/BGYMzaYIdRjrP2O0AaYd0zuiYK14egq/hDbvdECi0/f
         hjAApxTyp0DFGg714R/eeIZAaXHq+prSivwtmGpKJ/y2gEph5Nn4FHpBWKYdycL1HoIb
         TJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842248; x=1754447048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=db7w+qlj3x6A30qhGk3svrDuPx+Id3qEqe7Z1wrV5Fc=;
        b=whgW3icGEgFRkT9FfO+Mt1ZgagqZWYw/sG2055TQnCHZNwYHJgKRoCbsY9kQgBDHHT
         wY7FM7hynauDnKC/GzsNLzbEF/oJAcCgjgLW+GzJYE3VtAmUnNvcSONQ5W7BgmtqaC8k
         Saqk3mO2cFFCM45EGJ5nDFqtdMMnTatzQ+GxooF1GvYnvdiTIwYRSvy0xZxRtLPSpQQV
         DBop/mqQf9ddUobn4ujrVmR9ex+++dD5my5SyOsDTVRVytYykRIowA0p6X3TCh78EOtG
         EACWWWIReNdQf5IYvqlgwC8qTbqUpaTr0L21qqVDlm9Fh+w7G6u6j+o4TjbTdOek7FZY
         f+rg==
X-Forwarded-Encrypted: i=1; AJvYcCWEKVJ2lyr/T1DO8LQ+ogdFHuCvi3eJTy6QmG43sl+l3OjISV031Y+hcJeNQ0KSLUV5nT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxT6ZIJoS06zsOQU09gOdVrQJqCUx5pi9Vgcn9+seBSnOjbNkn
	cfvOT9zOofs0fsvmDHhJeUbHvDLAXUJOH04aWW0IhCcNi4kOj0E8JZQrWsp/NVkTz633CKpqqRA
	opniz1g==
X-Google-Smtp-Source: AGHT+IHhLv6xFPeOTg+DJUtO46sNQgxdk80iCLDRyCDBD5ZkpZjf8Is9Cy4z221p/h5t/aI4fA2UkVY4hWU=
X-Received: from plhk16.prod.google.com ([2002:a17:902:d590:b0:234:bca4:b7b3])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:240:3239:21c7
 with SMTP id d9443c01a7336-24096ba6594mr16406855ad.37.1753842247994; Tue, 29
 Jul 2025 19:24:07 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:23:45 -0700
In-Reply-To: <20250730022347.71722-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730022347.71722-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730022347.71722-3-yuzhuo@google.com>
Subject: [PATCH v1 2/4] rcuscale: Create debugfs files for worker thread PIDs
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

Creates {reader,writer,kfree}_tasks files in the "rcuscale" debugfs
folder.  Each line contains one kernel thread PID.

This provides a more robust way for external performance analysis tools
to attach to kernel threads than using pgrep.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 kernel/rcu/rcuscale.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ad10b42be6fc..7c88d461ed2c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -143,6 +143,9 @@ static unsigned long b_rcu_gp_test_finished;
 
 static struct dentry *debugfs_dir;
 static struct dentry *debugfs_writer_durations;
+static struct dentry *debugfs_reader_tasks;
+static struct dentry *debugfs_writer_tasks;
+static struct dentry *debugfs_kfree_tasks;
 
 #define MAX_MEAS 10000
 #define MIN_MEAS 100
@@ -1009,6 +1012,112 @@ static const struct file_operations writer_durations_fops = {
 	.release = seq_release,
 };
 
+/*
+ * Generic seq_file private data for tasks walkthrough.
+ */
+struct debugfs_pid_info {
+	int ntasks;
+	struct task_struct **tasks;
+};
+
+/*
+ * Generic seq_file pos to pointer conversion function, using private data
+ * of type debugfs_pid_info, and ensure it is within bound.
+ */
+static void *debugfs_pid_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t worker = *pos;
+	struct debugfs_pid_info *info = m->private;
+
+	if (worker < 0 || worker >= info->ntasks)
+		return NULL;
+
+	return info->tasks[worker];
+}
+
+static void *debugfs_pid_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return debugfs_pid_start(m, pos);
+}
+
+/*
+ * Each line of the file contains one PID from the selected kernel threads.
+ */
+static int debugfs_pid_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", ((struct task_struct *)v)->pid);
+	return 0;
+}
+
+static void debugfs_pid_stop(struct seq_file *m, void *v)
+{
+}
+
+static const struct seq_operations debugfs_pid_fops = {
+	.start	= debugfs_pid_start,
+	.next	= debugfs_pid_next,
+	.stop	= debugfs_pid_stop,
+	.show	= debugfs_pid_show
+};
+
+/*
+ * Generic seq_file creation function that sets private data of type
+ * debugfs_pid_info.
+ */
+static int debugfs_pid_open_info(struct inode *inode, struct file *file,
+		int ntasks, struct task_struct **tasks)
+{
+	struct debugfs_pid_info *info =
+		__seq_open_private(file, &debugfs_pid_fops, sizeof(*info));
+	if (!info)
+		return -ENOMEM;
+
+	info->ntasks = ntasks;
+	info->tasks = tasks;
+
+	return 0;
+}
+
+static int debugfs_pid_open_reader(struct inode *inode, struct file *file)
+{
+	return debugfs_pid_open_info(inode, file, nrealreaders, reader_tasks);
+}
+
+static int debugfs_pid_open_writer(struct inode *inode, struct file *file)
+{
+	return debugfs_pid_open_info(inode, file, nrealwriters, writer_tasks);
+}
+
+static int debugfs_pid_open_kfree(struct inode *inode, struct file *file)
+{
+	return debugfs_pid_open_info(inode, file, kfree_nrealthreads, kfree_reader_tasks);
+}
+
+static const struct file_operations readers_fops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_pid_open_reader,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations writers_fops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_pid_open_writer,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations kfrees_fops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_pid_open_kfree,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 /*
  * Create an rcuscale directory exposing run states and results.
  */
@@ -1032,6 +1141,18 @@ static int register_debugfs(void)
 			debugfs_dir, NULL, &writer_durations_fops))
 		goto fail;
 
+	if (try_create_file(debugfs_reader_tasks, "reader_tasks", 0444,
+			debugfs_dir, NULL, &readers_fops))
+		goto fail;
+
+	if (try_create_file(debugfs_writer_tasks, "writer_tasks", 0444,
+			debugfs_dir, NULL, &writers_fops))
+		goto fail;
+
+	if (try_create_file(debugfs_kfree_tasks, "kfree_tasks", 0444,
+			debugfs_dir, NULL, &kfrees_fops))
+		goto fail;
+
 	return 0;
 fail:
 	pr_err("rcu-scale: Failed to create debugfs file.");
@@ -1052,6 +1173,9 @@ do {						\
 } while (0)
 
 	try_remove(debugfs_writer_durations);
+	try_remove(debugfs_reader_tasks);
+	try_remove(debugfs_writer_tasks);
+	try_remove(debugfs_kfree_tasks);
 
 	/* Remove directory after files. */
 	try_remove(debugfs_dir);
-- 
2.50.1.552.g942d659e1b-goog

