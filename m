Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B11C433E6
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6FD64EEC
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347126AbhCDBAh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353198AbhCDADm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B19D64F99;
        Thu,  4 Mar 2021 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816024;
        bh=TrnMpBgd7K2DIKHxECyH2hJa49pun2ojxoFMIYoP8c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnNf2ZTmXWztt1yHcVcl3eUfZrif/2jE2Hkpza+nRIw65oUozcZ81OA469LVAg+3I
         kBKbyEsRmda2Bjmd0tC6fzo6EWcLc7zH7exELWCRBLetFFgYrU84M5PrJFWRF00jLy
         NMkY7vP7Pz4OyVC5ewqYIw9P23sU8TufIcwhC+103MWh14N3PR0czp5xh3/I4Alrwm
         1CSAobNVzaBzVssIdZ9WI6xrlmcie2zyIfhIcIcRtyx0GmqvfatdsWaB9teze2VXvi
         ouHjwtybbyg4yg0Fvxo5Ky+9YyfeKGMphQkzk5fHFFPg9Mdqk18fVUhuxIq3jdL0aN
         2zWFHg+q+U5AQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Sangmoon Kim <sangmoon.kim@samsung.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/10] rcu/tree: Add a trace event for RCU CPU stall warnings
Date:   Wed,  3 Mar 2021 16:00:19 -0800
Message-Id: <20210304000019.22459-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sangmoon Kim <sangmoon.kim@samsung.com>

This commit adds a trace event which allows tracing the beginnings of RCU
CPU stall warnings on systems where sysctl_panic_on_rcu_stall is disabled.

The first parameter is the name of RCU flavor like other trace events.
The second parameter indicates whether this is a stall of an expedited
grace period, a self-detected stall of a normal grace period, or a stall
of a normal grace period detected by some CPU other than the one that
is stalled.

RCU CPU stall warnings are often caused by external-to-RCU issues,
for example, in interrupt handling or task scheduling.  Therefore,
this event uses TRACE_EVENT, not TRACE_EVENT_RCU, to avoid requiring
those interested in tracing RCU CPU stalls to rebuild their kernels
with CONFIG_RCU_TRACE=y.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree_exp.h      |  1 +
 kernel/rcu/tree_stall.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5fc2940..c7711e9 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
 		  __entry->cpu, __entry->qsevent)
 );
 
+/*
+ * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
+ * and a string identifying which function detected the RCU stall as follows:
+ *
+ *	"StallDetected": Scheduler-tick detects other CPU's stalls.
+ *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
+ *	"ExpeditedStall": Expedited grace period detects stalls.
+ */
+TRACE_EVENT(rcu_stall_warning,
+
+	TP_PROTO(const char *rcuname, const char *msg),
+
+	TP_ARGS(rcuname, msg),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(const char *, msg)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->msg = msg;
+	),
+
+	TP_printk("%s %s",
+		  __entry->rcuname, __entry->msg)
+);
+
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6c6ff06..2796084 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -521,6 +521,7 @@ static void synchronize_rcu_expedited_wait(void)
 		if (rcu_stall_is_suppressed())
 			continue;
 		panic_on_rcu_stall();
+		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
 		ndetected = 0;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 475b261..59b95cc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -536,6 +536,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -606,6 +607,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info(smp_processor_id());
-- 
2.9.5

