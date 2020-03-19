Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE5DC55188
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF1C2076F
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576692;
	bh=/lNK+4AM9ncCFxX+MXSXM9gMwQMVbCsWMIAl06YFsLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1YgeCCzc3CG6oHjSq4gaooeG9KiEpBl+ECbYCWqDZ2Zc45iscVyv2CKiHoF3axXSu
	 hkXwv3Lzex9pXt7WHmXHl0lXsiAhsl/SAQg/NjTwYr65QrQVvx1097pE2ht1ayABRD
	 vGu08p9O+69ipssUd1UyXMbPvlzGr5kTcxoW6j28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCSALc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgCSALI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15ED20A8B;
        Thu, 19 Mar 2020 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576667;
        bh=/lNK+4AM9ncCFxX+MXSXM9gMwQMVbCsWMIAl06YFsLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N03b92lE/zMh4l3V4ifhQMgPHwnMkRpH0Q6dON4fpatIKPgXxfMV1W7lPpL+XG3YL
         B3NoIFH2c//ufCcWhhtXSugLxKpTNUvzn4XtU/fFJXmjZxlXN9jl7iw5LUcObGGuD2
         tYd+81SiWM4Jxj3XztdnHG6SZYJPRuchDIiZ4X2c=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 17/22] rcu-tasks: Move #ifdef into tasks.h
Date:   Wed, 18 Mar 2020 17:10:55 -0700
Message-Id: <20200319001100.24917-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit pushes the #ifdef CONFIG_TASKS_RCU_GENERIC from
kernel/rcu/update.c to kernel/rcu/tasks.h in order to improve
readability as more APIs are added.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h  | 5 +++++
 kernel/rcu/update.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e6ef98e..220f264 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Paul E. McKenney
  */
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -976,3 +977,7 @@ core_initcall(rcu_spawn_tasks_trace_kthread);
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
+
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void rcu_tasks_bootup_oddness(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 16058a5..0fb2a9e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -559,11 +559,7 @@ late_initcall(rcu_verify_early_boot_tests);
 void rcu_early_boot_tests(void) {}
 #endif /* CONFIG_PROVE_RCU */
 
-#ifdef CONFIG_TASKS_RCU_GENERIC
 #include "tasks.h"
-#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
-static inline void rcu_tasks_bootup_oddness(void) {}
-#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
 #ifndef CONFIG_TINY_RCU
 
-- 
2.9.5

