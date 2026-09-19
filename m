Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C537A857;
	Sat, 19 Sep 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776066; cv=none; b=AExozoJHvOlgiIV4gSwMkh6ZadzKWPVgmG847Gl2nFRS6e5sv0bGQexDvWfISab9qiNBfpis0/Alu7OjZvstDjExa+r/tuTiDbhrTArny7YrGbp4xxOJeIvtkhJ1jysQIMPJ1anpOQfGfs/szVHWGs9M4LPRA3eEVusOzbqZecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776066; c=relaxed/simple;
	bh=aDtMveuzkicr3ZH7Riodyvayp7OGAhUI2lt8EFgxZ+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2/GnjTZYvt2/eUYyFhylEY//YVQNYRYa3CsotTLLTvhzjiQAZK2LF9AICblWkpDzmnRQAJGAOjCgvC1Jw9zmLX4pmNT9MbJC0ky7VHr/ODUoPZenJyf8oMtdz4jCqXG6XVu78ZpT4gcvTmn2xnHHJ/BiwAG5burguruWqg63Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks6LgU6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks6LgU6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA731F00902;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=ZUqGw1U4xWEhkLvILWW1b3zulxPP0XvJl6r6j3x+lV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ks6LgU6bRrHIXZZdAzw5Y2nBcURqUJP5e8LO3y0qj9u81/xuqWui3gOtxksdZsTt3
	 JQCm3pmo89U6QQS8LgpO1WfP7OKSRLOA0RdyEOakYgy0tqqbu9tmE89b4sowFbwSbw
	 DYWT+RYDKJeWKOLTLGdPxLq7nw9tLWcEv5wnQs+6oqoPhlKkqXpNF6emLJPjoHYlCr
	 w/uUSgijnH4zcqC93tj93joW4YKSiN1DyHDFxDc3brq8l9cqVVZTeV9tLTWsKlB1aF
	 fvOdeH3Y47co0rbwn0bkNhy1FxSOLsh9FbqK3/5jKFh8cqxG4zIixFRFwKVKnhZmXZ
	 Kr6pU35kapffQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 77937CE0E27; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
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
Subject: [PATCH 16/28] hazptrtorture: Add irq_release to release hazptr from irq
Date: Fri, 18 Sep 2026 17:00:44 -0700
Message-Id: <20260919000056.3132131-16-paulmck@kernel.org>
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

This commit adds the irq_release module parameter, which specifies how
often hazard pointers will be released from an smp_call_function_single()
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
 kernel/rcu/hazptrtorture.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 045ab6fc7ba2..5016d04d1bae 100644
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
@@ -659,14 +678,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
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
@@ -817,6 +836,13 @@ static int __init hazptr_torture_init(void)
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

