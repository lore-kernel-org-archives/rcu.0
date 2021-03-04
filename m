Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76162C433E9
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5564564EEE
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhCDBBF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345169AbhCDA0u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F020464E51;
        Thu,  4 Mar 2021 00:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817594;
        bh=yXGcZW2wWfu41VYgk2M2ElY38HMuoYksAX7Pf7DoV/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=et1zxteZXdmCPsXOcrSLXdf8B24TIXjD8xuPMjc3vLoIgcmde59CcbkGWGJkPjhXQ
         3mIgle1hkRFARcygVdO3FCzwgQ9PGne4HCLKxsnOL0Rldruy91DJsyCxbwtnWTCSAr
         W4YPEH92WncXYo2KqEnyXXMr++CeGFo8LiWhBesVhzYvMrDzT9nrTAIJeKg+Rlnj4A
         MXU0HKdx61/KBeMjpqQ3BUdVQaQfHJM9GvUvzFLJ1lGLB8wKAuy71gAoXj9rftO1xG
         aywrxorsfYu3YAej2eqpJjnFgeW42UNPdtmmDZzu6Cqlpcx52mPwvOoRNLYBnVtEQO
         whVGeDAmwyueA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] rcu: Provide polling interfaces for Tree RCU grace periods
Date:   Wed,  3 Mar 2021 16:26:30 -0800
Message-Id: <20210304002632.23870-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002605.GA23785@paulmck-ThinkPad-P72>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

There is a need for a non-blocking polling interface for RCU grace
periods, so this commit supplies start_poll_synchronize_rcu() and
poll_state_synchronize_rcu() for this purpose.  Note that the existing
get_state_synchronize_rcu() may be used if future grace periods are
inevitable (perhaps due to a later call_rcu() invocation).  The new
start_poll_synchronize_rcu() is to be used if future grace periods
might not otherwise happen.  Finally, poll_state_synchronize_rcu()
provides a lockless check for a grace period having elapsed since
the corresponding call to either of the get_state_synchronize_rcu()
or start_poll_synchronize_rcu().

As with get_state_synchronize_rcu(), the return value from either
get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
to a later call to either poll_state_synchronize_rcu() or the existing
(might_sleep) cond_synchronize_rcu().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutree.h |  2 ++
 kernel/rcu/tree.c       | 70 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index df578b7..b89b541 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -41,6 +41,8 @@ void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
 unsigned long get_state_synchronize_rcu(void);
+unsigned long start_poll_synchronize_rcu(void);
+bool poll_state_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu(unsigned long oldstate);
 
 void rcu_idle_enter(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..8e0a140 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3774,8 +3774,8 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  * get_state_synchronize_rcu - Snapshot current RCU state
  *
  * Returns a cookie that is used by a later call to cond_synchronize_rcu()
- * to determine whether or not a full grace period has elapsed in the
- * meantime.
+ * or poll_state_synchronize_rcu() to determine whether or not a full
+ * grace period has elapsed in the meantime.
  */
 unsigned long get_state_synchronize_rcu(void)
 {
@@ -3789,13 +3789,73 @@ unsigned long get_state_synchronize_rcu(void)
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
 /**
+ * start_poll_state_synchronize_rcu - Snapshot and start RCU grace period
+ *
+ * Returns a cookie that is used by a later call to cond_synchronize_rcu()
+ * or poll_state_synchronize_rcu() to determine whether or not a full
+ * grace period has elapsed in the meantime.  If the needed grace period
+ * is not already slated to start, notifies RCU core of the need for that
+ * grace period.
+ *
+ * Interrupts must be enabled for the case where it is necessary to awaken
+ * the grace-period kthread.
+ */
+unsigned long start_poll_synchronize_rcu(void)
+{
+	unsigned long flags;
+	unsigned long gp_seq = get_state_synchronize_rcu();
+	bool needwake;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+
+	lockdep_assert_irqs_enabled();
+	local_irq_save(flags);
+	rdp = this_cpu_ptr(&rcu_data);
+	rnp = rdp->mynode;
+	raw_spin_lock_rcu_node(rnp); // irqs already disabled.
+	needwake = rcu_start_this_gp(rnp, rdp, gp_seq);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	if (needwake)
+		rcu_gp_kthread_wake();
+	return gp_seq;
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
+
+/**
+ * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
+ *
+ * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
+ *
+ * If a full RCU grace period has elapsed since the earlier call from
+ * which oldstate was obtained, return @true, otherwise return @false.
+ * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
+ *
+ * Yes, this function does not take counter wrap into account.
+ * But counter wrap is harmless.  If the counter wraps, we have waited for
+ * more than 2 billion grace periods (and way more on a 64-bit system!).
+ * Those needing to keep oldstate values for very long time periods
+ * (many hours even on 32-bit systems) should check them occasionally
+ * and either refresh them or set a flag indicating that the grace period
+ * has completed.
+ */
+bool poll_state_synchronize_rcu(unsigned long oldstate)
+{
+	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
+		smp_mb(); /* Ensure GP ends before subsequent accesses. */
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
+
+/**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
  *
  * @oldstate: return value from earlier call to get_state_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call to
- * get_state_synchronize_rcu(), just return.  Otherwise, invoke
- * synchronize_rcu() to wait for a full grace period.
+ * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
+ * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
  *
  * Yes, this function does not take counter wrap into account.  But
  * counter wrap is harmless.  If the counter wraps, we have waited for
@@ -3804,7 +3864,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void cond_synchronize_rcu(unsigned long oldstate)
 {
-	if (!rcu_seq_done(&rcu_state.gp_seq, oldstate))
+	if (!poll_state_synchronize_rcu(oldstate))
 		synchronize_rcu();
 	else
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
-- 
2.9.5

