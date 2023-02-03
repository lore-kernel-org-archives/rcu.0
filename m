Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA53C636D3
	for <rcu@archiver.kernel.org>; Fri,  3 Feb 2023 01:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBCBfg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBCBff (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 2 Feb 2023 20:35:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C39841A0;
        Thu,  2 Feb 2023 17:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675388134; x=1706924134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=71piuBCEe2+vVRwtacCxx8j39fJadVo2ugu2BE7Iu/4=;
  b=UvpZVXcVPellXE/DBbyOa8H/FEkvigWvHkr6CAR449zS2MnS2/x/5nUa
   k26BkvFvQtG5JxGEuYmGA1FRTRW9XzIoSFZcMm5UWgFKQisLll2K7z0xn
   idLmzESMSStjIhlN1A7ylePg8rTmvdLn36gsXj5Z8MLO/hf9mNmiF+wEI
   iU31ZT7PxL0TX6iWOq/Jw1qaZ8BZBEaa4zE2EsYKQHywrYl9pgusA0vRw
   g+d4jnb2udm2UU+AFE37vw9jKSogYf4XMpqC8SMqqvf7VrUccEmRgC9ER
   tyaxWQkq2InYW/TjvYGBUgpcCyNg9iAbDPuC/HfQiEX4/HUAaINdP+zaw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="414836810"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="414836810"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:35:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="697900501"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="697900501"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:35:15 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcutorture: Create nocb tasks only for CONFIG_RCU_NOCB_CPU=y kernels
Date:   Fri,  3 Feb 2023 09:40:21 +0800
Message-Id: <20230203014021.3408798-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When setting nocbs_nthreads to start rcutorture test with a non-zero value,
the nocb tasks will be created and invoke rcu_nocb_cpu_offload/deoffload()
to toggle CPU's callback-offload state, but for CONFIG_RCU_NOCB_CPU=n
kernel, the rcu_nocb_cpu_offload/deoffload() is a no-op and this is also
meaningless for torture_type is non-rcu.

This commit therefore add member can_nocbs_toggle to rcu_torture_ops
structure to avoid unnecessary nocb tasks creation.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 297da28ce92d..d01127e0e8cd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3708,6 +3708,12 @@ rcu_torture_init(void)
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
 	}
+	if (nocbs_nthreads != 0 && (cur_ops != &rcu_ops ||
+					!IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		pr_alert("rcu-torture types: %s and CONFIG_RCU_NOCB_CPU=%d, nocb toggle disabled.\n",
+				cur_ops->name, IS_ENABLED(CONFIG_RCU_NOCB_CPU));
+		nocbs_nthreads = 0;
+	}
 	if (cur_ops->init)
 		cur_ops->init();
 
-- 
2.25.1

