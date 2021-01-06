Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D81DC433E9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9652311E
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 16:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAFQxO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:53:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhAFQxO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 11:53:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E036623331;
        Wed,  6 Jan 2021 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609951954;
        bh=R0SAKfueyJltvmZA7TSOV4iN4gDsf3a43uV6vHVaTSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2DtfzXDssSqGNTB2emk//OWUOA0wGtBqnW2QW5acrfMgQTrhJFPUtIpSvSgng9AT
         14pZfHQvbVSMxQljxIvEUem4ymZJEGM0pw71YxEfB/yD1mI2+QxA2f/M2I1tueoPLv
         upI7wPbE6JbJgVL5Vhq+aBwDgbBXdm8wKFo00AhD2OjXGNqDGgs4wlAs6p1l/kdbof
         oNXJohOPbhXFyep/O59ux/6oYd61uyEP7NBalMJWR4S5U10b7Yxp1K5P0Y7RMNG4c/
         LxVD5Mmxv0TKRMZlIEVSo4KAUqd3hAnxKVsSSmTUZWMgzYHwvhkLfuEw76PGrdQTji
         +jkd4sewsMObg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/4] rcu: Do not NMI offline CPUs
Date:   Wed,  6 Jan 2021 08:52:30 -0800
Message-Id: <20210106165231.20441-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106165210.GA20296@paulmck-ThinkPad-P72>
References: <20210106165210.GA20296@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, RCU CPU stall warning messages will NMI whatever CPU looks
like it is blocking either the current grace period or the grace-period
kthread.  This can produce confusing output if the target CPU is offline.
This commit therefore checks for offline CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 35c1355..29cf096 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -333,9 +333,12 @@ static void rcu_dump_cpu_stacks(void)
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
-			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
-				if (!trigger_single_cpu_backtrace(cpu))
+			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
+				if (cpu_is_offline(cpu))
+					pr_err("Offline CPU %d blocking current GP.\n", cpu);
+				else if (!trigger_single_cpu_backtrace(cpu))
 					dump_cpu_task(cpu);
+			}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
@@ -466,9 +469,13 @@ static void rcu_check_gp_kthread_starvation(void)
 			pr_err("RCU grace-period kthread stack dump:\n");
 			sched_show_task(gpk);
 			if (cpu >= 0) {
-				pr_err("Stack dump where RCU grace-period kthread last ran:\n");
-				if (!trigger_single_cpu_backtrace(cpu))
-					dump_cpu_task(cpu);
+				if (cpu_is_offline(cpu)) {
+					pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
+				} else  {
+					pr_err("Stack dump where RCU GP kthread last ran:\n");
+					if (!trigger_single_cpu_backtrace(cpu))
+						dump_cpu_task(cpu);
+				}
 			}
 			wake_up_process(gpk);
 		}
-- 
2.9.5

