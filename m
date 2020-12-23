Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C89C433E0
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 08:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DFD222BB
	for <rcu@archiver.kernel.org>; Wed, 23 Dec 2020 08:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgLWIkw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Dec 2020 03:40:52 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:56656 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgLWIks (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Dec 2020 03:40:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608712828; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gGi09wd5qI0o39eCUseEFsMgWFRbdS+39Uf8hOZ5cBI=; b=lS5Y7erIlDZcsXPJQlQfDtkW+8NyIVk5M0jI8sHwaadc56OHy8QPLpM5JeUtiuucYqSXIdYI
 W2jM8wbcPhTYOy8P6Vn533TDlCYNKTd0bf5Wy1oOiEBtiC48vBxuZ1X8ay9hb7U7kalHpW8J
 eTdjeAgMjLbV6deGD2ognlgcKy4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fe30258120d248bb5a32e4f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Dec 2020 08:39:52
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B077C43463; Wed, 23 Dec 2020 08:39:52 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B7D0C433CA;
        Wed, 23 Dec 2020 08:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B7D0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, peterz@infradead.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Fix dynticks_nmi_nesting underflow check in rcu_is_cpu_rrupt_from_idle
Date:   Wed, 23 Dec 2020 14:09:37 +0530
Message-Id: <1608712777-1769-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For the smp_call_function() optimization, where callbacks can run from
idle context, in commit 806f04e9fd2c ("rcu: Allow for smp_call_function()
running callbacks from idle"), an additional check is added in
rcu_is_cpu_rrupt_from_idle(), for dynticks_nmi_nesting value being 0,
for these smp_call_function() callbacks running from idle loop.
However, this commit missed updating a preexisting underflow check
of dynticks_nmi_nesting, which checks for a non zero positive value.
Fix this warning and while at it, read the counter only once.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---

Hi,

I was not able to get this warning, with scftorture.

  RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
    "RCU dynticks_nmi_nesting counter underflow/zero!");

Not sure if idle loop smp_call_function() optimization is already present
in mainline?

Another thing, which I am not sure of is, maybe lockdep gets disabled
in the idle loop contexts, where rcu_is_cpu_rrupt_from_idle() is called?
Was this the original intention, to keep the lockdep based
RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0
check separate from idle task context nesting value
WARN_ON_ONCE(!nesting && !is_idle_task(current)) check?


Thanks
Neeraj

 kernel/rcu/tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bc8b489..c3037cf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -457,11 +457,10 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
 			 "RCU dynticks_nesting counter underflow!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
-			 "RCU dynticks_nmi_nesting counter underflow/zero!");
+	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
+	RCU_LOCKDEP_WARN(nesting < 0, "RCU dynticks_nmi_nesting counter underflow!");
 
 	/* Are we at first interrupt nesting level? */
-	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
 	if (nesting > 1)
 		return false;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

