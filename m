Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C5C432BE
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFD6138B
	for <rcu@archiver.kernel.org>; Wed, 25 Aug 2021 07:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhHYHMZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:12:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18650 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239199AbhHYHMW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Aug 2021 03:12:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629875497; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LRZ59MHtwhDfCCrByq/bFpM20hBGTxzPwxFPdQwcGjc=; b=B4EJ6nB60pO4jGNaJCcDzo2SknLjwK+rJKf3FdebtNNg4M6KpUzldQa/BSXRq9LCU1GPCCep
 yPB9XTVqRIWQrav9QpjCbkYzikDbK4EwWRpMq7xYPD+3/yArmACvVNTNQxUcA9U3qkHStqiu
 sPLKJZw5gjKF0jA1FGKHb0fzRMo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6125ed284f8fcf705485559b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 25 Aug 2021 07:11:36
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 299D5C43619; Wed, 25 Aug 2021 07:11:36 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 676AAC43616;
        Wed, 25 Aug 2021 07:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 676AAC43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        urezki@gmail.com, frederic@kernel.org, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH v2 5/5] rcu-tasks: Clarify read side section info for rcu_tasks_rude GP primitives
Date:   Wed, 25 Aug 2021 12:40:51 +0530
Message-Id: <1629875451-20628-6-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
References: <1629875451-20628-1-git-send-email-neeraju@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU tasks rude variant does not maintain or check whether the current
running context on a CPU is usermode. Read side critical section ends
on transition to usermode execution, by the virtue of usermode
execution being schedulable. Clarify this in comments for
call_rcu_tasks_rude() and synchronize_rcu_tasks_rude().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tasks.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c5f1c2f..691defa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -677,11 +677,11 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks_rude()
  * assumes that the read-side critical sections end at context switch,
- * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
- * there are no read-side primitives analogous to rcu_read_lock() and
- * rcu_read_unlock() because this primitive is intended to determine
- * that all tasks have passed through a safe state, not so much for
- * data-structure synchronization.
+ * cond_resched_rcu_qs(), or transition to usermode execution (as
+ * usermode execution is schedulable). As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -699,8 +699,8 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
  * grace period has elapsed, in other words after all currently
  * executing rcu-tasks read-side critical sections have elapsed.  These
  * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
- * anyway) cond_resched().
+ * cond_resched_tasks_rcu_qs(), userspace execution (which is a schedulable
+ * context), and (in theory, anyway) cond_resched().
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function preambles
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation

