Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCF6C433F5
	for <rcu@archiver.kernel.org>; Thu, 24 Mar 2022 11:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbiCXLQT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiCXLQT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Mar 2022 07:16:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8219F6C8;
        Thu, 24 Mar 2022 04:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648120487; x=1679656487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=82T1//IDxRxWMoKx8jXyzu8qZyLKygsREbSeX2E2PMA=;
  b=jltTZbK5SuOJnc7mZDr4RSP8jJWju0AcCNLisFii5n3n/f3NDDclPeSQ
   cczdu1oPQdO3ztM7k4bwEPATbzvFhZnUHgqTRLwbSWaiIXC0Ha6JrBsPU
   7p6d8ajmBjcBFsfqbpx9mbOjnw1kknBT6KY5bCs0hJD0f4M0ftjGAYuHe
   GsOYQ8VWto2G3Fy6gpxWCMH1S+lZGPugTJkp0Te3OmsRjrHZan4j6NQu8
   86Uv5C0P3vyGV6ks4FvtxQVn5hDsXE6Js7kKIS39JSRSvqRMi7p40BVlK
   qeEs5zcWiwQRYJ42E1kN6VRr7Cs3vjNYy+nJiN/qVowoBk3yy0u/ggkzQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258302716"
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="258302716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:14:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,207,1643702400"; 
   d="scan'208";a="519742130"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 04:14:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Check the validity of the boost_kthread_task pointer
Date:   Thu, 24 Mar 2022 19:15:15 +0800
Message-Id: <20220324111515.1810160-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The boost kthreads may spawn failed, although the probability of
creation failure is very low, in consideration of the robustness
of the code, add boost_kthread_task pointer detection.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6b9bcd45c7b2..fd642f14f31f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1125,7 +1125,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	__releases(rnp->lock)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!rcu_preempt_blocked_readers_cgp(rnp) && rnp->exp_tasks == NULL) {
+	if (!rnp->boost_kthread_task ||
+			(!rcu_preempt_blocked_readers_cgp(rnp) && rnp->exp_tasks == NULL)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-- 
2.25.1

