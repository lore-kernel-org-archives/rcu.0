Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872D3C48BE5
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE66613C0
	for <rcu@archiver.kernel.org>; Tue, 22 Jun 2021 12:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFVMHu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Jun 2021 08:07:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55098 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhFVMHt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Jun 2021 08:07:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624363534; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Tp8UH9h2iMsv9pkhjSI6gKRM13+oYh8zxCNpxDqjBd4=; b=Eu7yKYQZ0TjfX+YtaExfhwXZIqaQKHRPrClEmXCKeYEn+KOatwjcH6MQOypeWJNAh4epLPoW
 4M/m5+rXaLhWtlL0oTUDfsPr4CgBXq9vlOb5c58ghxmfTbm/G6yuMLgwzWkljDYMl1ETKgwZ
 ZohQeMSQGIPQCOUO4YA1jMlMmmE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60d1d207bcc24d859be7add8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 12:05:27
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3C61C43144; Tue, 22 Jun 2021 12:05:26 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5C31C433D3;
        Tue, 22 Jun 2021 12:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5C31C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: update: Check rcu_bh_lock_map state in rcu_read_lock_bh_held
Date:   Tue, 22 Jun 2021 17:35:21 +0530
Message-Id: <1624363521-19702-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In addition to irq and softirq state, check rcu_bh_lock_map
state, to decide whether RCU bh lock is held.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c21b38c..d416f1c 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -333,7 +333,7 @@ int rcu_read_lock_bh_held(void)
 
 	if (rcu_read_lock_held_common(&ret))
 		return ret;
-	return in_softirq() || irqs_disabled();
+	return lock_is_held(&rcu_bh_lock_map) || in_softirq() || irqs_disabled();
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

