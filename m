Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530993;
	b=hWDLgWEed2I5EaAHg+HS3Q+nqyIVlUQYPxCc6Vuy+9tktbfxp2OQXVJM+FzPDvsfdByI
	 d5EpEgYXvyzb+Km7YguhYhJVmcFZNdSCXCL1ydQPaijVOjV34tSyWGD7sb/tMsYr+NLbu
	 1gOBtd0xSsAE7ylPzEu1P8PPq5/IrLujoUJb35qOQb6fLwoX/hLwvahUD7vO6oLZJTdYa
	 KYGoGjHmFAv14ogsFtnWn9EpJ+D5y2fb41J5Q0BqzNnT9ruUoHY4Ag7sOM6Ly6zpmQ50n
	 prBQemojv4IV92jvUw3Ewfa0MHtgVxuc+2jMGXN3FFSYYuXk8OsMlVYjR9mwUGmXK0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BtqRQYWJz1FxpEXn8uRRkglHdLqa9ytBLROzu5x/QHI=;
	b=1PsmRft/HiGng1Qbcni2aZWTYgK2YNH07VJXuhKs5ga8RPaUomLWlCu11td3Ly97vdvR
	 xy8pfjVzZPY7GKRDc+lvZo8m8VDaxdgIWw4QuZtu7GnGiYoheuBX5mX6udMcY3I7+3YWR
	 hPYVVLYkXdF728ull3t9pD9DAZJgbj/CMKYVZoWw8d0E2shfwEcxn/rVtQGD7F30Kp/In
	 f1IqK87Bir+ad2Mfu1tKp/4d96a9w/AMXlsreyb+ljiHJrizGuIdvDrqMyo0PTxLoCHm6
	 qE1Ysx0yCHxYRjeNz0VroYt3b2g9Drhk87RiPDCwQSp+w4t+zSTKcDG974+J32M3TXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRpTllLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8E72F606A88E;
	Fri, 13 Nov 2026 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRpTllLk
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D0B481F000CA;
	Fri, 13 Nov 2026 00:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794530993;
	bh=BtqRQYWJz1FxpEXn8uRRkglHdLqa9ytBLROzu5x/QHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRpTllLkKDal2ZvuY6Eixhzu2B7UefpPHm8f5FR3QFGU+aA2IjE20qgWh0n6jCKDG
	 L8X2ORI0To9BfM11xvfVmdLZgKSmKBCahKtt3B01AwslmgY99NNOgUQS2ZtGDKbkfn
	 rCGhw4gQrFn8JtET9JbvPMVqWD7TJC1jUhgX047dLQHoGBn56bN1/CY0NacHD4nHJP
	 w/Y2LuQOH8DHHeggjYv8wCQr4Oa7bZCbJywtUfl2oVsDznThrED8mfjZSWmbD7Sy8h
	 2T8FSfb71ImXcyJNOp2w8GRB/FF+qRoqL8bMoo77yZpHQYhNXmB0C5Gg+e14Y1trKw
	 w5uMyRQvdlx2Q==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH for-v7.5 2/5] rcu-tasks: Avoid alloc_percpu() failure in rcu_tasks_rude_wait_gp()
Date: Thu, 12 Nov 2026 19:49:41 -0500
Message-ID: <20261113004946.2758197-3-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113004946.2758197-1-jfern@kernel.org>
References: <20261113004946.2758197-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
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
2.54.0

