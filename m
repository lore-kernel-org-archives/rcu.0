Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD12C2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8352076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586974872;
	bh=u9WDPJ9PVhLe00nroezkeAOMPAu5vRYHEOa3AE/9rBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhQw3pdZq47TYy4Y7WrEU/QFL4bR9FdS2mqgIv1Cw875SRkxQOp3javRMUQV3IGuD
	 09uwEkG9WFAHVEoo6l9jh3ReWWki+1cMyxdYvkG2TLmfHDaikDUfzEbHFBqBhoNeTZ
	 1q9wwuRDyH1D35NgPmJwYKSNCsewa8l19k6S9gjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416548AbgDOSVK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441396AbgDOSTz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9287E21BE5;
        Wed, 15 Apr 2020 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974794;
        bh=u9WDPJ9PVhLe00nroezkeAOMPAu5vRYHEOa3AE/9rBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=16G12vWV5otnRrHhYIEMlBGoo7Px1ovnQHIAR4q4+xpG8Jvpx4jsLCI0SbZOJbxtQ
         te9zxr8S8zNkC7y6P2yt9u6Nj3SL4z1bIG0qOjhRF9LhNWJWsQ3fwvPnDwotmLfi5A
         EBLUZUB1Q75Jap/4UEGMoCAijkdly4yOiCS0yYdw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 32/38] rcu-tasks: Add rcu_dynticks_zero_in_eqs() effectiveness statistics
Date:   Wed, 15 Apr 2020 11:19:35 -0700
Message-Id: <20200415181941.11653-32-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds counts of the number of calls and number of successful
calls to rcu_dynticks_zero_in_eqs(), which are printed at the end
of rcutorture runs and at stall time.  This allows evaluation of the
effectiveness of rcu_dynticks_zero_in_eqs().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 6bd9bfe..b51f19a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -725,6 +725,11 @@ DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
+// The number of detections of task quiescent state relying on
+// heavyweight readers executing explicit memory barriers.
+unsigned long n_heavy_reader_attempts;
+unsigned long n_heavy_reader_updates;
+
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
@@ -830,9 +835,11 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
 		// However, we cannot safely change its state.
+		n_heavy_reader_attempts++;
 		if (!ofl && // Check for "running" idle tasks on offline CPUs.
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
+		n_heavy_reader_updates++;
 		in_qs = true;
 	} else {
 		in_qs = likely(!t->trc_reader_nesting);
@@ -1143,9 +1150,11 @@ core_initcall(rcu_spawn_tasks_trace_kthread);
 
 static void show_rcu_tasks_trace_gp_kthread(void)
 {
-	char buf[32];
+	char buf[64];
 
-	sprintf(buf, "N%d", atomic_read(&trc_n_readers_need_end));
+	sprintf(buf, "N%d h:%lu/%lu", atomic_read(&trc_n_readers_need_end),
+		data_race(n_heavy_reader_updates),
+		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 
-- 
2.9.5

