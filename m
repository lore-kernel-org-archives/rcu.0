Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF126C4332F
	for <rcu@archiver.kernel.org>; Wed, 19 Oct 2022 23:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiJSXcs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Oct 2022 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiJSXci (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Oct 2022 19:32:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8C1C4920;
        Wed, 19 Oct 2022 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666222343; x=1697758343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z5X4sFIIoSeyL67r5yY/uxjHbHuM5Ha0FgxnmkDejtQ=;
  b=Sbv4e5ReBxeUYzjXlPleCRnOuX6Dt60xK2gO57NhPJcta+bq4mewZZcw
   gAN8vN1e57LVSfnxER8SYzo+brmvRGyAER4BdLEdgWOVDpxKLSamZRfux
   woIzE6KEPkJIfZDo3xM9PbI3FA2qlptZ1v+Ityc4NkWz6G6Lthzy5Qqx+
   UvQbhOXdQCrqdcFNX7ixzc3rkRT5VTIkG0nJ1aF/Zg9nhElAiMInML6mp
   B002j/yQ2ToGd95ZqFRqno+yK6rqB0VDnFvDMfttgmJZMBGkQ6zEIqj4Z
   zdO81o3qI//XJkBFlFVsDz0hsaLu89Q7pQeNRH1pz9nC3fntx6UW0bVln
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="392859932"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="392859932"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:32:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="662707262"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="662707262"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 16:32:19 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Thu, 20 Oct 2022 07:38:35 +0800
Message-Id: <20221019233835.395474-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, regardless of whether the CONFIG_RCU_LAZY is enabled,
invoke the call_rcu() is always lazy, it also means that when
CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
lazy. therefore, this commit make call_rcu() lazy only when
CONFIG_RCU_LAZY is enabled.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2: 
 Use IS_ENABLED(CONFIG_RCU_LAZY) to the existing function of the same name.

 kernel/rcu/tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index abc615808b6e..ecf42b0d3726 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2887,7 +2887,10 @@ EXPORT_SYMBOL_GPL(call_rcu_flush);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, true);
+	if (IS_ENABLED(CONFIG_RCU_LAZY))
+		return __call_rcu_common(head, func, true);
+	else
+		return __call_rcu_common(head, func, false);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.25.1

