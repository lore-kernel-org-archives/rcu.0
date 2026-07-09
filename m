Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1737B027
	for <rcu@vger.kernel.org>; Thu,  9 Jul 2026 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591574; cv=none; b=PjOwwxe/+PAKYsHL/xzODYpW9+udUrgulcnreByPdSCxPhIDPp/RiJLWNN1/YJRu1j/wqyvADiHOV6IiC049zLrmcM1U+GgeqwH3n+dyC1KgMH69ZaKEKxdEW0TRm8MTXzVwyXDmT60KqSQ/SsgD6+f8/6afGhI5si2ZxZCIpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591574; c=relaxed/simple;
	bh=WEfxnlKngtkjWSOkjSVZL97A3/35dYp3+/HNvWnzFKQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jDbWQ4BD6zZYfntW9yadVs+/Pzgnd0kkHtOxnv6a/AR9lparcRBTIlDm1H4x2gXAc9V90O//Lj+F4692OccejuHhVwZyorblCLjJhVWaLIdQZ8IJdcFODdxRT6+zFFGKKGbUoBlgbfrH+V0nadUDd2VTRApQSfG4169+POI4hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vOP71zTo; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vOP71zTo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783591570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=WzpRcNLeleHuaLrfhlaWkFZ7FFcNOi/6rUOgRO01pPI=;
	b=vOP71zToodqXQ5L4CZ24aQH8cxgUZMGcKKZ+A4N4fk2ZN5/sYIK091ZtDIwRY9moWQ2fA1
	FWa1VUnMsHd06tD+Xqtkn6gdG3E3DTLaDjgC2fvPatntnsVPixJOcZJ29vHd3tpnuwAac1
	DVLoiTfNXquFzkuxDqfy9ypgwLR6IA0=
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
Subject: [PATCH] srcu: Queue sdp->work when the delay timer is successfully deleted
Date: Thu,  9 Jul 2026 18:06:02 +0800
Message-Id: <20260709100602.821-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

In the cleanup_srcu_struct(), when iterating over per-cpu's srcu_data,
the timer_delete_sync(&sdp->delay_work) is called to cancel the delay
timer before flush_work(&sdp->work).

However, if the timer_delete_sync() returns 1 means that it successfully
deleted an pending timer before it had a chance to fire, also means that
the sdp->work cannot be queued, the subsequent flush_work(&sdp->work)
will returns immediately without waiting for anything, this causes SRCU
callbacks to not be processed.

Fix this by checking the return value of timer_delete_sync(), if it
returns 1, explicitly queue sdp->work so that the following flush_work()
can correctly wait for the work to complete.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7..02c322b7c6f1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -725,7 +725,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		timer_delete_sync(&sdp->delay_work);
+		//In most scenarios, calling srcu_barrier before cleanup
+		//will not trigger WARN_ON().
+		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
+					rcu_cpu_beenfullyonline(sdp->cpu))
+			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
-- 
2.17.1

