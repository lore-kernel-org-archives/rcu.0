Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0CBC6377D
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3730861263
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbhGUT2V (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhGUT2U (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:28:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF46F6124C;
        Wed, 21 Jul 2021 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626898134;
        bh=4u/Or69/PlQhSEBH0Eaic+1vZVEPAHlTAjiIyX9drlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcGf50oDo6wcb0No1eBJgK8ID5oDhIGw56IHM4XaZBRNAD0eIFOoKTYhI+RNEdgsn
         LNTEGBbBYECczPoHn8wmrX0M5p8yFX28QoDDntWEhObRrd8/dLAYEOKykXAbz2Uk7B
         kVGBNHf1U3FFfU9XeQ45ENP9QMUMMKRl76atadmfLHYUZpdeCsi6gn4ER9O5EvHiXR
         iA9p1l3ukgjrozFf2e9W6jNHUpJF9TfAhFmdW/ox7XRx0JD+IdrIXbJJrkwd/j+8lb
         PzUlj6KyXXLuRMy6eHGhvldjMD9w3dPvTQOd8SuwgU1rjAzvFh2e35kJgDUL/a/l+h
         zfzrKWOT1+DIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8DB9B5C0BF4; Wed, 21 Jul 2021 13:08:54 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH rcu 5/5] doc: Update stallwarn.rst with recent changes
Date:   Wed, 21 Jul 2021 13:08:53 -0700
Message-Id: <20210721200853.1175189-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
References: <20210721200806.GA950569@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit calls out the possibility of self-detected stalls, adds new
messages, and calls out the use for stack traces.

Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index f1c49c626e934..5036df24ae61c 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -189,8 +189,8 @@ rcupdate.rcu_task_stall_timeout
 Interpreting RCU's CPU Stall-Detector "Splats"
 ==============================================
 
-For non-RCU-tasks flavors of RCU, when a CPU detects that it is stalling,
-it will print a message similar to the following::
+For non-RCU-tasks flavors of RCU, when a CPU detects that some other
+CPU is stalling, it will print a message similar to the following::
 
 	INFO: rcu_sched detected stalls on CPUs/tasks:
 	2-...: (3 GPs behind) idle=06c/0/0 softirq=1453/1455 fqs=0
@@ -204,6 +204,8 @@ PREEMPT_RCU builds can be stalled by tasks as well as by CPUs, and that
 the tasks will be indicated by PID, for example, "P3421".  It is even
 possible for an rcu_state stall to be caused by both CPUs *and* tasks,
 in which case the offending CPUs and tasks will all be called out in the list.
+In some cases, CPUs will detect themselves stalling, which will result
+in a self-detected stall.
 
 CPU 2's "(3 GPs behind)" indicates that this CPU has not interacted with
 the RCU core for the past three grace periods.  In contrast, CPU 16's "(0
@@ -283,7 +285,8 @@ If the relevant grace-period kthread has been unable to run prior to
 the stall warning, as was the case in the "All QSes seen" line above,
 the following additional line is printed::
 
-	kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1 ->cpu=5
+	rcu_sched kthread starved for 23807 jiffies! g7075 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1 ->cpu=5
+	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
 
 Starving the grace-period kthreads of CPU time can of course result
 in RCU CPU stall warnings even when all CPUs and tasks have passed
@@ -313,15 +316,21 @@ is the current ``TIMER_SOFTIRQ`` count on cpu 4.  If this value does not
 change on successive RCU CPU stall warnings, there is further reason to
 suspect a timer problem.
 
+These messages are usually followed by stack dumps of the CPUs and tasks
+involved in the stall.  These stack traces can help you locate the cause
+of the stall, keeping in mind that the CPU detecting the stall will have
+an interrupt frame that is mainly devoted to detecting the stall.
+
 
 Multiple Warnings From One Stall
 ================================
 
-If a stall lasts long enough, multiple stall-warning messages will be
-printed for it.  The second and subsequent messages are printed at
+If a stall lasts long enough, multiple stall-warning messages will
+be printed for it.  The second and subsequent messages are printed at
 longer intervals, so that the time between (say) the first and second
 message will be about three times the interval between the beginning
-of the stall and the first message.
+of the stall and the first message.  It can be helpful to compare the
+stack dumps for the different messages for the same stalled grace period.
 
 
 Stall Warnings for Expedited Grace Periods
-- 
2.31.1.189.g2e36527f23

