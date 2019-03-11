Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E758C43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBDA2084D
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SQtkWwru";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oQ29EOGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCKJq0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:46:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34278 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCKJqZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Mar 2019 05:46:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F387161AAC; Mon, 11 Mar 2019 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552297585;
        bh=JxSVU/SSe8lP2Aj/IFNvDfKxJZKSr+VYBcHiCZhUSOs=;
        h=From:To:Cc:Subject:Date:From;
        b=SQtkWwru4nSdTI19q1HFRRaC1U1c3b2zf8QOlAJoLWQy7ANluiZFwXeC+jldu2Xrz
         VgixjlureK9zA2CWeQWBf7yCFXQKgZ7yJvtZojfLZDmp7OJzu89r4VqMciRVpEzZE3
         kG2EIFwNhmt10B41Zi2mRW2eXO7PFLcHd+vZmSw4=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C26DE61340;
        Mon, 11 Mar 2019 09:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552297582;
        bh=JxSVU/SSe8lP2Aj/IFNvDfKxJZKSr+VYBcHiCZhUSOs=;
        h=From:To:Cc:Subject:Date:From;
        b=oQ29EOGPaNeCsmQMJ0buvvI7xElq0RMBLUS9Hivj6LovCd0Drwtt/NyxL+2afDkSE
         lnFgencAm687lqowRpWPx8SxRxyYYSCUmSZIpx2XbArv6Nizy8tZsRgjj77KbdZ2En
         7TZsNmgmoEXWvwpBlDO8MEQKoDwvAHlXz2FiVHzM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C26DE61340
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     rcu@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu/tree: Default jiffies_to_sched_qs to jiffies_till_sched_qs
Date:   Mon, 11 Mar 2019 15:16:11 +0530
Message-Id: <1552297571-5617-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Current code does not call adjust_jiffies_till_sched_qs(),
if jiffies_till_sched_qs is specified. For the case, where
jiffies_till_first_fqs and jiffies_till_next_fqs are default,
jiffies_to_sched_qs won't be a correct adjustment of
jiffies_till_sched_qs.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ddd5c74..10aeb89 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3259,8 +3259,7 @@ static void __init rcu_init_geometry(void)
 		jiffies_till_first_fqs = d;
 	if (jiffies_till_next_fqs == ULONG_MAX)
 		jiffies_till_next_fqs = d;
-	if (jiffies_till_sched_qs == ULONG_MAX)
-		adjust_jiffies_till_sched_qs();
+	adjust_jiffies_till_sched_qs();
 
 	/* If the compile-time values are accurate, just leave. */
 	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

