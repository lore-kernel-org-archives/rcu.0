Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B5C5ACBF
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A420206B1
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584037077;
	bh=8csvVhRW3l5KCsMDr6QYUn3YY8DNKrig/Br59Zsgyso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKpLhqgYApxfbYUQZts4/D5iTauni6I1xNOaFfONZFhhSqgV54PglUpAWhNMQVOeF
	 6MkXYyfw4OuyvpctKjCH6y3Gp8bxu5iy6N8chupnL8aNxFVqAbtnlyHWXPPLORegwO
	 vJzbFUhU510OcWZ/WPIn5MNzfeDwKSoYFxHf8WTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCLSRy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgCLSRG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AF92073B;
        Thu, 12 Mar 2020 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037025;
        bh=8csvVhRW3l5KCsMDr6QYUn3YY8DNKrig/Br59Zsgyso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zUOWK6m2oCPce5Zcj5hEAhQGIF/dz9Zo7wrRTl1/JXfyQS90EQoAs+oqFFW5L9SZC
         RT+sD7HaVJDt3YhIWuIBa74IM0uh24/BeWSYLXIfT8b4hZo6MjRF9rssLA2Ib8CEOC
         AVxL7KmXQ34FEQYjwcx3sLFhVLPs5y8WQ7YfttDY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 03/16] rcutorture: Add flag to produce non-busy-wait task stalls
Date:   Thu, 12 Mar 2020 11:16:49 -0700
Message-Id: <20200312181702.8443-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit aids testing of RCU task stall warning messages by adding
an rcutorture.stall_cpu_block module parameter that results in the
induced stall sleeping within the RCU read-side critical section.
Spinning with interrupts disabled is still available via the
rcutorture.stall_cpu_irqsoff module parameter, and specifying neither
of these two module parameters will spin with preemption disabled.

Note that sleeping (as opposed to preemption) results in additional
complaints from RCU at context-switch time, so yet more testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/rcu/rcutorture.c                         | 13 ++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6d16b78..17eff15 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4161,6 +4161,11 @@
 			Duration of CPU stall (s) to test RCU CPU stall
 			warnings, zero to disable.
 
+	rcutorture.stall_cpu_block= [KNL]
+			Sleep while stalling if set.  This will result
+			in warnings from preemptible RCU in addition
+			to any other stall-related activity.
+
 	rcutorture.stall_cpu_holdoff= [KNL]
 			Time to wait (s) after boot before inducing stall.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b3301f3..f75d466 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -102,6 +102,7 @@ torture_param(int, stall_cpu, 0, "Stall duration (s), zero to disable.");
 torture_param(int, stall_cpu_holdoff, 10,
 	     "Time to wait before starting stall (s).");
 torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
+torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stat_interval, 60,
 	     "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
@@ -1599,6 +1600,7 @@ static int rcutorture_booster_init(unsigned int cpu)
  */
 static int rcu_torture_stall(void *args)
 {
+	int idx;
 	unsigned long stop_at;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_stall task started");
@@ -1610,21 +1612,22 @@ static int rcu_torture_stall(void *args)
 	if (!kthread_should_stop()) {
 		stop_at = ktime_get_seconds() + stall_cpu;
 		/* RCU CPU stall is expected behavior in following code. */
-		rcu_read_lock();
+		idx = cur_ops->readlock();
 		if (stall_cpu_irqsoff)
 			local_irq_disable();
-		else
+		else if (!stall_cpu_block)
 			preempt_disable();
 		pr_alert("rcu_torture_stall start on CPU %d.\n",
 			 smp_processor_id());
 		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
 				    stop_at))
-			continue;  /* Induce RCU CPU stall warning. */
+			if (stall_cpu_block)
+				schedule_timeout_uninterruptible(HZ);
 		if (stall_cpu_irqsoff)
 			local_irq_enable();
-		else
+		else if (!stall_cpu_block)
 			preempt_enable();
-		rcu_read_unlock();
+		cur_ops->readunlock(idx);
 		pr_alert("rcu_torture_stall end.\n");
 	}
 	torture_shutdown_absorb("rcu_torture_stall");
-- 
2.9.5

