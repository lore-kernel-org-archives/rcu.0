Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADAC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70ED161935
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKWyV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66B4F61931;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=0d5bi3hjAF94P+mGJMXhhe1JF0CFHUsMHJdas6S8C/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/fSLI62B+p1iAwq9hDPas9VM+3kIExWmQBOCQZTe7OFZ3MG/O69r9OixtYX/QUrz
         HbzGj636d34CZCNipSfgVqFWrCOsxUnM7jRrO9g2X2Zy8QPYqHy3Ul7VYeXvl7W1zf
         VfNAOD7OdjfEs0ouNS9XnFhoiqOrbaFVYPkFGseRFYsF2IuJw8Dv2l2Dl2lujAMnmI
         NXQV7qamlMF3AUJOf+3FX1j1iyuVzFnhnwhS/omoPltVQF2MQsEuiGq7/TQxWmyWNP
         pXdmv5RfiPmB/sVXu1Fg9GSHaPgmaxQvjXqQ13CLEU8k/5+RYj7VSgWJm19RFzrmIX
         YB4dqwprReYWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A7C4B5C0E5B; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 18/19] rcu: Remove obsolete rcu_read_unlock() deadlock commentary
Date:   Tue, 11 May 2021 15:53:03 -0700
Message-Id: <20210511225304.2893154-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The deferred quiescent states resulting from the consolidation of RCU-bh
and RCU-sched into RCU means that rcu_read_unlock() will no longer attempt
to acquire scheduler locks if interrupts were disabled across that call
to rcu_read_unlock().  The cautions in the rcu_read_unlock() header
comment are therefore obsolete.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 45e58f14b1ce..323954363389 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -702,33 +702,12 @@ static __always_inline void rcu_read_lock(void)
 /**
  * rcu_read_unlock() - marks the end of an RCU read-side critical section.
  *
- * In most situations, rcu_read_unlock() is immune from deadlock.
- * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
- * is responsible for deboosting, which it does via rt_mutex_unlock().
- * Unfortunately, this function acquires the scheduler's runqueue and
- * priority-inheritance spinlocks.  This means that deadlock could result
- * if the caller of rcu_read_unlock() already holds one of these locks or
- * any lock that is ever acquired while holding them.
- *
- * That said, RCU readers are never priority boosted unless they were
- * preempted.  Therefore, one way to avoid deadlock is to make sure
- * that preemption never happens within any RCU read-side critical
- * section whose outermost rcu_read_unlock() is called with one of
- * rt_mutex_unlock()'s locks held.  Such preemption can be avoided in
- * a number of ways, for example, by invoking preempt_disable() before
- * critical section's outermost rcu_read_lock().
- *
- * Given that the set of locks acquired by rt_mutex_unlock() might change
- * at any time, a somewhat more future-proofed approach is to make sure
- * that that preemption never happens within any RCU read-side critical
- * section whose outermost rcu_read_unlock() is called with irqs disabled.
- * This approach relies on the fact that rt_mutex_unlock() currently only
- * acquires irq-disabled locks.
- *
- * The second of these two approaches is best in most situations,
- * however, the first approach can also be useful, at least to those
- * developers willing to keep abreast of the set of locks acquired by
- * rt_mutex_unlock().
+ * In almost all situations, rcu_read_unlock() is immune from deadlock.
+ * In recent kernels that have consolidated synchronize_sched() and
+ * synchronize_rcu_bh() into synchronize_rcu(), this deadlock immunity
+ * also extends to the scheduler's runqueue and priority-inheritance
+ * spinlocks, courtesy of the quiescent-state deferral that is carried
+ * out when rcu_read_unlock() is invoked with interrupts disabled.
  *
  * See rcu_read_lock() for more information.
  */
-- 
2.31.1.189.g2e36527f23

