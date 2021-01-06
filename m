Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24098C433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C42216C4
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhAFQxT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:53:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbhAFQxO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:53:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4EA223159;
        Wed,  6 Jan 2021 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951953;
        bh=ptOijJRz7hMlFYrLJ/WDibagQ1cW8IX2w0bPLLjRwcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ue93coABGJVTaVKZBu56NpS55MlVrUtO6DBxSXfaB7HfuauSsjFq0eRAVKjNv4JVj
         5CaXUuTyOie+01gKL5V60s7F8FOcOBnxa3r98J+VTvQ9oxVq7cUnmJJPkBGyllQNOV
         zSMGxrnL7+ad89vKRyoYL50F8h361E5RTJ9jEVxidZf+m8CgNKUweeuV9Dt73+Oeoy
         23cPLuLaFj1AcR4mjPP20XxXtlc/RbbwC0Qo6mrNxRXwEvqMvHgwaiUboEQaRPQ3QW
         3LOXpXA0GlXimzxjl9OcqqhaHe3VXVQs+QVVUhOczLQreJ94s9+jPjDNlZD3ktf3Rg
         lW5Bl99UNUw6g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/4] rcu: For RCU grace-period kthread starvation, dump last CPU it ran on
Date:   Wed,  6 Jan 2021 08:52:29 -0800
Message-Id: <20210106165231.20441-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165210.GA20296@paulmck-ThinkPad-P72>
References: <20210106165210.GA20296@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When the RCU CPU stall-warning code detects that the RCU grace-period
kthread is being starved, it dumps that kthread's stack.  This can
sometimes be useful, but it is also useful to know what is running on the
CPU that this kthread is attempting to run on.  This commit therefore
adds a stack trace of this CPU in order to help track down whatever it
is that might be preventing RCU's grace-period kthread from running.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c5..35c1355 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -449,20 +449,27 @@ static void print_cpu_stall_info(int cpu)
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
+	int cpu;
 	struct task_struct *gpk = rcu_state.gp_kthread;
 	unsigned long j;
 
 	if (rcu_is_gp_kthread_starving(&j)) {
+		cpu = gpk ? task_cpu(gpk) : -1;
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
+		       gpk ? gpk->state : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
+			if (cpu >= 0) {
+				pr_err("Stack dump where RCU grace-period kthread last ran:\n");
+				if (!trigger_single_cpu_backtrace(cpu))
+					dump_cpu_task(cpu);
+			}
 			wake_up_process(gpk);
 		}
 	}
-- 
2.9.5

