Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43EFC433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C646B20842
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872261;
	bh=A0kI0wgoQ5BHwgm1QZZGGbhuj1grYtYeE5ffgxbMsBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LTOsH2BoCtQAvC5vVmQjwfHFp6rCU0YBfRrlub4NqpRlbgr4WgP5fzyEzsDlwdTJg
	 Xq3NdAGXKjJXQyxsF18c/9EWJllbDSBlNudOJH9Lr7ZF1xL8X3Cc/jJXo4qhGuDAIa
	 jsXJE+B33nhRuc8Tv5fkuKSPYDq/Mge5UlKvyKaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgFWAap (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731720AbgFWAaV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87DB208C9;
        Tue, 23 Jun 2020 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872221;
        bh=A0kI0wgoQ5BHwgm1QZZGGbhuj1grYtYeE5ffgxbMsBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1fpf9hiqfN08S5A50Hpz51JFfRFT9lR2NVGpa6vT24Fq37ADcG5c0euycCN39phD
         rWgIR0mr51IZHBwFA+2b9pbiEYb5JS00zA16javDfGhqAfkDzcbsQG6vtw/s5DTW92
         mjL7c7c/O1dXUucSjUL6fh89bpfqcutFmGRx3WAw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 28/30] refperf: Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST
Date:   Mon, 22 Jun 2020 17:30:11 -0700
Message-Id: <20200623003013.26252-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The old Kconfig option name is all too easy to conflate with the
unrelated "perf" feature, so this commit renames RCU_REF_PERF_TEST to
RCU_REF_SCALE_TEST.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                                    | 4 ++--
 kernel/rcu/Makefile                                         | 2 +-
 kernel/rcu/refperf.c                                        | 6 +++---
 tools/testing/selftests/rcutorture/configs/refperf/CFcommon | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 858765b..3cf6132 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -61,8 +61,8 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
-config RCU_REF_PERF_TEST
-	tristate "Performance tests for read-side synchronization (RCU and others)"
+config RCU_REF_SCALE_TEST
+	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index ba7d826..45d562d 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
-obj-$(CONFIG_RCU_REF_PERF_TEST) += refperf.o
+obj-$(CONFIG_RCU_REF_SCALE_TEST) += refperf.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2bfdcdc..7c98057 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
-// Performance test comparing RCU vs other mechanisms
+// Scalability test comparing RCU vs other mechanisms
 // for acquiring references on objects.
 //
 // Copyright (C) Google, 2020.
@@ -59,7 +59,7 @@ MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 
 // Wait until there are multiple CPUs before starting test.
-torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
+torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
 // Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000, "Number of loops per experiment.");
@@ -656,7 +656,7 @@ ref_perf_init(void)
 		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
 			pr_cont(" %s", perf_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_PERF_TEST));
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
index 8ba5ba2..a98b58b 100644
--- a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
@@ -1,2 +1,2 @@
-CONFIG_RCU_REF_PERF_TEST=y
+CONFIG_RCU_REF_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
-- 
2.9.5

