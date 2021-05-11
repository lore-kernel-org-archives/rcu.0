Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95593C433B4
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1D161934
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEKXKv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhEKXKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEE2461624;
        Tue, 11 May 2021 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774584;
        bh=/M0p63bg1/fKxbIsfDTivMgbhmIF+/ZPH4ovwSfJMCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJB1a3iXZ+tXQQQaDZbKbqDTrKRGQ1B1RJoOldniOYSC5C+oHXCJ3bFLc/L70lqi8
         YxZiVSOBxuusOAVb389hAfwpPvqF8x4VwpjN/PUJCYTw+ONU5Rjjquv3ecIfui4qXd
         /wmPK9bKUTKdbPqwYhGTXwfsCzw2sDR9127LPXyR8dK3LHuvZgydbQy2sWHElmF19h
         TqEJTr38HsUjUOPNG7B9DU88uADjAR9u3x8J2ZmUrsEtOR0iw6YsT1VaGFqz/AwWPs
         +CUavfGP+S8WGIAUPkU+vlLfXgYKfURlhbZ0w9y8byub9Is6bVYGyFyELwbgntqFhN
         5YodD7tbQXqEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 58FCA5C0B55; Tue, 11 May 2021 16:09:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH tip/core/rcu 4/4] tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
Date:   Tue, 11 May 2021 16:09:42 -0700
Message-Id: <20210511230942.2894861-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In some architectures, the no-op variant of show_rcu_tasks_gp_kthreads()
get "no previous prototype" compiler warnings.  These are false positives
given that kernel/rcu/tasks.h is included only once.  But why put up
with the compiler noise?

This commit therefore adds "static inline" to this definition to force
the compiler to accept this situation, while also moving it to its proper
place in kernel/rcu/rcu.h.

Reported-by: kernel test robot <lkp@intel.com>
[ paulmck: Update per Stephen Rothwell feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h   | 4 ++++
 kernel/rcu/tasks.h | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d4b659..c0b3ab6736b8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -441,7 +441,11 @@ bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+#ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void show_rcu_tasks_gp_kthreads(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d6aa352cd705..fc218539d151 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1401,5 +1401,4 @@ void __init rcu_init_tasks_generic(void)
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
-- 
2.31.1.189.g2e36527f23

