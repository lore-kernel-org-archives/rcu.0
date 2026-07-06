Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722044211B
	for <rcu@vger.kernel.org>; Mon,  6 Jul 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332210; cv=none; b=SeGd8rJ4AKi8e/595hUHGEU8WHO2PZYeoxrdVBhbI3DrgKn3e5ANsR8JZI93lDpY9+H/5CzgyEtqr8ITyJnmeyT1etOqFcNEEHePF7CeUf49tn0Wuuv16yAC/hrc9uSyEagyxStlfX2eLjxD9fnI8IPj+3G/ebC7izaustgUgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332210; c=relaxed/simple;
	bh=XY9K7Cb7JfipGpwtFNQC/8Df/UdrKnANDYrTcTSic7Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZKFTtHgj74N7PmW73sSVvYIOjgAwlnCNxfXaZQAl9gt7O0g5akdXba2aF25L4CNKzQTxZzRfFgezmy2C9Btb9UjbQRMKcXbDHx62E8fRqJqxM7yKhi3PHKa6wJ/B6Q6All8Pu7MBhsBYC2v4jas/BgVxIpWbID3vSAqMpUCBoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWMhFTaC; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWMhFTaC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783332207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=dbPkIUFo9q+eC9Vvwi0RICjQO1U4OESF4jrAFQggctQ=;
	b=gWMhFTaC8gpp052tnfEyKbJuXj+5LJlbIMpQZY6lhTQmD9q6VNCPVgoIl8xdBfrvQ41r04
	CpqLZ26uk8VFniPI2H1vT+n1/T5u9+MZ6qXe62CFjgmW9TfNw8cn0QTCIV3i1nE2Thw99e
	4pGcrz6K+3EFSqcwpG20nZg1T4kBE44=
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
Subject: [PATCH] rcu-tasks: Remove unused struct rcu_tasks's->n_ipis_fails variables
Date: Mon,  6 Jul 2026 18:03:09 +0800
Message-Id: <20260706100310.19735-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

The RCU tasks trace has been reimplemented by 'commit c27cea4416a3
("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
rcu_tasks structure's->n_ipis_fails is no longer used, this commit
therefore remove it.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f4da5fad70f5..7f7d1e636217 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -67,7 +67,6 @@ struct rcu_tasks_percpu {
  * @gp_start: Most recent grace-period start in jiffies.
  * @tasks_gp_seq: Number of grace periods completed since boot in upper bits.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
- * @n_ipis_fails: Number of IPI-send failures.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @lazy_jiffies: Number of jiffies to allow callbacks to be lazy.
  * @pregp_func: This flavor's pre-grace-period function (optional).
@@ -102,7 +101,6 @@ struct rcu_tasks {
 	unsigned long gp_start;
 	unsigned long tasks_gp_seq;
 	unsigned long n_ipis;
-	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
 	unsigned long lazy_jiffies;
 	rcu_tasks_gp_func_t gp_func;
@@ -735,12 +733,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		if (havecbs && haveurgent && haveurgentcbs)
 			break;
 	}
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c%c%c l:%lu %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
 		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
-		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
+		data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[havecbs],
 		".u"[haveurgent],
-- 
2.17.1

