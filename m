Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946F41168B;
	Wed,  7 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406770; cv=none; b=B63xMfYltNyMe7ranjchJwFzB8RsxVPOSJuD9L+y+y2Z/PErqh6xSlBSnggmsakwksRkmBp07Uk+JLrN/9+RJhzSWg7KYnV2V3okmq3qgvj9eGlG+TfpviIcWLgftJQv0ibY3K3pnLqoBf+MIUd0t6k5TPxoT81KZ/tIRshnCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406770; c=relaxed/simple;
	bh=ClYlIDlbUBsAgqH+RyqB+In8rjlqkRmKPJtbV7oJ/+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrLRZQxvM0NJv6FAcR/Nql95v+qVgUPngU1wibSb4piZiCxviT8Yz7wY5CXyBi/PNQBvsD9MlWa52p6B43QKF+ipondxnwhSlpxOHAjo0anNcu50OCiDLJuUa7PEcMFYDIOclQ6NgwNnrE0zLpByOHI5/1ze3eNDqHbUsARqf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5H50knY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5H50knY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97041F00899;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=+tf1v70g+i8fJOH6gBW9L9fZoO8Sctx/8euetYksTb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5H50knYH+uk82sJcVhy0ygFe8hR/ou7MIvhVuEEsyvRG/r7NwWhI8nVE9LhEs0om
	 hNzEebCeMLlJ/5sCK6oHXUmSbCHHEQ7rlimHvaR08mXV7wNttMDBltZsmphTYNDHEp
	 snkCkQjHq+7oFMhsQNAaSnZ714nlgK0eAHkmjPGcUhaSNzMvj7agI76s966h8RMYcf
	 ttd5+XiD1M6syTDSmsmgABMy74ds81fbOFK+BpPDIq05gxa4sdSNQYr0XJsBUxU9aj
	 F3dt7RAbubyFK2Gx/DQZ/2oo7Cr0Zbd5yjRzkY0NeW8FDQJM1W1iH8Onpd0cpMfbmq
	 kzjVwCZK88fcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 23C25CE2742; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 08/21] srcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Date: Wed,  7 Oct 2026 13:59:11 -0700
Message-Id: <20261007205924.1983367-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The irq_work in srcu is used to schedule a delayed work. The work item
is not scheduled directly because it is not always possible wake a
thread directly.

On PREEMPT_RT the default irq_work is initialized with IRQ_WORK_LAZY and
is delayed to the irq_work thread. A system booted with the command line
"trace_event=…" will freeze during boot because the irq_work thread is
not yet deployed (and tracing uses synchronize_srcu() in
tp_rcu_cond_sync()).

The irq_work performs just a wakeup a thread, there is nothing wrong
with doing this from hardirq context on PREEMPT_RT.

Use IRQ_WORK_INIT_HARD for srcu's irq_work.

Fixes: 7c405fb3279b3 ("rcu: Use an intermediate irq_work to start process_srcu()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 672fb41345c91..64081c8eacc84 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -259,7 +259,12 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static, bool
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->srcu_sup->work, process_srcu);
-	init_irq_work(&ssp->srcu_sup->irq_work, srcu_irq_work);
+	/*
+	 * trace events started on the command line require SRCU before
+	 * the irq_work kthread starts. Since all it does is a simple
+	 * wakeup, having it as a hard irq, even on PREEMPT_RT is fine.
+	 */
+	ssp->srcu_sup->irq_work = IRQ_WORK_INIT_HARD(srcu_irq_work);
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static) {
 		ssp->sda = alloc_percpu(struct srcu_data);
-- 
2.40.1

