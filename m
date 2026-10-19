Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAD4EC649
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412539; cv=none; b=NM7Bh6Vmh+JSdX65SZ/XA3Hzujiml5My5i1mlz0twBLV0tSlwl6ztkJVYjQsmk5/+7/WQwzn4HL4hS7kyYifVL4I1m+MYHrKB9zM3vrwUDzlVKpuJ4iFaBLR0h9wtVZ1PB9mjxJpYbPLWQuKbO5SUBI/AFpYJ+FA+hHMtTB82y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412539; c=relaxed/simple;
	bh=e8XRpkvdD7E4aZpJobAsdPMQqsGQoGh3b+KJgMhv7Ws=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bOLVgCVQXEGiQfzu5vftzCreri5i5TXcjmDQqZZNp0D9xx11hrBEVjWyZ42SNnVYK5qPhqpg4NyLcn7V0OkLtf5dFcdyf+e1Uc2U52lCbL0+luQpzdtTq+ZVqnfuOiuPvdvTkYEOWH1urWO17P6s3yfpFB7B4BN6MDV9vDGDiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mqc1ZbR7; arc=none smtp.client-ip=91.218.175.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mqc1ZbR7"
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=e8XRpkvdD7E4aZpJobAsdPMQqsGQoGh3b+KJgMhv7Ws=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792412534; v=1; x=1793017334;
 b=Mqc1ZbR7uzHxNYg+mSnmgKJqkbKQb2o2PS7sor1N6DavgDPd+95AVN19mn4q/WbFQ3sJmqam
 wmgLMqDi1fo6JuoQwVcMqQXwu4suYpNRyQ2mfTx/9ihiB8aJVA8I9kGHFFlHvSlOjtYRPLL7oMr
 cMQWtqA7L/sqk/kXz40knANc=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3dc76d404e419662;
	Mon, 19 Oct 2026 12:22:14 +0000
X-Mizu-Trace-ID: 3dc76d404e419662
X-Migadu-Flow: FLOW_OUT
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Avoid alloc_percpu() failure in rcu_tasks_rude_wait_gp()
Date: Mon, 19 Oct 2026 20:22:08 +0800
Message-Id: <20261019122209.15604-1-qiang.zhang@linux.dev>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The RCU Tasks Rude grace period is implemented by invoking the
schedule_on_each_cpu() with an empty work function, which forces a context
switch on every online CPU and guarantees that all RCU Tasks Rude read
critical sections have completed. However, schedule_on_each_cpu() can
fail (via alloc_percpu() returning -ENOMEM) and returns immediately, in
which case those context switches never happen and also not wait for tasks
to exit the RCU Tasks Rude read critical section, too-short grace period
happen.

This commit therefore replace schedule_on_each_cpu() with a statically
defined per-CPU work_struct, which is allocated at compile time and cannot
fail in this path. rcu_tasks_rude_wait_gp() now holds CPU-hotplug readlock,
schedules rcu_tasks_be_rude() on each online CPUs, and flush each work item
before returning. This preserves the original behavior of the synchronous
API while removing both the runtime allocation.

Suggested-by: Bradley Morgan <brads@mainlining.org> 
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fcac7361ec51..a59aa8b6ab05 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1342,11 +1342,17 @@ void exit_tasks_rcu_finish(void) { }
 ////////////////////////////////////////////////////////////////////////
 //
 // "Rude" variant of Tasks RCU, inspired by Steve Rostedt's
-// trick of passing an empty function to schedule_on_each_cpu().
+// trick of passing an empty function to per-CPUs workqueue.
 // This approach provides batching of concurrent calls to the synchronous
-// synchronize_rcu_tasks_rude() API.  This invokes schedule_on_each_cpu()
-// in order to send IPIs far and wide and induces otherwise unnecessary
-// context switches on all online CPUs, whether idle or not.
+// synchronize_rcu_tasks_rude() API.  A no-op work item is scheduled on
+// each online CPUs, in order to send IPIs far and wide and induces otherwise
+// unnecessary context switches on all online CPUs, whether idle or not.
+//
+// A statically defined per-CPU work_struct is used instead of a
+// runtime-allocated one, which can fail under memory pressure. Each
+// CPU's work item is scheduled with schedule_work_on() and waited for
+// with flush_work(), under the read side of the CPU-hotplug lock so the
+// set of online CPUs cannot change mid-iteration.
 //
 // Callback handling is provided by the rcu_tasks_kthread() function.
 //
@@ -1357,11 +1363,25 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 {
 }
 
+static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
+
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	int cpu;
+
+	guard(cpus_read_lock)();
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
-	schedule_on_each_cpu(rcu_tasks_be_rude);
+
+	for_each_online_cpu(cpu) {
+		struct work_struct *work = &per_cpu(tasks_rude_work, cpu);
+
+		INIT_WORK(work, rcu_tasks_be_rude);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu)
+		flush_work(&per_cpu(tasks_rude_work, cpu));
 }
 
 static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-- 
2.17.1

