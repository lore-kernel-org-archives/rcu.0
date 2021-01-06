Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A7C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B02C22D01
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 04:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhAFEvT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbhAFEuR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 23:50:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD862230FE;
        Wed,  6 Jan 2021 04:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609908537;
        bh=4N/ttNNejpsHl6sFyhRfALMQ7Vl3QKfj945XUGPFMaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9QpSS64Ko5SeN3Ta8jJtsoDq0TvmLq5pJddrrB8+jikQ42e2L94cxm4fGVsUBx3+
         +FUzJsx69+LUs5R+WyIHjy7FGFotEV5nLmiTPb7vyBRSZ6zN3KSh8fZQUcOGPINjEh
         jI4sIMRYmbRasDQayPzGWzxSU0hbzZtCB01NSu8cw1yNm+OBUldN7HiwT61hOJHXRm
         sxxgvlbOFaaZkfqIKqUEIRQ318UX4vSsdqaIVibrCcrqpt3u1mNzWjOZLBHp2Wnm6d
         ggep5H1EduyAzGCbjaQyF0O34Mk0Ity3rOM6CzwjkLOsQjOr9MrEQMqdcGvqzR2Ijc
         yO5pyo1phHC3Q==
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
Subject: [PATCH tip/core/rcu 10/21] rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
Date:   Tue,  5 Jan 2021 20:48:42 -0800
Message-Id: <20210106044853.20812-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106013950.GA14663@paulmck-ThinkPad-P72>
References: <20210106013950.GA14663@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit sets SEGCBLIST_SOFTIRQ_ONLY once toggling is otherwise fully
complete, allowing further RCU callback manipulation to be carried out
locklessly and locally.

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
 kernel/rcu/tree_plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 35dc9b3..8641b72 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2352,7 +2352,14 @@ static int __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	 */
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
-	rcu_nocb_unlock_irqrestore(rdp, flags);
+	rcu_segcblist_set_flags(cblist, SEGCBLIST_SOFTIRQ_ONLY);
+	/*
+	 * With SEGCBLIST_SOFTIRQ_ONLY, we can't use
+	 * rcu_nocb_unlock_irqrestore() anymore. Theoretically we
+	 * could set SEGCBLIST_SOFTIRQ_ONLY with cb unlocked and IRQs
+	 * disabled now, but let's be paranoid.
+	 */
+	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 
 	return ret;
 }
-- 
2.9.5

