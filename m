Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADD2036F3;
	Thu, 17 Jul 2025 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731735; cv=none; b=uMKy5PsLxQMaXCGJriUu1Wg52p15eKSahX2AoU98PaYqxFGS7vgTbWD1Wx2caWXxNHRRBxNAtW6AHFouFqMfkFboz6d5/tMQBjAnjIBpvy9qNjJrA584+TNtK7fwrdNmEJK65JtA6uaJ+065wF2X07yn1jcVf4AoTSfq9who1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731735; c=relaxed/simple;
	bh=Jqhxd7A/eWsqPdvJq92jsPu1g+Ra/P0fxg2zat3wFEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JIQjpXsPL9a5gX6BXwDgZp53TL9mjVAmcg04npmhltf3MlZbk8fd9mnd+ujrxoWBtUS1Q63uTM39KWorLoMTvHNuLKj/pRlBinrisStdR/zmUO8irCJscU9o6LId52jCttmEermqTvWFk85Ay/cIhASoY9PAZOYVhMpsJCzXjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FAHqfX3f; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FAHqfX3f"
X-UUID: a376d29662d211f08b7dc59d57013e23-20250717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PWGJHWebyTPRG8s498ziY+Rf4TwzqDFkjnjk6ovCQdM=;
	b=FAHqfX3fatyEsyyI4hbPGsuDL8slBL94GBE60G/40eYO6PBU6Rwf/6bP2FD22i7gX9EvWD4kbHv6O9dlPoMJ5srGBtvfklVk4f4YrcdW4o6fkMvh2udAOEul2Bb4N8uDdvtOczU+nGaWLHoDZbzzLy3avRkkT2TpHFRIeZ5ag7A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:0425e4a5-199d-413f-b624-76d79a0b8907,IP:0,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:9eb4ff7,CLOUDID:07a61a73-f565-4a89-86be-304708e7ad47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a376d29662d211f08b7dc59d57013e23-20250717
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <tze-nan.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 354623613; Thu, 17 Jul 2025 13:55:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 17 Jul 2025 13:55:25 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 17 Jul 2025 13:55:25 +0800
From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
To: <rcu@vger.kernel.org>
CC: <bobule.chang@mediatek.com>, <wsd_upstream@mediatek.com>, Tze-nan Wu
	<Tze-nan.Wu@mediatek.com>, Cheng-jui Wang <cheng-jui.wang@mediatek.com>,
	<Lorry.Luo@mediatek.com>, <weiyangyang@vivo.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
	<boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Joel Fernandes (Google)"
	<joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] rcu: Fix delayed execution of hurry callbacks
Date: Thu, 17 Jul 2025 13:53:38 +0800
Message-ID: <20250717055341.246468-1-Tze-nan.Wu@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK: N

We observed a regression in our customer’s environment after enabling
CONFIG_LAZY_RCU. In the Android Update Engine scenario, where ioctl() is
used heavily, we found that callbacks queued via call_rcu_hurry (such as
percpu_ref_switch_to_atomic_rcu) can sometimes be delayed by up to 5
seconds before execution. This occurs because the new grace period does
not start immediately after the previous one completes.

The root cause is that the wake_nocb_gp_defer() function now checks
"rdp->nocb_defer_wakeup" instead of "rdp_gp->nocb_defer_wakeup". On CPUs
that are not rcuog, "rdp->nocb_defer_wakeup" may always be
RCU_NOCB_WAKE_NOT. This can cause "rdp_gp->nocb_defer_wakeup" to be
downgraded and the "rdp_gp->nocb_timer" to be postponed by up to 10
seconds, delaying the execution of hurry RCU callbacks.

