Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C174C43600
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A3D61260
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhEKWyW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A22A61956;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=/BBfqj9mIzxBt9L33xPA26hQ79odhjdQso35kGo1gjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrlvgEEUBzfI3W7CPFzTUZ1x6n92zt5TqM2y4OKcBcpegWbts7giIV3RkZnGP86/o
         yIQZT4BXZEjlf9Ho444x2TeCRhFw65R7MRoKcrRhMQqJlI0EjFRI0O3egLaHWbhKtj
         b3Dy1bBYH+y+mlAuLVGKr6B9LDFv+15k71P4YSEujGxkxqk/FKeYpVX8w1lfoV79KU
         GH6k7zReU1HJWjCHwpH3HRokjuwJmhgZMJSs/m8cN9i+2FX+VN7JUveKfxk9SgIms3
         TCST/e04RdBk/kOaA4dgOm8m1EJTbws+gj4gEM9UDVk/rtnewPutGiEuzhS9C/EPGF
         gP/Eqy5NuA4vQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A60EC5C0E59; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH tip/core/rcu 17/19] rcu: Improve comments describing RCU read-side critical sections
Date:   Tue, 11 May 2021 15:53:02 -0700
Message-Id: <20210511225304.2893154-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are a number of places that call out the fact that preempt-disable
regions of code now act as RCU read-side critical sections, where
preempt-disable regions of code include irq-disable regions of code,
bh-disable regions of code, hardirq handlers, and NMI handlers.  However,
someone relying solely on (for example) the call_rcu() header comment
might well have no idea that preempt-disable regions of code have RCU
semantics.

This commit therefore updates the header comments for
call_rcu(), synchronize_rcu(), rcu_dereference_bh_check(), and
rcu_dereference_sched_check() to call out these new(ish) forms of RCU
readers.

Reported-by: Michel Lespinasse <michel@lespinasse.org>
[ paulmck: Apply Matthew Wilcox and Michel Lespinasse feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 35 ++++++++++++++++++++++++++++-------
 kernel/rcu/tree.c        | 24 ++++++++++++++----------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index a10480f2b4ef..45e58f14b1ce 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -532,7 +532,12 @@ do {									      \
  * @p: The pointer to read, prior to dereferencing
  * @c: The conditions under which the dereference will take place
  *
- * This is the RCU-bh counterpart to rcu_dereference_check().
+ * This is the RCU-bh counterpart to rcu_dereference_check().  However,
+ * please note that starting in v5.0 kernels, vanilla RCU grace periods
+ * wait for local_bh_disable() regions of code in addition to regions of
+ * code demarked by rcu_read_lock() and rcu_read_unlock().  This means
+ * that synchronize_rcu(), call_rcu, and friends all take not only
+ * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
@@ -543,6 +548,11 @@ do {									      \
  * @c: The conditions under which the dereference will take place
  *
  * This is the RCU-sched counterpart to rcu_dereference_check().
+ * However, please note that starting in v5.0 kernels, vanilla RCU grace
+ * periods wait for preempt_disable() regions of code in addition to
+ * regions of code demarked by rcu_read_lock() and rcu_read_unlock().
+ * This means that synchronize_rcu(), call_rcu, and friends all take not
+ * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
@@ -634,6 +644,12 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
+ * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
+ * wait for regions of code with preemption disabled, including regions of
+ * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
+ * define synchronize_sched(), only code enclosed within rcu_read_lock()
+ * and rcu_read_unlock() are guaranteed to be waited for.
+ *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
  * is via the following sequence of events: (1) CPU 0 enters an RCU
@@ -728,9 +744,11 @@ static inline void rcu_read_unlock(void)
 /**
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
- * This is equivalent of rcu_read_lock(), but also disables softirqs.
- * Note that anything else that disables softirqs can also serve as
- * an RCU read-side critical section.
+ * This is equivalent to rcu_read_lock(), but also disables softirqs.
+ * Note that anything else that disables softirqs can also serve as an RCU
+ * read-side critical section.  However, please note that this equivalence
+ * applies only to v5.0 and later.  Before v5.0, rcu_read_lock() and
+ * rcu_read_lock_bh() were unrelated.
  *
  * Note that rcu_read_lock_bh() and the matching rcu_read_unlock_bh()
  * must occur in the same context, for example, it is illegal to invoke
@@ -763,9 +781,12 @@ static inline void rcu_read_unlock_bh(void)
 /**
  * rcu_read_lock_sched() - mark the beginning of a RCU-sched critical section
  *
- * This is equivalent of rcu_read_lock(), but disables preemption.
- * Read-side critical sections can also be introduced by anything else
- * that disables preemption, including local_irq_disable() and friends.
+ * This is equivalent to rcu_read_lock(), but also disables preemption.
+ * Read-side critical sections can also be introduced by anything else that
+ * disables preemption, including local_irq_disable() and friends.  However,
+ * please note that the equivalence to rcu_read_lock() applies only to
+ * v5.0 and later.  Before v5.0, rcu_read_lock() and rcu_read_lock_sched()
+ * were unrelated.
  *
  * Note that rcu_read_lock_sched() and the matching rcu_read_unlock_sched()
  * must occur in the same context, for example, it is illegal to invoke
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2437960a2795..4b00e4fbfa10 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3059,12 +3059,14 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
  * period elapses, in other words after all pre-existing RCU read-side
  * critical sections have completed.  However, the callback function
  * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(), and
- * may be nested.  In addition, regions of code across which interrupts,
- * preemption, or softirqs have been disabled also serve as RCU read-side
- * critical sections.  This includes hardware interrupt handlers, softirq
- * handlers, and NMI handlers.
+ * that started after call_rcu() was invoked.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
  *
  * Note that all CPUs must agree that the grace period extended beyond
  * all pre-existing RCU read-side critical section.  On systems with more
@@ -3730,10 +3732,12 @@ static int rcu_blocking_is_gp(void)
  * read-side critical sections have completed.  Note, however, that
  * upon return from synchronize_rcu(), the caller might well be executing
  * concurrently with new RCU read-side critical sections that began while
- * synchronize_rcu() was waiting.  RCU read-side critical sections are
- * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
- * In addition, regions of code across which interrupts, preemption, or
- * softirqs have been disabled also serve as RCU read-side critical
+ * synchronize_rcu() was waiting.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
  * sections.  This includes hardware interrupt handlers, softirq handlers,
  * and NMI handlers.
  *
-- 
2.31.1.189.g2e36527f23

