Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715E371041;
	Mon,  5 Oct 2026 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191153; cv=none; b=LXiycqEwQfIUSaxSLT3AiSzCTYS5FX4pDFcVDKP9StE2UWF67GydjoWYl9WbQVHfn0ZzRmD+/qzHbvdjX95jqa0gV5FkF6yC6H+brMMZh/5S+Wd4nkpseSpScbYAUgtPGW1dBBBXgG40gmZl0Hbrx+Z7tW/iiKel0OpsF9bTb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191153; c=relaxed/simple;
	bh=3OG0luuyz1JPVwQPmv+to+Bxr8043Jt01r7uy/yzgTI=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tK0GRpNUyBh45jGEXF2+WzNJ51Vri6MTxyD9hsJZO2jLZjVG+xJhcRH4gBKORgXYnyv2wLjFvinKp4g1+S4r/YeTJEXhRGMNarX7TiLax95/ftsmXMeSacWTeJ4Wb88HhhCZZnsBbaFCTltdI1eWIyu4DSgKtDNgFe8Fm9ebkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=C6MsBXLP; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YmfJLWNx; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="C6MsBXLP";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YmfJLWNx"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791191112; bh=P6/KVlhkMPwKZhFrwlLaZXw
	8Ki4qiLnbuA0NLKbRUrg=; b=C6MsBXLPeGvqRo8q1buLyxKHMyBnf5nwDEDLl6qeeKXc6ebsAy
	nX7M9KObTbqLv509Tb42Y8Y+jOUFJv5oKnwOz+VT7bVBG0LYu3l95i0H7dB9x86Knnl4yyBLRQ2
	GI0v+N/V/relXsSIPR9n3xl6vAUrDJQjZIpPvSIGD5aNO40lStnfgIv/p7sb9B1cW5JnJZpetrF
	ULeRnnDvp4C7+KGeguTQivenO+oONu57JfrkTq/pVfcAB/68eRMxC//UfY10e4o7W8zzphH6dKn
	abRzKFGknUAse0aJfu0tlKf1Jg5FCQ4y7wJvH1OmvTKRGxHf6YfNUdVCxDJdbqd4U9g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791191112; bh=P6/KVlhkMPwKZhFrwlLaZXw
	8Ki4qiLnbuA0NLKbRUrg=; b=YmfJLWNxJGnOAGk0Rn0vw1qrQkFnPilyi7ixKJToena4KXF02M
	WbwZLgZ3mQapeddI8DgKJYlycJPXznEhZIDw==;
Date: Mon, 05 Oct 2026 10:05:13 +0100
From: Bradley Morgan <brads@mainlining.org>
To: joelagnelf@nvidia.com
CC: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_rcuscale=3A_Consolidate_per-?=
 =?US-ASCII?Q?writer_arrays_into_struct_writer=5Fstate?=
In-Reply-To: <20261005005642.2312272-1-joelagnelf@nvidia.com>
Message-ID: <79863FBF-8E54-41F4-A198-44472F5CEA8A@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 October 2026 01:56:41 BST, Joel Fernandes <joelagnelf@nvidia.com>
wrote:
>The writer kthreads keep their state in five parallel arrays indexed by
>writer number: writer_tasks, writer_durations, writer_n_durations,
>writer_done and writer_freelists.  Each must be allocated, NULL-checked,
>freed and cleared separately, and the cleanup path needs several
>guards to cope with any one of them being missing.
>
>Collapse them into a single array of struct writer_state, holding the
>task pointer, the duration buffer, the measurement count, the done flag
>and the existing struct writer_freelist.
>
>This reduces initialization to one allocation and one out-of-memory
>check, and cleanup to a single kfree().  As a side effect, this also
>fixes a leak: cleanup only ran its frees under "if (writer_tasks)", so
>if the writer_tasks allocation failed while a later allocation (for
>example writer_durations or writer_n_durations) still succeeded, those
>already-allocated arrays were never freed.  With a single allocation,
>that partial-allocation state can no longer occur.

