Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AC4C43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 11:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6555206BA
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 11:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RF1SuSVn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RF1SuSVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCKL6Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:58:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33202 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfCKL6Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Mar 2019 07:58:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A0F31607C3; Mon, 11 Mar 2019 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552305495;
        bh=Y2IRlFLoyrzQx9/WpAt2HfDQOUyExWd76elA5fIv5hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RF1SuSVnJb9F8YTROEAX2IsH3k5F59z4v+2uiODSeQnCf7wASDYozDAClSVn5e7LJ
         +DvK4yCZYIWPQmEi0mtOX17Vpy85LL2z+a1mJ4HgOOLhPWcp+BS0NExpWb1YzF/bO4
         Zw8NXreBpK8WpFjy4d4yglmvIq+jmInhzRbqaozo=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66A7260159;
        Mon, 11 Mar 2019 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552305495;
        bh=Y2IRlFLoyrzQx9/WpAt2HfDQOUyExWd76elA5fIv5hQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RF1SuSVnJb9F8YTROEAX2IsH3k5F59z4v+2uiODSeQnCf7wASDYozDAClSVn5e7LJ
         +DvK4yCZYIWPQmEi0mtOX17Vpy85LL2z+a1mJ4HgOOLhPWcp+BS0NExpWb1YzF/bO4
         Zw8NXreBpK8WpFjy4d4yglmvIq+jmInhzRbqaozo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66A7260159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     rcu@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcuupdate: Do a single rhp->func read in rcu_head_after_call_rcu
Date:   Mon, 11 Mar 2019 17:28:03 +0530
Message-Id: <1552305483-15846-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Read rhp->func pointer in rcu_head_after_call_rcu() only once,
to avoid warning in the case, where call_rcu() happens between
two reads of rhp->func.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 include/linux/rcupdate.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6cdb1db..174768e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -878,9 +878,10 @@ static inline void rcu_head_init(struct rcu_head *rhp)
 static inline bool
 rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 {
-	if (READ_ONCE(rhp->func) == f)
+	rcu_callback_t func = READ_ONCE(rhp->func);
+	if (func == f)
 		return true;
-	WARN_ON_ONCE(READ_ONCE(rhp->func) != (rcu_callback_t)~0L);
+	WARN_ON_ONCE(func != (rcu_callback_t)~0L);
 	return false;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

