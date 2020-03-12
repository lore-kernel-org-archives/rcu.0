Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6915DC5ACBF
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1020751
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584037059;
	bh=5ghqwCmdCSHbQ1IepHyUQH5Oidbtajjt7LKGKmB8D/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zzEsg1nfWzjsy3OCvbkLcQM6yT0GM+InErjJ7QMIH+D9SQP0sHDLYQFJ7DD98E3wX
	 xf/Q4ljJkt8Zwd1PBhNiaumx9YBnR+e5mQ6gEvl352pEQJmxB5/Hrp9O4I921TS5wk
	 Ge+faLiDhRcbNUWswidiOauqC02E8b98+sS6gybE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCLSRI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgCLSRH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67732074C;
        Thu, 12 Mar 2020 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037027;
        bh=5ghqwCmdCSHbQ1IepHyUQH5Oidbtajjt7LKGKmB8D/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFeNy9xfhxV0BWOWq/VQwRpux53zdDDdsAMv1cbm4bHvrWMa/8rU3xE0dw8oknnbN
         hpdx/idxlCfmh++QcxxvXfzPAzSIMnR1B1jCFDMpv3AqsLYmVf7vGSiLap7nGjo/e/
         c/pFeaIizHSWDkBvHaeh3OBd5X9lPltNDJfabElI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 07/16] rcutorture: Add a test for synchronize_rcu_mult()
Date:   Thu, 12 Mar 2020 11:16:53 -0700
Message-Id: <20200312181702.8443-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a crude test for synchronize_rcu_mult().  This is
currently a smoke test rather than a high-quality stress test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index f75d466..1880c5f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -20,7 +20,7 @@
 #include <linux/err.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
-#include <linux/rcupdate.h>
+#include <linux/rcupdate_wait.h>
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
 #include <uapi/linux/sched/types.h>
@@ -666,6 +666,11 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 	call_rcu_tasks(&p->rtort_rcu, rcu_torture_cb);
 }
 
+static void synchronize_rcu_mult_test(void)
+{
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
+}
+
 static struct rcu_torture_ops tasks_ops = {
 	.ttype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_torture_init,
@@ -675,7 +680,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_tasks_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks,
-	.exp_sync	= synchronize_rcu_tasks,
+	.exp_sync	= synchronize_rcu_mult_test,
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
 	.fqs		= NULL,
-- 
2.9.5

