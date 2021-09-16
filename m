Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEAAC4321E
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A086120C
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 00:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhIPAPR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Sep 2021 20:15:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233297AbhIPAPP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Sep 2021 20:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0C1761214;
        Thu, 16 Sep 2021 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631751235;
        bh=q3euo4fS1Kyi8ERAnOAnTtwd14GGB2zm1reA+b92Z+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzSDAWsqWaMdv6tIyhP2J76XqIvXMpHZQy22jHAOi10PseSY7GjLRKAHq0N7jMsD1
         bb5RzTWY9b9dW72e8oy5Y2up8wJyDz3HCZP4mACHu56Qwqx3gWcDqWY+DjlE3gGHmS
         f5sKRxmOF/GE9dh+HPI9ZQ5EFjwPTOKyHGYclYciNfg7MmLzxH2ML/2rTvZs6kaOT7
         YA0jvaap27Eu/SRN9YGeRS0xH5U4u35I3I5oAjgYWehQqltVWoIUdBCvK9qxGK4qNv
         Qm93tSODH6Exv3zOB2XT1j63MWcK/7q4XQRvyRQwD9if8KstBZqv5hDpV3+jKpFQ1Y
         P8d7fd7OjHbrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 499A25C09F9; Wed, 15 Sep 2021 17:13:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Scott Wood <swood@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/7] rcutorture: Avoid problematic critical section nesting on PREEMPT_RT
Date:   Wed, 15 Sep 2021 17:13:52 -0700
Message-Id: <20210916001352.3909170-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
References: <20210916001329.GA3909068@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Scott Wood <swood@redhat.com>

rcutorture is generating some nesting scenarios that are not compatible on PREEMPT_RT.
For example:
	preempt_disable();
	rcu_read_lock_bh();
	preempt_enable();
	rcu_read_unlock_bh();

The problem here is that on PREEMPT_RT the bottom halves have to be
disabled and enabled in preemptible context.

Reorder locking: start with BH locking and continue with then with
disabling preemption or interrupts. In the unlocking do it reverse by
first enabling interrupts and preemption and BH at the very end.
Ensure that on PREEMPT_RT BH locking remains unchanged if in
non-preemptible context.

Link: https://lkml.kernel.org/r/20190911165729.11178-6-swood@redhat.com
Link: https://lkml.kernel.org/r/20210819182035.GF4126399@paulmck-ThinkPad-P17-Gen-1
Signed-off-by: Scott Wood <swood@redhat.com>
[bigeasy: Drop ATOM_BH, make it only about changing BH in atomic
context. Allow enabling RCU in IRQ-off section. Reword commit message.]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 48 ++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 424184764ef0..fb079b78c232 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1432,28 +1432,34 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	/* First, put new protection in place to avoid critical-section gap. */
 	if (statesnew & RCUTORTURE_RDR_BH)
 		local_bh_disable();
+	if (statesnew & RCUTORTURE_RDR_RBH)
+		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_IRQ)
 		local_irq_disable();
 	if (statesnew & RCUTORTURE_RDR_PREEMPT)
 		preempt_disable();
-	if (statesnew & RCUTORTURE_RDR_RBH)
-		rcu_read_lock_bh();
 	if (statesnew & RCUTORTURE_RDR_SCHED)
 		rcu_read_lock_sched();
 	if (statesnew & RCUTORTURE_RDR_RCU)
 		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
 
-	/* Next, remove old protection, irq first due to bh conflict. */
+	/*
+	 * Next, remove old protection, in decreasing order of strength
+	 * to avoid unlock paths that aren't safe in the stronger
+	 * context. Namely: BH can not be enabled with disabled interrupts.
+	 * Additionally PREEMPT_RT requires that BH is enabled in preemptible
+	 * context.
+	 */
 	if (statesold & RCUTORTURE_RDR_IRQ)
 		local_irq_enable();
-	if (statesold & RCUTORTURE_RDR_BH)
-		local_bh_enable();
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
-	if (statesold & RCUTORTURE_RDR_RBH)
-		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_SCHED)
 		rcu_read_unlock_sched();
+	if (statesold & RCUTORTURE_RDR_BH)
+		local_bh_enable();
+	if (statesold & RCUTORTURE_RDR_RBH)
+		rcu_read_unlock_bh();
 	if (statesold & RCUTORTURE_RDR_RCU) {
 		bool lockit = !statesnew && !(torture_random(trsp) & 0xffff);
 
@@ -1496,6 +1502,9 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 	int mask = rcutorture_extend_mask_max();
 	unsigned long randmask1 = torture_random(trsp) >> 8;
 	unsigned long randmask2 = randmask1 >> 3;
+	unsigned long preempts = RCUTORTURE_RDR_PREEMPT | RCUTORTURE_RDR_SCHED;
+	unsigned long preempts_irq = preempts | RCUTORTURE_RDR_IRQ;
+	unsigned long bhs = RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
 
 	WARN_ON_ONCE(mask >> RCUTORTURE_RDR_SHIFT);
 	/* Mostly only one bit (need preemption!), sometimes lots of bits. */
@@ -1503,11 +1512,26 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 		mask = mask & randmask2;
 	else
 		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
-	/* Can't enable bh w/irq disabled. */
-	if ((mask & RCUTORTURE_RDR_IRQ) &&
-	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
-	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
-		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
+
+	/*
+	 * Can't enable bh w/irq disabled.
+	 */
+	if (mask & RCUTORTURE_RDR_IRQ)
+		mask |= oldmask & bhs;
+
+	/*
+	 * Ideally these sequences would be detected in debug builds
+	 * (regardless of RT), but until then don't stop testing
+	 * them on non-RT.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		/* Can't modify BH in atomic context */
+		if (oldmask & preempts_irq)
+			mask &= ~bhs;
+		if ((oldmask | mask) & preempts_irq)
+			mask |= oldmask & bhs;
+	}
+
 	return mask ?: RCUTORTURE_RDR_RCU;
 }
 
-- 
2.31.1.189.g2e36527f23

