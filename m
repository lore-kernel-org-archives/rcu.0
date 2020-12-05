Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E094C2BB3F
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DF922D72
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgLEAl6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgLEAll (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:41 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH sl-b 3/6] rcu: Make call_rcu() print allocation address of double-freed callback
Date:   Fri,  4 Dec 2020 16:40:54 -0800
Message-Id: <20201205004057.32199-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201205004022.GA31166@paulmck-ThinkPad-P72>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
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

This commit therefore prints the last allocation address of the
double-freed callback when the callback is slab-allocated and sufficient
debugging is enabled.  It uses the shiny new kmem_last_alloc() and
kmem_last_alloc_errstring() functions for this purpose.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b6c9c49..788a072 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2957,6 +2957,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
 static void
 __call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	void *allocaddr;
+	const char *allocerr;
 	unsigned long flags;
 	struct rcu_data *rdp;
 	bool was_alldone;
@@ -2970,8 +2972,14 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		 * Use rcu:rcu_callback trace event to find the previous
 		 * time callback was passed to __call_rcu().
 		 */
-		WARN_ONCE(1, "__call_rcu(): Double-freed CB %p->%pS()!!!\n",
-			  head, head->func);
+		allocaddr = kmem_last_alloc(head);
+		allocerr = kmem_last_alloc_errstring(allocaddr);
+		if (allocerr)
+			WARN_ONCE(1, "__call_rcu(): Double-freed CB %p->%pS()!!! (%s)\n",
+				  head, head->func, allocerr);
+		else
+			WARN_ONCE(1, "__call_rcu(): Double-freed CB %p->%pS()!!! (Allocated at %pS)\n",
+				  head, head->func, allocaddr);
 		WRITE_ONCE(head->func, rcu_leak_callback);
 		return;
 	}
-- 
2.9.5

