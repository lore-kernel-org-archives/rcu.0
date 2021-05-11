Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AC6C43462
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E772961260
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhEKWyU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CF8A6194F;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=KgziwQ3KEzjZpdc2RZwuwHdOl/+SEw4HMLIaX5nV6Pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNj5WQ0dtF4BMhn5pfRNG2M85U9NRSB5Z23NM3nIbtPAQpEPSuQNmTpMnWiYXN8TZ
         GZMLJSOmS+OLh/jOBM31kthMU6mqGPe8TwoylPaL4S2CI79cwIq0jF0qnfwZMwbuf2
         lpQCpCh1WF8bVw6nFBMlHW7BL5vIrl/I0WNL17Cq/pf06F50O6zPM+/eGcTHSSvDhv
         aKG1Q4E6PFoZnqRGyw1qZhJ3ER5LWFqQpcvP0yT9p4fG0dAhJRRWPI9o6JLCzGi/nF
         UZXYcPSeSFFPyOqq2QLzK44NJwTV0qehHfborYcgtAjbk/mv5ecUn2nAm7PlV8lVya
         sr61f+BYDjBfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A027A5C0E09; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 14/19] rcu: Point to documentation of ordering guarantees
Date:   Tue, 11 May 2021 15:52:59 -0700
Message-Id: <20210511225304.2893154-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add comments to synchronize_rcu() and friends that point to
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c |  3 +++
 kernel/rcu/tree.c     | 20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b34ad3..f8340c3b1c00 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1000,6 +1000,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  * synchronize_srcu(), srcu_read_lock(), and srcu_read_unlock() are
  * passed the same srcu_struct structure.
  *
+ * Implementation of these memory-ordering guarantees is similar to
+ * that of synchronize_rcu().
+ *
  * If SRCU is likely idle, expedite the first request.  This semantic
  * was provided by Classic SRCU, and is relied upon by its users, so TREE
  * SRCU must also provide it.  Note that detecting idleness is heuristic
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6eb64e44bdcd..2437960a2795 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3084,6 +3084,9 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
  * between the call to call_rcu() and the invocation of "func()" -- even
  * if CPU A and CPU B are the same CPU (but again only if the system has
  * more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -3751,6 +3754,9 @@ static int rcu_blocking_is_gp(void)
  * to have executed a full memory barrier during the execution of
  * synchronize_rcu() -- even if CPU A and CPU B are the same CPU (but
  * again only if the system has more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
  */
 void synchronize_rcu(void)
 {
@@ -3821,7 +3827,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
 /**
  * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
  *
- * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
+ * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call from
  * which oldstate was obtained, return @true, otherwise return @false.
@@ -3837,6 +3843,11 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  * (many hours even on 32-bit systems) should check them occasionally
  * and either refresh them or set a flag indicating that the grace period
  * has completed.
+ *
+ * This function provides the same memory-ordering guarantees that
+ * would be provided by a synchronize_rcu() that was invoked at the call
+ * to the function that provided @oldstate, and that returned at the end
+ * of this function.
  */
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
@@ -3851,7 +3862,7 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 /**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
  *
- * @oldstate: return value from earlier call to get_state_synchronize_rcu()
+ * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call to
  * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
@@ -3861,6 +3872,11 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
  * counter wrap is harmless.  If the counter wraps, we have waited for
  * more than 2 billion grace periods (and way more on a 64-bit system!),
  * so waiting for one additional grace period should be just fine.
+ *
+ * This function provides the same memory-ordering guarantees that
+ * would be provided by a synchronize_rcu() that was invoked at the call
+ * to the function that provided @oldstate, and that returned at the end
+ * of this function.
  */
 void cond_synchronize_rcu(unsigned long oldstate)
 {
-- 
2.31.1.189.g2e36527f23

