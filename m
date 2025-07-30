Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D577B1E0DEA
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842253; cv=none; b=P9QyA5RSFDTSmBPmla+1EPHChqNIwuns2LAiq480zENY/ChPCmAKjz+ER8bJNWXOtLfGYVvkZc2XC2yp3iOQX03ReeTBnnR8a6rHzYGDepaR0HBJ1pvpyhsh/dWhY76O6+dvY84hW72zB1ApKDqDt7ezb6fOrlArIGlUZSP5KYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842253; c=relaxed/simple;
	bh=UIfabhiJWa3Z4s7GqC5WPKaw0anOyWSxrRl3qirvLr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L68vb0Yh5J2L7W35+K+6awb+VKKExz1YpaglnjiS6M8U0LiJTaVBvi/aM2TDTsz6K91UiEpI1sQDcxsaAc42pNFjZUSGtghP12CFu867ofxVCaBdbdF24VT+ABrE4lYDAfUNJUX3ugzjL7jKPsl+D6NMaXVtLEpZNDSyORctfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrHFNfhV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrHFNfhV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369dd58602so66632175ad.1
        for <rcu@vger.kernel.org>; Tue, 29 Jul 2025 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753842251; x=1754447051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oRndOQtUuCTe+afI4UqP/ZtSY/9RpQUvM4BI6wS4mQ=;
        b=LrHFNfhVOcnsMjknDSCYEhwshYfehgpX3f/PRv+DzckOzjEQLsGbKUyIBbrmHlrxix
         SEMptHUJMKbc6dMrB4HXihNHeXZidG9AVMCVaKS8sSW8W+hpxTU7IjtrLZrqgv5131ML
         HhtS8sv/idqlHpuzqy2Bs3s2edCYUXyFcfhosdZ1XNz8S11vxFredrOWXY0SS+rNw194
         WHvrM2wvQfyID0Q40KOoLCvOEA8+J9EiptzAagDYnI5IUHR4A6vLVaTqxXq0VHD3hiVl
         MRA/rYQf29RvBc9v8+57g/wYxCFQZgDtfBtdbnrC3L7qnHcUBrQBNbwF7LW9uXquiJK3
         B0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842251; x=1754447051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oRndOQtUuCTe+afI4UqP/ZtSY/9RpQUvM4BI6wS4mQ=;
        b=hBEtaVfO6SoG3XX2Z36LU4XDDpKGKc74Vo3+qVA/w5VoeATGndQQBNCZICMEbFu1nZ
         IOaKn+WiHqQpH1NJXseKPVfdjDdK78AvWtY1exVeu2G+W3uQqWJJXjQnQT+84Qb7ai5U
         ybMl6V5Zyq+n0MTLt4H5w8l9/cNwHMOdME2snQjooLGA4DPUqD+FpqUT0b7c2KY2WYUO
         xVTESaI7Cs/P96PQL1YdYH15LtH1F0XRj+DVq9hWRRhR77u/LAUaBeKnLHbevQbvdjn+
         ouPRcBEKwrjYxMOyWKQwgi5G3ozX664OF3KeL8q2tJwHsxaiUeYue5a9t+dha4O9MFkg
         iitg==
X-Forwarded-Encrypted: i=1; AJvYcCXa6h7InPSboYGHgD09NlQJQyu2BQU9Z8XGoiIii17qx6d9aozOi5y+jO2Ptn4ic0C6cHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7ez6sWSp7fwnwyopLmprxa4+Bb6tcIPP/njSNcONGOjrCl+C
	LRZrnKnm8k+UY0GVsKSn5Q7qWiue7sU+5Z91/5PVmiYgVVKT6GOFS3rPOWdzSfdciVQnRKNg0pt
	UC/U/Kg==
X-Google-Smtp-Source: AGHT+IE28C8fLr7AW0K7sod7RfR/S9Ci5NQA8Kz+RkgdLQ32laB755YoHEksytGwtVXC18LfdYKXqjs7klA=
X-Received: from pliy6.prod.google.com ([2002:a17:903:3d06:b0:240:931c:1712])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:98f:b0:23f:d861:bd4a
 with SMTP id d9443c01a7336-24096b6804dmr20278865ad.27.1753842251216; Tue, 29
 Jul 2025 19:24:11 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:23:47 -0700
In-Reply-To: <20250730022347.71722-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730022347.71722-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730022347.71722-5-yuzhuo@google.com>
Subject: [PATCH v1 4/4] rcuscale: Add CPU affinity offset options
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

Currently, reader, writer, and kfree threads set their affinity by their
id % nr_cpu_ids.  IDs of the all three types all start from 0, and
therefore readers, writers, and kfrees may be scheduled on the same CPU.

This patch adds options to offset CPU affinity.

From the experiments below, writer duration characteristics are very
different between offset 0 and 1.  Experiments carried out on a 256C 512T
machine running PREEMPT=n kernel.

Experiment: nreaders=1 nwriters=1 reader_cpu_offset=0 writer_cpu_offset=0
Average grace-period duration: 108376 microseconds
Minimum grace-period duration: 13000.4
50th percentile grace-period duration: 115000
90th percentile grace-period duration: 121000
99th percentile grace-period duration: 121004
Maximum grace-period duration: 219000
Grace periods: 101 Batches: 1 Ratio: 101

