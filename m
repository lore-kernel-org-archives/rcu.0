Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F14C43460
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 00:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE8E60FF1
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 00:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhESALE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 May 2021 20:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352409AbhESAK7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 May 2021 20:10:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD26E61363;
        Wed, 19 May 2021 00:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621382980;
        bh=8qbxz7WEGpVSMqD1fK+ggrOGQiNhB2uWQDWBi4BQiJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C9FS4vU9DG5XzoLMUem3v8MK4IHpxj+Ov6YsnDLZI3dzhHA+Dso16uLc+ezzUREAL
         wQOeop2jiy+AlaJTHLKOep7mKOCFWoq6dTqR+7g4SqcfNfkRsBFDTukpQ5NX3Kc6Ow
         bbYwi6SyyM8261wqdg/zeYNTqJYWXWWsXMR8a90TwFQDXmn+H/EFCni253+ISaGWLI
         lwId6FmQJZRqVJaqMOmOMc7MCHPuxIdGcF2Ew4s/YrwZsk1zr63UfewIfUWqwJC2oz
         x+88KnAGdPCN8mFERi8wFTBv/yStfmQFE4tQkPXEk5v3OQQWc7zB1BGlMJsQiYB5Qy
         pbKdbSUoGhkhA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH 3/3] rcu: Assume rcu_report_dead() always deals with local CPU
Date:   Wed, 19 May 2021 02:09:30 +0200
Message-Id: <20210519000930.15702-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519000930.15702-1-frederic@kernel.org>
References: <20210519000930.15702-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_report_dead() is always called locally from the idle path. Passing
a CPU number to it suggests otherwise and is rather error-prone as the
code inside relies on locality.

Robustify the function prototype and refine the name along the way.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../Expedited-Grace-Periods/Expedited-Grace-Periods.rst     | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg     | 2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg          | 2 +-
 Documentation/RCU/Design/Requirements/Requirements.rst      | 2 +-
 arch/arm64/kernel/smp.c                                     | 2 +-
 include/linux/rcupdate.h                                    | 2 +-
 kernel/cpu.c                                                | 4 ++--
 kernel/rcu/tree.c                                           | 6 +++---
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index 6f89cf1e567d..eddf5eea94f1 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -181,7 +181,7 @@ operations is carried out at several levels:
    of this wait (or series of waits, as the case may be) is to permit a
    concurrent CPU-hotplug operation to complete.
 #. In the case of RCU-sched, one of the last acts of an outgoing CPU is
-   to invoke ``rcu_report_dead()``, which reports a quiescent state for
+   to invoke ``rcu_report_dead_cpu()``, which reports a quiescent state for
    that CPU. However, this is likely paranoia-induced redundancy.
 
 +-----------------------------------------------------------------------+
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
index 7ddc094d7f28..6e7b05ff00d3 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
@@ -1135,7 +1135,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6-5"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_report_dead()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_report_dead_cpu()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 069f6f8371c2..ede6ae66d286 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3274,7 +3274,7 @@
          font-weight="bold"
          font-size="192"
          id="text202-7-5-3-27-6-5"
-         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_report_dead()</text>
+         style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_report_dead_cpu()</text>
       <text
          xml:space="preserve"
          x="3745.7725"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
index 2c9310ba29ba..e0ab8cd8db2d 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
@@ -607,7 +607,7 @@
        font-weight="bold"
        font-size="192"
        id="text202-7-5-3-27-6"
-       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_report_dead()</text>
+       style="font-size:192px;font-style:normal;font-weight:bold;text-anchor:start;fill:#000000;stroke-width:0.025in;font-family:Courier">rcu_report_dead_cpu()</text>
     <text
        xml:space="preserve"
        x="3745.7725"
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 38a39476fc24..ede6a2bbf69d 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1953,7 +1953,7 @@ if offline CPUs block an RCU grace period for too long.
 
 An offline CPU's quiescent state will be reported either:
 
-1.  As the CPU goes offline using RCU's hotplug notifier (rcu_report_dead()).
+1.  As the CPU goes offline using RCU's hotplug notifier (rcu_report_dead_cpu()).
 2.  When grace period initialization (rcu_gp_init()) detects a
     race either with CPU offlining or with a task unblocking on a leaf
     ``rcu_node`` structure whose CPUs are all offline.
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dcd7041b2b07..74c0ae3d6c93 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -414,7 +414,7 @@ void cpu_die_early(void)
 
 	/* Mark this CPU absent */
 	set_cpu_present(cpu, 0);
-	rcu_report_dead(cpu);
+	rcu_report_dead_cpu();
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
 		update_cpu_boot_status(CPU_KILL_ME);
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d9680b798b21..fda1dc9b4e03 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -85,7 +85,7 @@ static inline int rcu_preempt_depth(void)
 void rcu_init(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_sched_clock_irq(int user);
-void rcu_report_dead(unsigned int cpu);
+void rcu_report_dead_cpu(void);
 void rcutree_migrate_callbacks(int cpu);
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518556f4..852fcbda1fd8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1016,10 +1016,10 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
-	rcu_report_dead(smp_processor_id());
+	rcu_report_dead_cpu();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
-	 * We cannot call complete after rcu_report_dead() so we delegate it
+	 * We cannot call complete after rcu_report_dead_cpu() so we delegate it
 	 * to an online cpu.
 	 */
 	smp_call_function_single(cpumask_first(cpu_online_mask),
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a6b448e6e059..824a3b367797 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4322,11 +4322,11 @@ void rcu_cpu_starting(unsigned int cpu)
  * from the outgoing CPU rather than from the cpuhp_step mechanism.
  * This is because this function must be invoked at a precise location.
  */
-void rcu_report_dead(unsigned int cpu)
+void rcu_report_dead_cpu(void)
 {
 	unsigned long flags;
 	unsigned long mask;
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	// Do any dangling deferred wakeups.
@@ -4334,7 +4334,7 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* QS for any half-done expedited grace period. */
 	preempt_disable();
-	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
+	rcu_report_exp_rdp(rdp);
 	preempt_enable();
 	rcu_preempt_deferred_qs(current);
 
-- 
2.25.1

