Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BDC4338F
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2481F610FB
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhHYHMB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:12:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:38919 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbhHYHMA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Aug 2021 03:12:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629875475; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sWhAYxAL7TT2/0TBaegjVGuh0rk6amExECv1CD+bCpg=; b=GUYly0wv/Cm1hFaIHlAxfg1aoHyGyJWI9hWLrsL0TDwn8amFYcmVJ3ZaODU1tskQXd+cVNNG
 Iu6i93bMuM2iN7fMxCLRUTwfezd8oeHItyYX3+yTy6SwQCoOdG/kkRX6gJ6zaVqWNSBKTYVJ
 /n8rWQ/nixt5m2JD38X2DvAwnsk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6125ed06fc1f4cb692ec55b1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 07:11:02
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B797C4360C; Wed, 25 Aug 2021 07:11:02 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0029CC4338F;
        Wed, 25 Aug 2021 07:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0029CC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v2 0/5] rcu-tasks miscellaneous fixes
Date:   Wed, 25 Aug 2021 12:40:46 +0530
Message-Id: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Minor typos in comments and fixes for rcu-tasks.

V1 -> V2:
- Update comment in patch 4/5, as suggested by Paul.

Neeraj Upadhyay (5):
  rcu-tasks: Fix s/rcu_add_holdout/trc_add_holdout/ typo in comment
  rcu-tasks: Correct firstreport usage in check_all_holdout_tasks_trace
  rcu-tasks: Correct check for no_hz_full cpu in show_stalled_task_trace
  rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
  rcu-tasks: Clarify read side section info for rcu_tasks_rude GP
    primitives

 kernel/rcu/tasks.h | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

