Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843A8C6377A
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9B660725
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhGUT5q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231740AbhGUT5p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BAAB61221;
        Wed, 21 Jul 2021 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899901;
        bh=uo3mNzC8JGMN95RX/9rMuLZ2tfHn/qJe6eYq/zLbUPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTZrRS1GGtOB00DC2yzWdDK+eQAxiVMlCJRsHEuIPAeb5H4ol4TtXZqNJjCSL7iiq
         0/aY7xiS6wImy4OH2J+nYYKjsDqDkBrlQeJgyWSPdrgXRHALJseWiFUousi+5ebcOQ
         h+xeN+ZBJ4zYAq1qjTLbhVzTg4Ng3m/POohUTwFmt1v/XExa8wkaYcoaOXQ5/Rdgbo
         zDDZdAKwVhk0672hCWH7qVO9VlwpD3oEq2WMbjVfNt1L6ic6Dkr+TNc4Rg25rEs7YX
         YqSfNmyQ1J0n3EsxS5F7WKs3eUYMYmekIvUqra8747LKIFisQyXJ3D+Qu6otPN1IVb
         S3OFmV6cXVXqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 597595C0A11; Wed, 21 Jul 2021 13:38:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
Date:   Wed, 21 Jul 2021 13:38:16 -0700
Message-Id: <20210721203818.3398345-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

There are several ->trc_reader_special.b.need_qs data races that are
too low-probability for KCSAN to notice, but which will happen sooner
or later.  This commit therefore marks these accesses.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f6b5320c44849..1cece5e9be9a9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -850,7 +850,7 @@ static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t, int nesting)
 {
-	int nq = t->trc_reader_special.b.need_qs;
+	int nq = READ_ONCE(t->trc_reader_special.b.need_qs);
 
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
 	    t->trc_reader_special.b.need_mb)
@@ -916,7 +916,7 @@ static void trc_read_check_handler(void *t_in)
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 
 reset_ipi:
@@ -968,7 +968,7 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 	// state so that it will awaken the grace-period kthread upon exit
 	// from that critical section.
 	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-	WARN_ON_ONCE(t->trc_reader_special.b.need_qs);
+	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
 	return true;
 }
@@ -1103,7 +1103,7 @@ static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
 		 ".i"[is_idle_task(t)],
 		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
 		 READ_ONCE(t->trc_reader_nesting),
-		 " N"[!!t->trc_reader_special.b.need_qs],
+		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
 		 cpu);
 	sched_show_task(t);
 }
-- 
2.31.1.189.g2e36527f23

