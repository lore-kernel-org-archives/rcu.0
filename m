Return-Path: <SRS0=f31y=DF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78CC4727C
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC37421BE5
	for <rcu@archiver.kernel.org>; Mon, 28 Sep 2020 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601335870;
	bh=AuTy7tGMkG8gJzgNl9lfYfB9FwNBH9eZew6Rscmgudw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PznSK6BP8ECZOA/sdHTMcUiMv18wRdWLULBVnz63bm3ocJjWRdYs2sMrdqDX5EiVC
	 u+9M579G/3Wn6YGgFnqpHO4uSIuSWmdPLFjra6HCD7ItkPJLyUHi2Ye5y0UnETNtsS
	 O4c+6esX3IWCLZoBiW+lGreUFaNo/4lUv/vnT2fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgI1XbJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgI1XbF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Sep 2020 19:31:05 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0BD21D43;
        Mon, 28 Sep 2020 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601335864;
        bh=AuTy7tGMkG8gJzgNl9lfYfB9FwNBH9eZew6Rscmgudw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St7E+3398t135547ZTAV7d9yGDqXB/LD/PIAHTT5Aly7GP7S5puG+FntxYT7/JitX
         sdy+Qq2x5f2b/VKgoF2Tw3DXrzjpB8eiYrl2UHnj8nfMAj1j1oWxWm3+MmahwI28AZ
         GrjM8kUy5fzhE9AtWisvUFcbevpCMdVf2p1npAYA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 03/15] preempt: Cleanup PREEMPT_COUNT leftovers
Date:   Mon, 28 Sep 2020 16:30:50 -0700
Message-Id: <20200928233102.24265-3-paulmck@kernel.org>
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
Cc: Ingo Molnar <mingo@kernel.org>
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
 include/linux/preempt.h | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0..513769b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -56,8 +56,7 @@
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
- * Disable preemption until the scheduler is running -- use an unconditional
- * value so that it also works on !PREEMPT_COUNT kernels.
+ * Disable preemption until the scheduler is running.
  *
  * Reset by start_kernel()->sched_init()->init_idle()->init_idle_preempt_count().
  */
@@ -69,7 +68,6 @@
  *
  *    preempt_count() == 2*PREEMPT_DISABLE_OFFSET
  *
- * Note: PREEMPT_DISABLE_OFFSET is 0 for !PREEMPT_COUNT kernels.
  * Note: See finish_task_switch().
  */
 #define FORK_PREEMPT_COUNT	(2*PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
@@ -106,11 +104,7 @@
 /*
  * The preempt_count offset after preempt_disable();
  */
-#if defined(CONFIG_PREEMPT_COUNT)
-# define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
-#else
-# define PREEMPT_DISABLE_OFFSET	0
-#endif
+#define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
 
 /*
  * The preempt_count offset after spin_lock()
@@ -122,8 +116,8 @@
  *
  *  spin_lock_bh()
  *
- * Which need to disable both preemption (CONFIG_PREEMPT_COUNT) and
- * softirqs, such that unlock sequences of:
+ * Which need to disable both preemption and softirqs, such that unlock
+ * sequences of:
  *
  *  spin_unlock();
  *  local_bh_enable();
@@ -164,8 +158,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
-
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -231,27 +223,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.
-- 
2.9.5

