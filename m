Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF80C43332
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF5964F69
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbhCDBA5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355386AbhCDAXx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:23:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2889464E68;
        Thu,  4 Mar 2021 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817393;
        bh=rKqkwhR8fdkTQi124+9qJ6BCRqBuri/f+Mi5cInkd2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBf2LOju5rBf3sP70NdkmLryLTYUp/ciJQ2dAxlSoibx6/Au6IKRaM5pw4s1xU5Zl
         P8Bm+LMk3OB5VvgBSf/gkALCib6TlwnwVX/zQB7NX6NI8b7RGxKlC7EFBOx46gam48
         V1wLUeOeZ1QOef2DxJlXaAGbXoMmbe26LtENcCd8Z2uVBg8wexqsq1VxE7dkiVsWwG
         2vNE0z2QvOrc74oAuUEWJq765YtMIz5XFvIGeMCbAjqlx7rW3mLp1LMYhsrAAXTGy9
         Lg11CUjQ0nZay7FuMUP7M4OtFJZlc17RAE77PSCtVrA13xcrgGuNry40H+DOiCnDOn
         NwpjCjHKMYzgA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/12] timer: Report ignored local enqueue in nohz mode
Date:   Wed,  3 Mar 2021 16:23:01 -0800
Message-Id: <20210304002311.23655-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Enqueuing a local timer after the tick has been stopped will result in
the timer being ignored until the next random interrupt.

Perform sanity checks to report these situations.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar<mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb62..4822371 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -674,6 +674,26 @@ int get_nohz_timer_target(void)
 	return cpu;
 }
 
+static void wake_idle_assert_possible(void)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	/* Timers are re-evaluated after idle IRQs */
+	if (in_hardirq())
+		return;
+	/*
+	 * Same as hardirqs, assuming they are executing
+	 * on IRQ tail. Ksoftirqd shouldn't reach here
+	 * as the timer base wouldn't be idle. And inline
+	 * softirq processing after a call to local_bh_enable()
+	 * within idle loop sound too fun to be considered here.
+	 */
+	if (in_serving_softirq())
+		return;
+
+	WARN_ON_ONCE("Late timer enqueue may be ignored\n");
+#endif
+}
+
 /*
  * When add_timer_on() enqueues a timer into the timer wheel of an
  * idle CPU then this timer might expire before the next timer event
@@ -688,8 +708,10 @@ static void wake_up_idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (cpu == smp_processor_id())
+	if (cpu == smp_processor_id()) {
+		wake_idle_assert_possible();
 		return;
+	}
 
 	if (set_nr_and_not_polling(rq->idle))
 		smp_send_reschedule(cpu);
-- 
2.9.5

