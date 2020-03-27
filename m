Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2683C43331
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353420BED
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347905;
	bh=t2YKm8bgTn1HeOwZI5TULk2Ri2OZOPNEnL8cEhKP9zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fgUPk8N4bfwc7zXEfvGCtoydMVMvI3hYccjZUJSeYa+eK10myUOeGClhpvDDSwr8y
	 sNigC3fkWC+92ahD5GgfsjyKVXcrvPEKxwIrQxN9gsDLf4XfF5m3QjZNjr0lsysWJ/
	 QhqHDcDu70E6nH/XOsAUrD4J7qU5wvFDIlRBRvDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgC0WZE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgC0WZE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB367212CC;
        Fri, 27 Mar 2020 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347904;
        bh=t2YKm8bgTn1HeOwZI5TULk2Ri2OZOPNEnL8cEhKP9zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Muyr7dLy9Hc6fhxgL51My65Ccoo/mimhOlY6WJVTv/HKF7C814ZX0mKunEkurl+My
         tQXf7OuwHjD7dlhItMMtI7arDTJhzOZ7JLLZaNa9EUMzdy+9MXw6ZgLiMEywNhyGuu
         UGstMP4ufIt0Onphrneg+bAsnTJaW9Ag3BTzrqu8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 17/34] rcu-tasks: Move #ifdef into tasks.h
Date:   Fri, 27 Mar 2020 15:24:39 -0700
Message-Id: <20200327222456.12470-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
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
index fc7f116..b52a640 100644
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

