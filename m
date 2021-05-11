Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCDBC43600
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EEF61925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhEKXNo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhEKXNd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:13:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A29AD61970;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=HUeol4gFdWksleT74+GMDrTPrwvwDRevaKoSi42xkG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axaYhOU0RJ8fivPYyVtVQtkDU2Mu67r8Sq8ybTSwtUvrdj/2Ip/2u+tOryZORcqnv
         tQBJmbRh/9xs76HAZ6UDuMyubm/M9Yot+Aj/PETAzDXWHmkYortus6dpOqAwGHxgFo
         WeN6k8R1S6ctyVIr6UYMYTOuyrCWHOXZ1IKBOhvW9pKzykN9oB8Oo9bf6v165/bYm2
         2X9UW9R6J4NidvvYwrkBOwLJLzhnW1GQFWAOdt1ulbUrIR14GP+OJE592LbFMfEKFP
         9FsKXuXnQuL2f6HA1sx4lqrnFafL7jEGbz7/kAj/XgaCJ4OzqzkwJcEZqGxw6NYJ+R
         vrqaooWBPOpEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9925A5C0EBF; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 26/26] rcu: Don't penalize priority boosting when there is nothing to boost
Date:   Tue, 11 May 2021 16:12:23 -0700
Message-Id: <20210511231223.2895398-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU priority boosting cannot do anything unless there is at least one
task blocking the current RCU grace period that was preempted within
the RCU read-side critical section that it still resides in.  However,
the current rcu_torture_boost_failed() code will count this as an RCU
priority-boosting failure if there were no CPUs blocking the current
grace period.  This situation can happen (for example) if the last CPU
blocking the current grace period was subjected to vCPU preemption,
which is always a risk for rcutorture guest OSes.

This commit therefore causes rcu_torture_boost_failed() to refrain from
reporting failure unless there is at least one task blocking the current
RCU grace period that was preempted within the RCU read-side critical
section that it still resides in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 8bde1b53b0c9..65302518e006 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -723,6 +723,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
  * count this as an RCU priority boosting failure.  A return of true says
  * RCU priority boosting is to blame, and false says otherwise.  If false
  * is returned, the first of the CPUs to blame is stored through cpup.
+ * If there was no CPU blocking the current grace period, but also nothing
+ * in need of being boosted, *cpup is set to -1.  This can happen in case
+ * of vCPU preemption while the last CPU is reporting its quiscent state,
+ * for example.
  *
  * If cpup is NULL, then a lockless quick check is carried out, suitable
  * for high-rate usage.  On the other hand, if cpup is non-NULL, each
@@ -730,18 +734,25 @@ static void check_cpu_stall(struct rcu_data *rdp)
  */
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 {
+	bool atb = false;
 	int cpu;
 	unsigned long flags;
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
 		if (!cpup) {
-			if (READ_ONCE(rnp->qsmask))
+			if (READ_ONCE(rnp->qsmask)) {
 				return false;
-			else
+			} else {
+				if (READ_ONCE(rnp->gp_tasks))
+					atb = true;
 				continue;
+			}
 		}
+		*cpup = -1;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		if (rnp->gp_tasks)
+			atb = true;
 		if (!rnp->qsmask) {
 			// No CPUs without quiescent states for this rnp.
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -758,7 +769,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	// Can't blame CPUs, so must blame RCU priority boosting.
-	return true;
+	return atb;
 }
 EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
 
-- 
2.31.1.189.g2e36527f23

