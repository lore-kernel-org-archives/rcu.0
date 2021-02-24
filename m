Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E0C433DB
	for <rcu@archiver.kernel.org>; Wed, 24 Feb 2021 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC96264DE0
	for <rcu@archiver.kernel.org>; Wed, 24 Feb 2021 08:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhBXIb1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Feb 2021 03:31:27 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49523 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234040AbhBXIbS (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 24 Feb 2021 03:31:18 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UPR10aO_1614155430;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UPR10aO_1614155430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Feb 2021 16:30:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     paulmck@kernel.org
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] rcu: make nocb_nobypass_lim_per_jiffy static
Date:   Wed, 24 Feb 2021 16:30:29 +0800
Message-Id: <1614155429-64546-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix the following sparse warning:

kernel/rcu/tree_plugin.h:1497:5: warning: symbol
'nocb_nobypass_lim_per_jiffy' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..8ff8cf8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1494,7 +1494,7 @@ static int __init parse_rcu_nocb_poll(char *arg)
  * After all, the main point of bypassing is to avoid lock contention
  * on ->nocb_lock, which only can happen at high call_rcu() rates.
  */
-int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
+static int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
 module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
-- 
1.8.3.1

