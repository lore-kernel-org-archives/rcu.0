Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C7DC43470
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B4361925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhEKXKx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhEKXKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6C8D61919;
        Tue, 11 May 2021 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774584;
        bh=MM0CqeSkHwAV3YroUCw4vgYKKdVO10PGjsqK32KIwy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+WcdkcUve8Uiw+3kZgnsUjAZqrflGb71NoTEKKRQTGMRJb/TVAU+GpoV8jFt7hpi
         7Pp9ldTXKWaQdAvGIWPp7cn3OKeTsAG2pQ29zCYPMLLetmE8H9A7hmdZEYUCWFCw0e
         z+Qk2+xQp0lqubqFTbhn5tdm0wGnZynIYQijD/pAbV44F5cAuItvOvro5rsWfFOvw8
         zssO5MXhIeaLmzsLOcfrm2qsvpXPN2R73YXcad5JxsWYEAwpzG/pId8tdnPeF2AZs4
         2CZdlugMrU2VGqn8RC16HbcYQ/rq0WwFFeMlOuWvHeGcRpFsPT9MOj1+X28l2C9yzq
         cWuD6DRMq71/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 56B2D5C09EF; Tue, 11 May 2021 16:09:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states
Date:   Tue, 11 May 2021 16:09:41 -0700
Message-Id: <20210511230942.2894861-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Heavy networking load can cause a CPU to execute continuously and
indefinitely within ksoftirqd, in which case there will be no voluntary
task switches and thus no RCU-tasks quiescent states.  This commit
therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
quiescent state.

This of course means that __do_softirq() and its callers cannot be
invoked from within a tracing trampoline.

Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b2430c16..f4daa4e60b14 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -242,6 +242,7 @@ void rcu_softirq_qs(void)
 {
 	rcu_qs();
 	rcu_preempt_deferred_qs(current);
+	rcu_tasks_qs(current, false);
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

