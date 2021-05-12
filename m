Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0728C433B4
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 18:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809F26192E
	for <rcu@archiver.kernel.org>; Wed, 12 May 2021 18:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbhELSdK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 May 2021 14:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355652AbhELS26 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 May 2021 14:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F15C613FB;
        Wed, 12 May 2021 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620844069;
        bh=MM0CqeSkHwAV3YroUCw4vgYKKdVO10PGjsqK32KIwy4=;
        h=From:To:Cc:Subject:Date:From;
        b=Uz+ipe6Z7RPh/1pTMFzjEQ3a9Zkya83tJDLNRiYPbf2h0hwRXKSfCrP4U6fYwn+ip
         MKbDKSEPv1nIZI25CgILE9gOWYSmOhejJzUJqwpqFJGjlSBcLejNrrsi32hakU7UAD
         2ZkvZywFoR4T8c5Mg4MPgNkfhLLlhPUKGIULtoRwpCMXe3Z5ZO3quRvly+gkvmR5BZ
         WXBd1mVIAy0tw0JRGc2lPsd8deIFkjk5fX+6A8CdB3yQN+mFFN6JuyE4xbXIyyzoI+
         E3niS6EazJYloUEcojdmkW2bHv+pb0BOpnDmmkjBWv3zNYtCzHjRyjZsL+1GDrn/VN
         q3vaSlsPFWLdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 060755C0360; Wed, 12 May 2021 11:27:49 -0700 (PDT)
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
Date:   Wed, 12 May 2021 11:27:46 -0700
Message-Id: <20210512182747.3445812-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
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

