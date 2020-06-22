Return-Path: <SRS0=LAXB=AD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0452C433E1
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D0820656
	for <rcu@archiver.kernel.org>; Mon, 22 Jun 2020 18:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XXJMyLCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgFVSHZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:07:25 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:14534 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729860AbgFVSHX (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 22 Jun 2020 14:07:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592849243; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DpNd2zXh5ar+PR5dcDtX1KuMP2pD3jdm3Qo6Wkx+K3M=; b=XXJMyLCs5XIhNQc8T+pGupI10VyxxelJvpE1pr5btHHog2SweuWHGPDbYuu908WQn0EySKln
 b/ykVp9kVQGX1IED2N3WhVeJMMNndyKCL9rC8BCFSbmykmlmmD2dSRLzqyemOoxcKZ+Rb0e1
 bMXlAvpWf0S1neOnS40JJpgulYw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ef0f34dfe1db4db897ebb79 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 18:07:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31B07C43395; Mon, 22 Jun 2020 18:07:09 +0000 (UTC)
Received: from localhost (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2FC5C433C8;
        Mon, 22 Jun 2020 18:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2FC5C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu/tree: Remove CONFIG_PREMPT_RCU check in force_qs_rnp
Date:   Mon, 22 Jun 2020 23:37:03 +0530
Message-Id: <1592849223-17774-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Remove CONFIG_PREMPT_RCU check in force_qs_rnp(). Originally,
this check was required to skip executing fqs failsafe
for rcu-sched, which was added in commit a77da14ce9af ("rcu:
Yet another fix for preemption and CPU hotplug"). However,
this failsafe has been removed, since then. So, cleanup the
code to avoid any confusion around the need for boosting,
for !CONFIG_PREMPT_RCU.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6226bfb..57c904b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2514,8 +2514,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
-			if (!IS_ENABLED(CONFIG_PREEMPT_RCU) ||
-			    rcu_preempt_blocked_readers_cgp(rnp)) {
+			if (rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
 				 * are all zero.  But we might need to
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

