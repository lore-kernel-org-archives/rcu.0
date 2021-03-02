Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A604AC433DB
	for <rcu@archiver.kernel.org>; Wed,  3 Mar 2021 05:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BF864EC3
	for <rcu@archiver.kernel.org>; Wed,  3 Mar 2021 05:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353062AbhCCEyy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 2 Mar 2021 23:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhCBTVk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 2 Mar 2021 14:21:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAC064F1C;
        Tue,  2 Mar 2021 19:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614712821;
        bh=b51yDCHCWuWEn7rykJloCv1Z+KciJZNXYu6G7tfW3WM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uGwk6pTyWQ4dYAKstQOAhOqSRCHSHgqIW1dWP+tI0w0fAFuNckqhlavQ6XlTSGn1N
         C+ZBzQJCbE0oLqu3BLp79cfE9KbMINWjqLlim/eJhGvt7VtU7JGYg0bURobzaDEVEo
         n2SQeAll3iuqeTfTIDoVzT2NSyV2YT3XTUNWcF2dTnK/wH96mcmAu1sNUx70XOSH4i
         I50kSprMKISjtS20BTfd+ptYBgEq9LC3kgIWbDc2C/LIxgEKvMl+TU3s/ouejBzV1J
         VBY8d/XL8vecVmjQjNjbPTnLN8x4DvOJd/xajrmjiZbnDhBElpNCj9qN+kNHLcpj8V
         PaEO5Sgv740jw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2B7D7352259C; Tue,  2 Mar 2021 11:20:21 -0800 (PST)
Date:   Tue, 2 Mar 2021 11:20:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     Sangmoon Kim <sangmoon.kim@samsung.com>, urezki@gmail.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3] rcu/tree: Add a trace event for RCU stall warnings
Message-ID: <20210302192021.GP2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210228194700.GA55724@pc638.lan>
 <CGME20210302120418epcas1p17e7f55d9c380ae864d2a6afab5fd3b1b@epcas1p1.samsung.com>
 <20210302115515.14239-1-sangmoon.kim@samsung.com>
 <c8105158-d981-83bb-64f7-83e0c2921de9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8105158-d981-83bb-64f7-83e0c2921de9@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 02, 2021 at 10:34:26PM +0530, Neeraj Upadhyay wrote:
> On 3/2/2021 5:25 PM, Sangmoon Kim wrote:
> > The event allows us to trace the RCU stall when
> > sysctl_panic_on_rcu_stall is disabled.
> > 
> > The first parameter is the name of RCU flavour like other trace
> > events. The second one shows us which function detected stalls.
> > 
> > The RCU stall is mainly caused by external factors such as interrupt
> > handling or task scheduling or something else. Therefore, this event
> > uses TRACE_EVENT macro, not dedicated one, so that someone interested
> > in the RCU stall can use it without CONFIG_RCU_TRACE.
> > 
> > Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

[ . . . ]

> Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>

Thank you all!  As usual, I wordsmithed the commit log as shown below.
Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 4ee0eb7c0cbccaae8e5e3681d852d4e7f50c4378
Author: Sangmoon Kim <sangmoon.kim@samsung.com>
Date:   Tue Mar 2 20:55:15 2021 +0900

    rcu/tree: Add a trace event for RCU CPU stall warnings
    
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
