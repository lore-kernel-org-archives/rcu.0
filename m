Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA6DC43381
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA4A22DD3
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 00:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAFA6U (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbhAFA6T (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 19:58:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44D7622E03;
        Wed,  6 Jan 2021 00:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894658;
        bh=7Lpg3JpvCyhFmK3955GjHbz3mWVxQeMM9a2XxyDeSik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8guUJy78crW8ihMo2D0KzOV8nxIWDkqrYd9YCa8nxGBo5f36mqilxn1Hunovpxt4
         WLIbX/QK3i6c75US+SS+vfSsVOrJwu2TGd6fiHnixXUMHpAlhFXUGpZmn7Qnf4oqXy
         5lMSMEaeWGOdPHxJfX9jDWpmhq2zL9yEMNJVbvi7R/2/8+hqqX6lU1JyQeRhWr9IZO
         XzclKNrCIa3ARmHfEyapEXoLTLbndB3lNqMp/iN6wj9yEhOMNtig4aMVKXd+oU6yOj
         69+AA1Myq9ANDBXG8ZbdXGLvBT9RQp8PevgIcuj/ZwXfG83g4C6TbNCSiUcwpms//D
         w2/OpZFre+hSQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/6] rcu: Add lockdep_assert_irqs_disabled() to rcu_sched_clock_irq() and callees
Date:   Tue,  5 Jan 2021 16:57:33 -0800
Message-Id: <20210106005736.12613-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106005713.GA12492@paulmck-ThinkPad-P72>
References: <20210106005713.GA12492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a number of lockdep_assert_irqs_disabled() calls
to rcu_sched_clock_irq() and a number of the functions that it calls.
The point of this is to help track down a situation where lockdep appears
to be insisting that interrupts are enabled within these functions, which
should only ever be invoked from the scheduling-clock interrupt handler.

Link: https://lore.kernel.org/lkml/20201111133813.GA81547@elver.google.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        | 4 ++++
 kernel/rcu/tree_plugin.h | 1 +
 kernel/rcu/tree_stall.h  | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bd04b09..f70634f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2553,6 +2553,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 void rcu_sched_clock_irq(int user)
 {
 	trace_rcu_utilization(TPS("Start scheduler-tick"));
+	lockdep_assert_irqs_disabled();
 	raw_cpu_inc(rcu_data.ticks_this_gp);
 	/* The load-acquire pairs with the store-release setting to true. */
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
@@ -2566,6 +2567,7 @@ void rcu_sched_clock_irq(int user)
 	rcu_flavor_sched_clock_irq(user);
 	if (rcu_pending(user))
 		invoke_rcu_core();
+	lockdep_assert_irqs_disabled();
 
 	trace_rcu_utilization(TPS("End scheduler-tick"));
 }
@@ -3690,6 +3692,8 @@ static int rcu_pending(int user)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
+	lockdep_assert_irqs_disabled();
+
 	/* Check for CPU stalls, if enabled. */
 	check_cpu_stall(rdp);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e..cb76e70 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -682,6 +682,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 {
 	struct task_struct *t = current;
 
+	lockdep_assert_irqs_disabled();
 	if (user || rcu_is_cpu_rrupt_from_idle()) {
 		rcu_note_voluntary_context_switch(current);
 	}
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ca21d28..4024dcc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -260,6 +260,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 	struct task_struct *t;
 	struct task_struct *ts[8];
 
+	lockdep_assert_irqs_disabled();
 	if (!rcu_preempt_blocked_readers_cgp(rnp))
 		return 0;
 	pr_err("\tTasks blocked on level-%d rcu_node (CPUs %d-%d):",
@@ -284,6 +285,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 				".q"[rscr.rs.b.need_qs],
 				".e"[rscr.rs.b.exp_hint],
 				".l"[rscr.on_blkd_list]);
+		lockdep_assert_irqs_disabled();
 		put_task_struct(t);
 		ndetected++;
 	}
@@ -472,6 +474,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	struct rcu_node *rnp;
 	long totqlen = 0;
 
+	lockdep_assert_irqs_disabled();
+
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
 	if (rcu_stall_is_suppressed())
@@ -493,6 +497,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 				}
 		}
 		ndetected += rcu_print_task_stall(rnp, flags); // Releases rnp->lock.
+		lockdep_assert_irqs_disabled();
 	}
 
 	for_each_possible_cpu(cpu)
@@ -538,6 +543,8 @@ static void print_cpu_stall(unsigned long gps)
 	struct rcu_node *rnp = rcu_get_root();
 	long totqlen = 0;
 
+	lockdep_assert_irqs_disabled();
+
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads();
 	if (rcu_stall_is_suppressed())
@@ -592,6 +599,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long js;
 	struct rcu_node *rnp;
 
+	lockdep_assert_irqs_disabled();
 	if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
 	    !rcu_gp_in_progress())
 		return;
-- 
2.9.5

