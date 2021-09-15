Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A6FC43217
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67BF61157
	for <rcu@archiver.kernel.org>; Wed, 15 Sep 2021 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhIOXr3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhIOXr0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 19:47:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52DD661214;
        Wed, 15 Sep 2021 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631749566;
        bh=0pWSiEmXNjeWtq82Tf3g8888CbsbalGodtYiUW4YJUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKzkMyjc/Nh2iPsK/qz5EcGvGTin0fpbYMazP4Pa1ekHhIS+Elir9jKImXBaVP6Qn
         xRte70DQCkcjVnObyz32c3Y8raScsNmd2VfLc8awfnG09+ONuFiIjU/qouUPRpyfNX
         nGuJPTEeOQVVSJy7sBkRyNCP5+JLIcyCRZ8Hu3/jNfhg833p7zTpWV7DciM6w1wFZG
         IAJ6pH9CHWg1+4VdKQcIUzrVUJgP0oi8Rm8LrDnIQoWs3SOMz64mSnm30Hxw98quSI
         SmH51RAriPG7jgeT4acZ35wijLt8CDIFv6eKxCeZiqEogZUAoHL2SbBXubWr0nKCoy
         q2KsZrdYgmj1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D58A05C0DEE; Wed, 15 Sep 2021 16:46:05 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH rcu 13/13] rcu-tasks: Update comments to cond_resched_tasks_rcu_qs()
Date:   Wed, 15 Sep 2021 16:46:04 -0700
Message-Id: <20210915234604.3907802-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
References: <20210915234538.GA3907674@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The cond_resched_rcu_qs() function no longer exists, despite being mentioned
several times in kernel/rcu/tasks.h.  This commit therefore updates it to
the current cond_resched_tasks_rcu_qs().

Reported-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0c10c8407dca..66e7586a33e9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -368,7 +368,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 ////////////////////////////////////////////////////////////////////////
 //
 // Simple variant of RCU whose quiescent states are voluntary context
-// switch, cond_resched_rcu_qs(), user-space execution, and idle.
+// switch, cond_resched_tasks_rcu_qs(), user-space execution, and idle.
 // As such, grace periods can take one good long time.  There are no
 // read-side primitives similar to rcu_read_lock() and rcu_read_unlock()
 // because this implementation is intended to get the system into a safe
@@ -539,7 +539,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks() assumes
  * that the read-side critical sections end at a voluntary context
- * switch (not a preemption!), cond_resched_rcu_qs(), entry into idle,
+ * switch (not a preemption!), cond_resched_tasks_rcu_qs(), entry into idle,
  * or transition to usermode execution.  As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
@@ -677,7 +677,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
  * period elapses, in other words after all currently executing RCU
  * read-side critical sections have completed. call_rcu_tasks_rude()
  * assumes that the read-side critical sections end at context switch,
- * cond_resched_rcu_qs(), or transition to usermode execution (as
+ * cond_resched_tasks_rcu_qs(), or transition to usermode execution (as
  * usermode execution is schedulable). As such, there are no read-side
  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
  * this primitive is intended to determine that all tasks have passed
-- 
2.31.1.189.g2e36527f23

