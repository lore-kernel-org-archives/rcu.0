Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C543BBFCB
	for <rcu@vger.kernel.org>; Mon, 10 Aug 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359347; cv=none; b=K206h2t8sNXBJrPYqAGE2j8MZVIFmkrjKpeKEWS3Nu0Yw1KlS4aiTVESinaQ6Pi7i95DDzGadkgq/sgwJCFMZFPUDNu/nr11K7TcAJ4wpECYMYIQAb5yOxzgCMLYPn1wd+X4uyJm6BkVk5/YxMRKCj5a6HxeoWlpjVk5KofrjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359347; c=relaxed/simple;
	bh=qeXWIqBfHAkAaTv+q1lIIUSS6OEGRcAe3dmLubmVVpM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pTtD3/rhaqLA6NHCVOzWI5vUj/6Fevzjw6bncwYTL6MdRXH7RIA39329wIR/3BSxKmWZOxfZ1d1PlVvpGvJaQRxmzNLQf2xSKUs7pgf2FO2xB51CqqR+q0nvvYAgejmWw95vDqq6pa4j9VbjtiDLybVVo+6WEBvUDv3CCt9tBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W8dqcDcY; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W8dqcDcY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786359333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=S0/c+TFXi4CcHaO0LSruu19Vq9Mar/rn7dR4O6tfvx4=;
	b=W8dqcDcY/aw/VEaizwYgYLnvlOtW4XceHX5RxQ56FF7P1HLu6b8EjMoZ8vO838yHkUzg62
	t5cvgav1mWebevUrMV0PgpzwifmiafrpBHGNJCBYMAYkPkvR/0cGfucMkYeiRS0td9Y7gs
	quXSykwEU2i89fc9EyV0xgWJCgLWHEM=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	urezki@gmail.com,
	boqun@kernel.org
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in cleanup_srcu_struct()
Date: Mon, 10 Aug 2026 18:55:22 +0800
Message-Id: <20260810105522.19022-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The WARN_ON() for timer_delete_sync() means that the caller forgot to
call srcu_barrier() before cleanup. however, it still can trigger even
when srcu_barrier() was properly called.

When a SRCU grace period ends and ss_state < SRCU_SIZE_BIG, the mask=~0
causes delay_work timer be queued on every online CPU regardless of
whether it's sdp->srcu_cblist has callbacks. srcu_barrier() only wait
srcu_barrier_head's callbacks to complete, however, the srcu_barrier_head
will not be inserted into an empty sdp->srcu_cblist. after that, when
cleanup_srcu_struct() finds a pending delay_work timer on a CPU with no
callbacks, triggering a false positive.

This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make the
warning triggers only when the timer is still pending and there are actual
outstanding callbacks.

Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is successfully deleted")
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: kernel test robot <oliver.sang@intel.com> 
Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/ 
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 35fface51d50..090dddfc7463 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -753,8 +753,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 
 		// Call srcu_barrier() before this cleanup_srcu_struct()
 		// to avoid triggering this WARN_ON().
-		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
-					rcu_cpu_beenfullyonline(sdp->cpu))
+		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
+			rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+				rcu_cpu_beenfullyonline(sdp->cpu))
 			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
-- 
2.17.1

