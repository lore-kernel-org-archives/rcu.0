Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51FC4167B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 01:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C52B23B4B
	for <rcu@archiver.kernel.org>; Wed,  9 Dec 2020 01:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLIBNy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgLIBNr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Dec 2020 20:13:47 -0500
From:   paulmck@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 sl-b 5/5] percpu_ref: Dump mem_dump_obj() info upon reference-count underflow
Date:   Tue,  8 Dec 2020 17:13:03 -0800
Message-Id: <20201209011303.32737-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201209011124.GA31164@paulmck-ThinkPad-P72>
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Reference-count underflow for percpu_ref is detected in the RCU callback
percpu_ref_switch_to_atomic_rcu(), and the resulting warning does not
print anything allowing easy identification of which percpu_ref use
case is underflowing.  This is of course not normally a problem when
developing a new percpu_ref use case because it is most likely that
the problem resides in this new use case.  However, when deploying a
new kernel to a large set of servers, the underflow might well be a new
corner case in any of the old percpu_ref use cases.

This commit therefore calls mem_dump_obj() to dump out any additional
available information on the underflowing percpu_ref instance.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/percpu-refcount.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e59eda0..a1071cd 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/percpu-refcount.h>
 
 /*
@@ -168,6 +169,7 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 			struct percpu_ref_data, rcu);
 	struct percpu_ref *ref = data->ref;
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
+	static atomic_t underflows;
 	unsigned long count = 0;
 	int cpu;
 
@@ -191,9 +193,13 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	 */
 	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &data->count);
 
-	WARN_ONCE(atomic_long_read(&data->count) <= 0,
-		  "percpu ref (%ps) <= 0 (%ld) after switching to atomic",
-		  data->release, atomic_long_read(&data->count));
+	if (WARN_ONCE(atomic_long_read(&data->count) <= 0,
+		      "percpu ref (%ps) <= 0 (%ld) after switching to atomic",
+		      data->release, atomic_long_read(&data->count)) &&
+	    atomic_inc_return(&underflows) < 4) {
+		pr_err("%s(): percpu_ref underflow", __func__);
+		mem_dump_obj(data);
+	}
 
 	/* @ref is viewed as dead on all CPUs, send out switch confirmation */
 	percpu_ref_call_confirm_rcu(rcu);
-- 
2.9.5

