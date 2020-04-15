Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3DC3815B
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C3522084D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974937;
	bh=2zXyxwpgF+zdPFIG+jfLFyFXt7aB+acVAbxAj7BJYu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ox6evwY4MbRrW92Rfq5yll2TIyJko2D9jJjTHCmy2Jgc7qihA52yT1jbmO0MrNMZ
	 DoCzAmGXRCawUdDLpoKEZKDjk/IsFo9cvrxQqrJqsUnZR0oDg5fbIgGnRMQltVHayQ
	 bHzvP05n4u35Gu6oEizirijX3eeFAYqAnpIMyc8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416589AbgDOSWO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441388AbgDOSTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:53 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E272217BA;
        Wed, 15 Apr 2020 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974792;
        bh=2zXyxwpgF+zdPFIG+jfLFyFXt7aB+acVAbxAj7BJYu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHfNeJPAjZic5HdvWyE3GLJnbXcu7aCv+MJoHYKsCBXERJkCQv2G7qUz8ZySQwbQf
         aB6HEMJaigchk+JM7J+yD7oRZFFC0XAI1TPW2wwWDr4rdUf74byQ3TGyMnLamivO/Z
         stn422n6eIMCamh25zkCNbz00n6Dg6jN14CNb3xc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 26/38] rcu-tasks: Add Kconfig option to mediate smp_mb() vs. IPI
Date:   Wed, 15 Apr 2020 11:19:29 -0700
Message-Id: <20200415181941.11653-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit provides a new TASKS_TRACE_RCU_READ_MB Kconfig option that
enables use of read-side memory barriers by both rcu_read_lock_trace()
and rcu_read_unlock_trace() when the are executed with the
current->trc_reader_special.b.need_mb flag set.  This flag is currently
never set.  Doing that is the subject of a later commit.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h |  3 ++-
 kernel/rcu/Kconfig             | 18 ++++++++++++++++++
 kernel/rcu/tasks.h             |  3 ++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index c42b365c..4c25a41 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -50,7 +50,8 @@ static inline void rcu_read_lock_trace(void)
 	struct task_struct *t = current;
 
 	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
-	if (t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
+	    t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers
 	rcu_lock_acquire(&rcu_trace_lock_map);
 }
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index cb1d18e..0ebe15a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -234,4 +234,22 @@ config RCU_NOCB_CPU
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
 
+config TASKS_TRACE_RCU_READ_MB
+	bool "Tasks Trace RCU readers use memory barriers in user and idle"
+	depends on RCU_EXPERT
+	default PREEMPT_RT || NR_CPUS < 8
+	help
+	  Use this option to further reduce the number of IPIs sent
+	  to CPUs executing in userspace or idle during tasks trace
+	  RCU grace periods.  Given that a reasonable setting of
+	  the rcupdate.rcu_task_ipi_delay kernel boot parameter
+	  eliminates such IPIs for many workloads, proper setting
+	  of this Kconfig option is important mostly for aggressive
+	  real-time installations and for battery-powered devices,
+	  hence the default chosen above.
+
+	  Say Y here if you hate IPIs.
+	  Say N here if you hate read-side memory barriers.
+	  Take the default if you are unsure.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 94225f9..64a5b97 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -734,7 +734,8 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
 	int nq = t->trc_reader_special.b.need_qs;
 
-	if (t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
+	    t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers.
 	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
 	if (nq)
-- 
2.9.5

