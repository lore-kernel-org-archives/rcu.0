Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8197C43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC4222D04
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 01:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbhAFBSm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbhAFBSd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 20:18:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55C81230FB;
        Wed,  6 Jan 2021 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609895872;
        bh=ww/Zdig22m8u2xnm1Qhu/umiYDeAt6Ww+0ijypYNKug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBVWsNytN0FF6rHC/lUNdjAHZlOC77y+9lHvsMrarARu1wpL2smnFV8zunLQqncrW
         9kff/Y+JvYrQXj6cAtgmb2t0ZHOeq7vw9RK5aE4gCT0I6qSbB4jdZsm1hc84e7VbHb
         Fie7FblgG4V24RxRv7RI43LPYv/P5RpaErLT7iqfYjnVX7RXgig/UZiijx59R9GjhW
         oJNzTGOUJxvh2z8Ker9L2fJXvzaS6aymQCUExEwXXysZ0eG1jv7tIVlVRZfvkI8pIE
         RNkbp4NB8mIp0xIY3I0cQfHY8WEWPvM1IOraNbRxhw+Otix/qUKq1XIr+bCpO1x7N2
         EJbK+bbX6fnww==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH mm,percpu_ref,rcu 5/6] rcu: Make call_rcu() print mem_dump_obj() info for double-freed callback
Date:   Tue,  5 Jan 2021 17:17:49 -0800
Message-Id: <20210106011750.13709-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106011603.GA13180@paulmck-ThinkPad-P72>
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The debug-object double-free checks in __call_rcu() print out the
RCU callback function, which is usually sufficient to track down the
double free.  However, all uses of things like queue_rcu_work() will
have the same RCU callback function (rcu_work_rcufn() in this case),
so a diagnostic message for a double queue_rcu_work() needs more than
just the callback function.

This commit therefore calls mem_dump_obj() to dump out any additional
available information on the double-freed callback.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..84513c5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2941,6 +2941,7 @@ static void check_cb_ovld(struct rcu_data *rdp)
 static void
 __call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
 	struct rcu_data *rdp;
 	bool was_alldone;
@@ -2954,8 +2955,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		 * Use rcu:rcu_callback trace event to find the previous
 		 * time callback was passed to __call_rcu().
 		 */
-		WARN_ONCE(1, "__call_rcu(): Double-freed CB %p->%pS()!!!\n",
-			  head, head->func);
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
 		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
 	}
-- 
2.9.5

