Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BFD3164C7;
	Sat, 19 Sep 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778142; cv=none; b=CUWfVLxEzejr1Mwb5Mz0I/xj0wYIlStlNyTni+9eTS8/9JeEwtoCxfOXqxKV6jl5jLHhTbLBknr/335Vyn/BtKYggIBUEMdJXWSHFfPLq7RTOAYZ3OF7FlLtLO3lK7wAXeLuXMcd5CJZNHkvwK6860HfRvVlukqe6ffefM4zbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778142; c=relaxed/simple;
	bh=hhcXGkH7lGAK1LD3P8ZrtvZ+GRmYFcqsnwrzrihyZlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9fYRh9k8K7OX2G7mlWKx79Lf6vH2rfzcy9CpmhgqpjD/5EgUZKHXZ+rmiVZPaMmCw64oKdG8B7P1eNPea1fiIISkZli+UZULoHwjnREI3B5Lu+cAL6pMsuIM92x05WiQwkWTavpHBYLIcmAWo9/tm55SFWK8fSPvuLZprlOUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPmgsAcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPmgsAcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E391F008A3;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=cy/tNyQwWWPjWMsVG/mqE0zRzTrTjChpUOrBkRWJQUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PPmgsAcUz+dpw4rVVo5XESd1FX6or3YG53hUPToJrFJNQIpZJsO9Zy+vvWrcqCPsI
	 dBBxGcLqStGFvqpPrKk07rgQzHTwDQODWGnfJxfu1PqWa/Z/Cp7oStNAuiDyB+f5ut
	 1KlstOqWpPRmEstS0qjsDhZIi8Cek8JkFc9e4yiJpjgrazHcpY4liYymIRe/V09DQp
	 Yt/mPDqQH8YCbNaa6538AWaiUoFbLO+g8K2/2YFI6ts0e9amyKOTGYP1dBiz7m/1l5
	 ifM5BmARJglGOz77tPq9aORiuEGCnDeOOXcpZ7B2CoSjrAhUzvTDRakmdJ7yF4J513
	 jJiEvi5/567Lg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A5871CE1886; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 08/19] srcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
Date: Fri, 18 Sep 2026 17:35:10 -0700
Message-Id: <20260919003521.3134552-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
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
index 61c2375ba2ec..6625420cfb43 100644
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

