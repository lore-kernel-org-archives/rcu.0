Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B2C433F5
	for <rcu@archiver.kernel.org>; Sun,  3 Apr 2022 23:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344601AbiDDABB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 3 Apr 2022 20:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiDDABA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 3 Apr 2022 20:01:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99449FC0;
        Sun,  3 Apr 2022 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649030345; x=1680566345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kac8s4R5kDi57PE6BTP55BKRS8viWkvdWgVR3Sffaco=;
  b=ASnqxyaAFherfoXPMV1lU4jf8Ox7ZolZNbGxvwM9Pw8pyqkHPkCRJ5b4
   O+KsMOv/FB3HSuqheeBP1zpzMU6cvGyPhyJjpI/z1UwV5N+vEQrEUBRtB
   snkz0tSvfgFwnXDePjh+9FRJiIk/86sRhW8sWyR5JvyxT/c45Cyh9koy8
   5U5QZjsoqmyoWKnpk3HSg2DbvrDQ3C2uOWUBVc9DfmeT964eW+N/a+8Un
   zNMxF0ebxfAG9XdwdjTy6h4PAYd3LTkOglH32FRmrLRlsM5uVNzb6x3W3
   C9LOBnbh1439wz7v6skixARSNo95WvHCCJClGfpHfIanUXOrVQnuuu0n2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="257997173"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="257997173"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 16:59:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569106448"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 16:59:03 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Make defer_qs_iw as hard irq-work under RT kernel with strict grace period configuration
Date:   Mon,  4 Apr 2022 07:59:32 +0800
Message-Id: <20220403235932.2864193-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When the CONFIG_RCU_STRICT_GRACE_PERIOD is enabled, on non-PREEMPT_RT
kernel, the init_irq_work() make the defer_qs_iw irq-work execute in
interrupt context. however, on PREEMPT_RT kernel, the init_irq_work()
make defer_qs_iq irq-work execute in rt-fifo irq_work kthreads. when
system booting, there are a lot of defer_qs_iw irq-work to be processed
in rt-fifo irq_work kthreads, it occupies boot CPU for long time and
cause other kthread cannot get the boot CPU, the boot process occurs
hang. use IRQ_WORK_INIT_HARD() to initialize defer_qs_iw irq-work, can
ensure the defer_qs_iw irq-work execute in interrupt context, under
PREEMPT_RT kernel with the CONFIG_RCU_STRICT_GRACE_PERIOD is enabled.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Use IRQ_WORK_INIT_HARD initialize defer_qs_iw only under RT kernel
 with CONFIG_RCU_STRICT_GRACE_PERIOD is enabled. 

 kernel/rcu/tree_plugin.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3037c2536e1f..e6196a23793c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -661,7 +661,13 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
+				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
+							IS_ENABLED(CONFIG_PREEMPT_RT))
+					rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(
+								rcu_preempt_deferred_qs_handler);
+				else
+					init_irq_work(&rdp->defer_qs_iw,
+							rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
-- 
2.25.1

