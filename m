Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1876424640
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684277; cv=none; b=MZNr6CX66GWjjoUsI0XDtrotkYT6FosSw3WobxirvfnGWzYw7Af2F0Ael+nUB0uxX1eAu3LyKeh54k+MiU/Yq2gkHauW8PkiOVKZNQnLLlUHO1LgBdgHtcQB3D0AWnIKgpH5XXnB7NfANA3oP5AaPIbOyerYL0pdkJY3RzuHuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684277; c=relaxed/simple;
	bh=vyX5xrxHROORiWAjlRlcQw56LChl0dz+9gQa4MikS34=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ik9BxSbDdODzkW19U+O5/8FeRnkgFUrfp07UjnFLvyThaoR16M12EU4tE2G6cFPJMrT6/nlap2LiZ3kAlq+I9vkrZWlwotBOOenRQuUw0/m/ct/9pehu+NQEuQk/duYPoa253qbj/2HudK4bwm72WIhqIL4iBonv30FDqKdw7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JsnzoTtv; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JsnzoTtv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783684267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=kXpgfPsUsYLrLKL6idYqW10DMIxygu0DJmdPH4XYS+4=;
	b=JsnzoTtvhwM/3uBpWh1yb/ezoe2s+wQVsyopWU2gnUcs03AzcYxOGccwpOmmp5qbtCEeig
	I2MuqM7aC0d/Q536Jtpj8qlGhWlweZY4aV15mdh5zjn7mJqRmeps4F4iAG+pt7asFXojRW
	RB2jO82dzoexHsuD4he4cwHxvgLDzSY=
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
Subject: [PATCH] rcu-tasks: Remove smp_mb() in rcu_spawn_tasks_kthread_generic()
Date: Fri, 10 Jul 2026 19:50:28 +0800
Message-Id: <20260710115028.30303-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_generic()
from early 'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its
own file")' and 'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthread()
creation till first call_rcu_tasks()")', the pairing as follows:

rcu_spawn_tasks_kthread()
->t = kthread_run(rcu_tasks_kthread, ...);
->smp_mb(); /* Ensure others see full kthread. */
->WRITE_ONCE(rcu_tasks_kthread_ptr, t);

							call_rcu_tasks()
					      		->if (READ_ONCE(rcu_tasks_kthread_ptr))
					         	  ->wake_up(&rcu_tasks_cbs_wq)
							    ->try_to_wake_up()
							      lock pi_lock
							      ->smp_mb__after_spinlock()
								//see full kthread

Currently, the 'commit d119357d0743 ("rcu-tasks: Treat only synchronous
grace periods urgently")' moved kthread_ptr assignment into the
rcu_tasks_kthread(), the following pairings are sufficient:

The rq->lock/unlock from wake_up_process() in kthread_run() and
__schedule() provides a memory barrier when the kthread is first
scheduled, this ensures the kthread itself observes all of the
kthread's initialization.

The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr) in
call_rcu_tasks_generic() compose release/acquire pairing, the
cumulativity of smp_store_release() propagates visibility of the
kthread's initialization through the scheduler chain.

This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5a8db89135eb..18ab335665e3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -395,7 +395,6 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
 	rcu_read_unlock();
-	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		irq_work_queue(&rtpcp->rtp_irq_work);
 }
@@ -681,7 +680,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
-	smp_mb(); /* Ensure others see full kthread. */
 }
 
 #ifndef CONFIG_TINY_RCU
-- 
2.17.1

