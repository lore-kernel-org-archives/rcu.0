Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8ACC433ED
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F7761925
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 23:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhEKXKw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 19:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKXKv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 19:10:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B474061626;
        Tue, 11 May 2021 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774584;
        bh=Y6MaGrrbx1rhQ0TtyMb37eg0EUKdFwJ4AMTQbQ3ZCZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCzxQqC9+orkPNVP2s7bXZFDYAKMeC9+saLjeqSNbrGghzyZB6o8aqyjwF+as98qr
         iPKahw6AjpVLK3+K4YJwjzwM3tBwrEJUlsvaD80zU2/bfOroppHIc+5TOg0A/0JkWL
         tUCff6YXbfFrycuOeOKlLNHdTezDOwlic47hyj/yk5x/RfQhJ0x0U1Z0VjZ2RAnjNB
         M90kCy29CwQlc4p47uilqYJB1ribCBvj7OmlP12kZ8QGUW4E3Tc2LEi08VFDs2XMAf
         SAeujyRtbw3n0DhpnmOXrPrk9CTlv9kVZEvt8l3KZoNfScSrvqBaVelx6Em++dultN
         BjgPstguDVNLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 522585C0138; Tue, 11 May 2021 16:09:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] rcu-tasks: Add block comment laying out RCU Tasks design
Date:   Tue, 11 May 2021 16:09:39 -0700
Message-Id: <20210511230942.2894861-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This commit adds a block comment that gives a high-level overview of how
RCU tasks grace periods progress.  It also adds a note about how exiting
tasks are handled, plus it gives an overview of the memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5051f9..94d2c2c7f0ab 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -377,6 +377,46 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 // Finally, this implementation does not support high call_rcu_tasks()
 // rates from multiple CPUs.  If this is required, per-CPU callback lists
 // will be needed.
+//
+// The implementation uses rcu_tasks_wait_gp(), which relies on function
+// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_kthread()
+// function sets these function pointers up so that rcu_tasks_wait_gp()
+// invokes these functions in this order:
+//
+// rcu_tasks_pregp_step():
+//	Invokes synchronize_rcu() in order to wait for all in-flight
+//	t->on_rq and t->nvcsw transitions to complete.	This works because
+//	all such transitions are carried out with interrupts disabled.
+// rcu_tasks_pertask(), invoked on every non-idle task:
+//	For every runnable non-idle task other than the current one, use
+//	get_task_struct() to pin down that task, snapshot that task's
+//	number of voluntary context switches, and add that task to the
+//	holdout list.
+// rcu_tasks_postscan():
+//	Invoke synchronize_srcu() to ensure that all tasks that were
+//	in the process of exiting (and which thus might not know to
+//	synchronize with this RCU Tasks grace period) have completed
+//	exiting.
+// check_all_holdout_tasks(), repeatedly until holdout list is empty:
+//	Scans the holdout list, attempting to identify a quiescent state
+//	for each task on the list.  If there is a quiescent state, the
+//	corresponding task is removed from the holdout list.
+// rcu_tasks_postgp():
+//	Invokes synchronize_rcu() in order to ensure that all prior
+//	t->on_rq and t->nvcsw transitions are seen by all CPUs and tasks
+//	to have happened before the end of this RCU Tasks grace period.
+//	Again, this works because all such transitions are carried out
+//	with interrupts disabled.
+//
+// For each exiting task, the exit_tasks_rcu_start() and
+// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
+// read-side critical sections waited for by rcu_tasks_postscan().
+//
+// Pre-grace-period update-side code is ordered before the grace via the
+// ->cbs_lock and the smp_mb__after_spinlock().  Pre-grace-period read-side
+// code is ordered before the grace period via synchronize_rcu() call
+// in rcu_tasks_pregp_step() and by the scheduler's locks and interrupt
+// disabling.
 
 /* Pre-grace-period preparation. */
 static void rcu_tasks_pregp_step(void)
-- 
2.31.1.189.g2e36527f23

