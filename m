Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91020C2D0EC
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E5F2073E
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 22:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347973;
	bh=yQeLNXE8pE+mX3NEX+uIgJ7GV9AeElQkGmvOOqKMGQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BufrB809bBIFHNeKmXje1pgy73SvHSQZvhtVPksTai4lUgdqOlrk+sPNJqjd3htXO
	 VsbCk9ObNWSE9PmqSVVoAnvbSjy9Dwy5JGxjqLt6ijDiQA/5xM+CD8awFmvo5uTz+y
	 uSR6bQgZxh9P36oOxHOlYIb1Ba+Qzs9OCzffAsls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgC0W0J (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgC0WZE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 338772137B;
        Fri, 27 Mar 2020 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347903;
        bh=yQeLNXE8pE+mX3NEX+uIgJ7GV9AeElQkGmvOOqKMGQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcUE2hcyHo3P42DvB5aLcbawWekr1QUmns8giXhhv9X5D3hLECUnsH7V/Q9bCRWly
         SEHNtJxLAAdxvkDfDlWLrJl9cghQ5sjTGkLp6/1lPXBldlyo98vhkfa1+UQ2fS66LC
         JunGkxQ2047ExDM8S6gi+wBm+HjDBWzt0WVH7wJw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 15/34] rcutorture: Add torture tests for RCU Tasks Trace
Date:   Fri, 27 Mar 2020 15:24:37 -0700
Message-Id: <20200327222456.12470-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the definitions required to torture the tracing flavor
of RCU tasks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                           |  2 +
 kernel/rcu/rcu.h                                   |  1 +
 kernel/rcu/rcutorture.c                            | 44 +++++++++++++++++++++-
 .../selftests/rcutorture/configs/rcu/CFLIST        |  1 +
 .../selftests/rcutorture/configs/rcu/TRACE01       | 10 +++++
 .../selftests/rcutorture/configs/rcu/TRACE01.boot  |  1 +
 6 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index b15a3bd..a4db41d 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -25,6 +25,7 @@ config RCU_PERF_TEST
 	select SRCU
 	select TASKS_RCU
 	select TASKS_RUDE_RCU
+	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -43,6 +44,7 @@ config RCU_TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
 	select TASKS_RUDE_RCU
+	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index c574620..72903867 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -442,6 +442,7 @@ enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
 	RCU_TASKS_RUDE_FLAVOR,
+	RCU_TASKS_TRACING_FLAVOR,
 	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 386cd11..bb6daa58 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -45,6 +45,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
 #include <linux/tick.h>
+#include <linux/rcupdate_trace.h>
 
 #include "rcu.h"
 
@@ -758,6 +759,45 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.name		= "tasks-rude"
 };
 
+/*
+ * Definitions for tracing RCU-tasks torture testing.
+ */
+
+static int tasks_tracing_torture_read_lock(void)
+{
+	rcu_read_lock_trace();
+	return 0;
+}
+
+static void tasks_tracing_torture_read_unlock(int idx)
+{
+	rcu_read_unlock_trace();
+}
+
+static void rcu_tasks_tracing_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu_tasks_trace(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops tasks_tracing_ops = {
+	.ttype		= RCU_TASKS_TRACING_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= tasks_tracing_torture_read_lock,
+	.read_delay	= srcu_read_delay,  /* just reuse srcu's version. */
+	.readunlock	= tasks_tracing_torture_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
+	.sync		= synchronize_rcu_tasks_trace,
+	.exp_sync	= synchronize_rcu_tasks_trace,
+	.call		= call_rcu_tasks_trace,
+	.cb_barrier	= rcu_barrier_tasks_trace,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.slow_gps	= 1,
+	.name		= "tasks-tracing"
+};
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1316,6 +1356,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 				  rcu_read_lock_bh_held() ||
 				  rcu_read_lock_sched_held() ||
 				  srcu_read_lock_held(srcu_ctlp) ||
+				  rcu_read_lock_trace_held() ||
 				  torturing_tasks());
 	if (p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
@@ -2435,7 +2476,8 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops, &trivial_ops,
+		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
+		&tasks_tracing_ops, &trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index ec0c72f..dfb1817 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -15,3 +15,4 @@ TASKS01
 TASKS02
 TASKS03
 RUDE01
+TRACE01
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
new file mode 100644
index 0000000..078e2c1
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -0,0 +1,10 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
new file mode 100644
index 0000000..9675ad6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=tasks-tracing
-- 
2.9.5