The trace log of one scenario we encountered is as follow:
  // previous GP ends at this point
  rcu_preempt   [000] d..1.   137.240210: rcu_grace_period: rcu_preempt 8369 end
  rcu_preempt   [000] .....   137.240212: rcu_grace_period: rcu_preempt 8372 reqwait
  // call_rcu_hurry enqueues "percpu_ref_switch_to_atomic_rcu", the callback waited on by UpdateEngine
  update_engine [002] d..1.   137.301593: __call_rcu_common: wyy: unlikely p_ref = 00000000********. lazy = 0
  // FirstQ on cpu 2 rdp_gp->nocb_timer is set to fire after 1 jiffy (4ms)
  // and the rdp_gp->nocb_defer_wakeup is set to RCU_NOCB_WAKE
  update_engine [002] d..2.   137.301595: rcu_nocb_wake: rcu_preempt 2 FirstQ on cpu2 with rdp_gp (cpu0).
  // FirstBQ event on cpu2 during the 1 jiffy, make the timer postpond 10 seconds later.
  // also, the rdp_gp->nocb_defer_wakeup is overwrite to RCU_NOCB_WAKE_LAZY
  update_engine [002] d..1.   137.301601: rcu_nocb_wake: rcu_preempt 2 WakeEmptyIsDeferred
  ...
  ...
  ...
  // before the 10 seconds timeout, cpu0 received another call_rcu_hurry
  // reset the timer to jiffies+1 and set the waketype = RCU_NOCB_WAKE.
  kworker/u32:0 [000] d..2.   142.557564: rcu_nocb_wake: rcu_preempt 0 FirstQ
  kworker/u32:0 [000] d..1.   142.557576: rcu_nocb_wake: rcu_preempt 0 WakeEmptyIsDeferred
  kworker/u32:0 [000] d..1.   142.558296: rcu_nocb_wake: rcu_preempt 0 WakeNot
  kworker/u32:0 [000] d..1.   142.558562: rcu_nocb_wake: rcu_preempt 0 WakeNot
  // idle(do_nocb_deferred_wakeup) wake rcuog due to waketype == RCU_NOCB_WAKE
  <idle>        [000] d..1.   142.558786: rcu_nocb_wake: rcu_preempt 0 DoWake
  <idle>        [000] dN.1.   142.558839: rcu_nocb_wake: rcu_preempt 0 DeferredWake
  rcuog/0       [000] .....   142.558871: rcu_nocb_wake: rcu_preempt 0 EndSleep
  rcuog/0       [000] .....   142.558877: rcu_nocb_wake: rcu_preempt 0 Check
  // finally rcuog request a new GP at this point (5 seconds after the FirstQ event)
  rcuog/0       [000] d..2.   142.558886: rcu_grace_period: rcu_preempt 8372 newreq
  rcu_preempt   [001] d..1.   142.559458: rcu_grace_period: rcu_preempt 8373 start
  ...
  rcu_preempt   [000] d..1.   142.564258: rcu_grace_period: rcu_preempt 8373 end
  rcuop/2       [000] D..1.   142.566337: rcu_batch_start: rcu_preempt CBs=219 bl=10
  // the hurry CB is invoked at this point
  rcuop/2       [000] b....   142.566352: blk_queue_usage_counter_release: wyy: wakeup. p_ref = 00000000********.

This patch changes the condition to check "rdp_gp->nocb_defer_wakeup" in
the lazy path. This prevents an already scheduled "rdp_gp->nocb_timer"
from being postponed and avoids overwriting "rdp_gp->nocb_defer_wakeup"
when it is not RCU_NOCB_WAKE_NOT.

Fixes: 3cb278e73be5 ("rcu: Make call_rcu() lazy to save power")
Co-developed-by: Cheng-jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Cheng-jui Wang <cheng-jui.wang@mediatek.com>
Co-developed-by: Lorry.Luo@mediatek.com
Signed-off-by: Lorry.Luo@mediatek.com
Tested-by: weiyangyang@vivo.com
Signed-off-by: weiyangyang@vivo.com
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
---
The regression is first observed by wyy in the Update Engine scenario
with  CONFIG_LAZY_RCU enabled. there is an additional delay of 4–5
seconds during the heavy ioctl API call, waiting for
percpu_ref_switch_to_atomic_rcu (RCU hurry CB) to complete.

Initially, we suspected that the percpu_ref_switch_to_atomic_rcu
function itself was taking too long. However, after enabling some
custome and the following trace events: rcu_do_batch, rcu_nocb_wake, and
rcu_grace_period. we found that the root cause was that rcuog was not
being woken up in time to request a new GP. This led to the delay in
invoking the hurry RCU callback (percpu_ref_switch_to_atomic_rcu).

Environment:
  Android-16, Kernel: 6.12, 8 CPUs (ARM)

Configuration:
  CONFIG_TREE_RCU=y
  CONFIG_PREEMPT_RCU=y
  CONFIG_LAZY_RCU=y
  CONFIG_RCU_NOCB_CPU=y
  CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
  rcu_nocb_gp_stride = -1 (default is 4 for 8 cores)
  jiffies_lazy_flush = 10 * HZ

Contributions:
Tze-Nan Wu:
Collaborated with Cheng-Jui to discuss which tracepoints needed to be
added, jointly analyzed the trace logs, identified the root cause, and
proposed this upstream change.

Cheng-Jui Wang:
Provided many valuable suggestions during the debugging process,
repeatedly found breakthroughs when we were stuck, and helped identify
the root cause.

Lorry Luo:
Assisted in verifying whether rcu-hurry-callback was executed too long
or deferred, supported with testing, and helped with communication.

Weiyangyang:
Main tester who discovered the regression scenario, confirmed that
enabling CONFIG_LAZY_RCU caused the regression, and verified that this
patch resolves the issue.

Note:
With my limited understanding of lazy RCU, I am not fully confident that
this is a real issue. In my opinion, hurry callbacks should not be
delayed by other events such as firstBQ trace event.
If my understanding is incorrect, I would greatly appreciate any
guidance or clarification from the maintainers.
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 08eb9b0e2fab..e6cd56603cad 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -276,7 +276,7 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	 * callback storms, no need to wake up too early.
 	 */
 	if (waketype == RCU_NOCB_WAKE_LAZY &&
-	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
+	    rdp_gp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
-- 
2.45.2

