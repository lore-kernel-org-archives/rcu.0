Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DADC43461
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C113320866
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897013;
	bh=jAVAU5YWnz0TRbKu8MV8HA7oYQnPc+WZMtj2L/g5Oio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONWPgTZgDX69+Rjr1BgXPQSfVyK4g94Y6PF9EOTq8wIiOfDFYOmxwub1LvXAPSWrk
	 uNLThARv0ZumIu/yOuRYiSqtII/YKROoYmLOF0EanrB9H4hqRp70t5xFbgmrFplaqb
	 Tg9pmgsOIBf9hydSmCBgLH4V/5dhF3HSnXpy/Wmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgHaSC6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbgHaSB0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128C72166E;
        Mon, 31 Aug 2020 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896885;
        bh=jAVAU5YWnz0TRbKu8MV8HA7oYQnPc+WZMtj2L/g5Oio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjK1xf/Qc5qvbao1bo8YuRTV4dyIHy0gh8V8VkG/kNNXXXsstBH65ib/MbTZWYK3l
         Sbb0QGLEbC2iyzuimpa9uVxdQ9ByMbeENC2hEKGCqy4rRsMX2XZUPr90hxnAXOvIB7
         pJWGf/XAJz8zar88MROohVlX3+7/Mr48y4titA5U=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/24] rculist: Introduce list/hlist_for_each_entry_srcu() macros
Date:   Mon, 31 Aug 2020 11:01:08 -0700
Message-Id: <20200831180116.32690-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

list/hlist_for_each_entry_rcu() provides an optional cond argument
to specify the lock held in the updater side.
However for SRCU read side, not providing the cond argument results
into false positive as whether srcu_read_lock is held or not is not
checked implicitly. Therefore, on read side the lockdep expression
srcu_read_lock_held(srcu struct) can solve this issue.

However, the function still fails to check the cases where srcu
protected list is traversed with rcu_read_lock() instead of
srcu_read_lock(). Therefore, to remove the false negative,
this patch introduces two new list traversal primitives :
list_for_each_entry_srcu() and hlist_for_each_entry_srcu().

Both of the functions have non-optional cond argument
as it is required for both read and update side, and simply checks
if the cond is true. For regular read side the lockdep expression
srcu_read_lock_head() can be passed as the cond argument to
list/hlist_for_each_entry_srcu().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Suraj Upadhyay <usuraj35@gmail.com>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
[ paulmck: Add "true" per kbuild test robot feedback. ]
Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 7a6fc99..f8633d3 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -63,9 +63,17 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
 	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
 			 "RCU-list traversed in non-reader section!");	\
 	})
+
+#define __list_check_srcu(cond)					 \
+	({								 \
+	RCU_LOCKDEP_WARN(!(cond),					 \
+		"RCU-list traversed without holding the required lock!");\
+	})
 #else
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
+
+#define __list_check_srcu(cond) ({ })
 #endif
 
 /*
@@ -386,6 +394,25 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
 
 /**
+ * list_for_each_entry_srcu	-	iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ * @cond:	lockdep expression for the lock required to traverse the list.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as list_add_rcu()
+ * as long as the traversal is guarded by srcu_read_lock().
+ * The lockdep expression srcu_read_lock_held() can be passed as the
+ * cond argument from read side.
+ */
+#define list_for_each_entry_srcu(pos, head, member, cond)		\
+	for (__list_check_srcu(cond),					\
+	     pos = list_entry_rcu((head)->next, typeof(*pos), member);	\
+		&pos->member != (head);					\
+		pos = list_entry_rcu(pos->member.next, typeof(*pos), member))
+
+/**
  * list_entry_lockless - get the struct for this entry
  * @ptr:        the &struct list_head pointer.
  * @type:       the type of the struct this is embedded in.
@@ -684,6 +711,27 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
 			&(pos)->member)), typeof(*(pos)), member))
 
 /**
+ * hlist_for_each_entry_srcu - iterate over rcu list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ * @cond:	lockdep expression for the lock required to traverse the list.
+ *
+ * This list-traversal primitive may safely run concurrently with
+ * the _rcu list-mutation primitives such as hlist_add_head_rcu()
+ * as long as the traversal is guarded by srcu_read_lock().
+ * The lockdep expression srcu_read_lock_held() can be passed as the
+ * cond argument from read side.
+ */
+#define hlist_for_each_entry_srcu(pos, head, member, cond)		\
+	for (__list_check_srcu(cond),					\
+	     pos = hlist_entry_safe(rcu_dereference_raw(hlist_first_rcu(head)),\
+			typeof(*(pos)), member);			\
+		pos;							\
+		pos = hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(\
+			&(pos)->member)), typeof(*(pos)), member))
+
+/**
  * hlist_for_each_entry_rcu_notrace - iterate over rcu list of given type (for tracing)
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
-- 
2.9.5

