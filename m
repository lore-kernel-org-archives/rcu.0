Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439EAC4741F
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117612100A
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335915;
	bh=xBvFJr3HzbVvZzRWdMfb7wUEPCUSWv4vIDuq8NJNVFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MFy0y2VdB+34EH2822NwHZ4NShj6JKdyzHuG3Pb79YL7saNuTGLGFCo7z+S0EFPI7
	 bhRY1OVpr1cDZF9/rB3bn+STj3r2ufd7Ayy2psI3LKChuALertaW6DX3Il3Q7QKbQW
	 A1ujs3SSqr1bdBq4aZf173q9S5KW1Y6tZ9YVgBZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgI1Xbp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgI1XbG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:06 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0976522574;
        Mon, 28 Sep 2020 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335866;
        bh=xBvFJr3HzbVvZzRWdMfb7wUEPCUSWv4vIDuq8NJNVFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1imhI4mkLWXcSHTGxW/f2BLOOw9kW98k/AgMpOuc0Wz2BZA9OnsNJ+PnMaqXFP3bD
         w3rcEO5fUavZm7M5PBDaaHGKAyNI8B4iNgQyyCaqLjsqJkQyQb0SMspiLpyzYkJKAk
         6cM+yq8o7yWWQ5dKCIq8FxTqtSENPEzbtMb1IitQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/15] sched: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:55 -0700
Message-Id: <20200928233102.24265-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200928233041.GA23230@paulmck-ThinkPad-P72>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 6 +-----
 lib/Kconfig.debug   | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3..1c304a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3706,8 +3706,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * finish_task_switch() for details.
 	 *
 	 * finish_task_switch() will drop rq->lock() and lower preempt_count
-	 * and the preempt_enable() will end up enabling preemption (on
-	 * PREEMPT_COUNT kernels).
+	 * and the preempt_enable() will end up enabling preemption.
 	 */
 
 	rq = finish_task_switch(prev);
@@ -7308,9 +7307,6 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	if (irqs_disabled())
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return;
-
 	if (preempt_count() > preempt_offset)
 		return;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4d0574..52af6ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1320,7 +1320,6 @@ config DEBUG_LOCKDEP
 
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
-	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
-- 
2.9.5

