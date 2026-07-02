Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BF30F7EA
	for <rcu@vger.kernel.org>; Thu,  2 Jul 2026 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987096; cv=none; b=Otg7xkIkeRO/nJKDvWnfWLAGKgL7xHC6nyEpXgD0jMj7J4J6hAWIYWpFMASi8noTLhm/QHPKzEip/VUG15LOgRu1cxNC1KKNQ/9ARJCbX6C6cxRom+3m3sYVWlA7abWxXBdD4rt1JokJ+qEZUO1mfxc1Z4RNbBNk+GW0hBS90MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987096; c=relaxed/simple;
	bh=vXBY8X1VpcE86nsXf4rfCzfnmeVf+t0i6VLgBEGtHjE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hSuZgPZ4HARBZkFvmqQJ+a6LbJhEPNF6EuTuXKjdH3KFwVJ4BQg9MTwbLEV9f/EJOFMURshmJsDhLZyMJvN4uStYk5pXQ/IHv28cPvPPBXd6mhLxWUxQbZZxEehIgk6WtLNLVBCq0uspzQWhIpMMVugeouOE27DwUf6jzuPWscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3sDL/UP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3sDL/UP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782987093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=VpcrzsL+LYGt4tdSKZjEyyQfxAn9oxbx7N3Ne5akxOk=;
	b=F3sDL/UPThwpT8tXNPRg/n27VLSZA7iL/OTSW7ZbXBVG2D0ZE99X+DDqXWy58E9cntAhc8
	MwaZbxpeRrr5EX90VjRriKuICO8GhNakQ4ebuj97GHwEzFTIYJcSupw4SIJsiOZFLwkms1
	fgjiLOju21bgVrh2Df8rFnm1B/1lV3s=
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
Subject: [PATCH] rcutorture: Use __set_current_state() set task state in rcu_nocb_toggle()
Date: Thu,  2 Jul 2026 18:11:25 +0800
Message-Id: <20260702101125.14100-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

In the rcu_nocb_toggle(), the schedule_hrtimeout() is called after the
state assignment with no condition check. the release-acquire pair from
raw_spin_unlock/lock(&cpu_base->lock), guarantee that task->__state is
visible to the hrtimer callback:

              CPU0                                                     CPU1
__set_current_state(TASK_INTERRUPTIBLE)
->WRITE_ONCE(task->__state, TASK_INTERRUPTIBLE)
schedule_hrtimeout
->hrtimer_sleeper_start_expires()
  ->raw_spin_lock_irqsave(&cpu_base->lock)
    ....
  ->raw_spin_unlock_irqrestore(&cpu_base->lock)

								hard-irq:
							raw_spin_lock_irqsave(&cpu_base->lock)
							__hrtimer_run_queues
							->__run_hrtimer
							  ->raw_spin_unlock_irqrestore(&cpu_base->lock)
							  ->fn(timer)
							    ->hrtimer_wakeup
							      ->wake_up_process
								->try_to_wake_up
								  ->READ task->__state

This commit therefore use the __set_current_state() to replace the
set_current_state() in rcu_nocb_toggle().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b1bab59efde5..a0e6901e0f90 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2947,7 +2947,7 @@ static int rcu_nocb_toggle(void *arg)
 			atomic_long_inc(&n_nocb_deoffload);
 		}
 		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
-		set_current_state(TASK_INTERRUPTIBLE);
+		__set_current_state(TASK_INTERRUPTIBLE);
 		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
 		if (stutter_wait("rcu_nocb_toggle"))
 			sched_set_normal(current, oldnice);
-- 
2.17.1

