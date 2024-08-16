Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138108289E;
	Fri, 16 Aug 2024 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791042; cv=none; b=ncTeDfpIhAOhPoJPR8TQHz6CpYzI1aua0MXQqDKzzya425VFExidkXutQnVtpOk9JRxGyeOKjxLG8abnlF/3H/YD+f8UxnAzKhAvAXfloGIFBxDlnihKY2YV38Yuh4SQJpLO7oryFtbXeF8PZwChm2LUQVA0z/wCh1zaMSYHsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791042; c=relaxed/simple;
	bh=+XHlKyHnlRafoh2XYAWbtt0V7ZsBf8HadwtpSouqSuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/Z7EGI67WMkEPawE0gG5dmobpueQRg2Eeg0AuYbcrDd1lMmaFyA6oTmDVw3zzgzYAyZDPZX10C89sZMiEtgi8rrYQeFklFGQUe1aa2vvgwZrsAs2p+BdMeju+JjWDwEAzY9achVZuB+xFfRUYH4fbcUzFNfvMcBlS3DS75pxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdRTBEDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdRTBEDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC6C4AF09;
	Fri, 16 Aug 2024 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791041;
	bh=+XHlKyHnlRafoh2XYAWbtt0V7ZsBf8HadwtpSouqSuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdRTBEDtYPLLb5+i/GLGA0IaqjXFLjV5LQ9v2isJNiZpvRbS9WFMuGKcG9RMUlTYV
	 Uq4wiFPW3Pxyjj2NC/HvjbzKhFc4wJtiNpkDH2SZLq9KKY5KZqPJlfbEcFGbCXauX7
	 9H2/0cSRfkTfy0Owz4S1DECNiI3Q0okvgfYZUalXx12hH6uQNlezRNacJ2MU652iDE
	 /M+h3cwu/29ltgYEaNHlkqB2OCOyPqYpNGYH83hPBwAFkuSgsuTVMizMC8gPg7LJzZ
	 ZLI9I0brLX1rHdhzgy6OFPXB/bLcdx0lRvrjclv3ppbcXpCwDjBi9M7AJ01Pjoq8jn
	 BDcnJCf1n6SQg==
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
Subject: [PATCH rcu 02/12] doc: Remove RCU Tasks Rude asynchronous APIs
Date: Fri, 16 Aug 2024 12:19:11 +0530
Message-Id: <20240816064921.57645-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The call_rcu_tasks_rude() and rcu_barrier_tasks_rude() APIs are no longer.
This commit therefore removes them from the documentation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  |  3 +-
 Documentation/RCU/checklist.rst               | 61 +++++++++----------
 Documentation/RCU/whatisRCU.rst               |  2 +-
 .../admin-guide/kernel-parameters.txt         |  8 ---
 4 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index f511476b4550..6125e7068d2c 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2649,8 +2649,7 @@ those that are idle from RCU's perspective) and then Tasks Rude RCU can
 be removed from the kernel.
 
 The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
-consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
-and rcu_barrier_tasks_rude().
+consisting solely of synchronize_rcu_tasks_rude().
 
 Tasks Trace RCU
 ~~~~~~~~~~~~~~~
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 3e6407de231c..7de3e308f330 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -194,14 +194,13 @@ over a rather long period of time, but improvements are always welcome!
 		when publicizing a pointer to a structure that can
 		be traversed by an RCU read-side critical section.
 
-5.	If any of call_rcu(), call_srcu(), call_rcu_tasks(),
-	call_rcu_tasks_rude(), or call_rcu_tasks_trace() is used,
-	the callback function may be invoked from softirq context,
-	and in any case with bottom halves disabled.  In particular,
-	this callback function cannot block.  If you need the callback
-	to block, run that code in a workqueue handler scheduled from
-	the callback.  The queue_rcu_work() function does this for you
-	in the case of call_rcu().
+5.	If any of call_rcu(), call_srcu(), call_rcu_tasks(), or
+	call_rcu_tasks_trace() is used, the callback function may be
+	invoked from softirq context, and in any case with bottom halves
+	disabled.  In particular, this callback function cannot block.
+	If you need the callback to block, run that code in a workqueue
+	handler scheduled from the callback.  The queue_rcu_work()
+	function does this for you in the case of call_rcu().
 
 6.	Since synchronize_rcu() can block, it cannot be called
 	from any sort of irq context.  The same rule applies
@@ -254,10 +253,10 @@ over a rather long period of time, but improvements are always welcome!
 		corresponding readers must use rcu_read_lock_trace()
 		and rcu_read_unlock_trace().
 
-	c.	If an updater uses call_rcu_tasks_rude() or
-		synchronize_rcu_tasks_rude(), then the corresponding
-		readers must use anything that disables preemption,
-		for example, preempt_disable() and preempt_enable().
+	c.	If an updater uses synchronize_rcu_tasks_rude(),
+		then the corresponding readers must use anything that
+		disables preemption, for example, preempt_disable()
+		and preempt_enable().
 
 	Mixing things up will result in confusion and broken kernels, and
 	has even resulted in an exploitable security issue.  Therefore,
@@ -326,11 +325,9 @@ over a rather long period of time, but improvements are always welcome!
 	d.	Periodically invoke rcu_barrier(), permitting a limited
 		number of updates per grace period.
 
