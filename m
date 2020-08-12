Return-Path: <SRS0=nsBp=BW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04100C433DF
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE6822BF5
	for <rcu@archiver.kernel.org>; Wed, 12 Aug 2020 22:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597273086;
	bh=ZPE1HTxpLJWa5ErT52Cxkkm9sLFUiyxPk/mt+0FIM3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hu8SmlyFKEvBZHNFU7qELcAOTnOvpyO7Az7NNdeyUqf0X6mWb+QtyeSdDESe3eSY0
	 EYF5XI5kmR4wBeO1NRcbLya+F+KRDXcVZHv/lYFmi7JLCbn0uOz5a5S6IyzQU2gCHg
	 /5EykUFwSNFgTPR4oJvJ5qrbFDSpVknMt6ewxbko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHLW6A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 12 Aug 2020 18:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgHLW5g (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 12 Aug 2020 18:57:36 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B0D214F1;
        Wed, 12 Aug 2020 22:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597273055;
        bh=ZPE1HTxpLJWa5ErT52Cxkkm9sLFUiyxPk/mt+0FIM3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWEGuJK22E+re99O6cayUvFaO0nA4tQMkzXsuByL/7lcyagXOojdKeliIDUDMZGDq
         0mudQBFEXp7zcF1HKZpaIlYfU09AUv8/T7lYB3b1QBOxBrIJvDfH1LkkYHrYZHnVT9
         IF9D63GFWVW2s+1OGPg1o5A9226xZZGa6n/7uC9w=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        elver@google.com, dvyukov@google.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/12] rcu: Do full report for .need_qs for strict GPs
Date:   Wed, 12 Aug 2020 15:57:26 -0700
Message-Id: <20200812225732.20068-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200812225632.GA19759@paulmck-ThinkPad-P72>
References: <20200812225632.GA19759@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The rcu_preempt_deferred_qs_irqrestore() function is invoked at
the end of an RCU read-side critical section (for example, directly
from rcu_read_unlock()) and, if .need_qs is set, invokes rcu_qs() to
report the new quiescent state.  This works, except that rcu_qs() only
updates per-CPU state, leaving reporting of the actual quiescent state
to a later call to rcu_report_qs_rdp(), for example from within a later
RCU_SOFTIRQ instance.  Although this approach is exactly what you want if
you are more concerned about efficiency than about short grace periods,
in CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels, short grace periods are
the name of the game.

This commit therefore makes rcu_preempt_deferred_qs_irqrestore() directly
invoke rcu_report_qs_rdp() in CONFIG_RCU_STRICT_GRACE_PERIOD=y, thus
shortening grace periods.

Historical note:  To the best of my knowledge, causing rcu_read_unlock()
to directly report a quiescent state first appeared in Jim Houston's
and Joe Korty's JRCU.  This is the second instance of a Linux-kernel RCU
feature being inspired by JRCU, the first being RCU callback offloading
(as in the RCU_NOCB_CPU Kconfig option).

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7ed55c5..1761ff4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -459,8 +459,12 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		return;
 	}
 	t->rcu_read_unlock_special.s = 0;
-	if (special.b.need_qs)
-		rcu_qs();
+	if (special.b.need_qs) {
+		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
+			rcu_report_qs_rdp(rdp->cpu, rdp);
+		else
+			rcu_qs();
+	}
 
 	/*
 	 * Respond to a request by an expedited grace period for a
-- 
2.9.5

