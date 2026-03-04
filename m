Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12473FBA7
	for <rcu@vger.kernel.org>; Wed,  4 Mar 2026 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593057; cv=none; b=ZFIL4HLCZwph2n9cyV4MFXNBtrijx09t0hnoPJAmJuz5Rh8GceYSToPXv7zJ6Yr9pcIRC+hPmm/eacFpq5MtVGZGsWE7WSMr/4wSMGTorBPU6z0BeOZQsOVM9SI575BRNptGnl2UQrlL21CvfHm/VnyzJ8thUHtvn2LvKuXANk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593057; c=relaxed/simple;
	bh=qkeRbo78B+2gM+r2nbeXSUfeM0u2W8lSayzGSDjRBRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhfsnFoR7TdtYwPxyMcIw4cO52s59/OwjHvggzCmpkTVJ3zwd8ciCgIvfZVR8LfxpypON9bhDT1CDMuFHHOYuObJhoNgR/7JlKuSJJhoIBcMXJ4qC0BKI71NAPLu2CXo6w3mOJDXmteWhrH98kL7yrff8rpZw4QdxmEu/5cQaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=XKKDSHI8; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="XKKDSHI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1772593055;
	bh=DCsWQhNqFPEinGuq6D8087JmXqNHHQaNhOmiVDfpepM=;
	h=From:Subject:Date:Message-Id;
	b=XKKDSHI8/IF7wpWU/SCvV+Bh2BQzDiaLo3PCCk2ibHoVsG2jdbJ4dwFZ1C9gAiNs6
	 hIPTHzNapOiIgFrVuZD86dnVx1d3v4NeaIX/7wy0rx315Zo+sE2Qpt89yCyp/q7ZmC
	 q9hEn5X1j0uwuMTnH9IlAmREBBIUrLnkpfFlB63g=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.22) with ESMTP
	id 69A79F9400002FF7; Wed, 4 Mar 2026 10:57:26 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 7820897602635
X-SMAIL-UIID: 7B04746125BA4BD6BB653162830FBA2D-20260304-105726-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	qiang.zhang1211@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	rcu@vger.kernel.org,
	neeraj.upadhyay@kernel.org
Subject: [PATCH 6.6.y] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access
Date: Wed,  4 Mar 2026 10:57:24 +0800
Message-Id: <20260304025724.2365669-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit 1bba3900ca18bdae28d1b9fa10f16a8f8cb2ada1 ]

In the preparation stage of CPU online, if the corresponding
the rdp's->nocb_cb_kthread does not exist, will be created,
there is a situation where the rdp's rcuop kthreads creation fails,
and then de-offload this CPU's rdp, does not assign this CPU's
rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
rdp's->rdp_gp->nocb_gp_kthread is still valid.

This will cause the subsequent re-offload operation of this offline
CPU, which will pass the conditional check and the kthread_unpark()
will access invalid rdp's->nocb_cb_kthread pointer.

This commit therefore use rdp's->nocb_gp_kthread instead of
rdp_gp's->nocb_gp_kthread for safety check.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
[ Minor conflict resolved. ]
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 kernel/rcu/tree_nocb.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8993b2322be2..a3d613f063a8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1221,7 +1221,6 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int wake_gp;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
@@ -1231,7 +1230,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
+	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
 		return -EINVAL;
 
 	pr_info("Offloading %d\n", rdp->cpu);
@@ -1260,7 +1259,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 */
 	wake_gp = rdp_offload_toggle(rdp, true, flags);
 	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
+		wake_up_process(rdp->nocb_gp_kthread);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
-- 
2.34.1