-	The same cautions apply to call_srcu(), call_rcu_tasks(),
-	call_rcu_tasks_rude(), and call_rcu_tasks_trace().  This is
-	why there is an srcu_barrier(), rcu_barrier_tasks(),
-	rcu_barrier_tasks_rude(), and rcu_barrier_tasks_rude(),
-	respectively.
+	The same cautions apply to call_srcu(), call_rcu_tasks(), and
+	call_rcu_tasks_trace().  This is why there is an srcu_barrier(),
+	rcu_barrier_tasks(), and rcu_barrier_tasks_trace(), respectively.
 
 	Note that although these primitives do take action to avoid
 	memory exhaustion when any given CPU has too many callbacks,
@@ -383,17 +380,17 @@ over a rather long period of time, but improvements are always welcome!
 	must use whatever locking or other synchronization is required
 	to safely access and/or modify that data structure.
 
-	Do not assume that RCU callbacks will be executed on
-	the same CPU that executed the corresponding call_rcu(),
-	call_srcu(), call_rcu_tasks(), call_rcu_tasks_rude(), or
-	call_rcu_tasks_trace().  For example, if a given CPU goes offline
-	while having an RCU callback pending, then that RCU callback
-	will execute on some surviving CPU.  (If this was not the case,
-	a self-spawning RCU callback would prevent the victim CPU from
-	ever going offline.)  Furthermore, CPUs designated by rcu_nocbs=
-	might well *always* have their RCU callbacks executed on some
-	other CPUs, in fact, for some  real-time workloads, this is the
-	whole point of using the rcu_nocbs= kernel boot parameter.
+	Do not assume that RCU callbacks will be executed on the same
+	CPU that executed the corresponding call_rcu(), call_srcu(),
+	call_rcu_tasks(), or call_rcu_tasks_trace().  For example, if
+	a given CPU goes offline while having an RCU callback pending,
+	then that RCU callback will execute on some surviving CPU.
+	(If this was not the case, a self-spawning RCU callback would
+	prevent the victim CPU from ever going offline.)  Furthermore,
+	CPUs designated by rcu_nocbs= might well *always* have their
+	RCU callbacks executed on some other CPUs, in fact, for some
+	real-time workloads, this is the whole point of using the
+	rcu_nocbs= kernel boot parameter.
 
 	In addition, do not assume that callbacks queued in a given order
 	will be invoked in that order, even if they all are queued on the
@@ -507,9 +504,9 @@ over a rather long period of time, but improvements are always welcome!
 	These debugging aids can help you find problems that are
 	otherwise extremely difficult to spot.
 
-17.	If you pass a callback function defined within a module to one of
-	call_rcu(), call_srcu(), call_rcu_tasks(), call_rcu_tasks_rude(),
-	or call_rcu_tasks_trace(), then it is necessary to wait for all
+17.	If you pass a callback function defined within a module
+	to one of call_rcu(), call_srcu(), call_rcu_tasks(), or
+	call_rcu_tasks_trace(), then it is necessary to wait for all
 	pending callbacks to be invoked before unloading that module.
 	Note that it is absolutely *not* sufficient to wait for a grace
 	period!  For example, synchronize_rcu() implementation is *not*
@@ -522,7 +519,6 @@ over a rather long period of time, but improvements are always welcome!
 	-	call_rcu() -> rcu_barrier()
 	-	call_srcu() -> srcu_barrier()
 	-	call_rcu_tasks() -> rcu_barrier_tasks()
-	-	call_rcu_tasks_rude() -> rcu_barrier_tasks_rude()
 	-	call_rcu_tasks_trace() -> rcu_barrier_tasks_trace()
 
 	However, these barrier functions are absolutely *not* guaranteed
@@ -539,7 +535,6 @@ over a rather long period of time, but improvements are always welcome!
 	-	Either synchronize_srcu() or synchronize_srcu_expedited(),
 		together with and srcu_barrier()
 	-	synchronize_rcu_tasks() and rcu_barrier_tasks()
-	-	synchronize_tasks_rude() and rcu_barrier_tasks_rude()
 	-	synchronize_tasks_trace() and rcu_barrier_tasks_trace()
 
 	If necessary, you can use something like workqueues to execute
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index d585a5490aee..1ef5784c1b84 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1103,7 +1103,7 @@ RCU-Tasks-Rude::
 
 	Critical sections	Grace period		Barrier
 
-	N/A			call_rcu_tasks_rude	rcu_barrier_tasks_rude
+	N/A						N/A
 				synchronize_rcu_tasks_rude
 
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..a6107b745076 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5572,14 +5572,6 @@
 			of zero will disable batching.	Batching is
 			always disabled for synchronize_rcu_tasks().
 
-	rcupdate.rcu_tasks_rude_lazy_ms= [KNL]
-			Set timeout in milliseconds RCU Tasks
-			Rude asynchronous callback batching for
-			call_rcu_tasks_rude().	A negative value
-			will take the default.	A value of zero will
-			disable batching.  Batching is always disabled
-			for synchronize_rcu_tasks_rude().
-
 	rcupdate.rcu_tasks_trace_lazy_ms= [KNL]
 			Set timeout in milliseconds RCU Tasks
 			Trace asynchronous callback batching for
-- 
2.40.1

