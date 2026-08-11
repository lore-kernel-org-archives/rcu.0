Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CD29ACC6
	for <rcu@vger.kernel.org>; Tue, 11 Aug 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408214; cv=none; b=c4/hG/3d4TTdzjIvNjYbVzvboOTr3NFQ2k9VIHpcu+2cjdhIhU4yLhGrJv4mf1lLaswXc1Q2KSehqtIBBHkhd3I4VHbbmDegQBUG426D8mxVxRSKKB4tyEnK+G9trKHf5arsP3wYmuKGD+dZLHwlnEA9hrLZABUnlQ8SGduNws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408214; c=relaxed/simple;
	bh=csmL1Fm8/JJVCbBvwBpjLfWJJQ0cKMhN6+PkppKltlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaHvOPKNSJJ3Ul51Etx6KhKKpLmObnKAbNWHSX7KPB3FRbJodfHPGlwmV7hvW1DB1nzfnHu81LZl79tRClC44GASfAG5Q4GOeCvKtF4kYGlyFLxEnFoRZlhTPSVXefZhREHe8dpI8tnY3lJP3BzR7AHBMQbienKLqEPKSo89nMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f2Uve+hZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f2Uve+hZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786408200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RLxMwvn7nS8UPElVtHIAqpb9TvnwFRl3lYgNErFBttQ=;
	b=f2Uve+hZF6n3HbVMbzBFlN1LXSm4hhSZrKBihOWc6H6W/Q7z3/NkgK1q8pObiw1d8AGzrz
	aBzDrQ+t9W+YFWboZ5oJaRko0UdEqcpxV8uWCe+1AuHsjT6Os+NGEJ+zLIGMGk7mY8oN1J
	iqNUObWd1r+5XfWrYEa01yZ8b4fRWq4=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: qiang.zhang@linux.dev,
	leitao@debian.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2] srcu: Fix WARN_ON() for timer_delete_sync() in cleanup_srcu_struct()
Date: Tue, 11 Aug 2026 08:29:51 +0800
Message-ID: <20260811002951.106631-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The WARN_ON() for timer_delete_sync() means that the caller forgot
to call srcu_barrier() before cleanup. however, it still can trigger
even when srcu_barrier() was properly called.

When a SRCU grace period ends and find that the allocation of srcu_node
tree has been completed, but the ss_state is still less than SRCU_SIZE_BIG,
the mask=~0 causes delay_work timer be queued on every CPU which has
been online regardless of whether it's sdp->srcu_cblist has callbacks.
the srcu_barrier() only wait srcu_barrier_head's callbacks to complete,
however, the srcu_barrier_head will not be inserted into an empty
sdp->srcu_cblist. after that, when cleanup_srcu_struct() finds a pending
delay_work timer on a CPU with no callbacks, triggering a false positive.

This commit therefore add rcu_segcblist_n_cbs() to WARN_ON(), make the
warning triggers only when the timer is still pending and there are
actual outstanding callbacks.

Fixes: 05c3e88488ed ("srcu: Queue sdp->work when the delay timer is successfully deleted")
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202608060833.bce92909-lkp@intel.com/
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 v1->v2:
 Update commit log and modify indentation. 

 kernel/rcu/srcutree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 35fface51d50..be420ecde851 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -753,8 +753,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 
 		// Call srcu_barrier() before this cleanup_srcu_struct()
 		// to avoid triggering this WARN_ON().
-		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
-					rcu_cpu_beenfullyonline(sdp->cpu))
+		if (WARN_ON(timer_delete_sync(&sdp->delay_work) &&
+			    rcu_segcblist_n_cbs(&sdp->srcu_cblist)) &&
+		    rcu_cpu_beenfullyonline(sdp->cpu))
 			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
-- 
2.48.1

