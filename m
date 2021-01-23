Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE24AC433DB
	for <rcu@archiver.kernel.org>; Sat, 23 Jan 2021 09:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939CC2370D
	for <rcu@archiver.kernel.org>; Sat, 23 Jan 2021 09:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbhAWJzH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Jan 2021 04:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbhAWJzF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Jan 2021 04:55:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA6C06174A;
        Sat, 23 Jan 2021 01:54:25 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m5so5414627pjv.5;
        Sat, 23 Jan 2021 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2zaKFy4Ti6zlMHdCbJBd9eRKJbtUauUBtadJDj+E3v8=;
        b=pd5e++T5Cdjjg3yC4Jj2OMaJ9ugN9p3O7CPkSXUlaIDw3yCMbnH43OH5XVULn9zl40
         htGFWwcSL/ltLyKfiukVtwd33dXP4VYWJe2QMu1NbqSNGxDrhTwUnp7E8r0bnXVpuTWP
         dKeN58/HXzZTljDdnP611pACjAson6AFGJZj0/1bcFN7D05JyEFGFm93H0cAOkAfYQ1J
         jyQowiydBZgkJbcoVZC8t5+ei5AwCxnmQzsNHSf6MvN9SJIiUc9QuMEyJ7euHtSAuHOc
         CgdmB40iXCIF6hBRR8k+k9ADSIqUXyCzXAlu0fKB2IT8o6qO83aiJVUsYCt/fVVHHKBO
         wlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2zaKFy4Ti6zlMHdCbJBd9eRKJbtUauUBtadJDj+E3v8=;
        b=j4/iPiRlyxSOQgerROgJNYU7lpHXO1AHybqO0MTSHXWPfST38ArV9/NyPjlmoAZnPE
         ybirN7aIwRGJ+q1TMEVRnteyJsiOqCcPtCr+D8mG1072s1KRLVSYihkxd1euHn5ef8Bh
         0TkELe0d4cQ+f4m5UV7T/CWs4PrXglCrdHGp7PasaR+nC58E9R5TtBbfdbdBXBUGZL+E
         6sgokTKAbFqPm5TFKEZ8Wh1EwPFiMIIr6xLbtv436zuymIGPcxtEi4M4W0B0Zn/afWI/
         gSXFdumHGhvmPUKmGMcXSnVVFVqIbQiuJB0mgLJn8MtsMvIS+aYGxTE7K0sOPjGB1bIW
         Le4A==
X-Gm-Message-State: AOAM5316ns0FA6aQOUmUjiCOjPrUzOq0vXZCBWPNYb68m4imTUViCHnl
        ZrLAMjwb5JjT8aHNlQKj2HY=
X-Google-Smtp-Source: ABdhPJxeUh8DI8HSPg1I6oxyeOWFkd6UQo7q5x+lfJGK1AZ9ce9n71FS/Dvaohdy+1vq9dDawpB+BQ==
X-Received: by 2002:a17:90a:e297:: with SMTP id d23mr10298856pjz.42.1611395665096;
        Sat, 23 Jan 2021 01:54:25 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id c5sm11978857pjo.4.2021.01.23.01.54.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 01:54:24 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     dave@stgolabs.net, paulmck@kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] rcutorture: replace the function name with %s
Date:   Sat, 23 Jan 2021 17:54:17 +0800
Message-Id: <1611395657-6645-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Better to replace the function name with %s in case of changes.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2440f89..e561641 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2016,8 +2016,8 @@ static int rcu_torture_stall(void *args)
 			local_irq_disable();
 		else if (!stall_cpu_block)
 			preempt_disable();
-		pr_alert("rcu_torture_stall start on CPU %d.\n",
-			 raw_smp_processor_id());
+		pr_alert("%s start on CPU %d.\n",
+			  __func__, raw_smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
 			if (stall_cpu_block)
@@ -2028,7 +2028,7 @@ static int rcu_torture_stall(void *args)
 			preempt_enable();
 		cur_ops->readunlock(idx);
 	}
-	pr_alert("rcu_torture_stall end.\n");
+	pr_alert("%s end.\n", __func__);
 	torture_shutdown_absorb("rcu_torture_stall");
 	while (!kthread_should_stop())
 		schedule_timeout_interruptible(10 * HZ);
-- 
1.8.3.1

