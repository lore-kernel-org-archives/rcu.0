Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9EFC388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE012083B
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604618697;
	bh=WSUvQbBbhVUpOAUFpD636ja6PJFHVfcean+yzKETEj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0g1dqDRQKv9LOF5qBQAEJPZ9sQvDJjkJeyKhVZIz0ncRBN+/Cd0uEL9x75vCtnp6s
	 Dsncb+BvWYsUByGBXKUeJPBOebfIfGPZBUHnoQQKudsNw0FmB3OsFxkpdIHoUS+9Qy
	 DwSQmcnAv6BLA772psBXpUeMBhuWZ3HaJ9bc38TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbgKEXY4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXY4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:24:56 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2316620704;
        Thu,  5 Nov 2020 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618696;
        bh=WSUvQbBbhVUpOAUFpD636ja6PJFHVfcean+yzKETEj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCI+v2Un/Qs6XdnSOlOXCmn+XOLghHQ4rfwOqVsrkqW7CpTwt/93oH6TV87EAJgtx
         BodDtFdLR0BezIDOqKypOGLM+EBLf5zc6U89WKfe6MEY3k4FRbxgL7aikcnTaEBLE/
         C7sz5H8JQhrY3UWlwIFU0sfXq4b8Vai04xl5ZUdQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jakub Kicinski <kuba@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/7] sched: Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP
Date:   Thu,  5 Nov 2020 15:24:48 -0800
Message-Id: <20201105232454.19919-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105232345.GA19179@paulmck-ThinkPad-P72>
References: <20201105232345.GA19179@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

Currently, variables used only within lockdep expressions are flagged as
unused, requiring that these variables' declarations be decorated with
either #ifdef or __maybe_unused.  This results in ugly code.  This commit
therefore causes the lockdep_tasklist_lock_is_held() function to be
visible even when lockdep is not enabled, thus removing the need for
these decorations.  This approach further relies on dead-code elimination
to remove any references to functions or variables that are not available
in non-lockdep kernels.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched/task.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 85fb2f3..c0f71f2 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -47,9 +47,7 @@ extern spinlock_t mmlist_lock;
 extern union thread_union init_thread_union;
 extern struct task_struct init_task;
 
-#ifdef CONFIG_PROVE_RCU
 extern int lockdep_tasklist_lock_is_held(void);
-#endif /* #ifdef CONFIG_PROVE_RCU */
 
 extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
-- 
2.9.5

