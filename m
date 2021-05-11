Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D12C43603
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88FF61624
	for <rcu@archiver.kernel.org>; Tue, 11 May 2021 22:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhEKWyS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 May 2021 18:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230301AbhEKWyP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FF426193B;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=0jkeqLuZt28j8YO/2un6NrSskGJmVZ0FDBk/rJOc/64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+N7BT1jKWBTleHXGv8wD3i+Nm8hWvGnIUBdHCcLD5KTOzxWI8OkKJupmTILBDi4v
         a9FamGltdJU49VG68CBbbvqjTUHu+Zmcy95v1LJV2wLDRnKtltYqV/SfcKS+t4dVdD
         eVCpYHyIiVCgrTg0uU0UMpKjFFtIBY8snyFxnKU0csx7aCggyXBQ0qZWRG/7+qubZs
         msX+ticuyzpt/Zg91jNTMed7t6bpE2xHbXaq/QxTdzsrJ6k1zVo6GgswCyKUbjkdpy
         L1DekQFsISrwoQIihyDbiDhZ97n952vsTvpVZdhABE8NhlwD4b4VZv3Vvvnr0pK1cx
         ow0lLQ73iTfcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 996C45C0DEA; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH tip/core/rcu 10/19] rcu: Make RCU priority boosting work on single-CPU rcu_node structures
Date:   Tue, 11 May 2021 15:52:55 -0700
Message-Id: <20210511225304.2893154-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When any CPU comes online, it checks to see if an RCU-boost kthread has
already been created for that CPU's leaf rcu_node structure, and if
not, it creates one.  Unfortunately, it also verifies that this leaf
rcu_node structure actually has at least one online CPU, and if not,
it declines to create the kthread.  Although this behavior makes sense
during early boot, especially on systems that claim far more CPUs than
they actually have, it makes no sense for the first CPU to come online
for a given rcu_node structure.  There is no point in checking because
we know there is a CPU on its way in.

The problem is that timing differences can cause this incoming CPU to not
yet be reflected in the various bit masks even at rcutree_online_cpu()
time, and there is no chance at rcutree_prepare_cpu() time.  Plus it
would be better to create the RCU-boost kthread at rcutree_prepare_cpu()
to handle the case where the CPU is involved in an RCU priority inversion
very shortly after it comes online.

This commit therefore moves the checking to rcu_prepare_kthreads(), which
is called only at early boot, when the check is appropriate.  In addition,
it makes rcutree_prepare_cpu() invoke rcu_spawn_one_boost_kthread(), which
no longer does any checking for online CPUs.

With this change, RCU priority boosting tests now pass for short rcutorture
runs, even with single-CPU leaf rcu_node structures.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 29 +++++++----------------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2532e584e95f..00a3ebca70b8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4166,7 +4166,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	rcu_prepare_kthreads(cpu);
+	rcu_spawn_one_boost_kthread(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 5fd0c443517e..b5508f44ff29 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -418,8 +418,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(void);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static void __init rcu_spawn_boost_kthreads(void);
-static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
 static void rcu_prepare_for_idle(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ef004cc7101d..3c90dad00d3c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1198,22 +1198,16 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  */
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
-	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
+	int rnp_index = rnp - rcu_get_root();
 	struct sched_param sp;
 	struct task_struct *t;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
-		return;
-
-	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
+	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		return;
 
 	rcu_state.boost = 1;
 
-	if (rnp->boost_kthread_task != NULL)
-		return;
-
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
@@ -1265,17 +1259,8 @@ static void __init rcu_spawn_boost_kthreads(void)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp)
-		rcu_spawn_one_boost_kthread(rnp);
-}
-
-static void rcu_prepare_kthreads(int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;
-
-	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
-	if (rcu_scheduler_fully_active)
-		rcu_spawn_one_boost_kthread(rnp);
+		if (rcu_rnp_online_cpus(rnp))
+			rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
@@ -1295,15 +1280,15 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 {
 }
 
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static void __init rcu_spawn_boost_kthreads(void)
+static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 }
 
-static void rcu_prepare_kthreads(int cpu)
+static void __init rcu_spawn_boost_kthreads(void)
 {
 }
 
-- 
2.31.1.189.g2e36527f23

