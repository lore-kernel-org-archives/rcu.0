Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658440F74A
	for <rcu@vger.kernel.org>; Wed, 22 Jul 2026 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715871; cv=none; b=BHvW7QbEewKkL2r6LSEzbGPgv6fbGJvxmswKKDNFp3aVknY/USp0RNP6XItY3yAbrRKLV2PmaxVM8BAg2k/8McPWSFXuFd/+niFDrj7KHMGgnaUDWSZJJF/1Uhyi7gvEH7I5CTeo7WP4UTXBiHIqZlviz2ll0wQ350j6ffUtm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715871; c=relaxed/simple;
	bh=T+zQGJYQw12hzXXrOCLj5B7/XnNgsd7lzkzMvgw7sus=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IRtNdhbVqeO99nK/ESHcjmdShXlTZJUjiMMKufIFVJib3TYb11/+tLlM3crhfoDDFqWPTPkI2D1mC96kaiDBFRlNtCAA4/C/aKKrlNgbSr2Xc3j6PpHQbRber2VpRqxposWko4f4SY2/349O368XGHK5jWPHwMxu+8WTbFMFdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q1N0H6+i; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q1N0H6+i"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784715858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=iKDHSFqXKxd8yDlZ5/9RklFB/SZyB73W9ZH1EPghICk=;
	b=q1N0H6+iIilHT5Y1ZzQD0DhhOZXYZ2DMGhIXmrQUlfZvBt5VT8GF6osKjyRKBqHzwKNjmR
	a+vsEJiqtCS0SzENh3LdGlpDcf/+TWgIX4xj+rIe3xIBSvGRe8fohF4zuHTKsVWQqObYS9
	8m+pLlurnqvoqhk4+IwgUv5tzUvio98=
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
Subject: [PATCH] rcu: Remove unused rdp parameter from rcu_check_gp_start_stall()
Date: Wed, 22 Jul 2026 18:23:47 +0800
Message-Id: <20260722102347.6194-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The rcu_check_gp_start_stall() works entirely on rnp parameter,
and never uses it's rdp parameter. this commit therefore drop it,
updating both callers and the declaration.

No functional change.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tree.c       | 2 +-
 kernel/rcu/tree.h       | 3 +--
 kernel/rcu/tree_stall.h | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 27104edace0b..4bb7e9ca5ab7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2911,7 +2911,7 @@ static __latent_entropy void rcu_core(void)
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
 	}
 
-	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
+	rcu_check_gp_start_stall(rnp, rcu_jiffies_till_stall_check());
 
 	/* If there are callbacks ready, invoke them. */
 	if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_ready_cbs(&rdp->cblist) &&
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9b85eeaa0071..eedfa43059e8 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -545,8 +545,7 @@ static bool rcu_nohz_full_cpu(void);
 static void record_gp_stall_check_time(void);
 static void rcu_iw_handler(struct irq_work *iwp);
 static void check_cpu_stall(struct rcu_data *rdp);
-static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
-				     const unsigned long gpssdelay);
+static void rcu_check_gp_start_stall(struct rcu_node *rnp, const unsigned long gpssdelay);
 
 /* Forward declarations for tree_exp.h. */
 static void sync_rcu_do_polled_gp(struct work_struct *wp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 45b9856ccd2b..02684dadb4ee 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -998,8 +998,7 @@ EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
  * This function checks for grace-period requests that fail to motivate
  * RCU to come out of its idle mode.
  */
-static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
-				     const unsigned long gpssdelay)
+static void rcu_check_gp_start_stall(struct rcu_node *rnp, const unsigned long gpssdelay)
 {
 	unsigned long flags;
 	unsigned long j;
@@ -1074,7 +1073,7 @@ void rcu_fwd_progress_check(unsigned long j)
 			__func__, jiffies - data_race(READ_ONCE(rcu_state.gp_end)));
 		preempt_disable();
 		rdp = this_cpu_ptr(&rcu_data);
-		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
+		rcu_check_gp_start_stall(rdp->mynode, j);
 		preempt_enable();
 	}
 	for_each_possible_cpu(cpu) {
-- 
2.17.1

