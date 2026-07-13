Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4D36604B
	for <rcu@vger.kernel.org>; Mon, 13 Jul 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938696; cv=none; b=Bb3eTLZWnhudgV3nEVkZPxqT7EaaxMWDmcOyzYFjbXjrEUDVy3gOKfUwDoO/IODS2qBReTrSAQ+PnP5nN9b8QCug3eyy6+ltf7ajoGZ3iAxxdyNXhD6LB7p6EiVOSKwHGjFLynfWTr5uPUStyjCBhDYzxLOV1r01c6jIE+IfL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938696; c=relaxed/simple;
	bh=cetrw9vLlxTzhdEU47+iSwxho7Loh07LFgMKVvSZCeM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t+/81xlOfuF5/Ldp460NTlbkG3ejtmuQ0+bRz6IcoJv5EXEcwxjyKgyq4cd7Nq3jRg2bEztfVIAQJfoEuGLkkTJD3UPCCfNmd1dfy7ieUO1IspT8taymOkW6O/lcQXIUs4F0z5ja9/v84HFPJh0KFYNUdP3fUHaBWCcqHwO/Y2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dV1KNKDn; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dV1KNKDn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783938693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=d2lw1fCsJANUm53zNf4w72X0FjIibByAUvFi/qkzlIc=;
	b=dV1KNKDn2h0ggpn/fu3FH8QDfiRN0eqlnD/XA5m4BzJBLIPbfUtXSqs9jZRTfMn8Z4/y05
	9JnWJIQpfHrD+wN5N3XQGZQkEBZrJ030oczrPzXdwxbB+Ilgxkyd84M17CiewqbflYOQub
	udYwoWmhFeFFT91+uWfSysKb1QMlwwE=
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
Subject: [PATCH] rcu-tasks: Update comments in call_rcu_tasks_generic()
Date: Mon, 13 Jul 2026 18:31:26 +0800
Message-Id: <20260713103126.29782-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Currently, the comments: "We can't create the thread unless interrupts
are enabled." from 'commit 4929c913bda5 ("rcu: Make call_rcu_tasks()
tolerate first call with irqs disabled")', now the kthread creation
has been move to core_initcall() time from 'commit c63eb17ff06d
("rcu: Create call_rcu_tasks() kthread at boot time")', and use the
irq_work does deferred wakeup. this commit therefore update comments
in call_rcu_tasks_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a2ca79d1dd6a..089a0d5a5cc9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -395,7 +395,11 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
 	rcu_read_unlock();
-	/* We can't create the thread unless interrupts are enabled. */
+	// We can't create the kthread with interrupts disabled,
+	// or a spinlock might be held, the kthread creation has
+	// been move to core_initcall() time.
+	// at the same time, use the irq_work does deferred wakeup
+	// to avoid potential lockdep splat.
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		irq_work_queue(&rtpcp->rtp_irq_work);
 }
-- 
2.17.1

