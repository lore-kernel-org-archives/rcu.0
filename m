Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23A35F61A
	for <rcu@vger.kernel.org>; Mon, 13 Jul 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938685; cv=none; b=ulkXPfnzP5xCcASu587KOaHwNnfcJECpL0MCE6MSc7DBfTAE81aZJs45PL5m8LeQUkuakTXE/9fwjo188TfA9c7YxnS90qgINZfSw/sICjm0GfGqWsndC4MPWhc5BMeH0Vy/le2ycAf3Tny5D2eVP0thaI5LPPtZyM+yH/eSePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938685; c=relaxed/simple;
	bh=guyB+6quiEFGX4AsnlbsfiQaXv5z+paJdn/EUo/CSXg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HZFI6AiLZBLXG+q8pHhiMWrk0jqdsUm1ncLAlbJq6Iiesd+zGobutR6+XClfqYE1oSKfaXG0XD5FBpszebYidN03f7KNHV7esXQWSAlGwxxYS5dtN5hO8/97Bjx2QJOiEOLIXmz6TKGUrMW4cPkLB68RbOjcLdT2y8ND5DBGljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oK2MkkjL; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oK2MkkjL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783938681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=DdZw068OCkfwYhuGEqn5npBkDRG5/RkIUC8PHlVzGcY=;
	b=oK2MkkjL4UYqSGcuJGJM4hqpTSBcTNiBD6QhU/XRz+UjPVl/guJxkW0jWr5YSDvpjzCanb
	s0VZAepI/3g9Fo6utQy4WdhvdVyiLnNvnN6z+oncwCfZf3QaO4C3fAjB+cc09UocoNMGCM
	b83HE8e0xt/yUhdswfy/oD2771L3Ijw=
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
Subject: [PATCH v2] rcu-tasks: Remove smp_mb() in rcu_spawn_tasks_kthread_generic()
Date: Mon, 13 Jul 2026 18:31:12 +0800
Message-Id: <20260713103112.29425-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The smp_mb() after kthread_run() in rcu_spawn_tasks_kthread_generic()
from early commit:

'commit eacd6f04a133 ("rcu-tasks: Move Tasks RCU to its own file")'
'commit 84a8f446ffd7 ("rcu: Defer rcu_tasks_kthread() creation till
 first call_rcu_tasks()")'

the memory order pairing as follows:

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

Currently, the 'commit d119357d0743 ("rcu-tasks: Treat only
synchronous grace periods urgently")' moved the kthread_ptr
assignment into the rcu_tasks_kthread(), the following memory
order pairings are sufficient:

The runq's raw_spinlock/unlock(or smp_mb__after_spinlock()) from
wake_up_process() in kthread_run() and __schedule() provides memory
order barrier when the kthread is first scheduled, this ensures
the kthread's func observes all of the kthread's initialization.

The kthread's smp_store_release(&rtp->kthread_ptr, ...) in
rcu_tasks_kthread() and smp_load_acquire(&rtp->kthread_ptr)
in call_rcu_tasks_generic() compose release/acquire pairing,
the cumulativity of smp_store_release() propagates visibility
of the kthread's initialization through the scheduler chain.

This commit therefore remove smp_mb() in rcu_spawn_tasks_kthread_generic().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5a8db89135eb..a2ca79d1dd6a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -681,7 +681,6 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
-	smp_mb(); /* Ensure others see full kthread. */
 }
 
 #ifndef CONFIG_TINY_RCU
-- 
2.17.1

