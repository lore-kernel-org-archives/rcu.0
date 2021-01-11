Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3ADC433E0
	for <rcu@archiver.kernel.org>; Mon, 11 Jan 2021 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DC922527
	for <rcu@archiver.kernel.org>; Mon, 11 Jan 2021 11:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbhAKLqI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:46:08 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:36851 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAKLqI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Jan 2021 06:46:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610365544; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=phlq0VMVBR4TsRWMuHemTdrgrkpRg2OyM5+rf5MITYc=; b=DBLwg1S94z3flnVg+nqqFqD3OtQ3ZBpzpFxhuvoImrqAU4BuXvgzJBQjNyNVagKpc58X4ynj
 0UsARje9XMh2yLRE6/R3XpFEpgdL70gLJBHGNOLysHQ5eWkETkPUBjPSzBtzy/b3kBJy51M2
 4arV5bgAd/nQfVb82iQNyuxRtYM=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ffc3a462a47972bcc2e88d9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:45:10
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31B28C43462; Mon, 11 Jan 2021 11:45:10 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB819C433ED;
        Mon, 11 Jan 2021 11:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB819C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Only trace when cbs are accelerated
Date:   Mon, 11 Jan 2021 17:15:01 +0530
Message-Id: <1610365501-6196-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Fix rcu_accelerate_cbs() traces to only trace when cbs are
accelerated in current call.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 804e543..338b817 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1508,8 +1508,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * number.
 	 */
 	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
-		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
+	if (!rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
+		return ret;
+	ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

