Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378C0C433F5
	for <rcu@archiver.kernel.org>; Fri, 22 Apr 2022 13:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447807AbiDVNR4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 22 Apr 2022 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447892AbiDVNRz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 22 Apr 2022 09:17:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E321158;
        Fri, 22 Apr 2022 06:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650633303; x=1682169303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fk1/9xj+k4tMU+1zg07H5ABLMjz7bV0v7SjqRVxbtx0=;
  b=htpsv9G8/eGfnGPj2vR0vUqOvIF/7iAMj2lQDsBjLxW2ob0inrKOlh80
   IBxdlEV+RfW5YfucprCxMIPnfPbSDo8ygwtye/KejXiiVRYHyokQpPYTx
   wfEYAFEAnMNPqUcJnfRieYddk4naXHg44nSt7no/mAb4sRRIgXD1XZC8M
   k9Hq+lhUvirl/REip6dMv1u7N6RmmHwXwnWQsnXBPqCj9R/VRAKnK9YhV
   I9GLg5j/wxAcaZ9LbhI12dH5M8WFsuQi7MyzIVo5xCt1KMTbY49rDoBoH
   d66vm9YjtZs9ozU5LQzblHrY5ddZCKR5vmgCZgbdcAsfZtILr1tvrKVwP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264447579"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="264447579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:15:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="577888236"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:15:01 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Put panic_on_rcu_stall() after expedited RCU CPU stall warnings
Date:   Fri, 22 Apr 2022 21:15:18 +0800
Message-Id: <20220422131518.3090060-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When the expedited RCU CPU stall warning is treated as panic, if
it's triggered, the stall info should be printed first and tell us
reason, rather than directly panic.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 571b0a700cce..f05a15b11fa0 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -623,7 +623,6 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
-		panic_on_rcu_stall();
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
@@ -671,6 +670,7 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+		panic_on_rcu_stall();
 	}
 }
 
-- 
2.25.1