Experiment: nreaders=1 nwriters=1 reader_cpu_offset=0 writer_cpu_offset=1
Average grace-period duration: 185950 microseconds
Minimum grace-period duration: 8999.84
50th percentile grace-period duration: 217946
90th percentile grace-period duration: 218003
99th percentile grace-period duration: 218018
Maximum grace-period duration: 272195
Grace periods: 101 Batches: 1 Ratio: 101

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 +++++++++++++++++++
 kernel/rcu/rcuscale.c                         | 16 +++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5e233e511f81..f68651c103a4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,3 +1,4 @@
+# vim: noet:sw=8:sts=8:
 	accept_memory=  [MM]
 			Format: { eager | lazy }
 			default: lazy
@@ -5513,6 +5514,12 @@
 			test until boot completes in order to avoid
 			interference.
 
+	rcuscale.kfree_cpu_offset= [KNL]
+			Set the starting CPU affinity index of kfree threads.
+			CPU affinity is assigned sequentially from
+			kfree_cpu_offset to kfree_cpu_offset+kfree_nthreads,
+			modded by number of CPUs.  Negative value is reset to 0.
+
 	rcuscale.kfree_by_call_rcu= [KNL]
 			In kernels built with CONFIG_RCU_LAZY=y, test
 			call_rcu() instead of kfree_rcu().
@@ -5567,6 +5574,12 @@
 			the same as for rcuscale.nreaders.
 			N, where N is the number of CPUs
 
+	rcuscale.reader_cpu_offset= [KNL]
+			Set the starting CPU affinity index of reader threads.
+			CPU affinity is assigned sequentially from
+			reader_cpu_offset to reader_cpu_offset+nreaders, modded
+			by number of CPUs.  Negative value is reset to 0.
+
 	rcuscale.scale_type= [KNL]
 			Specify the RCU implementation to test.
 
@@ -5578,6 +5591,12 @@
 	rcuscale.verbose= [KNL]
 			Enable additional printk() statements.
 
+	rcuscale.writer_cpu_offset= [KNL]
+			Set the starting CPU affinity index of writer threads.
+			CPU affinity is assigned sequentially from
+			writer_cpu_offset to writer_cpu_offset+nwriters, modded
+			by number of CPUs.  Negative value is reset to 0.
+
 	rcuscale.writer_holdoff= [KNL]
 			Write-side holdoff between grace periods,
 			in microseconds.  The default of zero says
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 43bcaeac457f..1208169be15e 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -95,12 +95,15 @@ torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
 torture_param(int, minruntime, 0, "Minimum run time (s)");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, nwriters, -1, "Number of RCU updater threads");
+torture_param(int, reader_cpu_offset, 0, "Offset of reader CPU affinity")
 torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
 	      "Shutdown at end of scalability tests.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
+torture_param(int, writer_cpu_offset, 0, "Offset of writer CPU affinity")
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, writer_holdoff_jiffies, 0, "Holdoff (jiffies) between GPs, zero to disable");
 torture_param(bool, writer_no_print, false, "Do not print writer durations to ring buffer");
+torture_param(int, kfree_cpu_offset, 0, "Offset of kfree CPU affinity")
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 torture_param(int, kfree_by_call_rcu, 0, "Use call_rcu() to emulate kfree_rcu()?");
@@ -495,7 +498,7 @@ rcu_scale_reader(void *arg)
 	long me = (long)arg;
 
 	VERBOSE_SCALEOUT_STRING("rcu_scale_reader task started");
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_cpus_allowed_ptr(current, cpumask_of((reader_cpu_offset + me) % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_rcu_scale_reader_started);
 
@@ -585,7 +588,7 @@ rcu_scale_writer(void *arg)
 
 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
 	WARN_ON(!wdpp);
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_cpus_allowed_ptr(current, cpumask_of((writer_cpu_offset + me) % nr_cpu_ids));
 	current->flags |= PF_NO_SETAFFINITY;
 	sched_set_fifo_low(current);
 
@@ -719,8 +722,8 @@ static void
 rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
-		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown=%d\n",
-		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff, minruntime, nrealreaders, nrealwriters, writer_holdoff, writer_holdoff_jiffies, verbose, shutdown);
+		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d reader_cpu_offset=%d writer_cpu_offset=%d writer_holdoff=%d writer_holdoff_jiffies=%d kfree_cpu_offset=%d verbose=%d shutdown=%d\n",
+		 scale_type, tag, gp_async, gp_async_max, gp_exp, holdoff, minruntime, nrealreaders, nrealwriters, reader_cpu_offset, writer_cpu_offset, writer_holdoff, writer_holdoff_jiffies, kfree_cpu_offset, verbose, shutdown);
 }
 
 /*
@@ -785,7 +788,7 @@ kfree_scale_thread(void *arg)
 	DEFINE_TORTURE_RANDOM(tr);
 
 	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_cpus_allowed_ptr(current, cpumask_of((kfree_cpu_offset + me) % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
 
@@ -1446,6 +1449,9 @@ rcu_scale_init(void)
 	atomic_set(&n_rcu_scale_reader_started, 0);
 	atomic_set(&n_rcu_scale_writer_started, 0);
 	atomic_set(&n_rcu_scale_writer_finished, 0);
+	reader_cpu_offset = max(reader_cpu_offset, 0);
+	writer_cpu_offset = max(writer_cpu_offset, 0);
+	kfree_cpu_offset = max(kfree_cpu_offset, 0);
 	rcu_scale_print_module_parms(cur_ops, "Start of test");
 
 	if (!block_start)
-- 
2.50.1.552.g942d659e1b-goog

