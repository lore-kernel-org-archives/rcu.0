Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C97C433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F4D20720
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871763;
	bh=ScFiFOeg4wutJUeONEdB3g/vj6kgdvyBYrim7fkHdkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R5B2oXEc6nIBTC5/H1X1AOucHVh14EWUQGsdvatVvfbND8Y9ZHVJc9DZxrQv/VJhM
	 8+rRRov1vMMr6ufX7AtER1NZXRYbIqQXlVuKWq4bw4f0K+GWnRBuCs1J7mPcFrDrJn
	 YAxGlrlVqLxKMyckUzaslCOJPzaR8NR9kxzsCHFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbgFWAWm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731533AbgFWAVw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A0C20888;
        Tue, 23 Jun 2020 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871711;
        bh=ScFiFOeg4wutJUeONEdB3g/vj6kgdvyBYrim7fkHdkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbhDz2xqOOd90aeR/wpemEW9o39zIOk7ijmiFK4X0GlmwVKMv/R0atkEG8DBpreww
         vB8Kxq0FgJ2lx3jrZmooTVFytZOWq+VNTPVtQVEVCrZtu13+Ckq689+wBfkZvGiiKK
         5nh7nfH0ZUYUflF1S7BcJZ+zRN29BGMRmxLr4tzk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>, stable@kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/26] tick/nohz: Narrow down noise while setting current task's tick dependency
Date:   Mon, 22 Jun 2020 17:21:34 -0700
Message-Id: <20200623002147.25750-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Setting a tick dependency on any task, including the case where a task
sets that dependency on itself, triggers an IPI to all CPUs.  That is
of course suboptimal but it had previously not been an issue because it
was only used by POSIX CPU timers on nohz_full, which apparently never
occurs in latency-sensitive workloads in production.  (Or users of such
systems are suffering in silence on the one hand or venting their ire
on the wrong people on the other.)

But RCU now sets a task tick dependency on the current task in order
to fix stall issues that can occur during RCU callback processing.
Thus, RCU callback processing triggers frequent system-wide IPIs from
nohz_full CPUs.  This is quite counter-productive, after all, avoiding
IPIs is what nohz_full is supposed to be all about.

This commit therefore optimizes tasks' self-setting of a task tick
dependency by using tick_nohz_full_kick() to avoid the system-wide IPI.
Instead, only the execution of the one task is disturbed, which is
acceptable given that this disturbance is well down into the noise
compared to the degree to which the RCU callback processing itself
disturbs execution.

Fixes: 6a949b7af82d (rcu: Force on tick when invoking lots of callbacks)
Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@kernel.org
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/tick-sched.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e2dc9b..f0199a4 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -351,16 +351,24 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits bit)
 EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
 
 /*
- * Set a per-task tick dependency. Posix CPU timers need this in order to elapse
- * per task timers.
+ * Set a per-task tick dependency. RCU need this. Also posix CPU timers
+ * in order to elapse per task timers.
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	/*
-	 * We could optimize this with just kicking the target running the task
-	 * if that noise matters for nohz full users.
-	 */
-	tick_nohz_dep_set_all(&tsk->tick_dep_mask, bit);
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
+		if (tsk == current) {
+			preempt_disable();
+			tick_nohz_full_kick();
+			preempt_enable();
+		} else {
+			/*
+			 * Some future tick_nohz_full_kick_task()
+			 * should optimize this.
+			 */
+			tick_nohz_full_kick_all();
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 
-- 
2.9.5