All I've gotta say here, is one huge thank you, this cleanup WASS needed.

Reviewed-by: Bradley Morgan <brads@mainlining.org>

Also I ran basic tests:

Tested-by: Bradley Morgan <brads@mainlining.org> # Power10 

>
>Assisted-by: Codex
>Fixes: 8704baab9bc8 ("rcutorture: Add RCU grace-period performance tests")
>Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>---
> kernel/rcu/rcuscale.c | 127 ++++++++++++++++++------------------------
> 1 file changed, 55 insertions(+), 72 deletions(-)
>
>diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>index 1097ec15879c..f0bca5dcc754 100644
>--- a/kernel/rcu/rcuscale.c
>+++ b/kernel/rcu/rcuscale.c
>@@ -115,17 +115,21 @@ struct writer_freelist {
> 	struct writer_mblock *ws_mblocks;
> };
> 
>+struct writer_state {
>+	struct writer_freelist wst_fl;
>+	struct task_struct *wst_task;
>+	u64 *wst_durations;
>+	int wst_n_durations;
>+	bool wst_done;
>+};
>+
> static int nrealreaders;
> static int nrealwriters;
> static int nrealexp;
>-static struct task_struct **writer_tasks;
> static struct task_struct **reader_tasks;
> static struct task_struct **exp_tasks;
> 
>-static u64 **writer_durations;
>-static bool *writer_done;
>-static struct writer_freelist *writer_freelists;
>-static int *writer_n_durations;
>+static struct writer_state *writer_states;
> static atomic_t n_rcu_scale_reader_started;
> static atomic_t n_rcu_scale_writer_started;
> static atomic_t n_rcu_scale_writer_finished;
>@@ -504,9 +508,9 @@ static struct writer_mblock *rcu_scale_alloc(long me)
> 	struct writer_freelist *wflp;
> 	struct writer_mblock *wmbp;
> 
>-	if (WARN_ON_ONCE(!writer_freelists))
>+	if (WARN_ON_ONCE(!writer_states))
> 		return NULL;
>-	wflp = &writer_freelists[me];
>+	wflp = &writer_states[me].wst_fl;
> 	if (llist_empty(&wflp->ws_lhp)) {
> 		// ->ws_lhp is private to its rcu_scale_writer task.
> 		wmbp = container_of(llist_del_all(&wflp->ws_lhg), struct writer_mblock, wmb_node);
>@@ -560,8 +564,9 @@ rcu_scale_writer(void *arg)
> 	u64 t;
> 	DEFINE_TORTURE_RANDOM(tr);
> 	u64 *wdp;
>-	u64 *wdpp = writer_durations[me];
>-	struct writer_freelist *wflp = &writer_freelists[me];
>+	struct writer_state *wsp = &writer_states[me];
>+	u64 *wdpp = wsp->wst_durations;
>+	struct writer_freelist *wflp = &wsp->wst_fl;
> 	struct writer_mblock *wmbp = NULL;
> 
> 	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
>@@ -631,7 +636,7 @@ rcu_scale_writer(void *arg)
> 			started = true;
> 		if (!done && i >= MIN_MEAS && time_after(jiffies, jdone)) {
> 			done = true;
>-			WRITE_ONCE(writer_done[me], true);
>+			WRITE_ONCE(wsp->wst_done, true);
> 			sched_set_normal(current, 0);
> 			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
> 				 scale_type, SCALE_FLAG, me, MIN_MEAS);
>@@ -649,7 +654,7 @@ rcu_scale_writer(void *arg)
> 						cur_ops->get_gp_seq();
> 				}
> 				if (shutdown_secs) {
>-					writer_tasks[me] = NULL;
>+					wsp->wst_task = NULL;
> 					smp_mb(); /* Assign before wake. */
> 					rcu_scale_cleanup();
> 					kernel_power_off();
>@@ -665,10 +670,10 @@ rcu_scale_writer(void *arg)
> 
> 			if (!atomic_xchg(&dumped, 1)) {
> 				for (i = 0; i < nrealwriters; i++) {
>-					if (writer_done[i])
>+					if (writer_states[i].wst_done)
> 						continue;
> 					pr_info("%s: Task %ld flags writer %d:\n", __func__, me, i);
>-					sched_show_task(writer_tasks[i]);
>+					sched_show_task(writer_states[i].wst_task);
> 				}
> 				if (cur_ops->stats)
> 					cur_ops->stats();
>@@ -676,7 +681,7 @@ rcu_scale_writer(void *arg)
> 		}
> 		if (!selfreport && time_after(jiffies, jdone + HZ * (70 + me))) {
> 			pr_info("%s: Writer %ld self-report: started %d done %d/%d->%d i %d jdone %lu.\n",
>-				__func__, me, started, done, writer_done[me], atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
>+				__func__, me, started, done, wsp->wst_done, atomic_read(&n_rcu_scale_writer_finished), i, jiffies - jdone);
> 			selfreport = true;
> 		}
> 		if (gp_succeeded && started && !alldone && i < MAX_MEAS - 1)
>@@ -687,7 +692,7 @@ rcu_scale_writer(void *arg)
> 		rcu_scale_free(wmbp);
> 		cur_ops->gp_barrier();
> 	}
>-	writer_n_durations[me] = i_max + 1;
>+	wsp->wst_n_durations = i_max + 1;
> 	torture_kthread_stopping("rcu_scale_writer");
> 	return 0;
> }
>@@ -1031,13 +1036,11 @@ rcu_scale_cleanup(void)
> 		reader_tasks = NULL;
> 	}
> 
>-	if (writer_tasks) {
>+	if (writer_states) {
> 		for (i = 0; i < nrealwriters; i++) {
> 			torture_stop_kthread(rcu_scale_writer,
>-					     writer_tasks[i]);
>-			if (!writer_n_durations)
>-				continue;
>-			j = writer_n_durations[i];
>+					     writer_states[i].wst_task);
>+			j = writer_states[i].wst_n_durations;
> 			pr_alert("%s%s writer %d gps: %d\n",
> 				 scale_type, SCALE_FLAG, i, j);
> 			ngps += j;
>@@ -1051,14 +1054,12 @@ rcu_scale_cleanup(void)
> 			 rcuscale_seq_diff(b_rcu_gp_test_finished,
> 					   b_rcu_gp_test_started));
> 		for (i = 0; i < nrealwriters; i++) {
>-			if (!writer_durations)
>-				break;
>-			if (!writer_n_durations)
>-				continue;
>-			wdpp = writer_durations[i];
>+			struct writer_state *wsp = &writer_states[i];
>+
>+			wdpp = wsp->wst_durations;
> 			if (!wdpp)
> 				continue;
>-			for (j = 0; j < writer_n_durations[i]; j++) {
>+			for (j = 0; j < wsp->wst_n_durations; j++) {
> 				wdp = &wdpp[j];
> 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
> 					scale_type, SCALE_FLAG,
>@@ -1066,34 +1067,23 @@ rcu_scale_cleanup(void)
> 				if (j % 100 == 0)
> 					schedule_timeout_uninterruptible(1);
> 			}
>-			kfree(writer_durations[i]);
>-			if (writer_freelists) {
>+			kfree(wdpp);
>+			if (wsp->wst_fl.ws_mblocks) {
> 				int ctr = 0;
> 				struct llist_node *llnp;
>-				struct writer_freelist *wflp = &writer_freelists[i];
> 
>-				if (wflp->ws_mblocks) {
>-					llist_for_each(llnp, wflp->ws_lhg.first)
>-						ctr++;
>-					llist_for_each(llnp, wflp->ws_lhp.first)
>-						ctr++;
>-					WARN_ONCE(ctr != gp_async_max,
>-						  "%s: ctr = %d gp_async_max = %d\n",
>-						  __func__, ctr, gp_async_max);
>-					kfree(wflp->ws_mblocks);
>-				}
>+				llist_for_each(llnp, wsp->wst_fl.ws_lhg.first)
>+					ctr++;
>+				llist_for_each(llnp, wsp->wst_fl.ws_lhp.first)
>+					ctr++;
>+				WARN_ONCE(ctr != gp_async_max,
>+					  "%s: ctr = %d gp_async_max = %d\n",
>+					  __func__, ctr, gp_async_max);
>+				kfree(wsp->wst_fl.ws_mblocks);
> 			}
> 		}
>-		kfree(writer_tasks);
>-		writer_tasks = NULL;
>-		kfree(writer_durations);
>-		writer_durations = NULL;
>-		kfree(writer_n_durations);
>-		writer_n_durations = NULL;
>-		kfree(writer_done);
>-		writer_done = NULL;
>-		kfree(writer_freelists);
>-		writer_freelists = NULL;
>+		kfree(writer_states);
>+		writer_states = NULL;
> 	}
> 
> 	/* Do torture-type-specific cleanup operations.  */
>@@ -1187,37 +1177,30 @@ rcu_scale_init(void)
> 				goto unwind;
> 		}
> 	}
>-	writer_tasks = kzalloc_objs(writer_tasks[0], nrealwriters);
>-	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
>-	writer_n_durations = kzalloc_objs(*writer_n_durations, nrealwriters);
>-	writer_done = kzalloc_objs(writer_done[0], nrealwriters);
>-	if (gp_async) {
>-		if (gp_async_max <= 0) {
>-			pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
>-				__func__, gp_async_max);
>-			WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
>-			firsterr = -EINVAL;
>-			goto unwind;
>-		}
>-		writer_freelists = kzalloc_objs(writer_freelists[0],
>-						nrealwriters);
>+	writer_states = kzalloc_objs(writer_states[0], nrealwriters);
>+	if (gp_async && gp_async_max <= 0) {
>+		pr_warn("%s: gp_async_max = %d must be greater than zero.\n",
>+			__func__, gp_async_max);
>+		WARN_ON_ONCE(IS_BUILTIN(CONFIG_RCU_TORTURE_TEST));
>+		firsterr = -EINVAL;
>+		goto unwind;
> 	}
>-	if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done ||
>-	    (gp_async && !writer_freelists)) {
>+	if (!writer_states) {
> 		SCALEOUT_ERRSTRING("out of memory");
> 		firsterr = -ENOMEM;
> 		goto unwind;
> 	}
> 	for (i = 0; i < nrealwriters; i++) {
>-		writer_durations[i] =
>-			kcalloc(MAX_MEAS, sizeof(*writer_durations[i]),
>-				GFP_KERNEL);
>-		if (!writer_durations[i]) {
>+		struct writer_state *wsp = &writer_states[i];
>+
>+		wsp->wst_durations = kcalloc(MAX_MEAS, sizeof(*wsp->wst_durations),
>+					     GFP_KERNEL);
>+		if (!wsp->wst_durations) {
> 			firsterr = -ENOMEM;
> 			goto unwind;
> 		}
>-		if (writer_freelists) {
>-			struct writer_freelist *wflp = &writer_freelists[i];
>+		if (gp_async) {
>+			struct writer_freelist *wflp = &wsp->wst_fl;
> 
> 			init_llist_head(&wflp->ws_lhg);
> 			init_llist_head(&wflp->ws_lhp);
>@@ -1235,7 +1218,7 @@ rcu_scale_init(void)
> 			}
> 		}
> 		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
>-						  writer_tasks[i]);
>+						  wsp->wst_task);
> 		if (torture_init_error(firsterr))
> 			goto unwind;
> 	}
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
