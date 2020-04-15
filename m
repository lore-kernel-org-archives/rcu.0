Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7254CC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5CC20787
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974901;
	bh=m4G4wp1dz094L8BWhivBSAV94uoFke6uWBc+soNg9Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lr23THDsTp6y2bUMmGGbiTztYSxHD2OsxO9ad7YJnbumi4L+ybEtIxivkVbiu+3hr
	 0U2yvPan4V4gd9/S8b/p9/qjXS8Txqeb46GAxNomSADsopo7pUON78u5SbF2lps37u
	 Laf9UFXkvRNTXJaWLXDdRuEhRSKKYLWyDXYvC19M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441395AbgDOSTy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441368AbgDOSTs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3143D2076D;
        Wed, 15 Apr 2020 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974787;
        bh=m4G4wp1dz094L8BWhivBSAV94uoFke6uWBc+soNg9Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUyUtqeCDrEZSqqssmiqXNuy5ytQPKG/lzDTsjj7ru5d9rWj9AoJhebAEuGxxqGCE
         CSStww2RrzvR76GSkYvgsIPsiQBzIHaUbawU/joiYA3dkNONa3rKObaY73UveJ+/xi
         /w58iW1Ab3SrwWuZtEaXGgxSdYGO/XDzptio75QI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 11/38] rcutorture: Add torture tests for RCU Tasks Rude
Date:   Wed, 15 Apr 2020 11:19:14 -0700
Message-Id: <20200415181941.11653-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the definitions required to torture the rude flavor of
RCU tasks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                           |  2 ++
 kernel/rcu/rcu.h                                   |  1 +
 kernel/rcu/rcutorture.c                            | 31 ++++++++++++++++++++--
 .../selftests/rcutorture/configs/rcu/CFLIST        |  1 +
 .../selftests/rcutorture/configs/rcu/RUDE01        | 10 +++++++
 .../selftests/rcutorture/configs/rcu/RUDE01.boot   |  1 +
 6 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4aa02ee..b5f3545 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -29,6 +29,7 @@ config RCU_PERF_TEST
 	select TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
+	select TASKS_RUDE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -46,6 +47,7 @@ config RCU_TORTURE_TEST
 	select TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
+	select TASKS_RUDE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 00ddc92..c574620 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -441,6 +441,7 @@ void rcu_request_urgent_qs_task(struct task_struct *t);
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
+	RCU_TASKS_RUDE_FLAVOR,
 	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fbb3e62..6b066380 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -730,6 +730,33 @@ static struct rcu_torture_ops trivial_ops = {
 	.name		= "trivial"
 };
 
+/*
+ * Definitions for rude RCU-tasks torture testing.
+ */
+
+static void rcu_tasks_rude_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu_tasks_rude(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops tasks_rude_ops = {
+	.ttype		= RCU_TASKS_RUDE_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= rcu_torture_read_lock_trivial,
+	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
+	.readunlock	= rcu_torture_read_unlock_trivial,
+	.get_gp_seq	= rcu_no_completed,
+	.deferred_free	= rcu_tasks_rude_torture_deferred_free,
+	.sync		= synchronize_rcu_tasks_rude,
+	.exp_sync	= synchronize_rcu_tasks_rude,
+	.call		= call_rcu_tasks_rude,
+	.cb_barrier	= rcu_barrier_tasks_rude,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.name		= "tasks-rude"
+};
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -739,7 +766,7 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 
 static bool __maybe_unused torturing_tasks(void)
 {
-	return cur_ops == &tasks_ops;
+	return cur_ops == &tasks_ops || cur_ops == &tasks_rude_ops;
 }
 
 /*
@@ -2413,7 +2440,7 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops, &trivial_ops,
+		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops, &trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index c3c1fb5..ec0c72f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -14,3 +14,4 @@ TINY02
 TASKS01
 TASKS02
 TASKS03
+RUDE01
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
new file mode 100644
index 0000000..bafe94c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
@@ -0,0 +1,10 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
new file mode 100644
index 0000000..9363708
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=tasks-rude
-- 
2.9.5

