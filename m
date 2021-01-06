Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D5C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5FA22CE3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhAFEuR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbhAFEuR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1DA5230F9;
        Wed,  6 Jan 2021 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908536;
        bh=mYC8n2tBoXxFl/HWwwJQ1b2I6TPQeCleiL/VfsurVHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnVvRZmVFkw1E/Z7mICfj3thmjT88JXkcECr+CS7+8B6IN06cDTBsU98ISUFUnzjF
         MzOLqku3auq/RF3wOVuk5ZBb9Ou1WjYA4Ze6pOJWK+DTEJ/Y0IcR2dhVKPaFeUZS+A
         0CkqqHe4v9A+Xk4D/XiOvmdCKHoS1gTf036ypLrmbX56bJbsejhIZaB57Lg++IGR8A
         ukBi0Da4C7IQb+Ry/SEpx3B9W7XDzHKC+zUaNZuhJhqcDyL87sjMLfrtikeTrSxCwL
         RdmqTRGk5PTEWMYIRdRw2NBUF/kCZ/vpyI5lTLKuHMJaVMjcJ+O3hwp7sxoR6DXcEn
         QDoWdJB59rMMA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/21] rcu/nocb: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
Date:   Tue,  5 Jan 2021 20:48:41 -0800
Message-Id: <20210106044853.20812-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit flushes the bypass queue and sets state to avoid its being
refilled before switching to the final de-offloaded state.  To avoid
refilling, this commit sets SEGCBLIST_SOFTIRQ_ONLY before re-enabling
IRQs.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c88ad62..35dc9b3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2339,12 +2339,21 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	/* Make sure nocb timer won't stay around */
 	rcu_nocb_lock_irqsave(rdp, flags);
+	/* Make sure nocb timer won't stay around */
 	WRITE_ONCE(rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_OFF);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 	del_timer_sync(&rdp->nocb_timer);
 
+	/*
+	 * Flush bypass. While IRQs are disabled and once we set
+	 * SEGCBLIST_SOFTIRQ_ONLY, no callback is supposed to be
+	 * enqueued on bypass.
+	 */
+	rcu_nocb_lock_irqsave(rdp, flags);
+	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
 	return ret;
 }
 
-- 
2.9.5

