Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB1EEB56F
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 20:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjIHUgi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbjIHUgg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 16:36:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CDB2;
        Fri,  8 Sep 2023 13:36:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015D5C433C8;
        Fri,  8 Sep 2023 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205388;
        bh=6boxuA0q94N/Ed+FRmKuiKbsWIdOVvAtoMhIDXQWL44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0tN5Z7ThROb64K9jyX34QkgwAALEzcAns/+NdYr90LdFK4qlApeyiX12brzy/q1Z
         xtUNO3D1oO7VhYvbSnBBfY90lVEvyjeiSTm1lDZwPEKJ6mEXMibG9Vju2jQ4Klu5A1
         MSuWCIbVW2aV1NLRgiCQ+HLQx8CeI65oLeaH13dDy4afo33GwMcoy2U+XSJVdI/Y5r
         uDdJZlssMSyon4VQFqcMsRSIk/H0CQgYhna8wMQS2FBF43lcQYkqSlo6fjtFBRCWA5
         N3HTM5Wwb+V/7ciWUCq7aV7DagAoXGH+e5Vcw+l2/vvO7W6Z/IqJ2XShVJZBa3gahS
         wY/u8smjc9tUQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/10] rcu: Assume rcu_report_dead() is always called locally
Date:   Fri,  8 Sep 2023 22:35:59 +0200
Message-ID: <20230908203603.5865-7-frederic@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908203603.5865-1-frederic@kernel.org>
References: <20230908203603.5865-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_report_dead() has to be called locally by the CPU that is going to
exit the RCU state machine. Passing a cpu argument here is error-prone
and leaves the possibility for a racy remote call.

Use local access instead.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm64/kernel/smp.c  | 2 +-
 include/linux/rcupdate.h | 2 +-
 kernel/cpu.c             | 2 +-
 kernel/rcu/tree.c        | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index edd63894d61e..ce672cb69f1c 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -401,7 +401,7 @@ void __noreturn cpu_die_early(void)
 
 	/* Mark this CPU absent */
 	set_cpu_present(cpu, 0);
-	rcu_report_dead(cpu);
+	rcu_report_dead();
 
 	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
 		update_cpu_boot_status(CPU_KILL_ME);
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade90..aa351ddcbe8d 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -122,7 +122,7 @@ static inline void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
 void rcu_init(void);
 extern int rcu_scheduler_active;
 void rcu_sched_clock_irq(int user);
-void rcu_report_dead(unsigned int cpu);
+void rcu_report_dead(void);
 void rcutree_migrate_callbacks(int cpu);
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 88a7ede322bd..86f08eafbd9f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1368,7 +1368,7 @@ void cpuhp_report_idle_dead(void)
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
 
 	BUG_ON(st->state != CPUHP_AP_OFFLINE);
-	rcu_report_dead(smp_processor_id());
+	rcu_report_dead();
 	st->state = CPUHP_AP_IDLE_DEAD;
 	/*
 	 * We cannot call complete after rcu_report_dead() so we delegate it
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8b5ebef32e17..289c51417cbc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4551,11 +4551,11 @@ void rcu_cpu_starting(unsigned int cpu)
  * from the outgoing CPU rather than from the cpuhp_step mechanism.
  * This is because this function must be invoked at a precise location.
  */
-void rcu_report_dead(unsigned int cpu)
+void rcu_report_dead(void)
 {
 	unsigned long flags;
 	unsigned long mask;
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	/*
-- 
2.41.0

