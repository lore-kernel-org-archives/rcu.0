Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F82C4346E
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 06:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A322311A
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 06:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BbMyEm9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIXGed (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:34:33 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:10377 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgIXGed (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 24 Sep 2020 02:34:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600929272; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=SCZE0l76mOT8sBQ7aJKBqrLFMUKoKWKDRKCvf8+bXBk=; b=BbMyEm9+OB1xTTMYIWaOL4Bav/67X6fZI9ByV1AT99mluaKpRjS0gMCded6TE3B2GGdkYb39
 H38GLUXqTskYRCB9mQ53VLEAg6Jn827p440KYmp2UmQu8j5p90VZzXfrA+pGScrEA+FeoGLQ
 GTK06AKR9QEYPkIxccm1/WubMDQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6c3dea244d44dc65074236 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 06:34:18
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE6F6C43385; Thu, 24 Sep 2020 06:34:17 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B2FA2C433C8;
        Thu, 24 Sep 2020 06:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2FA2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config
Date:   Thu, 24 Sep 2020 12:04:10 +0530
Message-Id: <1600929250-20344-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Clarify the "x" in rcuox/N naming in RCU_NOCB_CPU config
description.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/Kconfig | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f..5b22747 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -227,11 +227,12 @@ config RCU_NOCB_CPU
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
-	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
+	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
+	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
+	  from running on the specified CPUs, but (1) the kthreads may be
+	  preempted between each callback, and (2) affinity or cgroups can
+	  be used to force the kthreads to run on whatever set of CPUs is
+	  desired.
 
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

