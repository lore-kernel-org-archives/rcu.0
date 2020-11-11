Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A092C56201
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43222072C
	for <rcu@archiver.kernel.org>; Wed, 11 Nov 2020 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mB5CzTwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgKKOIX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 Nov 2020 09:08:23 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10730 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbgKKOHr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 Nov 2020 09:07:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605103665; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lz+m4hxHGlnZkGfrO+ALxUZ4EUqPBDZxQ1K+QAgsLW8=; b=mB5CzTwowNgr8xuE8jRl0KX2C7c2u/qzRMAIFprFc3iV0awJPZp+YlfSDi83Afv5ATDqGSGy
 wg8Doro0x0KciM8JsFG1ThCRRl/ZMiQsHJOCs/YZFKc+WDQnMJV1G4QXmuE1TsGAfjU4bJiv
 6gvHM1egRCNQsLZe+7lkPpwDiHE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fabf0308bd2e3c2226dfcc9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 14:07:44
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 837A5C433F0; Wed, 11 Nov 2020 14:07:44 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F232CC433C8;
        Wed, 11 Nov 2020 14:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F232CC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu: Check and report missed fqs timer wakeup on RCU stall
Date:   Wed, 11 Nov 2020 19:37:37 +0530
Message-Id: <1605103657-25815-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For a new grace period request, RCU GP kthread transitions
through following states:

a. [RCU_GP_WAIT_GPS] -> [RCU_GP_DONE_GPS]

Initial state, where GP kthread waits for a new GP start
request is RCU_GP_WAIT_GPS. On new GP request (started by
callers, for any new callbacks, by setting RCU_GP_FLAG_INIT
gp_state flag and waking up the GP kthread) GP kthread
enters RCU_GP_DONE_GPS.

b. [RCU_GP_DONE_GPS] -> [RCU_GP_ONOFF]

Grace period initialization starts in rcu_gp_init(), which
records the start of new GP in rcu_state.gp_seq and enters
into RCU_GP_ONOFF state.

c. [RCU_GP_ONOFF] -> [RCU_GP_INIT]

In RCU_GP_ONOFF state, for each leaf rnp node, GP kthread
applies the buffered online/offline information of its cpus,
from ->qsmaskinitnext to ->qsmaskinit, which is basically
the mask of cpus, which need to report quiescent state, for
the new GP to complete.

Also, in this state, an outgoing rnp's (for which all cpus
are now offline and there are no tasks blocked inside
RCU read section) or an incoming rnp's (for which first cpu
comes online) participation in the new and subsequent GP is
advertised, by propagating its qsmaskinit information up the
tree.

d. [RCU_GP_INIT] -> [RCU_GP_WAIT_FQS]

In RCU_GP_INIT state, current GPs qs mask information and new
GP seq is propagated down the tree, into all rnp nodes,
in breadth first order.

On GP initialization completion, GP kthread enters a fqs loop,
which does following things, to get quiescent state reported
for cpus, which aren't quiesce in ->qsmask:

  i. For CPUs, which have entered idle since the first iteration,
     report quiescent state up the tree.

  ii. Based on how long the current grace period has been running
      for, either, set the appropriate flags, so that sched clock
      interrupt on that cpu, does qs reporting or do a resched
      on that cpu.

On each iteration, it transitions through following states. The fqs
loop is terminated on GP completion, when all CPUs report their
quiescent state and all RCU readers, blocking current grace period
have completed the RCU read section.

e. [RCU_GP_WAIT_FQS] -> [RCU_GP_DOING_FQS]

GP kthread uses a timed wait (jiffies_till_first_fqs for first
iteration and jiffies_till_next_fqs for subsequent iterations),
before doing all the work, to force quiescent state on
all cpus. It wakes up from this state, either on timeout, or
when (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD) flags are set, either
on callback overload conditions or when last cpu reports its
quiescent state and all RCU readers blocking current GP, have
left the RCU read section.

f. [RCU_GP_CLEANUP] -> [RCU_GP_CLEANED]

Mark end of grace period, in ->gp_seq, on all rnp nodes, in breadth
first order and finally in rcu_state.

For cases where timers are not served (due to issues in timer
configuration, in timer framework or due to softirqs not getting
handled, when there is a storm of interrupts) on the CPU,
where GP kthread queued a timer (for timed wait, which is done
in RCU_GP_WAIT_FQS) its possible that RCU kthread never wakes up.
Report the same from stall warnings, if GP thread is in RCU_GP_WAIT_FQS
state, and the timeout has elapsed and the kthread is not woken.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c       | 25 +++++++++++++++----------
 kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 413831b..804e543 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1767,7 +1767,7 @@ static bool rcu_gp_init(void)
 	 * go offline later.  Please also refer to "Hotplug CPU" section
 	 * of RCU's Requirements documentation.
 	 */
