Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B525B085;
	Sat, 17 Oct 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240400; cv=none; b=pj2I4G69nvFlOfrvMGHqR9rKWLe9q22JA/JM503uucXsaBwKXJl15IROfAJke4gfy+n67QGRKSnzHalwwEsOTc0UFMTfZAFyKTq/l8k5thhG+ypr2+7bcgR02OD+paVR82VxpzxBehMuo9ImSNzWiahpLUwwb6wGM7FGB2oOlT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240400; c=relaxed/simple;
	bh=J//YVV17Rz8lySIZhp79mEFRW2ZeKvkLfUp/cNGiZeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKyRevKjAd5qC24+Ceq9pkp5Y17OVUE3SKP04rOBw4UVrkLG8FIM4ZObKW5waczE+1so93BVR50DzeUYqU8EnEnCjDwd2DXM4eXvmIpBedFy80o25LR4D9KGgEgXv/o4u+aC94M+h41p6ZT/3q3OmGjDwyFPFAnpMTBiVimLpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hMqxJrxW; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OGsmcvzb; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hMqxJrxW";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OGsmcvzb"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1792240396; bh=d+UHXAYKQkiIYQf49Dhtfnf
	pf5MZ6LWLy9aT53fZ0LA=; b=hMqxJrxWKeXw3xC+cRp71GVxG6O6dDxxJuMq6LS5rPeRssMFq4
	P9YV+3sDvepMh8IUyvrbBvOVT8+V+meaXtiu9ukxNt7zgwMEAlGysqwQIreevu497vOySgR1cGr
	Ps5JRbm66Tz2maF5bGGyqwYE1QDvJmdDEQ3g1BSdnvc9uiNKL64KuwoeQnJf8XLJMtcMbZxqilo
	JVYNId2TkbDLY4vmDMlG1rTvgF0yYwOY15sAdFHUUIKWPm+3hDsg6xfa64kpcbF+yrmtbvUKN5p
	8k0bfNygeQ1+GMBFtHAJl2SvG2pKcEF1Ab0sulpxCy7gTxhZDpsg4hUCygTxBX4gHww==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1792240396; bh=d+UHXAYKQkiIYQf49Dhtfnf
	pf5MZ6LWLy9aT53fZ0LA=; b=OGsmcvzb35N0uzl/CIJTTZBadGTKUT8Z6FB3jw5j6WPp2IlBQJ
	qQ6n5b+YyCxZLF4s0BUOPxAz+R3HIuObthBA==;
From: Bradley Morgan <brads@mainlining.org>
To: qiang.zhang@linux.dev
Cc: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH] rcu/tasks: Use static per cpu work_struct for Tasks Rude grace periods
Date: Sat, 17 Oct 2026 12:33:13 +0000
Message-ID: <20261017123313.1441679-1-brads@mainlining.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zqiang caught a snafu in the rude grace period, if a too small grace
period was reached, a UAF could occur. However, his patch used
a WARN_ONCE() on schedule_on_each_cpu() OOM failures, which would not
have handled the failure properly.

Instead of throwing a warning or relying on dynamic alloc_percpu(), replace
the dynamic allocation with static per cpu work_struct instances. Using
schedule_work_on() and flush_work() keeps everything in task context,
guarantees the required context switch on every online CPU, and stays
zero allocation so it cannot fail under OOM.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/rcu/tasks.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 627295396cd9..f81c0ea0b92a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1348,11 +1348,25 @@ static void rcu_tasks_be_rude(struct work_struct *work)
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
2.53.0

