Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BADC6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5587561244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhGUTky (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51F246124C;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=mjtFv0UvBo/F+L2Q18GUSdbQSbd6/xyupeGingIlhY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oftJ9rAowAtEY6tYw4Sm8SSVnrDLSyFslPDSyYiMIJ/hhoRmY//jcklk47Hrn5E9E
         PUujGUEV51tB74MjzTylplTIl5rPUDMoHiNqqZPbzh1QYQfa14Kzwct9ndbmgyl3hz
         wdX48XyyhtVi7wDAoOHgwgWVUZoeVj2BQCXRy6/dWsoYr9NWm3fxQoOfR/61VPb/u0
         sQRAVo7I1CBnL1Bg3+ZczDl2NqNlatF+eAfaoyVuTPKLHfvg9S5S+C1wfmtfR2g/+e
         oH3YfASrLuWo1dN75Q+xrUUj7iquhGqbmJK2YiHsI52ca90xSd3Kydfbnd6L/gsrLA
         bwqX/q2VnI6ZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 108A15C0A03; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Yanfei Xu <yanfei.xu@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/18] rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock
Date:   Wed, 21 Jul 2021 13:21:10 -0700
Message-Id: <20210721202127.2129660-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

If rcu_print_task_stall() is invoked on an rcu_node structure that does
not contain any tasks blocking the current grace period, it takes an
early exit that fails to release that rcu_node structure's lock.  This
results in a self-deadlock, which is detected by lockdep.

To reproduce this bug:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"

This will also result in other complaints, including RCU's scheduler
hook complaining about blocking rather than preemption and an rcutorture
writer stall.

Only a partial RCU CPU stall warning message will be printed because of
the self-deadlock.

This commit therefore releases the lock on the rcu_print_task_stall()
function's early exit path.

Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2e96f9741666d..bd4de5bc5807e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -267,8 +267,10 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *ts[8];
 
 	lockdep_assert_irqs_disabled();
-	if (!rcu_preempt_blocked_readers_cgp(rnp))
+	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
+	}
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
 	       rnp->level, rnp->grplo, rnp->grphi);
 	t = list_entry(rnp->gp_tasks->prev,
-- 
2.31.1.189.g2e36527f23

