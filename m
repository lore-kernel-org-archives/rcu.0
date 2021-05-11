Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FE7C433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE3861925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhEKWyR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhEKWyO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 100296193E;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=dkFhhz4iUhshAQa00vsJ0fXOLT1bbaaz0LaX7HTa71I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4C0XhIbF+WWuAUjvdtnCxCP8c4VxKVlsnj8fG04uoE1R4JZwKgD/WSHKxlfDygNT
         sYMo2MgUWjnkfqUcL8d6pbfX93XwoHzG3GiYk/qpOtq9LSYHAUR/isMcV/NrvU4yzw
         3tuTRaBuAf3EztVYbR2KzAIHUvAF3gzO1jeszDfAG6HDGPlVncYK+R8+1Wx/aA6k5v
         q5/63EQmt3Cdmwew2Pjnj+KWEtE79TEIk8tYy98e2FaNPpW6xcNUGljpXuyhDn793u
         ETrO2U9mNr4O3yhmZhXosHHhbvj4/Hp/nOs9+G/8so6zSPW/tM1/Vt9jrd4AIv+D8S
         pDNC9pj4JHoQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 941D45C0DD7; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH tip/core/rcu 07/19] lockdep: Explicitly flag likely false-positive report
Date:   Tue, 11 May 2021 15:52:52 -0700
Message-Id: <20210511225304.2893154-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The reason that lockdep_rcu_suspicious() prints the value of debug_locks
is because a value of zero indicates a likely false positive.  This can
work, but is a bit obtuse.  This commit therefore explicitly calls out
the possibility of a false positive.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48d736aa03b2..d6c3c987009d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6393,6 +6393,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 {
 	struct task_struct *curr = current;
+	int dl = READ_ONCE(debug_locks);
 
 	/* Note: the following can be executed concurrently, so be careful. */
 	pr_warn("\n");
@@ -6402,11 +6403,12 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	pr_warn("-----------------------------\n");
 	pr_warn("%s:%d %s!\n", file, line, s);
 	pr_warn("\nother info that might help us debug this:\n\n");
-	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n",
+	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n%s",
 	       !rcu_lockdep_current_cpu_online()
 			? "RCU used illegally from offline CPU!\n"
 			: "",
-	       rcu_scheduler_active, debug_locks);
+	       rcu_scheduler_active, dl,
+	       dl ? "" : "Possible false positive due to lockdep disabling via debug_locks = 0\n");
 
 	/*
 	 * If a CPU is in the RCU-free window in idle (ie: in the section
-- 
2.31.1.189.g2e36527f23

