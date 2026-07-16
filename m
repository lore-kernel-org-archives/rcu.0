Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278F23183F;
	Thu, 16 Jul 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161096; cv=none; b=ASqKR9W1SQQOhiMkP+9OixUdYIqH1s1FboXIKgej0n0C6P2LQJ9R8Vd2eimi30UBM9e022xQnXjymRV4jvM9QqfVWOt8+10vA7UnThJCB3ji/LXIM8WA5NQA6rLtGGf3bA4y0Jl/00ilDxDDsfv09QW3Tgbv04jTrq3rMl9EaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161096; c=relaxed/simple;
	bh=zvWR6bgmBcz8v6mYV8M7NJqQ2X/y1muO0aIYKPzGGDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHeBdl9gJfG2vQN8g3N4VFOnYbgpNOjbujOjZiYRKwaPTFJtaHXDMaQ5mwPdfvkyJbGiHMGhrjGDTx8rZcMN0jXVGvDG98ZG7KTpzk6cWNFHzzgfl9tdt82bI8Cs4a/DurJ/QnFswc1Y2VH4IgK11kPSU0CVt95W80pQPVgn+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMO3Gv6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMO3Gv6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4331F01561;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=oO2sm1j7Nq9Prg/AKFwcQRXORcrI5Vi3nU5SVYQ9V+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jMO3Gv6WanyGQuOXaw2lzBFd5/u6pZ+MdVjYZNK8JeYzxDc1qD+OWTOLyaZaInf8V
	 8M9Ha7Znzw8mPqCFiPTtk8MzfmFOQKvMZp76wi+UASYp9Jv2JzgktZGr/hlu96JLkb
	 SXzQfGowEZdjpZdAggdvOtX/6LUezTsGOHw+TXdvTTucbeL2XivcgJ4oa0zezwcWZi
	 ll6wE7ZKj4LBVsSlUa7SmzgcX8PAqybMMuiJOCNB3W9eR0jVMbqjWIaOIrZx6z1z1L
	 l0JxAfdT2am61meJe1yUzoxJP2lC0mni99serrlI+I4jUegnTeZBTbi2cRPnrNLykV
	 WgfkrBhzESvdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A6E5CE0F64; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 16/24] hazptrtorture: Add irq_release to release hazptr from irq
Date: Wed, 15 Jul 2026 17:18:01 -0700
Message-Id: <20260716001809.11084-16-paulmck@kernel.org>
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

This commit adds the irq_release module parameter, which specifies how
often hazard pointers will be released from an smp_call_function_single()
handler.  For example, a value of 10 would result in one of of ten
hazard-pointer acquisitions taking place in a handler, and probably also
death by excessive numbers of handlers.  A value of zero disables, and
a value of -1 makes the frequency decrease as a function of the number
of CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 0752cedb2f5570..fb25f8351659a4 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -33,6 +33,8 @@ MODULE_AUTHOR("Paul E. McKenney <paulmckrcu@meta.com>");
 torture_param(int, defer_modulus, -1, "Defer once per specified # of hazptr ops, zero to disable");
 torture_param(int, irq_acquire, -1,
 	      "Acquire hazard pointers from irq handlers once per specified #, zero to disable");
+torture_param(int, irq_release, -1,
+	      "Release hazard pointers from irq handlers once per specified #, zero to disable");
 torture_param(int, kthread_do_pending_ms, -1,
 	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
@@ -364,6 +366,16 @@ static void hazptr_torture_acquire(void *hppp_in)
 	hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
 }
 
+/*
+ * Release a hazard pointer from an smp_call_function handler.
+ */
+static void hazptr_torture_release(void *hppp_in)
+{
+	struct hazptr_pending *hppp = hppp_in;
+
+	cur_ops->readunlock(&hppp->hpp_hc, hppp->hpp_htp);
+}
+
 /*
  * Do the delay, the accounting, and the release.  This in intended to
  * be invoked from hazptr_torture_reader, but also for hazard pointers
@@ -372,6 +384,7 @@ static void hazptr_torture_acquire(void *hppp_in)
 static void
 hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_state *trsp)
 {
+	int cpu;
 	struct hazptr_ctx *hcp = &hppp->hpp_hc;
 	struct hazptr_torture *htp = hppp->hpp_htp;
 	int pipe_count;
@@ -388,7 +401,13 @@ hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_st
 		rcu_ftrace_dump(DUMP_ALL);
 	__this_cpu_inc(hazptr_torture_count[pipe_count]);
 	preempt_enable();
-	cur_ops->readunlock(hcp, htp);
+	if (irq_release && !(torture_random(trsp) % irq_release)) {
+		guard(preempt)();
+		cpu = cpumask_next_wrap(smp_processor_id(), cpu_online_mask);
+		smp_call_function_single(cpu, hazptr_torture_release, hppp, 1);
+	} else {
+		cur_ops->readunlock(hcp, htp);
+	}
 }
 
 /*
@@ -660,14 +679,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 {
 	pr_alert("%s" TORTURE_FLAG
 		 "--- %s: nreaders=%d nwriters=%d "
-		 "defer_modulus=%d irq_acquire=%d kthread_do_pending_ms=%d "
+		 "defer_modulus=%d irq_acquire=%d irq_release=%d kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders, nwriters,
-		 defer_modulus, irq_acquire, kthread_do_pending_ms,
+		 defer_modulus, irq_acquire, irq_release, kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
 		 reader_sleep_us,
@@ -818,6 +837,13 @@ static int __init hazptr_torture_init(void)
 		WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
 		irq_acquire = 0;
 	}
+	if (irq_release == -1) {
+		irq_release = 1000 * nr_cpu_ids;
+	} else if (irq_release < 0) {
+		pr_alert("Cannot have irq_release (%d) < -1, disabling.\n", irq_release);
+		WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
+		irq_release = 0;
+	}
 	reader_tasks = kzalloc_objs(reader_tasks[0], nrealreaders);
 	for (i = 0; i < nrealreaders; i++) {
 		firsterr = torture_create_kthread(hazptr_torture_reader, (void *)i,
-- 
2.40.1

