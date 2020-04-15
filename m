Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09805C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E65B20784
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974812;
	bh=hxzCrZ8MhRdXTQXHvBbuNs9fxe+PSD5N3gPfWIoQ6go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SgaOcPQzlcIXOVYY9qRpbPWkGobnG4hw7GMaCmNkaI0SdDoqfoa9TY8C2iSBEP1Ia
	 ZeSG7jJ0MRv2JVAoQBXoHhQ8kh2c3myAvpdC6ZNTRXDlWUEHq8nQVFKEqmL/96027U
	 ayQ5xPF49LfCnhHsaIfueiiIj9DpAuSzWRKSEm4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898339AbgDOSUL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441401AbgDOST5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C9E221E8;
        Wed, 15 Apr 2020 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974796;
        bh=hxzCrZ8MhRdXTQXHvBbuNs9fxe+PSD5N3gPfWIoQ6go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3s8Nr4CR80e1gd2x1YmwY9XjNkxOdOYT3644St1rQRnp5Ia08bjTEOPD9OCPGFqH
         IOErxlAcCWh7S54xGC8SdXtnS3m5aAxiouU2IXEFRbtXB8zTci/xL2OKc5qDRFpX/i
         CL+b7TWeX4dk1J71snUOef8hacQkOTc6euqArGcE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v4 tip/core/rcu 37/38] ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()
Date:   Wed, 15 Apr 2020 11:19:40 -0700
Message-Id: <20200415181941.11653-37-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces the schedule_on_each_cpu(ftrace_sync) instances
with synchronize_rcu_tasks_rude().

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
[ paulmck: Make Kconfig adjustments noted by kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/trace/Kconfig  |  1 +
 kernel/trace/ftrace.c | 17 +++--------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 402eef8..ae69010 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -158,6 +158,7 @@ config FUNCTION_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
 	select TASKS_RCU if PREEMPTION
+	select TASKS_RUDE_RCU
 	help
 	  Enable the kernel to trace every kernel function. This is done
 	  by using a compiler feature to insert a small, 5-byte No-Operation
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 041694a..771eace 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -160,17 +160,6 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 	op->saved_func(ip, parent_ip, op, regs);
 }
 
-static void ftrace_sync(struct work_struct *work)
-{
-	/*
-	 * This function is just a stub to implement a hard force
-	 * of synchronize_rcu(). This requires synchronizing
-	 * tasks even in userspace and idle.
-	 *
-	 * Yes, function tracing is rude.
-	 */
-}
-
 static void ftrace_sync_ipi(void *data)
 {
 	/* Probably not needed, but do it anyway */
@@ -256,7 +245,7 @@ static void update_ftrace_function(void)
 	 * Make sure all CPUs see this. Yes this is slow, but static
 	 * tracing is slow and nasty to have enabled.
 	 */
-	schedule_on_each_cpu(ftrace_sync);
+	synchronize_rcu_tasks_rude();
 	/* Now all cpus are using the list ops. */
 	function_trace_op = set_function_trace_op;
 	/* Make sure the function_trace_op is visible on all CPUs */
@@ -2932,7 +2921,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		schedule_on_each_cpu(ftrace_sync);
+		synchronize_rcu_tasks_rude();
 
 		/*
 		 * When the kernel is preeptive, tasks can be preempted
@@ -5887,7 +5876,7 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		schedule_on_each_cpu(ftrace_sync);
+		synchronize_rcu_tasks_rude();
 
 		free_ftrace_hash(old_hash);
 	}
-- 
2.9.5

