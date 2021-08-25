Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC51C4338F
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24541610FB
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhHYHMd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:12:33 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34032 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbhHYHMa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Aug 2021 03:12:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629875505; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=z+OKMShM2fMy+gZ/km5sQAkC8EdzVtSYeFkJgI7tvP4=; b=hfb9wknSokj7x6fuA/5q0WDib4BeI+PoP7w1l7UXTRpMTifjvjKxfkh9bzXctveX49pE44IH
 QMnO96R4dU7Lg0fn70sKxOYowH1UenKpU2LpCS+YatB4xb4ZEEh7jz/M46XzrtxyKjcuJCTg
 +tEkKHfFnWIDkHIRTMhPS+e5DRg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6125ed24c603a0154f2d4c9f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 07:11:32
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72D0FC43618; Wed, 25 Aug 2021 07:11:31 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2CDEC4338F;
        Wed, 25 Aug 2021 07:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C2CDEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v2 4/5] rcu-tasks: Fix read-side primitives comment for call_rcu_tasks_trace
Date:   Wed, 25 Aug 2021 12:40:50 +0530
Message-Id: <1629875451-20628-5-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
References: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu_tasks_trace() does have read-side primitives - rcu_read_lock_trace()
and rcu_read_unlock_trace(). Fix this information in the comments.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tasks.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 244e06a..c5f1c2f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1212,15 +1212,11 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
  * @rhp: structure to be used for queueing the RCU updates.
  * @func: actual callback function to be invoked after the grace period
  *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_tasks_trace()
- * assumes that the read-side critical sections end at context switch,
- * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
- * there are no read-side primitives analogous to rcu_read_lock() and
- * rcu_read_unlock() because this primitive is intended to determine
- * that all tasks have passed through a safe state, not so much for
- * data-structure synchronization.
+ * The callback function will be invoked some time after a trace rcu-tasks
+ * grace period elapses, in other words after all currently executing
+ * trace rcu-tasks read-side critical sections have completed. These
+ * read-side critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -1236,7 +1232,7 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
  *
  * Control will return to the caller some time after a trace rcu-tasks
  * grace period has elapsed, in other words after all currently executing
- * rcu-tasks read-side critical sections have elapsed.  These read-side
+ * trace rcu-tasks read-side critical sections have elapsed. These read-side
  * critical sections are delimited by calls to rcu_read_lock_trace()
  * and rcu_read_unlock_trace().
  *
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

