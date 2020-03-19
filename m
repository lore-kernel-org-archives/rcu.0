Return-Path: <SRS0=6vZU=5E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C55C43333
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AE42076F
	for <rcu@archiver.kernel.org>; Thu, 19 Mar 2020 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584576731;
	bh=pQlQRjD4yimpnJzghi3drA3TOuaXMcXyU0xt0j/uKtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fbmEAtsXaL/G6qb53QtuZr6q4Mbv3CMJSBaclf8S5thA3OEcdjZYtLHHB0AK8zmUE
	 3bOkcOap6aCZFOihPsR4PHPZScsa61dWt7LiCGqW1OFSFfkHpEst1wpPCdOMMf3nK/
	 n23gcK1fk+YNPbTV6PKokXiEy1w/GGbH4ILGOtcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgCSAMC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbgCSALE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 20:11:04 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1CF20775;
        Thu, 19 Mar 2020 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584576664;
        bh=pQlQRjD4yimpnJzghi3drA3TOuaXMcXyU0xt0j/uKtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTJC+DPOnkmpanenNcq5wnjOumxNsKA1z9fGQc7z0VLxCHfNiNClYbL8BcmxrVgwf
         w+met3EHUE/5cZvbyqIzA+Io/+xVK4bRx3jaTtVRNgPWxaHbHsefbVqqHWiOk4/kgl
         ixknBZU/ekRoccb1n5e95br9+xR8T3J3NIc9+tN0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 tip/core/rcu 07/22] rcutorture: Add a test for synchronize_rcu_mult()
Date:   Wed, 18 Mar 2020 17:10:45 -0700
Message-Id: <20200319001100.24917-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200319001024.GA28798@paulmck-ThinkPad-P72>
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
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
index ada5b91..88631f5 100644
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

