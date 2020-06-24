Return-Path: <SRS0=iUCR=AF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2530C433E0
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915B320823
	for <rcu@archiver.kernel.org>; Wed, 24 Jun 2020 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593029575;
	bh=qFTDYEvpOJ3RBMm1xfDoDflHzs1ac1r8vdJ2u1YMMDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DilCjBh6TYSXiWdBVM14ntQWD0ar+bDALvGUGLiWNX4z422+1yeyrPKBOKr3WmifI
	 Rqs6TLlXUDTA9VgvXr9KQywG+qk88tAK8Fd/qn6ufYlUlY8rjuCX0DKb08yAQ6KA5b
	 RSjrwyn6mEMGIlIlJ/eu1iWsCprkEg8xWhs7CgNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406447AbgFXUMz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406396AbgFXUMc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Jun 2020 16:12:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3855C2184D;
        Wed, 24 Jun 2020 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593029551;
        bh=qFTDYEvpOJ3RBMm1xfDoDflHzs1ac1r8vdJ2u1YMMDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV+frg8UIFx3EB9Gy8xujAX6JA0Z++nFYwHZNI3HD5qyXSJz2DUZFlm++CNN2w65s
         0Me/b/D0WpmjZc0Qkbwv2XlkeHbf4Vzcc26el8YLBerGpqWEWTUVaS8tHEZpi54zoE
         S9hsXin/LUc6B9vfygME6fRj1mHG50fF2ktvvOz0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/17] rcu: Support reclaim for head-less object
Date:   Wed, 24 Jun 2020 13:12:24 -0700
Message-Id: <20200624201226.21197-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200624201200.GA28901@paulmck-ThinkPad-P72>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Update the kvfree_call_rcu() function with head-less support.
This allows RCU to reclaim objects without an embedded rcu_head.

tree-RCU:
We introduce two chains of arrays to store SLAB-backed and vmalloc
pointers, each.  Storage in either of these arrays does not require
embedding an rcu_head within the object.

Maintaining the arrays may become impossible due to high memory
pressure. For such cases there is an emergency path. Objects with
rcu_head inside are just queued on a backup rcu_head list. Later on
that list is drained. As for the head-less variant, as the current
context can sleep, the following emergency measures are applied:
   a) Synchronously wait until a grace period has elapsed.
   b) Call kvfree().

tiny-RCU:
For double argument calls, there are no new changes in behavior. For
single argument call, kvfree() is directly inlined on the current
stack after a synchronize_rcu() call. Note that for tiny-RCU, any
call to synchronize_rcu() is actually a quiescent state, therefore
it does nothing.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 18 +++++++++++++++++-
 kernel/rcu/tree.c       | 45 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index fb2eb39..5cc9637 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,9 +34,25 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
+/*
+ * Add one more declaration of kvfree() here. It is
+ * not so straight forward to just include <linux/mm.h>
+ * where it is defined due to getting many compile
+ * errors caused by that include.
+ */
+extern void kvfree(const void *addr);
+
 static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	call_rcu(head, func);
+	if (head) {
+		call_rcu(head, func);
+		return;
+	}
+
+	// kvfree_rcu(one_arg) call.
+	might_sleep();
+	synchronize_rcu();
+	kvfree((void *) func);
 }
 
 void rcu_qs(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 07fb5a36..38fb3ce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3296,6 +3296,13 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			if (IS_ENABLED(CONFIG_PREEMPT_RT))
 				return false;
 
+			/*
+			 * NOTE: For one argument of kvfree_rcu() we can
+			 * drop the lock and get the page in sleepable
+			 * context. That would allow to maintain an array
+			 * for the CONFIG_PREEMPT_RT as well if no cached
+			 * pages are available.
+			 */
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
@@ -3335,16 +3342,33 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	bool success;
 	void *ptr;
 
+	if (head) {
+		ptr = (void *) head - (unsigned long) func;
+	} else {
+		/*
+		 * Please note there is a limitation for the head-less
+		 * variant, that is why there is a clear rule for such
+		 * objects: it can be used from might_sleep() context
+		 * only. For other places please embed an rcu_head to
+		 * your data.
+		 */
+		might_sleep();
+		ptr = (unsigned long *) func;
+	}
+
 	krcp = krc_this_cpu_lock(&flags);
-	ptr = (void *)head - (unsigned long)func;
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
+
+		// Mark as success and leave.
+		success = true;
 		goto unlock_return;
 	}
 
@@ -3352,10 +3376,16 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr))) {
+	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	if (!success) {
+		if (head == NULL)
+			// Inline if kvfree_rcu(one_arg) call.
+			goto unlock_return;
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
+		success = true;
 	}
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
@@ -3369,6 +3399,17 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 unlock_return:
 	krc_this_cpu_unlock(krcp, flags);
+
+	/*
+	 * Inline kvfree() after synchronize_rcu(). We can do
+	 * it from might_sleep() context only, so the current
+	 * CPU can pass the QS state.
+	 */
+	if (!success) {
+		debug_rcu_head_unqueue((struct rcu_head *) ptr);
+		synchronize_rcu();
+		kvfree(ptr);
+	}
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-- 
2.9.5

