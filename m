Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244CC433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA19722227
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbhAFRRx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbhAFRRx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:17:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E40823132;
        Wed,  6 Jan 2021 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953432;
        bh=aO51+nFL0aN+LRSsFz74vIhhXFFoO6tkeT1fWqEziII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obh9cob/rQlCTayzMYa+PH683N0jebdtI9lLO4JjmKoJY97B1vJjzHv6IRIjRvfly
         WxLyuFZWcijXMSqr44SZxoT1VMwzXcaKKFVwDMVV9IwzuQUnOEXRDIYSEVuhaou0IV
         idpFS9rr/0H9dgHe2X4YWhziz4uB2eDZbTpZ3bY/V7ZqK/lU4LBsXe31JdEy4wjf82
         wSnV8NivMHTMZx8KtUicck1g/4YsinbJMj7mwV9sgx/2dnd/DmBXe06Dcj9ArSv9g/
         CcGdoEdIMhkYz7fx/CjoZCT8t6IgTd1GilbDkDZDGY0YwAIhdRg9EZv8AJrsuNEIaV
         dR6Lodib+INYg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/17] refscale: Allow summarization of verbose output
Date:   Wed,  6 Jan 2021 09:16:56 -0800
Message-Id: <20210106171710.22239-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106171532.GA20769@paulmck-ThinkPad-P72>
References: <20210106171532.GA20769@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The refscale test prints enough per-kthread console output to provoke RCU
CPU stall warnings on large systems.  This commit therefore allows this
output to be summarized.  For example, the refscale.verbose_batched=32
boot parameter would causes only every 32nd line of output to be logged.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 kernel/rcu/refscale.c                           | 21 ++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..29ea816 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4557,6 +4557,12 @@
 	refscale.verbose= [KNL]
 			Enable additional printk() statements.
 
+	refscale.verbose_batched= [KNL]
+			Batch the additional printk() statements.  If zero
+			(the default) or negative, print everything.  Otherwise, 
+			print every Nth verbose statement, where N is the value
+			specified.
+
 	relax_domain_level=
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 23ff36a..3da246f 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -46,6 +46,16 @@
 #define VERBOSE_SCALEOUT(s, x...) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG s, scale_type, ## x); } while (0)
 
+static atomic_t verbose_batch_ctr;
+
+#define VERBOSE_SCALEOUT_BATCH(s, x...)							\
+do {											\
+	if (verbose &&									\
+	    (verbose_batched <= 0 ||							\
+	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched)))		\
+		pr_alert("%s" SCALE_FLAG s, scale_type, ## x);				\
+} while (0)
+
 #define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
 
@@ -57,6 +67,7 @@ module_param(scale_type, charp, 0444);
 MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
 
 // Wait until there are multiple CPUs before starting test.
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
@@ -368,14 +379,14 @@ ref_scale_reader(void *arg)
 	u64 start;
 	s64 duration;
 
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: task started", me);
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: task started", me);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_init);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 repeat:
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
 	// Wait for signal that this reader can start.
 	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
@@ -392,7 +403,7 @@ ref_scale_reader(void *arg)
 		while (atomic_read_acquire(&n_started))
 			cpu_relax();
 
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d started", me, exp_idx);
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: experiment %d started", me, exp_idx);
 
 
 	// To reduce noise, do an initial cache-warming invocation, check
@@ -421,8 +432,8 @@ ref_scale_reader(void *arg)
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
 
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d ended, (readers remaining=%d)",
-			me, exp_idx, atomic_read(&nreaders_exp));
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: experiment %d ended, (readers remaining=%d)",
+				me, exp_idx, atomic_read(&nreaders_exp));
 
 	if (!torture_must_stop())
 		goto repeat;
-- 
2.9.5

