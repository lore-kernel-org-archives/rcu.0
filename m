Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AEBC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5BA2084D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586973417;
	bh=nGy9WgTQ6D3i0syJzgdiWa9l9kclRCKBZQM3Ki2Xmr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KwHvazdwO/fTMmImW8TrqYpwIyeairak90Q854CbyCqKIa0IbsjEj7sU9Hnd5Znjs
	 LHPGUdduUEpLFizZqhhdGWE8TZL8TKeGpdyBpIU9Ftnh3S58VNJh91aniSIT6LhlLV
	 5WnrldGZk21/AGpAtbkBAgHGWHmOUWRUvgXShTTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405379AbgDOR4y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416565AbgDOR4R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:56:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D38F7208E4;
        Wed, 15 Apr 2020 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586973377;
        bh=nGy9WgTQ6D3i0syJzgdiWa9l9kclRCKBZQM3Ki2Xmr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zRaJmXK5DLGjDphkpQfeinamK8ABzvjyoN9bWZLvfReGjEIaY/LB38XfqB1t9DPtg
         B3e/M1GCLZ2wf9HGuT2/lKwM7u6tV+Kotz0Dt+Rv7GF7kHmb31Uan/sMHrCELRtyCs
         JjmUjd/Y8WIhOZHkUOuMaZ2/POcS/Tayq8/boAn0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH tip/core/rcu 2/6] rcu: Make rcu_read_unlock_special() safe for rq/pi locks
Date:   Wed, 15 Apr 2020 10:56:10 -0700
Message-Id: <20200415175614.10837-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415175543.GA10416@paulmck-ThinkPad-P72>
References: <20200415175543.GA10416@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The scheduler is currently required to hold rq/pi locks across the entire
RCU read-side critical section or not at all.  This is inconvenient and
leaves traps for the unwary, including the author of this commit.

But now that excessively ong grace periods enable scheduling-clock
interrupts for holdout nohz_full CPUs, the nohz_full rescue logic in
rcu_read_unlock_special() can be dispensed with.  In other words, the
rcu_read_unlock_special() function can refrain from doing wakeups unless
such wakeups are guaranteed safe.

This commit therefore avoids unsafe wakeups, freeing the scheduler to
hold rq/pi locks across rcu_read_unlock() even if the corresponding RCU
read-side critical section might have been preempted.

This commit is inspired by a patch from Lai Jiangshan:
https://lore.kernel.org/lkml/20191102124559.1135-2-laijs@linux.alibaba.com
This commit is further intended to be a step towards his goal of permitting
the inlining of RCU-preempt's rcu_read_lock() and rcu_read_unlock().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/rcu/tree_plugin.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 097635c..ccad776 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -615,19 +615,18 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
-		exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
-		      (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
-		      tick_nohz_full_cpu(rdp->cpu);
+		exp = (t->rcu_blocked_node &&
+		       READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
+		      (rdp->grpmask & READ_ONCE(rnp->expmask));
 		// Need to defer quiescent state until everything is enabled.
-		if (irqs_were_disabled && use_softirq &&
-		    (in_interrupt() ||
-		     (exp && !t->rcu_read_unlock_special.b.deferred_qs))) {
-			// Using softirq, safe to awaken, and we get
-			// no help from enabling irqs, unlike bh/preempt.
+		if (use_softirq && (in_irq() || (exp && !irqs_were_disabled))) {
+			// Using softirq, safe to awaken, and either the
+			// wakeup is free or there is an expedited GP.
 			raise_softirq_irqoff(RCU_SOFTIRQ);
 		} else {
 			// Enabling BH or preempt does reschedule, so...
-			// Also if no expediting or NO_HZ_FULL, slow is OK.
+			// Also if no expediting, slow is OK.
+			// Plus nohz_full CPUs eventually get tick enabled.
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-- 
2.9.5

