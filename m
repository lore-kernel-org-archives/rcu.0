Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37E2C4338F
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 07:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3BCC61076
	for <rcu@archiver.kernel.org>; Wed, 18 Aug 2021 07:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhHRH3e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Aug 2021 03:29:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33813 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232380AbhHRH3c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Aug 2021 03:29:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629271738; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BFpIm1za3PUOq2erDVvRfM+67PBhnjQaTiTXMeThml0=; b=sbuyWgMynla/1AJ6e4nX/lFOI1LhadlntiE/c9NwLf76hFMyvNDyjH1l0zuWT5vvv2eEKQI5
 XNUcuaEXhGNF2J6yZow+eumx+nV+V8m9SmifpqaSgXG+oLfyu/naVwW4exwxTNnSCwIiGymF
 KoAsXQgmRsaURFN0/SDmBio90aA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 611cb6b19507ca1a3403e293 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Aug 2021 07:28:49
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19335C43617; Wed, 18 Aug 2021 07:28:49 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91484C4338F;
        Wed, 18 Aug 2021 07:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 91484C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH 0/5] rcu-tasks miscellaneous fixes
Date:   Wed, 18 Aug 2021 12:58:38 +0530
Message-Id: <1629271723-3816-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Minor typos in comments and fixes for rcu-tasks.

Neeraj Upadhyay (5):
  rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment
  rcu-tasks: Correct firstreport usage in check_all_holdout_tasks_trace
  rcu-tasks: Correct check for no_hz_full cpu in show_stalled_task_trace
  rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
  rcu-tasks: Clarify read side section info for rcu_tasks_rude GP
    primitives

 kernel/rcu/tasks.h | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

