Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E30C6379B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CB86127C
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbhGUTlA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240399AbhGUTky (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F02016139A;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898890;
        bh=MwdcEzyqxvGGf9rRbzj9W8+01WNtdWk5AM4dfPjKIEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K13FYWMXVDFnYgHMWDqShTRRCby/S3XEDN1NsAWSgfRe4Lln9ZUG+EX8GJe/yrWFI
         0iljXuShFyFQvWaDPRRyOfLnH0j4ySizE0uC9EFjH/zJr/5V9Pmb8KZOGh7lxamGj8
         NLmRU/BpiJfVD3ST19GG9RqsOQpsbX1cckPppr75+BN6bsV39xCSVwEeFdlfXlybJm
         xEg9ZADcb2Gs+iUH+m0wwZsRadf/fy5InpNrXnzUmCGH+ciRhqCPdq1pXV3PQCUEvi
         3sP16LZc5C2NI+jlyRQzJ5WQEYo3tkEgcY8FSoB4MczliifLAovLvJanXFi6E6F4qB
         C0CaNQc/qgg8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4CA415C0F00; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/18] rcu: Explain why rcu_all_qs() is a stub in preemptible TREE RCU
Date:   Wed, 21 Jul 2021 13:21:25 -0700
Message-Id: <20210721202127.2129660-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The cond_resched() function reports an RCU quiescent state only in
non-preemptible TREE RCU implementation.  This commit therefore adds a
comment explaining why cond_resched() does nothing in preemptible kernels.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d9ff40f46619..6a03c3fac55cc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7781,6 +7781,17 @@ int __sched __cond_resched(void)
 		preempt_schedule_common();
 		return 1;
 	}
+	/*
+	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * whether the current CPU is in an RCU read-side critical section,
+	 * so the tick can report quiescent states even for CPUs looping
+	 * in kernel context.  In contrast, in non-preemptible kernels,
+	 * RCU readers leave no in-memory hints, which means that CPU-bound
+	 * processes executing in kernel context might never report an
+	 * RCU quiescent state.  Therefore, the following code causes
+	 * cond_resched() to report a quiescent state, but only when RCU
+	 * is in urgent need of one.
+	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
 #endif
-- 
2.31.1.189.g2e36527f23

