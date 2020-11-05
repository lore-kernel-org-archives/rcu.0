Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB3C388F7
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F36120759
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620138;
	bh=cwCXmKgp/mfMgVtuaXwya+QgwONDg9inMtv9VLEd/ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xMitAcDOUpQsVxkfE1Rzib3a218cW5fVwbXMvZadQ+5FWva2yr4mKZV1TBP4DKLP9
	 4P2PV2rtE6c2oYbdbURRnxGuoku5N1jLsZO6ZQOFA7vat4h+Qw39pPVUfaPKguIFhu
	 JktoIUQCkSh//IpFPsgw4jl//FaaSzA+XG2BaSu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgKEXr0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbgKEXrZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:25 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87367221FA;
        Thu,  5 Nov 2020 23:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620044;
        bh=cwCXmKgp/mfMgVtuaXwya+QgwONDg9inMtv9VLEd/ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiWkwcCKWuY7YCpbDn1EbF5S2k+RVWOSfuj2uCPjxqA6sE4GKE+jBstdEoZ7KJNoM
         YkjewLziscooQfBZlXBz8pRl87ufH0kYiEg9yYRc/D6cjujgSLLsPmeW7jAtMOY2Gv
         ygxtZ9HeBj2JgMqtMZVvdJImB1HS3celG+eLcq8E=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/28] rcuscale: Add RCU Tasks Trace
Date:   Thu,  5 Nov 2020 15:46:58 -0800
Message-Id: <20201105234719.23307-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the ability to test performance and scalability of RCU
Tasks Trace updaters.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c                              | 32 +++++++++++++++++++++-
 .../selftests/rcutorture/configs/rcuscale/CFcommon |  3 ++
 .../selftests/rcutorture/configs/rcuscale/TRACE01  | 15 ++++++++++
 .../rcutorture/configs/rcuscale/TRACE01.boot       |  1 +
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95..c42f240 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -38,6 +38,7 @@
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
+#include <linux/rcupdate_trace.h>
 
 #include "rcu.h"
 
@@ -294,6 +295,35 @@ static struct rcu_scale_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+/*
+ * Definitions for RCU-tasks-trace scalability testing.
+ */
+
+static int tasks_trace_scale_read_lock(void)
+{
+	rcu_read_lock_trace();
+	return 0;
+}
+
+static void tasks_trace_scale_read_unlock(int idx)
+{
+	rcu_read_unlock_trace();
+}
+
+static struct rcu_scale_ops tasks_tracing_ops = {
+	.ptype		= RCU_TASKS_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_trace_scale_read_lock,
+	.readunlock	= tasks_trace_scale_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
+	.async		= call_rcu_tasks_trace,
+	.gp_barrier	= rcu_barrier_tasks_trace,
+	.sync		= synchronize_rcu_tasks_trace,
+	.exp_sync	= synchronize_rcu_tasks_trace,
+	.name		= "tasks-tracing"
+};
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -754,7 +784,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops, &tasks_tracing_ops
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 87caa0e..90942bb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -1,2 +1,5 @@
 CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_TASKS_RCU_GENERIC=y
+CONFIG_TASKS_RCU=y
+CONFIG_TASKS_TRACE_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
new file mode 100644
index 0000000..e6baa2f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -0,0 +1,15 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
new file mode 100644
index 0000000..af0aff1
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
@@ -0,0 +1 @@
+rcuscale.scale_type=tasks-tracing
-- 
2.9.5

