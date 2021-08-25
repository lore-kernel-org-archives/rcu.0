Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85F4C4338F
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38A56138B
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhHYHMT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:12:19 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57852 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbhHYHMR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Aug 2021 03:12:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629875492; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=uxIirJq89ai5k1ras2EdMLyn7THEMaXEw0ZvQhMyOaQ=; b=jA+BZFYCkcUODEvOBosx4P0zta0Ims76dSntLY/SN1p7fY59OOu7P73c6HuflkyqikQ8yxMi
 ilV/5mmGTxOiC7D/81AJN7StA52YHqKZ9sz7uhGAyi8oOAx481SreEMseCnOlA48OilaV/qk
 8ob3mgbyhYFEXk5ddutClXy02AI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6125ed15e0fcecca19efc001 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 07:11:17
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C840CC4360D; Wed, 25 Aug 2021 07:11:16 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25EC5C4338F;
        Wed, 25 Aug 2021 07:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 25EC5C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v2 1/5] rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment
Date:   Wed, 25 Aug 2021 12:40:47 +0530
Message-Id: <1629875451-20628-2-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
References: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 39cef3c..e62da45 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -996,7 +996,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// If this task is not yet on the holdout list, then we are in
 	// an RCU read-side critical section.  Otherwise, the invocation of
-	// rcu_add_holdout() that added it to the list did the necessary
+	// trc_add_holdout() that added it to the list did the necessary
 	// get_task_struct().  Either way, the task cannot be freed out
 	// from under this code.
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

