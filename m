Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E44221FCD;
	Thu, 16 Jul 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161095; cv=none; b=lj+TofzPKUGyor6t0Q+0ytkOS74DT8yaHKqaGKGlObv96CzfbsophPxUJY/HVAD2rCOvWibKi8I/lC3jdvIswoKWeKD11Wp5YY/LLB5LJZJRF6uhHRSE53JinZwchcfjYT0N4TPfAeJLaZGfGqmVIRJg2nZ7pQwSAsMOW7DoudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161095; c=relaxed/simple;
	bh=M6BVgZFSjILX5HaRUmyWETnbG02BYPqnpcsDUfsXXbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKe8l7ZhYWp44E6Ot8GSSnKffzljVXPq6i3ZAJX6WdKwzezL0a4y1sCRcOa/rcPexjijCsYV9/O3ZGaWau0Ak4O6EMQeLgnCl05NE4EHRWMHQBD/mDjAhOyQ7U0xv+cbsOhyBJ/9q7uXjWyS8tK0i0ciC3Oa+2W1FHY2sA32kEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddsru8iT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddsru8iT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75F11F01560;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=o2QKJb1SmUARMMLEAEctoR5D5DIckgM5bthyhdFJHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ddsru8iTWOAIVD8vlpGVCpkR7Vm+Abkp36rkU4MrtLBVenOxLqj2uGVENQM/bjhWO
	 uBbGB8hoi42udhDib2CP7I8VRlQddoyhwezzffXNC8qsK1GqJuDHo7UmMXLWQJ/Dh5
	 b9bapr1KaVhR+zdB30lbiYUMBnUXzN8x1d+8frNjIiJS19MkdcoylPvfXQMLGX/o/t
	 NxPs62NBCTOVUeGg9Egvo3e0vZ8Nv3SqQFIKj9fHsYp1J8n2EPaLsU9EdfMtQtDOJE
	 cgwg+MuqqonfXp8Ty2PVOdouORzzZpsLIJBN/l7SHs5R7Pabh1eEHzxRKAu01ofvDf
	 xRILLdytXXt2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 408A3CE0E8C; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 12/24] hazptrtorture: Add irq_acquire to acquire hazptr from irq
Date: Wed, 15 Jul 2026 17:17:57 -0700
Message-Id: <20260716001809.11084-12-paulmck@kernel.org>
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

This commit adds the irq_acquire module parameter, which specifies how
often hazard pointers will be acquired from an smp_call_function_single()
handler.  For example, a value of 10 would result in one of of ten
hazard-pointer acquisitions taking place in a handler, and probably also
death by excessive numbers of handlers.  A value of zero disables, and
a value of -1 makes the frequency decrease as a function of the number
of CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 8b1315e2d1d1a6..3304eb450d7e32 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -31,6 +31,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmckrcu@meta.com>");
 
 torture_param(int, defer_modulus, -1, "Defer once per specified # of hazptr ops, zero to disable");
+torture_param(int, irq_acquire, -1,
+	      "Acquire hazard pointers from irq handlers once per specified #, zero to disable");
 torture_param(int, kthread_do_pending_ms, -1,
 	      "Delay between cleanups for deferred hazard pointers (ms), zero to disable");
 torture_param(int, nreaders, -1, "Number of hazard-pointer reader threads");
@@ -351,6 +353,16 @@ hazptr_torture_writer(void *arg)
 	return 0;
 }
 
+/*
+ * Acquire a hazard pointer from an smp_call_function handler.
+ */
+static void hazptr_torture_acquire(void *hppp_in)
+{
+	struct hazptr_pending *hppp = hppp_in;
+
+	hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+}
+
 /*
  * Do the delay, the accounting, and the release.  This in intended to
  * be invoked from hazptr_torture_reader, but also for hazard pointers
@@ -399,6 +411,7 @@ static void hazptr_torture_defer(struct hazptr_pending *hppp, struct torture_ran
 static int hazptr_torture_reader(void *arg)
 {
 	bool can_defer = !cur_ops->onstack_ctx && kthread_do_pending_ms && defer_modulus;
+	int cpu = 0;
 	struct hazptr_pending hpp;
 	struct hazptr_pending *hppp = cur_ops->onstack_ctx ? &hpp : NULL;
 	unsigned long lastsleep = jiffies;
@@ -417,7 +430,16 @@ static int hazptr_torture_reader(void *arg)
 				continue;
 			}
 		}
-		hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+		if (irq_acquire && !(torture_random(&rand) % irq_acquire)) {
+			guard(preempt)();
+			cpu = cpumask_next_wrap(cpu, cpu_online_mask);
+			if (cpu != smp_processor_id())
+				smp_call_function_single(cpu, hazptr_torture_acquire, hppp, 1);
+			else
+				hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+		} else {
+			hppp->hpp_htp = cur_ops->readlock(&hppp->hpp_hc);
+		}
 		if (!hppp->hpp_htp) {
 			// Still starting up, so get out of the way.
 			schedule_timeout_interruptible(HZ / 10);
@@ -635,14 +657,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 {
 	pr_alert("%s" TORTURE_FLAG
 		 "--- %s: nreaders=%d "
-		 "defer_modulus=%d kthread_do_pending_ms=%d "
+		 "defer_modulus=%d irq_acquire=%d kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
 		 "reader_sleep_us=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders,
-		 defer_modulus, kthread_do_pending_ms,
+		 defer_modulus, irq_acquire, kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
 		 reader_sleep_us,
@@ -786,6 +808,13 @@ static int __init hazptr_torture_init(void)
 	if (torture_init_error(firsterr))
 		goto unwind;
 
+	if (irq_acquire == -1) {
+		irq_acquire = 1000 * nr_cpu_ids;
+	} else if (irq_acquire < 0) {
+		pr_alert("Cannot have irq_acquire (%d) < -1, disabling.\n", irq_acquire);
+		WARN_ON(IS_BUILTIN(CONFIG_HAZPTR_TORTURE_TEST));
+		irq_acquire = 0;
+	}
 	reader_tasks = kzalloc_objs(reader_tasks[0], nrealreaders);
 	for (i = 0; i < nrealreaders; i++) {
 		firsterr = torture_create_kthread(hazptr_torture_reader, (void *)i,
-- 
2.40.1

