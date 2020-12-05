Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ECC4361B
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1463222D71
	for <rcu@archiver.kernel.org>; Sat,  5 Dec 2020 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbgLEAlo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgLEAln (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:43 -0500
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
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH sl-b 6/6] percpu_ref: Print stack trace upon reference-count underflow
Date:   Fri,  4 Dec 2020 16:40:57 -0800
Message-Id: <20201205004057.32199-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201205004022.GA31166@paulmck-ThinkPad-P72>
References: <20201205004022.GA31166@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In some cases, the allocator return address is in a common function, so
that more information is desired.  For example, percpu_ref reference-count
underflow happens in an RCU callback function having access only
to a block of memory that is always allocated in percpu_ref_init().
This information is unhelpful.

This commit therefore causes the percpu_ref_switch_to_atomic_rcu()
function to use the new kmem_last_alloc_stack() function to collect
and print a stack trace upon reference-count underflow.  This requires
the kernel use the slub allocator and be built with CONFIG_STACKTRACE=y.
As always, slub debugging must be enabled one way or another, for example,
by booting with the "slub_debug=U" kernel boot parameter.

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/percpu-refcount.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 8c7b21a0..ebdfa47 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -169,8 +169,6 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	struct percpu_ref *ref = data->ref;
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
 	unsigned long count = 0;
-	void *allocaddr;
-	const char *allocerr;
 	int cpu;
 
 	for_each_possible_cpu(cpu)
@@ -194,14 +192,26 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &data->count);
 
 	if (atomic_long_read(&data->count) <= 0) {
-		allocaddr = kmem_last_alloc(data);
+		void *allocaddr;
+		const char *allocerr;
+		void *allocstack[8];
+		int i;
+
+		allocaddr = kmem_last_alloc_stack(data, allocstack, ARRAY_SIZE(allocstack));
 		allocerr = kmem_last_alloc_errstring(allocaddr);
-		if (allocerr)
+		if (allocerr) {
 			WARN_ONCE(1, "percpu ref (%ps) <= 0 (%ld) after switching to atomic (%s)",
 				  data->release, atomic_long_read(&data->count), allocerr);
-		else
-			WARN_ONCE(1, "percpu ref (%ps) <= 0 (%ld) after switching to atomic (allocated at %pS)",
-				  data->release, atomic_long_read(&data->count), allocaddr);
+		} else {
+			pr_err("percpu ref (%ps) <= 0 (%ld) after switching to atomic (allocated at %pS)\n",
+			       data->release, atomic_long_read(&data->count), allocaddr);
+			for (i = 0; i < ARRAY_SIZE(allocstack); i++) {
+				if (!allocstack[i])
+					break;
+				pr_err("\t%pS\n", allocstack[i]);
+			}
+			WARN_ON_ONCE(1);
+		}
 	}
 
 	/* @ref is viewed as dead on all CPUs, send out switch confirmation */
-- 
2.9.5

