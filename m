Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B543D88F7
	for <rcu@vger.kernel.org>; Thu, 16 Jul 2026 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784195884; cv=none; b=JncP28hz/5R/yGPPPN1OMMGgcUUBQph542xZ952JLwWRDtmZZhZsAwePBaAnKCUQHmlaVAwutjNj71f5VWB45KmCcHqfeUdsnTEI9Fs2rFK6h0W6yDhGFVh4zhHsqceuQr0nhCbLE0mOyUSv0H5Rp93ISodO7LvS9YrfRKigDFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784195884; c=relaxed/simple;
	bh=Tyl2/hykBetSDaGYfwPkaP7vJGJZa465zuX32/hlzEk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CG5cLDqhOmWshLgHSAxJ7CEddeXr3Uevchh1lO4lUhbA6GGpicq5C/wWWMLgJczd0nZrLIsw/n6wK7K2YBsfgSkYPI7vzNkZqJvaE1GpGrgCZRh3ouGpPOVUIfcsLINs8eH1i+/OO4MSbRNdR3ZA8HCMLq+c8RpgFe1c3OKpNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IhNkZ+ge; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IhNkZ+ge"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784195880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=dyng1bq1uW1noHl5YZws9kuGFCXD/NaMxtWCvR5ZBUk=;
	b=IhNkZ+geDKRTBIctyAwKVTKB+wFph5rnw5xPVF0LElqNtaXWzEvL1sCoJnMqMM+KpuQsp2
	ThNNMDhqNxFgqR5CbxdFIan9IvJye/sLQdz/ssyu0xjSTHFREm4z9wmKrKN2p8sTII2dH6
	cUtuE3RSVFiY4B8w7p+1rCvFzWSKBEc=
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
Subject: [PATCH] rcu-tasks: Dump rtpcp->lazy_timer status in show_rcu_tasks_generic_gp_kthread()
Date: Thu, 16 Jul 2026 17:57:54 +0800
Message-Id: <20260716095754.24827-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

Add 'P' flag to the diagnostic line to indicate whether any per-cpu
rtpcp's lazy_timer is pending.  this helps diagnose stalls where
rcu-task callbacks are queued but the kthread stay sleep because
the lazy_timer has not yet fired and no grace period has started.

The output is as follows:

[   31.319540][   T77] call_rcu_tasks() has failed boot-time tests.
[   31.320205][   T77] rcu_tasks: RTGS_WAIT_CBS(11) since 7518 g:4 i:0 kCuUP l:150000

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/tasks.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6720dc25cd39..a146d1d98c22 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -723,6 +723,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 	bool havecbs = false;
 	bool haveurgent = false;
 	bool haveurgentcbs = false;
+	bool havependtimer = false;
 
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
@@ -733,10 +734,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 			haveurgent = true;
 		if (!data_race(rcu_segcblist_empty(&rtpcp->cblist)) && data_race(rtpcp->urgent_gp))
 			haveurgentcbs = true;
-		if (havecbs && haveurgent && haveurgentcbs)
+		if (data_race(timer_pending(&rtpcp->lazy_timer)))
+			havependtimer = true;
+		if (havecbs && haveurgent && haveurgentcbs && havependtimer)
 			break;
 	}
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c%c l:%lu %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
@@ -746,6 +749,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[havecbs],
 		".u"[haveurgent],
 		".U"[haveurgentcbs],
+		".P"[havependtimer],
 		rtp->lazy_jiffies,
 		s);
 }
-- 
2.17.1

