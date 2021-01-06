Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA1C433DB
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5322022CB9
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFB07 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbhAFB07 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:26:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBB7B22D6F;
        Wed,  6 Jan 2021 01:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609896379;
        bh=efvVs7NjR82yjo8j+QlQmTT06UvJ/+lZfaz3AgaMiAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOd3PN9MEtvcyCJnyftw5TRWPBn8UBLE3XansWG2OtxGrM041SzY0TplWtNerffdY
         VWmQHl/9VL/hpbYKl1fUPxLuv2uTShSLJrxYGPd987PobjNE4MNA0k3PcuD5ndLL+A
         1R6zoQFUyHzKCbGVMOxJt/G1CvcYaDInc2uZWot0/vVvsC9RtDuBOc3fMO9ssqK9dC
         tqQY8k6y2UkcM+OPRKoIemnbXfPY+iJQvK8GusySZqftPqn3nCV5iEN4QagxpSJDQB
         eMa8ZeDby0p5I+2ZyV3OcA2LXhng/hPg9kZp8vawjWLYwfJWyjrQPT/ZRid/Lu8qmG
         Jc5+Dr9JnLKTA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/6] rcu/segcblist: Add additional comments to explain smp_mb()
Date:   Tue,  5 Jan 2021 17:26:13 -0800
Message-Id: <20210106012617.14122-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106012541.GA13972@paulmck-ThinkPad-P72>
References: <20210106012541.GA13972@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

One counter-intuitive property of RCU is the fact that full memory
barriers are needed both before and after updates to the full
(non-segmented) length.  This patch therefore helps to assist the
reader's intuition by adding appropriate comments.

[ paulmck:  Wordsmithing. ]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 68 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index bb246d8..0f55864 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,17 +94,77 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * field to disagree with the actual number of callbacks on the structure.
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
+ *
+ * So why on earth is a memory barrier required both before and after
+ * the update to the ->len field???
+ *
+ * The reason is that rcu_barrier() locklessly samples each CPU's ->len
+ * field, and if a given CPU's field is zero, avoids IPIing that CPU.
+ * This can of course race with both queuing and invoking of callbacks.
+ * Failng to correctly handle either of these races could result in
+ * rcu_barrier() failing to IPI a CPU that actually had callbacks queued
+ * which rcu_barrier() was obligated to wait on.  And if rcu_barrier()
+ * failed to wait on such a callback, unloading certain kernel modules
+ * would result in calls to functions whose code was no longer present in
+ * the kernel, for but one example.
+ *
+ * Therefore, ->len transitions from 1->0 and 0->1 have to be carefully
+ * ordered with respect with both list modifications and the rcu_barrier().
+ *
+ * The queuing case is CASE 1 and the invoking case is CASE 2.
+ *
+ * CASE 1: Suppose that CPU 0 has no callbacks queued, but invokes
+ * call_rcu() just as CPU 1 invokes rcu_barrier().  CPU 0's ->len field
+ * will transition from 0->1, which is one of the transitions that must
+ * be handled carefully.  Without the full memory barriers after the ->len
+ * update and at the beginning of rcu_barrier(), the following could happen:
+ *
+ * CPU 0				CPU 1
+ *
+ * call_rcu().
+ *                      		rcu_barrier() sees ->len as 0.
+ * set ->len = 1.
+ *                      		rcu_barrier() does nothing.
+ *					module is unloaded.
+ * callback invokes unloaded function!
+ *
+ * With the full barriers, any case where rcu_barrier() sees ->len as 0 will
+ * have unambiguously preceded the return from the racing call_rcu(), which
+ * means that this call_rcu() invocation is OK to not wait on.  After all,
+ * you are supposed to make sure that any problematic call_rcu() invocations
+ * happen before the rcu_barrier().
+ *
+ *
+ * CASE 2: Suppose that CPU 0 is invoking its last callback just as
+ * CPU 1 invokes rcu_barrier().  CPU 0's ->len field will transition from
+ * 1->0, which is one of the transitions that must be handled carefully.
+ * Without the full memory barriers before the ->len update and at the
+ * end of rcu_barrier(), the following could happen:
+ * 
+ * CPU 0				CPU 1
+ *
+ * start invoking last callback
+ * set ->len = 0 (reordered)
+ *                      		rcu_barrier() sees ->len as 0
+ *                      		rcu_barrier() does nothing.
+ *					module is unloaded
+ * callback executing after unloaded!
+ *
+ * With the full barriers, any case where rcu_barrier() sees ->len as 0
+ * will be fully ordered after the completion of the callback function,
+ * so that the module unloading operation is completely safe.
+ * 
  */
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
-	smp_mb__before_atomic(); /* Up to the caller! */
+	smp_mb__before_atomic(); // Read header comment above.
 	atomic_long_add(v, &rsclp->len);
-	smp_mb__after_atomic(); /* Up to the caller! */
+	smp_mb__after_atomic();  // Read header comment above.
 #else
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); // Read header comment above.
 	WRITE_ONCE(rsclp->len, rsclp->len + v);
-	smp_mb(); /* Up to the caller! */
+	smp_mb(); // Read header comment above.
 #endif
 }
 
-- 
2.9.5

