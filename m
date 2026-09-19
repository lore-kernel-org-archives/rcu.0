Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28D3314DE;
	Sat, 19 Sep 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776064; cv=none; b=qE/LyTUreK4A/Td/JQvPQwQ922MKTU0gBgHiSyb77jfGbDr0Iyreg4VODHXX6WiJDeX1nFn2NF3tCFxb7VWj/7xG68gVl+x53B/8tFsVB4uM4QPQ716Q0l22yGaIyL3rXxJqHDKrE1VaTmNMEVZUDFZcZBvfryNn7M6p4AT8yNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776064; c=relaxed/simple;
	bh=iaZV3IG8J0Aiq2rSuuFWdI5UzAZ31i17fi4VmWM2hvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZ1Y/9n4l1laoCuGA+/6tqN99vweMY2CLEIXYieOCN1OuenH31hQlu0sEKkH4UnYxtYs3aNzUGY5NtUyk8T9dLJialx6ko1cjIPvAlUG59T4o73pc5p5bzAHhD7kMRb/EaQmMwO7t9p1YCGLFQ2RG6LyVS9YfHuT78vvROVZ4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orBQ1UXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orBQ1UXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E653C1F0089B;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=CnSiDLJ7QHHXSz6IC5OgMA66MRnY2X7v8dzQ1csx5U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orBQ1UXHxoeJMcxVxFPHnJ27QqvFxuc8BKb2LuqneWF8NlkUW1qRekAmmfpS9w7kW
	 ejubyANPdn/f0y+sSwd3qVq4I2oNgtCKd6hXtUcHv2assjsjeJF/L51Unv7vN3UE3o
	 ZONiyd5WdRKJu2tErp7e4cil5+oFzD+NoWa6eWwOFVin1ehYR1y2N3x/GOTqSkm3bb
	 tp0qImFujAtHlJYJjqgaYecC7zPz7W2FHz9QHD7b8av8IzpoBqP/dB5Hmt2KTx5HLF
	 YfSSNh1pP9uuHV17NDbcugFknMQ3ql+xAvo6pPPJJBstBuWfC/nwaWOw19P/4r2d/X
	 PL/Zb1wZtzicA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C835CE0C44; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 12/28] hazptrtorture: Add irq_acquire to acquire hazptr from irq
Date: Fri, 18 Sep 2026 17:00:40 -0700
Message-Id: <20260919000056.3132131-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the irq_acquire module parameter, which specifies how
often hazard pointers will be acquired from an smp_call_function_single()
handler.  For example, a value of 10 would result in one of ten
hazard-pointer acquisitions taking place in a handler, and probably also
death by excessive numbers of handlers.  A value of zero disables, and
a value of -1 makes the frequency decrease as a function of the number
of CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index ff253fe35ca2..dc148894786b 100644
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
@@ -634,14 +656,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
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
@@ -785,6 +807,13 @@ static int __init hazptr_torture_init(void)
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

