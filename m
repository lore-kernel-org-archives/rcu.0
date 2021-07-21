Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B694DC63799
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928AE61244
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbhGUTk6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237548AbhGUTkx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A691A61355;
        Wed, 21 Jul 2021 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898889;
        bh=wTmbqBY9AqPvVPQt3asLMeVulJpVoLicw5TeHOv8ij8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBLKLMsLTHOEmPJeBMobuXM0/6i2rpN3SW3IX7B8C8b4OsdvSMmR9uVJbVfE/+JzH
         EWDlrwUTWhnAVr2p8NVxarsssmiJ8Y7a7LeylsgAPZvzxHdFlBk9Hp6uN22iFQYQWj
         NkJ9Erj9D+/+eLyznmWeHxxl8sa8w7hOUWh/bEEYKEtKhiWlwiucRk0sCTvz6ddSSb
         tXoTi36UtD75miFtkFMDqq0qAmjISgiE/8pOR5g8adXcSKcK4t2vioOUFy3sTtO4Eb
         TkD4xgSPJA6rCyuKl/42fizJe9SmqlCKrPEG8wx1y5ecMlEKhlCdC5kD3ISCYV2hq8
         4L+ur6ZYmAjKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D87B5C0017; Wed, 21 Jul 2021 13:21:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/18] rculist: Unify documentation about missing list_empty_rcu()
Date:   Wed, 21 Jul 2021 13:21:14 -0700
Message-Id: <20210721202127.2129660-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

We have two separate sections that talk about why list_empty_rcu()
is not needed, so this commit consolidates them.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
[ paulmck: The usual wordsmithing. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index f8633d37e3581..d29740be4833e 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -10,15 +10,6 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 
-/*
- * Why is there no list_empty_rcu()?  Because list_empty() serves this
- * purpose.  The list_empty() function fetches the RCU-protected pointer
- * and compares it to the address of the list head, but neither dereferences
- * this pointer itself nor provides this pointer to the caller.  Therefore,
- * it is not necessary to use rcu_dereference(), so that list_empty() can
- * be used anywhere you would want to use a list_empty_rcu().
- */
-
 /*
  * INIT_LIST_HEAD_RCU - Initialize a list_head visible to RCU readers
  * @list: list to be initialized
@@ -318,21 +309,29 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 /*
  * Where are list_empty_rcu() and list_first_entry_rcu()?
  *
- * Implementing those functions following their counterparts list_empty() and
- * list_first_entry() is not advisable because they lead to subtle race
- * conditions as the following snippet shows:
+ * They do not exist because they would lead to subtle race conditions:
  *
  * if (!list_empty_rcu(mylist)) {
  *	struct foo *bar = list_first_entry_rcu(mylist, struct foo, list_member);
  *	do_something(bar);
  * }
  *
- * The list may not be empty when list_empty_rcu checks it, but it may be when
- * list_first_entry_rcu rereads the ->next pointer.
- *
- * Rereading the ->next pointer is not a problem for list_empty() and
- * list_first_entry() because they would be protected by a lock that blocks
- * writers.
+ * The list might be non-empty when list_empty_rcu() checks it, but it
+ * might have become empty by the time that list_first_entry_rcu() rereads
+ * the ->next pointer, which would result in a SEGV.
+ *
+ * When not using RCU, it is OK for list_first_entry() to re-read that
+ * pointer because both functions should be protected by some lock that
+ * blocks writers.
+ *
+ * When using RCU, list_empty() uses READ_ONCE() to fetch the
+ * RCU-protected ->next pointer and then compares it to the address of the
+ * list head.  However, it neither dereferences this pointer nor provides
+ * this pointer to its caller.  Thus, READ_ONCE() suffices (that is,
+ * rcu_dereference() is not needed), which means that list_empty() can be
+ * used anywhere you would want to use list_empty_rcu().  Just don't
+ * expect anything useful to happen if you do a subsequent lockless
+ * call to list_first_entry_rcu()!!!
  *
  * See list_first_or_null_rcu for an alternative.
  */
-- 
2.31.1.189.g2e36527f23

