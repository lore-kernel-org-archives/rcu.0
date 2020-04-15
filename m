Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B99C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E3D20787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974928;
	bh=1XnsCZM+pttPcms4B+LS2wz1W45AlBaSp+DmLTPoFXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t0NfJTZkHUM+IDh6nAfUKiCjwtE7VE4E6OCPhQdUdbxm9Z0HJ7CMmPwo69PcalY8g
	 rMLk4BG4mfgcj8Mkn+f5/K8WbcVSaM5alaFUMosPXDxB+30L6/rllm5kjWerh5APMG
	 zePH+DGN08zWCdXBpsNbVT/nNFFst06D3xMMlbTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441504AbgDOSWF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441378AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD37921835;
        Wed, 15 Apr 2020 18:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974789;
        bh=1XnsCZM+pttPcms4B+LS2wz1W45AlBaSp+DmLTPoFXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+MTIUhLV+e7ifBGL5oKiJ2946Nd8OGVabwc/tpIT2Dk7JVfzpxg+KfDYPbdGt8Ij
         RNSByyKcl43upuEWWHogmfaAsytFP1x3ihyRnWoXQ3234sLjIpRAdMgFCQh/NKx67O
         idJVdQL/brYE4cs3jFz/KouLQMiFn4fMmaofZ6go=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 18/38] rcu-tasks: Move #ifdef into tasks.h
Date:   Wed, 15 Apr 2020 11:19:21 -0700
Message-Id: <20200415181941.11653-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
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
index 1484e8c..d65a97f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -5,6 +5,7 @@
  * Copyright (C) 2020 Paul E. McKenney
  */
 
+#ifdef CONFIG_TASKS_RCU_GENERIC
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -980,3 +981,7 @@ core_initcall(rcu_spawn_tasks_trace_kthread);
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
+
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void rcu_tasks_bootup_oddness(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 30dce20..c579934 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -584,11 +584,7 @@ late_initcall(rcu_verify_early_boot_tests);
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

