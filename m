Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4146C4338F
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 07:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A5861076
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 07:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhHRH3y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:29:54 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64995 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbhHRH3q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Aug 2021 03:29:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629271752; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=X4BgYWor9an514sETJ471o1unidQYvJlyZ1LoWRzyHk=; b=KdV4dB/eX5GJkGrIJOUxBevPwObcip7yL2VKO/azdXkg7Eb6uLKVQmIC59VD47HlrULvFkRE
 mTi7qLLmnUrNS8gyCqjBWFwRij6SEx9QM5Hjqb+fkknNESi7cPujLbXvCYTNS9ME1rQm+ldQ
 zX2by1jvCFcLHahSaa+/ZlxWPNk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611cb6c066ff107904e2690e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 07:29:04
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05E21C4338F; Wed, 18 Aug 2021 07:29:04 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7572C43460;
        Wed, 18 Aug 2021 07:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C7572C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH 2/5] rcu-tasks: Correct firstreport usage in check_all_holdout_tasks_trace
Date:   Wed, 18 Aug 2021 12:58:40 +0530
Message-Id: <1629271723-3816-3-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
References: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In check_all_holdout_tasks_trace(), firstreport is a pointer argument;
so, check the dereferenced value, instead of checking the pointer.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e62da45..9db7293 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1134,7 +1134,7 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 	cpus_read_unlock();
 
 	if (needreport) {
-		if (firstreport)
+		if (*firstreport)
 			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
 		show_stalled_ipi_trace();
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