-	rcu_state.gp_state = RCU_GP_ONOFF;
+	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
 	rcu_for_each_leaf_node(rnp) {
 		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
 		firstseq = READ_ONCE(rnp->ofl_seq);
@@ -1833,7 +1833,7 @@ static bool rcu_gp_init(void)
 	 * The grace period cannot complete until the initialization
 	 * process finishes, because this kthread handles both.
 	 */
-	rcu_state.gp_state = RCU_GP_INIT;
+	WRITE_ONCE(rcu_state.gp_state, RCU_GP_INIT);
 	rcu_for_each_node_breadth_first(rnp) {
 		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -1932,17 +1932,22 @@ static void rcu_gp_fqs_loop(void)
 	ret = 0;
 	for (;;) {
 		if (!ret) {
-			rcu_state.jiffies_force_qs = jiffies + j;
+			WRITE_ONCE(rcu_state.jiffies_force_qs, jiffies + j);
+			/*
+			 * jiffies_force_qs before RCU_GP_WAIT_FQS state
+			 * update; required for stall checks.
+			 */
+			smp_wmb();
 			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
 				   jiffies + (j ? 3 * j : 2));
 		}
 		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
-		rcu_state.gp_state = RCU_GP_WAIT_FQS;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
 		ret = swait_event_idle_timeout_exclusive(
 				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
 		rcu_gp_torture_wait();
-		rcu_state.gp_state = RCU_GP_DOING_FQS;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
 		/* If grace period done, leave loop. */
 		if (!READ_ONCE(rnp->qsmask) &&
@@ -2056,7 +2061,7 @@ static void rcu_gp_cleanup(void)
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("end"));
 	rcu_seq_end(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	rcu_state.gp_state = RCU_GP_IDLE;
+	WRITE_ONCE(rcu_state.gp_state, RCU_GP_IDLE);
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(&rcu_data);
 	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
@@ -2095,12 +2100,12 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		for (;;) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("reqwait"));
-			rcu_state.gp_state = RCU_GP_WAIT_GPS;
+			WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_GPS);
 			swait_event_idle_exclusive(rcu_state.gp_wq,
 					 READ_ONCE(rcu_state.gp_flags) &
 					 RCU_GP_FLAG_INIT);
 			rcu_gp_torture_wait();
-			rcu_state.gp_state = RCU_GP_DONE_GPS;
+			WRITE_ONCE(rcu_state.gp_state, RCU_GP_DONE_GPS);
 			/* Locking provides needed memory barrier. */
 			if (rcu_gp_init())
 				break;
@@ -2115,9 +2120,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		rcu_gp_fqs_loop();
 
 		/* Handle grace-period end. */
-		rcu_state.gp_state = RCU_GP_CLEANUP;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
 		rcu_gp_cleanup();
-		rcu_state.gp_state = RCU_GP_CLEANED;
+		WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
 	}
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 70d48c5..4ff7990 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -468,6 +468,37 @@ static void rcu_check_gp_kthread_starvation(void)
 	}
 }
 
+/* Complain about missing wakeups from expired fqs wait timer */
+static void rcu_check_gp_kthread_expired_fqs_timer(void)
+{
+	struct task_struct *gpk = rcu_state.gp_kthread;
+	short gp_state;
+	unsigned long jiffies_fqs;
+	int cpu;
+
+	gp_state = READ_ONCE(rcu_state.gp_state);
+	/*
+	 * Order reads of .gp_state and .jiffies_force_qs.
+	 * Matching smp_wmb() is present in rcu_gp_fqs_loop().
+	 */
+	smp_rmb();
+	jiffies_fqs = READ_ONCE(rcu_state.jiffies_force_qs);
+
+	if (gp_state == RCU_GP_WAIT_FQS &&
+	    time_before(jiffies + RCU_STALL_MIGHT_MIN, jiffies_fqs) &&
+	    gpk && !READ_ONCE(gpk->on_rq)) {
+		cpu = task_cpu(gpk);
+		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
+		       rcu_state.name, (jiffies - jiffies_fqs),
+		       (long)rcu_seq_current(&rcu_state.gp_seq),
+		       data_race(rcu_state.gp_flags),
+		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
+		       gpk->state);
+		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
+		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
+	}
+}
+
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
@@ -530,6 +561,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
 	rcu_check_gp_kthread_starvation();
+	rcu_check_gp_kthread_expired_fqs_timer();
 
 	panic_on_rcu_stall();
 
@@ -565,6 +597,7 @@ static void print_cpu_stall(unsigned long gps)
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation();
+	rcu_check_gp_kthread_expired_fqs_timer();
 
 	rcu_dump_cpu_stacks();
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

