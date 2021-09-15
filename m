Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0328C43219
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ABAA61165
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhIOXr1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A4CA61209;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=tK7gDNzTJijjoEzk8+ykOdWYpf1Fi5RILdgPl90J05U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d11lN9rIKG14n74/s9NhHlDG/m55MR8vzsbw2p/MYpExuwC9nildqbPibCiY6YiNJ
         5MiOfjT6/m/ZdxtGsKFrQatAHXDgG4sa0TmPIn6PBPC/ECpFb7ltMuewHIltek3THp
         fMZ5M+C0hC7YmLgiY115WyjytEUt0E9zq+iH2k/QwvPFw8hehG7Jm+PBvdky2/bz8F
         /zPcrsxxRxuAE+mBIFPSPztpzEtQkFZht8TeRlVl/PQXDa4MOg+FfBXT2p5h9o/Yb0
         LIB/fCDN1HJyv+M9rg9SVweDz6OLm8b2pxXZOanKZ5fREiP09G0ecuhcc/l1yntMCD
         djXwwIE7VGEGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CFFE15C0CCE; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/13] rcu-tasks: Clarify read side section info for rcu_tasks_rude GP primitives
Date:   Wed, 15 Sep 2021 16:46:01 -0700
Message-Id: <20210915234604.3907802-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

RCU tasks rude variant does not check whether the current
running context on a CPU is usermode. Read side critical section ends
on transition to usermode execution, by the virtue of usermode
execution being schedulable. Clarify this in comments for
call_rcu_tasks_rude() and synchronize_rcu_tasks_rude().

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index af7388849bed..8c63b4d23829 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -677,11 +677,11 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks_rude()
  * assumes that the read-side critical sections end at context switch,
- * cond_resched_rcu_qs(), or transition to usermode execution.  As such,
- * there are no read-side primitives analogous to rcu_read_lock() and
- * rcu_read_unlock() because this primitive is intended to determine
- * that all tasks have passed through a safe state, not so much for
- * data-structure synchronization.
+ * cond_resched_rcu_qs(), or transition to usermode execution (as
+ * usermode execution is schedulable). As such, there are no read-side
+ * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
+ * this primitive is intended to determine that all tasks have passed
+ * through a safe state, not so much for data-structure synchronization.
  *
  * See the description of call_rcu() for more detailed information on
  * memory ordering guarantees.
@@ -699,8 +699,8 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_rude);
  * grace period has elapsed, in other words after all currently
  * executing rcu-tasks read-side critical sections have elapsed.  These
  * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
- * anyway) cond_resched().
+ * cond_resched_tasks_rcu_qs(), userspace execution (which is a schedulable
+ * context), and (in theory, anyway) cond_resched().
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function preambles
-- 
2.31.1.189.g2e36527f23

